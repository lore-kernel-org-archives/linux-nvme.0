Return-Path: <SRS0=QV8n=5I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA08BC4332B
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2020 23:39:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86624206F9
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2020 23:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LEngldnd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IH5FA9P6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86624206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RwrezKlA2OZvFw5cUPN0c557M6YbWDnL/RV6DtFuNRw=; b=LEngldndA5+7RW
	L1HWdc+8zHisei1aV4c3E8I48OzyJcp5dXIgxd7SGJR4nlV4xcixrm3LyLBnNJ48fq6OJ9LxOVPR6
	MSKgw6xbRTSz1Epp/TLZqbbicXm9rV1KlnzH9RCY7niuPSWUETrHGyhk3M3FJnT39gsT+2zuKyIPy
	tNZa24O2USPtQJOGIdwee4WasvCnz86bopQNaFMDtZOXvXFT6KVYuLvWkmY+SdywHoCF6LJxBKrDh
	L4bbaCDmZAFR+2n1mQVU4a3QpbY/F0diB73f0kQS+eum/2MYkpGS/vrIODywKO+4kfvdO99VOw/tP
	bAXO51V7EsM5lAGgeupg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jGWfG-0008AL-6J; Mon, 23 Mar 2020 23:39:26 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jGWfD-00089o-KA
 for linux-nvme@lists.infradead.org; Mon, 23 Mar 2020 23:39:24 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 37D73206F9;
 Mon, 23 Mar 2020 23:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1585006763;
 bh=6ySwLpM3yktpyx1nQaWDhabMCg2ZfB/8aJUMwIUMfco=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IH5FA9P6Cg3pHzcpT9qr7VIfnd8HLZvTR5r3oVwRUHlJGFnDp3rYZ7H5TqsYdX7bl
 RykZiTaEjSHoCopk312wBDOxfbQojvyS0OVdmG9I3fCAAPuE8ARBGcur2IozhPSdEG
 Ufz6RhTSb2C5BtZz1//ml68jZCaiwm9gMH0iTRSM=
Date: Tue, 24 Mar 2020 08:39:16 +0900
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme-tcp: don't poll a non-live queue
Message-ID: <20200323233916.GA15091@redsun51.ssa.fujisawa.hgst.com>
References: <20200323221315.16120-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200323221315.16120-1-sagi@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200323_163923_685615_B1162608 
X-CRM114-Status: GOOD (  15.23  )
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
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Mark Wunderlich <mark.wunderlich@intel.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Mar 23, 2020 at 03:13:15PM -0700, Sagi Grimberg wrote:
> In error recovery we might be removing the queue so check we
> can actually poll before we do.
> 
> Reported-by: Mark Wunderlich <mark.wunderlich@intel.com>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/nvme/host/tcp.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index b545a9e96327..5d03a86fa69b 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2327,6 +2327,9 @@ static int nvme_tcp_poll(struct blk_mq_hw_ctx *hctx)
>  	struct nvme_tcp_queue *queue = hctx->driver_data;
>  	struct sock *sk = queue->sock->sk;
>  
> +	if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
> +		return 0;
> +
>  	set_bit(NVME_TCP_Q_POLLING, &queue->flags);
>  	if (sk_can_busy_loop(sk) && skb_queue_empty_lockless(&sk->sk_receive_queue))
>  		sk_busy_loop(sk, true);
> -- 

Did I miss a patch recently? I couldn't find the "NVME_TCP_Q_POLLING"
flag in any tree, so this patch doesn't apply as-is.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
