Return-Path: <SRS0=JSXe=5C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F8FC1975A
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2020 20:36:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 482BD20714
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2020 20:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mF0xZbv1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSQMDhyH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 482BD20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:Date:
	In-Reply-To:From:Subject:Mime-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uRXOseL6vlEaVVxpgy0xlQXaGgBZvtBsl4GeYImsFvM=; b=mF0xZbv1HgIY7E
	GOV/Vwug6dnOgEnIw5kXbxmS9bUxJuvgAwNO+QVqWtjrlY5Jq0GAiIA1fqet04lZwZarOgRjqRVlI
	WlOSi27wcA+NwkKvZgXZ/6bYKajkrz2EbEa8xT+RWuSZ/S/5P2VkbmakJcp7q3dmyLpmRiMTSOZrS
	VrAJytwyj7qZUceqxOBIuQ6JoHVJinBjrglbblD35TUjFlu4NSimCfPj1TAzfShwN5zDlULbVRF7X
	h3m3REEM6O8sR3e0dydyKeB2Tvm4fgPz9iyHT0qyvFFGu0G0GvekPLYKJn5bmQMHFISpktP2WgU77
	4Px4UB53hEen3ZPt1Dcw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jEIwo-0003B4-00; Tue, 17 Mar 2020 20:36:22 +0000
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jEIwl-0003Ak-9c
 for linux-nvme@lists.infradead.org; Tue, 17 Mar 2020 20:36:21 +0000
Received: by mail-qt1-x844.google.com with SMTP id l20so18766668qtp.4
 for <linux-nvme@lists.infradead.org>; Tue, 17 Mar 2020 13:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=NRL+rFj8iTOXMxbcEI6wvpftyj7DZ5j4v32M1+NFYz0=;
 b=WSQMDhyHN+/0MJbaYkq4Nghj60ImuG7mERlSFPrjIgquOdtwsK6Z1R2PPXxmcr6Nl2
 lAoYGKVgg63o3evSBw7tfJ94dXyJWb2uYk5//CgungQQBLKvRT1zeeCWXhOzi1iKr/pF
 3aOQ1WF/TXSFgHtKMRaJ9K3fevhYcbexd8NzEWZ97R4fGlXgvJpB9apaRW62oNFbe4jh
 j62d3d8bbPFAanJfE5xSE+pt2HxC+7qRLv8DN+fJmuWZcmlWVnJ1tUKaWsuZO30Muppw
 bbAt6OGFbuCNbv87LdfnzoheZIaASCCkRhyuA9rfuzuY/4nUVVXxsSSPL9JMHq9DIxnf
 EjmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=NRL+rFj8iTOXMxbcEI6wvpftyj7DZ5j4v32M1+NFYz0=;
 b=HRD3DgEMIuWxBfwga6bhmAet3XNEloCgn+8LzxtmyvfCZe+jmhcLLSaSd5dV2JK0EK
 DrIP8ILzd1+Gz1fMaD4Ed68+6B/b7sntlcanVgEzdGY3P3wD5wCKtNja6FyRtrUJxKak
 uhOyG9K+5NT1DMjaJw9oJ0Yyru1ELtSbzv6Xv0smWSFJs+WDn/MI2RpEerZLXMOtSNri
 E97ngJMrriC/szI6h1sui0oKtMjtKlm7qPP4x2IIsFitM+V0+9jdVzCHT5s0ykrARnbr
 4EyVwjWBGLGevfa8jP1pMhps4hC2BDZZdgrlaghvzerlUSoO/qvAEZwiDASowmX4B0e9
 DDgA==
X-Gm-Message-State: ANhLgQ2xqKu3q6Cjth1WeO7f5iKkEJOmVQ/XvoapiqlORecex/0jc2qE
 i625ctZjV6vhcmRgWJ10JeU=
X-Google-Smtp-Source: ADFU+vtepzx1nqFPpsAM1U4n9aVqgkBQ20MS/lvDaO4zzom9Iwd8wrko+hb9mVO00F+G3+nBZ3IsUw==
X-Received: by 2002:aed:3244:: with SMTP id y62mr1077946qtd.242.1584477377608; 
 Tue, 17 Mar 2020 13:36:17 -0700 (PDT)
Received: from anon-dhcp-153.1015granger.net
 (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
 by smtp.gmail.com with ESMTPSA id f93sm3010515qtd.26.2020.03.17.13.36.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Mar 2020 13:36:16 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 4/5] IB/core: cache the CQ completion vector
From: Chuck Lever <chucklever@gmail.com>
In-Reply-To: <078fd456-b1bc-a103-070b-d1a8ea6bff9c@mellanox.com>
Date: Tue, 17 Mar 2020 16:36:14 -0400
Message-Id: <82D6A70B-A201-4592-A031-F8EC581C0123@gmail.com>
References: <20200317134030.152833-1-maxg@mellanox.com>
 <20200317134030.152833-5-maxg@mellanox.com>
 <448195E1-CE26-4658-8106-91BAFF115853@gmail.com>
 <078fd456-b1bc-a103-070b-d1a8ea6bff9c@mellanox.com>
