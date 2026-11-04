Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F978606A32D
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 17:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=acKcc9j2;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UpGEf9sM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=132l4Enwzi8qsldPmZLlfjC48XR/zj9rNKmwXP4V6AI=; b=acKcc9j2G7tYP+GoGP08Nlms3R
	E769nMysybNpKcP1TJ2fn9QjPpiFoX3bTAejsMxy20ZGyVX+vhgKtG1BJSTQokG+ZV11EfaWWm3VP
	hOduRIXDeBCdubJZJLrVNfJNka9UFveRJ3u4YuDa32ZLMO9EVW9Cryp86m5BCLb5ypAqmnR3gsQdq
	jw/s7yxOhz56JSSKLMz1gzY9Ob1OanTllcRwEQkLtbsiBHsIPSYcB2r1SUCeWgWcxWYwqe1rGwgoO
	JuFwlWnMLXUW/O5oBfH4dpNIR2w4OiccWfk0vkgD/wmlMA5hMJ9EJ6eY48jhU/NWWSE4Ydp0012dB
	Sqq/QJzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOex9-00000006FTS-0lsS;
	Wed, 04 Nov 2026 17:39:15 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOex7-00000006FTA-43M7
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 17:39:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 103346022B;
	Wed,  4 Nov 2026 17:39:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F9E71F000C1;
	Wed,  4 Nov 2026 17:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793813952;
	bh=132l4Enwzi8qsldPmZLlfjC48XR/zj9rNKmwXP4V6AI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UpGEf9sMJOG45ua1JHhpR2JDFB5NnWfbRm4ar6KqxOVrmnvvQo1fiEZQmFN8dnIXF
	 zeWpNyeY/hGEDESZTX9U7eXk13e9ms9c3nnKwkBSSTDvHm7nrIPrfm8CcAyYDaCEfM
	 GZlv1RFfvaZDRVbnymyvZBN8iyqx8Ms7eF8wHaHS3msKWiqIXKzKqa+vvUYAqGQ9Wy
	 5bsGW+8KkryC4pxhUK7pgkcGf8SidbHqjc/xX/UeXljWdGqP0u4CgEu+LJ9fjCJMti
	 jcdacw99SdVMSlVTh9J96ow3z6ba5dMOxD8ipcnzyX1MapjkZuVPCjuOIhuSlry4Hd
	 FTk6RRbuLDHdQ==
Date: Wed, 4 Nov 2026 10:39:11 -0700
From: Keith Busch <kbusch@kernel.org>
To: "Ewan D. Milne" <emilne@redhat.com>
Cc: linux-nvme@lists.infradead.org, kch@nvidia.com, hch@lst.de,
	sagi@grimberg.me
Subject: Re: [PATCH] nvmet: don't return memory contents beyond valid data
 when reading ANA log page
Message-ID: <auttv_yEj_mRwDH-@kbusch-mbp>
References: <20261104172833.161567-1-emilne@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104172833.161567-1-emilne@redhat.com>
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04, 2026 at 12:28:33PM -0500, Ewan D. Milne wrote:
> The host side does not know how much valid data will be returned by the target
> so it will typically provide a buffer larger than the amount of valid data in
> the ANA log page.  The memory allocation used by the target does not guarantee
> that prior kernel memory contents will not be returned past the end of the valid
> page data.  Fix this to ensure that the SGL is zeroed before copying the data.
> 
> Fixes: 72efd25dcf4f ("nvmet: add minimal ANA support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ewan D. Milne <emilne@redhat.com>
> ---
>  drivers/nvme/target/admin-cmd.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index 26028be8fe4d..bfd5750da27b 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -543,6 +543,15 @@ static void nvmet_execute_get_log_page_ana(struct nvmet_req *req)
>  	u16 ngrps = 0;
>  	u16 status;
>  
> +	/*
> +	 * The header and one descriptor per enabled group are the only bytes
> +	 * written below; zero the whole transfer first so the unwritten tail
> +	 * does not leak stale kernel memory to the host.
> +	 */
> +	status = nvmet_zero_sgl(req, 0, req->transfer_len);
> +	if (status)
> +		goto out;
> +

Just a minor optimization suggestion, it looks safe to move the zero'ing
to after the code fills out the entries so that we're not writing over
the memory twice. Something like this after the for-loop:
So 
	if (!status && offset < req->transfer_len)
		nvmet_zero_sgl(req, offset, req->transfer_len - offset);

