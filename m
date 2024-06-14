Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E369C27C6E
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Jun 2024 16:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BDixbra1HnV5DPgXv78teb+z8r3TOra1wJTUjH08YD4=; b=azhkaatdh1gDEjTGz4mN5yWKRM
	baDHTvbSF/xKzvKuFsl1b2GtdtyzYQKMhds0oOnEmusMV2ipe51Dh0M/09YvA+rBVsDt1JKxiMfQm
	aihiViesvAtN6CcMEND1uVfEZcezkVY4UBJeQPYYJYJP9rWXBbx0HRRxZdCIOAuiO1RWgXt85+sJM
	jgdaUsRdylKwfyYv9d2jdwOAbqo05oawrV9yamPG7mda4ZxY2lfZyt8A3dQbPNleVQjSXbR5UsY6k
	6LjvcWZdbC1f2nvpll7zYSW+c8XLQ0S39f2WrwDDD8C9BpLDd4s33fq2n5AnHyC/HB60eXKGjfNXt
	0AIbGWnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sI9ax-00000003Mm1-2vtF;
	Fri, 14 Jun 2024 16:16:07 +0000
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sI9av-00000003Mla-0gKW
	for linux-nvme@lists.infradead.org;
	Fri, 14 Jun 2024 16:16:06 +0000
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-7041a382663so73084b3a.2
        for <linux-nvme@lists.infradead.org>; Fri, 14 Jun 2024 09:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718381764; x=1718986564; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BDixbra1HnV5DPgXv78teb+z8r3TOra1wJTUjH08YD4=;
        b=IkZAzVPWOeo0meoa7fl+J3W+a8VPyen2sBR0q6cLD/pshXHJOKwoN51GxUUcQ0ff4Y
         cbjYR1uIwuGrsacNMyv7Xd9tLQ+qDFjSGh6ykFxfY5xd3+U1El4Q4no9iNrOBjQ4y7jh
         uyfKoSpemcwD7aWj7fTZmf8JNCZ1a7DEEHYxsGsRLTFodphRRj+cnYmMVr0420vtpaMM
         LDDHjheJTAuCGQq1OQVD4/nQnULoqhvNAUlDh7p2Yw5zT+EvWdSXIxDF0ebJEkwEznRB
         ACpGI2qCiPJ6PPF+4CoEJf6jXN5aQkdpFi5a/C7hW1fhzt40q3Xydx6+5B9bnYjTgEfK
         683Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718381764; x=1718986564;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BDixbra1HnV5DPgXv78teb+z8r3TOra1wJTUjH08YD4=;
        b=Re36q8h185CkG8KiEOjGhV5hX/zHvEomHNqVT8HQxLX3VhrH+tj1TB33v3XiQ1GJZj
         NUAiSSRqjHXobn7ZBUsWP6F24nM3S213/krIdpeiBQxjOBJPrSi3AlthubKm6C3nrJPz
         FJt+k0CpNM7Hw/DKYtM27HESKdOQb/z4bFDr1rmJjbqkhfCvK7nIewz2P3DbQIG9aLhn
         8hvmz0z6LyrwUKVv/OgrQEfuXMXBhX2UV9d0vmrYdL00BN1Qv1gjbAcWkAA6bsQ6+MwJ
         N5D7Rz0pteDWOb6tkq+8OOpwKal2LQX0EWXm6hl2fR7iBkMe2xmfEKQg6GY6wy7YdgSt
         kfWw==
X-Forwarded-Encrypted: i=1; AJvYcCWquN+C7ERTN9iJKnVg5ciTYc3zVXjV0ZWoBp3bXzBr/TzGWVZvolJ8uKVWmbYZLmfe8xg5Qq6H18PiXK2i5kp9mHHBZqCyYn1P45OE+40=
X-Gm-Message-State: AOJu0YxtdaPf6hZoBVAp4fi/0tZBR0V3RE5A5v9xyAXNXb8L2MB32Lw6
	27KWhZ3C3A3rpvkKm4oKBbMH82hSp9CQBnDKCGqNmCYgi/MKeztJeDu/8fp+yiQ=
X-Google-Smtp-Source: AGHT+IHcxyIgaaVTPfM4bd/lwoK3Ws05v5eakEhv+baleiJUj4MZMdoqwGuHfLvaj6ML51yAKT62Sg==
X-Received: by 2002:a05:6a21:6d98:b0:1b4:e10c:62bd with SMTP id adf61e73a8af0-1bae7ed3e48mr3699835637.2.1718381764289;
        Fri, 14 Jun 2024 09:16:04 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb8d98bsm3224419b3a.191.2024.06.14.09.16.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 09:16:03 -0700 (PDT)
Message-ID: <6c5d4295-098c-4dc2-8ad2-f747a205f689@kernel.dk>
Date: Fri, 14 Jun 2024 10:16:01 -0600
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
 <af0144b5-315e-4af0-a1df-ec422f55e5be@kernel.dk>
 <20240614160708.GA17171@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240614160708.GA17171@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240614_091605_240405_B2ABAF9B 
X-CRM114-Status: GOOD (  13.85  )
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

On 6/14/24 10:07 AM, Christoph Hellwig wrote:
> On Fri, Jun 14, 2024 at 10:04:28AM -0600, Jens Axboe wrote:
>>> That sounds like you didn't apply the above mentioned
>>> "convert the SCSI ULDs to the atomic queue limits API v2" series before?
>>
>> That might indeed explain it... Surprising it applied without.
> 
> Also as mentioned a couple weeks ago and again earlier this week,
> can we please have a shared branch for the SCSI tree to pull in for
> the limits conversions (including the flags series I need to resend
> next week) so that Martin can pull it in?

For some reason, lore is missing 12-14 of that series, which makes applying
it a bit more difficult... But I can setup a for-6.11/block-limits branch
off 6.10-rc3 and apply both series, then both scsi and block can pull that
in.

-- 
Jens Axboe



