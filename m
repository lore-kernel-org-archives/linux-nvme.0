Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BE9606A322
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Oct 2026 15:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=DC0rlB6s;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=THNS97+e
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ipRHD1Fdt59w+WPN2ImcNR3UFKMT4hC8lG8AfsUmKiA=; b=DC0rlB6s5o7WCUa8JssikW6QKs
	9Ql+GL47/y5m3Fe+Ug1SiTVp6mcMvq7YtZVUg1PVA2h0mbyC2YujrceQFmheSY9PpjzCsGK0EolSC
	XJRgknUfgSEm6OCJ9BqOYzZG0jylxEXvz5Dq1J9r+D8XiI3KkJLzcfvo2Jnhn/xCFq0ovBKMcMGO3
	fcr8vLEHWXqw357BaOcQ58aJDeKa8Hmwv3FteN9sxutUyxA/V+s9NiL29EzbKw20xOV31467ewAbO
	LdRp/TBrtm4Iob8ECxrxd7S7jxDPRnxRIBQtF7h5PIseMghlf64ySgAptAs4+nagWHB27+l6jSL2Z
	P2E+z+qQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLN1C-00000002nNd-27EY;
	Mon, 26 Oct 2026 15:53:50 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLN1B-00000002nNT-0fii
	for linux-nvme@lists.infradead.org;
	Mon, 26 Oct 2026 15:53:49 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8A5AD4408A;
	Mon, 26 Oct 2026 15:53:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31EF11F031ED;
	Mon, 26 Oct 2026 15:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793030028;
	bh=ipRHD1Fdt59w+WPN2ImcNR3UFKMT4hC8lG8AfsUmKiA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=THNS97+erkWrT8H4KwK/PwyDWNsDS9TDA4Wl/1f4Vx7PKvL9TfSSjpN2M8aK5V9cl
	 UdxxiOQfF35EPjx4vuXXOeF+ON0tlfxYcxR6MrdwD8tn4ewrNDheT36i5oNR+Sl3RD
	 JUE6NN3jwssl4kiZIHCff0ljEoyBzBGfjbwoUdybzuDJmigFShEZyJ5JEPIVdCSv66
	 e9IhAMcEx5BEuPzY9W+jdHFTynOqBK/Q01H4YHp8rORrSU+HjqGHpxS9Uj5nY5lIWg
	 S+VLT89Mn6S0bIWIhYhq53bUSwGbiyzDL8dbt8FWa0VhWBDwlSBYlkPSA4+cECR2G5
	 41VEjQa5j5XEw==
Message-ID: <sashiko-outbox-185466@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10] nvmet: add cgroup_id to charge namespace I/O to a
 cgroup
To: "Peng Yu" <yupeng0921@gmail.com>
Cc: linux-nvme@lists.infradead.org, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
In-Reply-To: <20261026153020.47791-1-yupeng0921@gmail.com>
References: <20261026153020.47791-1-yupeng0921@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 15:53:47 +0000
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] nvmet: secondary blkcg_wq works miss memalloc_noio_save() and sq d=
ying check
--

commit 13b26415d838fcd912a4355b04d128dd0c4fb228
Author: Peng Yu <yupeng0921@gmail.com>

nvmet: add cgroup_id to charge namespace I/O to a cgroup

This commit adds a configfs cgroup_id attribute to nvmet namespaces so
that namespace I/O can be associated with a blkcg css. To prevent
blocking shared transport threads when io.cost or io.latency throttles a
thread, it executes I/O commands for cgroup-associated namespaces via a
per-namespace workqueue.

> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 4955872dc1fc2..624955cc7fb55 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
[ ... ]
> @@ -474,8 +477,144 @@ void nvmet_put_namespace(struct nvmet_ns *ns)
[ ... ]
> +static void nvmet_blkcg_work(struct work_struct *work)
> +{
> +	struct nvmet_req *req =3D
> +		container_of(work, struct nvmet_req, blkcg_work);
> +	unsigned int noio_flag;
> +	bool associated;
> +
> +	/* its queue is being deleted: abort it rather than throttle it */
> +	if (unlikely(percpu_ref_is_dying(&req->sq->ref))) {
> +		nvmet_req_complete(req, NVME_SC_ABORT_QUEUE);
> +		return;
> +	}
> +
> +	/* reclaim must not wait for I/O queued on this workqueue */
> +	noio_flag =3D memalloc_noio_save();
> +	associated =3D nvmet_blkcg_begin(req);
> +	req->blkcg_execute(req);
> +	nvmet_blkcg_end(associated);
> +	memalloc_noio_restore(noio_flag);
> +}
> +
> +static void nvmet_blkcg_queue_req(struct nvmet_req *req)
> +{
> +	INIT_WORK(&req->blkcg_work, nvmet_blkcg_work);
> +	queue_work(req->ns->blkcg_wq, &req->blkcg_work);
> +}
> +
> +static void nvmet_blkcg_init_req(struct nvmet_req *req)
> +{
> +	if (!req->ns->cgrp)
> +		return;
> +
> +	req->blkcg_execute =3D req->execute;
> +	req->execute =3D nvmet_blkcg_queue_req;
> +}
[ ... ]
> diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-c=
md-file.c
> index 695963dd932ee..673df713c954f 100644
> --- a/drivers/nvme/target/io-cmd-file.c
> +++ b/drivers/nvme/target/io-cmd-file.c
> @@ -257,8 +257,13 @@ u16 nvmet_file_flush(struct nvmet_req *req)
>  static void nvmet_file_flush_work(struct work_struct *w)
>  {
>  	struct nvmet_req *req =3D container_of(w, struct nvmet_req, f.work);
> +	bool associated;
> +	u16 status;
> =20
> -	nvmet_req_complete(req, nvmet_file_flush(req));
> +	associated =3D nvmet_blkcg_begin(req);
> +	status =3D nvmet_file_flush(req);
> +	nvmet_blkcg_end(associated);
> +	nvmet_req_complete(req, status);
>  }
> =20
>  static void nvmet_file_execute_flush(struct nvmet_req *req)
> @@ -266,7 +271,7 @@ static void nvmet_file_execute_flush(struct nvmet_req=
 *req)
>  	if (!nvmet_check_transfer_len(req, 0))
>  		return;
>  	INIT_WORK(&req->f.work, nvmet_file_flush_work);
> -	queue_work(nvmet_wq, &req->f.work);
> +	nvmet_req_queue_work(req, nvmet_wq, &req->f.work);
>  }
> =20
>  static void nvmet_file_execute_discard(struct nvmet_req *req)
> @@ -274,10 +279,12 @@ static void nvmet_file_execute_discard(struct nvmet=
_req *req)
>  	int mode =3D FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE;
>  	struct nvme_dsm_range range;
>  	loff_t offset, len;
> +	bool associated;
>  	u16 status =3D 0;
>  	int ret;
>  	int i;
> =20
> +	associated =3D nvmet_blkcg_begin(req);
[ ... ]
> @@ -326,7 +334,7 @@ static void nvmet_file_execute_dsm(struct nvmet_req *=
req)
>  	if (!nvmet_check_data_len_lte(req, nvmet_dsm_len(req)))
>  		return;
>  	INIT_WORK(&req->f.work, nvmet_file_dsm_work);
> -	queue_work(nvmet_wq, &req->f.work);
> +	nvmet_req_queue_work(req, nvmet_wq, &req->f.work);
>  }
> =20
>  static void nvmet_file_write_zeroes_work(struct work_struct *w)
> @@ -336,6 +344,7 @@ static void nvmet_file_write_zeroes_work(struct work_=
struct *w)
>  	int mode =3D FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE;
>  	loff_t offset;
>  	loff_t len;
> +	bool associated;
>  	int ret;
[ ... ]
> @@ -347,7 +356,9 @@ static void nvmet_file_write_zeroes_work(struct work_=
struct *w)
>  		return;
>  	}
> =20
> +	associated =3D nvmet_blkcg_begin(req);
>  	ret =3D vfs_fallocate(req->ns->file, mode, offset, len);
> +	nvmet_blkcg_end(associated);
>  	nvmet_req_complete(req, ret < 0 ? errno_to_nvme_status(req, ret) : 0);
>  }
> =20
> @@ -356,7 +367,7 @@ static void nvmet_file_execute_write_zeroes(struct nv=
met_req *req)
>  	if (!nvmet_check_transfer_len(req, 0))
>  		return;
>  	INIT_WORK(&req->f.work, nvmet_file_write_zeroes_work);
> -	queue_work(nvmet_wq, &req->f.work);
> +	nvmet_req_queue_work(req, nvmet_wq, &req->f.work);
>  }
[ ... ]
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index e315f1c24e73d..9a9fba0512485 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
[ ... ]
> @@ -746,6 +767,36 @@ void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_=
req *req);
[ ... ]
> +static inline void nvmet_req_queue_work(struct nvmet_req *req,
> +		struct workqueue_struct *wq, struct work_struct *work)
> +{
> +#ifdef CONFIG_BLK_CGROUP
> +	if (req->ns->blkcg_wq)
> +		wq =3D req->ns->blkcg_wq;
> +#endif
> +	queue_work(wq, work);
> +}
> +
>  static inline u32 nvmet_rw_data_len(struct nvmet_req *req)
> diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
> index 92f5c1435582e..06d9a12245719 100644
> --- a/drivers/nvme/target/zns.c
> +++ b/drivers/nvme/target/zns.c
> @@ -498,8 +498,11 @@ static void nvmet_bdev_zmgmt_send_work(struct work_s=
truct *w)
>  	struct block_device *bdev =3D req->ns->bdev;
>  	sector_t zone_sectors =3D bdev_zone_sectors(bdev);
>  	u16 status =3D NVME_SC_SUCCESS;
> +	bool associated;
>  	int ret;
> =20
> +	associated =3D nvmet_blkcg_begin(req);
> +
>  	if (op =3D=3D REQ_OP_LAST) {
>  		req->error_loc =3D offsetof(struct nvme_zone_mgmt_send_cmd, zsa);
>  		status =3D NVME_SC_ZONE_INVALID_TRANSITION | NVME_STATUS_DNR;
> @@ -529,13 +532,14 @@ static void nvmet_bdev_zmgmt_send_work(struct work_=
struct *w)
>  		status =3D blkdev_zone_mgmt_errno_to_nvme_status(ret);
> =20
>  out:
> +	nvmet_blkcg_end(associated);
>  	nvmet_req_complete(req, status);
>  }
> =20
>  void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req)
>  {
>  	INIT_WORK(&req->z.zmgmt_work, nvmet_bdev_zmgmt_send_work);
> -	queue_work(zbd_wq, &req->z.zmgmt_work);
> +	nvmet_req_queue_work(req, zbd_wq, &req->z.zmgmt_work);
>  }

