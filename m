From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Tue,  5 Jun 2018 20:51:58 -0400
Subject: [PATCH 00/10] blktests: NVMeOF new testcases for file and bdev ns
Message-ID: <20180606005210.4197-1-chaitanya.kulkarni@wdc.com>

Hi,

This patch series resrtcures the target side namespace creation code and
adds new testcases for NVMeOF loop target (nvme_loop). We add different
testcases like basic creation/deletion of the host/target, fio based data
verification and exercising mkfs from the host side.

-Regards,
Chaitanya

Chaitanya Kulkarni (12):
  blktests: common/nvme export ns-mgmt interfaces
  blktests: add NVMeOF many bdev-ns creation test
  blktests: add NVMeOF bdev-ns target creation test
  blktests: add NVMeOF file-ns target creation test
  blktests: add NVMeOF bdev-ns host creation
  blktests: add NVMeOF file-ns host creation
  blktests: add NVMeoF data verification test for bdev-ns
  blktests: add NVMeOF data verification test for file-ns
  blktests: add NVMeOF mkfs test for bdev-ns
  blktests: add NVMeOF mkfs test for file-ns
  blktests: add NVMeOF flush test for bdev-ns
  blktests: add NVMeOF flush test for file-ns

 common/nvme           |   46 +-
 tests/nvme/006        |   65 +
 tests/nvme/006.out    | 5021 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/007        |   62 +
 tests/nvme/007.out    |    2 +
 tests/nvme/008        |   59 +
 tests/nvme/008.out    |    2 +
 tests/nvme/009        |   69 +
 tests/nvme/009.out    |    5 +
 tests/nvme/010        |   64 +
 tests/nvme/010.out    |    5 +
 tests/nvme/011        |   80 +
 tests/nvme/011.out    |    5 +
 tests/nvme/012        |   75 +
 tests/nvme/012.out    |    5 +
 tests/nvme/013        |   93 +
 tests/nvme/013.out    |    5 +
 tests/nvme/014        |   88 +
 tests/nvme/014.out    |    5 +
 tests/nvme/015        |   73 +
 tests/nvme/015.out    |    6 +
 tests/nvme/016        |   68 +
 tests/nvme/016.out    |    6 +
 tests/nvme/verify.fio |    9 +
 24 files changed, 5905 insertions(+), 13 deletions(-)
 create mode 100755 tests/nvme/006
 create mode 100644 tests/nvme/006.out
 create mode 100755 tests/nvme/007
 create mode 100644 tests/nvme/007.out
 create mode 100755 tests/nvme/008
 create mode 100644 tests/nvme/008.out
 create mode 100755 tests/nvme/009
 create mode 100644 tests/nvme/009.out
 create mode 100755 tests/nvme/010
 create mode 100644 tests/nvme/010.out
 create mode 100755 tests/nvme/011
 create mode 100644 tests/nvme/011.out
 create mode 100755 tests/nvme/012
 create mode 100644 tests/nvme/012.out
 create mode 100755 tests/nvme/013
 create mode 100644 tests/nvme/013.out
 create mode 100755 tests/nvme/014
 create mode 100644 tests/nvme/014.out
 create mode 100755 tests/nvme/015
 create mode 100755 tests/nvme/015.out
 create mode 100755 tests/nvme/016
 create mode 100755 tests/nvme/016.out
 create mode 100644 tests/nvme/verify.fio

-- 
2.9.5
