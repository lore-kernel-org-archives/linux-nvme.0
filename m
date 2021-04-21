Return-Path: <SRS0=D0Wy=JS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C603C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Apr 2021 14:28:42 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E38D86144B
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Apr 2021 14:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E38D86144B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fJYWb9ge+HJGsbFi9eqh58M4WJVoyikrGVGeRNTOtMA=; b=EMbfNLeeT1m3985VxmHsZVrum
	5E8v+sNwQ6Q1Je+P7vhf0geIeLVexNmCzbxxehoqG5ro+bVN128nowmooiDQgCQcx15SgzGXGG800
	x/cXzajJjzWwyZbCuojk7M8Z9qhLPGcgOKGDtaFFNcz/LQbiWZj3oSeZTGW2BRwJ5sFNdQ5js0IpA
	UVCZNcSk5Usg3ieSThvKqJwrHo8hNQC8tmNx7yD6INj2qZ+bbmqxACk2lpi0oG4dpcpz48FgA6+OQ
	YF1advw4L5+oJHsokIjfiBZDIrMrNRRHCbY8BT90WJJkWsBUgeHG3d90petdEpA/BtAVhRGTDTmpr
	yU7u7ifGw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lZDpt-00EaWK-FZ; Wed, 21 Apr 2021 14:28:13 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZDpr-00EaWA-7I
 for linux-nvme@desiato.infradead.org; Wed, 21 Apr 2021 14:28:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=QuvRJapiSksrCNIipucu7dwImUNMACUyddKzb1Opbqw=; b=e3egH/ghI3Z0GSZ2tonO8QzdVO
 vg999yUi7SgwDhEmNejpZDJCNwNlm8LeV7Ur6XNCX7Jc51Tf3i9toePuWEzV/MupwwPWIkEtdV+oz
 WKnlxwbOgm6JJXepMSIAO3g07hTPQQsdxyLFcODOExsIUq/G5/gMwAee5EwNMmraCnHyPF7y6CloJ
 OLY7Q+HSdxnd1aEVLCTB+MkJfB3369AmQYQVC6XtC7XJm/qzf+cSZwTb/5Z89udrHa0YTcOEsl+Zx
 odIuEw0k/TyK1zk8OL76l9YDxV3ssZ0kqut81tqJ1VJD3Ljz7C8/2ZY84BPuibIcGClPMSZs3Ghx0
 90K74uxQ==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZDpo-00CxNq-DO
 for linux-nvme@lists.infradead.org; Wed, 21 Apr 2021 14:28:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7981D67373; Wed, 21 Apr 2021 16:27:55 +0200 (CEST)
Date: Wed, 21 Apr 2021 16:27:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Minwoo Im <minwoo.im.dev@gmail.com>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: fix to find live controller based on namespace
Message-ID: <20210421142753.GC29072@lst.de>
References: <20210421131250.105796-1-minwoo.im.dev@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210421131250.105796-1-minwoo.im.dev@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210421_072808_619298_3115E98D 
X-CRM114-Status: GOOD (  10.78  )
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

Urgg.  But yes, if people want to issue the Identify commands that
depend on an active namespace we can't do this.  But I think the simpler
fix is a manual revert of "nvme: don't bother to look up a namespace for
controller ioctls".

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