[Severity: High]
When a namespace has cgroup_id configured, nvmet_parse_io_cmd() calls
nvmet_blkcg_init_req() in drivers/nvme/target/core.c for all I/O commands,
wrapping req->execute with nvmet_blkcg_queue_req().

For commands whose backend execute callbacks queue another work item via
nvmet_req_queue_work() (nvmet_file_execute_flush(), nvmet_file_execute_dsm(=
),
nvmet_file_execute_write_zeroes() in drivers/nvme/target/io-cmd-file.c, and
nvmet_bdev_execute_zone_mgmt_send() in drivers/nvme/target/zns.c), the call
chain becomes:

  nvmet_blkcg_queue_req()
    -> queue_work(req->ns->blkcg_wq, &req->blkcg_work)
  nvmet_blkcg_work()
    -> percpu_ref_is_dying(&req->sq->ref)
    -> memalloc_noio_save()
    -> nvmet_blkcg_begin()
    -> req->blkcg_execute(req)
         -> nvmet_req_queue_work(req, ..., work)
              -> queue_work(req->ns->blkcg_wq, work)
    -> nvmet_blkcg_end()
    -> memalloc_noio_restore()

Because req->blkcg_execute(req) only queues a second work item onto
req->ns->blkcg_wq and returns immediately, nvmet_blkcg_work() restores
noio_flag before the actual I/O work runs.

When the second work item (nvmet_file_flush_work(), nvmet_file_dsm_work() ->
nvmet_file_execute_discard(), nvmet_file_write_zeroes_work(), or
nvmet_bdev_zmgmt_send_work()) later executes on req->ns->blkcg_wq:

1. It runs without memalloc_noio_save() on a WQ_MEM_RECLAIM workqueue while
performing GFP_KERNEL / __GFP_IO allocations (such as blk_next_bio() with
GFP_KERNEL in blkdev_zone_mgmt() and nvmet_bdev_zone_mgmt_emulate_all(),
blkdev_report_zones(), or filesystem allocations in vfs_fallocate() and
vfs_fsync()). Can direct reclaim from these allocations recurse into I/O and
deadlock waiting for requests queued behind throttled workers on the same
req->ns->blkcg_wq?

2. It does not check percpu_ref_is_dying(&req->sq->ref) before calling
nvmet_blkcg_begin(req). If nvmet_sq_destroy() kills sq->ref while this seco=
nd
work item is waiting behind throttled commands on req->ns->blkcg_wq, won't =
it
still enter cgroup throttling instead of aborting early with
NVME_SC_ABORT_QUEUE?

Would it make sense for these commands to either execute directly in
nvmet_blkcg_work() without queuing a second work item onto req->ns->blkcg_w=
q,
or skip nvmet_blkcg_init_req() and apply the dying-queue check and
memalloc_noio_save() inside their own work handlers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026153020.4779=
1-1-yupeng0921@gmail.com?part=3D1

