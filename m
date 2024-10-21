Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED375D0E6C5
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Oct 2024 17:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=11C38koXyZw+O5RI9Un69eSq783zFusoRbV176crTNM=; b=Q5J2atxEu8hh3iGaTD2bir3yjU
	swFnWvjJ4Nknk6ZS2o9FD0AyInldh+MMr2g/f7iGR3H1ID5fpjSA64ptIA05TCf5wZRTH2/ft8Kxr
	6nGF1apLYRTCJJ4QXpSkuYG158GQRdBzmv3bNXoHh5ukbj/x2Yu19t8sF/Z7pVxwsq7lEgpG0NQwx
	Y7AzneURh6XRLriXfXQVB90RXEVe4a18U9bFeFQ25gTkkKlRd4MznKitE6+hMCyLdFf0TPKepCG8F
	uYomAqPeZAcHn4LlQqIzebZy+RQPHumiROLrm6+tFnSAOkJ108zBGgn0x7p7IdrWx3jZQNSX2CgIO
	JFv9CNSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2w35-00000008664-47Yg;
	Mon, 21 Oct 2024 17:18:31 +0000
Received: from 008.lax.mailroute.net ([199.89.1.11])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2vvF-000000084fS-1MHv
	for linux-nvme@lists.infradead.org;
	Mon, 21 Oct 2024 17:10:27 +0000
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4XXMJ41wrsz6ClY9J;
	Mon, 21 Oct 2024 17:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1729530603; x=1732122604; bh=11C38koXyZw+O5RI9Un69eSq
	783zFusoRbV176crTNM=; b=RhAveDcGf9i/kd6r+Qf6jBAL2nhRkd1q38TQRAZL
	sLyROvHW+CHEEorq3Owj3v3QQ2Ljj/5a0mY7sVHh4UWQ7/105yv9CmUJrVxenPwg
	zcsFe/W28Hdalgkdns3wXK4Bk2mc25WlPB/1UtGIzg8v/0EZaTezWmdUtpKeMMHS
	wlk6Vmk9SsFbVCeYTXY+CpUEr4sSoVMaRmTD0xgMivlu+TribTi8jAlGAnZGeYvF
	doM2jJeh8clM8zY6ZpGy7C4QyR+AXIKue1g0kYa355LsmFu9LsbMMraSw8TSVejg
	AK47DVWvnEndp861BXF8oRpOQ4SGGfs04R+oi2Gmb7POzw==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id R0H-YYTLMGMS; Mon, 21 Oct 2024 17:10:03 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4XXMHr68rSz6ClY9G;
	Mon, 21 Oct 2024 17:10:00 +0000 (UTC)
Message-ID: <a87c67aa-b1fe-48dc-9b5a-bc6732931298@acm.org>
Date: Mon, 21 Oct 2024 10:09:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv8 1/6] block, fs: restore kiocb based write hint
 processing
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@kernel.dk, io-uring@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, joshi.k@samsung.com, javier.gonz@samsung.com,
 Nitesh Shetty <nj.shetty@samsung.com>, Hannes Reinecke <hare@suse.de>
References: <20241017160937.2283225-1-kbusch@meta.com>
 <20241017160937.2283225-2-kbusch@meta.com> <20241018055032.GB20262@lst.de>
 <ZxZ3o_HzN8HN6QPK@kbusch-mbp>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ZxZ3o_HzN8HN6QPK@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241021_101025_419788_CB514F60 
X-CRM114-Status: GOOD (  17.09  )
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

On 10/21/24 8:47 AM, Keith Busch wrote:
> On Fri, Oct 18, 2024 at 07:50:32AM +0200, Christoph Hellwig wrote:
>> On Thu, Oct 17, 2024 at 09:09:32AM -0700, Keith Busch wrote:
>>>   {
>>>   	*kiocb = (struct kiocb) {
>>>   		.ki_filp = filp,
>>>   		.ki_flags = filp->f_iocb_flags,
>>>   		.ki_ioprio = get_current_ioprio(),
>>> +		.ki_write_hint = file_write_hint(filp),
>>
>> And we'll need to distinguish between the per-inode and per file
>> hint.  I.e. don't blindly initialize ki_write_hint to the per-inode
>> one here, but make that conditional in the file operation.
> 
> Maybe someone wants to do direct-io with partions where each partition
> has a different default "hint" when not provided a per-io hint? I don't
> know of such a case, but it doesn't sound terrible. In any case, I feel
> if you're directing writes through these interfaces, you get to keep all
> the pieces: user space controls policy, kernel just provides the
> mechanisms to do it.

Is it important to support partitions on top of FDP namespaces? We could
follow the example of zoned block devices and not support partitions on
top of FDP devices. From block/core.c, function add_partition():

	/*
	 * Partitions are not supported on zoned block devices that are used as
	 * such.
	 */
	if (bdev_is_zoned(disk->part0)) {
		pr_warn("%s: partitions not supported on host managed zoned block 
device\n",
			disk->disk_name);
		return ERR_PTR(-ENXIO);
	}

Thanks,

Bart.

