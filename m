Return-Path: <SRS0=pISK=JY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0534C433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 18:11:22 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 283F1613EB
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 18:11:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 283F1613EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=GtQnVKpgeI3Havm064pDLr5Eyv9VSxC1YyT4Kc9eihg=; b=cJWzp+CRmVAeUkZOlPY5jVPYW
	47zm+H8MRUMcN6As+urn6LzaZGByjK3R5m7gS3surNcIUjcwVB7IqHHH9GzCk/VQ6fIksMSwGHKec
	ds5hfcP3mBpFz+FIlJqB4PBSJoHCDKn6geiyeXohu69RXoz3W5pFVWaf1K01qgB0WnmlsLciZ+xqd
	U8gPT9F1GQBrxsrlYW4YrQObz0VgDCWxJUmFFz6qlUBCslmFkfoUF3ZpFQw6rpn6ULGpdd4bWDhcm
	+qidhC/iZL0HJ5FQs1nKJnkqTtxKgVqE+t36I6ewgIYXhZCGyTMkEv8CSfOMeJcD1EZvhkKN6dId9
	gb74Zujkw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbSAs-00225O-UT; Tue, 27 Apr 2021 18:11:07 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbSAq-00225B-VQ
 for linux-nvme@desiato.infradead.org; Tue, 27 Apr 2021 18:11:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=56aG1IJF8aKU3CFb+2Xn2C3HKWe+ogCf7V97Kw6PBoE=; b=xCyJDM2jcoFfh3+Ma/ENbsIc7K
 zpSl/cO9NHBk6W2AdfRg+xcERQdOPlyQ9dOUjVymd2UyuJzVCiOu1n9cwTspv/bnUyQYRt4YGWiZK
 K6WDrvANjQEpghqmh6l1of8kGM+uOtl4hSLlBsfUyHRyWG+34rtaVaXwP055kptczetXFcnObIyb/
 funL9HmbEVINUI/GZbJhLYpRnjc2Bqy40hscA6sCW8dputsz89neQ3a2TS2Xb9X7zesQ7hP20ybEf
 UDM1QNeRIlot6JiZGU+F7rOpaGzEL7aOWYThICDso9gwmVuwVK98QawQfNUr9T/O/ckYCulzd7Q1R
 CjEgf3vw==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbSAn-00GuUg-9q
 for linux-nvme@lists.infradead.org; Tue, 27 Apr 2021 18:11:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id ADCB468C7B; Tue, 27 Apr 2021 20:10:56 +0200 (CEST)
Date: Tue, 27 Apr 2021 20:10:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, mwilck@suse.com,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chao Leng <lengchao@huawei.com>, Daniel Wagner <dwagner@suse.de>,
 linux-nvme@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] nvme: rdma/tcp: fix list corruption with anatt timer
Message-ID: <20210427181056.GA1975@lst.de>
References: <20210427085246.13728-1-mwilck@suse.com>
 <0ff2dbc0-0182-f54d-b750-084feac53601@suse.de>
 <20210427162521.GA26528@lst.de>
 <f82b7f7c-ef12-27bb-1349-d23ea22e50a9@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f82b7f7c-ef12-27bb-1349-d23ea22e50a9@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210427_111101_506924_D8725E00 
X-CRM114-Status: GOOD (  18.80  )
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

On Tue, Apr 27, 2021 at 08:05:41PM +0200, Hannes Reinecke wrote:
> On 4/27/21 6:25 PM, Christoph Hellwig wrote:
> > On Tue, Apr 27, 2021 at 11:33:04AM +0200, Hannes Reinecke wrote:
> >> As indicated in my previous mail, please change the description. We have
> >> since established a actual reason (duplicate calls to add_timer()), so
> >> please list it here.
> > 
> > So what happens if the offending add_timer is changed to mod_timer?
> > 
> I guess that should be fine, as the boilerplate said it can act
> as a safe version of add_timer.
> 
> But that would just solve the crash upon add_timer(). We still have the
> problem that the anatt timer might trigger just _after_ eg
> nvme_tcp_teardown_admin_queue(), causing it to hit an invalid admin queue.

Yeah.  nvme_mpath_init isn't really suitable for being called on an
already initialized controller for a few reasons.  I have an idea how
to fix it, let me give it a spin.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
