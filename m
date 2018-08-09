From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu,  9 Aug 2018 11:25:21 +0200
Subject: [PATCH nvme-cli v2 0/2] fabrics connect-all fixes
Message-ID: <20180809092523.10225-1-jthumshirn@suse.de>

Two small fixes for fabrics commits of mine, which introduced options
but forgot to pass them down to the kernel.

Cahnges to v1:
* Add missing space between variable and '+' (Chaitanya)

Johannes Thumshirn (2):
  fabrics: write ctrl_loss_tmo to fabrics device on connect
  fabrics: write keep-alive-timeout to fabrics device on connect

 fabrics.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

-- 
2.16.4
