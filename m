From: Alexander.Levin@microsoft.com (Sasha Levin)
Date: Thu, 5 Apr 2018 01:34:28 +0000
Subject: [PATCH v2] nvmet: fix nvmet_execute_write_zeroes function
In-Reply-To: <1522680581-10220-1-git-send-email-rosattig@linux.vnet.ibm.com>
References: <1522680581-10220-1-git-send-email-rosattig@linux.vnet.ibm.com>
Message-ID: <DM5PR2101MB1032170718BCAF7FB1BD0B98FBBB0@DM5PR2101MB1032.namprd21.prod.outlook.com>

Hi "Rodrigo R. Galvao".

[This is an automated email]

This commit has been processed by the -stable helper bot and determined
to be a high probability candidate for -stable trees. (score: 6.9916)

The bot has tested the following trees: v4.15.15, v4.14.32, v4.9.92, v4.4.126, 

v4.15.15: Build OK!
v4.14.32: Build OK!
v4.9.92: Failed to apply! Possible dependencies:
    d262920998c8: ("nvmet: add support for the Write Zeroes command")
    78ce3daa7d70: ("nvmet: fix byte swap in nvmet_execute_write_zeroes")
    d262920998c8: ("nvmet: add support for the Write Zeroes command")

v4.4.126: Failed to apply! Possible dependencies:
    d262920998c8: ("nvmet: add support for the Write Zeroes command")
    a07b4970f464: ("nvmet: add a generic NVMe target")
    78ce3daa7d70: ("nvmet: fix byte swap in nvmet_execute_write_zeroes")
    d262920998c8: ("nvmet: add support for the Write Zeroes command")
    a07b4970f464: ("nvmet: add a generic NVMe target")


Please let us know if you'd like to have this patch included in a stable tree.

--
Thanks.
Sasha
