Return-Path: <SRS0=a62X=FU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057D3C4361B
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Dec 2020 05:33:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A63C123333
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Dec 2020 05:33:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A63C123333
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=gyjsTTFmvHYKpbQ6o/jSJo0oCcUiXfHyQm/3WF64Sws=; b=VKIhs+AXR5FT/HgCgaK5CVkFW
	NPpXvUj1wii072cFL0J5UXwrtvjRXHwO46sRhLFYVzb/DdezGAWUX63u1hjt4Yvi0JaGWR2zIZ6KM
	CgEYhXFUokjfBd29/vB2r6PWLdDtKmmoT+XEZITtu+DgrrZ8ECYK81lwN+SXyFP/ov4NfeC0GnCSV
	SzA3l6PE6q+xXWuMNkwqnaVE5AiQTRiad9KvlpQtjr++5Wkd04VE1o9udRtkbEatZVbB4r0VMFsMp
	sB1qswfCCWETW8kaq5lI+N91NoRHhCDKg5eC1row66hu0U1IMyy9Us1K5niZQ9kIkN6/JtP5x4WLA
	WJ5WXIk0A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kpPRI-00087Y-TT; Wed, 16 Dec 2020 05:33:28 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kpPRF-000873-R2
 for linux-nvme@lists.infradead.org; Wed, 16 Dec 2020 05:33:26 +0000
Date: Wed, 16 Dec 2020 07:33:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1608096804;
 bh=TiSBf5w2tXdsmwrHWZAnYD9B5JYVKhkRA1G+th2aN20=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=H9QY0zNxJK5JkrU+uV0xcKftRAX/07zfhU0aj7HTzgKkTIS5d3fRrQaDAUALfFjI0
 DfM1VzjKL5h1wDViFhkOkRHljSLaH8xQ174LYKDjA3ap7g8wq0VtGLRGFt45iKyQpf
 kenmHLLhFotNaV6NKTMGK+sjNVjN062vHZcULgXQajcDWteFyr1RFnMAO5RpT6mOsy
 ySYSaGMggkNw+dwHM0g/3ZewPoOHTyV0u9/73baqU+uaQjxxgLRbSrMRwLlF2c4ijV
 dbeC6cl0b9uHRHJoNYfVBukXGN1wDuSwmu8gmdoWrBc1DO/N68JIrF+DPIn8O88KUq
 slQjqF5oysSNQ==
From: Leon Romanovsky <leon@kernel.org>
To: Bernard Metzler <bmt@zurich.ibm.com>
Subject: Re: [PATCH] RDMA/siw: Fix handling of zero-sized Read and Receive
 Queues.
Message-ID: <20201216053320.GO5005@unreal>
References: <20201215122306.3886-1-bmt@zurich.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201215122306.3886-1-bmt@zurich.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201216_003325_990051_0CDAAB92 
X-CRM114-Status: GOOD (  16.04  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-rdma@vger.kernel.org, yi.zhang@redhat.com, kamalheib1@gmail.com,
 linux-nvme@lists.infradead.org, jgg@nvidia.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Dec 15, 2020 at 01:23:06PM +0100, Bernard Metzler wrote:
> During connection setup, the application may choose to zero-size
> inbound and outbound READ queues, as well as the Receive queue.
> This patch fixes handling of zero-sized queues.
>
> Reported-by: Kamal Heib <kamalheib1@gmail.com>
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
>  drivers/infiniband/sw/siw/siw.h       |  2 +-
>  drivers/infiniband/sw/siw/siw_qp.c    | 54 ++++++++++++++++-----------
>  drivers/infiniband/sw/siw/siw_qp_rx.c | 26 +++++++++----
>  drivers/infiniband/sw/siw/siw_qp_tx.c |  4 +-
>  drivers/infiniband/sw/siw/siw_verbs.c | 18 +++++++--
>  5 files changed, 68 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
> index e9753831ac3f..6f17392f975a 100644
> --- a/drivers/infiniband/sw/siw/siw.h
> +++ b/drivers/infiniband/sw/siw/siw.h
> @@ -654,7 +654,7 @@ static inline struct siw_sqe *orq_get_free(struct siw_qp *qp)
>  {
>  	struct siw_sqe *orq_e = orq_get_tail(qp);
>
> -	if (orq_e && READ_ONCE(orq_e->flags) == 0)
> +	if (READ_ONCE(orq_e->flags) == 0)
>  		return orq_e;
>
>  	return NULL;
> diff --git a/drivers/infiniband/sw/siw/siw_qp.c b/drivers/infiniband/sw/siw/siw_qp.c
> index 875d36d4b1c6..b686a09a75ae 100644
> --- a/drivers/infiniband/sw/siw/siw_qp.c
> +++ b/drivers/infiniband/sw/siw/siw_qp.c
> @@ -199,26 +199,28 @@ void siw_qp_llp_write_space(struct sock *sk)
>
>  static int siw_qp_readq_init(struct siw_qp *qp, int irq_size, int orq_size)
>  {
> -	irq_size = roundup_pow_of_two(irq_size);
> -	orq_size = roundup_pow_of_two(orq_size);
> -
> -	qp->attrs.irq_size = irq_size;
> -	qp->attrs.orq_size = orq_size;
> -
> -	qp->irq = vzalloc(irq_size * sizeof(struct siw_sqe));
> -	if (!qp->irq) {
> -		siw_dbg_qp(qp, "irq malloc for %d failed\n", irq_size);
> -		qp->attrs.irq_size = 0;
> -		return -ENOMEM;
> +	if (irq_size) {
> +		irq_size = roundup_pow_of_two(irq_size);
> +		qp->irq = vzalloc(irq_size * sizeof(struct siw_sqe));
> +		if (!qp->irq) {
> +			siw_dbg_qp(qp, "irq malloc for %d failed\n", irq_size);

Please don't copy prints after kernel allocators. You won't miss failure
in allocations.

Thanks

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
