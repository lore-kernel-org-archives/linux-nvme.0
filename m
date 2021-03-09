Return-Path: <SRS0=pxZf=IH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CDDC433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 10:30:07 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 488476521D
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 10:30:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 488476521D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jyTql+HYSkiqITWOxvngdCFlgfX584z3ZzBenXTf3pk=; b=XpPKJtKXOyj0BOuLPvUdE0JrO
	/cq8YrsEfpn6MF98OE3RrfNmbuzkhq+WDq8RaH/zwazdImA/4lhvA4QJT+Do5MeXShUxcchmOiLG4
	G3h1xww2cvTMY5PNvaQyGAKSAqv8uzi6bEMgHI+VMj4PYzTYmZFGQ4B6Fn4dhQ4jjxU7GvhjY7c5j
	NEUS/DHvQwrA1iYxePtTMpTI1aLOxy1RYCL127ON3IyINj9QRGBMsNuU6R0yluFpc98LCX06BjsQU
	Tl/Yk5bL6lsZpDcHk3shdC417WHQfFrOmth8+QeQXA4zQUSqImglrh39Rx/m9PVUs2OclT0bgKavh
	aUD0S8PLQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJZcm-004DS6-G5; Tue, 09 Mar 2021 10:30:00 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJZcg-004DRt-Gk
 for linux-nvme@desiato.infradead.org; Tue, 09 Mar 2021 10:29:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=c0B1LuxWx4LheWbH427md9p66qSkbuN+hcv17m4yysM=; b=BkjdZu4UrDdclLzzhMLaVgIsV0
 stGqJbHPXP6lnrMnkEab2SXsEIepta1o5KiN78NoHS1M/JoIVQ5SUkXax60T4MKL1R96I8SXBQ8Zu
 cLf03AiDmROmimy+QhG96Ol64X2k/T4GqxB5YMthThpVh3cXyZMaIGFSsKuGoZfFDKlDnb0LVWsri
 Sym1tuaou21vRQh/e7scAqYSagpSvKs9FsO+X8EGL6uImWWXdZqxkSfFkumbuHKMVjIV+rm38fJfH
 dWLeyX3Om3VaLmFvJXDAiaPg2lMj2x6UUW9y54SDSczUl1Wmwgh0xlNFacP7F8vaGPG7ztbnaBzP5
 SOidRVTA==;
Received: from verein.lst.de ([213.95.11.211])
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJZGl-000QWo-MF
 for linux-nvme@lists.infradead.org; Tue, 09 Mar 2021 10:07:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4D54368B02; Tue,  9 Mar 2021 11:07:03 +0100 (CET)
Date: Tue, 9 Mar 2021 11:07:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH V2 0/6] nvmet: cleanup and status, error log fix
Message-ID: <20210309100703.GA7310@lst.de>
References: <20210225015642.29288-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210225015642.29288-1-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210309_100717_000885_B19FA420 
X-CRM114-Status: UNSURE (   5.99  )
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

Applied to nvme-5.13 except for the two patches that use the nvmf
on the wire structures.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
