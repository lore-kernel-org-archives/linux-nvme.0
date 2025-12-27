Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA09E8FDD6
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Dec 2025 09:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MgeNdy0YuWWyqKLgp+AdynMOEeVGb+eYNCxj8IBexms=; b=RYVJXEkA4FTcPj6NXzRBN+0/16
	xnngCB78y0wGKDOIRiJLfdtSbpBSI9ZrsgtCpjDKwEZSqYsum+bPOx/LTx9qtVF5pF4JFZAbaPpQ/
	dH+n1hDTXF0Z7WjdAVSH9LK3BQhbKcoN/qWK4iDu9qIwmsn/7o+IByfYfO9Yq1+VjsFyD/uCjz+wP
	N/5pdpN4qm96PBRs9udY9VwJgR26P6rSxmTTODPnHpP75GfRWi786BMEXIV3E8iaKW9kQn+K4IVu+
	2EAQhVZOyt8NPhnkuNcCyh3rhEV52iwzSIIxJf/ES8XDElns3kYxjyF9UoPvXZQxhbYDH05T4kjdh
	lUPm039A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZR0t-00000001qKS-1lBC;
	Sat, 27 Dec 2025 09:55:07 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZR0r-00000001qJa-3282
	for linux-nvme@lists.infradead.org;
	Sat, 27 Dec 2025 09:55:06 +0000
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4775895d69cso32522895e9.0
        for <linux-nvme@lists.infradead.org>; Sat, 27 Dec 2025 01:55:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766829304; x=1767434104;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MgeNdy0YuWWyqKLgp+AdynMOEeVGb+eYNCxj8IBexms=;
        b=hF0hNw9vjU4+aKoYIrhnZNTqPmwURbiCcVWh88IwOEjKZzVNXNATmn04tteOAGsoiW
         vt/L5ijySqtQp9a2LsHkHHvnwezJaPXDGhHMxj0rNRf/bGlD8G7FjDSEAXTI21t2DcjS
         fV3Y6/+Z5WXa8uIDYRErihUbIE6uM1IunFf/w6FBm1gV5EpK2k8Drl4fHkX4ccUr1ohc
         SUePDfJ7V1VF9zUA4esTinQQ68W/OBae2Stad8YJKXuYaJspmrM35xC7TAgx/QgzeYOL
         xj+bKlExz4WD+I73dOZ3K2RH+QNlN9JepfNbXnrMmKXxK5xSTlEJ4Gu8eMz/leT/e40Z
         Heew==
X-Forwarded-Encrypted: i=1; AJvYcCX03TAT2ad3tq2k+b9hpIWs1tXipD9LkG6a/p4+hHDwaz7NwHIQFhjpg2TDBpGIJDlS758YRwMAAuUI@lists.infradead.org
X-Gm-Message-State: AOJu0Yz5GT9M9lvASWr28kSy+s4gRqb5ZHqEaWGadiCEwYbMQWPPb/lG
	YjExs7Q4gCfQpC0k4OHwO4W2vC2G2CZcnmA/jgLDnRQKhDG0wIaZRW13
X-Gm-Gg: AY/fxX7egM0nI0RnoQiDw+M43HVNTP6cD8Dsmu153i335hs4/0nCNxNGs4i8vMfQxtd
	iRNP8+0eBUCznl1+UyYLj4SfsTrv+/BQNdCJI1CMz6GakMk402oWqfN3vvOcacy9aoqAd8jGbwr
	0sKMEbD66N6MZP56x1MspAdfePHAjT7s3QzK8NLFm7OteSpjyrdFZy3Aa35HxutZl3JEb1BSxro
	Tb16/1J6eHdJccWFbxPDqyxGCr/frY4btibAy4JUNIvRoqEUal2ZbbMzQp8SJ7GtU6kv41myvOl
	9uglx8ylLu35n4qudDtQ+Lyza37DUJ/Yewi8gDoVc7+6nAzCG3bXrCeYGMb3YJfxLV2I4PpV472
	c+d6xO4a9CqI6iM7/Pj5rcGdpyQTxBT5j/qmZrRWuCzgj3vvfeLJaJBb8ZyJWZFVABmqR1bbWtj
	EjiDIU79/7IxbS3zOM/MavAm7+v6tBoawrDmwD3b0/S353UTXJw5DW8Q==
X-Google-Smtp-Source: AGHT+IG+l0xXVfn/4KRXXX22pOz4Ge/Cx7X0UB1DTt9IgD0ZtWp7FnyqM1ZBFwbrjAr4tWDaUm+Yaw==
X-Received: by 2002:a05:600c:3b2a:b0:477:b734:8c22 with SMTP id 5b1f17b1804b1-47d1953bd29mr266480285e9.8.1766829303709;
        Sat, 27 Dec 2025 01:55:03 -0800 (PST)
Received: from [10.100.102.74] (89-138-76-94.bb.netvision.net.il. [89.138.76.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d193d5372sm453678675e9.14.2025.12.27.01.55.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Dec 2025 01:55:03 -0800 (PST)
Message-ID: <f627fab9-9d8b-4a05-b2fd-e951ebb17fba@grimberg.me>
Date: Sat, 27 Dec 2025 11:55:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 07/14] nvme: Add RECOVERING nvme controller state
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>, John Meneghini
 <jmeneghi@redhat.com>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251126021250.2583630-1-mkhalfella@purestorage.com>
 <20251126021250.2583630-8-mkhalfella@purestorage.com>
 <e9bb2664-9d96-45f0-a39d-6deaad0829e9@grimberg.me>
 <20251225171709.GA8129-mkhalfella@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20251225171709.GA8129-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251227_015505_777201_2BAA3802 
X-CRM114-Status: GOOD (  10.18  )
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



On 25/12/2025 19:17, Mohamed Khalfella wrote:
> On Thu 2025-12-25 15:29:52 +0200, Sagi Grimberg wrote:
>>
>> On 26/11/2025 4:11, Mohamed Khalfella wrote:
>>> Add NVME_CTRL_RECOVERING as a new controller state to be used when
>>> impacted controller is being recovered. A LIVE controller enters
>>> RECOVERING state when an IO error is encountered. While recovering
>>> inflight IOs will not be canceled if they timeout. These IOs will be
>>> canceled after recovery finishes. Also, while recovering a controller
>>> can not be reset or deleted. This is intentional because reset or delete
>>> will result in canceling inflight IOs. When recovery finishes, the
>>> impacted controller transitions from RECOVERING state to RESETTING state.
>>> Reset codepath takes care of queues teardown and inflight requests
>>> cancellation.
>> Is RECOVERING really capturing the nature of this state? Maybe RESETTLING?
>> or QUIESCING?
> Naming is hard. QUIESCING sounds better, I will renaming it to
> QUIESCING.

I actually think that FENCING is probably best to describe what the 
state is used for...

