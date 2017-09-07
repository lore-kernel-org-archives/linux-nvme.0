From: hch@lst.de (Christoph Hellwig)
Date: Thu, 7 Sep 2017 14:01:28 +0200
Subject: [PATCH] nvme: fix lightnvm check
In-Reply-To: <20170906150604.GD17331@localhost.localdomain>
References: <20170906094825.8845-1-hch@lst.de>
 <20170906150604.GD17331@localhost.localdomain>
Message-ID: <20170907120128.GB18794@lst.de>

On Wed, Sep 06, 2017@11:06:04AM -0400, Keith Busch wrote:
> Ugh, even with this quirk, new lightnvm device will be broken for
> all existing kernels. This sort of thing really could benefit from a
> standard's defined capability or command set supported bit to distinguish
> lightnvm devices. Lacking that, this looks like the only thing we can
> do at the moment.

I told them to register a different class code for these devices a long
time ago, but nothing happened.  Then again I might underestimate the
complexity of getting a class code..
