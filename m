Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 166B0C6FA82
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 18:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GKDnwlvt98AzYvx8t1Z5mBjBPM9OSikHPq+0SvL9Y6w=; b=AoQH5vUP9EMFyOB2EqMNEGD3qP
	dMyuqMMKTOwlbkz565MZbdsFNqATKKp3GCnOMgsp1HcPV3krEY95jYzG53YxlKPXJgNDdL+tlgF/i
	qwh77l/MjILGh7Y8W+7ZQon1sWPf/9Kio4Yom48f9+X0q5ULBiEvojRfzDWbOItrXikDVka4FBpbB
	pm68MCUph9jB9qtKfWON5FwzeReuqH8fJ4CZtzKahe/0u75PwxcxjrxS77dcGU2hSHxyaxi7TGSyD
	xmUndIyjAgPCR2n3usBLAo4c+hY37PhwsU/salME2+rcjU31ReS2JuFEabBvprvZ0JfwEwl9VR19B
	WIDxyLKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odbWP-00HWXS-0B; Wed, 28 Sep 2022 18:11:01 +0000
Received: from mail-pj1-f45.google.com ([209.85.216.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odbWN-00HWWP-9w
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 18:11:00 +0000
Received: by mail-pj1-f45.google.com with SMTP id e11-20020a17090a77cb00b00205edbfd646so3394502pjs.1
        for <linux-nvme@lists.infradead.org>; Wed, 28 Sep 2022 11:10:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=GKDnwlvt98AzYvx8t1Z5mBjBPM9OSikHPq+0SvL9Y6w=;
        b=ZSH8uG/g2SK2iA9UgRXpq5s/oHxzSx/cswYn411UEKgnKc3wy6xF7QdKl6mkQu1VES
         VyC3m8H5Leaaw1DxDOBMmBSMrwSyrPCGoSRPhkQBNHGDmb7asoeBuR69Bn9tkKW2klSd
         n26Tok7511QwAmNTEE6dInu550oNq3TjAqVeuAqHOjv9KZRLjA+nFnubkKz62CAJ6Uza
         vHc5DXKe2bvj+Ymkm1v7s5A1CGX7PpSFqMkuf/wgw7HxBOV2k002RLIrbKU7t7i96ASK
         KP+M3qnk2xzFXw0G//KUxj4ifeVhqJ1z3V4fLCAQ42iR1ngOa35Y9Oqq2neT6XnE5pD3
         3Aww==
X-Gm-Message-State: ACrzQf19VDeHQzIU3038HjU3FmkjjobRAwJaECOVYvIxUG+SNcfSYf4d
	ilRwhlxqJllA/T4Y74VGPoI=
X-Google-Smtp-Source: AMsMyM6IxpfaBJs42tePmX0Cj6OVnmn2lb9A/fUs5CG7m7PAuLn3yEE2tGgbRAOQDk0DKNCAQZzakQ==
X-Received: by 2002:a17:902:ea12:b0:178:8e76:c781 with SMTP id s18-20020a170902ea1200b001788e76c781mr1044864plg.136.1664388656275;
        Wed, 28 Sep 2022 11:10:56 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:4cba:f1a9:6ef8:3759? ([2620:15c:211:201:4cba:f1a9:6ef8:3759])
        by smtp.gmail.com with ESMTPSA id i132-20020a62878a000000b0053651308a1csm4352316pfe.195.2022.09.28.11.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 11:10:55 -0700 (PDT)
Message-ID: <26566e80-bf67-8c9f-9aac-b636cfaf473c@acm.org>
Date: Wed, 28 Sep 2022 11:10:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v15 07/13] zonefs: allow non power of 2 zoned devices
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, snitzer@kernel.org,
 axboe@kernel.dk, agk@redhat.com, hch@lst.de, damien.lemoal@opensource.wdc.com
Cc: jaegeuk@kernel.org, gost.dev@samsung.com, linux-kernel@vger.kernel.org,
 hare@suse.de, matias.bjorling@wdc.com, Johannes.Thumshirn@wdc.com,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 pankydev8@gmail.com, dm-devel@redhat.com,
 Luis Chamberlain <mcgrof@kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>
References: <20220923173618.6899-1-p.raghav@samsung.com>
 <CGME20220923173627eucas1p2f134d9cb331e4a8f0fca8431eeb0f0b0@eucas1p2.samsung.com>
 <20220923173618.6899-8-p.raghav@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220923173618.6899-8-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_111059_376475_93811B8D 
X-CRM114-Status: UNSURE (   9.06  )
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

On 9/23/22 10:36, Pankaj Raghav wrote:
> The zone size shift variable is useful only if the zone sizes are known
> to be power of 2. Remove that variable and use generic helpers from
> block layer to calculate zone index in zonefs.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>



