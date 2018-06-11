From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 11 Jun 2018 05:15:40 -0400
Subject: [PATCH V2 00/14] blktests: NVMeOF new testcases for file and bdev ns
Message-ID: <20180611091554.19639-1-chaitanya.kulkarni@wdc.com>

Hi,

This patch series restructures the target side namespace creation code and 
adds new testcases for NVMeOF loop target (nvme_loop). Also, we add one 
fio helper for basic data verification, new testcases like basic
creation/deletion of the host/target, fio based data verification testcases
for both block device and file backed target namespace and file system
formatting and data verification from the host side.

-Regards,
Chaitanya

Changes Since V1:-

1. Add fio data verification helper.
2. Add a new test for many namespaces creation for file-backed ns.
3. Minor fixes and cleanups.

Chaitanya Kulkarni (14):
  blktests: common/nvme export ns-mgmt interfaces
  blktests: add NVMeOF bdev-ns target creation test
  blktests: add NVMeOF file-ns target creation test
  blktests: add NVMeOF bdev-ns host creation
  blktests: add NVMeOF file-ns host creation
  blktests: add fio data verification routine
  blktests: add NVMeoF data verification test for bdev-ns
  blktests: add NVMeOF data verification test for file-ns
  blktests: add NVMeOF mkfs test for bdev-ns
  blktests: add NVMeOF mkfs test for file-ns
  blktests: add NVMeOF flush test for bdev-ns
  blktests: add NVMeOF flush test for file-ns
  blktests: add NVMeOF many bdev-ns creation test
  blktests: add NVMeOF many file-ns creation test

 common/fio         | 12 +++++++
 common/nvme        | 46 +++++++++++++++++-------
 tests/nvme/006     | 62 ++++++++++++++++++++++++++++++++
 tests/nvme/006.out |  2 ++
 tests/nvme/007     | 60 +++++++++++++++++++++++++++++++
 tests/nvme/007.out |  2 ++
 tests/nvme/008     | 72 +++++++++++++++++++++++++++++++++++++
 tests/nvme/008.out |  5 +++
 tests/nvme/009     | 66 ++++++++++++++++++++++++++++++++++
 tests/nvme/009.out |  5 +++
 tests/nvme/010     | 76 +++++++++++++++++++++++++++++++++++++++
 tests/nvme/010.out |  5 +++
 tests/nvme/011     | 71 +++++++++++++++++++++++++++++++++++++
 tests/nvme/011.out |  5 +++
 tests/nvme/012     | 88 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/012.out |  5 +++
 tests/nvme/013     | 84 +++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/013.out |  5 +++
 tests/nvme/014     | 76 +++++++++++++++++++++++++++++++++++++++
 tests/nvme/014.out |  6 ++++
 tests/nvme/015     | 68 +++++++++++++++++++++++++++++++++++
 tests/nvme/015.out |  6 ++++
 tests/nvme/016     | 64 +++++++++++++++++++++++++++++++++
 tests/nvme/016.out | 13 +++++++
 tests/nvme/017     | 70 ++++++++++++++++++++++++++++++++++++
 tests/nvme/017.out | 13 +++++++
 26 files changed, 974 insertions(+), 13 deletions(-)
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
 create mode 100755 tests/nvme/014.out
 create mode 100755 tests/nvme/015
 create mode 100755 tests/nvme/015.out
 create mode 100755 tests/nvme/016
 create mode 100644 tests/nvme/016.out
 create mode 100755 tests/nvme/017
 create mode 100644 tests/nvme/017.out

-- 
2.17.0
