Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22124C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 17 May 2022 10:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RYdJ0CquWbNgjP3mPaFrI7sdsqbAp7pCPd/CZR+E39c=; b=efod+gYSgV26CFHUQJjmsCCXIU
	/fAB8MiqWB9sOP+gC7Oi54GFp6c8unJBRTndycB6uJ/r31xSZ8C7tDooDxvy6Vpps2PMloZPhsONK
	oj9G1IktoTKKBmnmHaqfDYGFIGW+N+sKQgcw2F+cSuhLfgylKfW29O0L831eL4Xz3X1ec63LKhzBH
	x38F1UZRMixcQdBtAC1mOecr2uCU97aNUDgmTDt0y7KmaVllFlx0fYr+siT5EsNM3/gkqwctlSGfs
	1FWmYiFqQxnwnspLk8G9iyuDLZcsf8L4nouRIQVZbke1MP4tlm/qQV4fyebRhMzFoVgnWxR1VU0FC
	a7CpJp0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nquAy-00Cxng-2g; Tue, 17 May 2022 10:11:36 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nquAu-00Cxlz-VX
 for linux-nvme@lists.infradead.org; Tue, 17 May 2022 10:11:34 +0000
Received: by mail-wr1-f51.google.com with SMTP id g17so5882068wrb.11
 for <linux-nvme@lists.infradead.org>; Tue, 17 May 2022 03:11:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=RYdJ0CquWbNgjP3mPaFrI7sdsqbAp7pCPd/CZR+E39c=;
 b=AVYgS8SqB6xsvjcIeUl+xgHqAUV2AUAKMCbwOfaaj1E+hhNB+edJFRc/CBHNR2Qi/e
 bEKeFxP3G8olrdczqF44mus4kFK7ZRO8thn72NtnuX4BNvY8d/rgt/gMVjtbFiC1JWbK
 z0ww8OgA8zCn8d4vru9fufOEGpJ4uPhdlD+RWTKlNGYyMKa4uCuvD8qdKZAiD30UgSXu
 dmoHTWM8eQHKSmRZOQoRWYa9Dj97SrY/2J/tNAvkV5m2pzq2Mrej0+01lTD+D0CSBjb0
 zE1oUbaeK/vclmYIqCgRJqW383nvDmZDfuVt80ZdEL9UFO6f75DMtQArYISlp/pSNgjY
 rw1g==
X-Gm-Message-State: AOAM532tFLmPrXuL9knxiTxH6whVcrjMxgoVqb7F+Ouqpz0aPE888leh
 aEZXNy2eAGO68/uurfpuLrg=
X-Google-Smtp-Source: ABdhPJwCpfWj90Ct12FqvlgMsrT97hTdfxy5G1GIH5rf3rw7cDB0SGozuI4y0KW4FvJmmTe1Yezz4g==
X-Received: by 2002:a5d:64c6:0:b0:20c:6ffb:9584 with SMTP id
 f6-20020a5d64c6000000b0020c6ffb9584mr17157469wri.156.1652782290645; 
 Tue, 17 May 2022 03:11:30 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 c12-20020adfc04c000000b0020c5253d8d8sm14222392wrf.36.2022.05.17.03.11.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 May 2022 03:11:30 -0700 (PDT)
Message-ID: <65ee2faf-b916-8905-cde5-c31b84b9350c@grimberg.me>
Date: Tue, 17 May 2022 13:11:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] nvme-rdma: Remove timeout for getting RDMA-CM established
 event
Content-Language: en-US
To: Israel Rukshin <israelr@nvidia.com>,
 Linux-nvme <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>
Cc: Nitzan Carmi <nitzanc@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
References: <1652627080-42045-1-git-send-email-israelr@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <1652627080-42045-1-git-send-email-israelr@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220517_031133_056564_B534CCD1 
X-CRM114-Status: GOOD (  12.76  )
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


> In case many controllers start error recovery at the same time (i.e.,
> when port is down and up), they may never succeed to reconnect again.
> This is because the target can't handle all the connect requests at
> three seconds (the arbitrary value set today). Even if some of the
> connections are established, when a single queue fails to connect,
> all the controller's queues are destroyed as well. So, on the
> following reconnection attempts the number of connect requests may
> remain the same. To fix this, remove the timeout and wait for RDMA-CM
> event to abort/complete the connect request. RDMA-CM sends unreachable
> event when a timeout of ~90 seconds is expired. This approach is used
> at other RDMA-CM users like SRP and iSER at blocking mode.

So with this connecting to an unreachable controller will take 90
seconds?

