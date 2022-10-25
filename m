Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A58ECDFA1
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 22:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T3VjNiv3RRJSbP29wYxbQj9v0Our5NtrZJDWtOG5IYw=; b=oPt8pt3SdIGefFSFrb2UP+JJmG
	xhTea9lEVi6q2ZcEvEIXTGK5UvZ69J+SVt3+8wcgK6vUUBCX67F8TYCJNyOfvi9ZoptngRDGcK6Gy
	51Fjbz2YH1GPVwCdeuGgW9RrqbLTQ+fYdJn9VBFfc5Yj5TpI6cghZNezuY3PUvpNcfZftPzPK/oa3
	w9uCR8lY7F/j94vpsMVgQrhEFNXRd4ufkcGauyk8Fup9nKzfDeydxtD+DgBAVgflO470JuiCqkUhN
	op7rF4/OI6VTJau7SfTYw1b5MPk4BWSDtM/6ja0gogQD0vtAwST1deAFuPevtXvAoRtX5F88amHd6
	IAlYHUpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onSae-007Qrx-Ek; Tue, 25 Oct 2022 22:40:08 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onSac-007QrC-B0
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 22:40:07 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B1A5161BBE;
	Tue, 25 Oct 2022 22:40:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4C4C433D6;
	Tue, 25 Oct 2022 22:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666737605;
	bh=QsLmNQLK9hrQ+9w+DGymM2b2NqUKEtn19jUXECHyZNM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Oby3UgqXWtt3rznL3m+4YgqhxRbxTKnQj69atceDrteKQp9/THJmL7oI2EcVnL/+p
	 9Zgb3k4BQdD0N0XN9ECjCd0VZxB0zyq9SV7KXBl4wQMCwMBMGFrxMzRn4pvrvbPvLv
	 xY4hvkOOHWED5HA69HutQ6Nmf1d2nPC801KrIAA0p+Xu0ZDDgF/UraynAYw5ZRa3R8
	 UfusV25HfnGDGreiCBQC9FBs1Qvv4o9OdQn5V280ksllhvykew7wq8aUkfHCSisCkq
	 KJwGUbiOCfe9igfUEElgcDfdYFry6s2cQ9MAnjtZybH0ft2p3iJWq5ApkAHp4Q+qMj
	 Lfci2h0I73j/g==
Date: Tue, 25 Oct 2022 15:40:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, saeedm@nvidia.com, tariqt@nvidia.com, leon@kernel.org,
 linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 kbusch@kernel.org, axboe@fb.com, chaitanyak@nvidia.com, smalin@nvidia.com,
 ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com,
 aurelien.aptel@gmail.com, malin1024@gmail.com
Subject: Re: [PATCH v7 02/23] iov_iter: DDP copy to iter/pages
Message-ID: <20221025154003.686cb8b1@kernel.org>
In-Reply-To: <20221025135958.6242-3-aaptel@nvidia.com>
References: <20221025135958.6242-1-aaptel@nvidia.com>
	<20221025135958.6242-3-aaptel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_154006_446983_15E9F227 
X-CRM114-Status: GOOD (  13.42  )
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

On Tue, 25 Oct 2022 16:59:37 +0300 Aurelien Aptel wrote:
> Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
> Signed-off-by: Boris Pismenny <borisp@nvidia.com>
> Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
> Signed-off-by: Yoray Zack <yorayz@nvidia.com>
> Signed-off-by: Shai Malin <smalin@nvidia.com>
> Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>

Great stuff :) Please get someone who matters to ack this.

> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>  lib/iov_iter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index c3ca28ca68a6..75470a4b8ab3 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -526,7 +526,7 @@ size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
>  		might_fault();
>  	iterate_and_advance(i, bytes, base, len, off,
>  		copyout(base, addr + off, len),
> -		memcpy(base, addr + off, len)
> +		(base != addr + off) && memcpy(base, addr + off, len)

