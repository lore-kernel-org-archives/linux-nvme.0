From: andrew.maier@eideticom.com (Andrew Maier)
Date: Wed, 9 May 2018 00:12:52 +0000
Subject: [PATCH V2 0/6] nvmet: implement target passthru commands support -
 tested with v4.17.0-rc3
Message-ID: <BN6PR19MB10921DECF8FB253ADA6DB1FC93990@BN6PR19MB1092.namprd19.prod.outlook.com>

Hi,

I tested Chaitanya's patches with tag v4.17.0-rc3 in our lab setup and they are working.  I like the new interface approach with having attr_ctrl_path as "/dev/nvme0" (for example) instead of the "nvme0" from V1 of the patches as it matches the normal subsystem method now.

Regards,
Andrew Maier
Software Engineer
Eideticom.com
