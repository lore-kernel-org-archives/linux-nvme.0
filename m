Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE1DC8302F
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Jul 2025 07:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yOAZJ/CMBkpxF+H13QQDPD8xZr8IWbTYQKCX5QUUYzk=; b=405nkeZ3orSKCuNMCcyTcpIsAu
	PF85JaZokilyGseNgBqRVhZ9SPiTkdywn6BT3veU43tzzooFlHPcrZ7e41IOdk1r6AhcpdrK1Ccpr
	rYd9HFBn6LXBlQLVqzRuaePU7ea5N/wwtpKfYS9++/stujqOtpDem/zq0MZmMveaXuw2ohlxsgND5
	Jvfxw4zPABjpw/jtuBRKu5R4g6MRvC8rJCVCFzEvCaspTfn2t+mEzSSkUA9PH1aqPoke+l1v95ktk
	WxjvgoEYi5AZ83WGaCPTDlpKtcJjec4Ease/ia3ZHYLG5YKGzlj76AM4tGM8hkaVKQyUcoYboplpi
	A2+u3TZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWVnR-00000004KOe-0W3a;
	Tue, 01 Jul 2025 07:52:53 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWVW3-00000004Har-2eBm
	for linux-nvme@bombadil.infradead.org;
	Tue, 01 Jul 2025 07:34:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=yOAZJ/CMBkpxF+H13QQDPD8xZr8IWbTYQKCX5QUUYzk=; b=jEx+3bC6kOJ9b+jkpTREOyza62
	3g/xypOpqYt2Ofge7jj8FvBY3cS0z+QyKK9hdq13m22M6JQxixzZyQ7FGwROMwe4FP7olEOvIHdWx
	Wf+Ikadxg9dOwgP1CwYbwEJ+3SoDqumwUDz2QKwjI3odflC+pZOVUVzf/F5zBAlm4d5CoOwqv68w3
	IGsk97Tkrh74pl2HN1oK+s7IzdXkvUjYtigNo/vGvXCp4cI0y0hLIuKJ8rvAHmhBFdFrsW3bdqR8F
	S+1v/1X0Kg9xP+B9AL55v7iTt8pkn02nLzL0+/wvN0rwnBpQMn4UDkCTMRETu4ZVombGzajfdMTb9
	Bw4IWqog==;
Received: from nyc.source.kernel.org ([147.75.193.91])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWVW0-00000006xOq-1k8g
	for linux-nvme@lists.infradead.org;
	Tue, 01 Jul 2025 07:34:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 628BBA4D4A1;
	Tue,  1 Jul 2025 07:34:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC704C4CEEB;
	Tue,  1 Jul 2025 07:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751355288;
	bh=CnJ7g+laoyIJRX+S6qFT+yJN9TWzFT3yscMkhR4S4tQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eyRHRfbM/kmwdg3sev8ghbqT2/VaeYb950pDlPGq7nwjlY54SgWTdgCikexOvw66Q
	 wBr2e+atV8YuMXdJ1YvhmcJOuwL6rnhNY4rN4HUqXfat9urVOm4zXNA4gFPIaTrsx6
	 VPA/Pz8B/UV6Ub6DHEvO3Y1uc7NTm/PfjevygLBhreivsim36vZ+txAMnyZ58jwXIM
	 xlIh4R3Gvh8DXTXDOFi01t7gV/ADyw76lrKo2F26eNwGTw5Eyfn2a0mSjTapgGmxTq
	 4CoiXc/GKJ/Pj6b9EBZdKEQ9n+WUsP00t4baj0csl1TPOTIfeuw8HBis/SWegq+iUX
	 3ljrdYLLwe6qg==
Message-ID: <7c5b852d-4f29-41c7-a171-c0069771a5e0@kernel.org>
Date: Tue, 1 Jul 2025 16:32:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvmet: Make blksize_shift configurable
To: Richard Weinberger <richard@sigma-star.at>,
 Richard Weinberger <richard@nod.at>, linux-nvme@lists.infradead.org,
 upstream@sigma-star.at
Cc: linux-kernel@vger.kernel.org, kch@nvidia.com, sagi@grimberg.me,
 hch@lst.de, upstream+nvme@sigma-star.at
References: <20250630191341.1263000-1-richard@nod.at>
 <132c1bdf-e100-4e3a-883f-27f9e9b78020@kernel.org>
 <2920993.eCsiYhmirv@nailgun>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <2920993.eCsiYhmirv@nailgun>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250701_083452_858447_7BC16A85 
