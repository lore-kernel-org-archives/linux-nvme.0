Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03DDEC47DDF
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jan 2024 11:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qsroQGuekNVI21wu0weQVu2RSZ/CUa55RqKvARuewJA=; b=rzcEBReAg5QXo5QmzRkPku212q
	sPPcibzlZbRlZTC/904UGJJTa4pdm9sBWBB3DTo4f+ZNXtCF7/qielBNOrfZF31eQNhkf98K2Tfdi
	tBdGISBUXCO9tr0l73ucwIbIEnxfluW+/conwjjJaKv5T4bLZyrPDJwxDhhe/XClosMe1qW8N9xmG
	GMj7qGIFGRybiVSE6FC+aQQPRSYeYYLRfbgK6fCadWD1w9pg8uRXQSgzvbVkiW50eVfrS8Jrj4Z8q
	RTuOeCeiRf2l7k07sc2Icr75/eqd5gtdgskvFr6t7Bk+Ma6m56N36wjy/uJNuJblDuY4P9zCj/PU2
	SLsIGq2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUmPQ-0000000GTw8-0NPx;
	Tue, 30 Jan 2024 11:36:08 +0000
Received: from out30-99.freemail.mail.aliyun.com ([115.124.30.99])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUmPD-0000000GToU-3D0a
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jan 2024 11:36:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706614552; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=qsroQGuekNVI21wu0weQVu2RSZ/CUa55RqKvARuewJA=;
	b=eoc+Wl3oGihWw4XosQI/Rudrof6XoaOsYbWtBOAfMNk8bh0g6AdtgMuoDSs3Z5Wvq+h2tHQRAmU6SclGRW8eobhG7lPQQkFOioJQeT0gzI8Dpqe469dNZOXfgObcBlc+GNMN7B3VOLvAHVTYnWGq+BCOP+nreUO/DggjYvp6w1U=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W.g4uIl_1706614550;
Received: from 30.178.83.131(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W.g4uIl_1706614550)
          by smtp.aliyun-inc.com;
          Tue, 30 Jan 2024 19:35:51 +0800
Message-ID: <9f9a68d3-0da0-4e3f-9579-70be365da740@linux.alibaba.com>
Date: Tue, 30 Jan 2024 19:35:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] nvme: parse dsm command detailly when tracing
Content-Language: en-GB
From: Guixin Liu <kanie@linux.alibaba.com>
To: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
References: <20240130113406.8414-1-kanie@linux.alibaba.com>
 <20240130113406.8414-3-kanie@linux.alibaba.com>
In-Reply-To: <20240130113406.8414-3-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240130_033556_216346_0542D5F6 
X-CRM114-Status: GOOD (  10.70  )
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

Wrong send, please ignore this patch.

在 2024/1/30 19:34, Guixin Liu 写道:
> Add detailed parse of dsm command to make the trace log more
> consistent and human-readable.
>
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>   drivers/nvme/host/trace.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
> index 95572c85b22a..b383d51c1a0c 100644
> --- a/drivers/nvme/host/trace.c
> +++ b/drivers/nvme/host/trace.c
> @@ -153,10 +153,12 @@ static const char *nvme_trace_read_write(struct trace_seq *p, u8 *cdw10)
>   static const char *nvme_trace_dsm(struct trace_seq *p, u8 *cdw10)
>   {
>   	const char *ret = trace_seq_buffer_ptr(p);
> +	u8 nr = cdw10[0];
> +	u8 idr = cdw10[4] & 0x1;
> +	u8 idw = (cdw10[4] >> 1) & 0x1;
> +	u8 ad = (cdw10[4] >> 2) & 0x1;
>   
> -	trace_seq_printf(p, "nr=%u, attributes=%u",
> -			 get_unaligned_le32(cdw10),
> -			 get_unaligned_le32(cdw10 + 4));
> +	trace_seq_printf(p, "nr=%u, idr=%u, idw=%u, ad=%u", nr, idr, idw, ad);
>   	trace_seq_putc(p, 0);
>   
>   	return ret;

