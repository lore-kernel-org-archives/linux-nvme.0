From: hare@suse.de (Hannes Reinecke)
Date: Tue, 30 Apr 2019 08:05:45 +0200
Subject: [nvme-cli 0/9] Update tests for qemu
Message-ID: <20190430060554.24368-1-hare@suse.de>

Hi all,

here's an update to the nvme-cli test suite, to bring it more in
line with the spec and to allow it to run under qemu.
The first part fixes up various tests to check if the functionality
is implemented before running the test.
The second part is to make it to run under the quirky qemu NVMe
emulation, which chose not to implement some mandatory features
and log pages. But as this is qemu we sure can update the emulation,
but that won't help us for existing platforms.
So there really is no good way except for masking it out in the
tests.

As usual, comments and reviews are welcome

Hannes Reinecke (9):
  tests/nvme_writezeros_test.py: check if write zeroes is supported
  tests/nvme_writeuncor_test.py: check if write uncorrectable is
    supported
  tests/nvme_compare_test.py: check if compare is supported
  tests: ignore log tests for Qemu
  tests/nvme_text.py: add test for namespace management
  tests/nvme_attach_detach_ns_test.py: skip if namespace mgmt is not
    supported
  tests/nvme_create_max_ns_test.py: skip if namespace mgmt is not
    supported
  tests/nvme_get_features_test.py: skip features for Qemu
  tests/nvme_format_test.py: skip test if namespace management is not
    supported

 tests/nvme_attach_detach_ns_test.py |  13 ++--
 tests/nvme_compare_test.py          |   7 ++-
 tests/nvme_create_max_ns_test.py    |  10 ++-
 tests/nvme_error_log_test.py        |   3 +-
 tests/nvme_format_test.py           |  10 ++-
 tests/nvme_get_features_test.py     |   2 +
 tests/nvme_smart_log_test.py        |   5 +-
 tests/nvme_test.py                  | 119 ++++++++++++++++++++++++++++++++++++
 tests/nvme_writeuncor_test.py       |  11 ++--
 tests/nvme_writezeros_test.py       |  15 ++---
 10 files changed, 167 insertions(+), 28 deletions(-)

-- 
2.13.7
