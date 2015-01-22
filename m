From: keith.busch@intel.com (Keith Busch)
Date: Thu, 22 Jan 2015 00:47:24 +0000 (UTC)
Subject: [PATCH 1/1] NVMe: Do not take nsid while a passthrough IO command
 is being issued via a block device file descriptor
In-Reply-To: <1421886503-25276-1-git-send-email-yan@purestorage.com>
References: <1421886503-25276-1-git-send-email-yan@purestorage.com>
Message-ID: <alpine.LNX.2.00.1501220035170.15481@localhost.lm.intel.com>

On Wed, 21 Jan 2015, Yan Liu wrote:
> When a passthrough IO command is issued with a specific block device file descriptor. It should be applied at
> the namespace which is associated with that block device file descriptor. This patch makes such passthrough
> command ingore nsid in nvme_passthru_cmd structure. Instead it takes the namespace ID asscoiated with the
> block device descriptor.
>
> Signed-off-by: Yan Liu <yan at purestorage.com>

Oh it doesn't look like you tested this through the character
handle. You've got it set to use the admin queue's request_queue for IO
passthrough commands, so that can't be right.

The IOCTL's purpose was to let someone submit completely arbitrary
commands on IO queues. This technically shouldn't even need a namespace
handle, but we don't have a request_queue associated to IO queues without
one like the admin queue has. In fact, we ought to fix that so we can
issue IO commands without namespaces.

Anyway, namespaces may be hidden or some vendor special NSID trickery,
who knows. Point is we don't want to tie the passthrough command's NSID
down to the namespace providing the request_queue. If it is your intention
to use that NSID, you can get the NSID using the NVME_IOCTL_ID prior to
setting up the passthrough command.
