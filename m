Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 062EEC76196
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Apr 2023 11:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UBItbdeexys0Y7TB8aLFQIh+fR2xJJUYLw4y/6h7Atk=; b=iwGsy/HMwNFBbQckoYJs/zttMh
	Mb1vb1JTvDLKF+XbiTKyxtIz2LhrL3OMIf48xtg4UmxriGeMHILUHtoCXn626InCkXnCIuD2q9shm
	Oolw4xkfy27CRE3AzTSEIUU6wnBqhZ8aAX1wLILpsmqs4Tl+NIt0N1AMOt+NslitFkskNP6tjfHNe
	6jYR7GefbWzRUfY4IODW5Yhe3+xI7ueNU5TwkYd5b1MQ448bC6wsba3GMElJO3BFA+kGlkDGcL5+2
	bl7LjRdRReks/4m1D6+xidhQpuFvpKUWmn5gyl0SUlmzbtsomfimakfs1LKgYbTEM1EK5JeJf/b0V
	e8vItvUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1plpoV-00FAMp-2K;
	Mon, 10 Apr 2023 11:35:59 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1plpoR-00FALT-2Q
	for linux-nvme@lists.infradead.org;
	Mon, 10 Apr 2023 11:35:57 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230410113544epoutp028e3dcfe7f0e3f3f51da137d6619d6228~Uj69QKyPd2402124021epoutp02f
	for <linux-nvme@lists.infradead.org>; Mon, 10 Apr 2023 11:35:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230410113544epoutp028e3dcfe7f0e3f3f51da137d6619d6228~Uj69QKyPd2402124021epoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1681126544;
	bh=UBItbdeexys0Y7TB8aLFQIh+fR2xJJUYLw4y/6h7Atk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HWFurj2+bF9czbCSuU8S5DYPb/gBa9FLmVZbK2P89YYqq6u9rOYTK1ttssXg/n+9G
	 FOfzWChflZaRJjuqHCV3a1VKhYlr3zSRcRygrNBPuyQArJSasGD8y1Dh7fY1JeOFf6
	 LBLQsuk6r2GLL9rFKHZKlFiJ3muJ4t6F7+f1YCJY=
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20230410113543epcas5p185f0673b416991f3f969dc3e19d1a058~Uj68w0Oyz0539905399epcas5p1y;
	Mon, 10 Apr 2023 11:35:43 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230410113543epsmtrp29bd6afde8c77983730b062df021887b8~Uj68wP4lx0546705467epsmtrp2_;
	Mon, 10 Apr 2023 11:35:43 +0000 (GMT)
Received: from green5 (unknown [107.110.206.5]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20230410113542epsmtip16fa219f71981e7b73d3b24faca822c9b~Uj67pzSAj0276502765epsmtip1N;
	Mon, 10 Apr 2023 11:35:42 +0000 (GMT)
Date: Mon, 10 Apr 2023 17:04:58 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	io-uring@vger.kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 3/5] nvme: unify nvme request end_io
Message-ID: <20230410113458.GB16047@green5>
MIME-Version: 1.0
In-Reply-To: <20230407191636.2631046-4-kbusch@meta.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CMS-MailID: 20230410113543epcas5p185f0673b416991f3f969dc3e19d1a058
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----w2jaHPLYrpKrCfQkcJ8LedpAWTKxgBVMFdZj2Hgt3-WHfK.r=_5832_"
CMS-TYPE: 105P
X-CMS-RootMailID: 20230407191710epcas5p285a50b90f4be2d782512bb4296ef6e20
References: <20230407191636.2631046-1-kbusch@meta.com>
	<CGME20230407191710epcas5p285a50b90f4be2d782512bb4296ef6e20@epcas5p2.samsung.com>
	<20230407191636.2631046-4-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230410_043556_169932_D61FF68D 
X-CRM114-Status: GOOD (  11.64  )
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

------w2jaHPLYrpKrCfQkcJ8LedpAWTKxgBVMFdZj2Hgt3-WHfK.r=_5832_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Fri, Apr 07, 2023 at 12:16:34PM -0700, Keith Busch wrote:
>From: Keith Busch <kbusch@kernel.org>
>
>We can finish the metadata copy inline with the completion. After that,
>there's really nothing else different between the meta and non-meta data
>end_io callbacks, so unify them.
>
>Signed-off-by: Keith Busch <kbusch@kernel.org>
>---
> drivers/nvme/host/ioctl.c | 57 +++++++--------------------------------
> 1 file changed, 9 insertions(+), 48 deletions(-)
>
>diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
>index 278c57ee0db91..a1e0a14dadedc 100644
>--- a/drivers/nvme/host/ioctl.c
>+++ b/drivers/nvme/host/ioctl.c
>@@ -465,29 +465,6 @@ static inline struct nvme_uring_cmd_pdu *nvme_uring_cmd_pdu(
> 	return (struct nvme_uring_cmd_pdu *)&ioucmd->pdu;
> }
>
>-static void nvme_uring_task_meta_cb(struct io_uring_cmd *ioucmd,
>-				    unsigned issue_flags)
>-{
>-	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
>-	struct request *req = pdu->req;
>-	int status;
>-	u64 result;
>-
>-	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
>-		status = -EINTR;
>-	else
>-		status = nvme_req(req)->status;
>-
>-	result = le64_to_cpu(nvme_req(req)->result.u64);
>-
>-	if (pdu->meta_len)
>-		status = nvme_finish_user_metadata(req, pdu->u.meta_buffer,
>-					pdu->u.meta, pdu->meta_len, status);
>-	blk_mq_free_request(req);
>-
>-	io_uring_cmd_done(ioucmd, status, result, issue_flags);
>-}
>-
> static void nvme_uring_task_cb(struct io_uring_cmd *ioucmd,
> 			       unsigned issue_flags)
> {
>@@ -502,11 +479,16 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
> 	struct io_uring_cmd *ioucmd = req->end_io_data;
> 	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
> 	void *cookie = READ_ONCE(ioucmd->cookie);
>+	int status = nvme_req(req)->status;
>
> 	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
>-		pdu->nvme_status = -EINTR;
>-	else
>-		pdu->nvme_status = nvme_req(req)->status;
>+		status = -EINTR;
>+
>+	if (pdu->meta_len)
>+		status = nvme_finish_user_metadata(req, pdu->u.meta_buffer,
>+					pdu->u.meta, pdu->meta_len, status);

nvme_finish_user_metadata does copy_to_user.
Here also the attempt was not to touch that memory in interrupt context.

------w2jaHPLYrpKrCfQkcJ8LedpAWTKxgBVMFdZj2Hgt3-WHfK.r=_5832_
Content-Type: text/plain; charset="utf-8"


------w2jaHPLYrpKrCfQkcJ8LedpAWTKxgBVMFdZj2Hgt3-WHfK.r=_5832_--

