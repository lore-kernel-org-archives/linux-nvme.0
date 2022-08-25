Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C70ECAAA2
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Aug 2022 22:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xfbE5Vo/QzRDekgWPSBG92uSVviACIBSqkJfH4RN/VA=; b=nWW6X9CAGRWaAwTWQhxEQCEBCz
	r4S7YtLTQG8TiGdzTe+YVXqC5kOQf1/SCARjdfha+PnIADUNnhzprQwDHV6n3lFUAHuTm/sKIrRdw
	1heoqxOuPG0+1tpy/l1flZDbg3HixRwwkKMZ2O4BZLJBfiZ+FF78J37ARwLYPnzy1FlPgQdQu81jE
	vtlMF1BoSy/5N3o7KC8lHjM+hQtdgPkxoXf/0qw1kDqT3yG159DK2epD9fqZ+UpgK1qk+5TNM6JOU
	sHFcZ8p9eU2SpAnJRNC8VXnwikgWny46bH+poazux9Vq1tVQn65ukfljCSvV+sFwiEmn0E+jF8Yj8
	ikaSQzjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRKvk-003h5u-4Z; Thu, 25 Aug 2022 22:02:28 +0000
Received: from mail-pg1-f174.google.com ([209.85.215.174])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRKjT-003aI9-TA
	for linux-nvme@lists.infradead.org; Thu, 25 Aug 2022 21:49:49 +0000
Received: by mail-pg1-f174.google.com with SMTP id 12so19013254pga.1
        for <linux-nvme@lists.infradead.org>; Thu, 25 Aug 2022 14:49:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=xfbE5Vo/QzRDekgWPSBG92uSVviACIBSqkJfH4RN/VA=;
        b=6wP+9x/fD85065tF2yXekejZpvNLfktszfbFUSu3WZ5QFun7shtpz9gLisfj/m84RQ
         TPKrlylyiVEpIU2ZaCO0tNx+gYrZU/oIOf4ANNZKcbjiWAdBIUGnISk3hq+cRob5C90z
         HY2Vi4SLGwd7iaDaqgbCX2OtQLBsEdnrip1o8xQX6si/N1+W/lwiU0PLZx/MpWvA+Zwj
         voXxjTpM9mKAx/jMQBT4GiPPayR+y43STAPZMAHGL3pCrOZYLW0eegqoux57KRiqU1mn
         wSQrt2O/phQ7J/PJ+rQMYedoIs8DGjnTS7HMh/D4jT4i/7H4YTfhfWwcCldLvec4QAXp
         y6fw==
X-Gm-Message-State: ACgBeo3n3TUZAyX/thBLSm3dp0d2/k9aPbzZqdJi+ArgANcNoeaDeyAA
	SZPSlWvpHrwAQc3MbtGUPJE=
X-Google-Smtp-Source: AA6agR73sSARbZPf4AXnzwJxFf85IRxa5zkDqZRlix4b3E0h6AybGGg3LFAG7lL0NOTwlkG6OZE2SQ==
X-Received: by 2002:a05:6a00:1943:b0:536:2bef:2f93 with SMTP id s3-20020a056a00194300b005362bef2f93mr931782pfk.34.1661464186761;
        Thu, 25 Aug 2022 14:49:46 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:349c:3078:d005:5a7e? ([2620:15c:211:201:349c:3078:d005:5a7e])
        by smtp.gmail.com with ESMTPSA id ik19-20020a170902ab1300b0016d9a17c8e0sm52556plb.68.2022.08.25.14.49.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 14:49:46 -0700 (PDT)
Message-ID: <d4f7f08a-e55b-c1a3-52b3-210b9f5b0a43@acm.org>
Date: Thu, 25 Aug 2022 14:49:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v12 06/13] null_blk: allow zoned devices with non
 power-of-2 zone sizes
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, agk@redhat.com, snitzer@kernel.org,
 axboe@kernel.dk, damien.lemoal@opensource.wdc.com, hch@lst.de
Cc: pankydev8@gmail.com, Johannes.Thumshirn@wdc.com,
 linux-block@vger.kernel.org, dm-devel@redhat.com, hare@suse.de,
 jaegeuk@kernel.org, linux-kernel@vger.kernel.org, matias.bjorling@wdc.com,
 gost.dev@samsung.com, linux-nvme@lists.infradead.org,
 Luis Chamberlain <mcgrof@kernel.org>
References: <20220823121859.163903-1-p.raghav@samsung.com>
 <CGME20220823121907eucas1p27664a441113cb557af8fce3ef2800e34@eucas1p2.samsung.com>
 <20220823121859.163903-7-p.raghav@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220823121859.163903-7-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220825_144947_987246_A0412C8C 
X-CRM114-Status: GOOD (  10.04  )
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

On 8/23/22 05:18, Pankaj Raghav wrote:
> Convert the power-of-2(po2) based calculation with zone size to be generic
> in null_zone_no with optimization for po2 zone sizes.
> 
> The nr_zones calculation in null_init_zoned_dev has been replaced with a
> division without special handling for po2 zone sizes as this function is
> called only during the initialization and will not be invoked in the hot
> path.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

