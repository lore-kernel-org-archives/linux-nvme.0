Return-Path: <SRS0=9POq=CU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACD2C433E2
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2020 18:34:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE3D921D92
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2020 18:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m0PF1nq+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE3D921D92
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jHymGY72ym2a1xOjU2o1LH8pu3+DNn20yvSi0Yc8gEg=; b=m0PF1nq+4qEV0vDZpWP5L1XFG
	8rAw4M1TWgfhPYGG4gxivbBiVTgLy8p7f2QW9207FYzEi+G6e0WtiNHTspT+EK6kltGutCO9RqBx9
	AnECI+ymKYZkPLeamhIKr5cSedgYggWD+K7FhHP6UPHJaR0kZIuoQRqyZPaWnK5jQgfs/Lh/8o5eV
	zF7WQrSG0LYbeiHZy8g2LrDRtPYEE93h5x0LIRHa3YNhqOPJTHVBEKmvOYaudXs4FindZ7WZ2arcT
	ZvT7nwz/bgwCverXnU1JrmJmargOwWk6+z5ci4VWkGcTXhUxx48f5Hcxh9eoHPnh4b9UpJ92NHGWm
	oAo8Hiptw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kGnsp-0004LS-UX; Fri, 11 Sep 2020 18:34:51 +0000
Received: from mail-pg1-f195.google.com ([209.85.215.195])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kGnsm-0004Kv-Si
 for linux-nvme@lists.infradead.org; Fri, 11 Sep 2020 18:34:50 +0000
Received: by mail-pg1-f195.google.com with SMTP id 7so7228237pgm.11
 for <linux-nvme@lists.infradead.org>; Fri, 11 Sep 2020 11:34:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7Uu5tIP1oLvFbOHEfS2a+Mm367EAxag99Qk3ziYJ4aQ=;
 b=tSd9f18hkX3qYF0xcJm9i2/8OpNyElI8Y3Ji4pOSGT99M3YCI/9G/lw8eRdzCS8Wfw
 yqd1SoRnIWa1YLaiQd65JpfkRTYp7ZL/gCmmIHaZTaCXPd27dcjTXE8DVJoMAIUh9Na/
 Xr8r4HR0KfuZYytAAzBpiCLPhcQK2zhHnOlRLpXRP53N8r9IiPMuo9eWPqTSAwPMNLN9
 9P2NUxF8JqOJqe/SdYsJOpDhd0iLq0yzhFgihoaRPZkflc5mu82I/gtvdRtit96nMvbW
 4LfugojoCKtfh7SPd0udvbyq1yQKh/RNghsXz3d6RgJ8UdoAy7pGyCLlUZzyVlGyrpCq
 m0Zw==
X-Gm-Message-State: AOAM533vcj1iw0MbyqPoATgvERbmyLsStcrBSGbERdGMIJ2sehtzzonH
 ATKEE01rcaAhRrNhpO4V7Cw=
X-Google-Smtp-Source: ABdhPJyXzn6p2rpLBz0aKKu0U05TK8yAUs0t8q7iU1ffy3xPEE67hIY/pPfOK2Z5X35ghzlq85sEJg==
X-Received: by 2002:a63:4c1b:: with SMTP id z27mr2595260pga.69.1599849287399; 
 Fri, 11 Sep 2020 11:34:47 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4428:73d8:a159:7fcc?
 ([2601:647:4802:9070:4428:73d8:a159:7fcc])
 by smtp.gmail.com with ESMTPSA id 203sm2919525pfz.131.2020.09.11.11.34.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2020 11:34:46 -0700 (PDT)
Subject: Re: [PATCH V5 0/4] blk-mq: implement queue quiesce via percpu_ref for
 BLK_MQ_F_BLOCKING
From: Sagi Grimberg <sagi@grimberg.me>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200911024117.62480-1-ming.lei@redhat.com>
 <4fb604fd-c081-5eb1-cb3a-860746b6952a@grimberg.me>
Message-ID: <09d5cb96-b442-6965-96b3-d884c95a3ca7@grimberg.me>
Date: Fri, 11 Sep 2020 11:34:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4fb604fd-c081-5eb1-cb3a-860746b6952a@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200911_143449_032552_E0C85585 
X-CRM114-Status: GOOD (  13.90  )
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
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Hannes Reinecke <hare@suse.de>, Chao Leng <lengchao@huawei.com>,
 Bart Van Assche <bvanassche@acm.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> Hi Jens,
>>
>> The 1st patch add .mq_quiesce_mutex for serializing quiesce/unquiesce,
>> and prepares for replacing srcu with percpu_ref.
>>
>> The 2nd patch replaces srcu with percpu_ref.
>>
>> The 3rd patch adds tagset quiesce interface.
>>
>> The 4th patch applies tagset quiesce interface for NVMe subsystem.
> 
> Tested some reset storms and target restarts during traffic with
> nvme-tcp.
> 
> Seems that no apparent breakage.
> 
> So:
> 
> Tested-by: Sagi Grimberg <sagi@grimberg.me>

Probably unrelated to this patches, but I do see new
kmemleak complaints in the form of:
--
unreferenced object 0xffff9440dbf3c240 (size 64):
   comm "systemd", pid 1, jiffies 4306444056 (age 25034.440s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 b0 fe 13 99 ff ff ff ff  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000f1d0b20e>] percpu_ref_init+0x5f/0xf0
     [<000000009598103f>] cgroup_mkdir+0xe9/0x440
     [<0000000001b93c19>] kernfs_iop_mkdir+0x57/0x80
     [<000000001ed0f985>] vfs_mkdir+0x10e/0x1d0
     [<00000000cac65f7e>] do_mkdirat+0xec/0x120
     [<00000000956db630>] do_syscall_64+0x33/0x80
     [<000000001c2b0e1a>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
