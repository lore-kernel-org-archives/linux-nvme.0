Return-Path: <SRS0=w6YM=OR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EF7C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 20:23:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04AB660E94
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 20:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 04AB660E94
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VmPchlDWwlolugjhVEOSfY5CtNIDjotRUFfMf1KyCOA=; b=qtVTcwMvi8oWer
	eFzMaEqRajhzqbZ6WP2r5kXkfd+Y7tke2IIVhJQKAiJCzeecstskEVbnp741/zlq6GTgjFsSQGOgc
	Pruny+gt+1Rz98CFr+jKeuF874HufgCVmNxTUY1lsfZi7tD5gKwhMie3IEqdwVG6M37tFCokhN1hp
	VGmrIg1xRUCuAjL7zroTONMP/BkEK7wYgI2DjLZ0XLl36h8xgtskehvsCQFGKUX2R8uGxAy+Ai69C
	f0yjyrYXrNeTJ3QpoW4V8Gux3FVQPvqTwg3TncJjpIxdPMJHmBFWVNkjez85/KkprXscUyNnfWORk
	xnMDImV6DJE/R4KKwJ8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUx8g-004AED-5H; Mon, 27 Sep 2021 20:22:14 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUx8b-004AD1-3j
 for linux-nvme@lists.infradead.org; Mon, 27 Sep 2021 20:22:10 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F58360EBB;
 Mon, 27 Sep 2021 20:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632774128;
 bh=rHlA0StQ17yYGddIus945tSg8K6di3WS+WxEzz9KzDg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UQ7qg8qiSZ4D75vGh0jmb8WX32krpkmVvP37Mdcsw4aq0O0oZqRYYm9p3Q5NzXYjL
 1gbTjhOrdRw4bmchfbldfgeMcaVWQzDHDC3GdUMQfl4JQP2gtD0VSmuXNkTFDtcFGf
 3IVo/YDYE85cuc7WN7OuRSYP9HgdfgLwS/8QooAcIkk0o5TPiWOK8eAOtT3Hwks1r3
 zRF9AzoQJBHmndZaq4kbR94uIGxSScmTdTJUMyPexsOro9qEeDrmT3+mOJ5CB5pEsc
 DvYHoJ+JpFtJTM35NVNiVz/KAyuhAlFcrSzIWKKOBCKxh0cDPfhJzyZXaY7FzepOO8
 L8qbojgk3u5/w==
Date: Mon, 27 Sep 2021 13:22:06 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH libnvme] fabrics: restore hostname traddr support
Message-ID: <20210927202206.GB387558@dhcp-10-100-145-180.wdc.com>
References: <20210926182932.55896-1-sagi@grimberg.me>
 <2a5ebd60-0367-6f76-67a4-d5af0a33e464@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2a5ebd60-0367-6f76-67a4-d5af0a33e464@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210927_132209_199234_356F3AE7 
X-CRM114-Status: UNSURE (   9.13  )
X-CRM114-Notice: Please train this message.
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

On Mon, Sep 27, 2021 at 07:39:53PM +0000, Chaitanya Kulkarni wrote:
> 
> > +static int hostname2traddr(nvme_ctrl_t c)
> > +{
> > +	struct addrinfo *host_info, hints = {.ai_family = AF_UNSPEC};
> > +	char addrstr[NVMF_TRADDR_SIZE];
> 
> do we need to setup the addrstr to 0 with = { 0 }; ?

Looks like it's unconditionally set if it is actually used, so should be
fine as-is.

Patch applied.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
