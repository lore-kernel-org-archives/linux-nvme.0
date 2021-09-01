Return-Path: <SRS0=EXAn=NX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F249C432BE
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Sep 2021 14:10:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7E8460525
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Sep 2021 14:10:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B7E8460525
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Nv93hfS5g/Nh5jdaQ2i8SLwFPom+CEV3kJotQ/8e0c0=; b=c9CRepPdBMqfm3
	4uhKnNdXmAWOxtLCbeAIWj9dy9AH8EOZ0NXbLdHTun+Ero6WjUuN3KNpwvLj5TLw9ltQ0qQfcmBCK
	jzWMsW8g1Arf/0wGNn4Gq8Ak/+OM8tRaYN80LjBdUj+Fy0PKFlyfrgJcu0xPYfF9e0iZ96kJAuviG
	Ks0acOYMTrVa5mM5PZIpbqPk2MBItOI3C3kyX8Bg2eqMT7pozOxGarLGjIjYghpts3cL69lIc0D/V
	IAepib3rYbDSNVsMD5EexAyK6/hU2z803mMJ3N5dCUK62SDN8rYZyD6dwTfTP808Y9tAtFk4SoiMJ
	S9sO5ZB+PJexRBOcsqMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mLQwf-006Dkt-Nr; Wed, 01 Sep 2021 14:10:29 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mLQwZ-006Djd-Df
 for linux-nvme@lists.infradead.org; Wed, 01 Sep 2021 14:10:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id C067E6736F; Wed,  1 Sep 2021 16:10:16 +0200 (CEST)
Date: Wed, 1 Sep 2021 16:10:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: kernel test robot <lkp@intel.com>
Cc: Tatsuya Sasaki <tatsuya6.sasaki@kioxia.com>, kbuild-all@lists.01.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [linux-nvme:nvme-5.15 6/8] drivers/nvme/host/core.c:1298:33:
 sparse: sparse: restricted __le32 degrades to integer
Message-ID: <20210901141016.GA19478@lst.de>
References: <202109012253.r41qqUsH-lkp@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <202109012253.r41qqUsH-lkp@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210901_071023_656759_4D8780FF 
X-CRM114-Status: UNSURE (   9.37  )
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

I've folded the obviously missing byte swaps in and force pushed the
branch.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
