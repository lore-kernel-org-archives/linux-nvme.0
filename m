Return-Path: <SRS0=k+Rq=MI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A81C07E95
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Jul 2021 07:39:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31134613E9
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Jul 2021 07:39:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31134613E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AtBxrJEWGSvm/LLt4aXL2JAQrkpdbZ6r2JsH8iDKcLg=; b=ewTNaNBkPpyflp
	af6S1INQSkIxtzKHsrDJFSW1KmtjD4CvGQRoTh4G6GaOcqgQx60omUJ9BOckJZGIJJm0JrLroYhbW
	I/Nv7Vvgnt6Rc0vA7gr5EeNnXhmOhq2U4Yss7W0Y23Acj27OWb+GIiXC9G98rCOATuVJ7FupP9ABn
	iLiT34/VD6sKqSCOWkJPmLGJDTpbnpsOT1QjB+DximSAp2BaVDYBis5MXVqpZ8A69Arc8aJat9ZGt
	G04do7TdXWcnvAZCw90jMUSLPics8NbCCA9F8r4k8icZiMFsOKLE/tZ9vUMUzhJojWQM4tNRIjs/W
	vgia4EU7/tHjGXZpSQUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m4IR3-003YM8-34; Fri, 16 Jul 2021 07:39:01 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m4IQz-003YLP-Mc
 for linux-nvme@lists.infradead.org; Fri, 16 Jul 2021 07:38:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 10AAB67373; Fri, 16 Jul 2021 09:38:55 +0200 (CEST)
Date: Fri, 16 Jul 2021 09:38:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Chao Leng <lengchao@huawei.com>, James Smart <jsmart2021@gmail.com>,
 Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 0/2] nvme-fabrics: short-circuit connect retries
Message-ID: <20210716073854.GB14800@lst.de>
References: <91ff9961-6537-05d1-c552-18a02d13bf0c@suse.de>
 <984b2d1a-f319-1a09-7347-6c4edd1dbab6@huawei.com>
 <d20b23fc-dd08-cb51-eb29-aa033810b0a4@suse.de>
 <caa3759f-9a72-5e3b-9097-700132e4ab63@gmail.com>
 <28ec79af-beb0-8ef9-ab6a-d608a632ee2c@huawei.com>
 <0af5901a-4dab-70de-abda-00ed7f8cf45f@suse.de>
 <c5ddf523-af8c-eae0-03fc-6c64d0df9e7c@huawei.com>
 <f4d95ae8-7c7b-275b-0436-863c5add25cb@gmail.com>
 <4ae04d12-cb34-45bb-5a01-54802d2a94b9@huawei.com>
 <5866f912-45de-e4a6-f98e-2562fb913746@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5866f912-45de-e4a6-f98e-2562fb913746@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210716_003857_932243_FBBDA36B 
X-CRM114-Status: GOOD (  18.34  )
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

On Fri, Jul 09, 2021 at 10:55:13AM +0200, Hannes Reinecke wrote:
>> I agree the nvme spec. I mean that linux kernel nvme target does not 
>> behave exactly like this.
>> So need to modify both host and target. In addition, the compatibility 
>> between different versions should be considered.
>
> Ah. You are talking about the _target_. I would be the first to admit that 
> this could be cleared up quite a bit; there are lots of inconsistencies 
> there.
>
> And sure, I can do a patch for that, too.

I think we need to sort this out first to not create regressions in the
Linux to Linux interaction.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
