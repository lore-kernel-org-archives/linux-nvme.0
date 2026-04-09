Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D9EF31E21
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Apr 2026 14:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=horXWfZCMvh+S4TT3Nno4kg77HU7PxJnupVD4Qao600=; b=zzcum9UJN+BWuwcUyB0T0R8jg3
	BguNibXEk17Ncuvmf0cbsj+vMPAioCOyci+VeG7TaO/+GfE8QtXn/tRiWH3COgpI26yZOvGIjzFJH
	SFpHU/GpDlIg1+6o0mPxuE8abS3ficCHHLW08hAJxKhEJm/gHkFBQLYF0gO5OeKE7RFhtCGUzWUVJ
	k+vs5/7JppJJmQmUc9BtTjqN69H0b3O2QPCphxgTxUmTUIwIXOWmxgnw+vmea9/h7bRujjFBQw28l
	aKAHSr4/8jvhYbcJIihtzyJ8MNN+VSZManXfJZbowbefabTVmKkQxuYKkVAvVYd/hV3FS1u0GDdqS
	C97FPGHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAqVC-0000000AiN5-1rhf;
	Thu, 09 Apr 2026 14:37:02 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAqV9-0000000AiMK-1Cq1
	for linux-nvme@lists.infradead.org;
	Thu, 09 Apr 2026 14:37:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 82D18419EB;
	Thu,  9 Apr 2026 14:36:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B80C4CEF7;
	Thu,  9 Apr 2026 14:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775745418;
	bh=I5Dk9ziTDun9hPjKv6l5CO2hNNvIjdHDsWHMdzw64K8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H/6lGxiF4ozC1vcnCHb/HpDYhjldlHBApBSBeHMoCX4+OBndzwONU7OZazEOf/tPB
	 egEhfCBnQTKQ5wyILckDcFQLThoTIhc74/fOmG4z5DCldclhDmEH0a81EHY5LGd9uJ
	 ghbdHsI8RhjfxivdeXRutGepe0XXjpzZNeuZIua5pHx93rervamoVUzt3jzv/ts/J+
	 6v+6duARpjdBnAvkznfNYFUOb5tLWycPNMxOxWAS1w5UkK6lhwTXANrl7QWmw7D2Cs
	 PeSk39Xo0Y6OlPhRW88xW2pdOaHmCjid7fHVOyVKBTqlC/bIVGD0t7PM+uUYcHVFHe
	 i05DCVxwSz9Rw==
Date: Thu, 9 Apr 2026 08:36:56 -0600
From: Keith Busch <kbusch@kernel.org>
To: AlanCui4080 <me@alancui.cc>
Cc: linux-nvme@lists.infradead.org
Subject: Re: Non-SGL transport mode warnings are set to dev_warn_once will
 cause confusion
Message-ID: <ade5iAP4y94z0JDL@kbusch-mbp>
References: <4770779.LvFx2qVVIh@alanarchdesktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4770779.LvFx2qVVIh@alanarchdesktop>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260409_073659_566634_FB78B339 
X-CRM114-Status: GOOD (  19.60  )
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

On Thu, Apr 09, 2026 at 04:46:37PM +0800, AlanCui4080 wrote:
> See 6fad84a (nvme-pci: use sgls for all user requests if possible). In the 
> kernel, those warnings are printed using `dev warn once`. This means that if 
> multiple devices in the system do not support SGLs (most consumer-grade 
> devices do not support them), only one warning for only one device will be 
> printed.
> 
> This asymmetry can be misleading to users. If all devices in the system report 
> the same issue, it might not be a problem, but if only one device reports it, 
> it might (especially since I have two identical drives). Is it possible to 
> move this warning to the device initialization phase so print it for each 
> device? Or, since we cannot resolve the issue of consumer-grade devices not 
> supporting SGL, should it be downgraded to an informational warning?

Fine with me. The warning was added in response to people filing CVE's
against the driver as a sort of acknowledgement that yeah, this
interface can't validate transfer lengths under these conditions, so
we're trusting the user isn't abusing it. A sort of nudge that perhaps
controller vendors might consider supporting the safer option.

Anyway, it's fine with me to move the message and make it less scary.
How about this:

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b42d8768d2979..b6aec0e3fbfb8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3744,6 +3744,10 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl, bool was_suspended)
 		ret = nvme_hwmon_init(ctrl);
 		if (ret == -EINTR)
 			return ret;
+
+		if (!nvme_ctrl_sgl_supported(ctrl))
+			dev_info(ctrl->device,
+				"passthrough uses implicit buffer lengths\n");
 	}
 
 	clear_bit(NVME_CTRL_DIRTY_CAPABILITY, &ctrl->flags);
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 8844bbd395159..e9eecdd54d5ed 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -125,16 +125,8 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 	struct bio *bio = NULL;
 	int ret;
 
-	if (!nvme_ctrl_sgl_supported(ctrl))
-		dev_warn_once(ctrl->device, "using unchecked data buffer\n");
-	if (has_metadata) {
-		if (!supports_metadata)
-			return -EINVAL;
-
-		if (!nvme_ctrl_meta_sgl_supported(ctrl))
-			dev_warn_once(ctrl->device,
-				      "using unchecked metadata buffer\n");
-	}
+	if (has_metadata && !supports_metadata)
+		return -EINVAL;
 
 	if (iter)
 		ret = blk_rq_map_user_iov(q, req, NULL, iter, GFP_KERNEL);
--

