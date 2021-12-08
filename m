Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A124BC433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Dec 2021 11:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/HUEVuB7nwz3XwbuNpoOARWOI/82hvSvRLLEPvIQriE=; b=O5zinn63g7+/vYc0ZWGYRYxqEV
	WU7Ks1I/5XqJRjeLJ6AS2zrVbl3Y5pfXv2JiBd/LrUwhpG/fNT7qyEGLVeXhJ89mSOepTcdcwDHuy
	zE0J0GqriBe9tOfHd8zJCNiklHcYi8E/tdjNy4JduH2P4+RDzkNO5CPQlp8QtMIhu3d/tV9QiXV14
	/Jhu539q6zZT52pqY5YM/jX5tlnHkgabuojUKYZfLqHEq4lV4cASLjRkWwmP1IVNE7da4gljjoqMz
	23UDUk8ccAzegnYBZS4+M7oBjY0XExUGwYwOp4xKTUu3CVY+WbXAhdR1NB5uFKMCboYqPjnccXEoa
	rLqtlyLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1muvCI-00CHDx-Tz; Wed, 08 Dec 2021 11:33:18 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1muvCF-00CHDS-Rz
 for linux-nvme@lists.infradead.org; Wed, 08 Dec 2021 11:33:17 +0000
Received: by mail-wr1-f48.google.com with SMTP id d9so3542964wrw.4
 for <linux-nvme@lists.infradead.org>; Wed, 08 Dec 2021 03:33:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/HUEVuB7nwz3XwbuNpoOARWOI/82hvSvRLLEPvIQriE=;
 b=kJW5WbY5RtEswEp6dQgIqGGwXpLNXmHdlZSkkgVQDtyB2gB7ZYeAcNsUWoHCswEfDw
 nvxfJOw+LgOZUGYaX3L6wP1Tk0+IOwRHCMc1vSTfx8hZJVTHK/tGsEj59SvQOzjpgaYa
 Frds4cbTwqIlgwB9pSiAF90QEzQN7zzPQbUCul9Wh7TR0YS7saQ6P8PCJRqlchnqbFsF
 y/8lmDpkWW6QUjYI1HkDOoFFhzWb2kFpS3CnN9A6lzVDfTojyYvz0+LVa/ZGfoNAY1Gy
 XX+b5/ubIDCsCFvQPOgsdHabpoe0wmjRLujva4Peu2dUny/d1/ITFEJlgp/ou6f3cHbo
 ulyg==
X-Gm-Message-State: AOAM533+sZS73Rwwk8VdsollJF4ldaqzd9QU59Jz02LnTCr6lbTocCWG
 3odeGn4aTPTVXgGaD2JYf2kO7nfy06M=
X-Google-Smtp-Source: ABdhPJxrJmIT27V1mxkmy3SRu7kAkT3Vbqe3a86pazm7QRFLFaL922WGQvomz4JBppl6SBHtYL6qVQ==
X-Received: by 2002:a5d:548b:: with SMTP id h11mr58689526wrv.11.1638963191502; 
 Wed, 08 Dec 2021 03:33:11 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id d8sm2400841wrm.76.2021.12.08.03.33.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Dec 2021 03:33:10 -0800 (PST)
Subject: Re: nvme-tcp host potential bugs
To: "Engel, Amit" <Amit.Engel@Dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: "Anner, Ran" <Ran.Anner@dell.com>
References: <PH0PR19MB4889C321978DC541DD83A939EE6E9@PH0PR19MB4889.namprd19.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <9f6e47bd-e604-790e-b6a1-13ed8fd111b1@grimberg.me>
Date: Wed, 8 Dec 2021 13:33:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <PH0PR19MB4889C321978DC541DD83A939EE6E9@PH0PR19MB4889.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211208_033315_951439_E94AD436 
X-CRM114-Status: GOOD (  23.48  )
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


> Hello Sagi,
> 
> We would like to share and hear your inputs regarding 2 host nvme-tcp issues that we have encountered in kernel version 4.18.0-348.2.1.el8_5.x86_64
> 
> First issue:
> As part of nvme_tcp_create_ctrl, ctrl->queues is being allocated per ctrl in size of queue_count
> Ctrl queue_count is being set as part of nvme_tcp_alloc_io_queues per nr_io_queues

ctrl->queues array is being allocated just once, in create_ctrl, and is
capped by opts->nr_io_queues, and should never exceed this size.

> 
> We see a potential issue in the following scenario:
> A connection is being established with x I/O queues and ctrl->queues is allocated to be of size x + 1

This means that opts->nr_io_queues == x

> Assuming there is a reconnection (due to a timeout or any other reason)
> The new connection is being established with y I/O queues (where y > x)

That should not be possible. It can be that the controller refused to
accept all the queues that the host asked for, which means that
user wants z queues, controller accepted the first go x queues and in
the second go y queues where z <= y < x (according to your example).

ctrl->queues size is z
first round the host connected x of these queues, and in the second
round the host connected y of the queues.

> 
> In this case, ctrl->queues was previously allocated with queue_count x + 1
> But now queue_count is being updated to y + 1
> As part of nvme_tcp_alloc_queue, we have
> struct nvme_tcp_queue *queue = &ctrl->queues[qid];
> which might lead to access an out of range memory location (When qid > x + 1])
> again, ctrl->queues was allocated with queue_count == x + 1 and not y
> 
> To prove the above theory, we added some debug prints when using x == 8 and y == 48:
> 
> #creating 8 I/O queues, queue_count == 9, queues points to 00000000fd0a0f0f

Yes, but what is the array size?

> Nov 30 14:02:25 nc9127122.drm.lab.emc.com kernel: nvme nvme15: creating 8 I/O queues. queues 00000000fd0a0f0f queue_count 9
> Nov 30 14:02:25 nc9127122.drm.lab.emc.com kernel: nvme nvme15: mapped 8/0/0 default/read/poll queues.
> Nov 30 14:02:25 nc9127122.drm.lab.emc.com kernel: nvme nvme15: Successfully reconnected (1 attempt)
> 
> #Timeout occurs that leads to reconnecting:
> Nov 30 14:02:42 nc9127122.drm.lab.emc.com kernel: nvme nvme15: queue 0: timeout request 0x0 type 4
> Nov 30 14:02:42 nc9127122.drm.lab.emc.com kernel: nvme nvme15: starting error recovery
> Nov 30 14:02:42 nc9127122.drm.lab.emc.com kernel: nvme nvme15: failed nvme_keep_alive_end_io error=10
> Nov 30 14:02:42 nc9127122.drm.lab.emc.com kernel: nvme nvme15: Reconnecting in 10 seconds...
> 
> #Creating 48 I/O queues, queue_count == 49, queues points again to 00000000fd0a0f0f

again, what is the array size?

> Nov 30 14:02:52 nc9127122.drm.lab.emc.com kernel: nvme nvme15: creating 48 I/O queues. queues 00000000fd0a0f0f queue_count 49
> 
> Second issue:
> With the same above example , where x <  y
> As part of the reconnection process, nvme_tcp_configure_io_queues is being called
> In this function, nvme_tcp_start_io_queues is being called with the new (y) queue_count
> Which will lead to an error (when sending the IO connect command to the block layer)

But the host won't connect x queues, it will only connect y queues.
Maybe I'm missing something?

> 
> Thanks,
> Amit
> 
> 
> Internal Use - Confidential

I'm assuming that this is not confidential as you are posting this
to Linux-nvme, so please drop this notice from your upstream mails.

