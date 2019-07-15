From: hch@lst.de (Christoph Hellwig)
Date: Mon, 15 Jul 2019 14:29:53 +0200
Subject: [PATCH] nvme: Add support for Apple 2018+ models
In-Reply-To: <4caeb954b2fa91445e02bac7ac9610ca886b4dd8.camel@redhat.com>
References: <71b009057582cd9c82cff2b45bc1af846408bcf7.camel@kernel.crashing.org>
 <20190715081041.GB31791@lst.de>
 <c088cb27f99adbcc1f8faf8e86167903f11593b8.camel@kernel.crashing.org>
 <25c3813ab1c2943658d7e79756803801b14a34db.camel@kernel.crashing.org>
 <4caeb954b2fa91445e02bac7ac9610ca886b4dd8.camel@redhat.com>
Message-ID: <20190715122953.GB3937@lst.de>

On Mon, Jul 15, 2019@12:28:05PM +0300, Maxim Levitsky wrote:
> 
> To be honest, the spec explicitly states that minimum submission queue entry size is 64 
> and minimum completion entry size should be is 16 bytes for NVM command set:

That doesn't keep Apple from implementing whatever they want and soldering
that down on their MacBook mainboards unfortunately :(
