Return-Path: <SRS0=X7Om=YL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12784CA9EA8
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Oct 2019 14:10:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCF18222C5
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Oct 2019 14:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OPaPPfRU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0kC7kb+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCF18222C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uBy5LnWW+h/+FPdLwX3eRWaMFvBB5YG1nMqmK1Z7DBo=; b=OPaPPfRU9GJJBN
	xo1SfvwAPs1U5BFeZfiJQACBaqLxEwrHGu6lBQfvGPsiRyH5bxQvg09sHIe7++h+OxaNFecs6FRPo
	f7HBSebj6rweBSIFI0cK9dWyEjJL5tJhCulitm1G4GrP4K2QCoHo2JfprrAfjjIQvbWQ7ktm6Fa6r
	o1rjonubJnC3OHA3tZjvbhnlt7jk9zwI6gjT8Yo5j/WkbIf4SytdaFaQb2tq9MxDQSm9+Ghwj6Oia
	tRkRxt4jHcgRYMakS0SjjiuETv7kIFhUriMHzUccwqyjU0uoWfMcF+L7Uf9Sm4ASc5n4cyapcO+dA
	2JYtMjsvVOjRukZqgSBw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iLSxR-0004Ok-PJ; Fri, 18 Oct 2019 14:10:21 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iLSxP-0004OR-C6
 for linux-nvme@lists.infradead.org; Fri, 18 Oct 2019 14:10:20 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 90A0B21925;
 Fri, 18 Oct 2019 14:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1571407818;
 bh=Tgg+hNEtc66TMH9GlXFtMJSnNvmgVNfAL1vb+W/dEUY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=n0kC7kb+xztdMQSKcSilf3Q7LQ5D0hiibvm/arAXa+I2WNjj1X5nIxJ4wVZn7enJO
 yUfrUozXu5/FSSnFrO9zZrpzcQxCftk7ocAbPmwe3a3THSZB4bV0sgT8Vv/G6xMput
 2ipL5caUGniKwKp+9PM0f2HbiU8r/1BrwAChxSGU=
Date: Fri, 18 Oct 2019 23:10:13 +0900
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] nvme-pci: Set the prp2 correctly when using more than
 4k page
Message-ID: <20191018141013.GA7124@redsun51.ssa.fujisawa.hgst.com>
References: <20191018005926.GN27363@pek-khao-d2.corp.ad.wrs.com>
 <20191018025314.39229-1-haokexin@gmail.com>
 <20191018064812.GA23002@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191018064812.GA23002@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191018_071019_434182_999F3C68 
X-CRM114-Status: UNSURE (   7.09  )
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
Cc: Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
 Kevin Hao <haokexin@gmail.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Applied to nvme-5.4, thanks.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
