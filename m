Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDCCCCF2D6
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2026 08:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vBxSrJ7Bp3ubw28sbwKyLYSJq+nVPd2lgK9BUM79tIo=; b=jBt9JAQp5KTGLBKbOKuoyNuvHL
	QcopdRTia9xIW49VOPER/eDkLYURhJ2OWWQBjalMLHrZbhDimjG+ooGgJZb80XWvLnUNVb+aCz5W4
	7EyYFFkkSQBzypd/U9V+NAj0Mn4kEyZ4SZQIt2UI1J1gdX4iE6dqZxlkeaB0NMmbvqol1okFNoRYi
	4OSJpLAUVWXDHC/aFK1/1hmSZh3voNdMp5Bo+rS/HwV+51woFtUOsPEL4SYfSMDqmg3vihgmScTC5
	4i2PF+W42ku+UQ5V7tBImKOS87Rr/S3DD8FErg0z0o5Vkl18xCF5y+BwciEMLjYfjwKn6fDQ/p/2l
	7DWeIl6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIiWC-00000006qrT-3JFG;
	Mon, 19 Oct 2026 08:14:52 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIiWB-00000006qrD-1eiV
	for linux-nvme@lists.infradead.org;
	Mon, 19 Oct 2026 08:14:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 049064042F;
	Mon, 19 Oct 2026 08:14:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8D11F000C4;
	Mon, 19 Oct 2026 08:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792397690;
	bh=vBxSrJ7Bp3ubw28sbwKyLYSJq+nVPd2lgK9BUM79tIo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eKY7HOMTwp3jkTt//aAP4H7pSCIDAdzfpoPBIpVPcTFe8mSpMwB4PAsB8M1Gb9ga6
	 OOXkdTwNxjQ85/Mq/7/ZCZU+x/a+Y4PROKjM6EtNY0ZsiJRUQ8IzZSA+4L3myzZyOK
	 H8JNg/Ycfa6zT2LSmhbuTO76YWW+TNuBQ9TL+/qLe/1g0dStuF0s+bUjqGCn/x1oit
	 9d4FffjTjXGFJhhQQRZL8IdD902W2rKRqLdAD2lhK94UBUFYs4AFALt+YYq7TnWbGU
	 y4laRd3Frt0N/B+Nd172lZDDEKmBLxSdqmvmH+7F3MKfiNOLJGfzjuWno0cj2xRiZ1
	 84tJosrEdf7aw==
Message-ID: <sashiko-outbox-176784@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] nvme-multipath: implement service-time iopolicy
To: "Guixin Liu" <kanie@linux.alibaba.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261019075607.808947-2-kanie@linux.alibaba.com>
References: <20261019075607.808947-1-kanie@linux.alibaba.com>
 <20261019075607.808947-2-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 08:14:50 +0000
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] nvme-multipath: in_flight_size leak in nvme_mpath_end_request() =
on failover
- [Medium] nvme-multipath: in_flight_size underflow wraps in nvme_st_compar=
e_load()
--

commit 211891d7cca0785689865f3a7650f5305abaef90
Author: Guixin Liu <kanie@linux.alibaba.com>

nvme-multipath: implement service-time iopolicy

This commit adds a service-time multipath I/O policy that selects paths
based on the ratio of in-flight bytes to a configurable relative throughput
weight, exposing in_flight_bytes and relative_throughput sysfs attributes.

> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 75dbb58286a32..3901654d8226b 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
[ ... ]
> @@ -179,11 +180,16 @@ void nvme_mpath_start_request(struct request *rq)
>  {
>  	struct nvme_ns *ns =3D rq->q->queuedata;
>  	struct gendisk *disk =3D ns->head->disk;
> +	int iopolicy =3D READ_ONCE(ns->head->subsys->iopolicy);
> =20
> -	if ((READ_ONCE(ns->head->subsys->iopolicy) =3D=3D NVME_IOPOLICY_QD) &&
> +	if (iopolicy =3D=3D NVME_IOPOLICY_QD &&
>  	    !(nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE)) {
>  		atomic_inc(&ns->ctrl->nr_active);
>  		nvme_req(rq)->flags |=3D NVME_MPATH_CNT_ACTIVE;
> +	} else if (iopolicy =3D=3D NVME_IOPOLICY_ST &&
> +		   !(nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE_BYTES)) {
> +		atomic64_add(blk_rq_bytes(rq), &ns->ctrl->in_flight_size);
> +		nvme_req(rq)->flags |=3D NVME_MPATH_CNT_ACTIVE_BYTES;
>  	}
> =20
>  	if (!blk_queue_io_stat(disk->queue) ||
> @@ -205,6 +211,10 @@ void nvme_mpath_end_request(struct request *rq)
> =20
>  	if (nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE)
>  		atomic_dec_if_positive(&ns->ctrl->nr_active);
> +	if (nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE_BYTES) {
> +		atomic64_sub(blk_rq_bytes(rq), &ns->ctrl->in_flight_size);
> +		nvme_req(rq)->flags &=3D ~NVME_MPATH_CNT_ACTIVE_BYTES;
> +	}

[Severity: Medium]
Can this leak bytes in ns->ctrl->in_flight_size when a request fails over to
another path?

When a request fails with a path error (such as NVME_SC_ANA_TRANSITION,
NVME_SC_ANA_INACCESSIBLE, NVME_SC_ANA_PERSISTENT_LOSS,
NVME_SC_HOST_PATH_ERROR, or NVME_SC_HOST_ABORTED_CMD) or on a dying queue,
__nvme_complete_rq() calls nvme_failover_req():

drivers/nvme/host/multipath.c:nvme_failover_req() {
	...
	spin_lock_irqsave(&ns->head->requeue_lock, flags);
	for (bio =3D req->bio; bio; bio =3D bio->bi_next)
		bio_set_dev(bio, ns->head->disk->part0);
	blk_steal_bios(&ns->head->requeue_list, req);
	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);

	nvme_req(req)->status =3D 0;
	nvme_end_req(req);
}

blk_steal_bios() detaches all bios from the request and sets
req->__data_len =3D 0 before nvme_end_req() -> __nvme_end_req() ->
nvme_mpath_end_request() is called:

block/blk-mq.c:blk_steal_bios() {
	...
	rq->bio =3D NULL;
	rq->biotail =3D NULL;
	rq->__data_len =3D 0;
}

When nvme_mpath_end_request() subsequently calls blk_rq_bytes(rq), it reads
rq->__data_len as 0 and subtracts 0 from ns->ctrl->in_flight_size while
clearing NVME_MPATH_CNT_ACTIVE_BYTES. Whenever failover occurs without a
controller reset (for example during an ANA state transition, or on a
multipath controller without NVME_CTRL_CMIC_ANA where
nvme_mpath_init_identify() returns early), those bytes remain permanently
counted in ns->ctrl->in_flight_size, skewing path selection in
nvme_service_time_path() and leaving in_flight_bytes non-zero when idle.

> =20
>  	if (!(nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
>  		return;
> @@ -464,6 +474,109 @@ static struct nvme_ns *nvme_queue_depth_path(struct=
 nvme_ns_head *head)
>  	return best_opt ? best_opt : best_nonopt;
>  }
> =20
> +#define ST_MAX_RELATIVE_THROUGHPUT	100
> +#define ST_MAX_RELATIVE_THROUGHPUT_SHIFT	7
> +#define ST_MAX_INFLIGHT_SIZE \
> +	((size_t)-1 >> ST_MAX_RELATIVE_THROUGHPUT_SHIFT)
> +
> +/*
> + * Compare estimated service time of two paths.
> + * Returns negative if ns1 is better, positive if ns2 is better, 0 if eq=
ual.
> + *
> + * Service time =3D in_flight_size / relative_throughput
> + * Cross-multiply to avoid division.
> + */
> +static int nvme_st_compare_load(struct nvme_ns *ns1, struct nvme_ns *ns2)
> +{
> +	size_t sz1, sz2, st1, st2;
> +	unsigned int tp1 =3D ns1->ctrl->relative_throughput;
> +	unsigned int tp2 =3D ns2->ctrl->relative_throughput;
> +
> +	sz1 =3D atomic64_read(&ns1->ctrl->in_flight_size);
> +	sz2 =3D atomic64_read(&ns2->ctrl->in_flight_size);

[Severity: Medium]
What happens here if ns->ctrl->in_flight_size underflows below zero after a
controller reset?

When a request is started under NVME_IOPOLICY_ST, nvme_setup_cmd() calls
nvme_clear_nvme_request() (which sets RQF_DONTPREP), and
nvme_mpath_start_request() adds blk_rq_bytes(rq) to ns->ctrl->in_flight_size
and sets NVME_MPATH_CNT_ACTIVE_BYTES.

If that request is then placed onto q->requeue_list in MQ_RQ_IDLE state
without calling nvme_mpath_end_request() (either via nvme_retry_req() ->
blk_mq_requeue_request(), or when a transport queue_rq callback such as
nvme_rdma_queue_rq(), nvme_fc_start_fcp_op(), or nvme_loop_queue_rq()
returns BLK_STS_RESOURCE after nvme_start_request()) and a controller reset
occurs:

1. nvme_cancel_tagset() -> nvme_cancel_request() skips the request because
   blk_mq_rq_state(req) !=3D MQ_RQ_IN_FLIGHT.
2. nvme_mpath_init_identify() resets ctrl->in_flight_size to 0 via
   atomic64_set(&ctrl->in_flight_size, 0).
3. When the queue is unquiesced and the request is re-dispatched,
   nvme_setup_cmd() preserves nvme_req(req)->flags because RQF_DONTPREP is
   set, and nvme_mpath_start_request() skips adding blk_rq_bytes(rq) because
   NVME_MPATH_CNT_ACTIVE_BYTES is already set.
4. When the request completes, nvme_mpath_end_request() unconditionally
   executes atomic64_sub(blk_rq_bytes(rq), &ns->ctrl->in_flight_size),
   driving ctrl->in_flight_size negative (unlike ctrl->nr_active, which uses
   atomic_dec_if_positive()).

In nvme_st_compare_load(), the negative s64 returned by atomic64_read() is
assigned to the unsigned size_t variables sz1 and sz2, wrapping to a large
positive value near SIZE_MAX and causing nvme_service_time_path() to treat
the path as heavily overloaded until enough new I/O leaks or resets it.
Should in_flight_size be prevented from going negative or clamped when read?

[ ... ]
> @@ -1453,6 +1610,7 @@ int nvme_mpath_init_identify(struct nvme_ctrl *ctrl=
, struct nvme_id_ctrl *id)
> =20
>  	/* initialize this in the identify path to cover controller resets */
>  	atomic_set(&ctrl->nr_active, 0);
> +	atomic64_set(&ctrl->in_flight_size, 0);
> =20
>  	if (!ctrl->max_namespaces ||
>  	    ctrl->max_namespaces > le32_to_cpu(id->nn)) {
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019075607.8089=
47-1-kanie@linux.alibaba.com?part=3D1

