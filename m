Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31849C77B61
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Apr 2023 16:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ziV2I8BLdfT23y/At9fcgpdWVrvOOKeRYBhfgs3V2HM=; b=zzx5hvx3Ij6GGJdLVzQCkA6EwH
	rQtj4r1ey1YHOpmPay0VPEM/cLdwGJHijEoGjffi3S3ThbOeji4YpjjQj+jQZNY28P+b2rcQCHGWS
	zT7A1SFKgYx1IXi7xs2duxS4PE432dZxA0uCLI56A3NreR3iLTnXx2YkCSgGEcZC9yXSGgUpoE5SR
	NPiyDObpaZ2oSL4L35doBl/7RFreFsGO/PKY7h+S/vDIGcIKWQ4b7HqSOHI6oQ0BoibpxlVIWxiK6
	CuxH7UrfbhoySVlKFj6e0Ie8c+8Aa8q0McsE3gNu6LDPe1NIF68Am8Ms0LGgOUyCRIRJIv24LSOaJ
	uN3vwZdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1psQva-00BDTV-16;
	Fri, 28 Apr 2023 16:26:34 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1psQvX-00BDSq-25
	for linux-nvme@lists.infradead.org;
	Fri, 28 Apr 2023 16:26:32 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 1932260EA8;
	Fri, 28 Apr 2023 16:26:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF34C4339B;
	Fri, 28 Apr 2023 16:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1682699190;
	bh=2ova8myvuxl3T9joUGwbPw35fOpZDeiokkLv+c3PG3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DzE2R4jgr/rlC9IRt7NY3eJBO2Z4usnBTMsCVHKdK53iCBcSDgjixMBZxwLowfqkF
	 szeBmfnpcsWArqxLwIfUE04zM4rbrbeuoTCE1DYi4h/KXcncgeXfglYyne3SLZ83uQ
	 8RRnww/qRNclGim00rquJqCwHRSwMgWVHl4lOEXc83HsZvrJ72/dCIOHsmOUjqJZHx
	 7FtElA9ij4/ni+u+88TfzqvBMfJzBpkTVBMvDVo1ezBCaWaljeINZPHEmtavN4yR6v
	 PUGmj/PN9/oAbAlAj9ku2kkanXN6NIl28DTKCzTYhbcPsjd+Tm/3rtMjkcJMPqYzX7
	 yCuvzOgVePfbA==
Date: Fri, 28 Apr 2023 10:26:28 -0600
From: Keith Busch <kbusch@kernel.org>
To: Lyndon Sanche <lsanche@lyndeno.ca>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [BUG][6.2.11] WD SN770 nvme controller is down
Message-ID: <ZEvztPVgoS7m0Xja@kbusch-mbp.dhcp.thefacebook.com>
References: <0SKHTR.QZGFTLD3Z8E01@lyndeno.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0SKHTR.QZGFTLD3Z8E01@lyndeno.ca>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230428_092631_721318_A9AAB407 
X-CRM114-Status: GOOD (  20.36  )
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

On Fri, Apr 21, 2023 at 04:21:36PM -0600, Lyndon Sanche wrote:
> 
> I am wondering if there are any other steps I can take to troubleshoot this
> problem. I have tried taking the drive back to the store I bought it from,
> but the tests they ran all passed so a replacement/return is not likely to
> be possible. I am wondering if there are other settings or possibly patches
> I could try.
> 
> It should be noted that none of these problems occur on my desktop with the
> same model of drive (ASUS X570 Motherboard).

I do not know what causes this, but here's a shot in the dark at
recovery. Since you showed a valid PCI_STATUS, the link is still
viable, so maybe an FLR will get the device MMIO capable again?

If this helps at all (it may very well accomplish nothing), this
is still not a satisfying conclusion since we really want to avoid
the situation in the first place rather than recover from it.

---
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 26e17110a419e..1278b8fd234c0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1272,6 +1272,11 @@ static void nvme_warn_reset(struct nvme_dev *dev, u32 csts)
 	if (csts != ~0)
 		return;
 
+	if (pci_status != (u16)~0U) {
+		pci_try_reset_function(to_pci_dev(dev->dev));
+		return;
+	}
+
 	dev_warn(dev->ctrl.device,
 		 "Does your device have a faulty power saving mode enabled?\n");
 	dev_warn(dev->ctrl.device,
--

