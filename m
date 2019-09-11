Return-Path: <SRS0=M8F8=XG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76378C5ACAE
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2019 22:23:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49F352087E
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2019 22:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="INy8yaPN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="fL/D7OGT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49F352087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nmBUwcj7ZHmYpDvQjLWgOJPE34fbVV96xrCc4CA5gPE=; b=INy8yaPNaUVIKj
	2zjMzjOzdfWB+dFKJD1S8ekPzxOPudrwXkey8h594JxOvdJGJn6/m+FO8vv/6q9Ka8Ikmu/Z2Qp5g
	NQAaHtXjX0GFvt1+FJY7K50m72PcEn7LbOHGQ9f7An19m55d8YherS4z3B8jNUNEWhTBenKFxRAZh
	1Hzsq57RVIed3qytfVoVJ/1cVhLsvs884NQXwbYQbAshS5ahRQuyjf+6f+trF9j4JvylQYpgUvHsc
	PyyRPhny3uPy1tWXN0VuEzioI5v5+Y3zDLDuZUeGaN8qo+pzO8SY+ZciR+QPawsJ5GaogOxB2geot
	nwN8xuqZSHxaEHxkB51Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1i8B19-0002II-9Z; Wed, 11 Sep 2019 22:23:15 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i8B16-0002Hw-PL
 for linux-nvme@lists.infradead.org; Wed, 11 Sep 2019 22:23:14 +0000
Received: by mail-pf1-x441.google.com with SMTP id d15so14568314pfo.10
 for <linux-nvme@lists.infradead.org>; Wed, 11 Sep 2019 15:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qromHROGHzTlsC/WWBIc0wK3SHAiGEj7/sh02xgyJfA=;
 b=fL/D7OGT3hg6ZbSy9k31tEMlyexTFo/vJMgGxHnlXpjbVwsNlbl/eZ16IfqxNLUnkF
 12rfCZgrU8Wv3rNJHflP8jGa0QAG66zT4tHdZOoTGtKJxdIfykuJbl1KqD2YEuM/0f36
 3wDR3qDI1aEP02sOaTe7gRk4AVtYZFmVPXQcBIcx4aHtaxSqtfqv0S91ZxdDaMvluEPM
 6kU5yF7rP1HOz/6MT2blFvov/2+UxBhE6rd09Aj9ZbV4FJ8kZjZu8OsuXfYSb2euGy+m
 2fiuKjg37rEiLS9B073m+KY9HsirvV1DDTuDg7kk41oKNbYrEbUf6KKXeZBiM3OrJHTq
 vcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qromHROGHzTlsC/WWBIc0wK3SHAiGEj7/sh02xgyJfA=;
 b=OtXxEsD1BzrWNqBbtKhGJM2TMYWot6QPYAr8trKKIQDo8l9f7+TovXRFNqJG2fTKR/
 ubaWI1ZwhqkRDx49ETRGgLyQdMqPI/v5OvNJ2j/H7zA9JoqNREpr3RtHq/lZSL8AbH2Q
 Eh/nj1dXALTxaqmjU9mhIcKax1dp0eXMZwzRJkiBZ5A2ysf85ZY2ISUE8IXIYfYUuqQA
 U7kYR8I7aEafDmhBmJX8Y4VQjjYEb3fo6bsuqGQT+9wJywFe8y2xuuw7Eu56UnylH6kZ
 Qkr7uUK6M4epAN+3UcmRd3XrTJDZq6rJ74IHmQUlIFGObM2FTMDA24DLCb00y+W8zuy1
 HAXg==
X-Gm-Message-State: APjAAAVnYV7gxZALdRDlSm6p3G7vb3n1+/kO1CBY+hjZ3X7b+Ep1b6IV
 8TpUHLlwspM33k/BSOR1NAJhuQ==
X-Google-Smtp-Source: APXvYqzc743lzXnjTPp/VEzJzWirmx//opNHkRTia7oyO9PI6Yt0NZRtEGWasS6hpxhuqhXujLW33Q==
X-Received: by 2002:a63:f5d:: with SMTP id 29mr10003179pgp.434.1568240592167; 
 Wed, 11 Sep 2019 15:23:12 -0700 (PDT)
Received: from [192.168.1.188] ([23.158.160.160])
 by smtp.gmail.com with ESMTPSA id h4sm25163273pfg.159.2019.09.11.15.23.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Sep 2019 15:23:11 -0700 (PDT)
Subject: Re: [PATCH v2] Added QUIRKs for ADATA XPG SX8200 Pro 512GB
To: Gabriel C <nix.or.die@gmail.com>
References: <CAEJqkgjJEHmTT3N42BXkeb+2mDbteE1YwW25cgUpMk7A_sOWzg@mail.gmail.com>
 <6a47a06d-f8f1-1865-1919-5ede359d0b10@kernel.dk>
 <CAEJqkgguW183DsU+JUPcV193HtDXzVsyUa4JEgVKrhumYTzpAg@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <856d3393-53c7-5c32-7c87-a682f6abc090@kernel.dk>
Date: Wed, 11 Sep 2019 16:23:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAEJqkgguW183DsU+JUPcV193HtDXzVsyUa4JEgVKrhumYTzpAg@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190911_152312_829014_0CA4FC08 
X-CRM114-Status: GOOD (  16.97  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/11/19 4:18 PM, Gabriel C wrote:
> Am Mi., 11. Sept. 2019 um 23:33 Uhr schrieb Jens Axboe <axboe@kernel.dk>:
>>
>> On 9/11/19 3:21 PM, Gabriel C wrote:
>>>    Booting with default_ps_max_latency_us >6000 makes the device fail.
>>>    Also SUBNQN is NULL and gives a warning on each boot/resume.
>>>     $ nvme id-ctrl /dev/nvme0 | grep ^subnqn
>>>       subnqn    : (null)
>>>
>>>    I use this device with an Acer Nitro 5 (AN515-43-R8BF) Laptop.
>>>    To be sure is not a Laptop issue only, I tested the device on
>>>    my server board too with the same results.
>>>    ( with 2x,4x link on the board and 4x on a PCI-E card ).
>>>
>>>    Signed-off-by: Gabriel Craciunescu <nix.or.die@gmail.com>
>>>    Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>>
>> For some reason your commit message is indented. Additionally, your
>> patch is whitespace damaged. So this won't apply anywhere.
> 
> Gmail hates me it seems. Sry but I don't have an proper setup on that
> box right now.
> My Laptop died and I try to fix the usual issue for new Laptops on
> this one right now.
> I uploaded the git patch, if you accept it like this. If not I will
> re-send as soon I fix
> this laptop and have git* and other things proper set up.

Use git send-email, it's trivial to use with gmail. That's what I use
and that works fine. If you use gmail (web) for kernel development,
you're going to have a really bad time.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
