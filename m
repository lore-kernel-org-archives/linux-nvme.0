Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 878C9C61DE8
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Aug 2026 21:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=kSWeMEx4Ssj7+1LyHPH04jpD5l
	CkolwhVyVyrbyXvIgNPSFyO7oQ2Ix9gsTkr1HNkXgNOv3YudLg+rTSXWG9bfwL29ITDRueOrOxPlY
	bPMMECUwdLEW0F/kgvEZwHpaGdwi0M5hXmGPn+OdYcXB4D44kR1q/jBtAzt4bpoHaa5RTJJahOBWw
	MzP/FlHXUEEgJLpsxJta7K+4R17Tf0U41LKZy63d1+/f/KHvagJDRo01Nu7SAJddZqh+lroVVHMyK
	fei0/5ReOvlf6hvZxKGA9NmesmqHtKcu4X7Le7OQII1fj7mG+KBrDKUap/xhPD6cbAPlMK6KtS/BB
	E2T+RlAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0mvR-000000086wT-0v9e;
	Sun, 30 Aug 2026 21:18:49 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0mvP-000000086vs-0AHM
	for linux-nvme@lists.infradead.org;
	Sun, 30 Aug 2026 21:18:48 +0000
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49b8ce9b733so18756435e9.1
        for <linux-nvme@lists.infradead.org>; Sun, 30 Aug 2026 14:18:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788124725; x=1788729525;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=YQpcpxKd3CtVF+SibmfEeKwWWC6x/aZAY1gJXKgGRADo4t9uuvkk1jNSH0q6KzJ4QJ
         8SgEQZltZIiVTEn1X71YhX0962D+2sd5N4oMrLLAaymBzdd2mIMxgb2yrL3MfV6HLI70
         TN42Xex7YsW8DQrsrjyOC5jYF1BNbKBWOOZcdTeavXC6TmeOjbHcwzOx+YkPTVqlOYit
         bkB6vOaSZw+RjFZISxyPSdX8BEWDnJBEkzOE3t/SOTNxVEQ9a+/36HWljjGyb0Fm2/Wd
         oGKmO45ltQVORk25yhxySrPQ2NcMlMlwt0F2QknKZfoHVcuELEFKKJp0FN9ATSIVy6Le
         P8AQ==
X-Forwarded-Encrypted: i=1; AHgh+RpMPIxZ0giFAFo75v+ODIl88z8ndA3ChPO/rG3ZNLhP63ka0w+Cy2rkO2rBRbeiwc8YcTdsbQFxopL1@lists.infradead.org
X-Gm-Message-State: AFuF++kQkvdxARjH3LxzwgzeZKmSEb0oyUc+mrNyhnrGPY102jlWIA5R
	a64dBm1w/qXSvH3xEfumTD2tRIK7RBkPPYZqBMZFO6eFZ6WladPZWQBQ
X-Gm-Gg: AR+sD105mFf7ExtTYE0qWVh/LjPE+cmrD0k1wUQDJZXitLlx61QZu5h537G6k7lfMuv
	e1XAaQVFwhZL7wuZobWA5BYCCP6rdP2BEIib0hRcyXVBcbizCZk5pu4bmRFiXqmtCNnG9Kl3aEu
	QtCWSI+/HDAZ+bgy2l5bObBzur5hNWjScNtgOHAVJLo3HRrKhEfnaRndFdUcK2yCqveyVDA3PgV
	8rL77VjyFiOYmirHIg4aqr25NUcbD4VNZ4r7mAoTDMKTvFjwulfrRGvGdgNdkoGGGtKM5fGTPrk
	z44khXgSR+EzLb1+FT1HvvAdUPWy8x4in3VsrXAVtvMkDB/vHJJfKAYX4OCmUeHELe3jJN7NJOy
	2/tr9pA4BR4WmSbz3QOoukZoazT+9CQflsCmt8KFUIjDBvJiblzUgXlqTpf/cMkohyS9MyFycx6
	dHAVbD0G8gJwOA/XD4y+0IAIljfCPKc6ujcoFIAMV8JGA7T2kd23BO0+DQeIxasXm3IRMnaLspr
	giX6YHDpME3M7uIs9/kZw==
X-Received: by 2002:a05:600c:8b86:b0:493:f5bf:4dc6 with SMTP id 5b1f17b1804b1-49b91c2777emr377275115e9.7.1788124725300;
        Sun, 30 Aug 2026 14:18:45 -0700 (PDT)
Received: from [10.100.102.74] (89-138-77-243.bb.netvision.net.il. [89.138.77.243])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbab5a2csm16272423f8f.4.2026.08.30.14.18.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Aug 2026 14:18:44 -0700 (PDT)
Message-ID: <41345fe6-0891-4127-af2e-de3832496935@grimberg.me>
Date: Mon, 31 Aug 2026 00:18:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nvme-7.3 v2 3/4] nvme-fabrics: reuse string helper for
 subsystem NQN
To: raoxu <raoxu@uniontech.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <0D24A9A3F19DBCF9+20260827125710.1381672-1-raoxu@uniontech.com>
 <2480D624F1D8ABC8+20260827130353.1390863-1-raoxu@uniontech.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <2480D624F1D8ABC8+20260827130353.1390863-1-raoxu@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260830_141847_076740_D087E862 
X-CRM114-Status: UNSURE (   4.39  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

