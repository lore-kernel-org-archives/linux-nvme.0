Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C75B4C41535
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 16:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cfI4bfiiLxbch7IOWy11LtDVNG3OtnvwhPz6HqfBH6Y=; b=l1wmHz9aEK7oQ0aKagG3CmUJUb
	9Ya/0SmNrWdfm3U8rtmr+EixDJyZmsy7tAgR3w1gcLQajFozUan2rayl9DuoMv/bLJCXh1p/PwYol
	Y/xD6KNLprFDLZv7GqJOw0s0g9m/ImbOYBL3+94JIImcl9ZZh3KQtSBffi6eGy4hDWyXZPacfCWhL
	XQdyXiSqTO3XOs7S4uUvi2VYtC5SNf2VJmxhzyp1dZfE5LYlsIc4KVP6Gie8mssHFnCFV7Qik2U/l
	HZwMwoGA5k/qBWAu7u5OwGnWHEtHNDnZYOsFDCJzGX+orPxPfSEliv0BNv3ZeVbPgC538NZT511TC
	RVn2ckgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFcrt-00EffT-32;
	Tue, 19 Dec 2023 16:22:53 +0000
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFcrq-00Efe7-2T
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 16:22:52 +0000
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-28ba5cca7fdso248391a91.0
        for <linux-nvme@lists.infradead.org>; Tue, 19 Dec 2023 08:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1703002969; x=1703607769; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cfI4bfiiLxbch7IOWy11LtDVNG3OtnvwhPz6HqfBH6Y=;
        b=PF9k0WENS5J5+LvjAHmxy///M78C2uWKzmQgbJ8M3nH/TZs1UlhUc+eWNQXARVk87p
         UXnAVIyn9HDWMkklx78y4Hgv0REu4Pxqdaa8WZxdSUE/mffDS3d8yhXKASbUDi3DWmdl
         tulAE3Q3K3GyGi+mtuv5bIrkDksh1zs1nECqKonY/EFKLfGjLwcGeCG4VxESEqXoKTtu
         71vZfQtJN97kvmfIVC4WXinGjoAYA/yE94ukicozJJkPCFYT+JXgg/JsWUFcEMfEptT+
         8JMQpUZ2DEhcL3nSNGc6BSbYd4mAXZRKwCz4PGXT+suB6/g1MU5F1+Zx8ENoUgmjorJX
         PMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703002969; x=1703607769;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cfI4bfiiLxbch7IOWy11LtDVNG3OtnvwhPz6HqfBH6Y=;
        b=GpQUy8HbA8thf41MtLGyEOmIym6qsIMm4Z2c6BnQlt2YwbE1Jf5lHPcMJm+MjGC09y
         aOgdofw5yzA8V4U9PP7VDDN1997GPsQBscFG/jwO65qIxrtkuvj6mE800giSeqmB98KW
         t78+PsKoWinWDpokHxretTMuzRFidIoNNwbUeiv48FBuBPJtf/7FiuE2k+AKUHP4lQHb
         TXpvN467IVHnzgR4+X1V9nZhv0M4n4xn5kBBgzNfdw3/g7uGhzXq6qlw3+TZgdnl4MRq
         DwHnMJxWcMhSnbDpnOxsi8AbyWOXwZ4ZQ/kIdMVE/IHeKt5ic72L/5y41HBFqyVBrq6p
         V9jw==
X-Gm-Message-State: AOJu0YzgsUug1F70SFlzh73DGqPaopJXfC0fq1C/TxrHmZFunqbFHpLb
	27fWcU/q5XMuX9OBStBo7DAZUVKudxnvLzrrWnKuXw==
X-Google-Smtp-Source: AGHT+IEgahBFywzOPel4pUn6C2TaXrNjVEzv3Jm9D2LuQIAnz7vq0UBPTrRhCf6QKpk4VAO01og31w==
X-Received: by 2002:a17:90a:5796:b0:28b:a5ea:732e with SMTP id g22-20020a17090a579600b0028ba5ea732emr3947616pji.2.1703002968985;
        Tue, 19 Dec 2023 08:22:48 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id qa8-20020a17090b4fc800b0028b11757032sm1800567pjb.29.2023.12.19.08.22.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 08:22:48 -0800 (PST)
Message-ID: <25a78b1e-783b-40ea-a12e-8fb316b2eafb@kernel.dk>
Date: Tue, 19 Dec 2023 09:22:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] nvme-pci: fix sleeping function called from interrupt
 context
Content-Language: en-US
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me
References: <20231219154201.438767-1-mlombard@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231219154201.438767-1-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_082251_144847_CCB214BF 
X-CRM114-Status: GOOD (  10.44  )
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

On 12/19/23 8:42 AM, Maurizio Lombardi wrote:
> the nvme_handle_cqe() interrupt handler calls nvme_complete_async_event()
> but the latter may call nvme_auth_stop() which is a blocking function.
> Sleeping functions can't be called in interrupt context
> 
>  BUG: sleeping function called from invalid context
>  in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 0, name: swapper/15
>   Call Trace:
>      <IRQ>
>       __cancel_work_timer+0x31e/0x460
>       ? nvme_change_ctrl_state+0xcf/0x3c0 [nvme_core]
>       ? nvme_change_ctrl_state+0xcf/0x3c0 [nvme_core]
>       nvme_complete_async_event+0x365/0x480 [nvme_core]
>       nvme_poll_cq+0x262/0xe50 [nvme]
> 
> Fix the bug by moving nvme_auth_stop() to fw_act_work
> (executed by the nvme_wq workqueue)

Since this looks like more auth fallout, can we get a fixes tag in here
for this?

> V2: Just move nvme_auth_stop() out of nvme_handle_aen_notice()
> so the latter can be safely called from interrupt context

Changelog stuff goes below the '---' line, not in the commit message.

With those two tweaks, patch looks good to me.

-- 
Jens Axboe


