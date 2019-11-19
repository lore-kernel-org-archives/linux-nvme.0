Return-Path: <SRS0=E+1U=ZL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A52C432C0
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Nov 2019 00:34:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED49422313
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Nov 2019 00:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AZvldrfa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcaSktkT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED49422313
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0Oy0CvPDOxFWiS4J17fcbQA/1IgMKFH2RaiQ2iQPp0A=; b=AZvldrfarIoU45
	IyWgmpoy7szvK8prxj0Xnk2ZMC3N9ji0JXr6z2x8TAQEpUmXvmYYRAjwf+I+/Dg/urNfSwohrigEv
	U6CVv/v2fdaojkHJHUO4ZeyZhZP1ET2tzpVbYnv2xjakOo6W7bm5nXXYjvQX2uHt/qXr7Z7PdYQA0
	ztHSMgMUL7LMXjTbdIPDhrlb7cV43OG7t4CRaHqOQ/4HNXcXkzslQyMqNjb+CWwwKx4B3BfShaf7l
	NanRcasiK6Ti7APl6B/U9Mte41UD9o2B9PLW9cV9pPIQTGatjcSJR47zY/abbhONe7uvss+oNAIcc
	C5LncXbI+c5S58toZLqg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iWrTi-0004pm-Cv; Tue, 19 Nov 2019 00:34:46 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iWrTf-0004p2-PL
 for linux-nvme@lists.infradead.org; Tue, 19 Nov 2019 00:34:44 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 16D542230B;
 Tue, 19 Nov 2019 00:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1574123682;
 bh=M274F5zR/Oyk28DX3L9hfU3Cu9CLN6grskgFrtA5yj0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UcaSktkTP4FvrY1hWFd3C8EOi3IvE1kWakBQiXFiOc8PzkoCTDiOU+Cd43t7fsMzz
 L8s/zRU7DkPKEoPP4sKJ6Z4A+/BazIXRKM+UnYrCYx0QswXFB9JouKUbFrfDUsbNBl
 PrNL5+3g4JJ6s3Mp6lVCQmZ8tgV6jbHSkA1DoDFE=
Date: Tue, 19 Nov 2019 09:34:37 +0900
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH RFC 0/3] blk-mq/nvme: use blk_mq_alloc_request() for
 NVMe's connect request
Message-ID: <20191119003437.GA1950@redsun51.ssa.fujisawa.hgst.com>
References: <20191115104238.15107-1-ming.lei@redhat.com>
 <8f4402a0-967d-f12d-2f1a-949e1dda017c@grimberg.me>
 <20191116071754.GB18194@ming.t460p>
 <016afdbc-9c63-4193-e64b-aad91ba5fcc1@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <016afdbc-9c63-4193-e64b-aad91ba5fcc1@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191118_163443_844286_9339F1B6 
X-CRM114-Status: GOOD (  13.05  )
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
Cc: Jens Axboe <axboe@kernel.dk>, James Smart <james.smart@broadcom.com>,
 linux-nvme@lists.infradead.org, Ming Lei <ming.lei@redhat.com>,
 linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Nov 18, 2019 at 04:05:56PM -0800, Sagi Grimberg wrote:
> 
> I'm starting to think we maybe need to get the connect out of the block
> layer execution if its such a big problem... Its a real shame if that is
> the case...

We still need timeout handling for connect commands, so bypassing the
block layer will need to figure out some other way to handle that.

This patch proposal doesn't really handle the timeouts very well either,
though: nvme_rdma_timeout() is going to end up referncing the wrong
queue rather than the one the request was submitted on. It doesn't
appear to really matter in the current code since it just resets the
entire controller, but if it ever wanted to do something queue specific...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
