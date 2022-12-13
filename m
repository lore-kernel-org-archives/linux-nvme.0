Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C3DC10F1B
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Dec 2022 19:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pbHsYNGvzVDFfPRifri/77weE9G6BwXJGfcBH0FlATs=; b=WfzjwbCZHfPH09xl9RcSD26Y80
	9BN8gCnzDZuzBDr7Rq90cJXu09W+vjC9Xz0oywyLqmv33szy8Y7+r6U3HTe7mj6i7F9Nmv/Xe/fM/
	bqfv1etTdNmPcUWio3KOsX1Bo9JvzbO8iTGiuxClbxpmaSlEphEEkoXKPU70TQrAm/jeVEiJYdEDI
	65MB3OMQBQ3hRfteIFiR8OxJ6DcelpNWJXBVmJ7YxEZ/EAwm2Axzvy3Ngw4+cZGa39ZhKZUcQ6+DC
	+5bSx/drgpCvrf2/uWmH18yCHhtJlbScgGIRNvXfyg36E1AnxU4mkpP0xmE+wt3Uut2/vRb+32+Sq
	M5OXAq6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5Anm-005DLZ-W3; Tue, 13 Dec 2022 19:18:55 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5Anj-005DKP-Kv
	for linux-nvme@lists.infradead.org; Tue, 13 Dec 2022 19:18:53 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 449FD615D1;
	Tue, 13 Dec 2022 19:18:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E9AC433F0;
	Tue, 13 Dec 2022 19:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670959130;
	bh=uSRw++TG/9t7FuHakJLBeaXuOaumSiOA7qoWYcBBbSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GUvtfFxpg4dRka26JiKuhFwR0o/4DuMLth9DtlGI+dWo+X2N505IWB1gK2f5ykqDh
	 1DdeFzsHgZ5huXvAvfjIFlJgii6GI6eCys88tCOVE0Y7VmLlUNzT0HZsNjVDvDvfl6
	 zSbkpcdLT5K8vajFD/yWk1HQNtZaxpUnsHWRWCFuzmoYnhYiSJGtOa5KZlrT322DRU
	 DecS4ZL2ii+Qu05PmK5HUpLlgwZn1+oGBmdqhaUfyfWSY3DaUkH8ITn1kTnUP/QvAi
	 wU+PhSJNuKOzk+cC8+OspiXws0nQOfE5z5f6hMT3NEQz+tyTBLXR3XJli0+GVK92TS
	 60WAYQh3X2rjw==
Date: Tue, 13 Dec 2022 12:18:47 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 6/7] nvme: also return I/O command effects from
 nvme_command_effects
Message-ID: <Y5jQF51E+/vH/5Cv@kbusch-mbp>
References: <20221213162453.584965-1-hch@lst.de>
 <20221213162453.584965-7-hch@lst.de>
 <Y5i8A84jGCnvLnbD@kbusch-mbp>
 <20221213185415.GB14596@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213185415.GB14596@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221213_111851_779510_9E9B794D 
X-CRM114-Status: GOOD (  25.48  )
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

On Tue, Dec 13, 2022 at 07:54:15PM +0100, Christoph Hellwig wrote:
> On Tue, Dec 13, 2022 at 10:53:07AM -0700, Keith Busch wrote:
> > Also nvme_cmd_write_uncorr.
> 
> Indeed.
> 
> > I think you'd need to know the namespace's command set to assume these
> > opcodes, though.
> 
> ctrl->effects always is NVM command set if supported, or otherwise
> empty for I/O commands.
> 
> > I was thinking instead of appending effects per-IO, we could always set
> > ns->head->effects even if the device doesn't support the log page, then
> > overwrite the log page's opcodes with known LBCC effects during
> > initialization. That way we don't need a per-io check. Does that sound
> > reasonable?
> 
> I'd prefer to keep OR ingin the known worst cases.  But we can do
> that at setup time.

