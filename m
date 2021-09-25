Return-Path: <SRS0=MUCY=OP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D69C433EF
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Sep 2021 19:55:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B368760F9B
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Sep 2021 19:55:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B368760F9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wJfgNM48rQ9CAI0i+wwthlkwqDCGDd52p5J9C93A7X0=; b=5GSN8VPNrd45zr
	J4XsRqRHeKK6UHyV664HMQtwCUcJN5hrX0ZAMWMPK8SoqfMmhUO+TlzPA64aj6gPMI3YcAku1WnyW
	tDO+SVAhDQvweyPQHETDZOsrEQG/mWMYl4W1uUf71UmrB9RAil7vFTpwZeLVBBDTGpeuwurCBmJ7o
	2qNx0kl355teHS/ao+R2At03RKRmL+eqRDeD5S4wt9vZvU6QWOKeHypTTvNk41bPLL+mMU1iWYzYB
	MBGj/GNVqXmaOcDkSepf+Eb57A3AOUaMusHQXnfRrtXMmzZ9XTpxCVTn77cOAYNxry+IGAcrD14Gj
	3mKm21NGDRPzA8NWp/cQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUDlJ-00H8zH-9t; Sat, 25 Sep 2021 19:55:05 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUDkl-00H8yk-TF
 for linux-nvme@lists.infradead.org; Sat, 25 Sep 2021 19:54:33 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id D507960F9B;
 Sat, 25 Sep 2021 19:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632599668;
 bh=ORMHJqP0QbdEHLECjFT+q180+6f7NyaNHoFvsqbPPnM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=r7Ra4GdZAVz0j60pggkrTCtQWwDoi+h7zTWzEAdTodh0ry0ScOTRlxMo5p0n7WG+e
 ll7kKjAUJDpjE1i9t7VlD13LBBdOXUejkTxv/UGIDYv79lNVALIPp/fLlXSBJ3a9Kz
 rnhASwGMa1ptOmwai5xDaWl5Vm7IRh6QSi+x0Oq+jQ2qf+dypeLzbc22WyBZM5qznB
 OJ2ZHzuaCEpiIRsu5wIKO/Hzdt2Pwn5d2owtx7DVVp2JTrqLEN4xphOgKBb04frfhQ
 z8pTqyD1or2Znykr/tA/LpxSfMKHJldXr59WD7QcbrWeh3bO9bL8y65HYzrm05VYqs
 gypXFgiwi0fSQ==
Date: Sat, 25 Sep 2021 12:54:25 -0700
From: Keith Busch <kbusch@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Aditya Garg <gargaditya08@live.com>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "james.smart@broadcom.com" <james.smart@broadcom.com>,
 "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "trivial@kernel.org" <trivial@kernel.org>
Subject: Re: [PATCH] Urgent bug fix causing Apple SSDs to not work.
Message-ID: <20210925195425.GB116968@dhcp-10-100-145-180.wdc.com>
References: <PNZPR01MB4415600ACD3C8D9944F15058B8A59@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
 <CAHk-=wgML11x9afCvmg9yhVm9wi5mvnjBvmX+i7OfMA0Vd4FWA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHk-=wgML11x9afCvmg9yhVm9wi5mvnjBvmX+i7OfMA0Vd4FWA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210925_125431_999867_641B5DCE 
X-CRM114-Status: GOOD (  26.75  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sat, Sep 25, 2021 at 11:47:08AM -0700, Linus Torvalds wrote:
> On Fri, Sep 24, 2021 at 9:02 PM Aditya Garg <gargaditya08@live.com> wrote:
> >
> > From: Aditya Garg <gargaditya08@live.com>
> > Date: Fri, 24 Sep 2021 15:36:45 +0530
> > Subject: [PATCH] Revert nvme to 5.14.5 to fix incompatibility arised in Apple SSDs.
> > Fixes: e7006de6c238 (nvme: code command_id with a genctr for use-after-free validation)
> 
> I think we need to hear more about the problem than just revert a
> commit like this randomly. That commit has already been picked up for
> -stable,
> 
> What are the exact symptoms, and which Apple SSD is this?
> 
> I do find this:
> 
>   https://lore.kernel.org/all/cjJiSFV77WM51ciS8EuBcdeBcv9T83PUB-Kw3yi8PuC_LwrrUUnQ3w5RC1PbKvSYE72KryXp3wOJhv4Ov_WWIe2gKWOOo5uwuUjbbFA8HDM=@protonmail.com/
> 
> which instead of a revert has an actual patch. Can you try that one?
> 
> Keith Busch replied to that one, saying that the Apple SSD might not
> be spec compliant, but hey, what else is new? If we start demanding
> that hardware comply with specs, we'd have to scrap the whole notion
> of working in the real world. Plus it would be very hypocritical of
> us, since we ignore all specs when we deem them too limiting (whether
> they be language specs, POSIX OS specs, or whatever).

Right, we have a lot of quirks for the apple controllers, what's one
more? :)

Could the following patch be tried? I'm basing this off the 'lspci' from
Orlando, but I'm assuming the previous model has the same limitation,
too.

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7efb31b87f37..f0787233557f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -979,6 +979,7 @@ EXPORT_SYMBOL_GPL(nvme_cleanup_cmd);
 blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
 {
 	struct nvme_command *cmd = nvme_req(req)->cmd;
+	struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
 	blk_status_t ret = BLK_STS_OK;
 
 	if (!(req->rq_flags & RQF_DONTPREP)) {
@@ -1027,7 +1028,8 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
 		return BLK_STS_IOERR;
 	}
 
-	nvme_req(req)->genctr++;
+	if (!(ctrl->quirks & NVME_QUIRK_SKIP_CID_GEN))
+		nvme_req(req)->genctr++;
 	cmd->common.command_id = nvme_cid(req);
 	trace_nvme_setup_cmd(req, cmd);
 	return ret;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9871c0c9374c..b49761d30df7 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -86,6 +86,12 @@ enum nvme_quirks {
 	 */
 	NVME_QUIRK_NO_DEEPEST_PS		= (1 << 5),
 
+	/*
+	 * The controller requires the command_id value be be limited to the
+	 * queue depth.
+	 */
+	NVME_QUIRK_SKIP_CID_GEN			= (1 << 6),
+
 	/*
 	 * Set MEDIUM priority on SQ creation
 	 */
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b82492cd7503..d9f22ed68185 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3369,7 +3369,10 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2005),
 		.driver_data = NVME_QUIRK_SINGLE_VECTOR |
 				NVME_QUIRK_128_BYTES_SQES |
-				NVME_QUIRK_SHARED_TAGS },
+				NVME_QUIRK_SHARED_TAGS ,
+				NVME_QUIRK_SKIP_CID_GEN },
+	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2006),
+		.driver_data = NVME_QUIRK_SKIP_CID_GEN },
 
 	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
 	{ 0, }
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
