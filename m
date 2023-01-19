Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A2DFC004D4
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Jan 2023 16:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dIyPRgIDUhMiRlxzFHo4rUEdOiQaPuaFWtkL56o8cEk=; b=0l0aKO6AdpEQNlngQdiCzTXYgs
	mnYtbiaHz8F5SIFNlAwBu69WdMhfJG72UQji+nHdgdhTpJYWPaMqMB5ZLVk+9De19XmX+PafKR1vv
	11ZFwrBLKw6SNhHS7YOeZumWJSfWEt6+ysFlEsi2YSA70J0JaywhcakbakES/w79a8Jqh2qBo1pLC
	Gb8QvYXHw+HO/TDCIMwNHgPWX1xguxvHf6gg7MTCIpCg7oHXTHiWO1QBy5n2FCHieG6JEn8OOeGM7
	o7bLg39Z+P+qbolV3j4NS7mL28MqAfijaUwabn8s2+qtZwnza8nnvu2JZ707MqOa/7G0txbBTrfDh
	2S2Wc5hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIY65-0065ln-6J; Thu, 19 Jan 2023 16:49:05 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIY61-0065l6-Rg
	for linux-nvme@lists.infradead.org; Thu, 19 Jan 2023 16:49:03 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 604D761CBF;
	Thu, 19 Jan 2023 16:49:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A15C433D2;
	Thu, 19 Jan 2023 16:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674146939;
	bh=ay0Zt/DVdmWEpoJIkbEHkl5DZpvrjQjuK8WtoM45jMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CG5RdnFqmkh/QFUyNL9Mv2Bx/eu+txGvUPxeOZjd+W7zzpbUMoLGYwaTFHeRsUYIq
	 b1V0JdztzFFYGGWrTTTFssCj4AIjnTNG3jT+WRjRuokV4rb1ViWIK+kkHm3zQFhCV5
	 KrqtROjEoAmeSieRs87dKrQRrwpHjsX0Q92ishdFQkzeBfsJqDmv+R7viYtOTiuyDJ
	 9EtQ51C3c/vc7CRAlsb6XF7dOO60lklFruJQxzw8Ya11qbM6fXsLMVe7h3PZEuTB70
	 d5X5rqzCnRLDPRbKOkrvaQtERmScNffkh9qSkmHSTb/c9Yp4KuhnO5VA00Kgno/QYB
	 fZ0BzHKeQlj9A==
Date: Thu, 19 Jan 2023 09:48:56 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Klaus Jensen <its@irrelevant.dk>, Jens Axboe <axboe@fb.com>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: regression on aarch64? panic on boot
Message-ID: <Y8l0ePagRXDHQByr@kbusch-mbp>
References: <Y8XINx8fpGPKudW6@cormorant.local>
 <20230117055819.GB13795@lst.de>
 <Y8ZA30EoAFaFPwVC@cormorant.local>
 <20230117063735.GA14468@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117063735.GA14468@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230119_084901_975420_9FA8A5D5 
X-CRM114-Status: GOOD (  17.82  )
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

On Tue, Jan 17, 2023 at 07:37:35AM +0100, Christoph Hellwig wrote:
> On Tue, Jan 17, 2023 at 07:31:59AM +0100, Klaus Jensen wrote:
> > Good morning Christoph,
> > 
> > Yep, the above works.
> 
> Context for the newly added: This is dropping the newly added
> PROBE_PREFER_ASYNCHRONOUS in nvme, which causes Klaus' arm64 (but not
> other boot tests) to fail.  Any idea what could be going wrong there
> probably in userspace?

Prior to 6.2, the driver would do it's own async_schedule, and that
async probe function would flush the first scan work.
wait_for_device_probe() was then forced to wait for the scan_work to
complete, which brings up the root device.

We're not flushing the scan_work anymore from our probe, so this should
fix it for 6.2:

---
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b294b41a149a7..ff97426749976 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3046,6 +3046,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)

        nvme_start_ctrl(&dev->ctrl);
        nvme_put_ctrl(&dev->ctrl);
+       flush_work(&dev->ctrl.scan_work);
        return 0;

 out_disable:
--

