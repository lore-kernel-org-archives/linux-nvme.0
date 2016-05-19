From: keith.busch@intel.com (Keith Busch)
Date: Thu, 19 May 2016 16:48:29 -0400
Subject: [PATCH v2 1/2] nvme: switch to RCU freeing the namespace
In-Reply-To: <1463637146.8610.4.camel@kernel.org>
References: <1463295520.5272.4.camel@kernel.org>
 <CAF1ivSaOMqLP=a9KgNy0Gbn9w_KkCzwbuY80e=sCJR+4Vg2kNw@mail.gmail.com>
 <20160517150511.GB14260@localhost.localdomain>
 <20160517152359.GC14260@localhost.localdomain>
 <20160517153003.GA18529@localhost.localdomain>
 <CAF1ivSaEg2wiH3hwpRmeK7ua69ERT5MP8MqZyuc6Dtb2fes6gg@mail.gmail.com>
 <20160517210706.GB19325@localhost.localdomain>
 <CAF1ivSbi8rXgsM885w0EMyzMnDuiGOUUfu3o+RKbz1KG2jJW6Q@mail.gmail.com>
 <20160517212542.GC19325@localhost.localdomain>
 <1463637146.8610.4.camel@kernel.org>
Message-ID: <20160519204829.GB28795@localhost.localdomain>

On Wed, May 18, 2016@10:52:26PM -0700, Ming Lin wrote:
> I have not found the root cause yet.
> Below patch makes reset not occur during active scan work.
> And I didn't see the crash any more with this patch.
> 
> So it seems there is a race somewhere between reset work and scan work.

I don't know about this. I think we should be able to reset during a
scan. A controller CSTS.CFS or IO timeout occuring during a scan should
be able to recover, but this patch could leave everything stuck if
that happens: the watchdog timer that kicked the reset work won't get
restarted since the reset work returns immediately before it disables
the controller to reclaim IO from the failed controller.

Alternatively, a reset scheduled from the timeout handler races with
the scan work changing the controller state, and may not proceed.


> ?drivers/nvme/host/core.c | 13 ++++++++++++-
> ?drivers/nvme/host/nvme.h |??1 +
> ?drivers/nvme/host/pci.c??|??3 +++
> ?3 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index a57ccd3..8560774 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -89,6 +89,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
> ?		case NVME_CTRL_NEW:
> ?		case NVME_CTRL_RESETTING:
> ?		case NVME_CTRL_RECONNECTING:
> +		case NVME_CTRL_SCANING:

spelling: NVME_CTRL_SCANNING

> ?			changed = true;
> ?			/* FALLTHRU */
> ?		default:
> @@ -126,6 +127,14 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
> ?			break;
> ?		}
> ?		break;
> +	case NVME_CTRL_SCANING:
> +		switch (old_state) {
> +		case NVME_CTRL_LIVE:
> +			changed = true;
> +			/* FALLTHRU */
> +		default:
> +			break;
> +		}
> ?	default:
> ?		break;
> ?	}
> @@ -1755,7 +1764,7 @@ static void nvme_scan_work(struct work_struct *work)
> ?	struct nvme_id_ctrl *id;
> ?	unsigned nn;
> ?
> -	if (ctrl->state != NVME_CTRL_LIVE)
> +	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_SCANING))
> ?		return;
> ?
> ?	if (nvme_identify_ctrl(ctrl, &id))
> @@ -1776,6 +1785,8 @@ static void nvme_scan_work(struct work_struct *work)
> ?
> ?	if (ctrl->ops->post_scan)
> ?		ctrl->ops->post_scan(ctrl);
> +
> +	nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE);
> ?}
> ?
> ?void nvme_queue_scan(struct nvme_ctrl *ctrl)
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 3f3945a..2827825 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -76,6 +76,7 @@ enum nvme_ctrl_state {
> ?	NVME_CTRL_RESETTING,
> ?	NVME_CTRL_RECONNECTING,
> ?	NVME_CTRL_DELETING,
> +	NVME_CTRL_SCANING,
> ?};
> ?
> ?struct nvme_ctrl {
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 02105da..71260c8 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1761,6 +1761,9 @@ static void nvme_reset_work(struct work_struct *work)
> ?	struct nvme_dev *dev = container_of(work, struct nvme_dev, reset_work);
> ?	int result = -ENODEV;
> ?
> +	if (dev->ctrl.state == NVME_CTRL_SCANING)
> +		return;
> +
> ?	if (WARN_ON(dev->ctrl.state == NVME_CTRL_RESETTING))
> ?		goto out;
