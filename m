From: hch@lst.de (Christoph Hellwig)
Date: Fri, 10 Nov 2017 12:14:37 +0100
Subject: [PATCH 2/2] nvme: expose subsys attribute to sysfs
In-Reply-To: <1510307903-3346-3-git-send-email-hare@suse.de>
References: <1510307903-3346-1-git-send-email-hare@suse.de>
 <1510307903-3346-3-git-send-email-hare@suse.de>
Message-ID: <20171110111437.GB7837@lst.de>

On Fri, Nov 10, 2017@10:58:23AM +0100, Hannes Reinecke wrote:
> We should be exposing the subsystem attributes like 'model' and
> 'subsysnqn' to sysfs to allow for easier identification of the
> subsystem.

This looks fine except for an overlong line that I can easily fix up.
