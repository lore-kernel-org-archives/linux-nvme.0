Return-Path: <SRS0=0To6=77=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD96C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2020 14:37:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F89A20773
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2020 14:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i5lPoxLP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F89A20773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=w/8Gfd2Ng16ePx1eHocu/7DbovVUu5lolFemXil/rw4=; b=i5lPoxLPq2Xt1c
	CVG7S5I8TbiNbZpS9mC+du3cHShz4UUXDJ/dJV7XdT/2wXxCeTnBGPqTTtB/WvIQT5oWhXYjqO/uK
	htIQIj1LMfLICoJhZCYvhU629vQ1C9jk1OdmrArU+L4ooykHIBzdIb+DwCkkiakk6D9XAjVbI0W7T
	auDBHzKoEijv19z0tKJv29T+GT7XUIgBfoVRC6V0T84VN3xZRrujX2zncN5V/9cmoEFszh3wYbaJH
	zT/Y8LpYw9yLZNYijpa8RGruBopmiIDtRrq+tVuzVB4wbynrbCWTa4h5rlMTn3LfIl6c82bnBiShO
	sniXQyz251cJxVYNSoTA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jlvfT-0008Tg-Ha; Thu, 18 Jun 2020 14:37:27 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jlvfQ-0008Sy-OI
 for linux-nvme@lists.infradead.org; Thu, 18 Jun 2020 14:37:25 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id BA57BACF9;
 Thu, 18 Jun 2020 14:37:19 +0000 (UTC)
Date: Thu, 18 Jun 2020 16:37:19 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 02/12] blk-mq: factor out a helper to reise the block
 softirq
Message-ID: <20200618143719.aakeh5ciazsg23gv@beryllium.lan>
References: <20200611064452.12353-1-hch@lst.de>
 <20200611064452.12353-3-hch@lst.de>
 <20200618143404.ro2kviia72qy6niv@beryllium.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200618143404.ro2kviia72qy6niv@beryllium.lan>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200618_073724_933718_461CA0DA 
X-CRM114-Status: UNSURE (   9.18  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jun 18, 2020 at 04:34:04PM +0200, Daniel Wagner wrote:
> Couldn't this be folded into the previous condition, e.g
> 
> 	if (ccpu == cpu || shared || raised_blk_irq(ccpu, req))

to answer my own question, patch #3 does addresses this :)

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
