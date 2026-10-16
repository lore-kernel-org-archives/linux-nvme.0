Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5080FCCF2C0
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Oct 2026 17:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TNK0H5yQMTcAOILr+2wVhtTaKLUKIqI3bP66lSDBLQE=; b=h/u2cxLDNOat1jEdeit6NRT71X
	q2ImbEFkHH/da/xPkibQHG92BNYdQrGpmwhah3wis/BQETSyIpo5IxGuPQh5jdj/g79Coejg8VtWD
	LaOkB4Sp5yMbp02q8a56fR/e12e2jVhFBNHPiUNbKSYkwy9F/jEkxEZTg5zMdCBw+/F/eMWIMHE1M
	GHefFd0HvaZbnByEtkqgTQ/DOPRwn5FPNAkpu1jj0T7q9S1cIvWbNwLlERYpS+FART1QFqiHSvuSm
	XAyuPUd4e7kqHvuNOa08ZMrCTkwfeiMZehqMXy4G4Xi96+huy3S0UI884NmvXp4kjukMSm12ac0mW
	cZWgUJQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHlpk-00000003ZMR-1YBd;
	Fri, 16 Oct 2026 17:35:08 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHlpj-00000003ZML-2WSZ
	for linux-nvme@lists.infradead.org;
	Fri, 16 Oct 2026 17:35:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1242740258;
	Fri, 16 Oct 2026 17:35:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4CB1F000C6;
	Fri, 16 Oct 2026 17:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792172107;
	bh=TNK0H5yQMTcAOILr+2wVhtTaKLUKIqI3bP66lSDBLQE=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=iSgoaF2FTX5HjyFjN6LFvH5luTwVsbXJfP+rzHC41Vc4VX+XQqgZr3bMsEnE87k9N
	 jPgoDEL/TCzgtFztlHEs0FJc0p5+ge9l67IBg+hBW6erb5Vk/ret5d7RWbv3BSBEGT
	 ClvHdZlppHluZXKp9D0ZA80XlpiNmk+E6Y+P715TNmLqmQ9/PMjew/eNWbBWsN6ONr
	 UkYyVoKqQ1XOyg2fIB9h5dhM4vNV+13tQRw8ZI8hbdx70652X+pv0qzLJlHTNO95/q
	 nRRfh/vs3ULRGuOjB2wUCZPC1LzL/t/koLDWXCh6IF+vMRsIKUfM1QYNqLIPA2NMZ3
	 BkQyHmJgeLufg==
Message-ID: <sashiko-outbox-174726@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH nvme] nvmet-rdma: reject short connection requests
To: bestswngs@gmail.com, linux-nvme@lists.infradead.org
In-Reply-To: <20261016172336.286341-3-bestswngs@gmail.com>
References: <20261016172336.286341-3-bestswngs@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 17:35:06 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] nvme-rdma: unauthenticated remote DoS via unbounded IO queue sizes
--

commit 73a9fa992c7d8c72321b7f00558b5cb1451f8574
Author: Weiming Shi <bestswngs@gmail.com>

nvmet-rdma: reject short connection requests

nvmet_rdma_parse_cm_connect_req() treats rdma cm private data as a
struct nvme_rdma_cm_req but accepts any nonzero private_data_len. The
iWARP path allocates exactly the peer-provided length, so a six-byte MPA
request reaches the parser and the hsqsize load reads two bytes past the
allocation. This requires the complete request structure before reading
any of its fields.

> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index ffa1e172c259b..075ab58d8c884 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -1412,7 +1412,7 @@ nvmet_rdma_parse_cm_connect_req(struct rdma_conn_pa=
ram *conn,
>  	struct nvme_rdma_cm_req *req;
> =20
>  	req =3D (struct nvme_rdma_cm_req *)conn->private_data;
> -	if (!req || conn->private_data_len =3D=3D 0)
> +	if (!req || conn->private_data_len < sizeof(*req))
>  		return NVME_RDMA_CM_INVALID_LEN;
> =20
>  	if (le16_to_cpu(req->recfmt) !=3D NVME_RDMA_CM_FMT_1_0)

[Severity: High]
Does this code adequately validate the remote request fields for io queues?

In nvmet_rdma_parse_cm_connect_req(), the unvalidated hsqsize and hrqsize
fields from the untrusted remote request are directly assigned to the queue
sizes. While there is a check for the admin queue (host_qid =3D=3D 0), the =
lack
of bounds checking for io queues allows an unauthenticated initiator to set
arbitrary queue bounds up to the 16-bit integer limit:

	queue->recv_queue_size =3D le16_to_cpu(req->hsqsize) + 1;
	queue->send_queue_size =3D le16_to_cpu(req->hrqsize);

	if (!queue->host_qid && queue->recv_queue_size > NVME_AQ_DEPTH)
		return NVME_RDMA_CM_INVALID_HSQSIZE;

During rdma connection establishment, these unvalidated sizes are passed to
nvmet_rdma_alloc_queue() within the unauthenticated rdma cm handler. This
introduces a regression where massive heap allocations are based on remote
input.

For instance, nvmet_rdma_alloc_rsps() uses the unvalidated size to loop up
to 131,072 times allocating cqe slabs and establishing dma mappings:

	int nr_rsps =3D queue->recv_queue_size * 2;
	...
	for (i =3D 0; i < nr_rsps; i++) {
		struct nvmet_rdma_rsp *rsp =3D &queue->rsps[i];
		ret =3D nvmet_rdma_alloc_rsp(ndev, rsp, i);

Similarly, nvmet_rdma_alloc_cmds() loops nr_cmds (up to 65,536) times,
allocating full memory pages via alloc_page(GFP_KERNEL) for inline data
and mapping them via dma:

	for (i =3D 0; i < nr_cmds; i++) {
		ret =3D nvmet_rdma_alloc_cmd(ndev, cmds + i, admin);

Could this allow an unauthenticated attacker to open a few concurrent
connections with large hsqsize values to trivially trigger severe memory
exhaustion and cause a denial of service?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016172336.2863=
41-3-bestswngs@gmail.com?part=3D1

