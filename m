Return-Path: <SRS0=c0j7=HK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C87C433E6
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Feb 2021 17:54:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B946164E88
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Feb 2021 17:54:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B946164E88
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=dTf+93cdBSVkutdO9AqmuVestQAVanP7VDHVDSK6MUc=; b=WzEKspgTZdGfv/Oc6H4OjvTQb
	IvwRQ6+FlKRsF1vnjoVdOpDMYZiQVlOSa4Du1lvyJ/IBtWNKfUXSfIwtLAe7LzDPHPiZesLFCI+XM
	/qav7C9UpELEIgUSmpGdE1YpAMHAVgTks3yRabwv67e/sYZq0vd7/9Nw/uosZR+ir63GQiAS+mV8o
	ZULLdo3EXEoLOfKhlZ6wp4NOyf/KCR3vgj7C43LdPbC6uBvFQEDbYQYmwlw++3L7GlHkbTZt5mVHf
	U13mTTTy++rSSS0Lq1XhVkf7XpeEDfQo6qJH5aNYLDfurq679H9+1UWroEwSOoVXeKh3LBBNOVKqH
	GHTLI1dlA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9Ajk-0006Cw-Nz; Mon, 08 Feb 2021 17:54:12 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9Ajj-0006C4-9m
 for linux-nvme@lists.infradead.org; Mon, 08 Feb 2021 17:54:12 +0000
Received: by mail-wr1-f43.google.com with SMTP id r21so2042709wrr.9
 for <linux-nvme@lists.infradead.org>; Mon, 08 Feb 2021 09:54:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=a66xHvPpp6i9dDSA9qGRCMjzbDlKR3Qlu6Ofb9DVV5E=;
 b=EUu3oG5TPXIQBpwWkg+nnIt60FFCwjARgLqiY85Q8XW9vI+NZyHVWR4YNY5EAzAYpZ
 rLoFJsaESbnEsr67S3y9Z/neZNkIVextWiupVdnihCT7uuq5TNrLsTfixApTVTC0RTpt
 7xB0CKGr6tn5MNpKcneqzq5thecLSlyOxELw4kG6NJYO0ToRiTByZt7Ztfq68R/emIqC
 oq4NqAN3k54hJXoNR1FTevJACGUHEf9HxaPY1M51SqxMizTuezeZCL9b9v/TeuNTtiXp
 HX6Sb3KfWWdk+wrzy3yo0QF+JqIqK8aP658YFdWdgMRGFpJc0I18k7+71jUN6pWMJPLi
 0oiw==
X-Gm-Message-State: AOAM53068kOuURKW9K13Phi25nx3ELpqqxkBVXBbTUnNubvZzInq4R31
 jUB2sB3+CLdPekUryDvrjQgAIhxV+Xc=
X-Google-Smtp-Source: ABdhPJwIIPgo5PKX+i0q2vi/2CObaqK+7TZC0mTmqpVzYgMhSpi6YclHvMWBzpjahZguuxz5zto/xQ==
X-Received: by 2002:a5d:58fb:: with SMTP id f27mr9164214wrd.119.1612806849850; 
 Mon, 08 Feb 2021 09:54:09 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:2121:4cf7:e6f6:2dc5?
 ([2601:647:4802:9070:2121:4cf7:e6f6:2dc5])
 by smtp.gmail.com with ESMTPSA id z4sm29766665wrw.38.2021.02.08.09.54.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Feb 2021 09:54:09 -0800 (PST)
Subject: Re: kernel null pointer at nvme_tcp_init_iter+0x7d/0xd0 [nvme_tcp]
To: Yi Zhang <yi.zhang@redhat.com>, linux-nvme@lists.infradead.org,
 linux-block <linux-block@vger.kernel.org>
References: <cki.F3E139361A.EN5MUSJKK9@redhat.com>
 <630237787.11660686.1612580898410.JavaMail.zimbra@redhat.com>
 <e1d08160-ca49-91e2-dafc-3ee80516842d@grimberg.me>
 <5848858e-239d-acb2-fa24-c371a3360557@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <af1d7e9d-0170-82f6-30e1-01f045d73fc7@grimberg.me>
Date: Mon, 8 Feb 2021 09:54:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <5848858e-239d-acb2-fa24-c371a3360557@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210208_125411_395484_D553452F 
X-CRM114-Status: GOOD (  18.30  )
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
Cc: axboe@kernel.dk, Rachel Sibley <rasibley@redhat.com>,
 Chaitanya.Kulkarni@wdc.com, CKI Project <cki-project@redhat.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Hi Sagi
> 
> On 2/8/21 5:46 PM, Sagi Grimberg wrote:
>>
>>> Hello
>>>
>>> We found this kernel NULL pointer issue with latest 
>>> linux-block/for-next and it's 100% reproduced, let me know if you 
>>> need more info/testing, thanks
>>>
>>> Kernel repo: 
>>> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>>> Commit: 11f8b6fd0db9 - Merge branch 'for-5.12/io_uring' into for-next
>>>
>>> Reproducer: blktests nvme-tcp/012
>>
>> Thanks for reporting Ming, I've tried to reproduce this on my VM
>> but did not succeed. Given that you have it 100% reproducible,
>> can you try to revert commit:
>>
>> 0dc9edaf80ea nvme-tcp: pass multipage bvec to request iov_iter
>>
> 
> Revert this commit fixed the issue and I've attached the config. :)

Good to know,

I see some differences that I should probably change to hit this:
--
@@ -254,14 +256,15 @@ CONFIG_PERF_EVENTS=y
  # end of Kernel Performance Events And Counters

  CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_SLUB_DEBUG=y
  # CONFIG_COMPAT_BRK is not set
-CONFIG_SLAB=y
-# CONFIG_SLUB is not set
-# CONFIG_SLOB is not set
-CONFIG_SLAB_MERGE_DEFAULT=y
-# CONFIG_SLAB_FREELIST_RANDOM is not set
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
+# CONFIG_SLAB_MERGE_DEFAULT is not set
+CONFIG_SLAB_FREELIST_RANDOM=y
  # CONFIG_SLAB_FREELIST_HARDENED is not set
-# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
+CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
+CONFIG_SLUB_CPU_PARTIAL=y
  CONFIG_SYSTEM_DATA_VERIFICATION=y
  CONFIG_PROFILING=y
  CONFIG_TRACEPOINTS=y
@@ -299,7 +302,8 @@ CONFIG_HAVE_INTEL_TXT=y
  CONFIG_X86_64_SMP=y
  CONFIG_ARCH_SUPPORTS_UPROBES=y
  CONFIG_FIX_EARLYCON_MEM=y
-CONFIG_PGTABLE_LEVELS=4
+CONFIG_DYNAMIC_PHYSICAL_MASK=y
+CONFIG_PGTABLE_LEVELS=5
  CONFIG_CC_HAS_SANE_STACKPROTECTOR=y
--

Probably CONFIG_SLUB and CONFIG_SLUB_DEBUG should be used.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
