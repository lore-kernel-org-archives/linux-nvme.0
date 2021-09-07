Return-Path: <SRS0=5VvL=N5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62687C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Sep 2021 07:11:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C8A46103E
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Sep 2021 07:11:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2C8A46103E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rp8x+e8WAL/T7nBwsbw7UiyhU1O9xFqpYc8a4J6mI9c=; b=KQoSvXnQMjW5HK
	aQdmRRPfvlURF7BMSAnPEpRZHQZc9fW/KAbXLhb2opGDn6doGAHkT374YN7dEovn+7O8R3y7caDp3
	eUyI9HDPHmSagHZ2EYwVYBQgdzg//ndkqSOgjtqsDhiAjKpvGftbsNE68dzTlqWLGVa30TwvnP6Iq
	A4xUJyc36yP/WcbTJKWFvHwT3ZJzAvSqqzedkALLlfmOehTXuXUZ87KD4JQdJNx1gXdcejaF0mE2x
	PwTd6EiLVc7MFiQvu0uk0MRTJkuUWFB9JZSRRBHL+f7dpfK97maqfsloPYdeaFj6UsM5t1fvNsHE1
	B1TRS8oj9nVRdkhjSC0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mNVFj-002g80-3g; Tue, 07 Sep 2021 07:10:43 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mNVFf-002g6C-Hx
 for linux-nvme@lists.infradead.org; Tue, 07 Sep 2021 07:10:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 41CC867373; Tue,  7 Sep 2021 09:10:35 +0200 (CEST)
Date: Tue, 7 Sep 2021 09:10:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk
Cc: kbusch@kernel.org, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, anuj20.g@samsung.com,
 javier.gonz@samsung.com, hare@suse.de
Subject: Re: [RFC PATCH 0/6] Fixed-buffers io_uring passthrough over nvme-char
Message-ID: <20210907071035.GA29874@lst.de>
References: <CGME20210805125910epcas5p1100e7093dd2b1ac5bbb751331e2ded23@epcas5p1.samsung.com>
 <20210805125539.66958-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210805125539.66958-1-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210907_001039_787455_9FCEAEB3 
X-CRM114-Status: GOOD (  11.42  )
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

Sorry for taking so long to get back to this, the previous merge
window has been a little busy.

On Thu, Aug 05, 2021 at 06:25:33PM +0530, Kanchan Joshi wrote:
> The work is on top of  Jens' branch (which is 5.14-rc1 based):
> https://git.kernel.dk/cgit/linux-block/log/?h=io_uring-fops.v5

I think we need to have this reviewed on the list as well.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
