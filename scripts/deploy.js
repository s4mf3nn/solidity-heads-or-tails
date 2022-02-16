async function main() {
  const Contract = await ethers.getContractFactory("HeadsTails");
  const contract = await Contract.deploy();

  console.log("My Contract deployed to:", contract.address);
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });