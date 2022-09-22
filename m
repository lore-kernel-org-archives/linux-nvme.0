Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E168C54EE9
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 23:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W2+hY5lHfF8Yuo41plQsF/0eXxPmqJupnSDFH4YELL4=; b=TSZEB94btKi3gz9M3X25K2VzuN
	ezzWxGqBPf2LUUnN17j52FKtNQyYtVl4rv9J6DwEsL1qMhYZ6CpC0UiaubcKq/uggOICXyDDMcwl1
	XpFUZ1IBzVbqYFWq1k/7nhNW6oOt2TqrcbL5Q6RW6NIFSZZsoeAQIOoUPE04+TljjbemAISOYtfpB
	9M7XYIFoFycUsFEhkfqORyHY6n+ri8OQtfWw4Ah8G67D1Lq0p+3hM2Rhx+3MADKFLagXoHEKe8nIF
	hk00KzRAJPkZzO4I8spF4nvLALY/dWG9nUwUZtb6PfOhVjH1qARWI93kLDnmSExX6V5h0sL2hNJIw
	7JbZ/SSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obW3F-000enN-FZ; Thu, 22 Sep 2022 23:56:17 +0000
Received: from mail-pl1-f175.google.com ([209.85.214.175])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obW3C-000elz-6v
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 23:56:15 +0000
Received: by mail-pl1-f175.google.com with SMTP id v1so10265842plo.9
        for <linux-nvme@lists.infradead.org>; Thu, 22 Sep 2022 16:56:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=W2+hY5lHfF8Yuo41plQsF/0eXxPmqJupnSDFH4YELL4=;
        b=MMkX1wj/Z3sROIsTlGy5hNSbF6TTIA/pHYZSFaGV9Ws/WcI8n2lls7eT5bpIyYymh8
         QPVwo+dVxImBC3YY7bWgeJLgNchqvOvnB9/O0Yia/bk8X10YD9zlBrq6HQ4G6XNxYayN
         Twgb4mF7MbSTDARvlLNQtwUMLlWjaXK7k29R7KShq0iYI3gPUyiPgrLxhkgys1Ip/Oes
         4CxHpJi/QPfxswtqPUr9MjvHkwxGOt3SqchAK0UEQfAWCYn/x1hS98XkqIPKPRlE7Hpz
         MAIwtf/xqMePhKASJyj+nVqJWVkHheZm+P55Ar3FXl+bRp5+yeZMVVd/Yzs9KS0zTnGr
         dgHw==
X-Gm-Message-State: ACrzQf0ThXLfQig0qfBu6MgEK5W4ZUQoVO7e5cIMGC8Ew1Vg7LJcnWCi
	8Sj+cuKKrUnbu5XjKcMwq3o=
X-Google-Smtp-Source: AMsMyM7DnGl8Usys7cprZQSwOFa/NlnQp69DKqLnRIqNLOSTU/oMTFEKEH4OrfofFw1WRmQVRwtsKg==
X-Received: by 2002:a17:902:d58f:b0:179:b756:6f5e with SMTP id k15-20020a170902d58f00b00179b7566f5emr4818263plh.1.1663890971926;
        Thu, 22 Sep 2022 16:56:11 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id u10-20020a170903124a00b001782a0d3eeasm4698194plh.115.2022.09.22.16.56.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 16:56:10 -0700 (PDT)
Message-ID: <8fd1d8b1-9f43-eb03-4a7f-187723d1c483@acm.org>
Date: Thu, 22 Sep 2022 16:56:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: Please further explain Linux's "zoned storage" roadmap [was: Re:
 [PATCH v14 00/13] support zoned block devices with non-power-of-2 zone sizes]
Content-Language: en-US
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Mike Snitzer <snitzer@redhat.com>, Pankaj Raghav <p.raghav@samsung.com>
Cc: agk@redhat.com, snitzer@kernel.org, axboe@kernel.dk, hch@lst.de,
 pankydev8@gmail.com, gost.dev@samsung.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 dm-devel@redhat.com, Johannes.Thumshirn@wdc.com, jaegeuk@kernel.org,
 matias.bjorling@wdc.com
References: <CGME20220920091120eucas1p2c82c18f552d6298d24547cba2f70b7fc@eucas1p2.samsung.com>
 <20220920091119.115879-1-p.raghav@samsung.com> <YytJhEywBhqcr7MX@redhat.com>
 <7dd9dbc0-b08b-fa47-5452-d448d86ca56b@opensource.wdc.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <7dd9dbc0-b08b-fa47-5452-d448d86ca56b@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_165614_294551_F9B875A3 
X-CRM114-Status: UNSURE (   8.20  )
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

On 9/21/22 16:55, Damien Le Moal wrote:
> But again, that all depends on if Pankaj patch series is accepted, that
> is, on everybody accepting that we lift the power-of-2 zone size constraint.

The companies that are busy with implementing zoned storage for UFS 
devices are asking for kernel support for non-power-of-2 zone sizes.

Thanks,

Bart.

