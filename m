From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 27 Aug 2018 15:55:36 -0700
Subject: [PATCH 0/6] blktests: new testcases for NVMeOF
Message-ID: <20180827225542.4329-1-chaitanya.kulkarni@wdc.com>

Hi,

This adds new testcases for Dataset Management, write-zeroes and
smart-log for block device and file backed namespace when NVMeOF
target is configured with loop mode (nvme-loop.ko).

Please note that I'm leaving out "018" for Hannes's ANA realted testcase :-
http://lists.infradead.org/pipermail/linux-nvme/2018-August/019553.html.

Regards,
Chaitanya

Chaitanya Kulkarni (6):
  blktests: add NVMeOF DSM discard test for bdev-ns
  blktests: add NVMeOF DSM discard test for file-ns
  blktests: add NVMeOF write-zeroes test for bdev-ns
  blktests: add NVMeOF write-zeroes test for file-ns
  blktests: add NVMeOF smart-log test for bdev-ns
  blktests: add NVMeOF smart-log test for file-ns

 tests/nvme/019     | 78 +++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/019.out |  6 ++++
 tests/nvme/020     | 72 ++++++++++++++++++++++++++++++++++++++++
 tests/nvme/020.out |  6 ++++
 tests/nvme/021     | 78 +++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/021.out |  6 ++++
 tests/nvme/022     | 72 ++++++++++++++++++++++++++++++++++++++++
 tests/nvme/022.out |  6 ++++
 tests/nvme/023     | 82 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/023.out |  5 +++
 tests/nvme/024     | 80 ++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/024.out |  5 +++
 12 files changed, 496 insertions(+)
 create mode 100755 tests/nvme/019
 create mode 100644 tests/nvme/019.out
 create mode 100755 tests/nvme/020
 create mode 100644 tests/nvme/020.out
 create mode 100755 tests/nvme/021
 create mode 100644 tests/nvme/021.out
 create mode 100755 tests/nvme/022
 create mode 100644 tests/nvme/022.out
 create mode 100755 tests/nvme/023
 create mode 100644 tests/nvme/023.out
 create mode 100755 tests/nvme/024
 create mode 100644 tests/nvme/024.out

-- 
2.17.0
