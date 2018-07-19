From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 19 Jul 2018 16:54:22 +0200
Subject: [PATCH 0/4] Rework NVMe abort handling
In-Reply-To: <20180719145005.GA21000@lst.de>
References: <20180719132838.15556-1-jthumshirn@suse.de>
 <20180719134203.GA15212@lst.de>
 <20180719141025.yveza2svhvc2r4lw@linux-x5ow.site>
 <20180719142355.GA18800@lst.de>
 <20180719143534.i36vo45lhz24xbrg@linux-x5ow.site>
 <20180719145005.GA21000@lst.de>
Message-ID: <20180719145422.2tdrbwa34gheuam3@linux-x5ow.site>

On Thu, Jul 19, 2018@04:50:05PM +0200, Christoph Hellwig wrote:
> The upper layer is only going to retry after tearing down the transport
> connection.  And a tear down of the connection MUST clear all pending
> commands on the way.  If it doesn't we are in deep, deep trouble.
> 
> A NVMe abort has no chance of clearing things at the transport layer.

OK so all I can do in my case (if I want soft error recovery) is send
out a transport abort in the timeout handler and then rearm the timer
and requeue the command.

Which leaves us to the FC patch only, modified of cause.

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
