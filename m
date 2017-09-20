From: hch@lst.de (Christoph Hellwig)
Date: Wed, 20 Sep 2017 16:59:31 +0200
Subject: [PATCH] nvme: make controller 'state' sysfs attribute pollable
In-Reply-To: <20170920104032.14014-1-jthumshirn@suse.de>
References: <20170920104032.14014-1-jthumshirn@suse.de>
Message-ID: <20170920145931.GA5208@lst.de>

On Wed, Sep 20, 2017@12:40:32PM +0200, Johannes Thumshirn wrote:
> Notify sysfs about changes of a nvme controller so user-space can watch the
> file via poll() or select() in order to react to a state change.

Userspace has no business polling for the state.
