Return-Path: <SRS0=+tAy=ON=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4A0C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Sep 2021 19:47:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F013061241
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Sep 2021 19:47:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F013061241
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LY1ThK6ceDtX9PugVwb0kvfnY42EGe0qRgp1yJhnyv8=; b=FNGBlbuW2D2Rp0
	Qmp8rK0P+y9OxVKJFvRblAHRnmXbajbvNELzTkPcRTQa1zAq1hQcfC5dmkUmxl7EK4+/yIHTPL3Pm
	29qYeO+uD+7yD1XLEO5bMpZZbo42bO4pIP0tNT6GizP/KMdHzGgsM906E04Dy8qq2O2PqxBD+bmTp
	JR4MM9BQPdnrfwbai1YvSMmmsrSgIJ/J6gF+RAB02c24f8zor+IcDUrWZmzgLowz9Se0gOSgZ5Sn5
	j+YrQ4K/3wOuyWNRcKDn2SkfpmOxNWjhChMejOLJnJBH18RBtcA8Xmcmwu8KOJQR51sIOyo7/SvAQ
	LiWlBflHorzBy/JwGa4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mTUfm-00CUH7-Qa; Thu, 23 Sep 2021 19:46:22 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mTUfk-00CUGK-06
 for linux-nvme@lists.infradead.org; Thu, 23 Sep 2021 19:46:21 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF41C60EFF;
 Thu, 23 Sep 2021 19:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632426379;
 bh=rzX+zCpd3Wc6cmbH8GXWLi4YhrvO0myx+ZdPCQn6En8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DC65B3tweDbJIlVFWnlY4c5dLaSMgcUM6bQpLAMWCwo8+wMwjYLwvZw9O/09VObmM
 uPeAU8mWikDaowUXnpX1GCTDxziVuMYmN4VesAQXCGeiKHbEcukkbnMAk+V7jymV2H
 mcD3LF/2x3RtePfu/FOM7b4okhvKQcuLyt1cmNau4OL5jFFdmc/wzLnLNL4rOYGnmi
 UkBs20pgKU2VaEvzaJGEP1k2W82KENEq7QcH5CwF1xXlbbhYY4YorMMnb2gfdTyKQE
 C50PcA8FOhWuBCQS+K+sgB31YocWWmDkQRK+LURzlS3QPkne9OIHV/UF30QHllJ11v
 UqM3ZP5lOPTtA==
Date: Thu, 23 Sep 2021 12:46:16 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 2/2] nvmet: use macro definitions for setting cmic value
Message-ID: <20210923194616.GA114816@dhcp-10-100-145-180.wdc.com>
References: <20210923101744.4204-1-mgurtovoy@nvidia.com>
 <20210923101744.4204-2-mgurtovoy@nvidia.com>
 <a6381c90-4eef-a9e1-2156-9f7539f169ea@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a6381c90-4eef-a9e1-2156-9f7539f169ea@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210923_124620_098891_97A77A1B 
X-CRM114-Status: GOOD (  18.70  )
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

On Thu, Sep 23, 2021 at 05:20:21PM +0000, Chaitanya Kulkarni wrote:
> On 9/23/21 3:17 AM, Max Gurtovoy wrote:
> > This makes the code more readable.
> > 
> > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > ---
> >   drivers/nvme/target/admin-cmd.c | 3 ++-
> >   include/linux/nvme.h            | 1 +
> >   2 files changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> > index 4ee9fe134697..92d81dc5906b 100644
> > --- a/drivers/nvme/target/admin-cmd.c
> > +++ b/drivers/nvme/target/admin-cmd.c
> > @@ -380,7 +380,8 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
> >   	 */
> >   
> >   	/* we support multiple ports, multiples hosts and ANA: */
> > -	id->cmic = (1 << 0) | (1 << 1) | (1 << 3);
> > +	id->cmic = NVME_CTRL_CMIC_MULTI_PORT | NVME_CTRL_CMIC_MULTI_CTRL |
> > +		NVME_CTRL_CMIC_ANA;
> >   
> >   	
> 
> So we actually had this discussion before to keep it open coded.
> 
> If I remember Keith had already sent out patch for this one...

The similiar patch I'd sent went in as 92decf118f1da. I argued symbolic
names helps browsing the code since we can tag/cscope them, so I think
this is a fine change.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
