Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61001CA5FC7
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2026 15:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ruocdeJmKgpaQFus+PucSGDLt7ZSCHmy/3XR1sTVzPs=; b=KN5I+bRBA41/TlAS84k4TL/THY
	mY0rG5/r13sqISGENME9H5xzI1LxmQHM4Ma0kuNKyDPo/ypfu5bZ7Wdr5tUlsuos4iqdAci6V1fVd
	8GiWDuKmLoqVgaa3t7tCB5a7KfxuEloGSnJ7AzayWf4WJ7thVu+LwBUmGpTuiMhP7zX0UUdh0OzxM
	qa/527wOaIgDo4/dtkrDMSTgwvw8CROlhq8Jmcefs14ZqmKzKYjkPbbgvdoCyVQx7vPTse/zn++kl
	kqzoZjekYiMezJLNPjC01+cr5aCX3NJ/P9Bjs2pzmkZwZ/40IVLbdUq2FFzoednjF6dVaIHq/KrG5
	zFz5M6ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBvxG-00000006R9s-25Nl;
	Wed, 30 Sep 2026 15:10:46 +0000
Received: from mail-ed2-x0c.google.com ([2a00:1450:4864:33::c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBrG1-00000005gLC-0TFU
	for linux-nvme@lists.infradead.org;
	Wed, 30 Sep 2026 10:09:50 +0000
Received: by mail-ed2-x0c.google.com with SMTP id 4fb4d7f45d1cf-6acbdf627ccso1761746a12.2
        for <linux-nvme@lists.infradead.org>; Wed, 30 Sep 2026 03:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790762987; x=1791367787; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ruocdeJmKgpaQFus+PucSGDLt7ZSCHmy/3XR1sTVzPs=;
        b=qLsD0SHueMj4oB4x5R6DIZ4Qi8Ojy9sJa1ngZdIT7ZURlVeCMCjMDgyNF4/BJRY5TM
         toVs8XN+OVqX829ul5LplxS8g5zeqdlr+XAGkIIOMfOtMIUJvpXKOjOSPBvBK34q9NUM
         zgcRMva5LzKGUo7oL6IEifpdSj39fQcMBsStK4Qq05mISD7yBhq0Mmn8xOBTCWGQGEHT
         bIdJYwUtMD2WQ8Xi0MvycRWJDAoftDIt0KVrqmSC8IFhndba6JTFMY/3U/KKHoozuQJ4
         /D8wOu7KOtgjK88Vc3yPL0xS4tIGqCoC4LkB0L4viTRYeGZrjajS0cb3mh6G55eNu6kJ
         hA9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790762987; x=1791367787;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ruocdeJmKgpaQFus+PucSGDLt7ZSCHmy/3XR1sTVzPs=;
        b=iqENFlZsU0t0xPNTBxMZoLl3KO3sDSqxOffv8TwXxSPlUVZ7aEFb1wwIyxiJAmD2kf
         ppIz6qFXvtUe9xpolgFPSnY3/D4v0MrLPIv2TOPYkXPx5I9+YpKah57ZHGKpJjBq6SvW
         trNG5DBikQc9xrGgMDlPqGBb26h5oeiFInZTILhH6X8THnir5hvUCKdaJLivgoA8dZN/
         zS3hS6OGiItPSJa0/k+orbw+ojHkcO/CZzOGZaj4xNpptxi4LA9oFOEjOK79aZK2IqoU
         3Jvbmq5IGpRRaNC1jouD443aRplvKCSlFAY4qbrnjXF7+LA2qXoMiNpaTTzkcwv1YZup
         lENA==
X-Forwarded-Encrypted: i=1; AKwUvBy1xdI946XnD1XcNhi/CgU7TE2gX214aBCxrziy+JzGaDAQs00i9ZPAxPsgoJ8LXqvx5ZVSsM9mvaVU@lists.infradead.org
X-Gm-Message-State: AFq9FYKzz5fdttKmxZejKwlqxWSgUvHOPOf/elUBH7BZVJHYbjmkIyn2
	YTJMsB34Lif0rsoTogBLq1sX/bQ27Qhlo/1kDIFAB67+/Qpz7RUzJHSI
X-Gm-Gg: AYBFou34Jv0mjUZKcibz+dM6t/LP7MyO3FbDFRdw/Yi/IskuHZunLFdwQIFHm8pxUfn
	kKpIYntAhc4jbo248EQ3hxvs2QvhUA1wqE/vS7EVO9x3PjRO625EBOCLkCvLrR/to2odlyxncDG
	Ojl1/QMienwXe+fwsNOTEPyAGlGShURpIL9jmiaAimgXAXzJpS+YMO2/yyzgaehpoRlmQ4M0tvb
	xEJAXfGrdRP+0lnwUhPmyHlaAUpJE9yRut4GYoxnuzAmlLpt6YThigQl8bWzE/uzUoCThXrAPRO
	MpkBWc3ybbQgHAeJCZMlq39oC1Xwm3lMhhTgiXlXEIRxGO6YZkcAanCyONYrfOuBu0pp7lhAbTe
	W718pwyZ/jrrhcxtLz142BH1m45JQfa0jh+GkmKNIExok88SigapJxdzvZdL4A/3AnHvL48hga8
	NyZutFal41KfQ+b1QajC9vJ2Qg9BG2JITNYsV7Luxjx5fpf47vRguATfdX0vB4vlmkKeRx4ws3f
	hOGblmqki7lVZNq9Zh+b+A+GW7sonTuoPLEXRCvsSBmuiOu5t9xNOa77wbJuw4ea+fFzyLRAExV
	W3km2YD2mHv5dCCOeOHCmRnV8gcP1LxZA+jytr2zZ0dD2Es1
X-Received: by 2002:a05:6402:27d0:b0:6aa:ec02:7de1 with SMTP id 4fb4d7f45d1cf-6ae199152a4mr634773a12.24.1790762987076;
        Wed, 30 Sep 2026 03:09:47 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ae15690dbbsm551642a12.22.2026.09.30.03.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 03:09:46 -0700 (PDT)
Message-ID: <77db5aa5-f160-48fb-ab59-a754b100bc34@gmail.com>
Date: Wed, 30 Sep 2026 11:09:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/13] nvme-pci: implement dma-buf backed requests
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: agk@redhat.com, akpm@linux-foundation.org, anuj20.g@samsung.com,
 axboe@kernel.dk, bmarzins@redhat.com, brauner@kernel.org,
 christian.koenig@amd.com, dm-devel@lists.linux.dev,
 dri-devel@lists.freedesktop.org, hch@lst.de, io-uring@vger.kernel.org,
 jack@suse.cz, joshi.k@samsung.com, kbusch@kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-nvme@lists.infradead.org,
 matthew.brost@intel.com, mpatocka@redhat.com, nj.shetty@samsung.com,
 phil.cayton@intel.com, sagi@grimberg.me, snitzer@kernel.org,
 sumit.semwal@linaro.org, tushar.gohad@intel.com, viro@zeniv.linux.org.uk,
 william.power@intel.com
References: <cover.1790602223.git.asml.silence@gmail.com>
 <e99dd5221c71cbf9aafb5737468d814cb83b9174.1790602223.git.asml.silence@gmail.com>
 <5a35ad21-c9d4-4dab-a4f0-97baee6e2301@wanadoo.fr>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <5a35ad21-c9d4-4dab-a4f0-97baee6e2301@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260930_030949_172312_DA3E8D93 
X-CRM114-Status: UNSURE (   9.02  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Wed, 30 Sep 2026 08:10:45 -0700
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

On 9/29/26 16:45, Christophe JAILLET wrote:
...>> +    for_each_sgtable_dma_sg(sgt, sg, tmp) {
>> +        dma_addr_t dma_addr = sg_dma_address(sg);
>> +        unsigned long sg_len = sg_dma_len(sg);
>> +
>> +        if ((sg_len % NVME_CTRL_PAGE_SIZE) ||
>> +            (dma_addr % NVME_CTRL_PAGE_SIZE)) {
>> +            ret = -EINVAL;
>> +            goto err;
>> +        }
>> +        while (sg_len) {
>> +            map->dma_list[i++] = dma_addr;
>> +            dma_addr += NVME_CTRL_PAGE_SIZE;
>> +            sg_len -= NVME_CTRL_PAGE_SIZE;
>> +        }
>> +    }
>> +
>> +    ret = dma_buf_io_init_map(ctx, &map->base, sgt);
>> +    if (ret)
>> +        goto err;
>> +    map->nr_entries = nr_entries;
>> +    map->sgt = sgt;
>> +    return &map->base;
>> +err:
>> +    if (sgt)
>> +        dma_buf_unmap_attachment(attach, sgt, ctx->dir);
>> +    kfree(map);
> 
> kvfree()?

Sashiko also flagged this one. I'm going to apply the nits from
both emails, thanks.

-- 
Pavel Begunkov


