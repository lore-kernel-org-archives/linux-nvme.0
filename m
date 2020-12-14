Return-Path: <SRS0=G3e6=FS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE60C4361B
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Dec 2020 17:51:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B48721534
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Dec 2020 17:51:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B48721534
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=yd5u5nXTtHtXv8l67xy4rUretEEFNXVY+9j/p2W4n7Q=; b=uLLecGIT5JmrI9VeJp3pS4hdQ
	S5BG0Br3AiwLOymMTjzhvLL0pOjfWbdLfFccaHs/z5bwdD7HALkeLmnS1uOdWcbedo5o/opro7qQe
	PtfJW3jvtscBvdfi299h5hMQzZM+WppkoYWqsvVrA/H42KsiJonow1OAtVq7JX7Gxi9i4VGRJCLvg
	ijZ1Kh5sP5EBCav48Xdca96r7efYdh2cP/QyYsXzVB/qwvsWDAbpAdA6ywf7wY3vZoc9DTjZPFpOf
	ThIaTimgh6QUhdq5mVDWkIEOTzv/AegpJRCNsrwRaw8jy8b910nkUjhAiMLy+ND7dtTEHy1KTpw+R
	W5P0nXgVg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kos0Z-0003S9-Jd; Mon, 14 Dec 2020 17:51:39 +0000
Received: from mail-pj1-f54.google.com ([209.85.216.54])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kos0U-0003Po-R6
 for linux-nvme@lists.infradead.org; Mon, 14 Dec 2020 17:51:36 +0000
Received: by mail-pj1-f54.google.com with SMTP id m5so7026562pjv.5
 for <linux-nvme@lists.infradead.org>; Mon, 14 Dec 2020 09:51:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zwm0xFLyLY3zdp4roOWulisu6acahy8SyNYF+XzQwiw=;
 b=tzH9qfjvdfMRddCZf/bE9hGjJRRkDRe33xhU7HQZqrqQJ0TSFxVGZYXSIYhTMjiQKG
 o8n6wTVHHEh8uLVdBV7LLMSLEkjkaQgTQ5fIS4+5Ih71fVGYb6btrS8PEJ8/GZ/caPwA
 q+oxjO+74Vz2kfehCcVXQBvg+m071LQ5tiwST5Mm8sArEc5qZr02rj8BvNyZ262+GHT8
 lxZ1HDizcDlkC7l8eLzdZ69VwyulbkvF+jGLorItVT9zhftVJ3hjqbi8xPh+4m2GxCS5
 C8Rf7lP+ywpGbBKivNKZpo3nZVcCzylqZ10yvyR3hDdwhD9IAaDL5Ud7mw9+0/1bhGck
 9odw==
X-Gm-Message-State: AOAM530lYdZKWJHlJ1+ts5v6C75MBRLvkxkwFxbQQazPsyRKr8lWRGuR
 4wBRQbCLuS5CXAP7WISchX0=
X-Google-Smtp-Source: ABdhPJxK990fnZ5/CsUOUQNVvhISxcyXD/kgBD/aHbVmEtdIFf9xwSOCw/e7Bd4i6SoX5oqhF83sPQ==
X-Received: by 2002:a17:902:e901:b029:db:c0d6:62cc with SMTP id
 k1-20020a170902e901b02900dbc0d662ccmr23887035pld.7.1607968291629; 
 Mon, 14 Dec 2020 09:51:31 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:b6ef:7a90:5c54:72f9?
 ([2601:647:4802:9070:b6ef:7a90:5c54:72f9])
 by smtp.gmail.com with ESMTPSA id u1sm19091852pjn.40.2020.12.14.09.51.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Dec 2020 09:51:30 -0800 (PST)
Subject: Re: Request timeout seen with NVMEoF TCP
To: Potnuri Bharat Teja <bharat@chelsio.com>
References: <X9EHFnhujZo175Kw@chelsio.com>
 <0fc0166c-a65f-125f-4305-d0cb761336ac@grimberg.me>
 <X9JVp9mjtC1p0iLS@chelsio.com>
 <3e7aa593-16b0-3bbd-f918-caffa6f5b20b@grimberg.me>
 <X9MfI872AfM+WMV/@chelsio.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <dbb14893-da35-2f7e-0583-c33ce9f41243@grimberg.me>
