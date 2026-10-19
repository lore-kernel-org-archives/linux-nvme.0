Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E3BCCF2DA
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2026 08:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RAWW5HtSN894it+Hhy56+CPxqfLKo4uvOouiIuJvv14=; b=nLJ1yM5jHso23POH/cBqLzds2f
	s1kUf5SDlFt7/5ppRYWUOD+6M1uN+Ym5UgZobdh5amnH0zlkGIWaYaPNAl9uf16KBk+UWOb4nI8lQ
	Sv4WMe7ozlfCBz5MdoOBJaND4zePVn4fhLwYD2+eZ50KhAfZkOZ7EH/+ZqzDP6FyzIcxohkZrs7yE
	DOR2GG3YzHxAD+3JYJ1WY0Z3moTYge1FtUwHeSRyW0UNFrhJmr6V5M7rLYhq5HemWJkJm6g7/MJMu
	UjPHk1o3bbTWjoMjofuRLTA+6C6NCcHqMaByKw9naVt/hgQOvCcbxpINEPTVvHhMn4uoNOMZYqF+6
	8EIr2l3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIiV8-00000006qdA-2V7n;
	Mon, 19 Oct 2026 08:13:46 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIiV8-00000006qcu-0Von
	for linux-nvme@lists.infradead.org;
	Mon, 19 Oct 2026 08:13:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7828F600CB;
	Mon, 19 Oct 2026 08:13:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF621F000C4;
	Mon, 19 Oct 2026 08:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792397625;
	bh=RAWW5HtSN894it+Hhy56+CPxqfLKo4uvOouiIuJvv14=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h1RV6ATEFrj3y7xZjAUhtm8APU+RVyuP73g8NTHnGmth3faKvYQjW+P95TO0IcF73
	 NKcRTJgXSfwR/zDSuhkKmEBqd9NoaAYuBq5hNcUTvoLZjtyKrFb8HJgONj56BFm46C
	 9yL6Ef9hWaKV7KNaoN7RH8Ak49weTRE5VhAhSt7Uzl9yhVeRAJSW4VJXxwGgGD/2WJ
	 VrJFXebVump6hclVC2P1Qt3lLnajfQqK2Y89pKovcUuFQbmcRSiVYhvgxdZwX3+RaT
	 gXBrXhtDMFuw2t2b01vz9scKGu2gaq1G7YqkQl4VC+MmYHs2JTBMCubOIYkAQj9sg7
	 w6UE2KkNfxH/g==
Message-ID: <sashiko-outbox-176783@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] nvme: document the service-time iopolicy sysfs
 attributes
To: "Guixin Liu" <kanie@linux.alibaba.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261019075607.808947-4-kanie@linux.alibaba.com>
References: <20261019075607.808947-1-kanie@linux.alibaba.com>
 <20261019075607.808947-4-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 08:13:44 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] nvme-multipath: nvme_failover_req() clears rq bytes before in_flig=
ht_size sub
- [High] nvme-multipath: in_flight_size underflow in nvme_mpath_end_request=
()
- [Low] nvme: missing service-time in sysfs-nvme iopolicy ABI documentation
--

commit 5acf4057a11f40dc3e2cd32f04002286c4084ff4
Author: Guixin Liu <kanie@linux.alibaba.com>

nvme: document the service-time iopolicy sysfs attributes

This commit documents the new in_flight_bytes and relative_throughput sysfs
attributes added for the service-time NVMe multipath I/O policy in
Documentation/ABI/stable/sysfs-nvme.

> diff --git a/Documentation/ABI/stable/sysfs-nvme b/Documentation/ABI/stab=
le/sysfs-nvme
> index a2f5d0710db40..adaf292c8c67b 100644
> --- a/Documentation/ABI/stable/sysfs-nvme
> +++ b/Documentation/ABI/stable/sysfs-nvme
> @@ -326,6 +326,28 @@ Description:
>  		currently selected path. Returns empty if iopolicy is not
>  		"numa". Requires CONFIG_NVME_MULTIPATH.
> =20
> +What:		/sys/block/nvmeXcYnZ/in_flight_bytes
> +What:		/sys/block/nvmeXcYnZ/relative_throughput
> +Date:		October 2026
> +KernelVersion:	7.5
> +Contact:	Guixin Liu <kanie@linux.alibaba.com>
> +Description:
> +		in_flight_bytes: Shows the number of bytes currently in
> +		flight on this path's controller. Returns empty if
> +		iopolicy is not "service-time".
> +		Requires CONFIG_NVME_MULTIPATH.

[Severity: High]
Can ns->ctrl->in_flight_size permanently leak in-flight bytes when a
request fails over in nvme_failover_req()?

In commit 211891d7cca0 ("nvme-multipath: implement service-time iopolicy"),
nvme_mpath_start_request() adds blk_rq_bytes(rq) to ns->ctrl->in_flight_size
and sets NVME_MPATH_CNT_ACTIVE_BYTES:

drivers/nvme/host/multipath.c:nvme_mpath_start_request() {
	...
	} else if (iopolicy =3D=3D NVME_IOPOLICY_ST &&
		   !(nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE_BYTES)) {
		atomic64_add(blk_rq_bytes(rq), &ns->ctrl->in_flight_size);
		nvme_req(rq)->flags |=3D NVME_MPATH_CNT_ACTIVE_BYTES;
	}
}

