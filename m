Return-Path: <SRS0=FbzM=CZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377C0C43461
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 06:54:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F79320771
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 06:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Hkn0Lkco"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F79320771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=i9zCF/pmedAYp1IQX8BBBciYcGm3iqoRNp36VIim33M=; b=Hkn0LkcogbbcZabgg5FSofQp2
	fxy73zVUGTThE1tIz0HhyWsRcWUcC7K7lsJdaFVCkUyKb79NNXlyCazA9eMecYwG/7ivzczT0x2cQ
	M7FZ7X2b7jYBXk/gv7xd/jeBcX0qZpyz4tXjAM4uJuprp87b78BetlZqqiivzIekKFe3jZvRzbL8P
	mGfYeEVd49Cc0OuZxgwDUFnd/VEBSY2VIZh+32ri1lGrW6Ip/PJjWoOX+lymAX/HhiPxQIYEKNi5W
	r85o/V1YH6M+WhmJ1kJ3LGlYC2fvkE+94EvSldB61qdCBjza/ZHHcMhNiEBgZbt+O7LynMLtoZ19m
	mLiaWRSrg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIRKs-0003y6-Jj; Wed, 16 Sep 2020 06:54:34 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIRKq-0003xm-Ur
 for linux-nvme@lists.infradead.org; Wed, 16 Sep 2020 06:54:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 766DD68B05; Wed, 16 Sep 2020 08:54:30 +0200 (CEST)
Date: Wed, 16 Sep 2020 08:54:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH V2 2/2] nvme: decouple nvme_get_ctrl() from file open
Message-ID: <20200916065430.GA9319@lst.de>
References: <20200916035326.9229-1-chaitanya.kulkarni@wdc.com>
 <20200916035326.9229-3-chaitanya.kulkarni@wdc.com>
 <20200916065243.GA9283@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200916065243.GA9283@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200916_025433_104401_EB81274B 
X-CRM114-Status: UNSURE (   7.91  )
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
Cc: kbusch@kernel.org, hch@lst.de, linux-nvme@lists.infradead.org,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

FYI, the second one should be attributed to you - git rebase keeps
messing up the author when resolving conflicts..

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
