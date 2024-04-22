Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131B4C4345F
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Apr 2024 14:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cG5O23soF8VrsxU2c8XdHLVZl/5BWhlfpIrLFAlNHek=; b=E14dKUYJQIZNg1sv5YEbRZZh6Y
	bu1cRdelwhVv+zVnlXz5cTEHiYgONQx58jpFcmoRS9+A2yTjgLo7vHq+0bnPRfgp6GMFYv1wt1+Uc
	/mp8D5JHTthvh5/RNT6Jj0fsXErXw7PtpJ0lDD317VMZ0X9kX2NBY/df4+BIcrqYVYZ1NIceZ3IQ3
	tOBJro5JBWFID8iIqX9beAWX8BQOuF0Z+7ka4CoDycpoxBcnT0U/pxU7/cIrZiv2jxZc+UjlH2Dk/
	Hz/AHPEt/KZDCEkjQC//5Dt38BwA0NuoYQzLP5BhFoPH+GtsJHJr3KXB/c87OimNjhh3CidUwCUdD
	RGHQoLFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryulE-0000000DwgL-0Cda;
	Mon, 22 Apr 2024 14:35:12 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryulB-0000000Dweq-39Pd
	for linux-nvme@lists.infradead.org;
	Mon, 22 Apr 2024 14:35:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 50D4760ECD;
	Mon, 22 Apr 2024 14:35:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FEC6C4AF0D;
	Mon, 22 Apr 2024 14:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713796507;
	bh=hpUO8Zq7ERz08WWuWxoY599Ya6Smi8/0bj3QcQz8uLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hTSPnxqKKCNyb3TmSpxmVyVxab6X/yBGj8bYB5BeUJXTiU/GckNizdJoNmRzse2Tq
	 /LmPhK6EmsgPs8SG0z3VKNo3X0kzq6quK1Y5U68Oy97S2Appps0767ohah+Ur/YhWU
	 /b8U64fK1RymGkM3RyglMYYlabnHGmRQnHW0Yj6HVLcUYRD6OkHWpdqQKuIoIZSjdR
	 0bcB5f1K65ncPuRsJYiXOpZDGew8X2eNQDLZHWsDB6rQja2gAYw1tYwpAXqXMjCIS7
	 w99Bpdk5uB8yQOypY4mSRbKBkB9ZkakhJQ3GVPO9NYbxfMXezPCmPHq3b0QRMqEPxM
	 cJOyiZ1i+8ZCQ==
Date: Mon, 22 Apr 2024 08:35:04 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Christoph Hellwig <hch@lst.de>, "axboe@fb.com" <axboe@fb.com>,
	Gregory Joyce <gjoyce@ibm.com>,
	Srimannarayana Murthy Maram <msmurthy@imap.linux.ibm.com>
Subject: Re: [Bug Report] PCIe errinject and hot-unplug causes nvme driver
 hang
Message-ID: <ZiZ1mB0pE6lBrJkN@kbusch-mbp.dhcp.thefacebook.com>
References: <199be893-5dfa-41e5-b6f2-40ac90ebccc4@linux.ibm.com>
 <579c82da-52a7-4425-81d7-480c676b8cbb@grimberg.me>
 <d33a5681-b195-4258-8eee-e0eae46ade5b@linux.ibm.com>
 <627cdf69-ff60-4596-a7f3-0fdd0af0f601@grimberg.me>
 <ZiZrmSW6s7lY7j98@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZiZrmSW6s7lY7j98@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240422_073509_858420_FBC730B9 
X-CRM114-Status: GOOD (  21.49  )
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

On Mon, Apr 22, 2024 at 07:52:25AM -0600, Keith Busch wrote:
> On Mon, Apr 22, 2024 at 04:00:54PM +0300, Sagi Grimberg wrote:
> > > pci_rescan_remove_lock then it shall be able to recover the pci error and hence
> > > pending IOs could be finished. Later when hot-unplug task starts, it could
> > > forward progress and cleanup all resources used by the nvme disk.
> > > 
> > > So does it make sense if we unconditionally cancel the pending IOs from
> > > nvme_remove() before it forward progress to remove namespaces?
> > 
> > The driver attempts to allow inflights I/O to complete successfully, if the
> > device
> > is still present in the remove stage. I am not sure we want to
> > unconditionally fail these
> > I/Os.    Keith?
> 
> We have a timeout handler to clean this up, but I think it was another
> PPC specific patch that has the timeout handler do nothing if pcie error
> recovery is in progress. Which seems questionable, we should be able to
> concurrently run error handling and timeouts, but I think the error
> handling just needs to syncronize the request_queue's in the
> "error_detected" path.

This:

---
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8e0bb9692685d..38d0215fe53fc 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1286,13 +1286,6 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
 	u32 csts = readl(dev->bar + NVME_REG_CSTS);
 	u8 opcode;
 
-	/* If PCI error recovery process is happening, we cannot reset or
-	 * the recovery mechanism will surely fail.
-	 */
-	mb();
-	if (pci_channel_offline(to_pci_dev(dev->dev)))
-		return BLK_EH_RESET_TIMER;
-
 	/*
 	 * Reset immediately if the controller is failed
 	 */
@@ -3300,6 +3293,7 @@ static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
 			return PCI_ERS_RESULT_DISCONNECT;
 		}
 		nvme_dev_disable(dev, false);
+		nvme_sync_queues(&dev->ctrl);
 		return PCI_ERS_RESULT_NEED_RESET;
 	case pci_channel_io_perm_failure:
 		dev_warn(dev->ctrl.device,
--

