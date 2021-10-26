Return-Path: <SRS0=3UZ0=PO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6429C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Oct 2021 15:42:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9669D60F9D
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Oct 2021 15:42:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9669D60F9D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pEeFx7fKwVz7r6OjBSTxpey03pHjAhV98o20OpErjpI=; b=STR+OjIDL40AO9GZdr+JCO4m4d
	3HMoR/81Rv6TKLV1gkv+Qr1yfqzi6Xh8HA8WdvMrN3p3yJqHOJqIG/frzSwxpSNTgWKxEBYFOHCh0
	ouM9s8mudmGgAdZ2hQ/Fqi2UAWPNZncdjBxLODKZpMe9t+1VVh6eohihAG9Nnk2OD3hqiLgEHcFyJ
	yISMOjgd4aq4/EdqkJ77c16plCWrG3S24+Ws9GK6sQcgI0OX5ueB6EW9nbeijyfGwMhhBzHb9KiXA
	5w15laa9I1lIN2LeSK/3FvLal72Xx3rxfmWcfCSjWsfKX0N0TdSBnlV0cjjr50lP0sg6G/NfR/79Y
	ugXNKwHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mfOaW-002DU6-LF; Tue, 26 Oct 2021 15:42:08 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mfOaT-002DRM-NA
 for linux-nvme@lists.infradead.org; Tue, 26 Oct 2021 15:42:06 +0000
Received: by mail-wr1-f49.google.com with SMTP id e4so20020260wrc.7
 for <linux-nvme@lists.infradead.org>; Tue, 26 Oct 2021 08:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pEeFx7fKwVz7r6OjBSTxpey03pHjAhV98o20OpErjpI=;
 b=cO+WxdVN82wlItGxjDBJDaILZHxNuNpTFjSIvt1+vG1yr7AgquOFSnAc9fVY2CQWTM
 TqgaMBlmvWvZ76w88aL+dug4m/Ycuvx/RBxQ5Fty1jZjGblfO0FgN5pU6dtPco4gUpcS
 STsdU1X4N1/q7kJiDpqfPEyuVuQnkpBJWu/8Ow1ONxRNO5sOxIThh/Mfj8gC8qNN5Bl8
 Xwm9o1z5Z7/tYxDgyFoyyfULOQ5d4Z7Iaov+7gaP5eWHYNGRUxVyTVJpHBNXe1i3Sf76
 66jvBU5Yn79EFUIz/CH/Jm8nzYRAdhlM22SVsRUxXIuPpxTW4becNe8nkiC03ksoyo82
 Icog==
X-Gm-Message-State: AOAM532Bwj4QlXN6PNiw7dnFyi1ALr6euFubfC91UTvF4lV2dV+8LD0h
 HkkJ4KkBNRheF/e+0gAcjvY=
X-Google-Smtp-Source: ABdhPJx/86KOS9Mv+wHPLClCqJMZJg3BbHXgqXvshXgcHIV7S8eRLeHaPk2r9kpnJ2mKJFeMTEhJnw==
X-Received: by 2002:adf:dd07:: with SMTP id a7mr27069606wrm.395.1635262923689; 
 Tue, 26 Oct 2021 08:42:03 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id p18sm1034202wmq.4.2021.10.26.08.42.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Oct 2021 08:42:03 -0700 (PDT)
Subject: Re: [PATCH 2/2] nvmet: fix a race condition between release_queue and
 io_work
To: Maurizio Lombardi <mlombard@redhat.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, hare@suse.de, chaitanya.kulkarni@wdc.com, jmeneghi@redhat.com
References: <20211021084155.16109-1-mlombard@redhat.com>
 <20211021084155.16109-3-mlombard@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <54e0464e-0d05-4611-10d9-7b706900af28@grimberg.me>
Date: Tue, 26 Oct 2021 18:42:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211021084155.16109-3-mlombard@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211026_084205_802900_ED4C8D0A 
X-CRM114-Status: GOOD (  15.79  )
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

Hi Maurizio,

On 10/21/21 11:41 AM, Maurizio Lombardi wrote:
> If the initiator executes a reset controller operation while
> performing I/O, the target kernel will crash because of a race condition
> between release_queue and io_work;

Can you add the stack trace?

> nvmet_tcp_uninit_data_in_cmds() may be executed while io_work
> is running, calling flush_work(io_work) was not sufficient to
> prevent this because io_work could requeue itself.

OK, then this should be sufficient to fix it right?

> * Fix this bug by preventing io_work from being enqueued when
> sk_user_data is NULL (it means that the queue is going to be deleted)

This is triggered from the completion path, where the commands
are not in a state where they are still fetching data from the
host. How does this prevent the crash?

> * Ensure that all the memory allocated for the commands' iovec is freed

How is this needed to prevent a crash?

