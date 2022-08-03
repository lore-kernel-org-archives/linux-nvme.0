Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56ED2C19F2C
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Aug 2022 17:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PLueRrdRrDSAZCsSnEuO7ryjbF4cDa5AGSQHDpCb7Jo=; b=RlF4CZ7XQop7UqrL2IBk29GYy3
	40u1s8kHNQWZi4SDxZaFFG5Kw5BmBU9QxFrb4s2Ges4Una22bPW13rJbLuIgdz4LgJeEmNI5OvVz+
	pU5IseVsmolhgtSJaRNov0yRrIbsmxEkJcEXgOVmg0OssLzz+1fT6HBEzJ7asDfX4Nr0yFb61IjRU
	GZVgSrQbj6nlvBBhS+qtp3CsL95y1+pZEdr7Ns3j/GJAZxkf9bXzw3vDcZGDMcnWnQdFLTr4yFZ4Y
	pfVaIYOiYFwTnwXYgs0HzzzXM5cnaDIH0DJq52CCobKMKVJsk+DEkdcg3xB8OVKiLkunGhHfJyAVO
	ah9UOGKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJI70-007u5F-Mq; Wed, 03 Aug 2022 17:24:50 +0000
Received: from mail-pj1-f41.google.com ([209.85.216.41])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJI6x-007u0v-35
	for linux-nvme@lists.infradead.org; Wed, 03 Aug 2022 17:24:48 +0000
Received: by mail-pj1-f41.google.com with SMTP id ha11so17409301pjb.2
        for <linux-nvme@lists.infradead.org>; Wed, 03 Aug 2022 10:24:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=PLueRrdRrDSAZCsSnEuO7ryjbF4cDa5AGSQHDpCb7Jo=;
        b=xFYlREN++R5vAGPkp7BOjJkkzKQZU4wWWgJ4H2v91CxsN5DHTmVFmIKkzk3eSKh++1
         3/45fcnf2VpjZJx1te3b1icjiw6j5st3ECGeAsYCcaSeuDg8ekodCyo/wTw0fYkmMhlB
         UgQmKhhnKV/6lBM0HOssj+qbYBw4RWbkgX5UD+osACvtoB4ilxX7Tn2UjtEhGnmF4xW4
         gqtZeDHoqvm3YuTp2e4RC8Ku+FSqNnZg7Op+7RdxBlFfrTc83nWrkv45W0kJrfSKrGFE
         U/pey/YwEJOdhLSWgSnFMop+pwXQLGxehVMgz/JCxQ0At1OApctnQImsEl5nJg7/KN6D
         xXhg==
X-Gm-Message-State: ACgBeo2StM3mBVF6HUsSz9dvXojG+0BVDRrrwn4+9r2WmXiVrQUeuXDr
	rLJWT/kdkTgf2dj3ElDLC6E=
X-Google-Smtp-Source: AA6agR4+errzcNzMPWB0CtPUqoFfU+/HvKqxJd9O453x9LrGJfJ/jGLweL2ivP559rQbToAj4CcR+Q==
X-Received: by 2002:a17:90a:d58e:b0:1f4:f9a5:22a8 with SMTP id v14-20020a17090ad58e00b001f4f9a522a8mr5883087pju.58.1659547483870;
        Wed, 03 Aug 2022 10:24:43 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:db71:edb7:462a:44af? ([2620:15c:211:201:db71:edb7:462a:44af])
        by smtp.gmail.com with ESMTPSA id i18-20020a170902c95200b0016c2cdea409sm2217726pla.280.2022.08.03.10.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 10:24:43 -0700 (PDT)
Message-ID: <9de2428b-96b8-883c-bd96-01a7763758e8@acm.org>
Date: Wed, 3 Aug 2022 10:24:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [dm-devel] [PATCH v9 10/13] dm-table: allow zoned devices with
 non power-of-2 zone sizes
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, Johannes.Thumshirn@wdc.com,
 snitzer@kernel.org, axboe@kernel.dk, damien.lemoal@opensource.wdc.com,
 agk@redhat.com, hch@lst.de
Cc: pankydev8@gmail.com, gost.dev@samsung.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 dm-devel@redhat.com, jaegeuk@kernel.org, matias.bjorling@wdc.com
References: <20220803094801.177490-1-p.raghav@samsung.com>
 <CGME20220803094813eucas1p2eab78901e97417ad52be1f8023db3d82@eucas1p2.samsung.com>
 <20220803094801.177490-11-p.raghav@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220803094801.177490-11-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220803_102447_200188_BB3950AB 
X-CRM114-Status: UNSURE (   7.41  )
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

On 8/3/22 02:47, Pankaj Raghav wrote:
> Allow dm to support zoned devices with non power-of-2(po2) zone sizes as
> the block layer now supports it.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

