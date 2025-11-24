Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD38CFA466
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Nov 2025 11:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FIrNcMo3OIORc59oYq11M7V6LWyQ4cuR88/fqcwGDYI=; b=S88aSdihfv7+CEIRANSCDb59Ei
	0XkxJgyHVbcYzcZYel+fAiz/bNpDmGNA+eCdC+dSEiSOauh1IWx0awfSg6yjeVEUtE0dIBDcwyxbR
	VATaTFuhq6zmDtLOvpa6Rk0XlkqUfyqGQpJKxUp0dJznD3wguhX07ihXgsPAUGEIKTBwy8hXUUc2H
	gl8pbVa0dUtg9mrkM0zBvjsj974lhRAWee0yQO/kcCJ67KYPZVm13aeOlLYtXl3jd+6Wk7jXcGT8c
	VK3iH4q5CqfhD3irvNxgZbPNe5FNU4HkLOlGpYDAe9H09TO7X15OeWKpLMsf10CaPB+7yr+xHyjB8
	13tNBeJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNUlo-0000000BYp7-2Ngy;
	Mon, 24 Nov 2025 11:30:12 +0000
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNUll-0000000BYoY-0e8c
	for linux-nvme@lists.infradead.org;
	Mon, 24 Nov 2025 11:30:10 +0000
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-47774d3536dso32166405e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 24 Nov 2025 03:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763983807; x=1764588607; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FIrNcMo3OIORc59oYq11M7V6LWyQ4cuR88/fqcwGDYI=;
        b=VT7ei1QqFIL9VjtYUdmeShUHfa+EFIcXza7QefJb+hHTU/MdnidQT1QZEPhED1UeDl
         NTVHKuxyGWH+E2Hsk8N70rSK15qfsjv7A0+wxGcyIVB5ywuYslQ/pgy8jWJQtQxtWO3p
         /WVOka6BmlucuwAc1a/sS42D75QnE0uL1TVf1zTseVYRx2GCx9tj2A+ESFRBu5lG2U03
         q8FcpIphI1ccuPFVKQiWQe+5sgqGzhrhQYDAY9xEYjH5p1yra9qvlmmAMuYQmkfFDcux
         MrwMnLpNtCBCL7gy+fsCZtgWK0bJgNkePfyvXdoyJvBDskpd/YVXQH+2tLSgZ/IL61Lo
         juEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763983807; x=1764588607;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FIrNcMo3OIORc59oYq11M7V6LWyQ4cuR88/fqcwGDYI=;
        b=HkNb1NQLrNXkd8nb05eQ066Hpjc83MJL3PIeh9xLQJshChzLZ487S3T089cE3dsezE
         GtvSprd7tLLMvPbojN73/vra+ENOq8i/le6+ShBQGtWscAAGkUnG/m5h5wJ7+yl9WNNU
         E3diID7P5MaDOgjqTaZcJwsbO3aKtCcFErEfSWk4GPH1A9ETf+UwdHFugIki54E4BwgC
         q34PYl4tJ/0eKQoZWNqIhO1GoJI8+DncvuZAYGBK74+pZ8OEkJ4Jt1ovdHs7esNFwhxj
         Zoe2jbPeXn+4u3YUEnFn4ZOUMRqfRfRz7hz8X1ScsCA25wAmqYEGAbaLHkSSMGrZGVly
         2XKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOjbymC8QwOsfJbTzOPKOKRm2KG2RR/4OckWRNDMCNaAptDEHAiHS/lKb1cc9zv2nro3w8x1TGzsB1@lists.infradead.org
X-Gm-Message-State: AOJu0YzROm1Cj1ZdTcDxK5hKwBFWjNpgW3BOsdKjdo5MAfI/bgTcW2PG
	WfdGz5fceEVxoMZG7BhMQE0N4D+sCESPnOFqyscHrIsc1ZyEDTf1nwM3
X-Gm-Gg: ASbGncvzgzSJXoDo9aBMYUVo9IVbdcrUCE0BDljFe9Z5sk7u65idfj9uYzuKwhld6dP
	PIBAH82XN2ikyD8RPir5IyeLfOFUqreB6mAmYknkAxdst1dczWSX//XLLLaZXLC8ACrbEubh/gG
	aFZsNw24LGlwRIunI4Llb9AzLVJZokEf1iZHkJ2M3yfRz5AlWIKM5xQrHVcNpTBrO88W1t/iFwW
	6h8XX0w5TTDOzDrks05m4PZkTU1+DfipyrBCrr1GW628FSmDlCCpymptHcNMB4AnRN4DCGesYIT
	3EqnlPLoCVg1LzGlkS+019bO0ggkybbQYC8cgSwjgPXXOhVEp8sXABI383FHS8mT1173ZfJzdSC
	XnOalOjUlMH1RsPWFgGTVdXBZYD1UssayWQmPP7qc1s2NqboeJnkJD2s7fwfDLfuFlAH+5qXXE/
	ouX+0aR7cToULQMFyZh0kHVIXS19oT/0oTB1zelgWU1nBsP21gM+tOmucW1HaQgp2nOKWEg04I
X-Google-Smtp-Source: AGHT+IH4rhfkRALzBtaC9gdxzf7gjncNKNUbJLJsQNk7iBQd1pjAZr0TQJP790c1nQt2gF0ktavqUA==
X-Received: by 2002:a05:600c:1d14:b0:477:9d88:2da6 with SMTP id 5b1f17b1804b1-477c026ed62mr113061345e9.0.1763983807185;
        Mon, 24 Nov 2025 03:30:07 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f2e432sm27351895f8f.9.2025.11.24.03.30.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 03:30:06 -0800 (PST)
Message-ID: <905ff009-0e02-4a5b-aa8d-236bfc1a404e@gmail.com>
Date: Mon, 24 Nov 2025 11:30:01 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 00/11] Add dmabuf read/write via io_uring
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org, io-uring@vger.kernel.org
Cc: Vishal Verma <vishal1.verma@intel.com>, tushar.gohad@intel.com,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
References: <cover.1763725387.git.asml.silence@gmail.com>
 <fd10fe48-f278-4ed0-b96b-c4f5a91b7f95@amd.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <fd10fe48-f278-4ed0-b96b-c4f5a91b7f95@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251124_033009_502752_709D6F41 
X-CRM114-Status: GOOD (  14.49  )
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

On 11/24/25 10:33, Christian König wrote:
> On 11/23/25 23:51, Pavel Begunkov wrote:
>> Picking up the work on supporting dmabuf in the read/write path.
> 
> IIRC that work was completely stopped because it violated core dma_fence and DMA-buf rules and after some private discussion was considered not doable in general.
> 
> Or am I mixing something up here?

The time gap is purely due to me being busy. I wasn't CC'ed to those private
discussions you mentioned, but the v1 feedback was to use dynamic attachments
and avoid passing dma address arrays directly.

https://lore.kernel.org/all/cover.1751035820.git.asml.silence@gmail.com/

I'm lost on what part is not doable. Can you elaborate on the core
dma-fence dma-buf rules?

> Since I don't see any dma_fence implementation at all that might actually be the case.

See Patch 5, struct blk_mq_dma_fence. It's used in the move_notify
callback and is signaled when all inflight IO using the current
mapping are complete. All new IO requests will try to recreate the
mapping, and hence potentially wait with dma_resv_wait_timeout().

> On the other hand we have direct I/O from DMA-buf working for quite a while, just not upstream and without io_uring support.

Have any reference?

-- 
Pavel Begunkov


