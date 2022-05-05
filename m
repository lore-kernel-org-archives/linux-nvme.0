Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E909C433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  5 May 2022 20:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EJXLCiD9UDZlUYXKklp0jgNiM5rwP1N2foOUIK+GKBY=; b=zMseIqZRHNoGIga7/wonUX9f4C
	MrxHK9KceDsehFXF6Sc3wfDwe9qdQxnkeJfBO/D20awuyAER+rTcZ+qvpTmk4xvgDeQE7I9OY09iD
	ajFUv2HFvfUWTnkZgSQTvlFJLuxD5FyPuE7l0PyXfFppd0AcBMdUH++7ghO+MtuXccDM4k8XKr068
	0t3PqojX10BA4dd8blWtgQIemtTomXcAE2UIUlKgc1XTDUqWn4KZ2rzA8MA/SKl6TRdzb3SKe3K/7
	2OEvTKNsK0dVa+RK5p0wX+tl7z5PSS1XRHnyD+p0BoQmoSo58qsmQY+AZ31h8ZZoNKw4E0PNzSSxJ
	eubUlo+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmiLF-000E18-Sr; Thu, 05 May 2022 20:44:53 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmiLD-000Dz2-K2
 for linux-nvme@lists.infradead.org; Thu, 05 May 2022 20:44:52 +0000
Received: by mail-pl1-x630.google.com with SMTP id i17so5470114pla.10
 for <linux-nvme@lists.infradead.org>; Thu, 05 May 2022 13:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=EJXLCiD9UDZlUYXKklp0jgNiM5rwP1N2foOUIK+GKBY=;
 b=7i/BmXtCmZ4oyXj60UgpglyLR8gU7E2SF8NgOJE4KvXOUgeuv6c4DY1BcwiW+rVfu0
 TUnwLJi7DGAAgAsiodnsjDtEUpvaW4uhXuyBAJPWmVSZYMI1dGUeihQCDLlTD/rxlxYy
 BfAB1QB7RV3EI1H8DSNmbL1kfH4NxBofrZgqdfl7ThZxmmRvUt7gy0CLNWhuQbQpT0ik
 cgaFoHhxFq7G80NaaidLdyCTvUN6fUmraGbGcnPGrd2FdtVlYJdBxvk8FNOHXIk5tj4o
 PxK1HQlIS8VivfIaLVGOJ+0y7B8j3oX/dCjq6hBZOHmF0CE1+nN+yr5ENYoBo29wVdYm
 8nDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=EJXLCiD9UDZlUYXKklp0jgNiM5rwP1N2foOUIK+GKBY=;
 b=ia2FV2XGhxdD4r1yjzf5zvHjVd8PtOTZ4TjN4ODzZQ81RW6HFmvB29HAnxt2f2Whe3
 7eeiFWoWZJAzThEpDaqFz+ZTmT6WIrj5UWCGXSroprooaXEzHZZOdoxp7gAZN93x6kXv
 BZVw3kMxWkj79Ddw2hTFoTtub7Oaqyzv/VoR8106o/3EPlN2RwZHuohKkrZOajo1TFzW
 gysG1P4l3Ch3jW3/kP3fbhfCz9aR6KAzjP6HfwJZP8LZcgaodCXgLa1bEBGLE/FaB9sU
 PGhcY6gMpNL2ZOUO3kIgjyCX9sHlYKiH/i8tJU8o7KHSUWSN2O9uAmQVbsu7lGQVDkYS
 2Cfg==
X-Gm-Message-State: AOAM530Eo+rftFmarPRPqqxBkDn4JHfOvy/jQ3IQYPTcV2vm2IgQza5n
 eSeXnO/EBAGhLR3BNoZJT+COQQ==
X-Google-Smtp-Source: ABdhPJyBxT9jGHq/XhhcjPyUc3/uizRAZtCuOS91jlBx4ShXxBud24XZyQhZ6ZTmhPEF1Ahsn7i2Fg==
X-Received: by 2002:a17:90a:4f0b:b0:1d9:acbd:1204 with SMTP id
 p11-20020a17090a4f0b00b001d9acbd1204mr8262151pjh.201.1651783482938; 
 Thu, 05 May 2022 13:44:42 -0700 (PDT)
Received: from [192.168.4.166] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
 by smtp.gmail.com with ESMTPSA id
 q21-20020a170902789500b0015e8d4eb1dcsm76060pll.38.2022.05.05.13.44.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 May 2022 13:44:42 -0700 (PDT)
Message-ID: <06a03ddf-215a-b558-4ff6-bae46c33d51d@kernel.dk>
Date: Thu, 5 May 2022 14:44:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 3/5] nvme: refactor nvme_submit_user_cmd()
Content-Language: en-US
To: "hch@lst.de" <hch@lst.de>
Cc: Clay Mayers <Clay.Mayers@kioxia.com>, Kanchan Joshi
 <joshi.k@samsung.com>, "io-uring@vger.kernel.org"
 <io-uring@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "asml.silence@gmail.com" <asml.silence@gmail.com>,
 "ming.lei@redhat.com" <ming.lei@redhat.com>,
 "mcgrof@kernel.org" <mcgrof@kernel.org>, "shr@fb.com" <shr@fb.com>,
 "joshiiitr@gmail.com" <joshiiitr@gmail.com>,
 "anuj20.g@samsung.com" <anuj20.g@samsung.com>,
 "gost.dev@samsung.com" <gost.dev@samsung.com>
References: <20220505060616.803816-1-joshi.k@samsung.com>
 <CGME20220505061148epcas5p188618b5b15a95cbe48c8c1559a18c994@epcas5p1.samsung.com>
 <20220505060616.803816-4-joshi.k@samsung.com>
 <80cde2cfd566454fa4b160492c7336c2@kioxia.com>
 <ce25812c-9cf4-efe5-ac9e-13afd5803e64@kernel.dk>
 <93e697b1-42c5-d2f4-8fb8-7b5d1892e871@kernel.dk>
 <0b16682a30434d9c820a888ae0dc9ac5@kioxia.com>
 <70c1a8d3-ed82-0a5b-907a-7d6bedd73ccc@kernel.dk>
 <20220505195039.GA7032@lst.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220505195039.GA7032@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220505_134451_685833_84DB9E36 
X-CRM114-Status: GOOD (  11.87  )
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

On 5/5/22 1:50 PM, hch@lst.de wrote:
> On Thu, May 05, 2022 at 01:31:28PM -0600, Jens Axboe wrote:
>>>> Jens Axboe
>>>
>>> This does work and got me past the null ptr segfault.
>>
>> OK good, thanks for testing. I did fold it in.
> 
> It might make sense to just kill nvme_meta_from_bio and pass the
> meta pointer directly with this version of the code.

Do you want to do an incremental for that? Looking at
nvme_execute_user_rq() and nvme_uring_task_cb() there's a fair bit of
duplication of the meta copy.

-- 
Jens Axboe


