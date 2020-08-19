Return-Path: <SRS0=A4m9=B5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F85EC433E1
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 10:50:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4257D2076E
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 10:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bHOGfOMs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4257D2076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=iPtEfEMy2Z/PCe/exsorqDzrAQ1x36nA49ZjaCVAGPE=; b=bHOGfOMs7GZFr0g8bNtzgvvgw
	OzFAZhPZl8NpHdZwIx+yPHTrs4pP3w5WiEZhL5Zqrh2dm4e6ZHrpEg0/MFblNkyLz6/AotrGbYLab
	MxrRHkqSakNbAUaGgZzdQkhRAun09d5cRsinFn7Lyob9lIJLIOUonP/zlbDethdMOqDpjjouZNTgK
	K5JC+qsi3CAIVaY2G1vm+mfI1wOw1Gun7DS6IiH/lolfqkOJZ3cVE+02whPEUunbyBmywQDCkj6DR
	tuMtz/UCS4SvO9v/5xWxxWMFsCekSb1R5tmJgzDulYk7qrXU+5NwELGtShO1jz6X+p1rMzFcRjlC8
	vObx9YrPA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8Lg7-00041k-Gh; Wed, 19 Aug 2020 10:50:47 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8Lg1-0003zX-0Q
 for linux-nvme@lists.infradead.org; Wed, 19 Aug 2020 10:50:42 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 69CA168BEB; Wed, 19 Aug 2020 12:50:39 +0200 (CEST)
Date: Wed, 19 Aug 2020 12:50:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH 4/4] nvme: redirect commands on dying queue
Message-ID: <20200819105038.GB3153@lst.de>
References: <20200818071132.1136033-1-hch@lst.de>
 <20200818071132.1136033-5-hch@lst.de>
 <4eeafb53-ad1f-a123-ad73-f996970a6f1e@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4eeafb53-ad1f-a123-ad73-f996970a6f1e@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200819_065041_251569_1E297810 
X-CRM114-Status: GOOD (  11.61  )
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
Cc: Keith Busch <kbusch@kernel.org>, Mike Snitzer <snitzer@redhat.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Aug 19, 2020 at 06:01:46PM +0800, Chao Leng wrote:
> Do not use blk_noretry_request. The local retry mechanism, which is
> defined by nvme protocol, is conflicted with REQ_FAILFAST_TRANSPORT.
> blk_noretry_request is not a good choice for nvme, even for SCSI,
> this is not a good choice too, so SCSI does not use this MACRO.
> We can seperate REQ_FAILFAST_TRANSPORT with other FAILFAST flag.
> For REQ_FAILFAST_TRANSPORT, do local retry for non path error.
> For other FAILFAST flag, complete request with error code immediately.

As said before - please prepare a series removing blk_noretry_request,
and fixing up any lose ends, with a good explanation of what in-tree
supported use case this fixes for you.  Out of tree modules are
completely unsupported, as is ANA with dm-multipath.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
