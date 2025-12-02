Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F3DED116FE
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Dec 2025 20:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6Smm4dmJ1uJn29R0lAPODzQiBT6Wt0yE+mY6KVWUz0U=; b=rlEzjMx0KJ4jw287sYMcNlykwt
	O2zF8tOV0yY/56ULjXYcLXgnZfhoUZOFu7yTyLCZrWkxeZEmvsuLThtJ9Nv4ylJi66GcfEq32EqT6
	xIKxAYzqELg3n1egAwBQ7GPBFHOZdGwEwU5dAzZIEZNymDAwGme7Maz8Esh1YMI69ejX4YMNLbSA5
	5k2cHa8xch/gY5eM3n8J+VDfrMgiU0i86AphqHzmnOCPugQq+Uv2W27gnP96zXpR2xL+j2QBNJo0Y
	iM4BVi/fFZLKQc4wSqc9rN0p/Kd6RwlcPMulKqCf0a11az432f21PC+qzN+JJ86+xeX5LEeg6VKC4
	O+GzhG1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQX4f-00000005nvT-0VhU;
	Tue, 02 Dec 2025 20:34:13 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQX4Y-00000005nux-2sUy
	for linux-nvme@lists.infradead.org;
	Tue, 02 Dec 2025 20:34:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A112443804;
	Tue,  2 Dec 2025 20:34:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA57C4CEF1;
	Tue,  2 Dec 2025 20:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764707644;
	bh=Cf6b4+V9opVKdSSXm4y65skKTdpW57ouuA6/NZAkz9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HMr75TkANL7F961M1dO/iNCaIJhFpl3hAqGapApldoKEGQoTMvo0PLffblA6fUDHg
	 y7AS+gioPIZ3vrr76LZ5vcXCnO2XNH04RAYqcH7R/kIsUyIIJp6GBHdnlRuEHhuBPu
	 LjcVMDvquehHwSIDNz8V2daHPHek0yowK/mjFR/A1orD1n/5K5g3H6wTuJITutsyJe
	 bdOoR52klw0VZ0+oD+hGd0RcDabm/xsTFsbkffItl8dLVTt3y0SQxm2G/hq/huxvPO
	 FA6Yi6wcK/rUahjVZOB47HepRmIqKT5iR5tQVVetKGauo6NJfDUB+KV5GpdnPvtg7B
	 I80dE06vCOprA==
Date: Tue, 2 Dec 2025 13:34:01 -0700
From: Keith Busch <kbusch@kernel.org>
To: Eugene Korenevsky <ekorenevsky@aliyun.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] nvme: nvme_identify_ns_descs: prevent oob
Message-ID: <aS9NOSxJk66vu2Dj@kbusch-mbp>
References: <aS3v2_VcV8IwsT6g@localhost.localdomain>
 <aS4yhAhZYjvHOqtD@kbusch-mbp>
 <aS9MTGx6V6VacZeH@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aS9MTGx6V6VacZeH@localhost.localdomain>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251202_123406_742992_48761A66 
X-CRM114-Status: GOOD (  12.08  )
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

On Tue, Dec 02, 2025 at 11:30:04PM +0300, Eugene Korenevsky wrote:
> OK, tried to make the patch as close as possible to previous code.
> See v4.

Yep, I saw. Mostly looks good to me.
 
> Also, adding 'pos += len' to modified `for` makes the line longer
> than 80 symbols. However, checkpatch.pl says it is OK. Let me know
> if it should be fixed somehow (e.g. by moving 'pos += len' to the
> end of loop compound statement).

The convention for this driver is to wrap lines at 80 characters. But
don't worry about sending a new version for just that; I can fix that
when applying.

