Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8136C54E76
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Jan 2023 19:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aKPxh2X/wP3Ih7PRZTWb2ihBTttUH2VjhyTc7VaRYw0=; b=KC74HjvyV1DehVpdk0dgn9LCfG
	TJEzbplcEet95IytNLQXbzrKIgWsB32rf1I/HaKTlRY5HYgdlZxMAJ6gBt0yvKPZjNSu4pjAxBixe
	+YllVZvQB99dXazhF+h81JfTychuDeKkCXz035ysAQBsfMCJzQnuGafz1k4qO836ugQmpxLJolMUi
	Y+CZPEF0YXI0bt2APwowhOa2quC1IlzZWbbaybyAcjOcI6RoLTls01NPactg45kKx20EdO1nZ2a5o
	AWPqnzszuM4FcTEj+k52GiFfucwp7BNOK3Wv1njb3F6MCXT2gGSeOE+Aj6e4SEarEVHKaQZOz8xQa
	GjJPYbTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHroZ-00Fezn-6Q; Tue, 17 Jan 2023 19:40:11 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHroW-00FezJ-01
	for linux-nvme@lists.infradead.org; Tue, 17 Jan 2023 19:40:09 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 9A44BB81607;
	Tue, 17 Jan 2023 19:40:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E837C433D2;
	Tue, 17 Jan 2023 19:40:01 +0000 (UTC)
Date: Tue, 17 Jan 2023 14:40:00 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Israel Rukshin <israelr@nvidia.com>,
 Bryan Tan <bryantan@vmware.com>, Christoph Hellwig <hch@lst.de>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Jens Axboe
 <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-rdma@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>, Selvin Xavier
 <selvin.xavier@broadcom.com>, Vishnu Dasa <vdasa@vmware.com>, Yishai Hadas
 <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-next 06/13] RDMA/core: Introduce MR type for crypto
 operations
Message-ID: <20230117144000.6efc56b2@gandalf.local.home>
In-Reply-To: <5b8fadc00c0fcc0c0ba3a5dcc9e7b9012c6b5859.1673873422.git.leon@kernel.org>
References: <cover.1673873422.git.leon@kernel.org>
	<5b8fadc00c0fcc0c0ba3a5dcc9e7b9012c6b5859.1673873422.git.leon@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230117_114008_235345_D9DEA24E 
X-CRM114-Status: GOOD (  14.47  )
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

On Mon, 16 Jan 2023 15:05:53 +0200
Leon Romanovsky <leon@kernel.org> wrote:

> index 17642aa54437..b6a3d82b89ca 100644
> --- a/include/trace/events/rdma_core.h
> +++ b/include/trace/events/rdma_core.h
> @@ -371,6 +371,39 @@ TRACE_EVENT(mr_integ_alloc,
>  		__entry->max_num_meta_sg, __entry->rc)
>  );
>  
> +TRACE_EVENT(mr_crypto_alloc,
> +	TP_PROTO(
> +		const struct ib_pd *pd,
> +		u32 max_num_sg,
> +		const struct ib_mr *mr
> +	),
> +
> +	TP_ARGS(pd, max_num_sg, mr),
> +
> +	TP_STRUCT__entry(
> +		__field(u32, pd_id)
> +		__field(u32, mr_id)
> +		__field(u32, max_num_sg)
> +		__field(int, rc)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->pd_id = pd->res.id;
> +		if (IS_ERR(mr)) {
> +			__entry->mr_id = 0;
> +			__entry->rc = PTR_ERR(mr);
> +		} else {
> +			__entry->mr_id = mr->res.id;
> +			__entry->rc = 0;
> +		}
> +		__entry->max_num_sg = max_num_sg;
> +	),
> +
> +	TP_printk("pd.id=%u mr.id=%u max_num_sg=%u rc=%d",
> +		__entry->pd_id, __entry->mr_id, __entry->max_num_sg,
> +		__entry->rc)
> +);
> +

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

>  TRACE_EVENT(mr_dereg,
>  	TP_PROTO(
>  		const struct ib_mr *mr


