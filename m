Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AAA6C021A4
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Feb 2025 08:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NagTNPWVYEQIFN5KJ5zTY9g1pZIdqaqMK1tcId/zS64=; b=Ne5rRJQiu9RaWrzznIvXxG9v64
	yAmKl6U+TmGmrMCCJy7TEEq3ooomzL7BBpkDb+hy/Z1aUgjeAmaNYF/Z/xZg5sU83trDI05X7P76r
	LRVyrfDU8AXKrw2LIrFCUVpwKKo2ZTGMAHSqvxHjP2BEjSEzNeEDa/JQmdsWrM026kpRlpESqJsTG
	5Z48TKJ/ljH1bIkcovpaicTrfowNAsVeEl/7OA8+xwItdnNc+4U+NBrkoIkznB6NQKHhPzP7oyiq0
	Vb5Y+rPclnCc9Km9PaN0uKVwJwG1zTgvt89WNyaDtYiu0k8zuuCrxB41qomVi496ClbRTVvf3uhnX
	p1Xbk0YA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tjwHl-00000003jLT-2wxP;
	Mon, 17 Feb 2025 08:15:25 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tjwHD-00000003jId-0cdH
	for linux-nvme@lists.infradead.org;
	Mon, 17 Feb 2025 08:14:52 +0000
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43967004304so17520235e9.2
        for <linux-nvme@lists.infradead.org>; Mon, 17 Feb 2025 00:14:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739780089; x=1740384889;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NagTNPWVYEQIFN5KJ5zTY9g1pZIdqaqMK1tcId/zS64=;
        b=Xs0Ymr7GkPs4Hy11pgE3MmxlRC8SViGYcZEIbKPOIJ7xpPIAQol+W6FB8MyIc9D3f4
         +2P93b0kJO/BCBPf8MBcTtUlJkaIDtBA19MMJe58N8wwYhCBI+Bj+kcouDjpHMvfTjhy
         uRCTC7ltpE0UA0CeI+nPpSBJpM6q0qWMh/IUoiTMCP2emXh25o9F9kbe+wdscwBCC6px
         aDZiZl0Ezso08zHxyny5LNjVSEIOANxfVMaLhSlH1vV4NXxYjgkEVq1V9UJlZF9+2Uhx
         LUhUOA8i4+63D0+79Agly8OL2YZ2K5wE3wfC5aj7MxczYkNajfiU5d5dFn16ozhmOxgy
         cjYw==
X-Forwarded-Encrypted: i=1; AJvYcCVr4+SVLZNtKJydHJEG3fhFNHEnaR0OjDGh0oHdBlrvReR4LR6Z526Geyh1Jaw3UNGq8xJQBaFEYLFE@lists.infradead.org
X-Gm-Message-State: AOJu0YxU27T7WzE9QfLNLypdvgECoLt6wFxvIgVI5+ZDyYVRuzD8P0lt
	deaMEWpY5ZP/MFs0FOPDcVKpQeMwLB7sTs2hN//Fe7cOjNZmh/RA
X-Gm-Gg: ASbGncviafO42soaTNEVwZxi0tp845Z77/NvsMmBJYfir0QiI0Hgkq82rwwy0NSJihF
	IppFpjhTA2Y5j4j9/86wMsfbpFITzReHRpz9I+kLbZ7PUShML6l+6oG+yyZ/KUc0tawANjdIVES
	85rFfEvK+S6Vt0ScVf6ExwBA6bqU+trBD4hYeXZJpikRbVbE7sD4jXUlrbV2/LmtODH9Au6kJff
	M3A8vFCmUoDB0Brmv5Y81JFrT1DgckWhL6BIkRENheD4GYD5TNOotxLxCAiw0NmnVTIf937lHjO
	WKRUWCcxRnPn85+70O6KPa0F3UJ2uOCdUmxJvAC3iXhAfQJ3+3evTojsnQ==
