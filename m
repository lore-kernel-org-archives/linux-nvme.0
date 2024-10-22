Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B22D2CE05
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Oct 2024 17:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UvfKvl2k3wD45LGMKxuQoQcPmHIyeZrRMB+2ZknXwSg=; b=gdr3C4l80A54bou6Zn9XPU2ujm
	RX5Fv7Ojsjcj//NhgRVzoo1gI4//bqWIQ4i73PH5XuSE6R25JoygOjnow+wotRACZbNp8gWiW46hZ
	4qoNHZeGPGHEVFg3GYG48qZbG82t6BxO/foRRwSueOsLsH0Ii7WLfo67BWnDTaWeBoSobIAI0N/U5
	IwtkiJOuUps2fZq88cxAzLcjpY8H41oo9/nRjL8vWlqr0EkdnHx4QzOieVKInyvZNJVeo0h6jCzBp
	BCn9P8Mbx8NGDQsJHQOLnwB94gufqtZ8B4bEPspNirdWGP8rQZfVqskGhRenUpdUlPAR7LARyuSiX
	tznQk8MA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3IQk-0000000BbmL-27H1;
	Tue, 22 Oct 2024 17:12:26 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3I9k-0000000BYZO-32cS
	for linux-nvme@lists.infradead.org;
	Tue, 22 Oct 2024 16:54:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 908395C584B;
	Tue, 22 Oct 2024 16:54:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74DC6C4CEC3;
	Tue, 22 Oct 2024 16:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729616091;
	bh=vSQUa7AVMmY2fqX9bLCL4ekVYcjWj0Np8okjUzrUY8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iad6mWa2XevOl526CpTsK6+fOzatZU70/xmNBmpOYdod4dEfwSD2jDrN42I5DXX52
	 uUjiJG1Hhq0HPcZYUrBsQvo2O9QcxpgWto0DgtgEcwZu1r2KV7k/rdh32SzHjbIw0a
	 Y7VuX3H2N5cvf9Q3JavwLAOUCGZtafNa/ZcIF96wYn0EpzCxJ9VYr5LXgg+R1PWsmt
	 s2Tv9rFZJaKqKUNFJaHaAWMHe51IPyLx76DVOq/stoIasKqnLM4Z7NxUBEM77qhapv
	 z08rwuZjt+1bd9pC6Y2Po+4cx3Ki5wBsrbCxY7w8TY0337AU5TL590PT0yuS7GMHK9
	 RIP3/tXa5gVcw==
Date: Tue, 22 Oct 2024 10:54:48 -0600
From: Keith Busch <kbusch@kernel.org>
To: Tokunori Ikegami <ikegami.t@gmail.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: check PI size if metadata size or below
Message-ID: <ZxfY2IT15o_2vTZq@kbusch-mbp>
References: <20241022163504.10738-1-ikegami.t@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022163504.10738-1-ikegami.t@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241022_095452_825874_85788FC5 
X-CRM114-Status: GOOD (  13.02  )
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

On Wed, Oct 23, 2024 at 01:34:27AM +0900, Tokunori Ikegami wrote:
> -	if ((io.control & NVME_RW_PRINFO_PRACT) &&
> -	    (ns->head->ms == ns->head->pi_size)) {
> +	if (io.control & NVME_RW_PRINFO_PRACT &&
> +	    ns->head->ms >= ns->head->pi_size) {
>  		/*
>  		 * Protection information is stripped/inserted by the
>  		 * controller.
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 093cb423f536..fbcb2243ba84 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -542,7 +542,7 @@ struct nvme_ns {
>  /* NVMe ns supports metadata actions by the controller (generate/strip) */
>  static inline bool nvme_ns_has_pi(struct nvme_ns_head *head)
>  {
> -	return head->pi_type && head->ms == head->pi_size;
> +	return head->pi_type && head->ms >= head->pi_size;
>  }

It would have been nice if PRACT worked this way, but spec says it
doesn't. The control bit is a no-op if Metadata Size does not equal the
PI size, which is what these checks are looking for, so we can't take
this.

