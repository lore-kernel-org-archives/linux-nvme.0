Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD83ECD983
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Feb 2026 15:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3qnl17Hshf4NxOoeZ53fLK3zTuUbmcFiz8jbD8yT0iE=; b=Z9i5VVahU6T7N+Hknh0JPbEivO
	wAlaQMabJ+4SFMyExc52iS39YV/QsbWpIEHwix2xpKKJvcUPIQZtvN1li0xDBUfzRjQJTKks7Brsy
	nwEN73ljIATkBL/QOX65urrkfVYAv6Xng3swliPDkLxyoXKZ5xUVjLqCKTOaaQPXLrSLSRujggzDU
	w9FGbXVnk7VH4671YBUrqAQzOXpKeJuwJ+Psz1ygu5wkj1nXr4pLWjxOFWt1EOKXoy/pJ3r3UUx1h
	LuMIgGH0+jUZ8V6Po+wAkaGIpSDY6yHOT4RmsQX6hyEMTwvUOQcef76xklqSd+KCibe/I0JHJhv9I
	/5rCh+OQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vo1bw-0000000AAap-3lAr;
	Thu, 05 Feb 2026 15:49:40 +0000
Received: from mail-oa1-x44.google.com ([2001:4860:4864:20::44])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vo1bu-0000000AAZm-07tc
	for linux-nvme@lists.infradead.org;
	Thu, 05 Feb 2026 15:49:40 +0000
Received: by mail-oa1-x44.google.com with SMTP id 586e51a60fabf-4095cd2b11eso812823fac.1
        for <linux-nvme@lists.infradead.org>; Thu, 05 Feb 2026 07:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1770306577; x=1770911377; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3qnl17Hshf4NxOoeZ53fLK3zTuUbmcFiz8jbD8yT0iE=;
        b=L0kEkMTZ6s97kxzrwP8ilig+iIc3ADTP5cy1BwfPrN4HkHj0uILH7ZJNvQgEBwAZmn
         2xSylbIb8b3M93JtwkMKTzKw5tDLtZFWvLp0aDvYbjiJXzyN04PN48cx/cZMZMXxEHFn
         0xXrJ1FegOMK14YF7+i0QrpgbXr4FvfRBF5c783ZRpiCZPJRWs8s19TzLki6nLWSu9lo
         ADMDF5BuYLuQC6w8cMxkIcyH5A2rQMrkpNlkLnAXISaLY4qtsEp9eWUGIy7OOKu52dtG
         6rrBKLxxV7oB6uXK4Y5o7UU2EBA5rgL6ImP6Mns5NRzFSV1eI7F4cRPjtDDGt3MZw1Qb
         WhpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770306577; x=1770911377;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3qnl17Hshf4NxOoeZ53fLK3zTuUbmcFiz8jbD8yT0iE=;
        b=euhrhxyyVhsvxXbXfgpsq1ktox/J//vhCMKkxbbcULh+Xl/lu8qPKMjhcDyGsBxHh9
         Bimd4VyeF368sosiO5dGlNA+8Sk6Wfe3JdNNWEW9q4dAoYR2PPYNYu9HVsN21Pa0xp9V
         AFOjnBgGfih9eyKc38a6INo8A0naaSI0g1jC+5yD4aRvUsIQdZ2oceb8z3gCK+NbgAsA
         /V1MN5g7HQi22hA+vI/OGK8napOTHTqQTDaUKuTF+++FUD2ZNt4MvsHpkenNhiea00JB
         CVggftQ/VknB1bgiYbcBlIXAGItL/oosOjj9KUw4GULTFwgdnZGYVJCVcO32z71Bt7oy
         YwkQ==
X-Gm-Message-State: AOJu0YzcjPggigsj+CC+NyzylmJuFMXpVxhprxZo8kU5FmYoNXFBYj63
	DnhNkKe7SJ0Mi2MQQmGw9unt3uy4twGr+Eg+bxzxUzX7FGLJ0hiHfHT5LgX+b8szPRQ=
