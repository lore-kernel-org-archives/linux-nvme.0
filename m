Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002D2C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 06:37:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2A7C207DD
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 06:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QWjC9cDt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2A7C207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KfiFEn9B3632cx1qDP8jvtyjj25r5HHjy8Vjb1twUyE=; b=QWjC9cDtF76YjEgU/tVQmHmqs
	6nRUwbG0yUweIZSyOTluH51+sYIwG6NTBdTQnEnG72SHevmPSrEZQEqeFnt1Tcxq5lSUdeGQjH0vX
	PTdu914RdXFeVB1MC5gqwQe+v/YuuquyyK266FoLp5Ekyv6zcI2VLVB+WhlheZMCMpWr4X2V87aMK
	GEG4+CteMh1c5iB0Uwdu9FPzC7XKuE5PxuGvnqRut3NDY6qcAGbVzK1sNrLFta16yPrHFHZTzTmkL
	iR1A5dhhbwH+epoc8xAZV/lnU8P8csXh8kaiuwsJHjjtNucWyKhOSFyrTj9rPJEy8ltI49OoDI+G9
	ZSMtdyyAg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jnz2Z-0000O3-5o; Wed, 24 Jun 2020 06:37:47 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jnz2A-0000JD-Gh
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 06:37:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0A02368AEF; Wed, 24 Jun 2020 08:37:20 +0200 (CEST)
Date: Wed, 24 Jun 2020 08:37:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2 for-5.8-rc 3/6] nvme: don't protect ns mutation with
 ns->head->lock
Message-ID: <20200624063719.GC17594@lst.de>
References: <20200624001853.5408-1-sagi@grimberg.me>
 <20200624001853.5408-4-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200624001853.5408-4-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
Cc: Keith Busch <kbusch@kernel.org>, Anton Eidelman <anton@lightbitslabs.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jun 23, 2020 at 05:18:50PM -0700, Sagi Grimberg wrote:
> Right now ns->head->lock is protecting namespace mutation
> which is wrong and unneeded. Move it to only protect
> against head mutations. While we're at it, remove unnecessary
> ns->head reference as we already have head pointer.

The changes look reasonable (nitpick below), but this changelog doesn't
sway what the problem is and how it it fixed.

> -	synchronize_srcu(&ns->head->srcu);
> -	kblockd_schedule_work(&ns->head->requeue_work);
> +	synchronize_srcu(&head->srcu);
> +	kblockd_schedule_work(&head->requeue_work);
> +	mutex_unlock(&head->lock);

Can't we move the synchronize_srcu and kblockd_schedule_work out of
the lock as well?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
