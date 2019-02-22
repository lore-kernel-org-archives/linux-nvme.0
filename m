From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri, 22 Feb 2019 06:55:00 +0100
Subject: [PATCH] nvmet: disable direct I/O when unavailable
In-Reply-To: <SN6PR04MB4527A810D247541AA7C4A512867F0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190221182234.22345-1-jthumshirn@suse.de>
 <SN6PR04MB4527A810D247541AA7C4A512867F0@SN6PR04MB4527.namprd04.prod.outlook.com>
Message-ID: <6c3fa30a-d516-a453-a001-1014202ff9ce@suse.de>

On 22/02/2019 01:41, Chaitanya Kulkarni wrote:
[...]
> 
> As per specified in the patch, this is only useful for testing, then we 
> should modify the test scripts so that on creation of the ctrl we switch 
> to the buffered I/O before running fio.

Or on any other file-system that does not support DIO..

> 
> OR
> 
> Similar result can be achieved by setting buffered I/O flag
> buffered_io=1 before enabling the name-space in the test script.

Frankly, we have a ton of testing related special cases in the kernel.

This one is a) simple and small, only 10 LoC, b) far away from the fast
path or any other place where it could have any impact on legitimate
users and c) it prints an informal message showing you what happened.

Sorry but this is a https://xkcd.com/386/ moment.

Byte,
	Johannes
-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
