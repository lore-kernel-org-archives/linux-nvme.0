Return-Path: <SRS0=jrCY=IV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C936C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Mar 2021 19:11:23 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2EF8619B3
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Mar 2021 19:11:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2EF8619B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=F+XUjsTW/NpbmcaU30mTYZxGFvVSjVbg48y+FdP+p10=; b=h+zh3eABMRigYjQQcC2nY8BVp
	whaz7S08HV3KjJEnqH5HdAZqKADSESZfGOApPEOsZ3NkJ0C+azxGpDUROhCDnYM/pnNIkZfvM8/+9
	HYUXAlYnEtztdhH3f+VhMqvgxvrDqdajOXhSNMFOPfbFkmKGCljjJ+icFLJE13e5R3OXf/HrwrBI2
	pdpkDw3ab7XrTnYR4b6nbRUZIaFYZHXF2abs/aYy8gET+yd9QVncmCVKKFAuRb9Cq1AxdFqZwhkTo
	8CAdVwxt0FLKTtleBjxPiOD8xhe1zr2CPwI9Vzd5I3iSV/tTjFWCtMcyZRL30liWJ8q3qmRS03HlJ
	dKuocTPJw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lOmQS-00Fa8B-9K; Tue, 23 Mar 2021 19:10:48 +0000
Received: from mail-pg1-f182.google.com ([209.85.215.182])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lOmQO-00Fa7Z-VK
 for linux-nvme@lists.infradead.org; Tue, 23 Mar 2021 19:10:47 +0000
Received: by mail-pg1-f182.google.com with SMTP id v2so12712608pgk.11
 for <linux-nvme@lists.infradead.org>; Tue, 23 Mar 2021 12:10:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1szg665cEnF+mr/Rmk/mTKKNIyLfWLmCsMVMt8xWiNw=;
 b=OgLwBGaaBNagb0TxSGD64TMK4dFnnPhvwMevy2BDALDqckUzZjtr9ZJk7PsaZoA7jL
 2V0iuEGT/5RfTsWo5AX7R3ZoxdkFotesmryyuGlLUD8fZMN6r3a0TPXJsq+wjNot25kF
 IgHTZ2YG5pAX8Zuzo3vX5lqF6aFimhyPNhXMdbpCL/7ejUzgn7wNbTWRwUivk3mDaWhE
 uQ+wcyEo8OGCLoxgTHNXX2JqpRrfNvrN7W5Qn/UNORGdF+lZLwevVc3BHKRgjUaICkzr
 virZPAI4OuZmS+LtHWOYHxGy0o6GAz5A4eXjCLPDrbZO/VtCL024QnUFyCzjaQ5EiH9x
 N8sA==
X-Gm-Message-State: AOAM530dE7SbRqHdBt3PGgHfhFRQrx0j55HJuAT98mbtdECO4Y4j3zB/
 gP1jHy//Ul+DZLUnRnR2myPXpmInH4M=
X-Google-Smtp-Source: ABdhPJxqi+ipxNNSF+1Sf8OqQT4E7lCymfoZBvETFAkNKVCKNWXQkl3Xbx9aNZ3SeCWftxLNx3Ybng==
X-Received: by 2002:a17:902:e906:b029:e5:c6d2:7dd0 with SMTP id
 k6-20020a170902e906b02900e5c6d27dd0mr7334293pld.12.1616526643248; 
 Tue, 23 Mar 2021 12:10:43 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:3b29:de57:36aa:67b9?
 ([2601:647:4802:9070:3b29:de57:36aa:67b9])
 by smtp.gmail.com with ESMTPSA id o4sm3261pfk.15.2021.03.23.12.10.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Mar 2021 12:10:42 -0700 (PDT)
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
 <162dc8f7-b46d-37ff-01e8-51d813e0a904@grimberg.me>
 <20210323182244.GA16649@lst.de>
 <c4ceed19-cdc5-aeca-0c4b-ebed088e8b82@grimberg.me>
 <20210323190145.GA17528@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0f405043-48b8-6cdc-71ed-74002571f41b@grimberg.me>
Date: Tue, 23 Mar 2021 12:10:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210323190145.GA17528@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210323_191045_104765_F467E42D 
X-CRM114-Status: GOOD (  13.41  )
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


>>>> The deadlock in this patchset reproduces upstream. It is not possible to
>>>> update the kernel in the env in the original report.
>>>>
>>>> So IFF we assume that this does not reproduce in upstream (pending
>>>> proof), is there something that we can do with stable fixes? This will
>>>> probably go back to everything that is before 5.8...
>>>
>>> The direct_make_request removal should be pretty easily backportable.
>>
>> Umm, the direct_make_request removal is based on the submit_bio_noacct
>> rework you've done. Are you suggesting that we replace it with
>> generic_make_request for these kernels?
> 
> Yes.

OK, that should be testable...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
