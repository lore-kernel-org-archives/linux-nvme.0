Return-Path: <SRS0=PLgZ=IB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6F8C433DB
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 22:37:53 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A98364EA4
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 22:37:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A98364EA4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2aG9LssJKlettJHByr6ixhftNDcguq67NWobxjSEKas=; b=qTPl7vj9CeQ2pjwVpHI4EtrWy
	Y+AUzlpkNocyOc04i+K6TvsjfPaXsgIzLTt8ZvYB8Z7ja4SX6VRF8rV8MS2ZHSrfLUQBP3+gAj6GX
	Q9ulYZNmlYwa0wyeZMRlfPRsUCb6KWh580lz3TRpraOdgbtks/Vb9u4PFxDbRsQjFXyojSlPNzt64
	cLtHefHK6k1Fv9IYCTErUtMuqxh1QYpC4YhbSLPuZMHNw5AlebgGc7MFp0n2AaQWoTFX6o6NM+ogt
	4hSrgPPabZgDGkwYVScZPYBA5sba3Iy+7tT8oPsYkSNuN09JzC4rZHJKa6eO8/+0q3eZI2BtDw3ed
	XVy1tyrrA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHa7g-006m38-Dz; Wed, 03 Mar 2021 22:37:41 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHTB6-005Kpq-K4
 for linux-nvme@desiato.infradead.org; Wed, 03 Mar 2021 15:12:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=wvdZWLneGG7NCsCyIPPTzZr1awqe7lPd+qOqTz4yafo=; b=qnfjsNB6facLJEPwlI+sqiILq/
 KCaM7aP3M4RLwk7gf321ae3KJdl1o1ioQ4TEslJmwRHRBlHyC9RxcF6aFriPA5iGwEPHkcsIgW8zz
 u7V60TkHuxbv1AeVUKS7ug21yI8JVPp7gjAqkVngv9gYC8htMy37jAeqhb+7da7CzUo5VdXuO9dWK
 YUbHuydZW+651xkXQE2wWmpb/mPqZ+OvhQeMmEvIdbaiY0I75ReWz4OE6PKVYDFBLLr+29M+WNcig
 Z0ZHmunCiNuRvKJRbbRr+P1mgFkJFi8pGKxIBTb08VeF5amVyuOxn+pVX7aww2w4bBWXFGTpFDVhp
 w1HpU5fw==;
Received: from verein.lst.de ([213.95.11.211])
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHQgI-002YfG-KY
 for linux-nvme@lists.infradead.org; Wed, 03 Mar 2021 12:32:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 342E268B05; Wed,  3 Mar 2021 13:32:40 +0100 (CET)
Date: Wed, 3 Mar 2021 13:32:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCHv2] nvme: send uevent once a multipath namespace is
 operational again
Message-ID: <20210303123239.GA28477@lst.de>
References: <20210303121227.65688-1-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210303121227.65688-1-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210303_123249_030711_12CB0ED6 
X-CRM114-Status: UNSURE (   9.85  )
X-CRM114-Notice: Please train this message.
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

On Wed, Mar 03, 2021 at 01:12:27PM +0100, Hannes Reinecke wrote:
> In an all paths down scenario I/O will be requeued or aborted, and no
> further I/O will be ongoing on this namespace.
> This leaves the upper layers unable to determine if the namespace
> becomes operational again eg. after a successful controller reset.
> With this patch a 'change' uevent will be sent per multipathed namespace
> once the underlying controller moved to LIVE and started I/O processing
> by calling nvme_kick_requeue_lists().

This looks functionally correct, but I'm a little worried about the
nvme_kick_requeue_lists function name being a little off now.  Can
anyone on the list think of a better name?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
