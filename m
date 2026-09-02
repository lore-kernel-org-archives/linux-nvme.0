Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FAFFC61DFD
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2026 04:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1/WJv6ORXpJMYtngGoOZ+CIauw4y5AKxPgY6cDe49jc=; b=2bkF2eg86CX50ws7mmqGgO2qaD
	aHHPLhJ+WEjusi54UcwsAHD9n+ViBdVgYFblfnOwDnOI0j6QN6+164BKeYiZBdgEkLDrTr4d70s10
	tRrXmDW/mPHGlaOU87eFEzB8l3Mchu1lFeF3uPrA5iaeHYzJivw1mZ/RhnSAJe1/kshtbutxtj7w/
	JasaDZD/ovymnckPoRqXwodAPWh7e8ffx2JvUEHaNy8mJrJZ0+ng6KFa+MnX+F1Ze0ehbmz19KRly
	jGt4aPdft7tC+SxDqTzA6AjSaFgc5JeoS+H8eaeSTTrD0kJO05cN8jdnCme3aOp4Tw+Zr090uNwQL
	WDEoy/Zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1cyf-0000000DmiJ-27rV;
	Wed, 02 Sep 2026 04:53:37 +0000
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1cyb-0000000Dmhe-37jN
	for linux-nvme@lists.infradead.org;
	Wed, 02 Sep 2026 04:53:37 +0000
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-3969e82ff8fso748219a91.0
        for <linux-nvme@lists.infradead.org>; Tue, 01 Sep 2026 21:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1788324812; x=1788929612; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1/WJv6ORXpJMYtngGoOZ+CIauw4y5AKxPgY6cDe49jc=;
        b=PzGEjNpuTIqdefBy+5s7DJbvxRxt78BY5s1t92qW87tvvTtE+frfTCVR0iKiCI4Je9
         ODnuFQhNhC+xWjMXF8VcCMtGokcZwEhtcIUfS2XaEXkzM87DUun3B58G9sE5cFA/SpIg
         iR/JBJwNxBT2O8Ksc05xf1MJJ97oYEEnAL/m5V4XEZiaZnJnaPV97iX/L1S1tIdn5DCn
         UgqB0yF93zl6mJr7hkm2NNIh5cSWZqp//ZYCxow93PmJmwaAs5qtWF0ZTbdc4vFScIQs
         3G5MlbzCh9X0xSDSLfqGeZZySjl7/mEr3+aCbLKY0Y9JmhYICWvpYwoA31gmBXrt21xr
         GfQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788324812; x=1788929612;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1/WJv6ORXpJMYtngGoOZ+CIauw4y5AKxPgY6cDe49jc=;
        b=fD57d8y6zAAZsqpLChJ4xpZDnD2a3MfCQQGS9rSSxFeiBRBmbmXB/r0ygJ5OOlZ7M/
         l8VxLHuvyXHtD19wdxt3vEGsn80k5pK+/B2fNXwZGhERmpCl5uCVtxcVzRMqoOs7RWn4
         /69JHigHmVlPccxz8t9I7G3EYirHkiMN5++QB0mFYxQp89n7xVZDEsT/B2WHjIQcJMz+
         dagnqDdWT93ubEK2/d9TI3syW2bjtmM1/O5N96sfRInIXtFIcse0OGkQwRQSYpSMcgdS
         l4yPswg8u6MSzBx+CdTE+cEISIXmk07fsD1yMYbMSWlOcez7VLD+P8zxETEqgmlhRZ+V
         IElQ==
X-Forwarded-Encrypted: i=1; AKwUvByNgFN2QCowson8DNpSXNN0MnQVz98H9cX6GpKruS1qi4GEDz9VxSHSnM6hQgF3D1jQV+/9qChEg35R@lists.infradead.org
X-Gm-Message-State: AFuF++kQDUZtozg22ILMZNudNE8oGtr4KeckoSNX2hdzkBpnL1mFOvQP
	ryC/9/DumZ6Rap29id+NpDoNTj8QfBgOEPZuirqTGpEbZCFI7iNWO0+ZQUaleThTJggC1jU/z0z
	O+3TRAOk=
X-Gm-Gg: AYBFou2S+9b5Dn113M542b8uYru3rziR3xTHFUwwDb2rW5MrXQIjYg3vlMl0lG4W9II
	lewd88VcLs6H+ahiHVKysjgh+qWV9iGgqBFbCDJ74U/hsb957uOSVNak+I4zJhE1kskdkdpeabn
	9QvHdJDRSAlarnTIECRFz5GTcSyxm9bszsc0u44911JwjghwmeFzVvLt8zqf6hPS3MxW/hDTwWX
	Tcht9eHZJuRyRvfLFA3B1N6bOXH3uMseIgeOSrMh2EnTaP6pvoyNYI6DgHJzHweIX5lp4SxNNx0
	NIXvvEv/oc6HhmL+xVftsxWIO66MyufgNqo7dlrk3wEm6yjETzlJNPltInSnXp1CxRjpHU704co
	P9kbatawmZ8weLjZCtHjztYnt+ElEG1OrZSPa/Uz3nEfyFsF9c1tlqyOecM99ScQCzTBAjbasmy
	rve036SyyMHaeSq7veJmWJ6aQxRY6g/1JhG/KosN+apUvy38NCinlJRHvbLJ4OynnuxbkzE6efq
	wq1/xA7GBEVftJJiclouZHLN4pZjP0ytNN1f7JnzPL/iGQ=
X-Received: by 2002:a17:90b:548c:b0:395:4de0:b78f with SMTP id 98e67ed59e1d1-39aede9368amr3441324a91.1.1788324812196;
        Tue, 01 Sep 2026 21:53:32 -0700 (PDT)
Received: from [172.20.4.188] ([192.77.111.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f07ba5a51sm2793041eec.21.2026.09.01.21.53.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 21:53:31 -0700 (PDT)
Message-ID: <a76b8cd5-8042-46ed-a9cd-620a0c4f56f3@kernel.dk>
Date: Tue, 1 Sep 2026 22:53:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: update nvme entry
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>
References: <20260901164935.2464374-1-kbusch@meta.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260901164935.2464374-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260901_215334_041805_A1025A3E 
X-CRM114-Status: UNSURE (   8.42  )
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

On 9/1/26 10:49 AM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Update Jens' entry to match the mail address of his other entries.

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


