From: hch@lst.de (Christoph Hellwig)
Date: Thu, 21 Sep 2017 16:10:33 +0200
Subject: [PATCH] nvme: make controller 'state' sysfs attribute pollable
In-Reply-To: <20170921051915.cfj2j5vu4bjqn5za@linux-x5ow.site>
References: <20170920104032.14014-1-jthumshirn@suse.de>
 <20170920145931.GA5208@lst.de>
 <20170921051915.cfj2j5vu4bjqn5za@linux-x5ow.site>
Message-ID: <20170921141033.GA17575@lst.de>

On Thu, Sep 21, 2017@07:19:15AM +0200, Johannes Thumshirn wrote:
> So why exposing it then in the first time?

It is a really nice debug aid, but the states really are an internal
detail of the implementation, and can (and probably will soon, see the
fc states discussion) change.

Maybe we need to move things like this to debugfs, but yet another
interface seems a little annoying.
