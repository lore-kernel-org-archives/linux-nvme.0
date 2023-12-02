Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F67C4167B
	for <linux-nvme@archiver.kernel.org>; Sat,  2 Dec 2023 01:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+i59c5r8CvAOU1fRMlh/sDl0jjO0yhkohmNQVmJktOk=; b=h4bh41ihu3ZR9nGlh7y4ajfHmw
	QITWBT9VH6wOTBYYBX66/G3bO92HOsjcbcJb0ZjNHiIdXjz6ZqJ9Aiy+RFLlbYdfZh5d+c3R4J4eE
	Xvx/NilpJmCGtgOSCtejiPy77Rq/wGfnV94bYrkwtxLNqhk/dKyKPFoEpO95XaEGiufyhgj1aXwXa
	o3nK7gasBgDDkgDlvIvxrSvTdJTLCLc8XGFwhQRseetd7OcmDqXAcJ+xLYPGlJEPGa+aRatQfcsbF
	cDY9PW77aHKgbcYIf0FwlXbhr/hfdKrIcsNc/gbfCdgrxmP5eMyRvD8LKxUqf8Pe1c9VjTP5oxWaa
	/OZmthYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r9ErS-00Eyo7-2B;
	Sat, 02 Dec 2023 01:32:02 +0000
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r9ErO-00EynV-2l
	for linux-nvme@lists.infradead.org;
	Sat, 02 Dec 2023 01:32:01 +0000
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6cdd2aeaa24so547811b3a.1
        for <linux-nvme@lists.infradead.org>; Fri, 01 Dec 2023 17:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701480717; x=1702085517; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+i59c5r8CvAOU1fRMlh/sDl0jjO0yhkohmNQVmJktOk=;
        b=15N0U8TQhaTytNF4X8joPWXXqUILFQp/iEU6p0wFuusJtFp8pnI6P9sMZZWxtZdY1P
         GS5gwxftZPlk+x+PTOr00SfOG4lYs+yQfS24fjO7kzlr6Ffxw9mxDukWGUGudMcXq6iG
         wohVqUTxHErxQRKnLhC/36jXXdXCdrr/Zt+7utYFfcuIOX5uarYm11a+89Mt7kjIoWd6
         CwKy6PHjmsmHtBd+30XEZzPzORWfir46vY4UIvcalVLPrWMg+qL0YVGZtW6k5+AliBoM
         dm2kmA/MMd2ABoseV+cihjLrE4dpZqqP5UKJcOJDoJ+vghm0RL1M386vfK5dI/JGB2kQ
         Tp8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701480717; x=1702085517;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+i59c5r8CvAOU1fRMlh/sDl0jjO0yhkohmNQVmJktOk=;
        b=lCEAbhR1oJeuaOzO7vAbFoP4WBp6w4SBJEKaWd1riMLGY0dpEsTAq+eyTdWCk+GjY1
         H9V8r8hEtrBcfn/8JjjKqb7VBACqzK583kKyaUnzkEtGAH43fe8e/IHvUXjUHFAXkUaz
         GXDP9pkRQjcn064y2o6JyFrCqMpgeSEZZSJLvK9mQZ6r9dlYXag7ps3GtgtONk3IsGwA
         T1Y3/PaqNly7TcRqjibqzES9//J9zFaB7RQom62b3sOA8LrX65bfg98IaAkJjrnHu+G7
         JSa4EYpR7isvWgsbQkmHX4nP9hFbTkOrCvHoyMaJusJfn2P2v9sTq4BZ50SAq4WZbMt7
         VYeA==
X-Gm-Message-State: AOJu0YzpciY1LTyqd136djX1E5tPj93thDTtsb2PM3nId3tMg/mn8hcN
	icn7825KgUnhhaf978M7OzZbig==
X-Google-Smtp-Source: AGHT+IGRxMfE3pAUV7zySyktGbmVuI16+3DjOSiEOaMv/EKu5JQOTXoLip0S7qmFA14Ls5ggCZoE6Q==
X-Received: by 2002:a05:6a00:18a3:b0:6ce:5b6:4cf7 with SMTP id x35-20020a056a0018a300b006ce05b64cf7mr3548767pfh.0.1701480717186;
        Fri, 01 Dec 2023 17:31:57 -0800 (PST)
Received: from [10.0.0.185] (50-255-6-74-static.hfc.comcastbusiness.net. [50.255.6.74])
        by smtp.gmail.com with ESMTPSA id gx9-20020a056a001e0900b006cdc6b9f0ecsm3597657pfb.81.2023.12.01.17.31.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 17:31:56 -0800 (PST)
Message-ID: <ac5e99c6-7297-4c56-8f3c-98755c58092b@kernel.dk>
Date: Fri, 1 Dec 2023 18:31:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv5 0/4] block integrity: directly map user space addresses
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, Kanchan Joshi <joshi.k@samsung.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, io-uring@vger.kernel.org, hch@lst.de,
 martin.petersen@oracle.com, ming.lei@redhat.com
References: <CGME20231130215715epcas5p33208ca14e69a68402c04e5c743135e6c@epcas5p3.samsung.com>
 <20231130215309.2923568-1-kbusch@meta.com>
 <e3c2d527-3927-7efe-a61f-ff7e5af95d83@samsung.com>
 <ZWopLQWBIUGBad3z@kbusch-mbp> <ZWpjBCF4KueqKlPN@kbusch-mbp>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZWpjBCF4KueqKlPN@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231201_173159_208155_80789EB5 
X-CRM114-Status: GOOD (  18.12  )
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

On 12/1/23 3:49 PM, Keith Busch wrote:
> On Fri, Dec 01, 2023 at 11:42:53AM -0700, Keith Busch wrote:
>> On Fri, Dec 01, 2023 at 04:13:45PM +0530, Kanchan Joshi wrote:
>>> On 12/1/2023 3:23 AM, Keith Busch wrote:
>>>> From: Keith Busch<kbusch@kernel.org>
>>>
>>> This causes a regression (existed in previous version too).
>>> System freeze on issuing single read/write io that used to work fine 
>>> earlier:
>>> fio -iodepth=1 -rw=randread -ioengine=io_uring_cmd -cmd_type=nvme 
>>> -bs=4096 -numjobs=1 -size=4096 -filename=/dev/ng0n1 -md_per_io_size=8 
>>> -name=pt
>>>
>>> This is because we pin one bvec during submission, but unpin 4 on 
>>> completion. bio_integrity_unpin_bvec() uses bip->bip_max_vcnt, which is 
>>> set to 4 (equal to BIO_INLINE_VECS) in this case.
>>>
>>> To use bip_max_vcnt the way this series uses, we need below patch/fix:
>>
>> Thanks for the catch! Earlier versions of this series was capped by the
>> byte count rather than the max_vcnt value, so the inline condition
>> didn't matter before. I think your update looks good. I'll double check
>> what's going on with my custom tests to see why it didn't see this
>> problem.
> 
> Got it: I was using ioctl instead of iouring. ioctl doesn't set
> REQ_ALLOC_CACHE, so we don't get a bio_set in bio_integrity_alloc(), and
> that makes inline_vecs set similiar to what your diff does.
> 
> Jens already applied the latest series for the next merge. We can append
> this or fold atop, or back it out and we can rework it for another
> version. No rush; for your patch:

I folded this into the original to avoid the breakage, even if it wasn't
a huge concern for this particular issue. But it's close enough to
merging, figured we may as well do that rather than have a fixup patch.

Please check the end result, both for-next and for-6.8/block are updated
now.

-- 
Jens Axboe


