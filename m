Return-Path: <SRS0=jIqL=PN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A54C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Oct 2021 14:38:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDE9460E0B
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Oct 2021 14:38:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CDE9460E0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VuSbTB4ItRDvxDfbD96aFmr3xrsQXnwdEVFmE17HTeM=; b=o7Nf7aOUVlqMPLB43suIaQAfnj
	8yGCNmyC0kh3lRnFUB3GorWPunKL4qcbGQLf9OpmuVm3MagGja6tUDMyzEbp6r0+LNryfypIZ+J04
	5Xrg9WTwfdOWLeaSKk726Q24no7sud+f2ZCZYI5/IFQVRd7RcjaMhGA9w2y8c82yxb1oib9A/8GVC
	GpLLWaTqflZ8VIb3GbU9uMl0AtISLSzuJj5jZDEh0AIj0CuQ6Safn0rVTkXb4Y3H3Oka/kmAESN7B
	On/sbjp4POaYzDCRmyE5DJrEEnce4hJOtDrVS+jwvKDFnKp/7Y9hMMYhSCYPr0Ged61uMerbLifrB
	4v7EKkrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mf17c-00Gj5G-P6; Mon, 25 Oct 2021 14:38:44 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mf17Z-00Gj46-98
 for linux-nvme@lists.infradead.org; Mon, 25 Oct 2021 14:38:42 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F8FE60E0B;
 Mon, 25 Oct 2021 14:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1635172720;
 bh=+lf/MmSujxCRyqvuxNYJTdSI5kHHXg32Bndaj6rPldI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DplNMJGy8h+e5aB8m6Zki+juh1EsxAYYVeJTB4TnZJstIz/PPyPz7Q1C3WrTU5yW/
 vSHJqRRWN3zIS99nSIQpCjRqrBCVhRd3z/45ty0me2qwAGaKs0IzHQ1XrMA6z8VpGB
 obGFV7pKVZL4b6/5Xodp/9WzwjwFsqeBSGse861FFWMIAyO+obK0nDMwp2SYTQWq4u
 uLOxe2oqBz1CRB+rHKr+NWyLkbzm4E8nRcmUpn6lOZXn4qDLAkVp/2Q9GgVLtfvrA7
 8XMiE/hahHdFrXLWiArbHb9fYmiFZTXawBl2YWhZL+PF4+mh6yBckABFg1wp7fcyFW
 67bD1RcRk+JnA==
Date: Mon, 25 Oct 2021 07:38:38 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH] nvme-tcp: Fix H2CData PDU send accounting (again)
Message-ID: <20211025143838.GA2335106@dhcp-10-100-145-180.wdc.com>
References: <20211024074331.546635-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211024074331.546635-1-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211025_073841_410494_19DEFF94 
X-CRM114-Status: GOOD (  25.98  )
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

On Sun, Oct 24, 2021 at 10:43:31AM +0300, Sagi Grimberg wrote:
> We should not access request members after the last send, even to
> determine if indeed it was the last data payload send. The reason is
> that a completion could have arrived and trigger a new execution of the
> request which overridden these members. This was fixed by commit
> 825619b09ad3 ("nvme-tcp: fix possible use-after-completion").
> 
> Commit e371af033c56 broke that assumption again to address cases where
> multiple r2t pdus are sent per request. To fix it, we need to record the
> request data_sent and data_len and after the payload network send we
> reference these counters to determine weather we should advance the
> request iterator.
> 
> Fixes: e371af033c56 ("nvme-tcp: fix incorrect h2cdata pdu offset accounting")
> Reported-by: Keith Busch <kbusch@kernel.org>
> Cc: stable@vger.kernel.org # 5.10+ 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/nvme/host/tcp.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 78966b8ddb1e..42b58eb1ba62 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -926,15 +926,17 @@ static void nvme_tcp_fail_request(struct nvme_tcp_request *req)
>  static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
>  {
>  	struct nvme_tcp_queue *queue = req->queue;
> +	int req_data_len = req->data_len;
>  
>  	while (true) {
>  		struct page *page = nvme_tcp_req_cur_page(req);
>  		size_t offset = nvme_tcp_req_cur_offset(req);
>  		size_t len = nvme_tcp_req_cur_length(req);
> -		bool last = nvme_tcp_pdu_last_send(req, len);
> +		bool pdu_last = nvme_tcp_pdu_last_send(req, len);

I'm not sure why you opted to change the name of this variable here, but
the patch is testing successfully: no observed r2t errors since apply
this, so I think we're good to go for that regression.

Reviewed-by: Keith Busch <kbusch@kernel.org>

> +		int req_data_sent = req->data_sent;
>  		int ret, flags = MSG_DONTWAIT;
>  
> -		if (last && !queue->data_digest && !nvme_tcp_queue_more(queue))
> +		if (pdu_last && !queue->data_digest && !nvme_tcp_queue_more(queue))
>  			flags |= MSG_EOR;
>  		else
>  			flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
> @@ -958,11 +960,11 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
>  		 * in the request where we don't want to modify it as we may
>  		 * compete with the RX path completing the request.
>  		 */
> -		if (req->data_sent + ret < req->data_len)
> +		if (req_data_sent + ret < req_data_len)
>  			nvme_tcp_advance_req(req, ret);
>  
>  		/* fully successful last send in current PDU */
> -		if (last && ret == len) {
> +		if (pdu_last && ret == len) {
>  			if (queue->data_digest) {
>  				nvme_tcp_ddgst_final(queue->snd_hash,
>  					&req->ddgst);
> -- 
> 2.30.2

