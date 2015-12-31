From: keith.busch@intel.com (Keith Busch)
Date: Thu, 31 Dec 2015 18:40:20 +0000
Subject: [PATCHv2 0/5] NVMe fixes and updates, version 2
In-Reply-To: <5685761D.2070704@dev.mellanox.co.il>
References: <1451580116-12252-1-git-send-email-keith.busch@intel.com>
 <5685761D.2070704@dev.mellanox.co.il>
Message-ID: <20151231184019.GB16806@localhost.localdomain>

On Thu, Dec 31, 2015@08:38:21PM +0200, Sagi Grimberg wrote:
> >Keith Busch (5):
> >   NVMe: Fix admin queue ring wrap
> >   NVMe: Use a retryable error code on reset
> >   NVMe: Remove queue freezing on resets
> 
> Any particular reason for not rebasing on top of my patch and
> Christoph's "namespace list locking and ioctl fixes V2"?

I'm building off Jens' tree. I'm happy to rebase on Christoph's.
