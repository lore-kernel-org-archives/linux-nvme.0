Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3148D5D688
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2024 21:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1ufFAguQv6xE1FuKw/f0rTK+In5uCORPKQiWUKsU1bI=; b=H33//Qgcm5MPA4/X1sE2wJI8uc
	2NkaOowx42Kr69ewNQ/HP/+TywvqGQwZu+REu9VAbG++N++mB3L/cobnNMvAMO06GmgfMiKlprm0s
	yJbIMQ7GybHiJ2eExVLwrXbyA4fdwnWtmAHgiBOm3wOi07dAKHvqjaZutZmVrfaMb75Tl/M8obds9
	R31sZ04XqIYAiDqDx7ExZvKqkLw2fBv1O5kPUDQHL7klDE2lliSLcXnZ2Z2DC+YTwrks5mSQeXdOF
	3X/kF4OktU20LJdR2KrP99e9nkXhC0pfidh1xOzuac9GJLz3rm0/6SgItAyMJpscHANB4UIZ1jj0I
	rQGBiahA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9AEi-00000008RHl-0pyw;
	Thu, 07 Nov 2024 21:40:16 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9AEg-00000008RHF-1RpD
	for linux-nvme@lists.infradead.org;
	Thu, 07 Nov 2024 21:40:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1B7D25C5553;
	Thu,  7 Nov 2024 21:39:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5373AC4CED2;
	Thu,  7 Nov 2024 21:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731015613;
	bh=I4LBPnqToniAOSLXeLg8j7CkNTi8gnD41hEMsaaNozs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u17hoUgjvBa5jzTtXJkHcSwZ6N5bbUrRi3IsS+H99O0J1osLQp4Q9gC0CT9gfu8wt
	 PLZnMvvMY1NNFE1iNwCPWpd6eWPcRUxWWBJqHQJHlCQw5lcGyEpeGwXTYLON5U+OGR
	 yNOfuR/NfG1HUHadZyGJb1jntEJiAf6MRoGo/9aRTPvY+Hu0Sfu8rtUFrtY42hpyMn
	 MBOb3Zk1DZgYgCh0dnA6RSj2neWFMG1ZAD6iL590y907ADUSsHgDpKB3if7dH2bLMe
	 wrOLmo5kSEd5XOW20WHqDGJyFncyFaUtq29w6QUQX5Y0CvfbI2iILq9lqF5zyMwLYa
	 FFShxIlbUIDog==
Date: Thu, 7 Nov 2024 14:40:11 -0700
From: Keith Busch <kbusch@kernel.org>
To: Tokunori Ikegami <ikegami.t@gmail.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: add temperature threshold hysteresis feature field
 definition
Message-ID: <Zy0zu0lXqFghcq8R@kbusch-mbp>
References: <20241105145628.11833-1-ikegami.t@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105145628.11833-1-ikegami.t@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241107_134014_597297_2773622E 
X-CRM114-Status: GOOD (  13.31  )
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

On Tue, Nov 05, 2024 at 11:55:36PM +0900, Tokunori Ikegami wrote:
> The definition TMPTHH field supported by NVMe 2.1.
> 
> Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
> ---
>  include/linux/nvme.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index b58d9405d65e..68c60b0b177f 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -1121,6 +1121,8 @@ enum {
>  	NVME_TEMP_THRESH_MASK		= 0xffff,
>  	NVME_TEMP_THRESH_SELECT_SHIFT	= 16,
>  	NVME_TEMP_THRESH_TYPE_UNDER	= 0x100000,
> +	NVME_TEMP_THRESH_HYST_SHIFT	= 22,
> +	NVME_TEMP_THRESH_HYST_MASK	= 0x7,
>  };

Let's not define new constants that are not used by the driver.

