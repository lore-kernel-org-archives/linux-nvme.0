Return-Path: <SRS0=T5dq=OD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F14C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 16:02:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32C85604DC
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 16:02:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 32C85604DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=x+W2hixWlemKfqFEN+xllO+nb2li90C9qEF103LmSjo=; b=ebwWCTJMkTSOji
	9eCjy4+rJSBBVtOE7lLN5T3j2EE3P2xiyIdxWvk3/A5ogW9M97yj13/tV+vIbaUoRwZaUoDq3MUxD
	40wq3yITRYT7X6TQ1twourozzuv6wTxZ+beZeCkbKOoo68L1G8h839mJHfdEYF9DVUxz/IL7dA1Nh
	tHXKgwbzF0Te0uNb7W5fOkbfbEbP6fDMwO1QItaXFi2yYwtdLN5gDme0QIPEMMHjWHL7nvNt4KAaR
	HLDm9/OM5XMsU21ssmTfiiztUSKmRwnlHp8yJCCx343W2l6jDJ4J3wOd9w4siLfqnjazOywcRMlCq
	/1/tHxZUpBpCHezUp88g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mPoPZ-002GjJ-M1; Mon, 13 Sep 2021 16:02:25 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPoPX-002Gha-CC
 for linux-nvme@lists.infradead.org; Mon, 13 Sep 2021 16:02:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 08A8867357; Mon, 13 Sep 2021 18:02:21 +0200 (CEST)
Date: Mon, 13 Sep 2021 18:02:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anton Eidelman <anton.eidelman@gmail.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, axboe@fb.com, Anton Eidelman <anton@lightbitslabs.com>
Subject: Re: [PATCH v2 2/3] nvme/multipath: cosmetic: keep ns nsid locally
Message-ID: <20210913160220.GB6442@lst.de>
References: <20210912185459.13496-4-anton@lightbitslabs.com>
 <20210913153023.70879-1-anton@lightbitslabs.com>
 <20210913153023.70879-3-anton@lightbitslabs.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210913153023.70879-3-anton@lightbitslabs.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210913_090223_630238_438E378B 
X-CRM114-Status: GOOD (  10.76  )
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

On Mon, Sep 13, 2021 at 09:30:22AM -0600, Anton Eidelman wrote:
> Keep the nsid of the current namespace in a local variable.
> Change the type to unsigned int to make checkpatch happy.
> 
> Signed-off-by: Anton Eidelman <anton@lightbitslabs.com>

I can't really see any improvement here.  Also checkpath as so often
these days is fundamentally wrong here.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