X-CRM114-Status: GOOD (  30.56  )
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

On 7/1/25 4:09 PM, Richard Weinberger wrote:
> On Dienstag, 1. Juli 2025 02:34 'Damien Le Moal' via upstream wrote:
>> On 7/1/25 4:13 AM, Richard Weinberger wrote:
>>> Currently, the block size is automatically configured, and for
>>> file-backed namespaces it is likely to be 4K.
>>> While this is a reasonable default for modern storage, it can
>>> cause confusion if someone wants to export a pre-created disk image
>>> that uses a 512-byte block size.
>>> As a result, partition parsing will fail.
>>>
>>> So, just like we already do for the loop block device, let the user
>>> configure the block size if they know better.
>>
>> Hmm... That fine with me but this explanation does not match what the patch
>> does: you allow configuring the block size bit shift, not the size. That is not
>> super user friendly :)
>>
>> Even if internally you use the block size bit shift, I think it would be better
>> if the user facing interface is the block size as that is much easier to
>> manipulate without having to remember the exponent for powers of 2 values :)
> 
> The initial intention of this patch was exposing the blksize_shift property.
> If we want to expose this as more user friendly, I'm fine with it.
> Maybe "minimum_io_size"?

That likely will be confusing with the existing device limit io_min. I think
block_size is clear.

>> Nit: to avoid the indented if, may be write this like this: ?
>>
>> 	if (!ns->blksize_shift)
>> 		ns->blksize_shift = bdev_blksize_shift;
>>
>> 	if (ns->blksize_shift < bdev_blksize_shift) {
>> 		pr_err("Configured blksize needs to be at least %u for device %s\n",
>> 			bdev_logical_block_size(ns->bdev),
>> 			ns->device_path);
>> 		return -EINVAL;
>> 	}
> 
> It's a matter of taste, but yes...

Absolutely :)

> 
>> Also, if the backend is an HDD, do we want to allow the user to configure a
>> block size that is less than the *physical* block size ? Performance will
>> suffer on regular HDDs and writes may fail with SMR HDDs.
> 
> I'm not sure whether it's worth putting more smartness into this logic.

This may be nice to avoid users shooting themselves in the foot with a bad
setup and us having to deal with bad performance complaints...
If we do not do anything special, we will be stuck with it as a more
restrictive setup later may break some (bad) user setups. That is why I raised
the point :)

>>>  	ns->pi_type = 0;
>>>  	ns->metadata_size = 0;
>>> diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
>>> index 2d068439b129c..a4066b5a1dc97 100644
>>> --- a/drivers/nvme/target/io-cmd-file.c
>>> +++ b/drivers/nvme/target/io-cmd-file.c
>>> @@ -49,12 +49,28 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
>>>  
>>>  	nvmet_file_ns_revalidate(ns);
>>>  
>>> -	/*
>>> -	 * i_blkbits can be greater than the universally accepted upper bound,
>>> -	 * so make sure we export a sane namespace lba_shift.
>>> -	 */
>>> -	ns->blksize_shift = min_t(u8,
>>> -			file_inode(ns->file)->i_blkbits, 12);
>>> +	if (ns->blksize_shift) {
>>> +		if (!ns->buffered_io) {
>>> +			struct block_device *sb_bdev = ns->file->f_mapping->host->i_sb->s_bdev;
>>> +			struct kstat st;
>>> +
>>> +			if (!vfs_getattr(&ns->file->f_path, &st, STATX_DIOALIGN, 0) &&
>>> +			    (st.result_mask & STATX_DIOALIGN) &&
>>> +			    (1 << ns->blksize_shift) < st.dio_offset_align)
>>> +				return -EINVAL;
>>> +
>>> +			if (sb_bdev && (1 << ns->blksize_shift < bdev_logical_block_size(sb_bdev)))
>>> +				return -EINVAL;
>>
>> I am confused... This is going to check both... But if you got STATX_DIOALIGN
>> and it is OK, you do not need (and probably should not) do the second if, no ?
> 
> I was not sure about that.
> Is it guaranteed that STATX_DIOALIGN returns something sane?

If it is defined by the FS, yes. But it may not be defined, so in that case,
you have to use the fallback of the bdev block size.


-- 
Damien Le Moal
Western Digital Research

