From: greg@kroah.com (Greg KH)
Date: Tue, 27 Jun 2017 13:29:34 +0200
Subject: [PATCH 0/2] nvme/quirk: backport to v4.4 stable for
 PCI_DEVICE(0x1c58, 0x0003)
In-Reply-To: <1498068203-29900-1-git-send-email-mauricfo@linux.vnet.ibm.com>
References: <1498068203-29900-1-git-send-email-mauricfo@linux.vnet.ibm.com>
Message-ID: <20170627112934.GG10609@kroah.com>

On Wed, Jun 21, 2017@03:03:21PM -0300, Mauricio Faria de Oliveira wrote:
> Hi Christoph, Jens, and Greg.
> 
> Would you ack these 2 backports to be applied to v4.4 stable?
> 
> The backports differ from the upstream applied commits in two aspects:
> 1) use PCI IDs directly rather than nvme quirk infrastructure (which was
>    introduced later, commit 106198edb7 "nvme: add explicit quirk handling",
>    and depends on many further changes, not required for this purpose).
>     
> 2) use 'struct nvme_dev->tagset' rather than 'struct nvme_ctrl->tagset'
>    (similarly.)
> 
> This has been built and tested on top of v4.4.70.

Always tell me what the git commit ids are for the patches in Linus's
tree, as I need them.  I dug it out this time...

thanks,

greg k-h
