Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72EFCC27C79
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jun 2024 14:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TrxAc+Uu30dWHZppC8CN0wQM7I31e2d3aLis3drkvvE=; b=l82x+WptZyHCO59FDp3/U1yzPt
	bxVOzBGzbxN9l459JwFyLfUC2dxhjHRYEITN9xxyub4oc0PTwtWBdBKElr2RTrb1EaOwXNPVlTVYm
	hjEjJFpSbLonc/oh9osdbuocmeliFCp6hj573eQrsk3T2cQXw3SowMRhdcV1K53WtVc73vpcfuGDz
	7v8fzEeosMtQD30Dsf9l8O+CGebWa83oVrucIuISHVvb+Z2G9Ol/tb/W4vYatj8T4cMYfLNiaK9sJ
	tSVkKZ9G6v8jAzS0lwR0u3/dP3U4rBE5E097CgcfaE6samtt0rMehLiTlYGfd2C6Eb7Mrnxg5QdOQ
	UG6XVCQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJwEn-00000001Vda-0DLm;
	Wed, 19 Jun 2024 14:24:37 +0000
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJwBb-00000001Ud6-3arU
	for linux-nvme@lists.infradead.org;
	Wed, 19 Jun 2024 14:21:22 +0000
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-6e9a52a302dso332777a12.1
        for <linux-nvme@lists.infradead.org>; Wed, 19 Jun 2024 07:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718806878; x=1719411678; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TrxAc+Uu30dWHZppC8CN0wQM7I31e2d3aLis3drkvvE=;
        b=JzJtCHee6YdIbJ+2wcPj68QsfnIGKFTq8lqhFL0S9F4J+/OFSqH27knWM+ORJ0jr9S
         Dk9dO2OVoAT4sdjSFn+bOjGm1xsx9NM+DOa5M3+KsBxlf8VHl9xfuq3PVj7lvFvrd50O
         Gc8l9FTCNNJRgy8x48xxfaMxmuRRwqglh9RVoyfnInXGjTYCmqn8Rt5uQaT391DWFHx9
         A0ZiXLFjoDduA4BJ9AM1+CmlT1nOGSMO0nIYr+eDNcMM70QCI8QDdTTJZmGyj/0lUQX6
         TiKJdrmAI/6XYvrsQnkA8DfzRAgBcIWeBydTG/wka+WwddJMkEL0dZyVXLCzExpZF3Cc
         g1Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718806878; x=1719411678;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TrxAc+Uu30dWHZppC8CN0wQM7I31e2d3aLis3drkvvE=;
        b=UyEWBjnjvHRl6o1yICiuip5o05bVNTORCoLT7kjtzxeAmqGI52Xp23sDnTG9MlYKh/
         uL/uqhAPiujeNOaDaHG+3y75F0f3y3gSTMo2MWlYMtvZeZY0NJJ+A8equiiIIOQZB0uV
         DL7SvFSfTLk9CsWaZs6whjHJbA5aG98rYzCKsEdnrFq3SfYzFyHg4UgiQiLIk5tUhu/r
         UbI8x/NSYtc3UqQn6vVMxZlNu2Kp0QTxxNS2oC8j41+AQhinmVnd5cbLwAbeh2zmXMqc
         983n78Q0PXCV3v8ZwjffIMpcNOeKQuzwK2302HVvJ7geoFzJJyUp/xUnBexbkpDbGhGw
         Tbxw==
X-Forwarded-Encrypted: i=1; AJvYcCUgCM/UNEhDYlGnztZufzjgmc889XmvSz1uUa1zYg5tIbblHB1cD4O2UhpDn4OwJyr82aGOq/0TDSqzhxO0qtuNVUqaWi/sCIjeUGDAEzM=
X-Gm-Message-State: AOJu0Yw+a51xac5YeLr3M9Kx5yO70jxC3nLUi2QzACqICe0VeRk7JLCp
	9dynwaWl4jWvxkUJkgBvJdWP+nvt/AEhzXC1ARK5jh6tBGMc5UL1PHx34ht2ZNg=
X-Google-Smtp-Source: AGHT+IGlNYahWungPdY/VG0D2i+/kOzAqG/9vIEbq77BhnEO6pEhdeI5ihGxkaZBKQBmSE54SEc3pA==
X-Received: by 2002:a05:6a21:33a5:b0:1b8:622a:cf7c with SMTP id adf61e73a8af0-1bcbb727134mr2697727637.3.1718806878609;
        Wed, 19 Jun 2024 07:21:18 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb6b110sm10739431b3a.153.2024.06.19.07.21.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 07:21:17 -0700 (PDT)
Message-ID: <e8e718ca-7d3a-4bce-b88a-3bcbe1fa32b0@kernel.dk>
Date: Wed, 19 Jun 2024 08:21:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: move features flags into queue_limits v2
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Richard Weinberger <richard@nod.at>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
 Josef Bacik <josef@toxicpanda.com>, Ming Lei <ming.lei@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
 Yu Kuai <yukuai3@huawei.com>, Vineeth Vijayan <vneethv@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-m68k@lists.linux-m68k.org, linux-um@lists.infradead.org,
 drbd-dev@lists.linbit.com, nbd@other.debian.org,
 linuxppc-dev@lists.ozlabs.org, ceph-devel@vger.kernel.org,
 virtualization@lists.linux.dev, xen-devel@lists.xenproject.org,
 linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-mtd@lists.infradead.org, nvdimm@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
References: <20240617060532.127975-1-hch@lst.de>
 <171880672048.115609.5962725096227627176.b4-ty@kernel.dk>
Content-Language: en-US
In-Reply-To: <171880672048.115609.5962725096227627176.b4-ty@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240619_072120_963315_E8662FBD 
X-CRM114-Status: GOOD (  13.52  )
X-Mailman-Approved-At: Wed, 19 Jun 2024 07:24:28 -0700
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

On 6/19/24 8:18 AM, Jens Axboe wrote:
> 
> On Mon, 17 Jun 2024 08:04:27 +0200, Christoph Hellwig wrote:
>> this is the third and last major series to convert settings to
>> queue_limits for this merge window.  After a bunch of prep patches to
>> get various drivers in shape, it moves all the queue_flags that specify
>> driver controlled features into the queue limits so that they can be
>> set atomically and are separated from the blk-mq internal flags.
>>
>> Note that I've only Cc'ed the maintainers for drivers with non-mechanical
>> changes as the Cc list is already huge.
>>
>> [...]
> 
> Applied, thanks!

Please check for-6.11/block, as I pulled in the changes to the main
block branch and that threw some merge conflicts mostly due to Damien's
changes in for-6.11/block. While fixing those up, I also came across
oddities like:

(limits->features & limits->features & BLK_FEAT_ZONED)) {

which don't make much sense and hence I changed them to

(limits->features & BLK_FEAT_ZONED)) {

-- 
Jens Axboe


