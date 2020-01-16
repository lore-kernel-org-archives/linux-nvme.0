Return-Path: <SRS0=1/6V=3F=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D637BC33CB1
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jan 2020 16:40:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A47552073A
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jan 2020 16:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MW5SuUDk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A47552073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AOGJlCeQPiUjezFKU4HgYPaeEZPw4pmj0YRz41A2JjY=; b=MW5SuUDkUWnwjk
	Gvseopmt4eFZh+IeYWUqfs5qDj2l1kZ4hYvijJfqe3XXiGqKweiAKpq/CC1DKvvPtpH6YdoVNBUc3
	aWzC+mvgJCGP5XjvtG+n1tOmivXAVp1Mj9v2LdmnQpOnuwoeEQq2wUmz4qwcszYjzg9DGnO6C4opm
	ilGXm3eZhDZCNjB/m8j6/In/KzuZ1NcgysxaqXp8F3Osxq7Gof0O/2dN6geMbOUZ98+xKsv0j7YUa
	ny9YporeR91wNSFDpRy+7lusCBVnI0NAXTy1LNoNYyBK0DuxjwGiIbbrhZErRbTMOzEGZO7Fc+/fy
	vPt0S8hepBFWbQNdc11w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1is8CT-0006UG-9G; Thu, 16 Jan 2020 16:40:53 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1is8CL-0006Td-9u
 for linux-nvme@lists.infradead.org; Thu, 16 Jan 2020 16:40:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id C16F068B05; Thu, 16 Jan 2020 17:40:42 +0100 (CET)
Date: Thu, 16 Jan 2020 17:40:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH V5 2/4] nvmet: make ctrl model configurable
Message-ID: <20200116164042.GB23501@lst.de>
References: <20200109050244.5493-1-chaitanya.kulkarni@wdc.com>
 <20200109050244.5493-3-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200109050244.5493-3-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200116_084045_494375_0A781ACB 
X-CRM114-Status: UNSURE (   6.73  )
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
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> +	down_write(&nvmet_config_sem);
> +	mutex_lock(&subsys->lock);
> +	new_model = rcu_replace_pointer(subsys->model, new_model,
> +					mutex_is_lock(&subsys->lock));
> +	mutex_unlock(&subsys->lock);

Shoudn't this be mutex_is_locked as there is no mutex_is_lock helper..

> +
> +	kfree_rcu(new_model, rcuhead);
> +	up_write(&nvmet_config_sem);

I think the kfree_rcu should move outside nvmet_config_sem to shrink
the critical section.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
