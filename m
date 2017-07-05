From: keith.busch@intel.com (Keith Busch)
Date: Wed, 5 Jul 2017 18:25:02 -0400
Subject: [PATCH v3] nvme: split nvme_uninit_ctrl into stop and uninit
In-Reply-To: <1499286857-7657-1-git-send-email-sagi@grimberg.me>
References: <1499286857-7657-1-git-send-email-sagi@grimberg.me>
Message-ID: <20170705222502.GA24884@localhost.localdomain>

On Wed, Jul 05, 2017@11:34:17PM +0300, Sagi Grimberg wrote:
> Usually before we teardown the controller we want to:
> 1. complete/cancel any ctrl inflight works
> 2. remove ctrl namespaces (only for removal though, resets
>    shouldn't remove any namespaces).
> 
> but we do not want to destroy the controller device as
> we might use it for logging during the teardown stage.
> 
> This patch adds nvme_start_ctrl() which queues inflight
> controller works (aen, ns scan, queue start and keep-alive
> if kato is set) and nvme_stop_ctrl() which cancels the works
> namespace removal is left to the callers to handle.
> 
> Move nvme_uninit_ctrl after we are done with the
> controller device.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

This looks good to me.

Reviewed-by: Keith Busch <keith.busch at intel.com>
