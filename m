Return-Path: <SRS0=i2V4=PV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9B0C433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Nov 2021 23:53:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A5A760E0C
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Nov 2021 23:53:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8A5A760E0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QAiloa57Qj9ZgrZe+5FGjaU8rODp+CJDpfSgisXcics=; b=N82kPm0O/ehT26hbVIJ4eTl/Nf
	LSVWFOEraWJcHjx9IZ4SXYVyT/I2yWHHRo3jgDvnZmDOwHe+A08NpLJWFTddJjSFII6jLafn4IcM2
	YjaKdpTTUooIdFP/WNN2dkn8yzt2R5U1bMUzCnd9J/68EeETAb2wkNLVMF1rD32lHDLy/rBfHV+Ub
	tYSeDVmmUIMR+SVIFxyfOnub6mVVcicHtdhD3JjxXnOgNm+TtYcYR2muqt9BBQVEurao2NQjNLTMe
	xYL4hJTyI+dv5TVArNgstbbjNVlZ/gT63xRRxco0roBKS/ARNGDuqkk80/5Ja7O3A3LZ9NbC1Ix7H
	csIEWGyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mi3ag-003Ua1-Am; Tue, 02 Nov 2021 23:53:18 +0000
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mi3ad-003UZJ-EA
 for linux-nvme@lists.infradead.org; Tue, 02 Nov 2021 23:53:16 +0000
Received: by mail-pg1-x532.google.com with SMTP id e65so775815pgc.5
 for <linux-nvme@lists.infradead.org>; Tue, 02 Nov 2021 16:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=QAiloa57Qj9ZgrZe+5FGjaU8rODp+CJDpfSgisXcics=;
 b=nJMSEvl6XzBhcjfG6L9JwnN/gFxBTMACtA72CGjAPI9oQkP1UDvemhHOS0VcCIUjeI
 djQgxbBa9IgSWowH35eVvJijO8FJ4VeE6nd4Up2kTHUoMuwRt7ulNcd4KKgb3ER/T1VD
 H+OwJzJSoRAk6FPOitPV7OKnV+FFExBm8xfgl2AsnFGXWL3p4vj3I2I936tu4vgkg3lP
 p5vwWlQ0sib6uxeWxUcSSgWx9Alm5qmKUPwiDAgbiJ8H1pM/7CefU5FbV5WLLw/cRKBu
 r7wo6Xb+bd4OIlcEJ+F1QyATV2xGgCrc+r4I6vcKxAOrDzL5+qkjbeynfcklAoegxmDD
 3zqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=QAiloa57Qj9ZgrZe+5FGjaU8rODp+CJDpfSgisXcics=;
 b=4QwNxW4k+eDpL3MAV028DMvyNK2k/lqd8K0GmlgUEKrWmwse8DxXonMYVGuuWXS5sG
 I2+fjJVWAjyrzLv+i2Nh3Q8Qs8YjbIedZv2ry01vjDvRqN0oawxLiINn2yof88JiH21i
 KPD2trQryEfifnzooXXfABVx1utKKqcYcYmmeFSpHe3Vq32VQz4/YUjWUzpdtWfd+YFM
 7y0wJwzOOchPH2aag1yndqtByOvyqloLwLQswOm8e99nVmOk4Zya5y9oQtk6TmPaiaaN
 UJWDjN1n978xNn/7oZvlW5dL/nRHktvCupv76VrzK/xuvqyCkepP3jMejsHiYTjlB6fU
 Oj3w==
X-Gm-Message-State: AOAM532IiRoNK/STXMp5w2eCXczRUMu8C/WUc2mPYEroTffy0Li2YYDU
 rO3CWE8wZTAkm5mL0x+F8EE=
X-Google-Smtp-Source: ABdhPJxQwlQjT+PSAUtlE9rzrnlnl6KcgXEFY4Phjmjxa5OSwtv39CeWmCRzpo3eo6qTYZaW2soN7w==
X-Received: by 2002:a63:e24b:: with SMTP id y11mr29956303pgj.452.1635897194959; 
 Tue, 02 Nov 2021 16:53:14 -0700 (PDT)
Received: from [10.69.44.239] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id m184sm176825pga.40.2021.11.02.16.53.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Nov 2021 16:53:14 -0700 (PDT)
Message-ID: <5e8d969f-8ae6-2675-6dc2-e68b3b06d22c@gmail.com>
Date: Tue, 2 Nov 2021 16:53:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 03/10] nvme: add err_work attribute to nvme ctrl
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, kbusch@kernel.org, sagi@grimberg.me
Cc: chaitanyak@nvidia.com, israelr@nvidia.com, oren@nvidia.com, hare@suse.de
References: <20211020103844.7533-1-mgurtovoy@nvidia.com>
 <20211020103844.7533-4-mgurtovoy@nvidia.com>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <20211020103844.7533-4-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211102_165315_535163_EC4529EB 
X-CRM114-Status: GOOD (  13.21  )
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

On 10/20/2021 3:38 AM, Max Gurtovoy wrote:
> This structure is duplicated for RDMA/TCP fabric controllers. Move it to
> common code.
> 
> FC controllers might use this attribute in the future instead of a local
> ioerr_work attribute.
> 
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>   drivers/nvme/host/nvme.h |  1 +
>   drivers/nvme/host/rdma.c |  9 ++++-----
>   drivers/nvme/host/tcp.c  | 12 +++++-------
>   3 files changed, 10 insertions(+), 12 deletions(-)
> 

This looks fine for commonizing rdma and tcp.

However, when I look at the calling sequences, such as 
rdma_error_recovery_work(), I do think rdma/tcp should look a lot like 
fc with it resulting in a call to nvme_reset_ctrl as that's what it 
really is. Gets rid of yet-another-independent-copy of stopping keep 
alive, queue teardown, queue state change, etc.  Just use the reset routine.

-- james