This is what I was thinking (but please ignore that I missed the
endian conversion in this example):

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d11e0d5b231df..b8672dc28beee 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1060,39 +1060,19 @@ int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 }
 EXPORT_SYMBOL_GPL(nvme_submit_sync_cmd);
 
-static u32 nvme_known_admin_effects(u8 opcode)
-{
-	switch (opcode) {
-	case nvme_admin_format_nvm:
-		return NVME_CMD_EFFECTS_LBCC | NVME_CMD_EFFECTS_NCC |
-			NVME_CMD_EFFECTS_CSE_MASK;
-	case nvme_admin_sanitize_nvm:
-		return NVME_CMD_EFFECTS_LBCC | NVME_CMD_EFFECTS_CSE_MASK;
-	default:
-		break;
-	}
-	return 0;
-}
-
 u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode)
 {
-	u32 effects = 0;
-
 	if (ns) {
-		if (ns->head->effects)
-			effects = le32_to_cpu(ns->head->effects->iocs[opcode]);
+		u32 effects = le32_to_cpu(ns->head->effects->iocs[opcode]);
+
 		if (effects & ~(NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC))
 			dev_warn_once(ctrl->device,
 				"IO command:%02x has unhandled effects:%08x\n",
 				opcode, effects);
-		return 0;
+		return effects;
 	}
 
-	if (ctrl->effects)
-		effects = le32_to_cpu(ctrl->effects->acs[opcode]);
-	effects |= nvme_known_admin_effects(opcode);
-
-	return effects;
+	return le32_to_cpu(ctrl->effects->acs[opcode]);
 }
 EXPORT_SYMBOL_NS_GPL(nvme_command_effects, NVME_TARGET_PASSTHRU);
 
@@ -3100,6 +3080,21 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
 	return ret;
 }
 
+static void nvme_init_known_nvm_effects(struct nvme_ctrl *ctrl)
+{
+	struct nvme_effects_log	*log = ctrl->effects;
+
+	log->acs[nvme_admin_format_nvm] |= NVME_CMD_EFFECTS_LBCC |
+						NVME_CMD_EFFECTS_NCC |
+						NVME_CMD_EFFECTS_CSE_MASK;
+	log->acs[nvme_admin_sanitize_nvm] |= NVME_CMD_EFFECTS_LBCC |
+						NVME_CMD_EFFECTS_CSE_MASK;
+
+	log->iocs[nvme_cmd_write] |= NVME_CMD_EFFECTS_LBCC;
+	log->iocs[nvme_cmd_write_zeroes] |= NVME_CMD_EFFECTS_LBCC;
+	log->iocs[nvme_cmd_write_uncor] |= NVME_CMD_EFFECTS_LBCC;
+}
+
 static int nvme_init_identify(struct nvme_ctrl *ctrl)
 {
 	struct nvme_id_ctrl *id;
@@ -3113,10 +3108,21 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 		return -EIO;
 	}
 
-	if (id->lpa & NVME_CTRL_LPA_CMD_EFFECTS_LOG) {
-		ret = nvme_get_effects_log(ctrl, NVME_CSI_NVM, &ctrl->effects);
-		if (ret < 0)
-			goto out_free;
+	if (!ctrl->effects) {
+		if (id->lpa & NVME_CTRL_LPA_CMD_EFFECTS_LOG) {
+			ret = nvme_get_effects_log(ctrl, NVME_CSI_NVM,
+						   &ctrl->effects);
+			if (ret < 0)
+				goto out_free;
+		} else {
+			ctrl->effects = kzalloc(sizeof(*ctrl->effects),
+						GFP_KERNEL);
+			if (!ctrl->effects) {
+				ret = -ENOMEM;
+				goto out_free;
+			}
+		}
+		nvme_init_known_nvm_effects(ctrl);
 	}
 
 	if (!(ctrl->ops->flags & NVME_F_FABRICS))
--

