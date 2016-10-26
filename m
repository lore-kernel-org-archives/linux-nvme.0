From: keith.busch@intel.com (Keith Busch)
Date: Wed, 26 Oct 2016 15:24:30 -0400
Subject: [NVME-CLI] NVMe Format Issues - HGST Drives
In-Reply-To: <BY2PR0201MB19110EA4851BB1DD37FDC13D8FAB0@BY2PR0201MB1911.namprd02.prod.outlook.com>
References: <BY2PR0201MB19119DF43362BC07D9F7D9E38FA90@BY2PR0201MB1911.namprd02.prod.outlook.com>
 <20161025124121.GB27453@infradead.org>
 <BY2PR0201MB19110EA4851BB1DD37FDC13D8FAB0@BY2PR0201MB1911.namprd02.prod.outlook.com>
Message-ID: <20161026192430.GA1570@localhost.localdomain>

On Wed, Oct 26, 2016@05:05:05PM +0000, Zeta Syanthis wrote:
> I tried -t 3600 for an hour, but it hung the couple of systems I tried it  on. What exactly does that timeout do? And is it not in seconds?

It's in milliseconds. The default when not set uses the kernel's
default, which is 60 seconds, or 60000 milliseconds.
