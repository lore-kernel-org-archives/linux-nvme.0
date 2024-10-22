Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77DE9D1CDCB
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Oct 2024 09:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+YILEbYAclnGtgIEOoXGJZkmFiFrekiLSEYoNMQucCs=; b=Ahm/XVUR60ao6yQDu0+ct96E73
	fiTJFSYSHTZzQiaWFLLfTpntKAf8P2FouqHAEgGcUuNFCyykqyK7cD5BvfNv46YinwRfhdnTN4OVk
	OpMaITBzZGxUzd7PLDF4vmr8STuIKf+erhnzTeoQ//WILX0QqA97zMBAS0ov9mHkVi2Am+7CrWBQl
	nRDgJ2Pb2wbjhHhOHAMMAmNsn9t/4q877Df/m6j/zYfTa7Jm9nSE2VGooOLok2pIiIzhIfjwLHaxz
	KvRRoceLe2lyRunUc2xLs/pxZ/WJjUbqNdZFmR/FVBd+FFw185AsBBTlW8+xWfaBZ1iSHy+/Z9XC8
	gvc4vCNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3BN5-0000000ANq6-47pC;
	Tue, 22 Oct 2024 09:40:11 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3B9s-0000000ALke-1M1o
	for linux-nvme@lists.infradead.org;
	Tue, 22 Oct 2024 09:26:33 +0000
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37ed3bd6114so2546548f8f.2
        for <linux-nvme@lists.infradead.org>; Tue, 22 Oct 2024 02:26:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729589190; x=1730193990;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+YILEbYAclnGtgIEOoXGJZkmFiFrekiLSEYoNMQucCs=;
        b=mYdW9obxp1wWLXjJ44RjfZfO38Q+SVVxSfuFyw1jFues8os3RY2sXGaNZ7VH6wUvYr
         DM5/fHBHywzsyatfWe8wFSpPT8zhKPocutY2apEfISd40m1SgIUFzu08i/ETskGDn6/Q
         +Y/w7er4PfW6l5SNCKP42FKF67DAZOv3UYRRA9L2FdPReBkZJzdMow8sJAgKKcxn84ZP
         JXd0PTHb5vjhk9JfBuIBijfO8eoryCDHIUNE4MHhAP6YAx4FpzGppnz3QAvweDzrsNbd
         YuFTLbpLuIKPG7ea8ruTycgYVXAS6n+VYTjT6ShNeY/s65QHLsL8vibS5fnlTlS3+1/X
         aY4w==
X-Forwarded-Encrypted: i=1; AJvYcCX97gz++ZruTWOqV+YFKofJ/LHIu6kQnGQ7yXqNWLs8neXevouMt8BJe2F+qA8xAwKUUATmim9nejjN@lists.infradead.org
X-Gm-Message-State: AOJu0YyO4Q6Cg6EJBPev9mr9JGhHyeV3BOnj6KkWBacqXPUtnMWNx04d
	r8N1WfWEr1BInIBKMDwi1QLD/3yNeLd7H4n+B6d5OV9gReIHeXbHfbFeXw==
X-Google-Smtp-Source: AGHT+IG0yuVGTOsARF6/x25d+bN0WGww2tVXGszHnPMQjyfFlODwrqiPB2YXrR0Rb2suVwJ2WnSShA==
X-Received: by 2002:a05:6000:c81:b0:37d:52fc:edf1 with SMTP id ffacd0b85a97d-37eab6ec059mr8349310f8f.58.1729589190517;
        Tue, 22 Oct 2024 02:26:30 -0700 (PDT)
Received: from [10.100.102.74] (89-138-78-158.bb.netvision.net.il. [89.138.78.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a48d51sm6166667f8f.38.2024.10.22.02.26.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 02:26:30 -0700 (PDT)
Message-ID: <ac3f51c6-7c95-4448-b233-9099f2509d6a@grimberg.me>
Date: Tue, 22 Oct 2024 12:26:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-loop: set blocking flag
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20241017172052.2603389-1-kbusch@meta.com>
 <7846e57b-fb03-42ed-af8e-0df88cc566a4@kernel.dk>
 <ZxFRpdU-GI76uetA@kbusch-mbp.dhcp.thefacebook.com>
 <20241018051056.GC19831@lst.de>
 <64f4d599-3261-4544-90c2-4cb3e1ad96fb@grimberg.me>
 <20241022062810.GC10573@lst.de> <20241022070252.GA11389@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241022070252.GA11389@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241022_022632_398089_CAC10D02 
X-CRM114-Status: GOOD (  11.40  )
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




On 22/10/2024 10:02, Christoph Hellwig wrote:
> On Tue, Oct 22, 2024 at 08:28:10AM +0200, Christoph Hellwig wrote:
>> On Mon, Oct 21, 2024 at 12:35:17AM +0300, Sagi Grimberg wrote:
>>>> Let me see what I can do.
>>> Note, the search is ONLY in the error case, i.e. when nsid is not found in
>>> subsys->namespaces.
>> Which kinda makes it worse as we use an unusual context just from
>> that rare error path.
> I just took a very quick look, and inserting the namespace into the
> xarray when created and only removing it when it is deleted, and
> instead checking an enabled flag during lookup should do the work.

Agreed.

