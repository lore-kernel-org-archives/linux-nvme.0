Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5144C88E4D
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2026 22:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4N9Po8THWwst3Ni8qYPenvp5yNhKG3HPQuwG00MWlxY=; b=Sqrndm11oUAm3o6ldb5cVV9+81
	AvyFfmuQxXVOvm0iaddiz9HfiVb5IzMXwBY9kdVFsNMP75X25xiH45xYD0cLMJD0bSaG13ise4PjE
	6arRfQJJF6w0KnHZfve6tvkPZvtplRfj0bKkXnA++aGzgGIAlrQHr1J/1kRf8owDQI8X/4zqOXN6c
	UxBlO69N2HSaKrPYk+aYJLgje9hCuRlBpf0q21RTe52iE0CW/W3U7KB0Yb/u8fK0fgQbnG+wQP5/i
	GI+H8lLRbAExwWCO61s//FGqPm6CJUV3nIDnryArFQyyROexV+De0lRafsA4+RVtI/pLTGvS6MFqx
	HlnP3MLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x59za-00000000I3C-1GVy;
	Fri, 11 Sep 2026 22:45:10 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x59zY-00000000I2k-1ubh
	for linux-nvme@lists.infradead.org;
	Fri, 11 Sep 2026 22:45:09 +0000
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49b0d8bc2aaso16619525e9.0
        for <linux-nvme@lists.infradead.org>; Fri, 11 Sep 2026 15:45:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789166706; x=1789771506;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4N9Po8THWwst3Ni8qYPenvp5yNhKG3HPQuwG00MWlxY=;
        b=r+Bvf2gV7yFACqPVD8ZGJH8ljashA+v8brxHFzRIP73cf0ALPEj1VMnCSgWZxlG/fT
         0VIzwyLpY/6yqFqDbMRbNhWzkZgM4rY1GdoIvUY4ky9F0tHcYasKjbTR4PyfRchCCgBM
         kXz67wVjP85BOPY6eJRqMTs9UjW3BUDkLslDow2/EHvH+pRebtsZJ4tj+JLl5Pgav7QX
         ci93wPVJzFp22KAH5Zg8f+AFaQVUkYGzXrlEYcmfsuj0uy3ppdVjUNCHz0MbtVWuAY0j
         E1AuTl9d6HOenAI4bRfuZe1xd3G3hm3SqIYyyOCZd5NqYxhsw6wAZQf2iaY5NcCRDAmv
         QYgQ==
X-Gm-Message-State: AFuF++k1uvaeju6OSIfKynyVUcDGCoDkwhVnrw4Sqh7wbByccZ9IVIB7
	q6PnBBhdOby7+PLfKY6VpdEnik0dIROr+QN7sXdGegV6t0fjjbmBZssg
X-Gm-Gg: AYBFou0gyQhWuMwBm+KmJ0/o3SpJtoHfQLxguRvq/0eZc7vFXZfN1gI4OLB0JeTt0w0
	STUHanCp4CyS/I2elPBAbh4G5lHmHhkONiisa7qWongrFLZIizqVWAX2rusB0LlmtbojJI9rjpR
	/ua8Znv2u0vR+v/d5ipqMUwvKTJKZcjp0GmkcLoQMtYD9N8xD45EYUV+nenake3E/GOtudqIOcP
	+hhIrCjxioW67bhOmOh8ptjkhpIAW3w3Dr3cI3FohtNidIav34KfrLGeqBc9aBaxFcPr496b6B5
	Lcc5txN6XUaq6nIGipEOuSqj5SYlxZiD3ZJ4tKZSrTA2u18uD7UccCXAyTf9Z0cyi87jIzbhdfA
	y0BcNQIWYuzodEKliUlJZhnK73DSkdjsfB+a1QV+goUgSY75fchNPHrS3xq1b1miVeAVPI7oh56
	pwdb9Yo20M/scHeN7KoGTVMqyPyS3XUKlsLA30w9T5znh/mXW7Y0Q9ppkmSaoYT5Fd0BDLDsIap
	jCoQjexHrUAbv+3skxARNnJGywEwvyK
X-Received: by 2002:a05:600c:8b41:b0:49b:d45:703e with SMTP id 5b1f17b1804b1-49e6198865dmr88111315e9.8.1789166706322;
        Fri, 11 Sep 2026 15:45:06 -0700 (PDT)
Received: from [10.100.102.74] (89-138-77-243.bb.netvision.net.il. [89.138.77.243])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb2ecfc3sm8447768f8f.4.2026.09.11.15.45.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 15:45:05 -0700 (PDT)
Message-ID: <80f6ad0b-fe3b-491a-81b3-c2c333bcaf41@grimberg.me>
Date: Sat, 12 Sep 2026 01:45:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: fix cntlid uniqueness check for different hosts
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
References: <20260823001509.119740-1-sagi@grimberg.me>
 <20260902134729.GA22248@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260902134729.GA22248@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260911_154508_535784_75568BD9 
X-CRM114-Status: GOOD (  14.74  )
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



On 02/09/2026 16:47, Christoph Hellwig wrote:
> On Sun, Aug 23, 2026 at 03:15:09AM +0300, Sagi Grimberg wrote:
>> A single physical host may use a separate {hostnqn, hostid} identifiers
>> when connecting to a controller.
> Not really.  As the hostid defines a host.  Linux just might be able to
> implement multiple hosts when it say hosts multiple containers.

Well, from the subsystem perspective, it is a separate host.

>
>> It is possible that the a distributed
>> nvmf controller may generate unique cntlid per hostnqn and not globally
>> unique. Hence, validate the cntlid is unique per nvmf host.
> If it does so it is not spec compliant, and we should not support it.

Hmm, interesting. It didn't occur to me that the cross-hosts controller IDs
are meaningful in any way.. The issue is that if a host connects to multiple
subsystem ports (say 16 for multipath), and also may use multiple 
hostnqn/hostid
pairs, the available number of cntlids starts dropping very quickly 
given that
there are only 16 bits in cntlid.

I am wandering if this issue was observed by others.

