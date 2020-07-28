Return-Path: <SRS0=l2Ft=BH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D63EC433E1
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 11:08:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 169FA20656
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 11:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rxf/0ago";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y/14gHZV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 169FA20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MouN5t7ON+XT4K/VMjJx8X+eVo3P7sV10cd8gQK/AJ8=; b=rxf/0agoOPx76fRbECIQQ8R86
	EQtVF4F1sfD1Vc16qORrxCRf9jITCnr6IR9HaSwY5dOlTcWiRdijaF4PZdHjvS5Ugwc+VVXbHkFbS
	RLiw106FFnSDDVupwC1bIZpTJWa+VpwHtgabmh8kHF1jlvyk82eQx6Y94n1OMuRFyk7JzkrAB0KCF
	dntAhWkoy8hU4aUuwgnwyVfHh8CaljRyZ1zHgNG3kapnHxoEl0qK7IWpZACvT6IL8fGTtvDQPehLq
	KDiLIQ54kjDE/ClMXQYQuJDX2g8Zd1Cmij+9HMMXxSoMBt1IAOgGr0ZKSOxjCy4T40TFjodureZOq
	DitonOwjQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0NTD-0006zv-8S; Tue, 28 Jul 2020 11:08:31 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0NTA-0006yq-Ad
 for linux-nvme@merlin.infradead.org; Tue, 28 Jul 2020 11:08:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=9IwCAOPcpAZxf8tyH1NZz7jwY7AKIW8ROYNTuoLNF+k=; b=Y/14gHZVn5uVCEzwnxG++MTq1c
 roGngRqEQ7dlvMOjH77Rx5viGrEmFDznfVsfpl0J8oXuqDg3yJaqTHXhXrIvqT3Xqts4nWXcSw5Bg
 7y4UK/KVKj2yQHY1XqudDDHVJQTerz//RMhWz1NYFJp4x4P3A80SUed2XWG1wiwLg+0NBMQJT9c93
 a49I+eYEcmGlGbrK0CjpujVmVN1+z/owQneEdvYPAo/E45fhpVsMwA2YwvRXqZ/nidKj82Y3YJ9lN
 m+vC6+/+5laiAetEQ/jUO//rSQlvRfGjELelroI8kszrJn0zKWYc2o15swXDNuVkPZxFkQii2GLpX
 5sxO02VA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1k0NT7-0005zH-U1; Tue, 28 Jul 2020 11:08:25 +0000
Date: Tue, 28 Jul 2020 12:08:25 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Brunberg <ingo_brunberg@web.de>
Subject: Re: [PATCH] nvme: Namepace identification descriptor list is optional
Message-ID: <20200728110825.GA20833@infradead.org>
References: <c92f9d41-de84-ab54-c003-8649d20deb50@grimberg.me>
 <m3sgdj10tr.fsf@web.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m3sgdj10tr.fsf@web.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jul 23, 2020 at 03:23:28AM +0200, Ingo Brunberg wrote:
> Sagi Grimberg <sagi@grimberg.me> writes:
> 
> >> With commit ea43d97, appearing now in kernel 5.7.8, you made my cheap
> >> SSD disfunctional again. For reference, see bug 205679. Maybe you
> >> remember the discussion.
> >>
> >> I do not know if this was intentional or not. Maybe you should introduce
> >> a quirk for that particular controller.
> >
> > Either we quirk this controller, or we are back to test specific errors...
> >
> > What is the pci id of the device to test a quirk?
> 
> The PCI ID is 126f:2263

Please try this patch:

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 05aa568a60af62..0602e0f3e77de9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1287,18 +1287,6 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
 	if (status) {
 		dev_warn(ctrl->device,
 			"Identify Descriptors failed (%d)\n", status);
-		 /*
-		  * Don't treat non-retryable errors as fatal, as we potentially
-		  * already have a NGUID or EUI-64.  If we failed with DNR set,
-		  * we want to silently ignore the error as we can still
-		  * identify the device, but if the status has DNR set, we want
-		  * to propagate the error back specifically for the disk
-		  * revalidation flow to make sure we don't abandon the
-		  * device just because of a temporal retry-able error (such
-		  * as path of transport errors).
-		  */
-		if (status > 0 && (status & NVME_SC_DNR) && !nvme_multi_css(ctrl))
-			status = 0;
 		goto free_data;
 	}
 
@@ -1888,7 +1876,9 @@ static int nvme_report_ns_ids(struct nvme_ctrl *ctrl, unsigned int nsid,
 		memcpy(ids->eui64, id->eui64, sizeof(id->eui64));
 	if (ctrl->vs >= NVME_VS(1, 2, 0))
 		memcpy(ids->nguid, id->nguid, sizeof(id->nguid));
-	if (ctrl->vs >= NVME_VS(1, 3, 0) || nvme_multi_css(ctrl))
+	if (nvme_multi_css(ctrl) ||
+	    (ctrl->vs >= NVME_VS(1, 3, 0) &&
+	     !(ctrl->quirks & NVME_QUIRK_NO_NS_DESC_LIST)))
 		return nvme_identify_ns_descs(ctrl, nsid, ids);
 	return 0;
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index c5c1bac797aa5a..4cadaea9034ae4 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -137,6 +137,13 @@ enum nvme_quirks {
 	 * Don't change the value of the temperature threshold feature
 	 */
 	NVME_QUIRK_NO_TEMP_THRESH_CHANGE	= (1 << 14),
+
+	/*
+	 * The controller doesn't handle the Identify Namespace
+	 * Identification Descriptor list subcommand despite claiming
+	 * NVMe 1.3 compliance.
+	 */
+	NVME_QUIRK_NO_NS_DESC_LIST		= (1 << 15),
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 61e612d52d61d6..bac3a3f9c79e0d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3181,6 +3181,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_DEVICE(0x1cc1, 0x8201),   /* ADATA SX8200PNP 512GB */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+	{ PCI_DEVICE(0x126f, 0x2263),
+		.driver_data = NVME_QUIRK_NO_NS_DESC_LIST, },
 	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001),
 		.driver_data = NVME_QUIRK_SINGLE_VECTOR },

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
