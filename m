Return-Path: <SRS0=ocGt=GT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE41FC433E0
	for <linux-nvme@archiver.kernel.org>; Sat, 16 Jan 2021 04:58:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57DA92371F
	for <linux-nvme@archiver.kernel.org>; Sat, 16 Jan 2021 04:58:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57DA92371F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+ViHBTXPcXs6JBAHJyanoIeapjm6yi+HujSzT7gOtsY=; b=vdMPDbqfudO5bxFC5LnKhNmr2
	kzOdm23LlbGHg1U4ZBGpQHIQsuiwMvMwwBBAfiASlIevIIVbkMcdq8U97WDClC67LS33joBEO+hoo
	ChQSgQgM3EinbsWm7KQ3AyFjkHwMzyyVlb4TExQQ92oicjvkDC1rsSgaElGB8A/US0l9awlYC48Lj
	rYy+QdbDpLYSYeP1Myhhbw4ja/MzvoZcGALqgDSQ4WWCkeaBz2W37po/5tJNs0ubN4YFqtEXmXWSk
	oIGtS5fOGjUtGrKvkMwC5rm5NbeVYKEmMAOd2Arn028c5r6P5C+QtMdJaJUQy0Fa3KEZmlo+bEBuN
	8xcX4cJAA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l0dej-0004RM-6V; Sat, 16 Jan 2021 04:57:45 +0000
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l0def-0004QV-P1
 for linux-nvme@lists.infradead.org; Sat, 16 Jan 2021 04:57:42 +0000
Received: by mail-oi1-x22f.google.com with SMTP id p5so11889913oif.7
 for <linux-nvme@lists.infradead.org>; Fri, 15 Jan 2021 20:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6afCtyrHhHrB0RbqmgZnegkbDUQotJZ+wrr34Ox/apA=;
 b=kLJStPZQ03ZCR8FkkhFkGoRm3SwFJan+pOkLMf86jVjqDHlHd6XH2v17uy9PGNrUik
 jwvABMZ18YfUo8rIoeVu3sRvGLsQM7TTYAEHmb3RqxX/k4BTujNu+WQ01tHCXaDkDZYH
 uSvVuksGxf3tHQediZBDeOhGHF5HuJ6yEKwm83pV7s1cj2SXB6sKMhKip9fvJIG+F+Ei
 PzIKp08i106dWuJoeL/6Dj4RHYCqFG/en6SUE602ryraV3/fZFR+LS33h2iSnLpt/PL1
 sJKEs5NrYLM1+uvvn2BDjiW6W/3BVXyKq1jte692aZTMljDKDWez2eX4FWbmZn8Y4KOt
 rdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6afCtyrHhHrB0RbqmgZnegkbDUQotJZ+wrr34Ox/apA=;
 b=KZnJONXCeWet+q337nv5KHVUpW/gifJsB7zbQM1cYE3tRKNw8tdRe3FMF1vIajd420
 gjCDVze6P6VnqWlknvEHfNtvxYPBBNHV+gEkmySv2G+a1+pR1GO1wel0uwZnTmJd+4hX
 r5a5LVMPDOhBDhQBVbtIw4hO2UZle8Pj7OxSz8yV4lhnYoPosdRm6lK2hfBXMsC5N0DE
 +ZkWUYIjYMHLcPMNntvHfytOThrItLNbPPtAd63svEWbcW7IYexst2NYCTIOu6dKjrsT
 1YYw8QV9cCfhev6YnUogrtoZkywFwgaj+rgn+fK9yO5afm2TRewx7zAe9BQBEZG7pTHP
 JsqQ==
X-Gm-Message-State: AOAM532+naJ/mfuCz3Evn30l0EfBpYGsu78cisnfaQk19cnR8BLfQM+G
 eRpgBsYhCdLvUo0XVx4TTAc=
X-Google-Smtp-Source: ABdhPJwrqF+SkL5qFx+dKLs4rf0eXCj768xFJjxmzOo22jOnX29qedvbAtQw47JMFK0WyWsQHS75AQ==
X-Received: by 2002:aca:f58c:: with SMTP id t134mr7850448oih.68.1610773057230; 
 Fri, 15 Jan 2021 20:57:37 -0800 (PST)
Received: from Davids-MacBook-Pro.local ([8.6.112.212])
 by smtp.googlemail.com with ESMTPSA id s66sm2291685ooa.37.2021.01.15.20.57.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Jan 2021 20:57:36 -0800 (PST)
