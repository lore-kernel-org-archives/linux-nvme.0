Return-Path: <SRS0=Ubpo=JH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8AEC433B4
	for <linux-nvme@archiver.kernel.org>; Sat, 10 Apr 2021 06:50:53 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D15960234
	for <linux-nvme@archiver.kernel.org>; Sat, 10 Apr 2021 06:50:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D15960234
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hWA3byOVvvXZ7C76LG0eURWRmCntcF67GLltAps7aTg=; b=U8SVZ4j6GWj/b3pT6klQpUf72
	mIF87EJ9dZ+onKilk22F/xFmD6AAPMsoXFdRc+zwpyfFfgm6qZUJDRyg2EaR4asXXebjKfAXouSCq
	B0vwyl+SWSbq4+G8AET9kHn+EIsFy/JLNknLkQUhQMWuk0O/b0A9ZPl9OQHBOu6mGE8bfqz56c4XN
	k4O7soovWNF75vQUWfsXWvmq1AcFrBsgzaZcUTmRIkYVyPKc1Zr0AojKdS19tSeyEhlOI3abv7GKJ
	XN7iFbhF65REga0gnPSWyQgQhk1MCwFJot1csyJm2sbTpYnrUv9YNAkJUVtmWnPWowaB+36O81gPP
	S9Um5qsSw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lV7S3-002Jfc-PB; Sat, 10 Apr 2021 06:50:42 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lV7Rv-002Jer-GP
 for linux-nvme@lists.infradead.org; Sat, 10 Apr 2021 06:50:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6AB3F67373; Sat, 10 Apr 2021 08:50:25 +0200 (CEST)
Date: Sat, 10 Apr 2021 08:50:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: cleanup nvme_configure_apst
Message-ID: <20210410065025.GA16097@lst.de>
References: <20210409094524.1920584-1-hch@lst.de>
 <YHCFmClWBxLCX9yN@x1-carbon.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YHCFmClWBxLCX9yN@x1-carbon.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210410_075032_417687_57BD3899 
X-CRM114-Status: GOOD (  14.27  )
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

On Fri, Apr 09, 2021 at 04:49:30PM +0000, Niklas Cassel wrote:
> >  	ret = nvme_set_features(ctrl, NVME_FEAT_AUTO_PST, apste,
> >  				table, sizeof(*table), NULL);
> >  	if (ret)
> >  		dev_err(ctrl->device, "failed to set APST feature (%d)\n", ret);
> > -
> >  	kfree(table);
> >  	return ret;
> >  }
> 
> Since your patch includes whitespace cleanup related to apst,
> perhaps you could remove the trailing whitespace after the
> nvme_configure_apst() call (in nvme_init_ctrl_finish()) as well?
> 
> It's the only trailing whitespace that we have in all of core.c,
> and it makes my eyes flinch everytime I see it ;)

Well, this patch only touches nvme_configure_apst, not any of the
callers.  But I'd gladly take a patch to clean up the trailing
whitespace from you.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
