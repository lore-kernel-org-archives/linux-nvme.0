Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D74AE77180
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Dec 2024 03:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6AtnGCWhgE5yRmnNWLd3jfQc69bM8/odC7co3wZHPtg=; b=H6cow7uKeyn1dDu9FrI2sOh/u9
	wePr6iVolrfTIYYb7KkDBBI0/KjapRYhaAq7M/gktNvQyuqcD1YrLbbaHErptZfTmgOUmjCa9JM/4
	cOMxFtHwnnM+0ku3vfWkskGB96rDSXyDdmbqeRoy0pD9uXE1NBic/VlKfkxg2kk0KznYLfBGmDRLN
	oFFuuAHV7JAVVqQvjtXu7mzpNLplm9CrN1zPKNBBuOaML+UAJviHE/HjF82oD/FxjCBKWyUQ9mPk0
	NV0Q5Xl/BHhS28IL5ooFN0wTHDwOjEEDPiQU7fdsCewWcN8TQIaWAEAaMs7SWjw6eX0SubdbAiCrm
	fUqDKvJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tK7jS-00000004lcf-11st;
	Sun, 08 Dec 2024 03:13:18 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tK7jP-00000004lc1-1hFe
	for linux-nvme@lists.infradead.org;
	Sun, 08 Dec 2024 03:13:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id B5FB9A40A85;
	Sun,  8 Dec 2024 03:11:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B12C4AF0B;
	Sun,  8 Dec 2024 03:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733627594;
	bh=6AtnGCWhgE5yRmnNWLd3jfQc69bM8/odC7co3wZHPtg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cn29ic7FLbypl46vgPx01MDVjPSj9TEjVOgR+Eauk381SOCsH1dCiQzCcV0iG4DD3
	 P9rt7P0TaZGGCcnc3RqtYU8YeCTSPVB+mvZgb7UrCK0k0bKyN92fMez7AzAvnGOfnY
	 zmuX2TmE9teGV3WHvTvG5haMkqDsGG3STghmAEAq3aGTBxbGXf1T6GVt5yI7NU3zPd
	 xlae84SaGouDNCiEC8WMGi8nsqBUcGX1Iyo9d1+D10iYE85F6+qB+Ov0+ghryDqD2k
	 JuP33eU7U1Al1MIC1GwRE0P/q+spxvUffyr11pZgt7hz3c/5o7zrHMJThz6QJeYZWf
	 MSZTzoDVRB5eg==
Date: Sat, 7 Dec 2024 20:13:12 -0700
From: Keith Busch <kbusch@kernel.org>
To: Yongsoo Joo <ysjoo@kookmin.ac.kr>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: fix return type of nvme_poll()
Message-ID: <Z1UOyFnUavHNJu5H@kbusch-mbp.dhcp.thefacebook.com>
References: <20241207045546.119933-1-ysjoo@kookmin.ac.kr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241207045546.119933-1-ysjoo@kookmin.ac.kr>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241207_191315_507836_C6127689 
X-CRM114-Status: UNSURE (   9.35  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sat, Dec 07, 2024 at 04:55:46AM +0000, Yongsoo Joo wrote:
> Change the type of the return variable 'found' from bool to int so
> that any interested caller can see not only whether at least one
> CQE was processed, but also the total number of CQEs processed.

It looks like all the interested callers only care if it's not 0, so I'm
not sure this is a "fix" as the subject says.

