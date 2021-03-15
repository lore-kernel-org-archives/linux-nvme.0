Return-Path: <SRS0=15CP=IN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4939DC433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 17:20:24 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0A0A64E83
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 17:20:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0A0A64E83
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3J2qE2fxzQP/PwW0DMHKCksj0eoxj/FVL6Er9ueNew0=; b=XEX6Ttulld1jIm9hghKopwX4C
	HWoCmFh98gGMaoxvHWRqjah0OXhQMDdFi4SKzcdMgAd83gY7d65uNaMB85p5tSHFSKBCYqEPEqkOR
	Xfg/+fNTKIS8Pc0r7xW2nYK/RqZvLLk08+CoxUYSHj0cx8R3QUD6DzE/YNXi5Z9Y6mfKt9JM5vKeh
	Hyz5kPwxtrW9w223jV1hCkCoM1Ot1MIc5l4rxFSRsF7eBEBbHnuRt1ootKckBjEB1rdMPPGhmuipj
	Q54kE4aX5U4dOnMat5B4uvuF3rEXdiB2eDFKaUeU0OopZbYGUuVAfrdqUlNxUTshCurb8vNWj1vor
	y+MuHb8tQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lLqt5-00GUX4-Mo; Mon, 15 Mar 2021 17:20:16 +0000
Received: from mail-pg1-f170.google.com ([209.85.215.170])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLqsw-00GUTp-Ub
 for linux-nvme@lists.infradead.org; Mon, 15 Mar 2021 17:20:09 +0000
Received: by mail-pg1-f170.google.com with SMTP id n9so19887918pgi.7
 for <linux-nvme@lists.infradead.org>; Mon, 15 Mar 2021 10:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dhte2D5Jm2p++hI6/DrWwYoclUkYAfx2V2JV3XPR538=;
 b=rqKEj6Ca3VbR/FN+oMtia9urY9iSP+F3O3+sIHReZkMKWEs/0DpNXWuFdw37dZfkzH
 G7cQxeGZ0a6fJ9FEnB+o2hTUvE5RDUHT6HPw3VdkH7DKnTDI17ZUASy0Zrjek8qvlJDz
 CPW6MirqvnohMLyV4xF9brW97MxQhxl8toY7cpqnGH5GIih0eCt9NkNBM+y0+Vb1Xnnt
 xaLcFQNwuQQp7Hy3tMFjQF9dfnDnY02nxkwytENeShqzzDHFoiCtUhq5eWDxD9JJ7IQ/
 Kof5josymC96XcK5uOqRYEL3+qxt+fiPoFTRjdgkTp+8+BXtTzPDo00tjoS4gg2yNuSx
 Trqw==
X-Gm-Message-State: AOAM533W33eiAbdbL3/BTJsgeAWDNZCgM3lfrOmD8R2q0EYtADDKA8RC
 IYsf5xU3Bcl8/63yI7GkIsM=
X-Google-Smtp-Source: ABdhPJz+HFlXqAvzFrT6KArU8kRmTwppYRUD/YWjHs1b5/oLIA6W9FdoN+bKKnZ9COU65k8zuu2VIQ==
X-Received: by 2002:aa7:9614:0:b029:1fa:e77b:722 with SMTP id
 q20-20020aa796140000b02901fae77b0722mr11557622pfg.2.1615828802423; 
 Mon, 15 Mar 2021 10:20:02 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4faf:1598:b15b:7e86?
 ([2601:647:4802:9070:4faf:1598:b15b:7e86])
 by smtp.gmail.com with ESMTPSA id g22sm219063pju.30.2021.03.15.10.20.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Mar 2021 10:20:01 -0700 (PDT)
Subject: Re: [PATCH] nvme/rdma: Fix a use after free in
 nvmet_rdma_write_data_done
To: Lv Yunlong <lyl2019@mail.ustc.edu.cn>, hch@lst.de,
 chaitanya.kulkarni@wdc.com, Israel Rukshin <israelr@mellanox.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210311054413.8731-1-lyl2019@mail.ustc.edu.cn>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3ffd40a5-efe8-d3e6-9142-c3fbd3419f65@grimberg.me>
Date: Mon, 15 Mar 2021 10:20:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210311054413.8731-1-lyl2019@mail.ustc.edu.cn>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210315_172007_536677_ABEA4E7F 
X-CRM114-Status: GOOD (  19.06  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> In nvmet_rdma_write_data_done, rsp is recoverd by wc->wr_cqe
> and freed by nvmet_rdma_release_rsp(). But after that, pr_info()
> used the freed chunk's member object and could leak the freed
> chunk address with wc->wr_cqe by computing the offset.
> 
> Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
> ---
>   drivers/nvme/target/rdma.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index 06b6b742bb21..6c1f3ab7649c 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -802,9 +802,8 @@ static void nvmet_rdma_write_data_done(struct ib_cq *cq, struct ib_wc *wc)
>   		nvmet_req_uninit(&rsp->req);
>   		nvmet_rdma_release_rsp(rsp);
>   		if (wc->status != IB_WC_WR_FLUSH_ERR) {
> -			pr_info("RDMA WRITE for CQE 0x%p failed with status %s (%d).\n",
> -				wc->wr_cqe, ib_wc_status_msg(wc->status),
> -				wc->status);
> +			pr_info("RDMA WRITE for CQE failed with status %s (%d).\n",
> +				ib_wc_status_msg(wc->status), wc->status);

There is nothing wrong with this reference, wr_cqe is a valid reference
and I think Israel added this for some extra information that may be
useful to him.

Israel? you ok with this removed?

>   			nvmet_rdma_error_comp(queue);
>   		}
>   		return;
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
