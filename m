Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09796C3DA6E
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Jan 2024 14:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:
	Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QVWWEZC0nTAcEXYkvWfohoACi+DyynjzoGETkqq6WTk=; b=IT53TANaIxqznHBKFaxy+XC5fk
	MxNrc9UGhiwnneaKAh1dW6xk0JEYcZR8z+S6C/36EXttageJpaAHwlo6sCm8ws0mkE/N+5E7Azty0
	qJiZ9lfQA7sjks8E80uiidMhZkJUZQ6EatDLYNYNxhoUWNjPcrfkXlK6DA3SYkkApnVeOyF4JjkrI
	OICocOM2c98Vv8DuO5ahLIYK8svR3ulFrGNf1nfXwdFI5EIOjPCBrvQ0Ptyrx6enpb/wkdzNSvQku
	npQyfJWU1dRFW13xlLI3VNazwvqdexD6l2ipiWomO4sgXE6K0gMe/f2WI5wRxeKLgqXV2EYvfCVC4
	Az9N3yJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLl16-00H26X-26;
	Fri, 05 Jan 2024 14:17:44 +0000
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLl0z-00H24h-11
	for linux-nvme@lists.infradead.org;
	Fri, 05 Jan 2024 14:17:40 +0000
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2cd0f4f306fso19512291fa.0
        for <linux-nvme@lists.infradead.org>; Fri, 05 Jan 2024 06:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1704464251; x=1705069051; darn=lists.infradead.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVWWEZC0nTAcEXYkvWfohoACi+DyynjzoGETkqq6WTk=;
        b=kQZ7fy6NWSdVssDehbPV6SiFxFcEBzy+JChM+lKiG+iuCR2sRd3ws86qqI3WN1TJa1
         G98sAI+/rJprc5kYu87B6EwqI1eJwCU3xSJDTMq8RTCOhDDxn5dlc4eIAbuNftuQZBWx
         prmSvrJOS+t3D9ytAC0kojh/rEuR2dVXngDIOF5XOD7v0WwMV1geGfaFrHxsQHv2ryre
         yQ2p76swmKh6sVVhhYxQU5DfMHa+srNEG1lLVODs9czDH1Kexzjl2FW1BJLf4hgDBrGi
         RctCF5nynmMlIuJl/R4sT7BxzLMM+Gzx0ytshElDl+j5NntLr96kudx+zX0yOBcZAERu
         Vi9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704464251; x=1705069051;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QVWWEZC0nTAcEXYkvWfohoACi+DyynjzoGETkqq6WTk=;
        b=PnBMvu15Wqdk7UqE9h6pPcMCMLcr8DWtjHSizQd+XbrfZAA3JcwoIziIDkrY9v5V5L
         1K4OGVC85bfwwpS4luj2onvpXluiJm8KTvq8UAUCirqxqdfNO+4mPQWGhcMStqYzy1su
         BpLFho6wqS+FjPOv6HNXQz615BT5JIqq4PcFiSRTgqDIichr6owXuBd/Q7qtO50UoFgT
         X3Gm0pKGrEH1T1gUHzgfpkZnlpbktKb5nnzjfEqyFN/QUDAt4gGKm8/s3hN9kzxrBZTQ
         xpUCLr7+p2m8OiIuUgoqI55YJwVAdXWeR88GBiUGrYHgcJi9ur4X4wRq+mo8C6zT+QAZ
         Q5Iw==
X-Gm-Message-State: AOJu0Yw93IgwfVFM1jJHTaWi1LeOSCJ4KV4V/m0+w2136iB9hiIgYq2w
	np4oha8a8TUykA708Nn+2VMFdlb6XMTKQ7lBXVzGLg5E1yrJHw==
X-Google-Smtp-Source: AGHT+IFUzqFY0DMUD4VxQFC0jdTQ+04LaFR5XJF6GZDdXO/19l3HLlkR+Dh2SihaaVqGfq3vwivRNQ==
X-Received: by 2002:a05:651c:2213:b0:2cc:8bd4:b860 with SMTP id y19-20020a05651c221300b002cc8bd4b860mr1337702ljq.85.1704464251368;
        Fri, 05 Jan 2024 06:17:31 -0800 (PST)
Received: from smtpclient.apple ([2a00:1370:81a4:169c:3983:bdeb:5f19:e2e9])
        by smtp.gmail.com with ESMTPSA id p8-20020a2ea4c8000000b002cca51c54c0sm337155ljm.130.2024.01.05.06.17.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jan 2024 06:17:30 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Removing GFP_NOFS
