Return-Path: <SRS0=YrQE=HG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4E7C433DB
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 08:04:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B54464E31
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 08:04:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B54464E31
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mDZpKK9fCHf3G/Kskkc16lITSYSu0ebMI4llz58cpXc=; b=HniRwwu06ypkoMplc5cyuZQxf
	CvnDgPEEAVoMkCbZAkeCL0vvSuEvKTPc50rP96yD+Y92MeH/87pRWYDgPOwTu31FEh1DYP2HPlkvv
	Weg/ZICEmbRBQhpWlH3H07X8N3xO33xTsyfO+XaABM9/y7oY4qlbU66a5tGs8mbsXnauBPTD33Shg
	aQT/sBbIcGt1ya9wNrrUSaFryLfjIhG6KjXMiYCqguUDy3hm3vznUOhgJypNZzqVICXXV21hlpBDN
	pVHI38rM8V5DO/G3Pu4Ox2ufm6R/+QZbAgrFmYt7JUq9+8xrYi/spF9l2fftnZC2Sl60yYclQCdT1
	6BsM7IHQQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7ZdE-0001TK-75; Thu, 04 Feb 2021 08:04:52 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7ZdB-0001St-J5
 for linux-nvme@lists.infradead.org; Thu, 04 Feb 2021 08:04:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id A77D768CEC; Thu,  4 Feb 2021 09:04:43 +0100 (CET)
Date: Thu, 4 Feb 2021 09:04:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH v5 0/3] avoid double request completion and IO error
Message-ID: <20210204080442.GA30542@lst.de>
References: <20210201034940.18891-1-lengchao@huawei.com>
 <20210203161455.GB4116@lst.de>
 <7d39e0a4-3765-85b8-aab5-b0ded93f8bec@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7d39e0a4-3765-85b8-aab5-b0ded93f8bec@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210204_030449_753511_196867C8 
X-CRM114-Status: UNSURE (   9.85  )
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
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, axboe@fb.com, kbusch@kernel.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Feb 04, 2021 at 01:56:34PM +0800, Chao Leng wrote:
> This looks good to me.
> Thank you very much.

Thanks a lot to you!

Please double check there version here:

http://git.infradead.org/nvme.git/shortlog/refs/heads/nvme-5.12

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
