Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE14C5478A
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Feb 2024 18:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2ibMi011Q0EQJ9o5N8+D6BIUHCeYNiiNeqUGcZf3ooA=; b=KBnWVbEYSCeq5Ql+uhEl6ZuzR0
	4EOVK/kXEi25qZ0BdJjVNwwfXjgHJYwUmP16Xh2FAjkiaqfMTNor6ffhcM9+iPs/pcvvVf9UKprPS
	Tf30ILm9Agb91TpUMzYXnNcHZQY0EsPOWYa6kWmo5w1/mJHu1TQ8XO48fuT7o6CCcOK6ioLfOgn2N
	+fFzPfh3XACP7Kr6OfCDB6KOdmFEDiTK4VFhf+dR0Sbvo2X6TpEHUMWeze2+J/qqFkiE3Ba+6pEBM
	Duh9ogzaCYs0otdO6U5Pi0aetaP5WJQLTDCZr9NYBxpl9fov5EyAUselVQJO2yy/D1LSCXEMUv4pS
	qeYUJjkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcr1P-000000021Rh-1Vfk;
	Wed, 21 Feb 2024 18:08:43 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcr1N-000000021Qk-0jTO
	for linux-nvme@lists.infradead.org;
	Wed, 21 Feb 2024 18:08:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 70EECCE1E67;
	Wed, 21 Feb 2024 18:08:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52DC9C433F1;
	Wed, 21 Feb 2024 18:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708538918;
	bh=ZdzfCl7xfQ11ruU8SKUsvaXH4I+/m1mTExj7GwXWwU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kLNO8sIIUfSoRUZMnnU0uoP+z27gNOK+Knmi2TGLB8R3sXDzQIpjpzgL40zhPJstC
	 p7TupIwnFdhHM8xXE0kOLyk0ySaAbADhPMf+XqxKWfPTexUCXiwYodTTzt8nWeg9H+
	 UU9y789rdZLj23eejqG/4lHIF55ZYocW8rauUrrYwT/QnEu6WpEn0puELih+2uGiEh
	 dxAhiem5uKKbbTa06xyT6A9beCwSYfEEIlPj6ochmcoAmpQDErrQLbttvsxrDoHGgM
	 NaSdzd4kk1xNave0ECzf+5RjrMKkA08/EYIbEhK3uY3+3Dfvc3ZaTktcfxvN7s2e6v
	 BR5dKgAcRmggA==
Date: Wed, 21 Feb 2024 11:08:36 -0700
From: Keith Busch <kbusch@kernel.org>
To: hare@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme-fabrics: typo in nvmf_parse_key()
Message-ID: <ZdY8JAl921AnBWqi@kbusch-mbp>
References: <20240221134530.142842-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221134530.142842-1-hare@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240221_100841_409009_F602D9B4 
X-CRM114-Status: GOOD (  17.27  )
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

On Wed, Feb 21, 2024 at 02:45:30PM +0100, hare@kernel.org wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> Of course we should use the key if there is no error ...

Fortunately the part that mattered handles the error correctly, but
printing the wrong message is confusing.

Applied to nvme-6.8, thanks!
 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/nvme/host/fabrics.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 3499acbf6a82..ab5ac219b70a 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -637,7 +637,7 @@ static struct key *nvmf_parse_key(int key_id)
>  	}
>  
>  	key = key_lookup(key_id);
> -	if (!IS_ERR(key))
> +	if (IS_ERR(key))
>  		pr_err("key id %08x not found\n", key_id);
>  	else
>  		pr_debug("Using key id %08x\n", key_id);
> -- 
> 2.35.3
> 

