From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Tue, 23 Feb 2016 19:11:52 +0200
Subject: [PATCH] NVMe: Fix 0-length integrity payload
In-Reply-To: <1456245373-17398-1-git-send-email-keith.busch@intel.com>
References: <1456245373-17398-1-git-send-email-keith.busch@intel.com>
Message-ID: <56CC92D8.4060204@dev.mellanox.co.il>


> A cheeky user could send a passthrough IO command with a metadata pointer,
> but on a namespace without metadata. With metadata length of 0, kmalloc
> returns ZERO_SIZE_PTR. Since that is not NULL, the driver would have
> set this as the bio's integrity payload, which causes an access fault
> on completion.
>
> This patch ignores the users metadata buffer if the namespace format
> does not support separate metadata. This is preferred over returning an
> invalid error to work with existing user space applications.

So having user-space get it wrong forever is preferable? Although I
assume that this is the equivalent of a strip operation which is
perfectly valid. The one difference is that strip validates the meta
data by definition...

If you want to be extra pedantic, you can verify that the meta-data is
still valid, but given that the data didn't travel the pci I don't know
if it makes real sense...

So all-in-all this looks fine,

Reviewed-by: Sagi Grimberg <sagig at mellanox.com>

CC'ing mkp
