Return-Path: <SRS0=Ubpo=JH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBE1C433ED
	for <linux-nvme@archiver.kernel.org>; Sat, 10 Apr 2021 06:47:01 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF3086113A
	for <linux-nvme@archiver.kernel.org>; Sat, 10 Apr 2021 06:47:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF3086113A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=E+Sx8fPbc/GJkI5hjonm9J1diju1bwryvJdBQYigaus=; b=iwXPM5hurS6UPbkNNR7sG0+Gc
	ywkOxvUeH4Ckg8k60zfGtA/juegUFT4jc4KjqMBhAfB5bS3hkYR++SyLPzMC/Ch+BUo5PKcPILitw
	nJ9Ir4kn91Pyaz8UpfxGBJSK6XHkDH9DxFsN2m53MyBbHcXNLF2q98KPDbm3Rj1LPsENzFNTJ3nwz
	XGMIBH+tDbbzL6A9PnhwZFLyGmf1rGKkmA1NmVO+IRY4ctNjwFQ6lfCEVfvluiKGAGJh4iua9OGtY
	EFVsIDTG8SUlQkhsyxIXeLpaGIXbSUkKo/l3KVvZbTi4PMoRBm01uQyN3YmyzVnSJoDsuA9Il7whf
	7j0CP+s4g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lV7OI-002JLq-UM; Sat, 10 Apr 2021 06:46:47 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lV7OE-002JL3-5g
 for linux-nvme@desiato.infradead.org; Sat, 10 Apr 2021 06:46:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=+A+6DsRuYg8NWSm4nE5tQkziAqhPtQ0snkyJLsJoF78=; b=wamMRNQ9B4+ki/nh4tEMB/FNre
 ltn+a5LuRXkE2WcGtWgOPboVwpgWof8dPa/Kfu2WTHa1RReTgLbhzqWYzzeGRgJM2ynnTQ1VHwkHR
 nGKSfmPgodZT/FkWjViBUpbnOwcir5oSsoqEF6Ebc/k6f9Pstzu376n6PBc5s3svaxx4oDQ/5T03q
 CrB5lvE3nzV6Zd0h1Me9OZ1++hobbl4yFi3Xw43FSfmyWw+wLs2KIQs5DuefH1GuRCtwoclG4ZRMV
 2oGTwPIzYd4feGKIJeUZpk6D1UDeNokpAagbRsFDeaFcy97Mg/cC4uvS1e0Zyg0P9z8MwYCR1K+mD
 yENSZ4vg==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lV7OB-004xih-9O
 for linux-nvme@lists.infradead.org; Sat, 10 Apr 2021 06:46:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id A87F567373; Sat, 10 Apr 2021 08:46:30 +0200 (CEST)
Date: Sat, 10 Apr 2021 08:46:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Minwoo Im <minwoo.im.dev@gmail.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Kanchan Joshi <joshiiitr@gmail.com>,
 Javier Gonz??lez <javier.gonz@samsung.com>, linux-nvme@lists.infradead.org
Subject: Re: nvme ioctl refactor and generic per-namespace char device
Message-ID: <20210410064630.GA15893@lst.de>
References: <20210408120842.1450092-1-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210408120842.1450092-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210409_234639_511647_8DFDD918 
X-CRM114-Status: GOOD (  12.36  )
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

On Thu, Apr 08, 2021 at 02:08:29PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series picks up the generic per-namespace character device
> from Minwoo and Javier with a few small fixed, but rebases them on
> an ioctl refactoring I had pending, which cleans up a lot of the
> lower level code.

I've pulled patches into nvme-5.13, and I'll resend patch 13.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
