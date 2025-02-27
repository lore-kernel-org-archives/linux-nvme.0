Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA69C197BF
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Feb 2025 21:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PYQvLwG25Id0b23KsYffRa4HFQ6gfzIEhP3pk2lFTi0=; b=J1oxZgUx7GsElo4eeHsTjlJr5a
	rElGCMZnshbHV2gckK4siZpPiXwddoA3RlfuHPTlsZiwqBMpuiDrm5E+Y7ja4b1mAg4NTEIZxFsTP
	dmipae6VI0aGzX/Feh9BbjWsjlkAOBixlLVcJQ8+ZvMViS4wW/opkg9IbFBdqj0c4Bn8MFms2SRxS
	9I0WEzw/uXratDdMPFHZo4j6qLYYpmx6hzywH+O2XBY2oYgSY3MCAyeVd1+3jH+axz5leXfmGiO4T
	eijkz+lDPk1sV25RdOQTQBoIfDOM/ouLMbl2wxP0rP2FClIFDXYHlgvCkcYCA4+l9XJnTuc1l8pbG
	upR/D/bQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnliB-00000008vV2-2u0X;
	Thu, 27 Feb 2025 21:46:31 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnliA-00000008vUu-2ita
	for linux-nvme@lists.infradead.org;
	Thu, 27 Feb 2025 21:46:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5C40F61126;
	Thu, 27 Feb 2025 21:46:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5796C4CEDD;
	Thu, 27 Feb 2025 21:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740692789;
	bh=/nEA92N9pwlqDw/LpZqyfnJstLMztmSrMkJcI7BZnHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dvPKRT5XKK86/yRCU7aGSRVF27Udij5AYbKVsRnHG6PUTWKHtcOSZDPFVar/JcZnl
	 yI2O72/iRm/uWkTxyqukHDz42HyvYTdT1ePpe83e2VZBl7oblC8giZJiQy9LKcuqCO
	 jy40JQgHG9VAO8fI/ShTXr4lxoaqrCZaKjuS1E6WUf/sjNJ1kvMTYDbivrkQCPJyhT
	 T7MDIGAsJkFd6Cej7EeboSyF7jkAVdbCoQTRkw22bby8sSJBcTXItn+70S/EaW/1DQ
	 C4FYt8vlwiLzjOVop89VMtMWuisR3lspQCEB4QUzM0j4YX3DeL1VuWqWTBpbVhZvX+
	 7IU+5xeEjSujg==
Date: Thu, 27 Feb 2025 14:46:26 -0700
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@meta.com>, ming.lei@redhat.com,
	asml.silence@gmail.com, linux-block@vger.kernel.org,
	io-uring@vger.kernel.org, bernd@bsbernd.com,
	csander@purestorage.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCHv7 1/6] io_uring/rw: move fixed buffer import to issue path
Message-ID: <Z8DdMoScpHMzYrrh@kbusch-mbp>
References: <20250226182102.2631321-1-kbusch@meta.com>
 <20250226182102.2631321-2-kbusch@meta.com>
 <8b65adec-8888-40ae-b6c8-358fa836bcc6@kernel.dk>
 <d1ff0d23-07a4-4123-b30f-446cf849814a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1ff0d23-07a4-4123-b30f-446cf849814a@kernel.dk>
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

On Wed, Feb 26, 2025 at 01:20:24PM -0700, Jens Axboe wrote:
> +static int io_rw_do_import(struct io_kiocb *req, int ddir)
> +{
> +	if (!io_do_buffer_select(req)) {
> +		struct io_async_rw *io = req->async_data;
> +		int ret;
> +
> +		ret = io_import_rw_buffer(ddir, req, io, 0);
> +		if (unlikely(ret))
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
> +		      int ddir)
> +{
> +	int ret;
> +
> +	ret = __io_prep_rw(req, sqe, ddir);
> +	if (unlikely(ret))
> +		return ret;
> +
> +	return io_rw_do_import(req, ddir);
> +}

...

>  static int io_prep_rwv(struct io_kiocb *req, const struct io_uring_sqe *sqe,
>  		       int ddir)
>  {
> -	const bool do_import = !(req->flags & REQ_F_BUFFER_SELECT);
>  	int ret;
>  
> -	ret = io_prep_rw(req, sqe, ddir, do_import);
> +	ret = io_prep_rw(req, sqe, ddir);
>  	if (unlikely(ret))
>  		return ret;
> -	if (do_import)
> -		return 0;
> +	if (!(req->flags & REQ_F_BUFFER_SELECT))
> +		return io_rw_do_import(req, ddir);

Not sure if I'm missing something subtle here, but wanted to point out
I've changed the above in the version I'm about to send: io_prep_rw()
already calls io_rw_do_import(), so we can just return 0 here.

