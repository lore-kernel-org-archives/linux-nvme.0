Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 948C5C43334
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jun 2022 13:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v2gTp+cA+CDkARU6bcp2WI68Fn05XsVZqobkJmc/AEY=; b=cErzq73mg08cUsnN3SK/gfaRea
	Gcw3j2Ay7N6WIBDvYoqVqFe3hxMxNtlMUs9tFPksBX/LDh3qrHyaMo88onjvX0UkxhcjWahp4/Gtj
	1U4ZpBfE+BneO/YN7ZBzSTqTkHXW3Saq0H09r1cDnsh7RTD4VnIBVflrPtoBj+KWKVkfKbIB7YK0C
	YcZtjbEuKys/M6c1J49RHf61fz5h92IO2wEZi1N2gvMB/qrH6uTYWIkmRCwrcKGBUMgGljLWvFOUG
	iOHjSJ2gwhnBf+em4dW5z+TsgNstdXTGzXJstJ3249bzGmdWrsA40rNZ2ZLANcCIY952pEj046j+Y
	bCZcTXdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5SDq-00Bv3z-BF; Sun, 26 Jun 2022 13:22:42 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5SDo-00Bv2e-Ei
	for linux-nvme@lists.infradead.org; Sun, 26 Jun 2022 13:22:41 +0000
Received: by mail-wm1-f41.google.com with SMTP id c130-20020a1c3588000000b0039c6fd897b4so5888347wma.4
        for <linux-nvme@lists.infradead.org>; Sun, 26 Jun 2022 06:22:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=v2gTp+cA+CDkARU6bcp2WI68Fn05XsVZqobkJmc/AEY=;
        b=g5OYEHf8cKoxVuA7Sa2FW85KtpQuvcPwiL454r/cu4xpYf+jFpGGl80B59Q02HSzgX
         j4sJxxGuOIHbvKNFt4r16hGEYoaZ0D9HvN31x34PRCx5P1xtRQI/zQreZ+Y6YHMMBFdZ
         s28uY2aK6PWDjUAgopGKh7JRbIXj1g2XnndtuoRI+hFa4lZJhpIvlMCjTGQ//CVQbyUH
         ++uDW/BRe6Atj0rpeWHc375ZIh3LMLuAsGxPStSM3jzuhk/3zFPh91yqN2VN+yDkgoi9
         nFwiC6v/Pn9WS/hyWcxPQELoKv3wNYzTftiYuStfOYsp+KELXQxEmwdxDX2gb/gzBr8+
         U7gw==
X-Gm-Message-State: AJIora93VYyhy2mDu7DvdWEzzfGQ+LB/jQ95zOhXapjQATbjtUPoQUt9
	et2Azrk4/OHlZ3S/zSmMfM4=
X-Google-Smtp-Source: AGRyM1sTSCTgyBE0ZM4+TkVK6CFl6HHxTDbEzYzs1h1LXJQKUBHp02RO78/y1VGAQZPmFAOQX4WfFw==
X-Received: by 2002:a05:600c:350f:b0:397:7204:ce8e with SMTP id h15-20020a05600c350f00b003977204ce8emr14926403wmq.0.1656249757748;
        Sun, 26 Jun 2022 06:22:37 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id d12-20020a05600c34cc00b0039c63f4bce0sm13606901wmq.12.2022.06.26.06.22.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 06:22:37 -0700 (PDT)
Message-ID: <c196e653-f5b4-c2c8-ae8b-1bd8b1120144@grimberg.me>
Date: Sun, 26 Jun 2022 16:22:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCHv17 00/11] nvme: In-band authentication support
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220623061730.51490-1-hare@suse.de>
 <19c905e8-963e-5720-b18a-d050217d40de@grimberg.me>
 <f1e33a3f-c3e2-e6da-7314-f0a926dd98a5@suse.de>
 <3ea29952-4969-8622-7275-fa64b26b845d@grimberg.me>
In-Reply-To: <3ea29952-4969-8622-7275-fa64b26b845d@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220626_062240_534686_30EAB8F6 
X-CRM114-Status: UNSURE (   9.27  )
X-CRM114-Notice: Please train this message.
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


>>> 3. Not sure if this is related, but now I see a new memory leak:
>>> -- 
>>> unreferenced object 0xffff8fa0c91d2080 (size 128):
>>>    comm "kworker/u8:4", pid 262, jiffies 4294949965 (age 1855.437s)
>>>    hex dump (first 32 bytes):
>>>      e0 a2 c9 96 ff ff ff ff 90 0f dd f4 a0 8f ff ff  ................
>>>      01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>>    backtrace:
>>>      [<000000009524c6a1>] blk_iolatency_init+0x25/0x160
>>>      [<0000000074c7283e>] blkcg_init_queue+0xb4/0x120
>>>      [<00000000747d5b28>] __alloc_disk_node+0xeb/0x1d0
>>>      [<0000000082cf1eb2>] __blk_alloc_disk+0x31/0x60
>>>      [<000000008e36f1d8>] nvme_mpath_alloc_disk+0xcc/0x1c0 [nvme_core]
>>>      [<00000000f81c9db1>] nvme_alloc_ns_head+0x12b/0x250 [nvme_core]
>>>      [<00000000eba12e37>] nvme_init_ns_head+0x255/0x2d0 [nvme_core]
>>>      [<000000006f769fbb>] nvme_alloc_ns+0x114/0x4b0 [nvme_core]
>>>      [<00000000cf38f67b>] nvme_validate_or_alloc_ns+0x9e/0x1c0 
>>> [nvme_core]
>>>      [<00000000db73ed81>] nvme_scan_ns_list+0xf7/0x2c0 [nvme_core]
>>>      [<0000000011b21727>] nvme_scan_work+0xde/0x270 [nvme_core]
>>>      [<000000000f7941ae>] process_one_work+0x1e5/0x3b0
>>>      [<000000008eb36ec1>] worker_thread+0x50/0x3a0
>>>      [<00000000e58a93ca>] kthread+0xe8/0x110
>>>      [<00000000e82e51e5>] ret_from_fork+0x22/0x30
>>> -- 
>>
>> Hmm. Looks like a generic nvme issue, so unlikely it's introduced by 
>> this patch. We still should fix it, though :-)
> 
> I'll have a look.

CC'ing Ming, this came back since commit:

285d5731a0cb ("Revert "block: release rq qos structures for queue 
without disk"")