To: Max Gurtovoy <maxg@mellanox.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200317_133619_361862_47ADF117 
X-CRM114-Status: GOOD (  20.66  )
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
Cc: loberman@redhat.com, bvanassche@acm.org, vladimirk@mellanox.com,
 idanb@mellanox.com, linux-rdma@vger.kernel.org, shlomin@mellanox.com,
 linux-nvme@lists.infradead.org, leonro@mellanox.com, dledford@redhat.com,
 jgg@mellanox.com, Oren Duer <oren@mellanox.com>, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



> On Mar 17, 2020, at 11:41 AM, Max Gurtovoy <maxg@mellanox.com> wrote:
> 
> 
> On 3/17/2020 5:19 PM, Chuck Lever wrote:
>> Hi Max-
>> 
>>> On Mar 17, 2020, at 9:40 AM, Max Gurtovoy <maxg@mellanox.com> wrote:
>>> 
>>> In some cases, e.g. when using ib_alloc_cq_any, one would like to know
>>> the completion vector that eventually assigned to the CQ. Cache this
>>> value during CQ creation.
>> I'm confused by the mention of the ib_alloc_cq_any() API here.
> 
> Can't the user use ib_alloc_cq_any() and still want to know what is the final comp vector for his needs ?

If your caller cares about the final cv value, then it should not use
the _any API. The point of _any is that the caller really does not care,
the cv value is hidden because it is not consequential. Your design
breaks that assumption/contract.


>> Is your design somehow dependent on the way the current ib_alloc_cq_any()
>> selects comp_vectors? The contract for _any() is that it is an API for
>> callers that simply do not care about what comp_vector is chosen. There's
>> no guarantee that the _any() comp_vector allocator will continue to use
>> round-robin in the future, for instance.
> 
> it's fine. I just want to make sure that I'll spread the SRQ's equally.

The _any algorithm is simplistic, it spreads cvs for the system as a whole.
All devices, all callers. You're going to get some bad degenerate cases
as soon as you have multiple users of the SRQ facility.

So, you really want to have a more specialized comp_vector selector for
the SRQ facility; one that is careful to spread cvs per device, independent
of the global allocator, which is good enough for normal cases.

I think your tests perform well simply because there was no other contender
for comp_vectors on your test system.


>> If you want to guarantee that there is an SRQ for each comp_vector and a
>> comp_vector for each SRQ, stick with a CQ allocation API that enables
>> explicit selection of the comp_vector value, and cache that value in the
>> caller, not in the core data structures.
> 
> I'm Ok with that as well. This is exactly what we do in the nvmf/rdma but I wanted to stick also with the SRP target approach.
> 
> Bart,
> 
> Any objection to remove the call for ib_alloc_cq_any() from ib_srpt and use ib_alloc_cq() ?
> 
> 
>> 
>> 
>>> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
>>> ---
>>> drivers/infiniband/core/cq.c | 1 +
>>> include/rdma/ib_verbs.h      | 1 +
>>> 2 files changed, 2 insertions(+)
>>> 
>>> diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
>>> index 4f25b24..a7cbf52 100644
>>> --- a/drivers/infiniband/core/cq.c
>>> +++ b/drivers/infiniband/core/cq.c
>>> @@ -217,6 +217,7 @@ struct ib_cq *__ib_alloc_cq_user(struct ib_device *dev, void *private,
>>> 	cq->device = dev;
>>> 	cq->cq_context = private;
>>> 	cq->poll_ctx = poll_ctx;
>>> +	cq->comp_vector = comp_vector;
>>> 	atomic_set(&cq->usecnt, 0);
>>> 
>>> 	cq->wc = kmalloc_array(IB_POLL_BATCH, sizeof(*cq->wc), GFP_KERNEL);
>>> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
>>> index fc8207d..0d61772 100644
>>> --- a/include/rdma/ib_verbs.h
>>> +++ b/include/rdma/ib_verbs.h
>>> @@ -1558,6 +1558,7 @@ struct ib_cq {
>>> 	struct ib_device       *device;
>>> 	struct ib_ucq_object   *uobject;
>>> 	ib_comp_handler   	comp_handler;
>>> +	u32			comp_vector;
>>> 	void                  (*event_handler)(struct ib_event *, void *);
>>> 	void                   *cq_context;
>>> 	int               	cqe;
>>> -- 
>>> 1.8.3.1
>>> 
>> --
>> Chuck Lever
>> chucklever@gmail.com
>> 
>> 
>> 

--
Chuck Lever
chucklever@gmail.com




_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
