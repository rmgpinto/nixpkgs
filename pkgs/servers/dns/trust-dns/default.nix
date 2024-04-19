{ lib
, fetchFromGitHub
, openssl
, pkg-config
, rustPlatform
}:

rustPlatform.buildRustPackage rec {
  pname = "trust-dns";
  version = "0.24.1";

  src = fetchFromGitHub {
    owner = "hickory-dns";
    repo = "hickory-dns";
    rev = "v${version}";
    hash = "sha256-+vZnozPsORe7nK6jL/yt/wp2qjwBTqyxZYz+cXaKNFk=";
  };
  cargoHash = "sha256-VLpl6eMOstD0FsuPeHngKQitv1jcb+0dx2pc8ic3Cf4=";

  buildInputs = [ openssl ];
  nativeBuildInputs = [ pkg-config ];

  # tests expect internet connectivity to query real nameservers like 8.8.8.8
  doCheck = false;

  meta = with lib; {
    description = "A Rust based DNS client, server, and resolver";
    homepage = "https://trust-dns.org/";
    maintainers = with maintainers; [ colinsane ];
    platforms = platforms.linux;
    license = with licenses; [ asl20 mit ];
    mainProgram = "hickory-dns";
  };
}