X-Gm-Gg: AZuq6aJeJqdNRAtLOl4ZXiVQavZJb6xKJ2PZMCQ/6aIc/nhiBxKbOOPtE9OIDXIug5K
	M+y7e2bqqanNUhUlWb8sx725tIPXZdjvn8pYbi4EWLvI301QTeWSU+/W2M6R6ddZYQ+WKA9JLTv
	wDgT2QlOTM+fyUVn1BHjDbDrBXpAJj6nix7SBhO8NOcVg0mb77jD+UwiNtDDrx6Xp1+LJWpSJUd
	w0eOxT05IosRS2/q6xDCWbQurepZBdbZaYOCG4zxbe2Uoe0GpjgouzX0kjMQCurN5b27d5KtNcT
	X8unhoiJ4mUa4aGYNbOZFVNuty0FdOunc0v5I/JHgFEWn5EVxkkRxSBJ8TEQ8tSBlQen8lS8Blk
	O/oY2SfsHxeH6WYlZod6JKGTRgtHG2L5MLP6pseBqMszvqHMnJKmhWgcQzLRkyjJot1jW5TTzYq
	wKI3eZ5Jj3AB/W41wCcF/Ljrk1Ry4t67Jn7yAyID9kTILLZsyXT/+XpWCXWqw6s0ymyKQS9Q==
X-Received: by 2002:a4a:e844:0:b0:662:c6ea:ceb3 with SMTP id 006d021491bc7-66a20882561mr2731806eaf.33.1770306576893;
        Thu, 05 Feb 2026 07:49:36 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40a54426935sm3979005fac.12.2026.02.05.07.49.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 07:49:36 -0800 (PST)
Message-ID: <ded8f99f-2d4a-48fc-9cff-02aa317a1c25@kernel.dk>
Date: Thu, 5 Feb 2026 08:49:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for 6.19, final
From: Jens Axboe <axboe@kernel.dk>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, linux-block@vger.kernel.org
References: <aYS5ZlwruxpNCdTL@kbusch-mbp>
 <d114450b-2405-4ed0-bcda-03e08f48ba1d@kernel.dk>
Content-Language: en-US
In-Reply-To: <d114450b-2405-4ed0-bcda-03e08f48ba1d@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260205_074938_151966_8A134487 
X-CRM114-Status: GOOD (  11.36  )
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

On 2/5/26 8:47 AM, Jens Axboe wrote:
> On 2/5/26 8:38 AM, Keith Busch wrote:
>> Hi Jens,
>>
>> Some late fixes for nvme that should go in this release. One for a pci
>> regression that causes a kernel panic during certain dma conditions. The
>> other fixes a vulnerability in the tcp target.
>>
>> The following changes since commit 4da7c5c3ec34d839bba6e035c3d05c447a2f9d4f:
>>
>>   bcache: fix I/O accounting leak in detached_dev_do_request (2026-01-28 19:06:55 -0700)
>>
>> are available in the Git repository at:
>>
>>   git://git.infradead.org/nvme.git tags/nvme-6.19-2026-02-05
>>
>> for you to fetch changes up to 52a0a98549344ca20ad81a4176d68d28e3c05a5c:
>>
>>   nvmet-tcp: add bounds checks in nvmet_tcp_build_pdu_iovec (2026-02-05 07:29:10 -0800)
>>
>> ----------------------------------------------------------------
>> nvme fixes for Linux 6.19
>>
>>  - Fix NULL pointer access setting up dma mappings (Keith)
>>  - Fix invalid memory access from malformed TCP PDU (YunJe)
>>
>> ----------------------------------------------------------------
>> Keith Busch (1):
>>       nvme-pci: handle changing device dma map requirements
> 
> After this one, iod in nvme_pci_prp_iter_next() is now unused, which
> will trigger a compiler warning...

Actually this is only true in the 7.0 based branches. Should be fine
for 6.19, I'll add a commit for the 7.0 merge.

-- 
Jens Axboe


