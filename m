Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E8D1CD128A
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 23:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bCjm33wW7K1Ph4Bsfelc544yZvvykuRqTR/BQI/H9BQ=; b=iJQus/EaJ32KNKQj6NDBE8Qiyv
	gf/VTtoZ1runbIVDLyuQ8oiYtcwEvhbQtgozcEWVFw9mS/YEqSBlc9LZokgUja9jW6MnY0wl9gbkp
	ZF8PCByc9s3sMkbGmeViDkcrsrXe02gwv2aWm4mCBy3kVx6Lo2R73nIMeSyFjOb3sJEQPeNSiRi14
	4NyJzRxbQU4CPp0ZWaIZ9sX179i8UIZMBFFtONw/RpTlK5V8qyl4ACm7xQfZApd7frj1GAvgyJe39
	K7QfjfZR2ZCwf34VtloIjITaDilo0lE7rD6TEQdlYAETKH1NjY5dnZaoGtbD2z4CnMgFNI5B9eo4E
	61rWmInQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpzA1-0000000G57d-35b2;
	Thu, 28 Mar 2024 23:27:53 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpz9y-0000000G56R-1pBC
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 23:27:51 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1dde367a10aso2543305ad.0
        for <linux-nvme@lists.infradead.org>; Thu, 28 Mar 2024 16:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1711668468; x=1712273268; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bCjm33wW7K1Ph4Bsfelc544yZvvykuRqTR/BQI/H9BQ=;
        b=UbLtb1JnXg6nWbnpP4XH0wdGf6y5uzIqlIsVNcEeViQQTCCI/Z2aDysT/NaZRS4O8S
         /j055hA06aag8k7IGP5QAkpEN9YEM70ZmwaBCl40umlSX0A0Fci7xC+kNtwfM9krZkdc
         LzmgvC2YGp8Kbjc/JfoZ35efcqArf6YaoUQZ6zO2EOarovQ+9jk9/pgZbXg2qsakD4ls
         uz0qaKjNjYQlzvjSMqTRmpPX6IJ9F81/ygXadXjXiDLnJkyMvWVeuVHSu8RKz7NHy4qi
         j1+4caHKsIiQ0jdxSKL/Fg/edct8Q3vNwZOnEB+nkeJtbI8yiFJQ0H13JeUgeHayJaLc
         P+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711668468; x=1712273268;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bCjm33wW7K1Ph4Bsfelc544yZvvykuRqTR/BQI/H9BQ=;
        b=WuIDxqCB2Pv/iTCZhC6csZ01EtrW9GwaZ+/nrKQCId8STj5Bp0b721dH2sj014Kmt1
         OKykSgjJAdx+EQZCIKq4ZT6ZOYlUxlnkQJaLtsma7EWsg2Zu/Z0sLIKq0Xo9MN0PK0VV
         RJzzZKafX6D6zhdyTZMXIxiSLM2ZBKNFJ05ZCW+u5AHRZS+zISqEceyfLA+UxHXZiQ3V
         mytAQA7EmbLB/QRu+3jGhCeUj9MLY5Y7cReSUdKkvbVYcSE8KL2jS/NoD6z15iPyNHFT
         9q3xH6TCjTx+S/Oy29Fst0TeDT8Sr+k1fCfgLqLRYBXvbjeK9cGtDEZgU52OL62HzUYn
         R1Ig==
X-Forwarded-Encrypted: i=1; AJvYcCXq1619Vz5McGHnkXcJEg2WKP7EJ3ZpHyeSNq03Y7XqQb2j8ktpwuO24wgxpxkFOnuTD51TmZkxmKO0Whsn9Jf0Cekh8ROIoWPP9pjwcZg=
X-Gm-Message-State: AOJu0YwRclyQ6faPyLBTZWv/Vbq3YW86fiHNYAw43tkkGaNK4TZjYRd1
	IXQ8r/QxDwmLGYkLPVDnHt9pijdT2moAsQQvfVN6ztBehCjPpULv3fmELKuUHjg=
X-Google-Smtp-Source: AGHT+IEzRSgPscwrQROpiBW893aXOX7Rqe6qefWWB6pwH5sKBp8T5k7GdQKDIPe0gtsPnzS2djJ3tQ==
X-Received: by 2002:a17:902:b205:b0:1df:fbc3:d130 with SMTP id t5-20020a170902b20500b001dffbc3d130mr951768plr.1.1711668467993;
        Thu, 28 Mar 2024 16:27:47 -0700 (PDT)
Received: from [192.168.201.244] ([50.234.116.5])
        by smtp.gmail.com with ESMTPSA id x21-20020a170902ea9500b001dcf91da5c8sm2198892plb.95.2024.03.28.16.27.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 16:27:47 -0700 (PDT)
Message-ID: <0b15c2ad-71c0-4cc6-b00b-293966525a97@kernel.dk>
Date: Thu, 28 Mar 2024 17:27:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v3 00/30] Zone write plugging
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, "Martin K . Petersen"
 <martin.petersen@oracle.com>, dm-devel@lists.linux.dev,
 Mike Snitzer <snitzer@redhat.com>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20240328004409.594888-1-dlemoal@kernel.org>
 <171166712406.796545.15002324421306835511.b4-ty@kernel.dk>
 <67a6eeea-253f-4568-b73d-aa05173cdb41@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <67a6eeea-253f-4568-b73d-aa05173cdb41@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_162750_525008_EDAEBE44 
X-CRM114-Status: GOOD (  11.90  )
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

On 3/28/24 5:13 PM, Damien Le Moal wrote:
> On 3/29/24 08:05, Jens Axboe wrote:
>>
>> On Thu, 28 Mar 2024 09:43:39 +0900, Damien Le Moal wrote:
>>> The patch series introduces zone write plugging (ZWP) as the new
>>> mechanism to control the ordering of writes to zoned block devices.
>>> ZWP replaces zone write locking (ZWL) which is implemented only by
>>> mq-deadline today. ZWP also allows emulating zone append operations
>>> using regular writes for zoned devices that do not natively support this
>>> operation (e.g. SMR HDDs). This patch series removes the scsi disk
>>> driver and device mapper zone append emulation to use ZWP emulation.
>>>
>>> [...]
>>
>> Applied, thanks!
>>
>> [01/30] block: Do not force full zone append completion in req_bio_endio()
>>         commit: 55251fbdf0146c252ceff146a1bb145546f3e034
>>
>> Best regards,
> 
> Thanks Jens. Will this also be in your block/for-next branch ?
> Otherwise, the series will have a conflict in patch 3.

It'll go into 6.9, and I'll rebase the for-6.10/block branch once -rc2
is out. That should take care of the dependency.

-- 
Jens Axboe


