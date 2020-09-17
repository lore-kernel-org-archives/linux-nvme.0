Return-Path: <SRS0=U7CH=C2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E8AC433E2
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2020 08:42:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB49C20715
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2020 08:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eqBL5H05"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB49C20715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zXNpB/ePNegg/EQZ2d9DVEhVII1KMykmTLeIlDEGsOk=; b=eqBL5H05N/p0KxwvY+JcKXXMo
	j6n/B5jNewchgdIuJJnoCNjua517dYIvWFFlbPybJAq76bDzdJ9hZWWFl+pKLFok5WaSY5Wds5n9K
	GxgOfIzRWUnhAlJsbFB1JijizpODal1ZzlU6v3LIRbF6Ors9XAnbQ+j6qhYipoXAUPRFxm8G1O4hf
	a2+IKPAl90+jwBfOfDlV95hXl0ilFHrJ9CtT1r/Ma1uA9+IZF7IiGREh9XpL7huveDSCPL0fB4HYs
	2PzUcbf8wolr9m0qSVC5O7k+gbZ3mkXo1aMfQh9ICjHkA1VkUW9p1sAqo+fWVUXfkD7X2OXAhphbe
	kz5MTLJLQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIpUn-0001rw-8f; Thu, 17 Sep 2020 08:42:25 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIpUk-0001rV-NO
 for linux-nvme@lists.infradead.org; Thu, 17 Sep 2020 08:42:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id EE15367357; Thu, 17 Sep 2020 10:42:19 +0200 (CEST)
Date: Thu, 17 Sep 2020 10:42:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH V3 1/3] nvme-core: get/put ctrl in nvme_dev_open/release()
Message-ID: <20200917084219.GA5921@lst.de>
References: <20200917011102.14819-1-chaitanya.kulkarni@wdc.com>
 <20200917011102.14819-2-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200917011102.14819-2-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200917_044222_881165_D1BDE98D 
X-CRM114-Status: UNSURE (   7.64  )
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
Cc: logang@deltatee.com, hch@lst.de, linux-nvme@lists.infradead.org,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I've folded this into the previous module_get patch, and re-applied the
result to nvme-5.9.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
