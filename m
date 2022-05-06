Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43EABC433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  6 May 2022 15:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8UncsHNdMIsvpUAtoQR+iW3+vVF0t6rUk5pOWiyUgs8=; b=I9aPbiKW5BAqv9ct1sG4A4fqo8
	G8Dp67BA05Z0UCgd7dUDMouwH92JYHRaqUDNPdpGEL22kYLXR0CCaypwX7mMI8s4rOXS9ptiWB9Z4
	lImk6PqJ2fq0RNMGSWfjzWN+34OyZRL+sKak74C5bTUrXX8nIe4eNhVWCtD3igZF+ZAH6T4BfdRwa
	2xbtIBmdwV8NHYZY7/9Xn0WqmtqDK87kpu3qNxgFCtF5MRLEzgKtELQNoYZpdAOkDLHQelVQRzqKf
	TW7TvWmGs3ZsiNwwflU4UVzDlWGYWmudtA49k1hecS2HV+TcpR8kUWyIxj6XNUNs2ww6uJ93MScgv
	eXqXM47w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmzXW-003yBb-E1; Fri, 06 May 2022 15:06:42 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmzXR-003y9a-Az
 for linux-nvme@lists.infradead.org; Fri, 06 May 2022 15:06:39 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 46685621B7;
 Fri,  6 May 2022 15:06:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0254C385A8;
 Fri,  6 May 2022 15:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1651849595;
 bh=Iptv53vFJdhpTSGnrF5kGqg5MMjPl4LVxL18KjOlJdU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BOeD6zMCOEgi2nA2dh7h5wq6MvnRPFqEYkIiCxR5QL93OvqcpQgmFDJiqfHl6S7E0
 P2htJJ6aGVDVXyu8L5Mi6L8i04N1QQ4t95AprtM4Jl9amUCADeCsh2Ghd5gASS+jKf
 xR0FNfznCpAtqAloZ3ZIsh4BoL/KVDznYqZn4V0mVJ45yRRV/0S0SQlHn8LdP7bjA+
 FV0yvq8C9GDQc3OI4JJ7+7cbQNJo+2kGvNlW8FE7X5tfta5IHfiGWUQKlrLgY/CRV3
 Y9X0rXYOmjxTjmD2HjXjFLtlKEa3FmhPVQ+sDnE2gFo779YNP+UnLTuiEvAOzbE7fl
 DHa4iKDssodLg==
Date: Fri, 6 May 2022 08:06:33 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>,
 Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] nvme: Ensure ret is always initialized in
Message-ID: <YnU5eTFPwXQnpATv@dev-arch.thelio-3990X>
References: <20220506150357.2443040-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506150357.2443040-1-nathan@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220506_080637_474205_9B4D6CE4 
X-CRM114-Status: GOOD (  23.72  )
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

Ugh, subject should be:

nvme: Ensure ret is always initialized in nvme_ns_head_chr_uring_cmd()

I can resend if this is the correct thing to do.

On Fri, May 06, 2022 at 08:03:58AM -0700, Nathan Chancellor wrote:
> Clang warns:
> 
>   drivers/nvme/host/ioctl.c:674:6: error: variable 'ret' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
>           if (ns)
>               ^~
>   drivers/nvme/host/ioctl.c:677:9: note: uninitialized use occurs here
>           return ret;
>                  ^~~
>   drivers/nvme/host/ioctl.c:674:2: note: remove the 'if' if its condition is always true
>           if (ns)
>           ^~~~~~~
>   drivers/nvme/host/ioctl.c:672:9: note: initialize the variable 'ret' to silence this warning
>           int ret;
>                  ^
>                   = 0
>   1 error generated.
> 
> Initialize ret to zero so that it cannot be used uninitialized.
> 
> Fixes: 271ee3df5cca ("nvme: wire-up uring-cmd support for io-passthru on char-device.")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1630
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> 
> Or alternatively, remove the 'if (ns)' if ns can never be NULL; I tried
> going down the rabbit hole to see if that is possible but I got a little
> lost :^)
> 
>  drivers/nvme/host/ioctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> index 9db88f2c15f8..3ad5285c1f96 100644
> --- a/drivers/nvme/host/ioctl.c
> +++ b/drivers/nvme/host/ioctl.c
> @@ -669,7 +669,7 @@ int nvme_ns_head_chr_uring_cmd(struct io_uring_cmd *ioucmd,
>  	struct nvme_ns_head *head = container_of(cdev, struct nvme_ns_head, cdev);
>  	int srcu_idx = srcu_read_lock(&head->srcu);
>  	struct nvme_ns *ns = nvme_find_path(head);
> -	int ret;
> +	int ret = 0;
>  
>  	if (ns)
>  		ret = nvme_ns_uring_cmd(ns, ioucmd, issue_flags);
> 
> base-commit: 002b149a51a53facaf26d7c6f2c1fe718673683c
> -- 
> 2.36.0
> 

