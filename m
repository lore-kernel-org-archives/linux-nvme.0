From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 16 Oct 2017 09:21:45 +0200
Subject: [PATCH] nvmet: protect sqhd update by a lock
In-Reply-To: <20171013203800.24125-1-jsmart2021@gmail.com>
References: <20171013203800.24125-1-jsmart2021@gmail.com>
Message-ID: <20171016072145.wyrp2fyw2cx2grpf@linux-x5ow.site>

To me it looks a bit awkward why you're only protecting the RMW part but not
the re-read below.

Could you please give some explanation why this is not needed?

Thanks,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
