Return-Path: <SRS0=dhBa=DI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADBEC4727E
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Oct 2020 17:24:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBE692085B
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Oct 2020 17:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="xvPLbHoS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBE692085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Mt0c8vtj8oJOO4vUctdYzJGLwjDa6ymJhA0hQfcUbpI=; b=xvPLbHoS8/bcytsXVsiCs1NXA
	+Xc4FwAwj7WtBOPrZKT0zjwsmBPNfo72YXqsBotAquusSZGvaDWUfkoq1mpC4kWAAHZTtKcFZlK1T
	4Pw/T93AO7xvUAY8yxjHjge5DQwvS7IXvVhGlCheKW/K68AMb47u7nfUX+hzbZMXrgF3TsbwncAh4
	k9K3XfrcyA2Q3SDBU3vRTPRPgdLaxoxNIdGIh/ZIMY4MlGHYlkS/iWfTGUh+KvWBJCskaEdB1875Z
	YR9s7FzDMUec8G8gl4HaL3OKyLg+yjAt+pIHobvFnv2Cka7DhGGpXknr6iDLxt2ZYkcniaxBdjcAh
	BXW8pob2Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kO2Jn-00082V-3N; Thu, 01 Oct 2020 17:24:35 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kO2Jk-00081X-78
 for linux-nvme@lists.infradead.org; Thu, 01 Oct 2020 17:24:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id E5C6E68B02; Thu,  1 Oct 2020 19:24:29 +0200 (CEST)
Date: Thu, 1 Oct 2020 19:24:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH 1/3] nvmet: allow user to set the ns readonly
Message-ID: <20201001172429.GA29997@lst.de>
References: <20201001024427.40753-1-chaitanya.kulkarni@wdc.com>
 <20201001024427.40753-2-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201001024427.40753-2-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201001_132432_390778_390A8C03 
X-CRM114-Status: GOOD (  12.63  )
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
Cc: mruijter@primelogic.nl, hch@lst.de, linux-nvme@lists.infradead.org,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Sep 30, 2020 at 07:44:25PM -0700, Chaitanya Kulkarni wrote:
> From: "Mark Ruijter" <mruijter@primelogic.nl>
> 
> User may want to export readonly ns to host in order to export
> read-only snapshots. Right now we don't have configfs attribute to
> allow user to mark readonly & export ns.
> 
> Add a configfs attribute such that user can set the ns and export ns
> readonly when it is not enabled.

I thin kwe also need to expose this as permantently write protected
throught the write protection feature on the get side, and ensure
a set features can't change the setting.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