X-Google-Smtp-Source: AGHT+IEIU5CLjQlA9tkFqcYYDvM8EiwLUkyGRzjsg6HWbjj8thv67Wuud8YrjwIJXvgxVWAxOSnkIg==
X-Received: by 2002:a05:600c:1909:b0:436:488f:50a with SMTP id 5b1f17b1804b1-4396e6f6f9cmr72006395e9.17.1739780089313;
        Mon, 17 Feb 2025 00:14:49 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4396b0aa4e9sm75605275e9.16.2025.02.17.00.14.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 00:14:49 -0800 (PST)
Message-ID: <92435d5a-34d8-4450-a0ba-f1fef782b3a2@grimberg.me>
Date: Mon, 17 Feb 2025 10:14:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-tcp: add basic support for the C2HTermReq PDU
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: axboe@kernel.dk, hch@lst.de, linux-nvme@lists.infradead.org,
 hare@kernel.org, mlombard@bsdbackstore.eu
References: <20250214190012.311960-1-mlombard@redhat.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250214190012.311960-1-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250217_001451_192554_E52715C3 
X-CRM114-Status: GOOD (  20.96  )
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




On 14/02/2025 21:00, Maurizio Lombardi wrote:
> Previously, the NVMe/TCP host driver did not handle the C2HTermReq PDU,
> instead printing "unsupported pdu type (3)" when received. This patch adds
> support for processing the C2HTermReq PDU, allowing the driver
> to print the Fatal Error Status field.
>
> Example of output:
> nvme nvme4: Received C2HTermReq (FES = Invalid PDU Header Field)
>
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>   drivers/nvme/host/tcp.c  | 37 +++++++++++++++++++++++++++++++++++++
>   include/linux/nvme-tcp.h |  2 ++
>   2 files changed, 39 insertions(+)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 841238f38fdd..8f783185575d 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -763,6 +763,40 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
>   	return 0;
>   }
>   
> +static void nvme_tcp_handle_c2h_term(struct nvme_tcp_queue *queue,
> +		struct nvme_tcp_term_pdu *pdu)
> +{
> +	u16 fes;
> +	const char *msg;
> +	u32 plen = le32_to_cpu(pdu->hdr.plen);
> +
> +	static const char * const msg_table[] = {
> +		[NVME_TCP_FES_INVALID_PDU_HDR] = "Invalid PDU Header Field",
> +		[NVME_TCP_FES_PDU_SEQ_ERR] = "PDU Sequence Error",
> +		[NVME_TCP_FES_HDR_DIGEST_ERR] = "Header Digest Error",
> +		[NVME_TCP_FES_DATA_OUT_OF_RANGE] = "Data Transfer Out Of Range",
> +		[NVME_TCP_FES_R2T_LIMIT_EXCEEDED] = "R2T Limit Exceeded",
> +		[NVME_TCP_FES_UNSUPPORTED_PARAM] = "Unsupported Parameter",
> +	};
> +
> +	if (plen < NVME_TCP_MIN_C2HTERM_PLEN ||
> +	    plen > NVME_TCP_MAX_C2HTERM_PLEN) {
> +		dev_err(queue->ctrl->ctrl.device,
> +			"Received a malformed C2HTermReq PDU (plen = %u)\n",
> +			plen);
> +		return;
> +	}
> +
> +	fes = le16_to_cpu(pdu->fes);
> +	if (fes && fes < ARRAY_SIZE(msg_table))
> +		msg = msg_table[fes];
> +	else
> +		msg = "N/A";

msg = "unknown" ? we shouldn't suggest N/A because it should be very 
much applicable.

> +
> +	dev_err(queue->ctrl->ctrl.device,
> +		"Received C2HTermReq (FES = %s)\n", msg);
> +}
> +

AFAIR, the goal with C2HTerm was to also log the offending PDU itself. 
However I don't think
its really necessary looking back.

Can you test this also with header digest enabled?

Conditioned that the above passes just fine, plus one minor nit,
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

