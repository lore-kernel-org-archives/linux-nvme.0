From: Zeta_Syanthis@Jabil.com (Zeta Syanthis)
Date: Wed, 26 Oct 2016 17:05:05 +0000
Subject: [NVME-CLI] NVMe Format Issues - HGST Drives
In-Reply-To: <20161025124121.GB27453@infradead.org>
References: <BY2PR0201MB19119DF43362BC07D9F7D9E38FA90@BY2PR0201MB1911.namprd02.prod.outlook.com>,
 <20161025124121.GB27453@infradead.org>
Message-ID: <BY2PR0201MB19110EA4851BB1DD37FDC13D8FAB0@BY2PR0201MB1911.namprd02.prod.outlook.com>

I tried -t 3600 for an hour, but it hung the couple of systems I tried it  on. What exactly does that timeout do? And is it not in seconds?

Thank you,

Zeta Mercy Syanthis
Software Test Engineer
StackVelocity  

From: Christoph Hellwig <hch@infradead.org>
Sent: Tuesday, October 25, 2016 5:41 AM
To: Zeta Syanthis
Cc: linux-nvme at lists.infradead.org
Subject: Re: [NVME-CLI] NVMe Format Issues - HGST Drives
?   
Hi Zeta,

a format will probably require a longer timeout than the default 60
seconds, try specfing ? --timeout argument with a longer timeout on the
nvme-cli command line.
