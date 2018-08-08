From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed,  8 Aug 2018 09:10:30 +0200
Subject: [PATCH nvme-cli 0/2] fabrics connect-all fixes
Message-ID: <20180808071032.5914-1-jthumshirn@suse.de>

Two small fixes for fabrics commits of mine, which introduced options
but forgot to pass them down to the kernel.

Johannes Thumshirn (2):
  fabrics: write ctrl_loss_tmo to fabrics device on connect
  fabrics: write keep-alive-timeout to fabrics device on connect

 fabrics.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

-- 
2.16.4