Subject: Re: [PATCH v2 net-next 19/21] net/mlx5e: NVMEoTCP, data-path for DDP
 offload
To: Boris Pismenny <borisp@mellanox.com>, kuba@kernel.org,
 davem@davemloft.net, saeedm@nvidia.com, hch@lst.de, sagi@grimberg.me,
 axboe@fb.com, kbusch@kernel.org, viro@zeniv.linux.org.uk,
 edumazet@google.com, smalin@marvell.com
References: <20210114151033.13020-1-borisp@mellanox.com>
 <20210114151033.13020-20-borisp@mellanox.com>
From: David Ahern <dsahern@gmail.com>
Message-ID: <10c28b01-49e5-c512-8670-bf8332b24b1b@gmail.com>
Date: Fri, 15 Jan 2021 21:57:34 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210114151033.13020-20-borisp@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210115_235741_907747_21B1DBB4 
X-CRM114-Status: GOOD (  30.46  )
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
Cc: Yoray Zack <yorayz@mellanox.com>, yorayz@nvidia.com,
 boris.pismenny@gmail.com, benishay@nvidia.com, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, Or Gerlitz <ogerlitz@mellanox.com>,
 ogerlitz@nvidia.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I have not had time to review this version of the patches, but this
patch seems very similar to 13 of 15 from v1 and you did not respond to
my question on it ...

