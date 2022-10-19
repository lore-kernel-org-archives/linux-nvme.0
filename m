Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D9DC433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Oct 2022 08:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=UA2Vi1p0lsv4nG1BecNvVrATWm
	KjvkQIDcqSQ3YMKWkocMIxvwaijW9qhyNDY28RQJbOtawP1NSiAap65VsbNTNgy6mcYwVCROrAg06
	JLW8Zm4eVpu698Pf+oFc+SpcwHVjcb4l98buWz/8jmY5bWvN6h7/mcbidIJiuPEC3HYjvTMcb/pj5
	p+XKjjwf1F+lFAfmt1/MlbxwR0tKAQohLAfZNzwdLWkCiKOqzmrVVWTEdxci4cLxsuhylhr2cJ51i
	kn/Kt+8ZpxUTKuZbA5/9ckbK26HQIUY7DPJMynVYv49NHRvP4+IWBq0TebUeNZt2h6AIjUsoL66DW
	3kMf70aw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol4Ic-00GU6d-41; Wed, 19 Oct 2022 08:19:38 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol4IZ-00GU3O-Cx
	for linux-nvme@lists.infradead.org; Wed, 19 Oct 2022 08:19:36 +0000
Received: by mail-wr1-f45.google.com with SMTP id j7so27825046wrr.3
        for <linux-nvme@lists.infradead.org>; Wed, 19 Oct 2022 01:19:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=MriVqSAXhVrYztSiLGjeIUE8IoBYMOH8/zGBv9wOZlBesFD7akLgIEHqZSuI8jYFni
         VqnuHL2UsvPYbAqBcihNzGiYDn+IYLyO9xYQTwH92Gh+1PI4cV6KUe1Fs+yfFs0ZTRY4
         Ll5xNWshYTcjcxT5UnSNBt5fHpET32it3F7HsOjyme7uEeOA023Qg26LddMSXkD5onlR
         kb97hoGn3AcgzBZMf3NLbomVO4K6LPbbvDJuKK0Kg1fWHLGiRDLLSQOVsRgOHukhkspV
         LycthQDmY/KfjmzLvnZluOTms1nXMv+mJCOtfFfu0aI2d1LwnbdSUYvkl/tZ+6+xVY4+
         Pt7A==
X-Gm-Message-State: ACrzQf2sB655lrQZsSQIjfvUmCVSmmlYtReszgwsGHhNdHReah+RRQnC
	UzA2YuYzjjs4IrKFO4IZllc=
X-Google-Smtp-Source: AMsMyM4lc4x/iFtG7fWlIVzB9oPWjbMGXLCGhbisxKo/bil/DlRMDg37IxS+5Kq2K+aKA3fI7lbTJQ==
X-Received: by 2002:a05:6000:15cf:b0:230:ba81:cefc with SMTP id y15-20020a05600015cf00b00230ba81cefcmr4214706wry.544.1666167573743;
        Wed, 19 Oct 2022 01:19:33 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id g5-20020a5d4885000000b0022e55f40bc7sm12916968wrq.82.2022.10.19.01.19.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 01:19:33 -0700 (PDT)
Message-ID: <635c9218-2ab6-5759-2657-5a1d3f50735e@grimberg.me>
Date: Wed, 19 Oct 2022 11:19:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 3/4] nvme-pci: remove an extra queue reference
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
 Keith Busch <kbusch@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org
References: <20221018135720.670094-1-hch@lst.de>
 <20221018135720.670094-4-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221018135720.670094-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221019_011935_445198_10C6D6B4 
X-CRM114-Status: UNSURE (   7.52  )
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

