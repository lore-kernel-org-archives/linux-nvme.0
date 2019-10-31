Return-Path: <SRS0=hE+E=YY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF45CA9ED0
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2019 13:59:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1C122087E
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2019 13:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XG0Q4BoZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1C122087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kKZUmnzeMOc74zUVERI/y5o1T1LJk9Tge6cUiJiawQU=; b=XG0Q4BoZBy/CWg
	B6F9or7EmAUMMHR5GMqcYENpnxjkpj+monBdZjvJ8p/bNGkrsAtbjjP5YOiHlfvxizQe1PJ9bS2MV
	TsnfTy1m+re57F/tcmWiId4aRzN2kUFXRVVBLphHZkEVSKppIM6mbB0jcnNeMg1z8di6zMU6soYY7
	E7POKEFjmfoXjQVvT6pMSn9my2lsUT9xxGNsSGQP7bC3dmP/TldXC4oYUQiLbkKLpKSKXazAab21g
	X5I0auvzSYye4l+lNY2V1/y52pwiyXqhtbVFDAsfck3jV+uXtAXpgymt7TerNOsTnwxbxn/RIYwBG
	f1xG1QaMYEDI2FUz9gmQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iQAyj-00066j-Mc; Thu, 31 Oct 2019 13:59:09 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iQAyh-00066O-7w
 for linux-nvme@lists.infradead.org; Thu, 31 Oct 2019 13:59:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5339068BE1; Thu, 31 Oct 2019 14:59:04 +0100 (CET)
Date: Thu, 31 Oct 2019 14:59:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: Charles Machalow <csm10495@gmail.com>
Subject: Re: [PATCH] nvme: change nvme_passthru_cmd64's result field.
Message-ID: <20191031135904.GA5180@lst.de>
References: <20191031050338.12700-1-csm10495@gmail.com>
 <20191031133921.GA4763@lst.de>
 <CANSCoS8rN6g7u6iG4SRTcXjdj68cbimvX1n1Ex+FBAkhAAivJA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANSCoS8rN6g7u6iG4SRTcXjdj68cbimvX1n1Ex+FBAkhAAivJA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191031_065907_438091_2434C70A 
X-CRM114-Status: UNSURE (   9.04  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 marta.rybczynska@kalray.eu, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Oct 31, 2019 at 06:55:33AM -0700, Charles Machalow wrote:
> Not quite sure what you mean by check for zero in the ioctl handler. I like
> the idea of being able to use the same struct for either the original or 64
> ioctls from userspace. I don't believe adding the explicit rsvd field
> allows that.

You might like the idea, but it fundamentally is a bad idea.  For example
you completely break architectures that do not support unaligned loads
and stores.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
