From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 17 Apr 2015 10:46:30 -0700
Subject: [PATCH 1/5 v2] blk-mq: Add prep/unprep support
In-Reply-To: <5530C132.30107@bjorling.me>
References: <1429101284-19490-1-git-send-email-m@bjorling.me>
 <1429101284-19490-2-git-send-email-m@bjorling.me>
 <20150417063439.GB389@infradead.org> <5530C132.30107@bjorling.me>
Message-ID: <20150417174630.GA10249@infradead.org>

On Fri, Apr 17, 2015@10:15:46AM +0200, Matias Bj?rling wrote:
> Just the prep/unprep, or other pieces as well?

All of it - it's functionality that lies logically below the block
layer, so that's where it should be handled.

In fact it should probably work similar to the mtd subsystem - that is
have it's own API for low level drivers, and just export a block driver
as one consumer on the top side.

> In the future, applications can have an API to get/put flash block directly.
> (using the blk_nvm_[get/put]_blk interface).

s/application/filesystem/?
