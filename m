From: keith.busch@intel.com (Keith Busch)
Date: Tue, 23 Feb 2016 17:32:31 +0000
Subject: [PATCH] NVMe: Fix 0-length integrity payload
In-Reply-To: <56CC92D8.4060204@dev.mellanox.co.il>
References: <1456245373-17398-1-git-send-email-keith.busch@intel.com>
 <56CC92D8.4060204@dev.mellanox.co.il>
Message-ID: <20160223173231.GC21865@localhost.localdomain>

On Tue, Feb 23, 2016@07:11:52PM +0200, Sagi Grimberg wrote:
> 
> >A cheeky user could send a passthrough IO command with a metadata pointer,
> >but on a namespace without metadata. With metadata length of 0, kmalloc
> >returns ZERO_SIZE_PTR. Since that is not NULL, the driver would have
> >set this as the bio's integrity payload, which causes an access fault
> >on completion.
> >
> >This patch ignores the users metadata buffer if the namespace format
> >does not support separate metadata. This is preferred over returning an
> >invalid error to work with existing user space applications.
> 
> So having user-space get it wrong forever is preferable? Although I
> assume that this is the equivalent of a strip operation which is
> perfectly valid. The one difference is that strip validates the meta
> data by definition...

Yeah, some have had it wrong for years, but it worked from their
perspective. Now it crashes the machine, so this just reinstates the
previously established behavior. That seemed better than forcing users to
fix their apps. They don't like "fixing" in reaction to kernel changes.
Though I'd argue their command was nonsense in the first place, and
probably doesn't do what they think they're doing.
