Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34361C83F34
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Jul 2025 13:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GRDhOPTJcT4Z/nkAWxhX0sqDgjg+qtu1GO/I4bxt9MM=; b=ELcjSsb6uecPcmfU3skh/3XE+M
	FTe9/EuLY5G1ehenqVozc5kmFDGdOwyDqKHx11nTIFc7pulycE9diwmQ4A9sOSXtxQH0eS8LgpmEl
	83FOq3bIjMAHjRNBHO7N9Jxso6yzhbhy6qpBSGayiZ9oGmHWTvx/jrqBYE9yx+Xrh5iFp+UtQHf9n
	NlnbkXQGBlIXPteSbIjc3F7JThnxkWTHq1x+rMRaPApSsNU0X8OCMflrN8eshGw9JnZM5Isv6QrNu
	d5sWh243uDFS59TeGOcvuLnHTVFX2f4Z6EWNc1y+uvSFoiYrPLZkeacfZjZOcmSJSrEz15LM4mG9J
	DlPvjEzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucORg-0000000AE4H-2ANU;
	Thu, 17 Jul 2025 13:14:44 +0000
Received: from mail-il1-x136.google.com ([2607:f8b0:4864:20::136])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucNH9-0000000A3Lc-1pAs
	for linux-nvme@lists.infradead.org;
	Thu, 17 Jul 2025 11:59:49 +0000
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-3e05bb6efe0so7907915ab.3
        for <linux-nvme@lists.infradead.org>; Thu, 17 Jul 2025 04:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1752753586; x=1753358386; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GRDhOPTJcT4Z/nkAWxhX0sqDgjg+qtu1GO/I4bxt9MM=;
        b=U6/37OV0eMdVpiWGuJedveRIfI91o4V4CTt3dTxXqzQmqnStDQg5kbSlBW8qmhkXoj
         QnwJpOhwme0bV5Br8w0OtX1dTxu9sJB5K41l60suP3M+vyzh5a1uI2edy/qBq5xsh38Q
         nCTxam+E7AFZ7hiyDQC3kCqDi6vN+nOFLHxQhCj63u3omiO10YchTwpvGx7VCYjmgGnf
         VgqzX86QAGVmfTheAmPBmEQLYvnJ3iMWPyuHpNJhbrPfo7eUZuD/GRGYO4Q1B4g1ZWta
         wHir9a7vQZDXcI4m1n48p6x7+3s5yUCSWSJ9XGGSmyrAskFN9+yDZLi62EOoI+FyVBzU
         r4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752753586; x=1753358386;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GRDhOPTJcT4Z/nkAWxhX0sqDgjg+qtu1GO/I4bxt9MM=;
        b=nvQWNJJ+ntoTg0TY17cxskcTEOur0FaQQ8uq6Jg07UKizfropj+Ja0P612w4SKuu8e
         depTtvp3yRA7PD0I6AFNSJ3YxKvm0qGzS9tQyuafTx6iNfSrZ1vD4OR740d8hTi3+WR0
         efN5yzHDjFqocSLIik8kc4z/QRyZcQ5BC5yzcyEOX76iBko8VsR7q1ZP/m4jSj+7XkoY
         I63VXLwRWs6aFCX7FxsxNSl6MUsdAMsCNIKVutFpxocM2MBhX2NwokFOnNukeHJUgZma
         1F06cJ3znRJmsQZlcJKh460k98QhbcuNgcJVmcgBvZJkB/jww9HrBQbweJACjS9PF6DH
         wPTw==
X-Forwarded-Encrypted: i=1; AJvYcCXz/aE/Ncyi3WYOyJ7KoEqiCX4avaYVaIQ3h99KyWqkxWWOn1DndpkmKujDF1uiIsTpT2ec8Ie/u44f@lists.infradead.org
X-Gm-Message-State: AOJu0Yys/Bob67XrYEpFam32my6HBZJ4zEVKDn+S+oy41ciHmm/+Q+b3
	SrIA+hhaqyvpQWUY4y1rZILx3fLxBSJvODH1ZwpN0RwfCeYQPltJ9rJfCOQahAXy8tU=
X-Gm-Gg: ASbGncs2ZPeaziQUbGGwdBJQlQexCNDEf35o0w0IlEKgdqmNd/4S778VVd7Z/m/z2WN
	iFiQEGxXfVzv6YOLIwxAGmrwxW5lKOdWQRhTD8/d9T6Jqbu9WhGHiGDwPp1h75hkcqxw308jKRu
	iWa8DaVZOVoSHFebdb0/Iz7YBV00kBculjqJPSnvEJJfAb8UTfRwau2G0CPsIxkCStA5tk+wC6m
	hiNYkYd1AAAltBPcpV4V4bZ1nm/ClLpElKwZHTNzPxpJzImwcPYgTAVH+CD/dOcVjkPYGZLLV5A
	/t1AP0JxuSYCKKC5Pm+ICss2wv6yUmyF0Akuswn/Assx4ph4dWKMcGnd0TVJcu/eI2SB+esTKuf
	OrqDQevFk3/MSKfPK1x4=
X-Google-Smtp-Source: AGHT+IF0aIFjZk0/SWFFLxGkKw8ydUTb+TGIScYtv8p0Ovs5rLUmiuvF34/q8UiLuJa1W5/ASv+UgQ==
X-Received: by 2002:a05:6e02:19c7:b0:3dd:d321:79ab with SMTP id e9e14a558f8ab-3e282485737mr78029765ab.18.1752753586120;
        Thu, 17 Jul 2025 04:59:46 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-505569cc669sm3357918173.100.2025.07.17.04.59.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 04:59:44 -0700 (PDT)
Message-ID: <892197f4-452f-4c76-9621-5ef860c48a25@kernel.dk>
Date: Thu, 17 Jul 2025 05:59:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 6.16
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
References: <aHjgWKyuasbJrqg6@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aHjgWKyuasbJrqg6@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250717_045947_715902_F32486B5 
X-CRM114-Status: GOOD (  11.50  )
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

On 7/17/25 5:36 AM, Christoph Hellwig wrote:
> The following changes since commit 3051247e4faa32a3d90c762a243c2c62dde310db:
> 
>   block: fix kobject leak in blk_unregister_queue (2025-07-11 20:39:23 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.16-2025-07-17
> 
> for you to fetch changes up to 0523c6cc87e558c50ff4489c87c54c55068b1169:
> 
>   nvmet-tcp: fix callback lock for TLS handshake (2025-07-15 09:49:13 +0200)
> 
> ----------------------------------------------------------------
> nvme-fix for Linux 6.16
> 
>  - revert the cross-controller atomic write size validation that caused
>    regressions (Christoph Hellwig)
>  - fix endianness of command word prints in nvme_log_err_passthru()
>    (John Garry)
>  - fix callback lock for TLS handshake (Maurizio Lombardi)
>  - fix misaccounting of nvme-mpath inflight I/O (Yu Kuai)
>  - fix inconsistent RCU list manipulation in nvme_ns_add_to_ctrl_list()
>    (Zheng Qixing)

Pulled, thanks.

-- 
Jens Axboe