Date: Mon, 14 Dec 2020 09:51:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <X9MfI872AfM+WMV/@chelsio.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201214_125134_984436_BD146095 
X-CRM114-Status: GOOD (  17.05  )
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
Cc: Samuel Jones <sjones@kalrayinc.com>, "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Hi Sagi,
> With above patch I still see the issue but less frequently. Without patch I was
> able to consistently reproduce the timouts with 4 target devices. With patch I
> see IO running fine for 4 targets. Tried the same test with 8 target devices
> and I see the below timeout. I've observed only one instance of timeout. So,
> I'll let it run for somemore time or rerun and update.

Hey Potnuri,

Have you observed this further?

I'd think that if the io_work reschedule itself when it races
with the direct send path this should not happen, but we may be
seeing a different race going on here, adding Samuel who saw
a similar phenomenon.

> 
> Target dmesg:
> ---
> [ 1704.132366] nvmet: creating controller 1 for subsystem nvme-ram0 for NQN nqn.2014-08.org.nvmexpress:uuid:77f6ffad-1c4a-4c0e-9f11-23cd4daf0216.
> [ 1704.185987] nvmet: creating controller 2 for subsystem nvme-ram1 for NQN nqn.2014-08.org.nvmexpress:uuid:77f6ffad-1c4a-4c0e-9f11-23cd4daf0216.
> [ 1704.230065] nvmet: creating controller 3 for subsystem nvme-ram2 for NQN nqn.2014-08.org.nvmexpress:uuid:77f6ffad-1c4a-4c0e-9f11-23cd4daf0216.
> [ 1704.277712] nvmet: creating controller 4 for subsystem nvme-ram3 for NQN nqn.2014-08.org.nvmexpress:uuid:77f6ffad-1c4a-4c0e-9f11-23cd4daf0216.
> [ 1704.314457] nvmet: creating controller 5 for subsystem nvme-ram4 for NQN nqn.2014-08.org.nvmexpress:uuid:77f6ffad-1c4a-4c0e-9f11-23cd4daf0216.
> [ 1704.370124] nvmet: creating controller 6 for subsystem nvme-ram5 for NQN nqn.2014-08.org.nvmexpress:uuid:77f6ffad-1c4a-4c0e-9f11-23cd4daf0216.
> [ 1704.435581] nvmet: creating controller 7 for subsystem nvme-ram6 for NQN nqn.2014-08.org.nvmexpress:uuid:77f6ffad-1c4a-4c0e-9f11-23cd4daf0216.
> [ 1704.501813] nvmet: creating controller 8 for subsystem nvme-ram7 for NQN nqn.2014-08.org.nvmexpress:uuid:77f6ffad-1c4a-4c0e-9f11-23cd4daf0216.
> [ 2103.965017] nvmet: creating controller 6 for subsystem nvme-ram5 for NQN nqn.2014-08.org.nvmexpress:uuid:77f6ffad-1c4a-4c0e-9f11-23cd4daf0216.
> ^^^^^^^^^^^^^^^
> ---
> 
> Initiator dmesg:
> ---
> [ 1735.038634] EXT4-fs (nvme7n1): mounted filesystem with ordered data mode. Opts: (null)
> [ 2111.990419] nvme nvme5: queue 7: timeout request 0x57 type 4
> [ 2111.991835] nvme nvme5: starting error recovery
> [ 2111.998796] block nvme5n1: no usable path - requeuing I/O
> [ 2111.998816] nvme nvme5: Reconnecting in 10 seconds...
> [ 2122.253431] block nvme5n1: no usable path - requeuing I/O
> [ 2122.254732] nvme nvme5: creating 16 I/O queues.
> [ 2122.301169] nvme nvme5: mapped 16/0/0 default/read/poll queues.
> [ 2122.314229] nvme nvme5: Successfully reconnected (1 attempt)
> ---
> 
> 
> Thanks.
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