From: Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <20240105102657.fwy7uxudqdoyogd5@quack3>
Date: Fri, 5 Jan 2024 17:17:25 +0300
Cc: Matthew Wilcox <willy@infradead.org>,
 linux-scsi@vger.kernel.org,
 linux-ide@vger.kernel.org,
 linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org,
 linux-mm@kvack.org,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 lsf-pc@lists.linux-foundation.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FE208054-586E-4365-8F07-4DEBB807755C@dubeyko.com>
References: <ZZcgXI46AinlcBDP@casper.infradead.org>
 <2EEB5F76-1D68-4B17-82B6-4A459D91E4BF@dubeyko.com>
 <20240105102657.fwy7uxudqdoyogd5@quack3>
To: Jan Kara <jack@suse.cz>
X-Mailer: Apple Mail (2.3696.120.41.1.4)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240105_061737_678742_CC87A858 
X-CRM114-Status: GOOD (  26.47  )
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



> On Jan 5, 2024, at 1:26 PM, Jan Kara <jack@suse.cz> wrote:
>=20
> On Fri 05-01-24 13:13:11, Viacheslav Dubeyko wrote:
>>=20
>>=20
>>> On Jan 5, 2024, at 12:17 AM, Matthew Wilcox <willy@infradead.org> =
wrote:
>>>=20
>>> This is primarily a _FILESYSTEM_ track topic.  All the work has =
already
>>> been done on the MM side; the FS people need to do their part.  It =
could
>>> be a joint session, but I'm not sure there's much for the MM people
>>> to say.
>>>=20
>>> There are situations where we need to allocate memory, but cannot =
call
>>> into the filesystem to free memory.  Generally this is because we're
>>> holding a lock or we've started a transaction, and attempting to =
write
>>> out dirty folios to reclaim memory would result in a deadlock.
>>>=20
>>> The old way to solve this problem is to specify GFP_NOFS when =
allocating
>>> memory.  This conveys little information about what is being =
protected
>>> against, and so it is hard to know when it might be safe to remove.
>>> It's also a reflex -- many filesystem authors use GFP_NOFS by =
default
>>> even when they could use GFP_KERNEL because there's no risk of =
deadlock.
>>>=20
>>> The new way is to use the scoped APIs -- memalloc_nofs_save() and
>>> memalloc_nofs_restore().  These should be called when we start a
>>> transaction or take a lock that would cause a GFP_KERNEL allocation =
to
>>> deadlock.  Then just use GFP_KERNEL as normal.  The memory =
allocators
>>> can see the nofs situation is in effect and will not call back into
>>> the filesystem.
>>>=20
>>> This results in better code within your filesystem as you don't need =
to
>>> pass around gfp flags as much, and can lead to better performance =
from
>>> the memory allocators as GFP_NOFS will not be used unnecessarily.
>>>=20
>>> The memalloc_nofs APIs were introduced in May 2017, but we still =
have
>>> over 1000 uses of GFP_NOFS in fs/ today (and 200 outside fs/, which =
is
>>> really sad).  This session is for filesystem developers to talk =
about
>>> what they need to do to fix up their own filesystem, or share =
stories
>>> about how they made their filesystem better by adopting the new =
APIs.
>>>=20
>>=20
>> Many file systems are still heavily using GFP_NOFS for kmalloc and
>> kmem_cache_alloc family methods even if  memalloc_nofs_save() and
>> memalloc_nofs_restore() pair is used too. But I can see that GFP_NOFS
>> is used in radix_tree_preload(), bio_alloc(), posix_acl_clone(),
>> sb_issue_zeroout, sb_issue_discard(), alloc_inode_sb(), =
blkdev_issue_zeroout(),
>> blkdev_issue_secure_erase(), blkdev_zone_mgmt(), etc.
>=20
> Given the nature of the scoped API, the transition has to start in the
> leaves (i.e. filesystems itself) and only once all users of say
> radix_tree_preload() are converted to the scoped API, we can remove =
the
> GFP_NOFS use from radix_tree_preload() itself. So Matthew is right =
that we
> need to start in the filesystems.

Makes sense to me. So, we need to summarize which file system uses
the GFP_NOFS for which methods. Then, I assume, it will be possible
to split the whole modification for particular phases of getting rid of
GFP_NOFS in particular case (particular method). It looks like that
we need to declare the whole modification plan and something like
a schedule for such change. Would it work in such way? :)

Thanks,
Slava.=20


