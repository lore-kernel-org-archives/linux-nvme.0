Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DAF6C27C4F
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Jun 2024 16:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3sB53YVX+rK6dUx6EvHnPX23LIsqxotuE4zZ0MxS4mo=; b=14w8fMWkxFlA/jnjaTnH+X6K4I
	A//cMJcuTEcv76+/fWvzH2ExzQDZEd0xp9To8v6l2CMmmi0LRZxUu4KdmojL37mW1NxI9V6QmYKXI
	j/nnK7vn3w8CMqnot6sU+coiCpM++Q888XWA972g3vTDMsym0UbOqT9kjNcEtfuwNXaCJ1rnITgxx
	zzUhj/jibPNMP60Cwp8gGAENRaxtp7AHWSDG3Eco4vrmYeRCmCef/GSz9uPYx3N0pzzHbrdW4og1T
	k7xrML3uZQdZS9UYJv36U+PvzsmHWVhLgeu64uq1KEAb4g1RUAGhXxkxutclVt5O03hkH4QgDYpJ5
	xJOWRhHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKhGw-00000009wCG-2pam;
	Fri, 21 Jun 2024 16:37:58 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKhGt-00000009wBs-3149
	for linux-nvme@lists.infradead.org;
	Fri, 21 Jun 2024 16:37:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0CD706243B;
	Fri, 21 Jun 2024 16:37:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E6CC2BBFC;
	Fri, 21 Jun 2024 16:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718987873;
	bh=Zq33N7S7xl0nRkY2EtxZg1KZYnJ8b9zPaYA9ahus2K4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fTdOcevtlQjBNhRsDEk3H5kHPQt4pEY3owXmEs5cUo92OxCBjW/+Iadq49NW6GYlU
	 VU4a3Zo/YzJqp81Fz6VRONwq8v592+TDZNriHwo3IBZi4VK3d+54v8y/V+cGnUXye2
	 ha6ieiLHarGKv/Yji3oDlb6eavUWN+Kp2C9iqERg8e7qu8fYQDG1QRyA1WOO6RcfF9
	 nI1cUla5S8SUWJjctZHDGBD9opvF6y4TJaLy/6rWtRDuGiaEA3KaOpW71rkkd8DgFK
	 0mAO3ym2ej1lkR4nBu06nCZwT7duNW/eOYL26oM37lW4fGmbkEUu/GMPTeE7Wns5Jy
	 ae4l5RkE+o0+Q==
Date: Fri, 21 Jun 2024 10:37:50 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	gjoyce@linux.ibm.com, axboe@fb.com
Subject: Re: [PATCH v3 1/1] nvme-pci : Fix EEH failure on ppc after subsystem
 reset
Message-ID: <ZnWsXmRdCCgMwL5V@kbusch-mbp>
References: <20240604091523.1422027-1-nilay@linux.ibm.com>
 <20240604091523.1422027-2-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604091523.1422027-2-nilay@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240621_093756_236817_3815C5A9 
X-CRM114-Status: GOOD (  22.18  )
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

On Tue, Jun 04, 2024 at 02:40:04PM +0530, Nilay Shroff wrote:
> The NVMe subsystem reset command when executed may cause the loss of
> the NVMe adapter communication with kernel. And the only way today
> to recover the adapter is to either re-enumerate the pci bus or
> hotplug NVMe disk or reboot OS.
> 
> The PPC architecture supports mechanism called EEH (enhanced error
> handling) which allows pci bus errors to be cleared and a pci card to
> be rebooted, without having to physically hotplug NVMe disk or reboot
> the OS.
> 
> In the current implementation when user executes the nvme subsystem
> reset command and if kernel loses the communication with NVMe adapter
> then subsequent read/write to the PCIe config space of the device
> would fail. Failing to read/write to PCI config space makes NVMe
> driver assume the permanent loss of communication with the device and
> so driver marks the NVMe controller dead and frees all resources
> associate to that controller. As the NVMe controller goes dead, the
> EEH recovery can't succeed.
> 
> This patch helps fix this issue so that after user executes subsystem
> reset command if the communication with the NVMe adapter is lost and
> EEH recovery is initiated then we allow the EEH recovery to forward
> progress and gives the EEH thread a fair chance to recover the
> adapter. If in case, the EEH thread couldn't recover the adapter
> communication then it sets the pci channel state of the erring
> adapter to "permanent failure" and removes the device.

I think the driver is trying to do too much here by trying to handle the
subsystem reset inline with the reset request. It would surely fail, but
that was the idea because we had been expecting pciehp to re-enumerate.
But there are other possibilities, like your EEH, or others like DPC and
AER could do different handling instead of a bus rescan. So, perhaps the
problem is just the subsystem reset handling. Maybe just don't proceed
with the reset handling, and it'll be fine?

---
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 68b400f9c42d5..97ed33d9046d4 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -646,9 +646,12 @@ static inline void nvme_should_fail(struct request *req) {}
 
 bool nvme_wait_reset(struct nvme_ctrl *ctrl);
 int nvme_try_sched_reset(struct nvme_ctrl *ctrl);
+bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
+		enum nvme_ctrl_state new_state);
 
 static inline int nvme_reset_subsystem(struct nvme_ctrl *ctrl)
 {
+	u32 val;
 	int ret;
 
 	if (!ctrl->subsystem)
@@ -657,10 +660,10 @@ static inline int nvme_reset_subsystem(struct nvme_ctrl *ctrl)
 		return -EBUSY;
 
 	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_NSSR, 0x4E564D65);
-	if (ret)
-		return ret;
-
-	return nvme_try_sched_reset(ctrl);
+	nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE);
+	if (!ret)
+		ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &val);
+	return ret;
 }
 
 /*
@@ -786,8 +789,6 @@ blk_status_t nvme_host_path_error(struct request *req);
 bool nvme_cancel_request(struct request *req, void *data);
 void nvme_cancel_tagset(struct nvme_ctrl *ctrl);
 void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl);
-bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
-		enum nvme_ctrl_state new_state);
 int nvme_disable_ctrl(struct nvme_ctrl *ctrl, bool shutdown);
 int nvme_enable_ctrl(struct nvme_ctrl *ctrl);
 int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
--

