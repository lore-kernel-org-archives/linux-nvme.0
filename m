From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 7 May 2019 08:20:34 +0200
Subject: [PATCH 1/3] nvme: 002: fix nvmet pass data with loop
In-Reply-To: <cfa4d48d-ce13-0ace-cf5c-a3d0d1f4cca7@gmail.com>
References: <20190505150611.15776-1-minwoo.im.dev@gmail.com>
 <20190505150611.15776-2-minwoo.im.dev@gmail.com>
 <SN6PR04MB45274C423AA7C3CC3DBB5ED586300@SN6PR04MB4527.namprd04.prod.outlook.com>
 <a66b775f-9a5f-fefc-ae29-c86678e66463@gmail.com>
 <SN6PR04MB45272BEB18B3ADD95DCB42AE86300@SN6PR04MB4527.namprd04.prod.outlook.com>
 <cfa4d48d-ce13-0ace-cf5c-a3d0d1f4cca7@gmail.com>
Message-ID: <20190507062034.GA3748@x250>

On Tue, May 07, 2019@01:54:09AM +0900, Minwoo Im wrote:
> If Johannes who wrote these tests agrees to not check output result from
> nvme-cli, I'll get rid of them.

Yes agreed. In the beginning I though of validating the nvme-cli output but
this would grow more and more filters, which makes it impractical.

-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
