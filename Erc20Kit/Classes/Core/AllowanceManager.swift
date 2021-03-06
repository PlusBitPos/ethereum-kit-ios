import RxSwift
import BigInt
import EthereumKit
import OpenSslKit

enum AllowanceParsingError: Error {
    case notFound
}

class AllowanceManager {
    private let disposeBag = DisposeBag()

    private let ethereumKit: EthereumKit.Kit
    private let storage: ITransactionStorage
    private let contractAddress: Address
    private let address: Address

    init(ethereumKit: EthereumKit.Kit, storage: ITransactionStorage, contractAddress: Address, address: Address) {
        self.ethereumKit = ethereumKit
        self.storage = storage
        self.contractAddress = contractAddress
        self.address = address
    }

    func allowanceSingle(spenderAddress: Address) -> Single<BigUInt> {
        let data = AllowanceMethod(owner: address, spender: spenderAddress).encodedABI()

        return ethereumKit.call(contractAddress: contractAddress, data: data)
                .map { data in
                    BigUInt(data[0...31])
                }
    }

    func approveTransactionData(spenderAddress: Address, amount: BigUInt) -> TransactionData {
        TransactionData(
                to: contractAddress,
                value: BigUInt.zero,
                input: ApproveMethod(spender: spenderAddress, value: amount).encodedABI()
        )
    }

}
