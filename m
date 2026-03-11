Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61459FD88C2
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Mar 2026 09:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z1gXiPTSuDVE28qOv2C5XW2DkFFIFhlspiEOZZiL4kU=; b=RVPS0j4d3Fg12savbBgvGxt2UR
	0330Vlvo8hDLDBlwh5ItZ5fvLHIWF7kvV7TgqjrSzGJpMCKSyuWa3FJL4g1kvNwChxe7QLHdd3+9a
	v8gfbISNF7fd9FtZcOrNxTXwUajwfIKM2ORQL3xSiw2pwdBYBo+xtAH+tVa7p4uD/OlVYzuc7pWkw
	UGluxZuaQ4CTVK7I9X9Gc0pYz/b++jdCU3jCd9pcU67O4xpZEl//6Sj35Ys54VNmWFNrgblCCwalL
	Qp3DdAGXurrfhTCE+fB/mKF9+533jHgoVlkmEs302iBlZgCgr7gu/H9GCjmyQfBMnGaLhRhV36bSv
	sx3heF6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0FSZ-0000000BDZi-15h2;
	Wed, 11 Mar 2026 09:02:31 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0FST-0000000BDYe-1xou
	for linux-nvme@lists.infradead.org;
	Wed, 11 Mar 2026 09:02:30 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 7f0d0655 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Mar 2026 10:02:21 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Mar 2026 10:02:21 +0100
Message-Id: <DGZTXRKSHBPC.2B318HF53ZRSN@arkamax.eu>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "nbd@other.debian.org" <nbd@other.debian.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>
Subject: Re: blktests failures with v7.0-rc1 kernel
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Maurizio Lombardi" <mlombard@arkamax.eu>, "Yi Zhang"
 <yi.zhang@redhat.com>, "Shinichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
X-Mailer: aerc 0.21.0
References: <aZ_-cH8euZLySxdD@shinmob>
 <CAHj4cs8mzSZez+n2qLu5931YAuQ4=RxNt6D6YJCsMEwGrm4UtA@mail.gmail.com>
 <DGZRYXTKC049.1I6QFQSMSD88H@arkamax.eu>
In-Reply-To: <DGZRYXTKC049.1I6QFQSMSD88H@arkamax.eu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260311_020225_845034_39519F3E 
X-CRM114-Status: UNSURE (   4.97  )
X-CRM114-Notice: Please train this message.
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed Mar 11, 2026 at 8:29 AM CET, Maurizio Lombardi wrote:
> On Wed Mar 11, 2026 at 1:35 AM CET, Yi Zhang wrote:
>
> If nvmet_rdma_rw_ctx_init() fails, shouldn't it call
> nvmet_req_free_sgls() before returning an error?

Possible fix, not tested:

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 2d6eb89f98af..79ae743bb405 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -892,7 +892,7 @@ static u16 nvmet_rdma_map_sgl_keyed(struct nvmet_rdma_r=
sp *rsp,

 	ret =3D nvmet_rdma_rw_ctx_init(rsp, addr, key, &sig_attrs);
 	if (unlikely(ret < 0))
-		goto error_out;
+		goto error_free_sgl;
 	rsp->n_rdma +=3D ret;

 	if (invalidate)
@@ -900,6 +900,8 @@ static u16 nvmet_rdma_map_sgl_keyed(struct nvmet_rdma_r=
sp *rsp,

 	return 0;

+error_free_sgl:
+	nvmet_req_free_sgls(&rsp->req);
 error_out:
 	rsp->req.transfer_len =3D 0;
 	return NVME_SC_INTERNAL;

Maurizio

