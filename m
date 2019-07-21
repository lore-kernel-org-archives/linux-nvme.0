From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Mon, 22 Jul 2019 00:32:15 +0900
Subject: [PATCH V2 0/4] lnvm: minor clean-ups
Message-ID: <20190721153219.5730-1-minwoo.im.dev@gmail.com>

Hi,

This series is nothing but a clean-up patch series.  I hope it's not a
just code churns, but a good start to do something for lnvm.

The first one removed a redundant whitespace in the command description.
The second one removed unnecessary print for the sizeof(dev) which will
always be zero in case user does not give any argument for the device.
The third patch removed temp variable instead casting the pinter
directly.  The last one just sync-up the kernel UAPI header file to the
latest.

Please review.

Thanks,

Changes to V2:
  - Resend the series with the latest patch commits.

Minwoo Im (4):
  lnvm: remove redundant whitespace in lnvm_init()
  lnvm: do not print 0 when the arg is not given
  lnvm: cast identity structure to (void *) directly
  lnvm: sync-up uapi lightnvm.h header from kernel

 linux/lightnvm.h         | 52 +++++++++++++++++++++++++++++++++++++++-
 nvme-lightnvm.c          |  7 +++---
 plugins/lnvm/lnvm-nvme.c |  8 +++----
 3 files changed, 58 insertions(+), 9 deletions(-)

-- 
2.17.1
