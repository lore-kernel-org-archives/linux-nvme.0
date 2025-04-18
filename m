Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D4AC369AB
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Apr 2025 10:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BThyBUVi69nQczKOrXf+2DGyB5ofV0HuW20XNDwPWLo=; b=ysgNvrER1DiRih3PWdi2PsbNWt
	cbrmmciQCRrJX77QQJILv4Y/c4WfPteAMpXyLdUl5N4JAJ7phjqbWiDeUxyWdFJw+X99NEfEmq9Wt
	XsVtc4U1Atr5OVlPXpAaJfgkG4/gQV/Fz5DzQeZyWg+lwivPr53gaO6uDJNqspevkKlNLzmQhkrLX
	CbKPiUKltQt2G4I3edVCMeMRKosV5UdtbtGVuTGTAYKgM7pN2awRHKibXtczKoF3v/GqPbaXMCj+8
	2TA5MHmReNbbdwucWTloGyTS6+KNH/1vk6ON1kNITu/69umIb+D0mLkUA/ojTTZL3wHfo0stEymd5
	uvfHF73A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5isK-0000000FqzW-3Mjl;
	Fri, 18 Apr 2025 10:23:12 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5isJ-0000000FqxA-05qY
	for linux-nvme@lists.infradead.org;
	Fri, 18 Apr 2025 10:23:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id CA8A4A4B30B;
	Fri, 18 Apr 2025 10:17:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2BAEC4CEE2;
	Fri, 18 Apr 2025 10:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744971789;
	bh=qQmApRLfNFtMFt8N8RV6ge+DooDi7AWtQxPYr8Nsjo8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AD6zzTbJkwmGuA9TxCDNzuZMV5weZlpx5THuHECOGQ/BRqd3iBzCKFwJQt9KuCpkL
	 3AMKj4AFOwH91rQoHgeHhI9N8Pp0nCb2LTOP0aoxxR6paDDSxVXDn1kgKjHwzpi/4d
	 L7QBr1MoC13i0d7AN5rbiffEvpbVuJ19otYkzQlmtRG5yELxwiTEX6uQOMQmKftblu
	 x3zen0J5BPGBwQ+2OIejCLcQ23YpQo91YE5ujZeUTxIm6HlQ1XGJHYLjqy0kDRCfQM
	 h8Y1YYIVWjYkrME7EyHgw7enQ+/+L12npmnancAnTSy3n+1B3vKWO/mxyCpQEvfasN
	 6mi1baq6BsR1Q==
Message-ID: <9f8fdcc0-53ae-4255-b221-b4e787320c44@kernel.org>
Date: Fri, 18 Apr 2025 19:23:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] nvmet: Make blksize_shift configurable
To: Richard Weinberger <richard@sigma-star.at>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>, kch@nvidia.com, sagi@grimberg.me,
 hch@lst.de, upstream+nvme@sigma-star.at
References: <20250418090834.2755289-1-richard@nod.at>
 <0e61c6e9-10bc-4272-b446-31e0d67547ce@kernel.org> <8418057.aG60p0z9Xu@anvil>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <8418057.aG60p0z9Xu@anvil>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250418_032311_132658_F31004A9 
X-CRM114-Status: GOOD (  15.17  )
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

On 4/18/25 18:56, Richard Weinberger wrote:
> On Freitag, 18. April 2025 11:37 'Damien Le Moal' via upstream wrote:
>>> +	if (!ns->blksize_shift)
>>> +		ns->blksize_shift = blksize_bits(bdev_logical_block_size(ns->bdev));
>>
>> If the user set logical block size is smaller than the block dev logical block
>> size, this is not going to work... No ? Am I missing something ?
> 
> Likely, yes.
> TBH, I'm not sure whether it makes actually sense for the bdev case to make
> blksize_shift configurable.

Probably not... I do understand the value for the file case though.

> The case I see most benefit is the backing file case.
> 
>>> +	if (!ns->blksize_shift) {
>>> +		/*
>>> +		 * i_blkbits can be greater than the universally accepted
>>> +		 * upper bound, so make sure we export a sane namespace
>>> +		 * lba_shift.
>>> +		 */
>>> +		ns->blksize_shift = min_t(u8,
>>> +				file_inode(ns->file)->i_blkbits, 12);
>>
>> This will work for any block size, regardless of the FS block size, but only if
>> ns->buffered_io is true. Doesn't this require some more checks with regards to
>> O_DIRECT (!ns->buffered_io case) ?
> 
> Good catch. I'll add a check.

And by the way, you need to check for STATX_DIOALIGN since some FS (e.g. xfs)
can handle direct IOs that are not aligned to the FS block size. See the recent
changes in drivers/block/loop.c to improve direct IO handling, specifically, the
function loop_query_min_dio_size().

-- 
Damien Le Moal
Western Digital Research

