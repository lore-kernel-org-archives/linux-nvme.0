Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE78C46CD2
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Jan 2024 18:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=afw47iJhozrCNRajUCbLfSDCqU326VOEQKxPXsEFugw=; b=f2U6KgvfTL0Z+7QpyiPdYTFfEr
	2WY3St9XnUxvF4VvgpvpCxhla3vHQwpMj6xnrcU765ZJnZ4XaTy83r38Y0pZ/UvOl9kYV+uSHUvM3
	WxP6tdd5SMla+lWiQtb8oJMmQZuBRjJbtQb56RWY7vZp34mx3B+lfT/jIJ0Jeiubeu814/siEx0f7
	0NR2EQELJY9p+ICtFVeOJT4b1guKXXL/9qRHP3MSkymTQKJMBBZQH3jrCsHxXyhH8VN5PYrFwLA/X
	e4k9eTKMkvNI9e0ymxYHOvqJkEYiHcDpaFCgRonADintMbeSZEOjez9RkT1ntrJOQVwRWRYtOzyUJ
	nn4JKMgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTmzs-00000007xxT-32ik;
	Sat, 27 Jan 2024 18:01:40 +0000
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTmzp-00000007xx5-46Ry
	for linux-nvme@lists.infradead.org;
	Sat, 27 Jan 2024 18:01:39 +0000
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40e5afc18f5so21113505e9.3
        for <linux-nvme@lists.infradead.org>; Sat, 27 Jan 2024 10:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706378495; x=1706983295; darn=lists.infradead.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=afw47iJhozrCNRajUCbLfSDCqU326VOEQKxPXsEFugw=;
        b=RmnhX+PXyLOQhI42iIXJd7TsD+Y2+mWxo7rJMLfDai2OmwAlbrA3iRClto+2p1dn71
         BLofZHHGTdGEV6Y9Utpm74oYL3OtxDq0CblSzhfvOCQcrz+1H17rA0jp8yarhTJD9LcB
         OGP3/AVDFrBbnSQlbJs0KhV2OhL11BXZlvC2JcQB9uWw8xcdahNKQO7hK+6+ASW8EAhF
         ZI1x4kMaTok5WJn1YvWHP5k8J2VVkvhX73dICatx1zikzpWfsVs97HMkhe2StcVCrr1X
         qNqnXCUsZH1yLgFChjAPfMr8cHnCaiqpOc7AgXSI3+DN56aMUjGGNXlxQfRdnHgilo4N
         BB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706378495; x=1706983295;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=afw47iJhozrCNRajUCbLfSDCqU326VOEQKxPXsEFugw=;
        b=MGX2qAl3sfHoqVELJ4VGtm4kb/M3LfmRIajOCZwYL8ncLIev99icFoHsPmpev1Vm0H
         pSdNK7b2NMqQvPFS3YwXtEYnKFqBF3VzQWjHwY7dPH/R6HBnn508sHyIjItVGV7NWVP6
         7xSAdadcnhyziRsDoS9byuFjQ066flPz8InXCFZZ0mTWTIqbcV2ccZX5oFj/LfZFgrB5
         Jzr3v3cVmryzS+o3JmXzuPxe1VvBU8VvcZ2fow6AAkxkDLhkm/Nt+6g06gTw5xUGejTo
         sjLPIgbvW/ymPhEC76XiB0ggTHeoQlV1cTsbalr2v5F0Wf+SkZ9ID5Y+XaWD2CZfNnv4
         Vc5A==
X-Gm-Message-State: AOJu0YwVZnzje0lin6VBIqye/bNwg1dls8rruhFkhTKNHdbtYd6p9woF
	jdNjshctMapnMFoVLQqjU4IK4lWBiPAyYlKiTMp2Gqsxs3LEUNvP/ogatlrBKcc=
X-Google-Smtp-Source: AGHT+IHciy1K3vXPYWKDO7KOcUAhY/RfSlMXGuD/MOnf8qrDue+j8zQ+kbmcj9/A7WPEd3tm1y0s4Q==
X-Received: by 2002:a05:6000:18a4:b0:337:d6d9:bf3b with SMTP id b4-20020a05600018a400b00337d6d9bf3bmr1617280wri.117.1706378494823;
        Sat, 27 Jan 2024 10:01:34 -0800 (PST)
Received: from [192.168.1.168] (host81-135-210-216.range81-135.btcentralplus.com. [81.135.210.216])
        by smtp.gmail.com with ESMTPSA id f7-20020a05600c4e8700b0040e4914f28dsm9198487wmq.18.2024.01.27.10.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 10:01:34 -0800 (PST)
Date: Sat, 27 Jan 2024 18:00:47 +0000 (GMT)
From: Nicky Chorley <ndchorley@gmail.com>
To: hare@kernel.org
cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
    Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
    Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/3] nvme: simplify __nvme_submit_sync_cmd() calling
 conventions
In-Reply-To: <20240127093746.40246-3-hare@kernel.org>
Message-ID: <b77d0c51-58e3-b2bc-028b-7c0457a75e03@gmail.com>
References: <20240127093746.40246-1-hare@kernel.org> <20240127093746.40246-3-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240127_100138_042437_6B72D488 
X-CRM114-Status: UNSURE (   9.90  )
X-CRM114-Notice: Please train this message.
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

On Sat, 27 Jan 2024, hare@kernel.org wrote:

> 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res,
> -			data, sizeof(*data), NVME_QID_ANY, 1,
> -			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
> +			data, sizeof(*data), NVME_QID_ANY,
> +			NVME_SUBMIT_AT_HEAD |
> +			NVME_SUBMIT_NOWAIT |
> +			NVME_SUBMIT_RESERVED);
> 	if (ret) {
> 		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
> 				       &cmd, data);
> @@ -525,8 +527,10 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
> 		return -ENOMEM;
>
> 	ret = __nvme_submit_sync_cmd(ctrl->connect_q, &cmd, &res,
> -			data, sizeof(*data), qid, 1,
> -			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
> +			data, sizeof(*data), qid,
> +			NVME_SUBMIT_AT_HEAD |
> +			NVME_SUBMIT_RESERVED |
> +			NVME_SUBMIT_NOWAIT);

Is it worth writing the new flags in the first hunk above in the same 
order as in the second (so NVME_SUBMIT_AT_HEAD | NVME_SUBMIT_RESERVED | 
NVME_SUBMIT_NOWAIT)? That way they're consistent with the old ones so 
might make reading the diff a little easier.

Nicky

