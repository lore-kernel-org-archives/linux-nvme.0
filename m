Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D804EB64D7
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jun 2023 10:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z2ziSSDnHmXzqyopdHEpI90tpZriUVyJ27mmVdNAibQ=; b=hwtuy+AcRbr24cWCPVw/uArQ5x
	1UhKBquexuX+7rkch3vCECVl9Z9qCIJ+avNu9MftQjGgLJlSwlZ5KJ0oB8GSm60OoXc37t9Y12Laz
	kR1MFH669cATjTpSDjPUekbWY0Bx6/VJTaF71ASGqtLKBKv42ifx1qO1D43Q1qYKosC2/cPbeTYia
	lxjg4khFJ47kkiav274XZ9pTNkiPRQo4KRLBnhjKZcNVu3wS+LcdI8ij0tG5/loGcAe3zc3bSIO8/
	sDBgQ2+89f9ba0NgFmQY6dBcpVUzPNKNsppJzxJltXmpTcdu/sQbKkrMy8KGS91FN1v/u1hDtuKTk
	IsyG3pxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBupy-00DzZ2-2D;
	Wed, 21 Jun 2023 10:13:18 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBupv-00DzXF-1R
	for linux-nvme@lists.infradead.org;
	Wed, 21 Jun 2023 10:13:16 +0000
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-3f90ab8e841so9039305e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 21 Jun 2023 03:13:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687342388; x=1689934388;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2ziSSDnHmXzqyopdHEpI90tpZriUVyJ27mmVdNAibQ=;
        b=TEr2CxezkTCXKS6Q/v2wJT8O9aP7Q5j8D+UrSwe9bTr4Sy2gGGq+qCiq6v5wSfwHqP
         49l2YA014yEshrNwWNTpBheuXfKcxyDxmBSUCstS7h0Eohvim9Gv/OQ008OhBMEJc5I6
         9mDxLauUzXeKNE90mPO4+vyIwt6pFDzgB3V7gfNri7n0BzQuOSFejyr48ZAuenZo3R2L
         s+kzCLdhti1nISxSYNHm+1gEx1pD0MZIRLhZYdq26CeE98xw2Afkx4gcRHC0LPgS6Jje
         7eG/3wlEtmVCQQg6EzkfzMKfO1o1CrDHOIYJ8dfM/5fPEgKIAQr8sxaCVcenAQVgWjMC
         KNLA==
X-Gm-Message-State: AC+VfDzV1YsMwwyw4YyMNN+pAOcIBs/J1ncM1iGavYk1gBcsqM/IqHzJ
	oWD9Q0V7v0xJY54kvwnii5k=
X-Google-Smtp-Source: ACHHUZ51waEdZ8FsyNEQCBlkHeu3MxzAXF5zJdLTOiH5Tcp/JKKq5/qraqY5qK1ij/xekpfSZqA4bg==
X-Received: by 2002:a1c:ed08:0:b0:3f7:369c:c640 with SMTP id l8-20020a1ced08000000b003f7369cc640mr14201347wmh.1.1687342387986;
        Wed, 21 Jun 2023 03:13:07 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id t20-20020a1c7714000000b003f900678815sm4517708wmi.39.2023.06.21.03.13.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 03:13:07 -0700 (PDT)
Message-ID: <caa80682-3c3e-f709-804a-6ee913e4524f@grimberg.me>
Date: Wed, 21 Jun 2023 13:13:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V2 0/4] nvme: fix two kinds of IO hang from removing NSs
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
 Chunguang Xu <brookxu.cn@gmail.com>
References: <20230620013349.906601-1-ming.lei@redhat.com>
 <86c10889-4d4a-1892-9779-a5f7b4e93392@grimberg.me>
 <ZJGoWGJ5/fKfIhx+@ovpn-8-23.pek2.redhat.com>
 <27ce75fc-f6c5-7bf3-8448-242ee3e65067@grimberg.me>
 <ZJI/1w8/9pLIyXZ2@ovpn-8-23.pek2.redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZJI/1w8/9pLIyXZ2@ovpn-8-23.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230621_031315_506368_65A13C63 
X-CRM114-Status: GOOD (  17.57  )
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


>>>>> Hello,
>>>>>
>>>>> The 1st three patch fixes io hang when controller removal interrupts error
>>>>> recovery, then queue is left as frozen.
>>>>>
>>>>> The 4th patch fixes io hang when controller is left as unquiesce.
>>>>
>>>> Ming, what happened to nvme-tcp/rdma move of freeze/unfreeze to the
>>>> connect patches?
>>>
>>> I'd suggest to handle all drivers(include nvme-pci) in same logic for avoiding
>>> extra maintain burden wrt. error handling, but looks Keith worries about the
>>> delay freezing may cause too many requests queued during error handling, and
>>> that might cause user report.
>>
>> For nvme-tcp/rdma your patch also addresses IO not failing over because
>> they block on queue enter. So I definitely want this for fabrics.
> 
> The patch in the following link should fix these issues too:
> 
> https://lore.kernel.org/linux-block/ZJGmW7lEaipT6saa@ovpn-8-23.pek2.redhat.com/T/#u
> 
> I guess you still want the paired freeze patch because it makes freeze &
> unfreeze more reliable in error handling. If yes, I can make one fabric
> only change for you.

Not sure exactly what reliability is referred here. I agree that there
is an issue with controller delete during error recovery. The patch
was a way to side-step it, great. But it addressed I/O blocked on enter
and not failing over.

So yes, for fabrics we should have it. I would argue that it would be
the right thing to do for pci as well. But I won't argue if Keith feels
otherwise.

