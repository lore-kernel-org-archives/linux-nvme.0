Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63469C76196
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Apr 2023 12:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hQCt4YaHv+6303eq3oNsTscAtpuTTpPBNIA7vNtc7BM=; b=mwP9PJ2hQs/7xWeagele/mawbb
	nyurOdXm/o7iv4dMaN4zmuRwSr8f5xrs6w9GbImWLaYEOmlIbLARdUDFKEEK9vy+FnfOUEheruElZ
	w1F1tJDNnxpRGSwOphZZmT0Jlb18XA6FrnZLRZQT48fY+may6pxq9kC8PDtNKk+lKTcdi41D4x8Os
	D+1Y4DH3iNSJVgTH0NSiO9g5uCMfwnSo8GzHDu2uMB+okZEFvUOEfdUXAv2zn1Uur2TpeEIss+eRi
	a89NqnSerBc1A3QrPHV7iWR6Lx3SpcZj799klA2qIgteHA26jOp7qs/ms92z9rU5KJLupfOCfaplm
	hObxjiog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pjJEK-00FG80-1m;
	Mon, 03 Apr 2023 12:24:12 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pjJEH-00FG7L-2L
	for linux-nvme@lists.infradead.org;
	Mon, 03 Apr 2023 12:24:10 +0000
Received: by mail-wr1-f43.google.com with SMTP id y14so29166490wrq.4
        for <linux-nvme@lists.infradead.org>; Mon, 03 Apr 2023 05:24:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680524646; x=1683116646;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hQCt4YaHv+6303eq3oNsTscAtpuTTpPBNIA7vNtc7BM=;
        b=njCLJstSnyUclenxk4PiEFhnVPcBtd2iAbTjLrzZA3Veb+OK4TZHNFHDTvFxcT4mJ0
         SLHDwXe2pZffgdCuu0Rfs8eeVH+U+HPP4HJSTPttVz7AJRQlRW+Jcpq23IfyXhQxUX5V
         sV11g76tV/X09wDpuTuZEX2pIu5qO1Mj7WkLXw1HKFaUW1H4zaob0/aHtBf+3BftEFov
         LiHOnobk0opuieWgEuHoNqZoZ9Ntdn6V9opWX7EyQUudfyeTB+PRF9ujzXNNf7aGETcp
         XMKgPn6mAJYKuNoarTkV7rMtGp+yUxQGY8xHXiM7wYjrOd6B7HfDJYL4Lcf065a4SGK8
         u9Ow==
X-Gm-Message-State: AAQBX9fdErZqaIqPWYVC7s8bl98Lp4AQko0ZhQ9VOMQnKjr99oWgNv+p
	yLz9G16GOuXOzUNnG9BasVs=
X-Google-Smtp-Source: AKy350YnT17EWqc4AVjiSBa/72RALGXXw0d8R+ex3gWi7PTbwRyKB/1X+7eHkM+2sdSrVB3oRW0lzw==
X-Received: by 2002:a5d:49c4:0:b0:2ca:ab68:eff9 with SMTP id t4-20020a5d49c4000000b002caab68eff9mr19563040wrs.7.1680524646419;
        Mon, 03 Apr 2023 05:24:06 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id a12-20020a056000100c00b002cea8664304sm9514655wrx.91.2023.04.03.05.24.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 05:24:06 -0700 (PDT)
Message-ID: <f1bfbb7c-d8df-0386-1048-f141cb6e22bc@grimberg.me>
Date: Mon, 3 Apr 2023 15:24:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 12/18] nvme-fabrics: parse options 'keyring' and 'tls_key'
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <chuck.lever@oracle.com>, kernel-tls-handshake@lists.linux.dev
References: <20230329135938.46905-1-hare@suse.de>
 <20230329135938.46905-13-hare@suse.de>
 <677f3f9a-872d-27fe-9a21-b41bbe1c44ff@grimberg.me>
 <daf1e19e-119b-3ceb-7808-b74d8b113e05@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <daf1e19e-119b-3ceb-7808-b74d8b113e05@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230403_052409_767185_1598F89F 
X-CRM114-Status: GOOD (  13.13  )
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

>>> Parse the fabrics options 'keyring' and 'tls_key' and store the
>>> referenced keys in the options structure.
>>
>> Can you explain the reasoning to why a user need to pass a keyring
>> given that we already set up one?
>>
> Choice.
> With a single keyring we can only have a single identity.
> But there might be configurations where we want to have different PSKs
> for the same identity (eg for key rotation).

How do you expect that rotation would work with this?

How does nvmet handle a non-nvme keyring?

> With this option we can prepare a new keyring, and use that instead of 
> the old one.

On an existing controller?

> (And it really doesn't add much complexity...)

I know, it just adds one more argument, and I want to understand if it
is really needed.

