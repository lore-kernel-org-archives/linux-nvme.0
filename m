Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F8ACD4F52
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2026 10:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hx27Zr2PfQkgYP6DocpvbcVC/5/Kjswu2b3jiJPzVQY=; b=f7vli1ztnmDhvJjfXk3xYx9ZhR
	Nu6fqJYHxoyAJm1729GJcF5jdJBb/WbcgJ9ed1gmmp4SNfv8DwZNdSzCj4div8LoR2Lb4ifsaOTZp
	X0fmrN1i+73QvaSAXYwxTIq5cPwCQS/2mE8DiaU45YxDlHV8Y7n8F1qgcyBOVoLFvAqL9kCQLNAV5
	sKTjl3k74dXgAlJEaVtArxz/Kt3RtwLPR1kwvR2/qstd5zGeCvVJJbI4pl18yo2EK6pYOMvczwJVT
	iz3w9gQT8jL1ZKJ4a4ON1Z1Fn3WUt+wBr1K1nQJppanG0UbFWmGCr5X9uVMN3iMEeMF/uJjG7RT87
	e2oKE1BA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOvFW-0000000FEw4-0wVe;
	Mon, 18 May 2026 10:31:02 +0000
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOvFT-0000000FEtc-14cM
	for linux-nvme@lists.infradead.org;
	Mon, 18 May 2026 10:31:00 +0000
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-67be871ed3fso4992135a12.1
        for <linux-nvme@lists.infradead.org>; Mon, 18 May 2026 03:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779100257; x=1779705057; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hx27Zr2PfQkgYP6DocpvbcVC/5/Kjswu2b3jiJPzVQY=;
        b=jiCzUXXmDGqNZHAhF4JY6KDtwHqfBPQirNqs/DFgHAex6Io4Y3izeVYOtg57491j8Z
         L4Ksz1mmR1U/letBJwf2mBUpC2cy1f0gHxJqDyJMLpD4Vy/zd+1yojTAZkZ558Yv3ZKf
         P0qgN4kwRj3qJpefCSYgqsvAuM5ShQ5i70625Sdw1km4ormjSmGykCjyOUmMkr5WLXLy
         VB6lFxeo95pInDPubkkUyLTfCSyVwsLuj06kazmTS0/8CU28IxaWLMqz/hYeS4jCIQhv
         mg8i2ihS6lvRpDFjxz0gswlnAcrlKBiaol3rIGVy/6QGcJK7EdGZnHemeJBmuUGDOF8l
         +yzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779100257; x=1779705057;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hx27Zr2PfQkgYP6DocpvbcVC/5/Kjswu2b3jiJPzVQY=;
        b=FTdjXAv5VOxYOQ2rMGrJl+FrnMsoDp7eD3NtoYfKvP6/HmQcKJA5pcli/S8kzfSKwm
         2FN8ynGl/nEJMKkoMXIu7rzQ1IJkQg4Q1dmdeAcRlpEhwfICpaIgZBljL1iQvHY9wsEJ
         GtaQmyoN3DJLrMfidSs0+GgMM3rssG29tSANeVb0jnq/FTo+tVdk200Q+mMhtQxyn2Cu
         CKVNWGBbMKtFBkhJYEnICzfAsCI655kNmFKbFe6TGe0Ok2omfDwDx/mkt04acVkwp/WT
         DIQnsLQsMKO9TQdQLY/7TrmSeU8vc7NX8T8y+T91/SvoFKHmBCYycscMOhqy2uwClQk7
         Qqdw==
X-Forwarded-Encrypted: i=1; AFNElJ9QeEBN5cmX8M+fINNOeUbNlMfYnl9lrtY+tk+GpgqaSPmw/1I8qPFIud46ZUezAr+DXNzU/Y5Pvmcr@lists.infradead.org
X-Gm-Message-State: AOJu0YyNgVkvQWvaOi7dmJdHYaWK4FeogXuQPkQaRxu0Df7wF2gAjiY/
	QVBTZeqEwSYspP/YQVXXJBlwbnsfepboxLfQ0RyHmaaox2JnpFSAseIj
X-Gm-Gg: Acq92OFUmehrmjrE3NA4Tg92qBFaBJvTowbTU6gD2/SZOQ/FsFAKADeH3v1Jo/qVS+9
	1m4RFq7HHPGx7wvnR0ar1bOqfmggY000apLWaucByUrucEEcxXUvI9nq9FaZAVMH3gY++AA4BpV
	4KDUG6uDR/LwiRPX9xeRnBci5N7msToj4jSr+Q9UZb0Q2JNiNv+PBaegjUPIKNNxUV92vgtXEWY
	8hntypUNmTUSt4iryLqarxQLStXN4pYBSWMPwEFipjcxwL27KPImZ3wjItNNqznd8A/Roh9z4Lk
	kleLLBPeqqez1f0FTLg/MGPmi95kbNPBNCL5aRCTq8ZXTbvmGpC9pFDZODeTwBYbhx/oxGSxj+8
	fzw+c6l3sHyVa+vhvCXCv0qtRz60BKXWoCZtFQUATjpywSvVbc2FygveXL99g5f+IM8UikP2Fw+
	psMET9ff2JMJQdjtKvaSg3QLMIXfiCwc0yZ07fYJVXNk1/uGruuQREPxC9Uxtv3IisNDXcs9xsC
	kXK1tO121mVBs4oBk6Zy/3wUS6KZPlZ/Mr9VQ/b7irYsCqs5J3TvPwvcE8=
X-Received: by 2002:a17:907:1c0d:b0:bd2:bd3:1ef8 with SMTP id a640c23a62f3a-bd517a99797mr714341866b.35.1779100257041;
        Mon, 18 May 2026 03:30:57 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:ec20])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4e4d54dsm542055466b.47.2026.05.18.03.30.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 03:30:56 -0700 (PDT)
Message-ID: <574f42cf-0d72-437a-8eba-fd970011e206@gmail.com>
Date: Mon, 18 May 2026 11:30:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] nvme-pci: implement dma_token backed requests
To: Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>,
 Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
 <5cecb1157ab784f9f303a91449fdf11b03aa6002.1777475843.git.asml.silence@gmail.com>
 <20260513083817.GC6461@lst.de>
 <CGME20260518092930epcas5p30d3b49f26efa5969ddcdb15351a886f3@epcas5p3.samsung.com>
 <50ed7240-d8d3-4816-bcc9-ce8adbbbf841@gmail.com>
 <f9e04625-50c6-4fa9-8b12-76496e29f10c@samsung.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <f9e04625-50c6-4fa9-8b12-76496e29f10c@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260518_033059_351407_DA14C879 
X-CRM114-Status: GOOD (  12.36  )
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

On 5/18/26 11:18, Anuj Gupta/Anuj Gupta wrote:
> On 5/18/2026 2:59 PM, Pavel Begunkov wrote:
>>> FYI, I really want SGL support before this get merged, but ignoring that
>>> for now:
>>
>> I was hoping to let Samsung guys to send a follow up they already have,
>> but I'll ask them to have about taking it into this patch set.
> 
> I had done patches on top of v3 adding SGL support and PRP list reuse
> optimization for the dmabuf path.
> Branch: https://github.com/SamsungDS/linux/commits/rw-dmabuf-v3-nvme-opt/
> 
> Also pasting the SGL patch here for quick reference:

Thanks Anuj!

-- 
Pavel Begunkov


