From: keith.busch@intel.com (Keith Busch)
Date: Wed, 5 Jul 2017 18:41:51 -0400
Subject: [PATCH v3] nvme: split nvme_uninit_ctrl into stop and uninit
In-Reply-To: <20170705222502.GA24884@localhost.localdomain>
References: <1499286857-7657-1-git-send-email-sagi@grimberg.me>
 <20170705222502.GA24884@localhost.localdomain>
Message-ID: <20170705224150.GB24884@localhost.localdomain>

On Wed, Jul 05, 2017@06:25:02PM -0400, Keith Busch wrote:
> On Wed, Jul 05, 2017@11:34:17PM +0300, Sagi Grimberg wrote:
> > Usually before we teardown the controller we want to:
> > 1. complete/cancel any ctrl inflight works
> > 2. remove ctrl namespaces (only for removal though, resets
> >    shouldn't remove any namespaces).
> > 
> > but we do not want to destroy the controller device as
> > we might use it for logging during the teardown stage.
> > 
> > This patch adds nvme_start_ctrl() which queues inflight
> > controller works (aen, ns scan, queue start and keep-alive
> > if kato is set) and nvme_stop_ctrl() which cancels the works
> > namespace removal is left to the callers to handle.
> > 
> > Move nvme_uninit_ctrl after we are done with the
> > controller device.
> > 
> > Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> 
> This looks good to me.
> 
> Reviewed-by: Keith Busch <keith.busch at intel.com>

Ah, it doesn't merge with your earlier patch, "nvme: move queue_count to
the nvme_ctrl". That 8-patch series the conflict came from looks good too,
so let's rebase this one on top of that.
