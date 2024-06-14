Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A79C2C27C77
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Jun 2024 16:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hCV+IWPk0IvkJKtq2bRF2qxH9qFCYf5hnPfztISGB5o=; b=m5RREX2enN/F4S4U07u5XH0kZP
	K4B52XuG8hOVHLEfJlp6HV4kyJ+1n/LK1JILNOlwjWYX3pf+QK88CKShrnUGFxWZCFWYj0Srkix8w
	CJV8wgSUAAM9Zqai/A7QBCjGUVmW2si7IcomdHK0i6OErnNIKkDCsLrkQrcR/4JC3zwTlYHlDKlfj
	xpPZRmsh27IPOZtFLEAz0L2hXizJjAqtnUgNpCOJQ1wIylfOZ5M0BWwS14goHZ4QwytAkhlmtltKi
	q9O9IxIwWdbJ1pUlN9RvLBuvYxfQZ8f9MmiTyIGlvVV7HFbUERtQA2v3AsND8Mtzx6M+Ydjk2aIde
	Ds1ZLM8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sI9Pn-00000003Knv-1SMX;
	Fri, 14 Jun 2024 16:04:35 +0000
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sI9Pk-00000003Kn9-2W0y
	for linux-nvme@lists.infradead.org;
	Fri, 14 Jun 2024 16:04:34 +0000
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-6fe0e23d8a6so222407a12.1
        for <linux-nvme@lists.infradead.org>; Fri, 14 Jun 2024 09:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718381071; x=1718985871; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hCV+IWPk0IvkJKtq2bRF2qxH9qFCYf5hnPfztISGB5o=;
        b=uPjqm06MbusSwhzJohhGvJT+rgLv/jUU8rVLCIz4x3o+ZmsOoWTdX3FrgIxs5aMTJC
         D3ss/I4qHOdQfa5C0L3QNIVeEthj/codGhc5i6fFQj19C+eGFRolodOfdIt1bpQD1/vJ
         RuGY0Nz/caDDrUu9IVrJfOrtTpEmC1kmyM7829eBPM5lO4FMFwDKp9WhtKYcU6jdQGQP
         iXXiY2Dh9m8tI0jLvoa5PN3KzGWkVHcvqDjXjwpJX6evEqnYik2ewRh9GryvcUvxj6Lk
         sYftGnEqi+majRNZcsqkYyWlR9YakH8VnC+UT0FYgGDlwY1ZyjqFDn99Qfy26OEGW7UM
         wPNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718381071; x=1718985871;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hCV+IWPk0IvkJKtq2bRF2qxH9qFCYf5hnPfztISGB5o=;
        b=lE1cT0dKZELMy8T4gr3k+vU+Ml78GLDUUBuwVq8Cu5LY22x5Of85+kxWGjwgKs8lA6
         OQppJfenifE8Axw7RHzJMBiMIhlBsHA0ToJ9lPoWtGJSRcyvEDQG9BHtsUgCRNWDDb2y
         ys5IBrl3Y4scRrKbaUCDFz7NfZI4j7rYIFDD3wvWGrtdhLt7GCQXp/YIkRcxpnZcPvmU
         Ph3nrnLdSc60gFcWBZj0EF4KKwH1B1uRaE2ZBRds4ixhHyo4KSaRnS88dZU8DI4FZEKT
         JBmloC8TfGbUM8Ps3KZh90/ltArgprul3WP9J8Yh4AReJs34Qpp3gbI1/9vTGP1kQBha
         a1Eg==
X-Forwarded-Encrypted: i=1; AJvYcCXZDT2AmH+Y7/Pf1P5z4wvegT0N55qBrpy7a/HZtmi+Ooffwz6g/zhUoEKxVMjiYSlfzeh1PLL065rKyxyT6JqE4f1BtD13PjNgqhtDwNw=
X-Gm-Message-State: AOJu0YxGPvHGYynqQP2vcwfFxYjFrGM0mBuFe82YASqR+E/2a9ooC3Jr
	zmJUMPK3RCkQc0HqepLnL3xKWNKU68NhwAlMX6ZoZERd0Swo0SMrlyEK6ZqNNyY=
X-Google-Smtp-Source: AGHT+IFcef25ONKjtc899Mq79qjBziTk8bpO5RUNlOaMS9rx17DLdtap7aVVIksBs4B1DV1O5X5XIA==
X-Received: by 2002:aa7:80d7:0:b0:705:daf0:9004 with SMTP id d2e1a72fcca58-705daf091c8mr2211921b3a.3.1718381071337;
        Fri, 14 Jun 2024 09:04:31 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb8d9acsm3207006b3a.197.2024.06.14.09.04.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 09:04:30 -0700 (PDT)
Message-ID: <af0144b5-315e-4af0-a1df-ec422f55e5be@kernel.dk>
Date: Fri, 14 Jun 2024 10:04:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: move integrity settings to queue_limits v3
To: Christoph Hellwig <hch@lst.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Song Liu <song@kernel.org>, Yu Kuai <yukuai3@huawei.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-raid@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
References: <20240613084839.1044015-1-hch@lst.de>
 <f134f09a-69df-4860-90a9-ec9ad97507b2@kernel.dk>
 <20240614160322.GA16649@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240614160322.GA16649@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240614_090432_906898_F30A87CD 
X-CRM114-Status: GOOD (  15.40  )
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

On 6/14/24 10:03 AM, Christoph Hellwig wrote:
> On Fri, Jun 14, 2024 at 06:33:41AM -0600, Jens Axboe wrote:
>>> The series is based on top of my previously sent "convert the SCSI ULDs
>>> to the atomic queue limits API v2" API.
>>
>> I was going to queue this up, but:
>>
>> drivers/scsi/sd.c: In function ?sd_revalidate_disk?:
>> drivers/scsi/sd.c:3658:45: error: ?lim? undeclared (first use in this function)
>>  3658 |                 sd_config_protection(sdkp, &lim);
>>       |                                             ^~~
>> drivers/scsi/sd.c:3658:45: note: each undeclared identifier is reported only once for each function it appears in
> 
> That sounds like you didn't apply the above mentioned
> "convert the SCSI ULDs to the atomic queue limits API v2" series before?

That might indeed explain it... Surprising it applied without.

-- 
Jens Axboe


