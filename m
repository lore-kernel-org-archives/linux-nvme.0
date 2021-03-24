Return-Path: <SRS0=XXBd=IW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9641C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Mar 2021 08:00:15 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14FD6619B4
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Mar 2021 08:00:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14FD6619B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=++jpeALvFOMMrn6BvV575f5f6gTaqBHFy8ddZ9u+3sk=; b=Da9xUm+U0rwDQvdmfEaJsyhVE
	x7CdzvDeIhrXBUShuOMIjPEH5WuriXvJyKxODFem1vD14w/MD/IJSj+kJBaJb/pxW6UxErCxqAU4n
	DyYA/RgVhDUKXDPSOt4xPEcAFFlMmddWIMZmn5sxLlYu9+zmARYctbEUgf+48188KxgP1fdRosCHV
	GQ8K0mBOR0lHHNMzaWQZ4CavlsFuUIk3jzzhjBpBrSNPVm3yACYs1ErajMwdPznoI2BJ10u2T/DRT
	A1Fm3waHOQRH5o1fx29yo89nkvEcAyanK47GiTGwmB+/nPSoos3by7RUuOP0yv1kGqyQ0PFA/J7O7
	ZiIpD+0JQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lOyQi-00GWuD-KW; Wed, 24 Mar 2021 07:59:52 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lOyQa-00GWu7-TQ
 for linux-nvme@desiato.infradead.org; Wed, 24 Mar 2021 07:59:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=ZlRU6ugcNF7X4xBlKF+fdzk/CLaM4VVBS1i3MgxtXjo=; b=s1qYSK0iibVvXHCXlxfcM7jIKW
 SXToNUQshgkrfvpB101bHHwx6OxBc+8T4DtcC0YRvQMnzGk0qvYRPhbvJedHM+p2sVbKVk0FPzxgf
 r4eRHCRtJURmoYWHbosJn6ESYLt3Sk93mm094PczIoqZIGubyiOwtpGMRyh0g5oVzT7ZY1WX7/eum
 +bPAZed2C2ZC0Q4ToQKDU+A0K1OXQVbEUM1cB8APh8wj2ou1XhZd+6QCp33lz9SHZdzri2OApeIrx
 HRPK6kC+bewKVBPWwdyhX7o8gKeZakxQ1+VQCqne0pQRrzDLoLbuPwo/m/QzFLgmDPiD+MAWptCcI
 HL/fzL+w==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1lOyPI-00B7SB-Ec; Wed, 24 Mar 2021 07:58:53 +0000
Date: Wed, 24 Mar 2021 07:58:24 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Peng Liu <pngliu@hotmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, kbusch@kernel.org,
 linux-nvme@lists.infradead.org, Peng Liu <liupeng17@lenovo.com>
Subject: Re: [PATCH] nvme: fix APST error for power latency tolerance
Message-ID: <20210324075824.GA2648357@infradead.org>
References: <OSYP286MB0181647E6B1C99AF64C0803DC6649@OSYP286MB0181.JPNP286.PROD.OUTLOOK.COM>
 <20210323162321.GA2446196@infradead.org>
 <OSYP286MB0181DD097BC42806382473BAC6639@OSYP286MB0181.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <OSYP286MB0181DD097BC42806382473BAC6639@OSYP286MB0181.JPNP286.PROD.OUTLOOK.COM>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

On Wed, Mar 24, 2021 at 10:38:12AM +0800, Peng Liu wrote:
> On Tue, Mar 23, 2021 at 04:23:21PM +0000, Christoph Hellwig wrote:
> > On Tue, Mar 23, 2021 at 03:31:33PM +0800, pngliu@hotmail.com wrote:
> > > From: Peng Liu <liupeng17@lenovo.com>
> > > 
> > > Clear apsta so that nvme_configure_apst() does not execute
> > > nvme_set_features(), which will fail because admin_q is either not set up
> > > yet or no longer available at the time of nvme_uninit_ctrl() being called,
> > > and this leads to the error message "nvme nvme0: failed to set APST feature
> > > (-19)".
> > > 
> > > Fixes: 510a405d945b("nvme: fix memory leak for power latency tolerance")
> > 
> > How did you get into this situation?  For PCIe nvme_uninit_ctrl is
> > only called at the end of ->remove and ->delete_ctrl, so how do we end
> > up in nvme_configure_apst after that?
> 
> I got into it with nvme surprise and non-surprise hot-removal tests.
> Below is the stack ftrace result for nvme_configure_apst under the
> surprise hot-removal, and it is similar for the non-surprise hot-removal.

Ok, looks like dev_pm_qos_hide_latency_tolerance calls back into
nvme_set_latency_tolerance, which is a little .. unexpected.

Does this patch work for you?

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0896e21642beba..d5d7e0cdd78d80 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2681,7 +2681,8 @@ static void nvme_set_latency_tolerance(struct device *dev, s32 val)
 
 	if (ctrl->ps_max_latency_us != latency) {
 		ctrl->ps_max_latency_us = latency;
-		nvme_configure_apst(ctrl);
+		if (ctrl->state == NVME_CTRL_LIVE)
+			nvme_configure_apst(ctrl);
 	}
 }
 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
