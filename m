Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD77C4707B
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jan 2024 21:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k2HSg/AmhYZcGkcbY0eGgy1Bb+DyP7rKRWI4KTFYTp8=; b=NavUu3YociQOe4mbOlWbLGOozu
	10iNduY/WdlLdVC71/CzEIXhzF7V4kw9x0h0n/4SkrwX2osTzRCTjmu8c9hbRKk+pdXslPBOV4YTl
	Xxj+HgoJ3kluQ0U9cNk9/pKJPIC4AnineBSPr8mxVWvLTMNTMymehIUe/uTX6CkiNt+0uINiUwiKT
	AiPRfkaHSc2YJGlKSUlQRKU3CnPeM3/orFGB3cOZ53F0FksTqrVJtIOn/vIjMo2GRxzGa0rU+nijM
	acStpMe9GhoD835k2gLwO07RprsOIJEcnbmxjkRYwV8YZw7vdVWIO8xvVYWafDzsXbKIeJL8G5ukG
	ypdjHg5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNJhm-009YwF-0c;
	Tue, 09 Jan 2024 21:32:14 +0000
Received: from mail-pl1-f171.google.com ([209.85.214.171])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rNJha-009Ysk-0m
	for linux-nvme@lists.infradead.org;
	Tue, 09 Jan 2024 21:32:12 +0000
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d3aa0321b5so31363345ad.2
        for <linux-nvme@lists.infradead.org>; Tue, 09 Jan 2024 13:31:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704835913; x=1705440713;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k2HSg/AmhYZcGkcbY0eGgy1Bb+DyP7rKRWI4KTFYTp8=;
        b=QDfVejfbtxpYX//T8aGRPh4E4dAkEfDJimbZmkRrUHNkvlyyBREmYy9TL/bjTPV6Bs
         AyB8y/nrMW9lLlTTcu0FSOIUip9uBfFS/j8QusCDpof00Esr+N63OaRjdxOs6qBmy3Tl
         ZvK+byMCkH8I+c9MGLAj21yDixa3K7yqicjDgragT0fbV+jNFO5lOxF1PIMHsIPjdVNQ
         +JvppT1baSzVQJpq0y/YXUgg+EakpKq4UzoygFM15olYyB79YMZlXbP8ETLVggdpnjYq
         DHg8mzrfCZl14zw7H1ihBAbBVk7hBqjaqTYZ2Q6VvhmZGEqZAxYkm3TCkhGvE7i0EnYA
         6Grg==
X-Gm-Message-State: AOJu0YyzWVIdTpPJd6Ltfoi/br2/Y4lGAHlTnqjjyq2ufF95QMNwo7is
	9DsFYdZZ3lDm0hnvK1veIj4=
X-Google-Smtp-Source: AGHT+IGgEoQ64du2K0/Q9WBgQuZMDtB5igrtdQVepbGX4TmcvhjuKUR8/XlFeDlu1Dyk5zxvLefSFw==
X-Received: by 2002:a17:902:d50e:b0:1d3:ee1f:ce54 with SMTP id b14-20020a170902d50e00b001d3ee1fce54mr24664plg.89.1704835912946;
        Tue, 09 Jan 2024 13:31:52 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:b76f:b657:4602:d182? ([2620:0:1000:8411:b76f:b657:4602:d182])
        by smtp.gmail.com with ESMTPSA id e2-20020a170902b78200b001d491db286fsm2245078pls.282.2024.01.09.13.31.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 13:31:52 -0800 (PST)
Message-ID: <33213b76-07f2-4b75-9940-679ec8f06975@acm.org>
Date: Tue, 9 Jan 2024 13:31:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] : blktests: status,
 expansion plan for the storage stack test framework
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "linux-fsdevel@vger.kernel.org >> linux-fsdevel"
 <linux-fsdevel@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, "josef@toxicpanda.com"
 <josef@toxicpanda.com>, Amir Goldstein <amir73il@gmail.com>,
 =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
 Dan Williams <dan.j.williams@intel.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "jack@suse.com" <jack@suse.com>, Ming Lei <ming.lei@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, Theodore Ts'o <tytso@mit.edu>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,
 Daniel Wagner <dwagner@suse.de>
References: <e5d8cd68-b3f2-4d7b-b323-b13d18199256@nvidia.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <e5d8cd68-b3f2-4d7b-b323-b13d18199256@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240109_133211_165356_70003FBA 
X-CRM114-Status: UNSURE (   7.59  )
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

On 1/8/24 22:30, Chaitanya Kulkarni wrote:
> 5. Potentially adding VM support in the blktests.

What is "VM support"? I'm running blktests in a VM all the time since
this test suite was introduced.

Bart.

