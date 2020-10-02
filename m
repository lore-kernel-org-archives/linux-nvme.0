Return-Path: <SRS0=oqNq=DJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896B6C4363D
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Oct 2020 06:41:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBC30206DD
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Oct 2020 06:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="3RC6wC6g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBC30206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=D5HVylA4CWuYwsuVmF9oVrqBUDUMMA7kvKvgn8RsMvE=; b=3RC6wC6gHBy/7VWgDflhpx4Os
	6U7vgRf2TxFcbclZ6ulCuAA1eWhkwJ/tLZ6D2lGOg/1sQNzjguz4eoHUeqF+SpRnLYLrhA6mys6ld
	yO/aPVnxXsgELdcRpjKebVICuruC5CU6tYn1TMdwOrZ5bndJYKjCGs9P2dL6dKksBJuFQ+vF38ODM
	Qi/L0EIVWCZGUuUCtJDPuANCd2XHvnifsVwAxtUzJiIq7iq02D7TKM1yt/6da/ZP9xrX6drsfzotv
	sh43q9y2wOhVm7pZrCjWNdy1thksCpPD1hVxVCX90xurlFfBN0NgJJyWI+mdmoAgy1Ktw0KZkztxM
	jkkDySLjQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kOEkm-0003dV-GM; Fri, 02 Oct 2020 06:41:16 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kOEkj-0003cm-8B
 for linux-nvme@lists.infradead.org; Fri, 02 Oct 2020 06:41:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id AEF9E68B02; Fri,  2 Oct 2020 08:41:10 +0200 (CEST)
Date: Fri, 2 Oct 2020 08:41:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Subject: Re: [PATCH 17/20] nvme: query namespae identifiers before adding
 the namespace
Message-ID: <20201002064110.GA9571@lst.de>
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-18-hch@lst.de>
 <20200930094411.GA189371@localhost.localdomain>
 <20200930100453.GA191465@localhost.localdomain>
 <20201001171457.GA29475@lst.de>
 <20201001174321.GA343057@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201001174321.GA343057@localhost.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201002_024113_426384_5068D7A8 
X-CRM114-Status: UNSURE (   9.18  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Oct 01, 2020 at 05:43:23PM +0000, Niklas Cassel wrote:
> Is there something I'm missing, or why did you change this between V1 and V2?

rescan is not exactly a common fast path.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
