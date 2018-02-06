From: Berck.Nash@wdc.com (Berck Nash)
Date: Tue, 6 Feb 2018 22:04:08 +0000
Subject: NVMEoF oops on reset
Message-ID: <CO2PR04MB21987F3848378AB2A7BA21B582FD0@CO2PR04MB2198.namprd04.prod.outlook.com>

We're experiencing an oops whenever we issue an "nvme reset" via the 
nvme cli on fabric setups.  Appears to be in the nvme_rdma code.  The 
problem occurs on mainline 4.15, as well as on 4.16-nvme (commit 
ca5554a696dce37852f6d6721520b4f13fc295c3).

We can reproduce this simply by discovering, connecting, then issuing a 
reset.

Please see attached logs for both 4.15 as well as 4.16-nvme.

Let us know what else we can provide.

Berck Nash
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: nvme_reset_oops_nvme-4.16.txt
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20180206/4738ec3f/attachment-0002.txt>
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: nvme_reset_oops-4.15.txt
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20180206/4738ec3f/attachment-0003.txt>
