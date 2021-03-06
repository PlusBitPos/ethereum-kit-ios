import EthereumKit
import HsToolKit

class Configuration {
    static let shared = Configuration()

    let syncMode: SyncMode = .api
    let networkType: NetworkType = .ropsten
    let minLogLevel: Logger.Level = .error
    let defaultsWords = ""

    let infuraCredentials: (id: String, secret: String?) = (id: "2a1306f1d12f4c109a4d4fb9be46b02e", secret: "fc479a9290b64a84a15fa6544a130218")
    let etherscanApiKey = "GKNHXT22ED7PRVCKZATFZQD1YI7FK9AAYE"

    var erc20Tokens: [Erc20Token] {
        switch networkType {
        case .mainNet: return [
            Erc20Token(name: "DAI",       coin: "DAI",  contractAddress: try! Address(hex: "0x6b175474e89094c44da98b954eedeac495271d0f"), decimal: 18),
            Erc20Token(name: "USD Coin",  coin: "USDC", contractAddress: try! Address(hex: "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48"), decimal: 6),
        ]
        case .ropsten: return [
            Erc20Token(name: "GMO coins", coin: "GMOLW", contractAddress: try! Address(hex: "0xbb74a24d83470f64d5f0c01688fbb49a5a251b32"), decimal: 18),
            Erc20Token(name: "DAI",       coin: "DAI",   contractAddress: try! Address(hex: "0xad6d458402f60fd3bd25163575031acdce07538d"), decimal: 18),
            Erc20Token(name: "MMM",       coin: "MMM",   contractAddress: try! Address(hex: "0x3e500c5f4de2738f65c90c6cc93b173792127481"), decimal: 8),
            Erc20Token(name: "WEENUS",    coin: "WEENUS", contractAddress: try! Address(hex: "0x101848D5C5bBca18E6b4431eEdF6B95E9ADF82FA"), decimal: 18),
        ]
        case .kovan: return []
        }
    }

}

struct Erc20Token {
    let name: String
    let coin: String
    let contractAddress: Address
    let decimal: Int
}

extension Configuration {

    enum SyncMode {
        case api
        case spv
        case geth
    }

}
