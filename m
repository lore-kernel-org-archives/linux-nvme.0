From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 28 Jun 2018 09:48:24 +0200
Subject: [PATCH v5 2/2] nvme: trace: add disk name to tracepoints
In-Reply-To: <20180627163706.GA9361@localhost.localdomain>
References: <20180627125324.22064-1-jthumshirn@suse.de>
 <20180627125324.22064-3-jthumshirn@suse.de>
 <20180627163706.GA9361@localhost.localdomain>
Message-ID: <20180628074824.crqwgdlnrqt34s3d@linux-x5ow.site>

On Wed, Jun 27, 2018@10:37:06AM -0600, Keith Busch wrote:
> It looks like you want the # assigned to /dev/nvme<#>. Do you want to
> use ctrl->instance here instead?

Right.

As it'll conflict with your other trace patch do you want me to wait
with the resend?

     Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
