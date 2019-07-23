From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Tue, 23 Jul 2019 23:42:32 +0900
Subject: [PATCH V3 0/3] lnvm: minor clean-ups
Message-ID: <20190723144235.12207-1-minwoo.im.dev@gmail.com>

Hi Keith,

This series has been reviewed by Matias and Javier.  Please consider
this series to be merged.  The Github PR can be found at:
	https://github.com/linux-nvme/nvme-cli/pull/527

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

Changes to V3:
  - Drop the last commit which is about the re-sync for the UAPI header
    file from the kernel because it does not have any actual using code.
    (Matias)
  - Added Reviewed-by tag from Javier. (Javier)

Changes to V2:
  - Resend the series with the latest patch commits.

Minwoo Im (3):
  lnvm: remove redundant whitespace in lnvm_init()
  lnvm: do not print 0 when the arg is not given
  lnvm: cast identity structure to (void *) directly

 nvme-lightnvm.c          | 5 ++---
 plugins/lnvm/lnvm-nvme.c | 8 ++++----
 2 files changed, 6 insertions(+), 7 deletions(-)

-- 
2.17.1