When a request fails over (for example, on NVME_SC_ANA_TRANSITION,
NVME_SC_HOST_PATH_ERROR, or a dying queue), __nvme_complete_rq() calls
nvme_failover_req(), which steals the bios from req before calling
nvme_end_req():

drivers/nvme/host/multipath.c:nvme_failover_req() {
	...
	blk_steal_bios(&ns->head->requeue_list, req);
	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);

	nvme_req(req)->status =3D 0;
	nvme_end_req(req);
}

Because blk_steal_bios() clears rq->__data_len:

block/blk-mq.c:blk_steal_bios() {
	...
	rq->__data_len =3D 0;
}

by the time nvme_end_req() -> __nvme_end_req() -> nvme_mpath_end_request()
runs:

drivers/nvme/host/multipath.c:nvme_mpath_end_request() {
	...
	if (nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE_BYTES) {
		atomic64_sub(blk_rq_bytes(rq), &ns->ctrl->in_flight_size);
		nvme_req(rq)->flags &=3D ~NVME_MPATH_CNT_ACTIVE_BYTES;
	}
}

blk_rq_bytes(rq) is 0, so the failed-over request's bytes are never
subtracted from ns->ctrl->in_flight_size. When failover occurs without a
controller reset, does ns->ctrl->in_flight_size remain permanently
inflated, skewing nvme_st_compare_load() and the in_flight_bytes sysfs
attribute?

[Severity: High]
Also in nvme_mpath_end_request(), can ns->ctrl->in_flight_size underflow
to a negative value if a requeued request completes after a controller
reset?

When a request started under NVME_IOPOLICY_ST is requeued via
nvme_retry_req() -> blk_mq_requeue_request() (or via BLK_STS_RESOURCE after
nvme_start_request() in nvme_rdma_queue_rq() or nvme_fc_start_fcp_op()),
the request returns to MQ_RQ_IDLE while retaining RQF_DONTPREP and
NVME_MPATH_CNT_ACTIVE_BYTES.

If a controller reset occurs before that request is re-dispatched,
nvme_mpath_init_identify() resets ctrl->in_flight_size to 0:

drivers/nvme/host/multipath.c:nvme_mpath_init_identify() {
	...
	/* initialize this in the identify path to cover controller resets */
	atomic_set(&ctrl->nr_active, 0);
	atomic64_set(&ctrl->in_flight_size, 0);
}

When the request is later re-dispatched, nvme_setup_cmd() skips
nvme_clear_nvme_request() because RQF_DONTPREP is set, and
nvme_mpath_start_request() skips atomic64_add() because
NVME_MPATH_CNT_ACTIVE_BYTES is already set. When the request finishes,
nvme_mpath_end_request() unconditionally subtracts blk_rq_bytes(rq) from
ns->ctrl->in_flight_size (unlike nr_active, which uses
atomic_dec_if_positive()), driving ctrl->in_flight_size negative.

In nvme_st_compare_load(), the negative s64 is then assigned to unsigned
size_t:

drivers/nvme/host/multipath.c:nvme_st_compare_load() {
	size_t sz1, sz2, st1, st2;
	unsigned int tp1 =3D ns1->ctrl->relative_throughput;
	unsigned int tp2 =3D ns2->ctrl->relative_throughput;

	sz1 =3D atomic64_read(&ns1->ctrl->in_flight_size);
	sz2 =3D atomic64_read(&ns2->ctrl->in_flight_size);

Would this wrap sz1 or sz2 to near SIZE_MAX, causing
nvme_service_time_path() to avoid that controller's path while reporting a
negative value in in_flight_bytes?

> +
> +		relative_throughput: Shows or sets the relative
> +		throughput weight of this path, which the "service-time"
> +		iopolicy uses to estimate the path service time as
> +		in_flight_bytes / relative_throughput. The value is an
> +		integer in the range 0-100 and defaults to 1; assign
> +		higher values to faster paths. A path with a value of 0
> +		is only selected when no path with a positive value is
> +		available. Reading returns empty if iopolicy is not
> +		"service-time"; writing is accepted regardless of the
> +		active policy. Requires CONFIG_NVME_MULTIPATH.
> +
>  What:		/sys/block/nvmeXnY/delayed_removal_secs
>  Date:		May 2025
>  KernelVersion:	6.16

[Severity: Low]
In the same file (Documentation/ABI/stable/sysfs-nvme), the entry for
/sys/class/nvme-subsystem/nvme-subsysX/iopolicy still lists only the three
previous policies:

What:		/sys/class/nvme-subsystem/nvme-subsysX/iopolicy
...
Description:
		Shows or sets the multipath I/O path selection policy for
		this subsystem. Accepted values: "numa", "round-robin",
		"queue-depth". Changing the policy clears all current path
		selections. Only available when CONFIG_NVME_MULTIPATH is
		enabled.

Should "service-time" also be added to the accepted values for
/sys/class/nvme-subsystem/nvme-subsysX/iopolicy?

=D9=87=D8=A7=DB=8C=DB=8C

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019075607.8089=
47-1-kanie@linux.alibaba.com?part=3D3

