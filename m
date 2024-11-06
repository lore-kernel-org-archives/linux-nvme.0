Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C123CD1CA17
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2024 05:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8AElb1Nzb7WvsWPuAK2NVIxG3yDmuTDord3oWSwojBk=; b=XFJUeaYtTquwwyEQYCUPLHcx1w
	nIH1FJqxUTGPjRYW0faKg6MCmJwo+XaSY8+znvBSgMPxgUad5pOmgU12b1RxGt8BoaqKLmilW0gVL
	hzBzlMzsyRuMthIKBOMlD8nBUnSJZaDKT8MJea5Jar9gXO+AwZzJWobe4Y3kXQUGSIHqlLw94JXFl
	a3i3Pm3o7sjR5AW+iFyszQGlBe0ORNLfWN4paab1gh9MB/s/NiOypGy04HE+JJhawHhxA364/5Lgd
	X+wuydUb1bmFbab6qIH82v4JNB20686uH787Hai/N2yTtjTdVZXXuuqmOGtCCHUykc8pzJr58e10s
	Vvfy1WoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Yk3-00000001sZg-0RPm;
	Wed, 06 Nov 2024 05:38:07 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Yjz-00000001sZD-3AQi
	for linux-nvme@lists.infradead.org;
	Wed, 06 Nov 2024 05:38:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3B15768AFE; Wed,  6 Nov 2024 06:38:00 +0100 (CET)
Date: Wed, 6 Nov 2024 06:38:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, m@bjorling.me,
	matias.bjorling@wdc.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 01/11] nvmet: implement id ns for nvm command set
Message-ID: <20241106053800.GA31330@lst.de>
References: <20241105174904.3612888-1-kbusch@meta.com> <20241105174904.3612888-2-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241105174904.3612888-2-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_213803_986682_8DC897E9 
X-CRM114-Status: GOOD (  19.84  )
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

On Tue, Nov 05, 2024 at 09:48:54AM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Nothing to report here, but it's a mandatory identification for nvme
> 2.1.

Yeah, as of 2.1 the only field is LBSTM which we don't support.

> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/target/admin-cmd.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index 081f0473cd9ea..8d06dba42bcb3 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -685,6 +685,20 @@ static void nvmet_execute_identify_ctrl_nvm(struct nvmet_req *req)
>  		   nvmet_zero_sgl(req, 0, sizeof(struct nvme_id_ctrl_nvm)));
>  }
>  
> +static void nvme_execute_identify_ns_nvm(struct nvmet_req *req)
> +{
> +	u16 status;
> +
> +	status = nvmet_req_find_ns(req);
> +	if (status)
> +		goto out;
> +
> +	status = nvmet_copy_to_sgl(req, 0, ZERO_PAGE(0),
> +				   NVME_IDENTIFY_DATA_SIZE);

Does this also need a check for the magic all-Fs nsid, which I think
is not supported for the I/O command set specific identify namespace?
(see the code іn the zns version)


