Return-Path: <SRS0=9POq=CU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA0CC43461
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2020 18:46:02 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 533D422205
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2020 18:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VbRvhAsq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="OXbHXnd4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 533D422205
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=AXjb9FZyeZ0pHASCX4Enaw7QwCuclvpVLYX7CwcHyeQ=; b=VbRvhAsq3AN9xwUC5+CcvNomf
	ph0ytnA2Rw+ttLnwbeMSAhY0Vn1K++ZM77DKMlclPEFkVgs5mnbniKmX+dg3uCR6zf7QP0zNJ8pjq
	xX0LeSmBvzlkABfQsF/Pj3lhWXD4DJCA3RiD6AUB0z/eG0L6oroIIYcWo6jwNev73LLc08yinC7PB
	6zhldoeAlrWJvKTF6zz38CA+7iXG2V0bbK7DIi2d+WBvBwhW/ptixZa65cSrKotP2jyKp2N3hSEWP
	5EBJ5y3bUTIJgMyEiQCHB5tPBlru137Hmm62ONOdLIsy9G177CDyO3OQpSL54eAIZpZRuOZKODuKn
	RWfstVwGw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kGo3Y-0005R3-1h; Fri, 11 Sep 2020 18:45:56 +0000
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kGo3V-0005Qf-Ar
 for linux-nvme@lists.infradead.org; Fri, 11 Sep 2020 18:45:54 +0000
Received: by mail-io1-xd41.google.com with SMTP id j2so12118106ioj.7
 for <linux-nvme@lists.infradead.org>; Fri, 11 Sep 2020 11:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xyQ7zrDADsTXTn2G9ynbikp72rRDgB7MUq83lLFTFQc=;
 b=OXbHXnd4qKFws/nWdgIV0rv+tUIeDRV5lf731S4EVMivAPrhYsBgoOnhNc1wWxCvxW
 wj9OIEazSlzsY9CJuqMdpmwQL3VWTPsXMNbfv6wOCTmYopbFmu5C/FhMBMxUEiDIUYAc
 m/u6FtMLQKkCsQJYW+zqzH6i0kBtQHY3MQR4TdDCkBGWl2fsQvv6SORsJ3NuEz9wXrhM
 MAgi38a5MvoQXD1TKSwascFAeweJaHbfZcombE3qnozjUoL3qXBohZXnxdCtg6xqJiUf
 BsczppLa6JoVPO7KtdWzbejGmn3YYEPpkwJctoumVXNzJE+Gx6/9Id6aCVweCXNol7HZ
 yKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xyQ7zrDADsTXTn2G9ynbikp72rRDgB7MUq83lLFTFQc=;
 b=Z0ZihTQqb6CbmbRYdgl/pf4a3q5WutE8BJWUtfZFtdXUGlxQadHh4lpQTyMgxnh72B
 5taI+lfQynCxEw+r0lfAVkaGrUV6OBJvdfoJjNfS+9y2judsZmmbVUD8cvzeU4Q3/7Ko
 93KQeRZmlUe6ZO1pp+VPeFhAN1tQEFt5xqqv+SSl+hOB4E1DMk/uie3hw3IY8Isgjkj7
 dbRsbyHfPgRuTWGl/0Gz8RlfwaZLyYB7mamEqLvzRfC2w9X9BINki65IyLGjMU7oIw4C
 nzvIpOtu4YOeX5a2UqqkaPt2NQTnK/k74SQf015zxaKIOEQzOVZsTHaFNXmSyOLdxyyJ
 TTMw==
X-Gm-Message-State: AOAM532U8EVuLE4LsukLcMKB7SOb9YjZNO35vFHP8tdxW94jCEuDj/pK
 6TLgdCJIw4KL719+ZTI3nhcKSw==
X-Google-Smtp-Source: ABdhPJzXO49c4GwGv9VXTp1j3gA7hErb4TCnTKvXuvwYnI1tL1rPTPPLXPYI0Y8uJWVTgOiWw1WAcw==
X-Received: by 2002:a6b:ba89:: with SMTP id k131mr2840584iof.141.1599849951525; 
 Fri, 11 Sep 2020 11:45:51 -0700 (PDT)
Received: from [192.168.1.10] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id z4sm1484794iol.52.2020.09.11.11.45.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2020 11:45:50 -0700 (PDT)
Subject: Re: [PATCH V5 0/4] blk-mq: implement queue quiesce via percpu_ref for
 BLK_MQ_F_BLOCKING
To: Sagi Grimberg <sagi@grimberg.me>, Ming Lei <ming.lei@redhat.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200911024117.62480-1-ming.lei@redhat.com>
 <4fb604fd-c081-5eb1-cb3a-860746b6952a@grimberg.me>
 <09d5cb96-b442-6965-96b3-d884c95a3ca7@grimberg.me>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <bbce9d82-2a59-7918-ec27-2b1bea4e015d@kernel.dk>
Date: Fri, 11 Sep 2020 12:45:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <09d5cb96-b442-6965-96b3-d884c95a3ca7@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200911_144553_487123_6F09F7E2 
X-CRM114-Status: GOOD (  15.81  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/11/20 12:34 PM, Sagi Grimberg wrote:
> 
>>> Hi Jens,
>>>
>>> The 1st patch add .mq_quiesce_mutex for serializing quiesce/unquiesce,
>>> and prepares for replacing srcu with percpu_ref.
>>>
>>> The 2nd patch replaces srcu with percpu_ref.
>>>
>>> The 3rd patch adds tagset quiesce interface.
>>>
>>> The 4th patch applies tagset quiesce interface for NVMe subsystem.
>>
>> Tested some reset storms and target restarts during traffic with
>> nvme-tcp.
>>
>> Seems that no apparent breakage.
>>
>> So:
>>
>> Tested-by: Sagi Grimberg <sagi@grimberg.me>
> 
> Probably unrelated to this patches, but I do see new
> kmemleak complaints in the form of:
> --
> unreferenced object 0xffff9440dbf3c240 (size 64):
>    comm "systemd", pid 1, jiffies 4306444056 (age 25034.440s)
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 b0 fe 13 99 ff ff ff ff  ................
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>    backtrace:
>      [<00000000f1d0b20e>] percpu_ref_init+0x5f/0xf0
>      [<000000009598103f>] cgroup_mkdir+0xe9/0x440
>      [<0000000001b93c19>] kernfs_iop_mkdir+0x57/0x80
>      [<000000001ed0f985>] vfs_mkdir+0x10e/0x1d0
>      [<00000000cac65f7e>] do_mkdirat+0xec/0x120
>      [<00000000956db630>] do_syscall_64+0x33/0x80
>      [<000000001c2b0e1a>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

Looks more related to the percpu_ref changes that allocate it
dynamically, causing issues on cases that forget to exit the ref.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