On 1/14/21 8:10 AM, Boris Pismenny wrote:
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c
> new file mode 100644
> index 000000000000..f446b5d56d64
> --- /dev/null
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c
> @@ -0,0 +1,243 @@
> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> +/* Copyright (c) 2021 Mellanox Technologies. */
> +
> +#include "en_accel/nvmeotcp_rxtx.h"
> +#include "en_accel/nvmeotcp.h"
> +#include <linux/mlx5/mlx5_ifc.h>
> +
> +#define	MLX5E_TC_FLOW_ID_MASK  0x00ffffff
> +static void nvmeotcp_update_resync(struct mlx5e_nvmeotcp_queue *queue,
> +				   struct mlx5e_cqe128 *cqe128)
> +{
> +	const struct tcp_ddp_ulp_ops *ulp_ops;
> +	u32 seq;
> +
> +	seq = be32_to_cpu(cqe128->resync_tcp_sn);
> +	ulp_ops = inet_csk(queue->sk)->icsk_ulp_ddp_ops;
> +	if (ulp_ops && ulp_ops->resync_request)
> +		ulp_ops->resync_request(queue->sk, seq, TCP_DDP_RESYNC_REQ);
> +}
> +
> +static void mlx5e_nvmeotcp_advance_sgl_iter(struct mlx5e_nvmeotcp_queue *queue)
> +{
> +	struct nvmeotcp_queue_entry *nqe = &queue->ccid_table[queue->ccid];
> +
> +	queue->ccoff += nqe->sgl[queue->ccsglidx].length;
> +	queue->ccoff_inner = 0;
> +	queue->ccsglidx++;
> +}
> +
> +static inline void
> +mlx5e_nvmeotcp_add_skb_frag(struct net_device *netdev, struct sk_buff *skb,
> +			    struct mlx5e_nvmeotcp_queue *queue,
> +			    struct nvmeotcp_queue_entry *nqe, u32 fragsz)
> +{
> +	dma_sync_single_for_cpu(&netdev->dev,
> +				nqe->sgl[queue->ccsglidx].offset + queue->ccoff_inner,
> +				fragsz, DMA_FROM_DEVICE);
> +	page_ref_inc(compound_head(sg_page(&nqe->sgl[queue->ccsglidx])));
> +	// XXX: consider reducing the truesize, as no new memory is consumed
> +	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
> +			sg_page(&nqe->sgl[queue->ccsglidx]),
> +			nqe->sgl[queue->ccsglidx].offset + queue->ccoff_inner,
> +			fragsz,
> +			fragsz);
> +}
> +
> +static struct sk_buff*
> +mlx5_nvmeotcp_add_tail_nonlinear(struct mlx5e_nvmeotcp_queue *queue,
> +				 struct sk_buff *skb, skb_frag_t *org_frags,
> +				 int org_nr_frags, int frag_index)
> +{
> +	struct mlx5e_priv *priv = queue->priv;
> +
> +	while (org_nr_frags != frag_index) {
> +		if (skb_shinfo(skb)->nr_frags >= MAX_SKB_FRAGS) {
> +			dev_kfree_skb_any(skb);
> +			return NULL;
> +		}
> +		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
> +				skb_frag_page(&org_frags[frag_index]),
> +				skb_frag_off(&org_frags[frag_index]),
> +				skb_frag_size(&org_frags[frag_index]),
> +				skb_frag_size(&org_frags[frag_index]));
> +		page_ref_inc(skb_frag_page(&org_frags[frag_index]));
> +		frag_index++;
> +	}
> +	return skb;
> +}
> +
> +static struct sk_buff*
> +mlx5_nvmeotcp_add_tail(struct mlx5e_nvmeotcp_queue *queue, struct sk_buff *skb,
> +		       int offset, int len)
> +{
> +	struct mlx5e_priv *priv = queue->priv;
> +
> +	if (skb_shinfo(skb)->nr_frags >= MAX_SKB_FRAGS) {
> +		dev_kfree_skb_any(skb);
> +		return NULL;
> +	}
> +	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
> +			virt_to_page(skb->data),
> +			offset,
> +			len,
> +			len);
> +	page_ref_inc(virt_to_page(skb->data));
> +	return skb;
> +}
> +
> +static void mlx5_nvmeotcp_trim_nonlinear(struct sk_buff *skb,
> +					 skb_frag_t *org_frags,
> +					 int *frag_index,
> +					 int remaining)
> +{
> +	unsigned int frag_size;
> +	int nr_frags;
> +
> +	/* skip @remaining bytes in frags */
> +	*frag_index = 0;
> +	while (remaining) {
> +		frag_size = skb_frag_size(&skb_shinfo(skb)->frags[*frag_index]);
> +		if (frag_size > remaining) {
> +			skb_frag_off_add(&skb_shinfo(skb)->frags[*frag_index],
> +					 remaining);
> +			skb_frag_size_sub(&skb_shinfo(skb)->frags[*frag_index],
> +					  remaining);
> +			remaining = 0;
> +		} else {
> +			remaining -= frag_size;
> +			skb_frag_unref(skb, *frag_index);
> +			*frag_index += 1;
> +		}
> +	}
> +
> +	/* save original frags for the tail and unref */
> +	nr_frags = skb_shinfo(skb)->nr_frags;
> +	memcpy(&org_frags[*frag_index], &skb_shinfo(skb)->frags[*frag_index],
> +	       (nr_frags - *frag_index) * sizeof(skb_frag_t));
> +	while (--nr_frags >= *frag_index)
> +		skb_frag_unref(skb, nr_frags);
> +
> +	/* remove frags from skb */
> +	skb_shinfo(skb)->nr_frags = 0;
> +	skb->len -= skb->data_len;
> +	skb->truesize -= skb->data_len;
> +	skb->data_len = 0;
> +}
> +
> +struct sk_buff*
> +mlx5e_nvmeotcp_handle_rx_skb(struct net_device *netdev, struct sk_buff *skb,
> +			     struct mlx5_cqe64 *cqe, u32 cqe_bcnt,
> +			     bool linear)
> +{
> +	int ccoff, cclen, hlen, ccid, remaining, fragsz, to_copy = 0;
> +	struct mlx5e_priv *priv = netdev_priv(netdev);
> +	skb_frag_t org_frags[MAX_SKB_FRAGS];
> +	struct mlx5e_nvmeotcp_queue *queue;
> +	struct nvmeotcp_queue_entry *nqe;
> +	int org_nr_frags, frag_index;
> +	struct mlx5e_cqe128 *cqe128;
> +	u32 queue_id;
> +
> +	queue_id = (be32_to_cpu(cqe->sop_drop_qpn) & MLX5E_TC_FLOW_ID_MASK);
> +	queue = mlx5e_nvmeotcp_get_queue(priv->nvmeotcp, queue_id);
> +	if (unlikely(!queue)) {
> +		dev_kfree_skb_any(skb);
> +		return NULL;
> +	}
> +
> +	cqe128 = container_of(cqe, struct mlx5e_cqe128, cqe64);
> +	if (cqe_is_nvmeotcp_resync(cqe)) {
> +		nvmeotcp_update_resync(queue, cqe128);
> +		mlx5e_nvmeotcp_put_queue(queue);
> +		return skb;
> +	}
> +
> +#ifdef CONFIG_TCP_DDP_CRC
> +	/* If a resync occurred in the previous cqe,
> +	 * the current cqe.crcvalid bit may not be valid,
> +	 * so we will treat it as 0
> +	 */
> +	skb->ddp_crc = queue->after_resync_cqe ? 0 :
> +		cqe_is_nvmeotcp_crcvalid(cqe);
> +	queue->after_resync_cqe = 0;
> +#endif
> +	if (!cqe_is_nvmeotcp_zc(cqe)) {
> +		mlx5e_nvmeotcp_put_queue(queue);
> +		return skb;
> +	}
> +
> +	/* cc ddp from cqe */
> +	ccid = be16_to_cpu(cqe128->ccid);
> +	ccoff = be32_to_cpu(cqe128->ccoff);
> +	cclen = be16_to_cpu(cqe128->cclen);
> +	hlen  = be16_to_cpu(cqe128->hlen);
> +
> +	/* carve a hole in the skb for DDP data */
> +	if (linear) {
> +		skb_trim(skb, hlen);
> +	} else {
> +		org_nr_frags = skb_shinfo(skb)->nr_frags;
> +		mlx5_nvmeotcp_trim_nonlinear(skb, org_frags, &frag_index,
> +					     cclen);
> +	}
> +
> +	nqe = &queue->ccid_table[ccid];
> +
> +	/* packet starts new ccid? */
> +	if (queue->ccid != ccid || queue->ccid_gen != nqe->ccid_gen) {
> +		queue->ccid = ccid;
> +		queue->ccoff = 0;
> +		queue->ccoff_inner = 0;
> +		queue->ccsglidx = 0;
> +		queue->ccid_gen = nqe->ccid_gen;
> +	}
> +
> +	/* skip inside cc until the ccoff in the cqe */
> +	while (queue->ccoff + queue->ccoff_inner < ccoff) {
> +		remaining = nqe->sgl[queue->ccsglidx].length - queue->ccoff_inner;
> +		fragsz = min_t(off_t, remaining,
> +			       ccoff - (queue->ccoff + queue->ccoff_inner));
> +
> +		if (fragsz == remaining)
> +			mlx5e_nvmeotcp_advance_sgl_iter(queue);
> +		else
> +			queue->ccoff_inner += fragsz;
> +	}
> +
> +	/* adjust the skb according to the cqe cc */
> +	while (to_copy < cclen) {
> +		if (skb_shinfo(skb)->nr_frags >= MAX_SKB_FRAGS) {
> +			dev_kfree_skb_any(skb);
> +			mlx5e_nvmeotcp_put_queue(queue);
> +			return NULL;
> +		}
> +
> +		remaining = nqe->sgl[queue->ccsglidx].length - queue->ccoff_inner;
> +		fragsz = min_t(int, remaining, cclen - to_copy);
> +
> +		mlx5e_nvmeotcp_add_skb_frag(netdev, skb, queue, nqe, fragsz);
> +		to_copy += fragsz;
> +		if (fragsz == remaining)
> +			mlx5e_nvmeotcp_advance_sgl_iter(queue);
> +		else
> +			queue->ccoff_inner += fragsz;
> +	}
> +
> +	if (cqe_bcnt > hlen + cclen) {
> +		remaining = cqe_bcnt - hlen - cclen;
> +		if (linear)
> +			skb = mlx5_nvmeotcp_add_tail(queue, skb,
> +						     offset_in_page(skb->data) +
> +								hlen + cclen,
> +						     remaining);
> +		else
> +			skb = mlx5_nvmeotcp_add_tail_nonlinear(queue, skb,
> +							       org_frags,
> +							       org_nr_frags,
> +							       frag_index);
> +	}
> +
> +	mlx5e_nvmeotcp_put_queue(queue);
> +	return skb;
> +}



... I'll copy and paste my question here:

"mlx5e_skb_from_cqe_mpwrq_linear and mlx5e_skb_from_cqe_mpwrq_nolinear
create an skb and then this function comes behind it, strips any frags
originally added to the skb, adds the frags for the sgls, and then
re-adds the original frags.

Why is this needed? Why can't the skb be created with all of the frags
in proper order?

It seems like this dance is not needed if you had generic header/payload
splits with the payload written to less retrictive SGLs."

This patch seems to be something very similar, and it is really
complicated way to create each skb for DDP. The patch description does
little to explain why it is needed.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
