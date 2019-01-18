From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri, 18 Jan 2019 08:17:09 +0100
Subject: [PATCH blktests 1/2] nvme: enable buffered_io for file-backed
 namespaces
In-Reply-To: <BYAPR04MB45024AB8410374A9B1AD81A186830@BYAPR04MB4502.namprd04.prod.outlook.com>
References: <20190117125906.15479-1-jthumshirn@suse.de>
 <BYAPR04MB45024AB8410374A9B1AD81A186830@BYAPR04MB4502.namprd04.prod.outlook.com>
Message-ID: <20beebf9-f582-08b3-1905-8a246f12268e@suse.de>

On 18/01/2019 00:46, Chaitanya Kulkarni wrote:
> This will force the user to run all tests in the buffered_io mode.
> 
> What we really need is a config for the nvme category option which user can set and decide
> whether to run buffered_io or direct_io, you can set by default to the buffered_io mode.

We could also introduce a check if we can use direct IO on the
underlying FS, but the only way I can think of from a shell script is
doing a 'dd of=$TMPDIR/testfile oflag=direct' and then populate the
result to the helper functions.

Chaitanya, Omar any ideas?

-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
