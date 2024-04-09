Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075CCC67861
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Apr 2024 20:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lULEqVs4tWshiKYsjKkDxlfPSKjepcgNdZDCa3C6hZk=; b=XOd2RnCLBCmxMObAnrYEIljrb9
	RYHG6qTq1TzXap1LwbpWf1u64DHphZh+lCW7DTpYv8qbq3MdD1BrjWlbzG9F7qFH2O5midl7ttR2B
	V4PgOgbCihwxGJr2xehvRpKSP/pn+pAF+KoetrLGw530F5nVU1qwgQvYIeamuVDtS/hjJoIhnJu2+
	FSkXBkLQiUIhmKmBMc/D/drEnQBmxtuP98YPN6ubGT9i+j1tJ5jJ994vSYmWX23MVuuikmcCWF2mJ
	BqpZJR4+ZBsQ8TDqJOgA+REwhVzeFbBhB4nNPgbzSm9smotJSlGl1s7KjmRyANNqBOD5W1rhm6rca
	QL0lfFLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruHxo-00000003gvT-3pJL;
	Tue, 09 Apr 2024 20:21:04 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruHxm-00000003gtt-0FqR
	for linux-nvme@lists.infradead.org;
	Tue, 09 Apr 2024 20:21:03 +0000
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-346407b8c9aso291097f8f.0
        for <linux-nvme@lists.infradead.org>; Tue, 09 Apr 2024 13:21:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712694059; x=1713298859;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lULEqVs4tWshiKYsjKkDxlfPSKjepcgNdZDCa3C6hZk=;
        b=TxCG5yJmBDZQfQqvnfxgOuJW4D9fp4lu4dETC8KVWasf88Iwfka6y1LTiMjt8VhMpg
         2zW3nwmMN5vFK9h+WC3xtkQcXSA0LcR+8nYQwxPUudYKGnOV1+2lMqCYKNo0lAbxKPTr
         e0e+h7tqAkcS5+0ii5xWytJEaDPo6+5SjA/aSAtl4jGGGiYabbrnO/C/2yjCbEDF2NPp
         9a7qrLmtfLcp68TrK1ojzmilBSjhGxghJaZNt+NU9Im7+Hgvli4lWtYA8lIbpPDpSQW8
         nmUlNe3gQYGkYS3xqXXXMgzDmbNeb+qZV0MfFy/CKIaRaZ9qOlZ2UcrZroyGyek4lXAI
         EKug==
X-Forwarded-Encrypted: i=1; AJvYcCXWlWYYgH9uFusShze0d2u0Zu+vLdVQYjEcsiYM5f7RyGfmNUKP4g0E8xkO/5L3K6u+nSXjswwRv3hvy9+cPpUxTRGMqyO/WVTKHlg6yIE=
X-Gm-Message-State: AOJu0YzKHHXw1/AVtPnhsgaCuNue2MRjQnWnHi9ArIkidB91TXRdESX9
	KrI2nNG8oPQ9e7dC9aMuMSj2EiVoLCOyCUMyZQO4jXPbsbaFK5rg
X-Google-Smtp-Source: AGHT+IG6MNaAyXXodTjWqghpCkWIqtkZEu+r8y5gb0akf8pgLPLriB5ARN54fPl8PnsCGmXRXU2QBQ==
X-Received: by 2002:a5d:4a4e:0:b0:343:c3b0:ee39 with SMTP id v14-20020a5d4a4e000000b00343c3b0ee39mr439936wrs.5.1712694058954;
        Tue, 09 Apr 2024 13:20:58 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id e8-20020a5d4e88000000b003438cc1d2b4sm12253228wru.59.2024.04.09.13.20.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 13:20:58 -0700 (PDT)
Message-ID: <e73b73af-a8c6-49f2-b47a-126fab4836b2@grimberg.me>
Date: Tue, 9 Apr 2024 23:20:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/6] nvme-tcp: short-circuit reconnect retries
To: Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240409093510.12321-1-dwagner@suse.de>
 <20240409093510.12321-4-dwagner@suse.de>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240409093510.12321-4-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240409_132102_203705_F1522253 
X-CRM114-Status: GOOD (  25.40  )
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



On 09/04/2024 12:35, Daniel Wagner wrote:
> From: Hannes Reinecke <hare@suse.de>
>
> Returning an nvme status from nvme_tcp_setup_ctrl() indicates that the
> association was established and we have received a status from the
> controller; consequently we should honour the DNR bit. If not any future
> reconnect attempts will just return the same error, so we can
> short-circuit the reconnect attempts and fail the connection directly.
>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> [dwagner: add helper to decide to reconnect]
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/host/nvme.h | 24 ++++++++++++++++++++++++
>   drivers/nvme/host/tcp.c  | 23 +++++++++++++++--------
>   2 files changed, 39 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 9b8904a476b8..dfe103283a3d 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -701,6 +701,30 @@ static inline bool nvme_is_path_error(u16 status)
>   	return (status & 0x700) == 0x300;
>   }
>   
> +/*
> + * Evaluate the status information returned by the LLDD in order to
> + * decided if a reconnect attempt should be scheduled.
> + *
> + * There are two cases where no reconnect attempt should be attempted:
> + *
> + * 1) The LLDD reports an negative status. There was an error (e.g. no
> + *    memory) on the host side and thus abort the operation.
> + *    Note, there are exception such as ENOTCONN which is
> + *    not an internal driver error, thus we filter these errors
> + *    out and retry later.
> + * 2) The DNR bit is set and the specification states no further
> + *    connect attempts with the same set of paramenters should be
> + *    attempted.
> + */
> +static inline bool nvme_ctrl_reconnect(int status)
> +{
> +	if (status < 0 && status != -ENOTCONN)
> +		return false;

So if the host failed to allocate a buffer it will never attempt
another reconnect? doesn't sound right to me..,

