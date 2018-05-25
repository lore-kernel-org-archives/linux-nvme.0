From: hch@lst.de (Christoph Hellwig)
Date: Fri, 25 May 2018 15:05:35 +0200
Subject: [PATCH 0/3] Provide more fine grained control over multipathing
In-Reply-To: <20180525125322.15398-1-jthumshirn@suse.de>
References: <20180525125322.15398-1-jthumshirn@suse.de>
Message-ID: <20180525130535.GA24239@lst.de>

On Fri, May 25, 2018@02:53:19PM +0200, Johannes Thumshirn wrote:
> Hi,
> 
> This patch series aims to provide a more fine grained control over
> nvme's native multipathing, by allowing it to be switched on and off
> on a per-subsystem basis instead of a big global switch.

No.  The only reason we even allowed to turn multipathing off is
because you complained about installer issues.  The path forward
clearly is native multipathing and there will be no additional support
for the use cases of not using it.
