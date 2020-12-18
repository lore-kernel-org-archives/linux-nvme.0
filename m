Return-Path: <SRS0=757D=FW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19ADCC4361B
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Dec 2020 00:58:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8930A238A0
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Dec 2020 00:58:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8930A238A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rAJ9lPTPnAzzFv4ca5hCez/sC+BlHDeUNPf17rMBHjI=; b=hEFi22yX+HT0M71EEj5fbKhXh
	tQchVTFuDQuVKfS1rdbYXuekG9T5GfK6ZqZgsDz3HWrqldmXAEUlA4o/QWsUisA6O0GkWddH3iKy8
	pQEywBmUbSN4p3JAC6tGaPgHJWqI/yzRCp5UP5kK/Eir6fO1N5rdr9ArPmW/Hzi4wZU/CQpwvz89g
	Qs/FI0aBJwW9sBu+eK65TxeT00cDcxzsk6sP7XEFemYEWWDl18yYIGOoE0ghhrMxmoM2j8gV5wlDa
	BxnCMjGWOsBXA/X59XB0ub47gL2iAyR/zsGmY9Y0pqc838idfgR2X1dtR1pZvVBFWuowYiH/WGefT
	IUFzm9Ugg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kq45j-0002P3-O6; Fri, 18 Dec 2020 00:57:55 +0000
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kq45g-0002OY-PX
 for linux-nvme@lists.infradead.org; Fri, 18 Dec 2020 00:57:53 +0000
Received: by mail-ot1-x32d.google.com with SMTP id x13so443293oto.8
 for <linux-nvme@lists.infradead.org>; Thu, 17 Dec 2020 16:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=M/GXJE0BsmK5P/8UPt6aSQZYOVcEb0nfKYYp7qoljXc=;
 b=Xl8sYIhX3iYj7zcnCfaXh8N1QC7FwqLNy9XJAH903Xl1dsF+bBqVjiT7raNV3fgpoz
 JfpqWU+5zPjKhAfYL1ssQ60gNl//2FnrSZLnUuhhFtBSq5CBU9j3xvGq8O26N50chfjG
 3brT31YBMHkK+fOnBrJuUVW2TGGzv6xJcnV50TPaj4PxZokClhC53WdBOhactyZjnFrl
 M7LIkbqNZmqA8ACNB38zi4cHkN1EM70iAJV5e8eqboXQsr21v80S2Wd0qlDCmZVCDqmW
 d/YWV6bZ3q1B64+yMbw77vBIhWfFNLm94qIqZ7llgZEJoFWTGWcdTuD2OAN7uAi8wwKj
 fRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=M/GXJE0BsmK5P/8UPt6aSQZYOVcEb0nfKYYp7qoljXc=;
 b=jQHjVGBPlE1Qe2YZZwURYMomuX9HPg+8eoLgkxGbKELP/47f5J9Z9zoabsgkEIWXpY
 yrbdGS9lK4VGYypNXKFOaX/eM/RoW7gRtAqh/pYdTueNOBMtq5EOacjbVZwqmFY/tZ+C
 4GLjXZR2z9NSCKMb64yHlWr4TMv3uNNgjbG0ffRBu8/MPlW+EPKSKCurbyENN9prwfKN
 xYBF3NixxZinRypRHnd8OwUrGIkq59XUeO7XKCiqYlSXlDZL7KIcf2nK4slrwUtDKAlG
 4Y6JxBxzk4tSqQbldCT3iCfxUfpWrZQq2o4rZqlGX1qT02BqIa28eXJmEcNBDW2t1Ete
 xQZw==
X-Gm-Message-State: AOAM533OAWMLYS88nXPorE2eB0pih0OsqxkHSz3nLkxKezGGqDRfkA56
 zvLC2BZypamSpCBRlH88Skg=
X-Google-Smtp-Source: ABdhPJz2bsikSsneQ1POTq/19Qi8HFEGhTTeKwyL6sW1XsGY0FGWILQ9EuNYCfOYoxO9A4vfGLWdKA==
X-Received: by 2002:a9d:4707:: with SMTP id a7mr1186925otf.133.1608253070902; 
 Thu, 17 Dec 2020 16:57:50 -0800 (PST)
Received: from Davids-MacBook-Pro.local ([8.48.134.51])
 by smtp.googlemail.com with ESMTPSA id m18sm1616741ooa.24.2020.12.17.16.57.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Dec 2020 16:57:50 -0800 (PST)
Subject: Re: [PATCH v1 net-next 13/15] net/mlx5e: NVMEoTCP, data-path for DDP
 offload
To: Boris Pismenny <borisp@mellanox.com>, kuba@kernel.org,
 davem@davemloft.net, saeedm@nvidia.com, hch@lst.de, sagi@grimberg.me,
 axboe@fb.com, kbusch@kernel.org, viro@zeniv.linux.org.uk, edumazet@google.com
References: <20201207210649.19194-1-borisp@mellanox.com>
 <20201207210649.19194-14-borisp@mellanox.com>
From: David Ahern <dsahern@gmail.com>
Message-ID: <9cc1e367-bf5a-929b-2abe-e368d2109291@gmail.com>
Date: Thu, 17 Dec 2020 17:57:47 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201207210649.19194-14-borisp@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201217_195752_866775_E6381870 
X-CRM114-Status: GOOD (  20.03  )
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
 boris.pismenny@gmail.com, Ben Ben-Ishay <benishay@mellanox.com>,
 benishay@nvidia.com, linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 Or Gerlitz <ogerlitz@mellanox.com>, ogerlitz@nvidia.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 12/7/20 2:06 PM, Boris Pismenny wrote:
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
> +	cqe128 = (struct mlx5e_cqe128 *)((char *)cqe - 64);
> +	if (cqe_is_nvmeotcp_resync(cqe)) {
> +		nvmeotcp_update_resync(queue, cqe128);
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

mlx5e_skb_from_cqe_mpwrq_linear and mlx5e_skb_from_cqe_mpwrq_nolinear
create an skb and then this function comes behind it, strips any frags
originally added to the skb, ...


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

... adds the frags for the sgls, ...

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

... and then re-adds the original frags.

Why is this needed? Why can't the skb be created with all of the frags
in proper order?

It seems like this dance is not needed if you had generic header/payload
splits with the payload written to less retrictive SGLs.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
