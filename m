From: hch@lst.de (Christoph Hellwig)
Date: Mon, 13 Mar 2017 17:33:38 +0100
Subject: [RFC PATCH] nvmet: Back namespace with files
In-Reply-To: <20170313161128.GD6994@localhost.localdomain>
References: <1489008937-31043-1-git-send-email-keith.busch@intel.com>
 <20170308213519.GA32009@lst.de> <20170308221527.GA1885@localhost.localdomain>
 <20170308222014.GA635@lst.de> <20170309174120.GA14329@localhost.localdomain>
 <d6291643-c644-5790-4311-3a159d5eecc9@grimberg.me>
 <20170313161128.GD6994@localhost.localdomain>
Message-ID: <20170313163338.GA3324@lst.de>

On Mon, Mar 13, 2017@12:11:28PM -0400, Keith Busch wrote:
> Yes, the RFC was light on details, and I'm probably getting ahead of
> myself with the file-as-a-namespaces suggestion.

No, it's a good idea.  The big question is what we win with explicit
support in nvmet over just using the loop device.  I actually hacked
up support earlier and it didn't show any performance advantage.
That being said we now have the ITER_BVEC type and proper support
for in-kernel aio, so the code might become simple enough to just take
it.
