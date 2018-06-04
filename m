From: hare@suse.de (Hannes Reinecke)
Date: Mon, 4 Jun 2018 08:36:58 +0200
Subject: [PATCH 5/9] nvme: add ANA support
In-Reply-To: <20180601071128.7630-6-hch@lst.de>
References: <20180601071128.7630-1-hch@lst.de>
 <20180601071128.7630-6-hch@lst.de>
Message-ID: <20180604083658.55a9bc10@pentland.suse.de>

On Fri,  1 Jun 2018 09:11:24 +0200
Christoph Hellwig <hch@lst.de> wrote:

> Add support for Asynchronous Namespace Access as specified in NVMe 1.3
> TP 4004.  With ANA each namespace attached to a controller belongs to
> an ANA group that describes the characteristics of accessing the
> namespaces through this controller.  In the optimized and
> non-optimized states namespaces can be accessed regularly, although
> in a multi-pathing environment we should always prefer to access a
> namespace through a controller where an optimized relationship
> exists.  Namespaces in Inaccessible, Permanent-Loss or Change state
> for a given controller should not be accessed.
> 
> We keep a simple per-controller array of ANA states which is indexed
> by the ANA group ID specified in the namespace.  The states are
> updated through reading the ANA log page, which is read once during
> controller initialization, and whenever the ANA change notice AEN is
> received, or when one of the ANA specific status codes that signal a
> state change is received on a command.
> 
> There currently isn't any support for the ANA transition timeout
> yet.
> 
> Includes fixes and improvements from Hannes Reinecke.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>  drivers/nvme/host/core.c      |  30 ++++-
>  drivers/nvme/host/multipath.c | 210
> +++++++++++++++++++++++++++++++++- drivers/nvme/host/nvme.h      |
> 28 +++++ 3 files changed, 261 insertions(+), 7 deletions(-)
> 

This suffers from the 'nvme connect' stall if the first detected
namespace is inaccessible.

I would prefer to have it fixed via a separate patchset, though, and
keep this patch as is.
So:

Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
