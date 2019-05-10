From: kbusch@kernel.org (Keith Busch)
Date: Fri, 10 May 2019 15:42:56 -0600
Subject: [PATCH 0/3] nvme-core: add user command filter
In-Reply-To: <20190508183634.4682-1-chaitanya.kulkarni@wdc.com>
References: <20190508183634.4682-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20190510214255.GA11723@localhost.localdomain>

On Wed, May 08, 2019@11:36:31AM -0700, Chaitanya Kulkarni wrote:
> This patch-series adds a filter to allow only certain user commands.                                   
> Right now we use this infrastructure to prevent the user get log page
> commands where RAE bit is cleared. We only allow get log pages to be
> read with RAE == 0 where we issue the uevent to the userspace so that
> user can clear the log pages.
> 
> Here we white list the log pages which are only allowed when RAE == 0.
> We also allow Vendor Specific log pages irrespective of the RAE.

I'm generally against the passthrough interface examining commands. It
is not for the driver to decide what an admin can't send to their devices.
