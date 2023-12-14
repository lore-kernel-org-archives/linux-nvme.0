Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F2AC4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Dec 2023 22:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K9LXU3is+IJ/FA2WLEo3Morjs3r0CReNzWjYTp8T0b0=; b=qORqR0x5fCb2Tn3D4MAh00yGI6
	Rg7sDuvKWEExmD6GE1AmT2BJt7Pborg0rvwAhbpJjNXKbStNghAqiby/w/G9OMNZtAO6xz3AXivB7
	4ptv3Jdz1AxmsD+l8bdCpT/RDg0OC5R04dk0DdADtqJy2aCzfi7uawhxq6LtMyKAsJf/wuCEv3n6Q
	luegmJVDp10Cj7pXWMvel3EXGiBdlkM39zYoBuPeIuDLpIzAgphq6WaY66QHYaTpIHeyQy9X7/sOF
	Byp9Mmco1ZI2Sm7HVW/Xu/hRpoMsJUrEERLyTIJswfA5AWAdW5GHLkBXFccRuIsCXN+rJSWdyOMbs
	rHtMtduQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDuWp-001UXI-2L;
	Thu, 14 Dec 2023 22:50:03 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDuWl-001UV0-1u
	for linux-nvme@lists.infradead.org;
	Thu, 14 Dec 2023 22:50:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 1D454CE223E;
	Thu, 14 Dec 2023 22:49:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDAB2C433C8;
	Thu, 14 Dec 2023 22:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702594196;
	bh=wyU0Fm9SOSd3j+OhfeqLs4fQpW/XmDPEDEOLYCp/Gm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MJB0ONvX8EKumio3sThaYHRwmtmP2Nisin3Y6NePuOHFSpcTnDVi9ma/0pO3dbX7q
	 cThXQnhgCOi2x6GNbRNo47kgjdWC/S88kStmm3qAaqzh2igCQ5qwFTYR5JrLoaTg2p
	 ln3MUEgbSSzTUqDvlldNBE1UMZUQnXifh7zQS0nm+e6mRcBfguHkuaWJXuoV9ki4J0
	 m3DE3wSzHObtCZFRQcY4AAvSzIoB32YjujIKysKqPWN/EPsYwOG+Ff6EQFJsHqzxwH
	 tavM6A9hZ7bSpVOiQRn2OnP17X4B7ts+v44hamBk1enwobcjRafrMTS9+WQxLKVY0p
	 BS/u6vwYC/ADw==
Date: Thu, 14 Dec 2023 14:49:54 -0800
From: Keith Busch <kbusch@kernel.org>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Kamaljit Singh <Kamaljit.Singh1@wdc.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: parallel nvme format
Message-ID: <ZXuGkmdgXwFKB_cY@kbusch-mbp>
References: <ZXsJdJxDXEbCmSec@x1-carbon>
 <ZXs5B8pYKTBLD1NH@kbusch-mbp>
 <ZXtx2EOnRUMLSjcu@x1-carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXtx2EOnRUMLSjcu@x1-carbon>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231214_144959_970239_CB6A54E9 
X-CRM114-Status: GOOD (  17.89  )
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

On Thu, Dec 14, 2023 at 09:21:28PM +0000, Niklas Cassel wrote:
> Perhaps we could introduce a new bit, NVME_CTRL_NEEDS_SCAN or similar?
> (That gets cleared by nvme_scan_work(), after a scan has been performed.)

Good point. Updated patch below.
 
> I guess for format command specifically, we already have
> NVME_AER_NOTICE_NS_CHANGED, but that seems to be cleared before by
> nvme_scan_work() before the mutex is acquired.

The clearing should just re-arm the controller to send the AER again if
any other namespace changes. But we can't really depend on the AER
anyway.

> And I'm not sure if all command that have
> effects & (NVME_CMD_EFFECTS_NIC | NVME_CMD_EFFECTS_NCC)
> set will trigger a NVME_AER_NOTICE_NS_CHANGED AEN.

We have the "known_effects" for the format command to ensure the driver
will always request a rescan on a format no matter what a controller
reports, but yeah, the format could be followed up by another command
with NVME_CMD_EFFECTS_CSE_MASK set without NIC/NCC, so definitely need
to retain the need to restart the scan.

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 590cd4f097c22..0b062a2268447 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1120,6 +1120,8 @@ u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode)
 		nvme_start_freeze(ctrl);
 		nvme_wait_freeze(ctrl);
 	}
+	if (effects & (NVME_CMD_EFFECTS_NIC | NVME_CMD_EFFECTS_NCC))
+		set_bit(NVME_CTRL_NEEDS_RESCAN, &ctrl->flags);
 	return effects;
 }
 EXPORT_SYMBOL_NS_GPL(nvme_passthru_start, NVME_TARGET_PASSTHRU);
@@ -1140,7 +1142,7 @@ void nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u32 effects,
 "controller capabilities changed, reset may be required to take effect.\n");
 		}
 	}
-	if (effects & (NVME_CMD_EFFECTS_NIC | NVME_CMD_EFFECTS_NCC)) {
+	if (test_bit(NVME_CTRL_NEEDS_RESCAN, &ctrl->flags)) {
 		nvme_queue_scan(ctrl);
 		flush_work(&ctrl->scan_work);
 	}
@@ -3945,7 +3947,14 @@ static void nvme_scan_work(struct work_struct *work)
 		nvme_clear_changed_ns_log(ctrl);
 	}
 
-	mutex_lock(&ctrl->scan_lock);
+	/*
+	 * Failure to acquire scan_lock means another thread will requeue this
+	 * work shortly
+	 */
+	if (!mutex_trylock(&ctrl->scan_lock))
+		return;
+
+	clear_bit(NVME_CTRL_NEEDS_RESCAN, &ctrl->flags);
 	if (nvme_ctrl_limited_cns(ctrl)) {
 		nvme_scan_ns_sequential(ctrl);
 	} else {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 39a90b7cb1254..79a71b6ae64fe 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -251,6 +251,7 @@ enum nvme_ctrl_flags {
 	NVME_CTRL_STOPPED		= 3,
 	NVME_CTRL_SKIP_ID_CNS_CS	= 4,
 	NVME_CTRL_DIRTY_CAPABILITY	= 5,
+	NVME_CTRL_NEEDS_RESCAN		= 6,
 };
 
 struct nvme_ctrl {
--

