Return-Path: <SRS0=jrCY=IV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD79C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Mar 2021 18:13:41 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C774619C1
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Mar 2021 18:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C774619C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ALddpEwCjKSjmh8sy6S0rWZhZvUYNOVmmaaoYhxv6A8=; b=FRoGm5nxK9OcCDArJ6PcplZvz
	tTMsRpMh/cceFwT/ETQAHA8nN3Oq8T3lg2DgcgieJfvjxr4p+vtqwQXIdPEfb1hDYDWuJlT6goKhJ
	w0loibZrXUkEG6KM/yjSPDZCj8Dw/mfZIqWc4tONdGrZw4kr5WYZ1SB9sOCHWoRvpDKzaFDnfKAqW
	NnlrEJgwifETOYQwemS/DVoavSu0AiYC5cpWBEh+s6yIIJP3NB7/PET867x1jvuIP2bt79uH2Tspm
	P4DCPnzD73T4zii7uHXzrQt/Bg+Tlnf2M0OscK9aB6EnhXKnl++NwNUspGkoKEttjJBL58YhnfTD3
	4nMwILuCA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lOlWr-00FUtQ-44; Tue, 23 Mar 2021 18:13:21 +0000
Received: from mail-pj1-f47.google.com ([209.85.216.47])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lOlWm-00FUsb-JG
 for linux-nvme@lists.infradead.org; Tue, 23 Mar 2021 18:13:18 +0000
Received: by mail-pj1-f47.google.com with SMTP id
 q6-20020a17090a4306b02900c42a012202so10466629pjg.5
 for <linux-nvme@lists.infradead.org>; Tue, 23 Mar 2021 11:13:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3P4/mXFhJ/Dtn8cjDyndslkTLcCHvMTiZcMWHyv681Q=;
 b=T+mvfMLJ4rBz/K3qcgyVBhBbVwUEulhuuymjMO9ILcTKzyeihftUOZoPEoRnGHlbvS
 +6pvSNhlxALjVe/EnYSvb7VkQtzVDKsQrYY0H3lWmseOt60urMgpwtoYWMwLy0xvWvCg
 Y0NGJQDLCQ2RYd0f7SABqGpykXVyAMdmOX9Ju48R2MfvSx/wRkVRxSGmsGtVzAZwYvkz
 6D6qRvy8ZPD7wUxz1816hloHM5BUpa80n31W7lNl6v9q+pi0yKL9aMtnHLDKgFxrzjYP
 5ROhaY5TkwKhxS5//kmqcZTlSAwiPhIvUsr5olOVyNFGtr6S3TMHjPI9H3hPuaBAJxoA
 JeRA==
X-Gm-Message-State: AOAM530hzj55xESliIaYjVKNsXRBwYGZZ0GE3/zjnQL3x5qpLEt1mqJw
 +3/1BTn2nChON1j9lA5kvL00s7CZoq8=
X-Google-Smtp-Source: ABdhPJwfoSBgnXvyx8KbaFhNsyMPOYAFVg5BKmYQ7TrjDgXlVBGlUmxnrhI709Y+C5JTnIYWRDvemg==
X-Received: by 2002:a17:90a:d3d8:: with SMTP id
 d24mr5763366pjw.28.1616523194486; 
 Tue, 23 Mar 2021 11:13:14 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:3b29:de57:36aa:67b9?
 ([2601:647:4802:9070:3b29:de57:36aa:67b9])
 by smtp.gmail.com with ESMTPSA id i8sm3277008pjl.32.2021.03.23.11.13.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Mar 2021 11:13:14 -0700 (PDT)
Subject: Re: [PATCH 2/2] nvme-multipath: don't block on blk_queue_enter of the
 underlying device
To: Christoph Hellwig <hch@lst.de>
Cc: Chao Leng <lengchao@huawei.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20210322073726.788347-1-hch@lst.de>
 <20210322073726.788347-3-hch@lst.de>
 <34e574dc-5e80-4afe-b858-71e6ff5014d6@grimberg.me>
 <33ec8b12-0b2b-e934-acb1-aae8d0259e2e@grimberg.me>
 <31e7f7f4-55fa-6b0c-426d-7f7e7638ab4b@huawei.com>
 <5d28226d-4619-74b6-1c73-c13ed57aa7ea@grimberg.me>
 <20210323161544.GA13402@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <162dc8f7-b46d-37ff-01e8-51d813e0a904@grimberg.me>
Date: Tue, 23 Mar 2021 11:13:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210323161544.GA13402@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210323_181316_686719_C25C1956 
X-CRM114-Status: GOOD (  16.41  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> Sagi, suggest trying this patch.
>>
>> The above reproduces with the patch applied on upstream nvme code.
> 
> Weird.  I don't think the deadlock in your original report should
> happen due to this.  Can you take a look at the callstacks in the
> reproduced deadlock?  Either we're missing something obvious or it is a
> a somewhat different deadlock.

The deadlock in this patchset reproduces upstream. It is not possible to
update the kernel in the env in the original report.

So IFF we assume that this does not reproduce in upstream (pending
proof), is there something that we can do with stable fixes? This will
probably go back to everything that is before 5.8...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
