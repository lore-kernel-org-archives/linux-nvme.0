Return-Path: <SRS0=tyWw=HF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA850C433DB
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 10:01:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F60264F68
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 10:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F60264F68
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JgWpcPedH+225n/w+BVDiVY5PPJV3yvCaNJBWKYxIGM=; b=k18l3X3XboMQIB5dkdT9TL8KP
	4rjrFBhkR7YcdpcjA66nm6egpehshGemomnIURW/cJn6HIWFagZdyRVWqHC6cQz5wfWWaLFxLY9VM
	e6MadFpt4bWPW5dTKCYA85Stldrf6K1t3mNAPpEgh++TEThu+nTUnaefU8nlkzixtNlsg+Xf0Zkx+
	dHy0xKRGQsl3Ui/+XA1n6F/ADmT6qz+wulNa22HIAHgk2Olpd2FPvhMQ4XU5KcvaQMqBXdkdJDig5
	ay/CzAvyM3OdsY8OHk//Jc/x+LFWzq2h5OZcXInxGmay3WqbcJVQkps2WM3XsmK6/VcnaT94NCWCI
	0aLYmPVsw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7EyK-00086P-Ho; Wed, 03 Feb 2021 10:01:16 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7EyI-00085i-B5
 for linux-nvme@lists.infradead.org; Wed, 03 Feb 2021 10:01:15 +0000
Received: by mail-wr1-f51.google.com with SMTP id l12so23457177wry.2
 for <linux-nvme@lists.infradead.org>; Wed, 03 Feb 2021 02:01:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hQ1+xn9onHr+U1sKgaHwddewcXOnntyDrq8unLpuF+s=;
 b=i9P/yjiKuBekbcssY9CljF/93ObiLd3JrE6Fx8zYekRzmotAUhkx+RP8YZxX40d+5e
 LsVYYlUmgXvvH1s8U1Lr2JlIar3zUQzEd9u8/FZh4vos9pePubMSNHHY4/dS7Z31sW4V
 CTCn7VlLb+ujdGhoUZwjgipWQWzDjOiaPQJbNBOy/ciYXJjpAn0UagCQybRs0ERr2Nxb
 14A7GhDga3jTpKKPrQwBanDopLR+1MrKMr7IcvuE5UENgvrHwDfYL/fFJJj5Vg2MUntu
 yqlbh5nM0LlWJ5BelPA8e9fXITlo70N0o68sAnaOlc0tHWElVx8tYLaDTUb4OIj0Dl62
 G8TA==
X-Gm-Message-State: AOAM531iLEEqvBkYzZmIezMoaeXCJ5gLq9oHBLNykVT3Dgk00KfM5Z32
 GzoHLQ5q2E1e3+aFI9Kfzpg=
X-Google-Smtp-Source: ABdhPJxcBp3kjQpvQn8kU5SPiF5zv/vrRQ69xPnMYCmqw5Ye4o0WNmrp7fFypq8ohVem3RqUBzwwRw==
X-Received: by 2002:adf:bbc1:: with SMTP id z1mr2518738wrg.95.1612346472794;
 Wed, 03 Feb 2021 02:01:12 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:819b:e1e8:19a6:9008?
 ([2601:647:4802:9070:819b:e1e8:19a6:9008])
 by smtp.gmail.com with ESMTPSA id p18sm2007664wmc.31.2021.02.03.02.01.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Feb 2021 02:01:12 -0800 (PST)
Subject: Re: [PATCH v2] nvme: avoid "(efault)" from nvme_sysfs_show_subsysnqn()
To: Christoph Hellwig <hch@lst.de>, mwilck@suse.com
References: <20210202005951.26614-1-mwilck@suse.com>
 <20210202075828.GA12160@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3fbf065a-0c1b-dbf6-7f07-06838a6efcd4@grimberg.me>
Date: Wed, 3 Feb 2021 02:01:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210202075828.GA12160@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210203_050114_403673_8981956F 
X-CRM114-Status: GOOD (  14.20  )
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
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Hannes Reinecke <hare@suse.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> From: Martin Wilck <mwilck@suse.com>
>>
>> While a controller is still connecting, ctrl->subsys is NULL and
>> thus reading the controller's "subsysnqn" sysfs attribute returns
>> "(efault)". This happens all the time when user space processes
>> "add" events for NVMe controller devices.
>>
>> Fix it by returning the nvmf_ctrl_options' subsysnqn attribute
>> if ctrl->subsys isn't initialized yet.
> 
> This is just papering over symptoms.  We should not be sending
> events or display sysfs files until the controlle is live.
> 
> In other wwords - I think we should remove the cdev_device_add
> from nvme_init_ctrl to nvme_start_ctrl (+ any error handling changes
> resulting from that).

Maybe move it to nvme_init_identify? nvme_start_ctrl is after I/O queues
were created.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
