Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5702DC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 12 May 2022 17:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5EH2eizEJHj786C4i7iVooWJ/uE/QSj7BBR5bCHBing=; b=TJcmk1uja5dngTSWSggA6PwDrg
	PsgR6nQKLzeqNuSM4bOerkjtuSPh7YPKR1uIN3FvpZ+GdseiHLNHlTKxHc+C542cVIAt1h6rp8+TO
	dyUnJq56F3VeB9Uavc0Oyh1gP5KH8wdz7/SK16gxkur8m+wZFeRwQVlHow0tlKmm3gzxwiAhRayu5
	mFnT4FTtJOJelc/LGDJlg/LOSlFnodTm0ztjT3txbb52ixI/0l7XJXfXQ16sFOAULT2LE7anM1+Nw
	Ehi+2Z46Ma+Kz5AgN5gOl4q9VFGYHCE+XJ+98M33/fEYK7Ak36ZOFr4VkASpnFcG836zESV1fgdHp
	qiRVTmOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1npCWF-00Cwo3-IZ; Thu, 12 May 2022 17:22:31 +0000
Received: from mail-pj1-f51.google.com ([209.85.216.51])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1npCWC-00Cwn8-Na
 for linux-nvme@lists.infradead.org; Thu, 12 May 2022 17:22:29 +0000
Received: by mail-pj1-f51.google.com with SMTP id
 a15-20020a17090ad80f00b001dc2e23ad84so8438363pjv.4
 for <linux-nvme@lists.infradead.org>; Thu, 12 May 2022 10:22:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=5EH2eizEJHj786C4i7iVooWJ/uE/QSj7BBR5bCHBing=;
 b=Dbu999USFpB/VRdS4SGkHyv3JxLglLzLSdrg2kqQpVbispJdMa1akrSZcbdgKOp1SJ
 sb138HNR2mBxIwkjPHK5D3xzcvW2zEjSQlo+yWTSq/lZYVfHS7oX5w3/6Yc9K2NUf1aO
 hrmn+AmS/mlvWg5gtnCy+9oIpZ83EERMgx8pkD5bhdHZ4EbPj51NptyHbQ40XVZT9Oxi
 SaH9f2EIJZ4h9OdN/pLNK7X+V9g3xNCr4YMYjcAGNjRy6SO5pDRjSqz9urKlEoHEtWOk
 bthMiMUwWYi0tkqlY5I14GOYPUn7dJUtxfi4SUHmu0c8QjgkCVciMLOt9zVFafKRpV1F
 S/Aw==
X-Gm-Message-State: AOAM531ZoDI5rBCPo4+/INweNd4P2+gyxDGqxMHImhrRH4iUwKiSxLzd
 i/Y9DI20c0acERyKiKeORH8=
X-Google-Smtp-Source: ABdhPJygkMTlAbNp9soO/418oUT6tIypetUTVmiczgfvtfjDYTiV1B21f/kf4VZ7nutFi/2LHDujOg==
X-Received: by 2002:a17:903:230e:b0:15e:ce57:d66f with SMTP id
 d14-20020a170903230e00b0015ece57d66fmr874623plh.35.1652376146314; 
 Thu, 12 May 2022 10:22:26 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:78c5:5d65:4254:a5e?
 ([2620:15c:211:201:78c5:5d65:4254:a5e])
 by smtp.gmail.com with ESMTPSA id
 d2-20020a170902cec200b0015e8d4eb2ddsm121808plg.295.2022.05.12.10.22.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 May 2022 10:22:25 -0700 (PDT)
Message-ID: <b14775a9-da39-f26a-fa46-b0b1b789c30e@acm.org>
Date: Thu, 12 May 2022 10:22:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 10/11] null_blk: allow non power of 2 zoned devices
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>, jaegeuk@kernel.org,
 hare@suse.de, dsterba@suse.com, axboe@kernel.dk, hch@lst.de,
 snitzer@kernel.org
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 linux-fsdevel@vger.kernel.org, matias.bjorling@wdc.com,
 Jens Axboe <axboe@fb.com>, gost.dev@samsung.com, jonathan.derrick@linux.dev,
 jiangbo.365@bytedance.com, linux-nvme@lists.infradead.org,
 dm-devel@redhat.com, Naohiro Aota <naohiro.aota@wdc.com>,
 linux-kernel@vger.kernel.org, Johannes Thumshirn <jth@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Alasdair Kergon <agk@redhat.com>,
 linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
 Keith Busch <kbusch@kernel.org>, linux-btrfs@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>
References: <20220506081105.29134-1-p.raghav@samsung.com>
 <CGME20220506081116eucas1p2cce67bbf30f4c9c4e6854965be41b098@eucas1p2.samsung.com>
 <20220506081105.29134-11-p.raghav@samsung.com>
 <39a80347-af70-8af0-024a-52f92e27a14a@opensource.wdc.com>
 <aef68bcf-4924-8004-3320-325e05ca9b20@samsung.com>
 <9eb00b42-ca5b-c94e-319d-a0e102b99f02@opensource.wdc.com>
 <9f1385a3-b471-fcd9-2c0c-61f544fbc855@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <9f1385a3-b471-fcd9-2c0c-61f544fbc855@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220512_102228_813185_9E4E4689 
X-CRM114-Status: GOOD (  10.91  )
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

On 5/9/22 04:56, Pankaj Raghav wrote:
> Even though I am not sure if this optimization will directly add value
> looking at my experiments with the current change, I can fold this in
> with a comment on top of zone_size_sect_shifts variable stating that
> size can be npo2 and this variable is only meaningful for the po2 size
> scenario.

Have these experiments perhaps been run on an x86_64 CPU? These CPUs 
only need a single instruction to calculate ilog2(). No equivalent of 
that instruction is available on ARM CPUs as far as I know. I think the 
optimization Damien proposed will help on ARM CPUs.

Thanks,

Bart.

