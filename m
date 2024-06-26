Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0FAC27C4F
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jun 2024 17:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IT8h/Qq58vDvyW6gRWtj9dbFpZk8EQlywh8n1so9UIM=; b=ZPMtX6kSahK7RoWdG5Rshu/ACE
	2fDPvOpDdsiVgb4QXsZ2r9AovnB9uRjSOp+P4SEcrqv0dPfbbAnZsV29l1dDUpeV94+MkAGjmrPnx
	YiZLoXuMhvbUDjJd98DAaV3IQfziv1jtLq8KgVpYhIoTD2mAIBKWiZx3vCs7F5NaYlgFIOMLIWPL2
	cFZGntyZCuR6k7MsH80HMYGzY2yxFpAnzxeDgAiY1r/8g58mA0GL+BVKtA6nwJ19h2xDvmLnhP2LG
	5YDUjgaSlcSRbs0Z15X3qB/pwQcRAe53cMbGZO21ay/soneaOGzTUWtPSZywJazZftAOB0/vXne3a
	6ijLsIGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMW63-00000007hkA-1zdM;
	Wed, 26 Jun 2024 17:06:15 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMW60-00000007hjW-0z5Y
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jun 2024 17:06:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 6A3A5CE0B15;
	Wed, 26 Jun 2024 17:06:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6287CC116B1;
	Wed, 26 Jun 2024 17:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719421568;
	bh=NGlqg/Pmt4gOfQtT4F33ND5D947m/+4mzw6M8io5Qtw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UfDdLa2S1ysiOoxcviyR4sD9rKUYuwGOxvS6LdOZDp60i58O8O/zKNCx8xVqnx9Mw
	 LmGDsy869BKdL+jUwonXLt/4TSeOgToxdM3UkkmnmgKeStZkvrDWD+HPg9nwV90kBw
	 hqo4bf4F2QabTiTSb+kSwp0ey36OEiffBOG+YpQT3yxG2tf8dP8Nfa8MEXVqNoylDF
	 tBzYbmIZb/DWI0qNqLL6MQ5eSEjdoqhJTYO7Scu2Sc978nDTaO0QlF0QEExjOYQSvP
	 Zt+Fv7574L1eefswOYgYSBFZT+tIRYGWNzdwaj53LPSQWjCPgji+/zh1U7Vj6mhiwK
	 IuGPIDjAcC4ug==
Date: Wed, 26 Jun 2024 10:06:05 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev, patches@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvmet-fc: Remove __counted_by from
 nvmet_fc_tgt_queue.fod[]
Message-ID: <20240626170605.GA66745@fedora-macbook-air-m2>
References: <20240529-drop-counted-by-fod-nvmet-fc-tgt-queue-v1-1-286adbc25943@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529-drop-counted-by-fod-nvmet-fc-tgt-queue-v1-1-286adbc25943@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_100612_661063_E61C6A9D 
X-CRM114-Status: GOOD (  27.05  )
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

Ping? This is still relevant and I don't think this is a compiler bug
that would justify withholding this change.

On Wed, May 29, 2024 at 02:42:40PM -0700, Nathan Chancellor wrote:
> Work for __counted_by on generic pointers in structures (not just
> flexible array members) has started landing in Clang 19 (current tip of
> tree). During the development of this feature, a restriction was added
> to __counted_by to prevent the flexible array member's element type from
> including a flexible array member itself such as:
> 
>   struct foo {
>     int count;
>     char buf[];
>   };
> 
>   struct bar {
>     int count;
>     struct foo data[] __counted_by(count);
>   };
> 
> because the size of data cannot be calculated with the standard array
> size formula:
> 
>   sizeof(struct foo) * count
> 
> This restriction was downgraded to a warning but due to CONFIG_WERROR,
> it can still break the build. The application of __counted_by on the fod
> member of 'struct nvmet_fc_tgt_queue' triggers this restriction,
> resulting in:
> 
>   drivers/nvme/target/fc.c:151:2: error: 'counted_by' should not be applied to an array with element of unknown size because 'struct nvmet_fc_fcp_iod' is a struct type with a flexible array member. This will be an error in a future compiler version [-Werror,-Wbounds-safety-counted-by-elt-type-unknown-size]
>     151 |         struct nvmet_fc_fcp_iod         fod[] __counted_by(sqsize);
>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   1 error generated.
> 
> Remove this use of __counted_by to fix the warning/error. However,
> rather than remove it altogether, leave it commented, as it may be
> possible to support this in future compiler releases.
> 
> Cc: stable@vger.kernel.org
> Closes: https://github.com/ClangBuiltLinux/linux/issues/2027
> Fixes: ccd3129aca28 ("nvmet-fc: Annotate struct nvmet_fc_tgt_queue with __counted_by")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  drivers/nvme/target/fc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index 337ee1cb09ae..381b4394731f 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -148,7 +148,7 @@ struct nvmet_fc_tgt_queue {
>  	struct workqueue_struct		*work_q;
>  	struct kref			ref;
>  	/* array of fcp_iods */
> -	struct nvmet_fc_fcp_iod		fod[] __counted_by(sqsize);
> +	struct nvmet_fc_fcp_iod		fod[] /* __counted_by(sqsize) */;
>  } __aligned(sizeof(unsigned long long));
>  
>  struct nvmet_fc_hostport {
> 
> ---
> base-commit: c758b77d4a0a0ed3a1292b3fd7a2aeccd1a169a4
> change-id: 20240529-drop-counted-by-fod-nvmet-fc-tgt-queue-50edd2f8d60e
> 
> Best regards,
> -- 
> Nathan Chancellor <nathan@kernel.org>
> 

