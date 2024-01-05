Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D2BC3DA6E
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Jan 2024 14:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EygD9BrtTMk3m1iWzpBiAzepmtQ8ztbZrT64ylgef6I=; b=x9jZ7QYpUbCL2ord5522RgSYeK
	9eF0sOD+mCPiLWm5ryyEtAlrAzzxrGdt8ajNSUnrBzrYnZmUNjywx1Em2IdfBR4SdQooTExgjabuq
	xSqC9MYGY/qKmp5E76EWwYVB8dLL8raDEn4+9+A2IoFCUnBgPkaJEHSgjCZLL06oGucky7Xe/vxZf
	8iFCPnyNcG8SJoLujheFjG7XTM7NNdNeStIHOkIWVb2usiWtr6OJqQ0nHN1JnWmjZOEAKTI2jMsxS
	Hv8nIHu3rebu7Lm1+l+X0Q65etfKoDBG0loWIQfWmJrKxYVtYf7SQaClw1eqkO9XX2+zdMvnCCSEi
	uXqEoAgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLlIh-00H4xa-0W;
	Fri, 05 Jan 2024 14:35:55 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLlId-00H4wj-2e
	for linux-nvme@lists.infradead.org;
	Fri, 05 Jan 2024 14:35:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8C00A61B33;
	Fri,  5 Jan 2024 14:35:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615E9C433C7;
	Fri,  5 Jan 2024 14:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704465350;
	bh=ka/VGduA+g6Ty/g3PfHmE31VPABF7sH+61l2Ri2RP4o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bI0he0u8LKjbDenWOurPtUTqPAzUOVcvLAiYQsGGX90tL1LB0LDVS7AldIDXfwAc5
	 7U3D8ZlRMEJuCNyxzjngrw38wEr5a/RJNRnDNjK/FiJUoYDwxYRFfCUUf/FWho3Gb9
	 byllmAj9Ne3+l4ZJew0i2E2Ys01gyRewS0x3jK/FOxrGdSyM8GdaDDFTXMyV6ogJok
	 xx59KLJkZGFiduu/qBxu5lpsDYmWpWAaoi50CRZZXKWzDwXK1pXFNC5PulrGfhmkR3
	 hbkCXdBCwNkGyNpL6hPhpw2prTOAJjXPpxhp06Vuo6kLceMRmEfXjF0bCXtxbgghQL
	 6HSg2DNX3ux7w==
Message-ID: <4101c577-91f9-40c2-9244-5a08dec4523a@kernel.org>
Date: Fri, 5 Jan 2024 15:35:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Removing GFP_NOFS
Content-Language: en-US
To: Viacheslav Dubeyko <slava@dubeyko.com>,
 Matthew Wilcox <willy@infradead.org>
Cc: lsf-pc@lists.linux-foundation.org,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>, linux-mm@kvack.org,
 linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org
References: <ZZcgXI46AinlcBDP@casper.infradead.org>
 <2EEB5F76-1D68-4B17-82B6-4A459D91E4BF@dubeyko.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <2EEB5F76-1D68-4B17-82B6-4A459D91E4BF@dubeyko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240105_063551_927582_D19DEDFB 
X-CRM114-Status: GOOD (  13.89  )
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

On 1/5/24 11:13, Viacheslav Dubeyko wrote:
> 
>> On Jan 5, 2024, at 12:17 AM, Matthew Wilcox <willy@infradead.org> wrote:
>> 
>> The memalloc_nofs APIs were introduced in May 2017, but we still have
>> over 1000 uses of GFP_NOFS in fs/ today (and 200 outside fs/, which is
>> really sad).  This session is for filesystem developers to talk about
>> what they need to do to fix up their own filesystem, or share stories
>> about how they made their filesystem better by adopting the new APIs.
>> 
> 
> Many file systems are still heavily using GFP_NOFS for kmalloc and
> kmem_cache_alloc family methods even if  memalloc_nofs_save() and
> memalloc_nofs_restore() pair is used too. But I can see that GFP_NOFS

Yes it should be enough to rely on memalloc_nofs_save() for
kmalloc/kmem_cache_alloc. The kmalloc layer doesnt't care about it, and once
it's run out of available slab folios and calls into the page allocator for
a new one, it evaluates the effect of memalloc_nofs_save() as expected.

> is used in radix_tree_preload(), bio_alloc(), posix_acl_clone(),
> sb_issue_zeroout, sb_issue_discard(), alloc_inode_sb(), blkdev_issue_zeroout(),
> blkdev_issue_secure_erase(), blkdev_zone_mgmt(), etc.
> 
> Would it be safe to switch on memalloc_nofs_save()/memalloc_nofs_restore() for
> all possible cases? Any potential issues or downsides?
> 
> Thanks,
> Slava.
> 
> 


