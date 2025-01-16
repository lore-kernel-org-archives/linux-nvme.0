Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A739FC02180
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jan 2025 01:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JC8KkORsQDtDgc+mHnl8bvuj7uNlbUWC7UgEcu+R32o=; b=RE/qv5+llnieKmTkdiRB1N1Gih
	pREDYxpaWYiCU+3opOTARafdguFTSnzjdQhRe1i1Dm1/xpV4omTvn524ofRqcsSmnl5CxbdVY+YHz
	RB/oXXMumKCJL12W/XAXFNKwkd5oTCzjhFQIb+IYO44rZ1HkgV9sSsm2wrJ02x+UpuRNopdho5I8k
	6urBdzql9CM3ZHLNNp3JVO7iDXTW7eTj7mf4DWVt2xNebDIdb1863Z7dVggGEigjEByWtbp//2hxr
	zOMKglMPMjB8cgsKjDKLNubOF/G0QjZFqwXoHXwbvkIzAkeTEi+hhriY+eLCpt8BYzPszhVLmqMD2
	/uazgF4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYF8X-0000000DaMm-2x9r;
	Thu, 16 Jan 2025 01:57:33 +0000
Received: from mail-io1-xd29.google.com ([2607:f8b0:4864:20::d29])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYF7T-0000000DaEb-3Om3
	for linux-nvme@lists.infradead.org;
	Thu, 16 Jan 2025 01:56:29 +0000
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-844e7bc6d84so18178839f.0
        for <linux-nvme@lists.infradead.org>; Wed, 15 Jan 2025 17:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736992586; x=1737597386; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JC8KkORsQDtDgc+mHnl8bvuj7uNlbUWC7UgEcu+R32o=;
        b=JgSzwW7hCEERwOWnoKEr1LMruy/A9BMlQIdI+97q3tyopdq6uuorlf10Wg2lr3fuUr
         pQGbgydJcaw/IwevuOQ4EdqtXs/DrDS+Ee9q3YA0OyUPdoxou2kNw2TX0Hk0OxByNEKa
         wuRkRntlwG5hmJTPrAsbS/A3n+LJoWP9OrZLKLAIodeNfFg3maDB2nku+xYttgfXkaLA
         9SmADBtj5Y8qHvNIMKaz5IztOiWJIAvtQNZIXTfZIEIcySDBhA3JIjYDYC/a7ORq/5Tr
         uG5BsyIXXPUR8yApWGgrwmnOlM7rMSpUHmR/0DyMhCPhAkJmtIrRrZiRZ4AVyWxEMv92
         lZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736992586; x=1737597386;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JC8KkORsQDtDgc+mHnl8bvuj7uNlbUWC7UgEcu+R32o=;
        b=ws/SbauMF9FzR7PQ4yotqU9W+tYuLAEAUZCMhVlPisTNqBvkhI0EvrikAhqZ1hLb/b
         TEHB36diJ5giei4vFRJDDiJl0iB63HMRgcSWZXvEIUX008uPPJZisTnU+SmUZriGXG1Q
         evlE35vj/U7r+UsRetsHdRZZD9TgmvWMNpzHKSayReuhG4P+PiX065HSvRlX5hXW1YaH
         Ma2T8H6Ug7gNHwpgnR/FHHlIWO56G11w3ipDOCfljFXkh00leew+MezlVGSaLBohcvQ/
         vwYNsQkIlvkklxTOHCoX/Fgv4AaFU5PjfTC2YIPepZLBGAQ5FiKRpoc4nWFsf1/Mcif1
         NFVQ==
X-Gm-Message-State: AOJu0YziSpT0yTv1OMLWqbQsvcxHa/6H3i7RX2Ppy/DO3a8KQC42icGV
	uebuXmL3wq5o7I14iln76+GyjyqJclycNmGlWp1a9qSH/sMOWq+U4UOu3Ui6Osk=
X-Gm-Gg: ASbGncuOQaifqcUW7vhHvt49ilhmka3nG5MAlUWZUkvbqAKESEqUFaPV/DKlZ7bhknr
	611Dja1dPaFEMJK68prlvXzrvyRqpByc77XYb/eAPVSlSnADjy4Mv9NU42CB8hi6GKJLCw1oDmQ
	cW6RgTOhviAG1BY5aOhBOv/Amo4oOesYjPG8slCMILB5BU6iSJheViZ0jfGDeyKIH9o5Zmr0pAj
	is/5XaIfmpVg3sQ9B5NCXFKTkSgsmNC66PMkXrKGPLIm/NdcoUeuQ==
X-Google-Smtp-Source: AGHT+IGAxrpSXYyqc9nwgVMDzXrrBc1MJSJ9iJo65T8dG7V1ajQDQpgUNPkECP8zuGcTc6ZBT8L0Ag==
X-Received: by 2002:a05:6602:4250:b0:835:3dfc:5ba5 with SMTP id ca18e2360f4ac-84f6740cfaemr444039139f.5.1736992586581;
        Wed, 15 Jan 2025 17:56:26 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-84d61fa3cd5sm428974139f.40.2025.01.15.17.56.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 17:56:25 -0800 (PST)
Message-ID: <66ee503d-525d-430e-94b3-3588a94dc94b@kernel.dk>
Date: Wed, 15 Jan 2025 18:56:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] nvmet: fix compilation errors
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Keith Busch <kbusch@kernel.org>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "dlemoal@kernel.org" <dlemoal@kernel.org>,
 "bvanassche@acm.org" <bvanassche@acm.org>
References: <20250115221703.62861-1-kch@nvidia.com>
 <6ca7f59b-f232-4bf0-984e-a4439e22b9ba@kernel.dk>
 <Z4g3z8GWgoCQd8Kh@kbusch-mbp>
 <5d1afcbe-95d6-4599-b9e9-5c97915446fb@nvidia.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <5d1afcbe-95d6-4599-b9e9-5c97915446fb@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250115_175628_004457_90747AA8 
X-CRM114-Status: GOOD (  12.32  )
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

On 1/15/25 6:16 PM, Chaitanya Kulkarni wrote:
> On 1/15/25 14:33, Keith Busch wrote:
>> On Wed, Jan 15, 2025 at 03:22:05PM -0700, Jens Axboe wrote:
>>> What is this against? There's been no changes in the nvme tree since I
>>> pulled it, and it doesn't apply here at all to my for-6.14/block branch.
>> It looks like its against the merge result of the secure concatenation
>> series, which as you know has been withdrawn. So this patch isn't
>> necessary.
> 
> nvme tree branch nvme-6.14 with HEAD :-
> 
> commit 4a324970fabad503260973cd588609f3a26baab9 (tag: 
> nvme-6.14-2025-01-12, origin/nvme-6.14)
> Author: Francis Pravin <francis.p@samsung.com>
> Date:   Fri Jan 10 05:21:37 2025 +0530
> 
>      nvme-pci: use correct size to free the hmb buffer
> 
> is resulting in the compilation error, hence I send that patch.

I think your git trees are messed up, as a) the problem does not
exist in that sha, and b) your patch doesn't even apply to that sha.

-- 
Jens Axboe


