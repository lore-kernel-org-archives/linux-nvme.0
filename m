Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF7FC369A5
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Apr 2025 14:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pSBs9rVpFWimLtlvk7OYl8D+TaqgDsgENnBgHobZZN0=; b=3SxBlrBI8zP6IcR9ugRf1QAD2y
	/Q+gklCYyqhMCyWEzNLmObTbZ1HgB5H8cNRMrlUxlArntGOMaqkx0m007quXw8FoITNX3y9F9VwXC
	dodAdiDbwbY/a7BJ4/szzGgAUfeYf3agmq/Rfkq0N2lXZpnoumUxUsY/m0OYBbpauuOCsKgC9REWW
	WTSv1Q8ZKNqAV0dK5d1YmsgtCZtd5ljmiMM5X3A5GLKi7lxKuImGuh3EJgicUFKoqh/YU97d34lRX
	c6pMqZTBSyvSnnSl1eE7xqKnM25rXS7XS1FlgGpj+oDUC4HluFkW7372FS5tym+vSJ/BGgQ2iLzDD
	TfSclK0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u29sm-00000004Muy-2x66;
	Tue, 08 Apr 2025 14:24:56 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u29sa-00000004MrU-2snh
	for linux-nvme@lists.infradead.org;
	Tue, 08 Apr 2025 14:24:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 029FDA484DD;
	Tue,  8 Apr 2025 14:19:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B1FC4CEE7;
	Tue,  8 Apr 2025 14:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744122283;
	bh=Jtx+DukxJmTYr3ylJDLM0gTcS+LkDJEYleA9tiC6RMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nAOFaKLHJzvbYQtFPV0d74xYwFLgOb6AQHsh0/fncSECVunpQqEuX5CaWDNfwkEfO
	 ZdY1BRqIaXSb0kWikziBRfZexfoMoTwyVTaVs8qbGYdSDRdd5julrjNXUYILEY/IP/
	 AEhZq9o0Q/aZM5uHYRkGcDvDB0kdMf1bOhYULA5FMDms+zwMRY9c657Tfy+OHyqhxS
	 mj/mtpJ2ahEzQRjmef/4asgZmFJkVQzuv0syQ/VVjaVGEP0P/vBheXDNzUtar72bqd
	 I28w1Qg5BkkFEDgZvtu5kZbAfC11Up+m+j07mARHszSg/d7p1MMhwP1pRxe55SxKkp
	 zYHtbMP6KCUoQ==
Date: Tue, 8 Apr 2025 15:24:39 +0100
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Lennart Poettering <lennart@poettering.net>
Subject: Re: [PATCH 1/2] nvmet: make 'readonly' setting configurable
Message-ID: <Z_Uxp-IMSjHFgGDY@kbusch-mbp>
References: <20250403144747.43043-1-hare@kernel.org>
 <20250403144747.43043-2-hare@kernel.org>
 <Z-6s9_rE-qAmhn8w@kbusch-mbp>
 <20250404062126.GB31468@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404062126.GB31468@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250408_072444_785053_1F002046 
X-CRM114-Status: GOOD (  15.95  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Apr 04, 2025 at 08:21:26AM +0200, Christoph Hellwig wrote:
> On Thu, Apr 03, 2025 at 09:44:55AM -0600, Keith Busch wrote:
> > > +	mutex_lock(&ns->subsys->lock);
> > > +	if (ns->enabled) {
> > > +		pr_err("the ns:%d is already enabled.\n", ns->nsid);
> > > +		mutex_unlock(&ns->subsys->lock);
> > > +		return -EINVAL;
> > > +	}
> > > +	ns->readonly = val;
> > > +	mutex_unlock(&ns->subsys->lock);
> > 
> > Not sure how people feel about the "cleanup" constructs. If we're okay
> > using them in this driver, this is a simple use case for the guard to
> > manage the mutex:
> > 
> > 	guard(mutex)(&ns->subsys->lock);
> > 
> > And then you don't need to worry about unlocking.
> 
> I really hate it with passion as the syntax is so butt ugly and has
> no explicit unlock point.

Okay, that's why I asked. Some subsystems have embraced it, but not
others. Since we haven't considered it for nvme yet, this looked like an
opportunity to feel that out, and it's totally fine with me if we avoid
the guard model.

