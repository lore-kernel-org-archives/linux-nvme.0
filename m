Return-Path: <SRS0=cJ6X=ZA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA03C5DF60
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Nov 2019 04:13:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 510212166E
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Nov 2019 04:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lQoGJiGX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDczIt/H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 510212166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lcZfrbJDY533iZbpDkphDSR0JkbWcth0N6vA4fbKkWg=; b=lQoGJiGXZ3RVE9
	CNcPnyXFULt2Z4uDRFZCP22T59aR6gZbTt2TB5SLMWKPIPlHgq1izjU+4/zKeSZg+erhy0tcuSqrH
	83aSl8yx+g2v57WxuZhxybc+nyD1Kf4UZunApLv2ixwgpzPLrE20Ur9Paxe1038LM99oSxcBYMUXX
	nDyFR3ingagPjkqzzuFHDzfFW0Qj5SLFZcjQHX4lCcWVrAB0B92fAiIllesCraCTgr/Z5K9o2w0yN
	bwnfLdn3Y3HmNJsQqXx43TCuLvoi80jIdQxxdknyRHRvDDywsZHsleBtaVxIXOCxA9I15L6fQs+Mf
	NT0g9vnL1lD3bgERM2Og==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iSvdt-0002eR-A2; Fri, 08 Nov 2019 04:13:01 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iSvdr-0002e0-29
 for linux-nvme@lists.infradead.org; Fri, 08 Nov 2019 04:13:00 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5A68C2166E;
 Fri,  8 Nov 2019 04:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1573186378;
 bh=Lx4Htpx3ec89XXjrmdKCN+/oWOmGeEMpob4iH3bxjYs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tDczIt/H+Qq5grq+w6qWgaJaLlu3EACHMoornA7xbbMmOEgi3sR0pQj1KV2hRKQ4Y
 VAP8S5w5vBzIeRNZvLNrJAa1ky4rZhaCJQ+OjiQ8+p2iWNhVrkxwLfPxragkzo3RE1
 loqW/LPhWWJJ6Lr5Xjgi3tlylhXF5xrkD/duMeso=
Date: Fri, 8 Nov 2019 13:12:51 +0900
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 1/2] nvme-pci: move sq/cq_poll lock initialization into
 nvme_init_queue
Message-ID: <20191108041251.GA2775@redsun51.ssa.fujisawa.hgst.com>
References: <20191108035508.26395-1-ming.lei@redhat.com>
 <20191108035508.26395-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191108035508.26395-2-ming.lei@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191107_201259_122451_967C2B2B 
X-CRM114-Status: GOOD (  10.50  )
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
Cc: Jens Axboe <axboe@fb.com>, Long Li <longli@microsoft.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Nov 08, 2019 at 11:55:07AM +0800, Ming Lei wrote:
> Prepare for adding new cq lock for improving IO performance in case
> of multi-mapping queue, and the new added cq_lock can share space with
> cq_poll_lock.
> 
> Move sq/cq_poll lock initialization into nvme_init_queue so that
> we may initialize the added cq_lock correctly and lockdep warning
> can be avoided.
> 
> This way is safe because no IO can be started until nvme_init_queue
> is returned.

Yes, but we call nvme_init_queue() on every reset. I think it looks it's
okay to reinit a lock as long as it's not held, but it really shouldn't
be necessary, right?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
