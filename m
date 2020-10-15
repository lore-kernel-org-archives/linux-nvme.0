Return-Path: <SRS0=wM/2=DW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F95AC433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2020 08:11:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7A1722243
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2020 08:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F4c1HepM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A1722243
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=r1IUIF+iesmz+dD9BSNLYe8RGkTHZ8LIXcLdddom6yc=; b=F4c1HepM9t8h04JuHTqce7UAK
	29UgV+hU0mgrqhAaEa0DPYVbIOHvvEGubNlndXoDjrtkQns2vsYXxp/0IzNiP3IgkFPECfzuZMOjh
	MkCnITsAPySsTdGtMS58195UPSvLjOS85tSAwvDkYck3Iy6Nsci3H06ss3fUmWIGjP1Vc44tbunjx
	L4dchqOfTVHZy/quIhZKIgN9mb+43MiTpxY4TlEma/hdZaomg7w7HnO3YLZK0c+Upw3t+OAQYn9fj
	Zek2NnMTLgRfOnjsE8yTez4VSIrpKhpNunIN1VpcbGBecSgZkdCIwau/8xwigeTokcYL6vpyhMeq7
	5TTAj/UDg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kSyLi-0004ua-DI; Thu, 15 Oct 2020 08:10:58 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kSyLg-0004u0-Qf
 for linux-nvme@lists.infradead.org; Thu, 15 Oct 2020 08:10:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 44CA668BEB; Thu, 15 Oct 2020 10:10:55 +0200 (CEST)
Date: Thu, 15 Oct 2020 10:10:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: [PATCH v3] nvmet: fix uninitialized work for zero kato
Message-ID: <20201015081054.GC15299@lst.de>
References: <20201015015140.1061936-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201015015140.1061936-1-pizhenwei@bytedance.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201015_041056_992608_B53C33C0 
X-CRM114-Status: UNSURE (   6.44  )
X-CRM114-Notice: Please train this message.
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
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
 chaitanya.kulkarni@wdc.com, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Applied to nvme-5.10, thanks.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
