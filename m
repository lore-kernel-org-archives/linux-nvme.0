Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA1AC35FF3
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Mar 2025 16:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TY/oRcO3UZfsdfHdUpN0kxvLAKDAx12D7HS/u5Zg4iM=; b=aKh2ECTcMy+msxWoRqONsF/98N
	8xoTL0dnqKByTIUzP+tK6wG+DQ6X4z8CRv/7RdE9yS9Cy+o0nwnlcH1zzP1w2K4Qtz6vm/kN7cRtM
	1psgCAE249n0v0ZWODTJ9L4oOEUsIk29oMljj8B4lCWuhMWPp0M5DzNkmAo2Jexy3qi1W8QYeyQVV
	fSzUT0tjlNUChXS4mvloNSS3HEfSfsXQGyn2lZ6LeB5bB15kjdbKlAeWtj97fCSJZO858ZmPSm4HI
	zdPAWQs7IOvmeGqcGmL4BWwGQjRr2fN/DVo0AhBGiAKGo3apPYLIfCbeCq+NMEhHt5o00scii6OVS
	Q7uoOr1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tskzY-0000000BjWe-1189;
	Thu, 13 Mar 2025 16:01:04 +0000
Received: from mail-io1-xd31.google.com ([2607:f8b0:4864:20::d31])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tskhW-0000000Bh7g-0mAq
	for linux-nvme@lists.infradead.org;
	Thu, 13 Mar 2025 15:42:27 +0000
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-85dac9728cdso31028139f.0
        for <linux-nvme@lists.infradead.org>; Thu, 13 Mar 2025 08:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741880545; x=1742485345; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TY/oRcO3UZfsdfHdUpN0kxvLAKDAx12D7HS/u5Zg4iM=;
        b=cgmbYs7ZxqGb0ST+1pjZdyAQEVViKy5X36u/e9YtUaUE0FUm1jaOGdVeb2aAG/fuey
         KnfS3pOpqjL0m5erv5L+DtDwgaK+OizudRctNuUiVkbUB2DnLe57EbgA875RBU1pfrav
         2mHJ/+pygXNtm7qkZFPviIAJk0KGjOvcJBN1P4fxeIZZDc+1Nub+ExH/P2wn3uGXh6SO
         4T6szDPThDHmwBVO12FbRr4Q8C7OZB4YgRdr9uZJ5ea0OE7JrqTCKLusqdJYdxgv2ZPV
         9LU6ekJpRQot+Lzo3bbhAfDhfh0n6W2SEpio+9Xm5koz0ZMSaP0EEyUvuhfamWBkDUn4
         /+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741880545; x=1742485345;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TY/oRcO3UZfsdfHdUpN0kxvLAKDAx12D7HS/u5Zg4iM=;
        b=NXgXU3vuq1qMWdGbtjeB0UdNq8Ygusxj3hYAL89u+BtJ51SXVaJJED0wWJAbIdJ4VS
         nK1sGrwmMT+vKMRWJ1Vj8Ra5xcfIoWZM0ojncqQEoPfNskbl0TmZ3dhDQlfLVp6yOjvL
         VNajDSRrWshOCUjlqhZ9jWjzLP73tARp7Spy9IyWqgDXvvnp9HsrwAWmUAc7nnBt0j+l
         6AXP+17+2uTj4qRBH0iEL6mkB4EmBPeG5fwxyP6wVhc8CrVaY5Vjs55G/EQUL+fyY4cg
         Ypqh0x+sREM2f+dlUaS46Qzhp5qc0Am3xJBkUyhIsofCQMHWkDbQD0dRuOUl3DRp992o
         SceA==
X-Forwarded-Encrypted: i=1; AJvYcCVj66TlXIP+Ghi0IuLglJn1GYIQZkEOSWp2a3Q7Q5m+D5IB2QThMomZES6MaCApHunm92CA/2yC+D5v@lists.infradead.org
X-Gm-Message-State: AOJu0YzqXplVeGOk6UT5jUQIk6y4FyKIGg0cPNOdeTjcgXch4w/IJLAm
	NVvoMIgFb2JhlRAgeaJdJAbe2n+owTTDUG6l7taJ0W3YcGgtcgAmo3xPohy8Z2smq2wgfyEy/7H
	6
X-Gm-Gg: ASbGncvstvTa+1/QxPrYokjcjjV+n6e97/Xq7PAFqSTObVjrna4nBGVVQW70godSDZi
	/9erYz5Qv6bYQddd6OCpFgHe0+cFljWeCfOpYDSlgJEtJ5CLsBxQRXIuOSUR5PetdLxW/pObDo/
	OgxhcLqKXK0zWf7QL+/gkd+Vn+h77/mTkM2FCa4FZ5PfR+tQX4CzS1dp+bdTfQJKQ/M9cN0rs+L
	TyvAKoTL49Zw89ufkCB5PiM3UFHy4ygiJEU/HcUrmWCApR9tvDWQa0pLnDxfqGUSyUdCW7M2JKW
	30c3XI83SB54aKicjV3WfAd7qJp+WsvrYtMfIqko
X-Google-Smtp-Source: AGHT+IEb7BDtWik7jQtG/h8MSH/c6mt10wqo1jz2f9XYl6ap4nModz4Vlkrver8exmKkxf+XSQzvVA==
X-Received: by 2002:a05:6602:2748:b0:85b:4484:182c with SMTP id ca18e2360f4ac-85dc1a204cemr26199239f.11.1741880544810;
        Thu, 13 Mar 2025 08:42:24 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f263719700sm396678173.44.2025.03.13.08.42.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 08:42:23 -0700 (PDT)
Message-ID: <cb274fb3-6a2f-4337-8a01-368d0a76ba7a@kernel.dk>
Date: Thu, 13 Mar 2025 09:42:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 6.14
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
References: <Z9L6Ok3AcufNjdjn@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z9L6Ok3AcufNjdjn@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250313_084226_356340_187F155A 
X-CRM114-Status: UNSURE (   9.44  )
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

On 3/13/25 9:31 AM, Keith Busch wrote:
> The following changes since commit e7112524e5e885181cc5ae4d258f33b9dbe0b907:
> 
>   block: Name the RQF flags enum (2025-03-06 17:50:55 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.14-2025-03-13
> 
> for you to fetch changes up to 39393f5c5c795992507aa5005a9d58396a5b07f1:
> 
>   nvmet: pci-epf: Do not add an IRQ vector if not needed (2025-03-10 10:12:16 -0700)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.14
> 
>  - Concurrent pci error and hotplug handling fix (Keith)
>  - Endpoint function fixes (Damien)

Pulled, thanks.

-- 
Jens Axboe


