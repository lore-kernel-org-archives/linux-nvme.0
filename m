Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC99E7717D
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Dec 2024 23:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rXD4bpZuxE3C3jn6xQbv3T0AZwRd7oa/4CdQsdzUBPQ=; b=evzKDPMIZEmgX9SK8XgxCRWrZ2
	odF4hPdRqg+/bk2O9ZsxfDURBWTf4pmCREf948gM4C33zkpZLqrq5gc5qubOjQqaV7yx7ygicuvJY
	+Dp8i8ttQHgNhM+oYfIlALRoufrNECHjNGXUUYoYJuA2E6nYY5LFNjfvT1ZZ39w2MZvmgyimPuSE1
	DapAr/8svKULGo5PN9acNxA5BV8AqrnO1u3BvT1w1tZQYTrukk9k08Xl/UkW0iij+mkpcpxkfJa1n
	CKMeXzHSRFvH2mdq4TLkPkuyuguX/IZq3gnrbJj4B3RAzvPVpXXTA9Bnb8PTphBYvcBAwYM/ZDC9Q
	L7/SS7kA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKn0N-00000009Xaz-2QLc;
	Mon, 09 Dec 2024 23:17:31 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKmwr-00000009WxM-2MoC
	for linux-nvme@lists.infradead.org;
	Mon, 09 Dec 2024 23:13:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 363D2A41A29;
	Mon,  9 Dec 2024 23:12:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FEA0C4CED1;
	Mon,  9 Dec 2024 23:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733786032;
	bh=FonpP2yRbU9dV17o69mNsSGdBW1hv2v1dQRplHQBs7E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Zj7sUsGmeF0PldVUJjr8d64+L196sZukFtk1CaP3Bbi9uYGRg8k6u7TtN7hmir8Sy
	 ESkHYO/SWTnXzwqor6irRTep3qhU/MTt1OseRzkys656TTXUxwbacdQp/UNpqko05g
	 BQ3PTyCSP4EI2+4tXnVn4z+IbF8LS8VLxejnan/0HH7ITKTyi52njQwMZ8wslospjT
	 b9RIwVPg25KFvUM5TieFbcVu4KofJsjIBnUlyWcdnVj5xqDEuclP3fu4k57dOEFQDL
	 D6bBTgxS7QXp6mZQDB4juTWOS3O9actt82jcih1S8vnUD68oB2gPVldHMaTwtU+FNy
	 DghWt5Mo3RvFQ==
Message-ID: <2287bbe4-1aad-419b-89a9-7c49fdc584ba@kernel.org>
Date: Tue, 10 Dec 2024 08:13:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv10 0/9] write hints with nvme fdp, scsi streams
To: Bart Van Assche <bvanassche@acm.org>,
 Nitesh Shetty <nj.shetty@samsung.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Javier Gonzalez <javier.gonz@samsung.com>,
 Matthew Wilcox <willy@infradead.org>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "joshi.k@samsung.com" <joshi.k@samsung.com>
References: <d7b7a759dd9a45a7845e95e693ec29d7@CAMSVWEXC02.scsc.local>
 <2b5a365a-215a-48de-acb1-b846a4f24680@acm.org>
 <20241111093154.zbsp42gfiv2enb5a@ArmHalley.local>
 <a7ebd158-692c-494c-8cc0-a82f9adf4db0@acm.org>
 <20241112135233.2iwgwe443rnuivyb@ubuntu>
 <yq1ed38roc9.fsf@ca-mkp.ca.oracle.com>
 <9d61a62f-6d95-4588-bcd8-de4433a9c1bb@acm.org>
 <yq1plmhv3ah.fsf@ca-mkp.ca.oracle.com>
 <8ef1ec5b-4b39-46db-a4ed-abf88cbba2cd@acm.org>
 <yq1jzcov5am.fsf@ca-mkp.ca.oracle.com>
 <CGME20241205081138epcas5p2a47090e70c3cf19e562f63cd9fc495d1@epcas5p2.samsung.com>
 <20241205080342.7gccjmyqydt2hb7z@ubuntu>
 <c639f90f-bdd1-4808-aeb7-e9b667822413@acm.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <c639f90f-bdd1-4808-aeb7-e9b667822413@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241209_151353_728615_72AA2CE3 
X-CRM114-Status: GOOD (  23.82  )
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

On 12/10/24 07:13, Bart Van Assche wrote:
> On 12/5/24 12:03 AM, Nitesh Shetty wrote:
>> But where do we store the read sector info before sending write.
>> I see 2 approaches here,
>> 1. Should it be part of a payload along with write ?
>>      We did something similar in previous series which was not liked
>>      by Christoph and Bart.
>> 2. Or driver should store it as part of an internal list inside
>> namespace/ctrl data structure ?
>>      As Bart pointed out, here we might need to send one more fail
>>      request later if copy_write fails to land in same driver.
> 
> Hi Nitesh,
> 
> Consider the following example: dm-linear is used to concatenate two
> block devices. An NVMe device (LBA 0..999) and a SCSI device (LBA
> 1000..1999). Suppose that a copy operation is submitted to the dm-linear
> device to copy LBAs 1..998 to LBAs 2..1998. If the copy operation is
> submitted as two separate operations (REQ_OP_COPY_SRC and
> REQ_OP_COPY_DST) then the NVMe device will receive the REQ_OP_COPY_SRC
> operation and the SCSI device will receive the REQ_OP_COPY_DST
> operation. The NVMe and SCSI device drivers should fail the copy 
> operations after a timeout because they only received half of the copy
> operation. After the timeout the block layer core can switch from
> offloading to emulating a copy operation. Waiting for a timeout is
> necessary because requests may be reordered.
> 
> I think this is a strong argument in favor of representing copy
> operations as a single operation. This will allow stacking drivers
> as dm-linear to deal in an elegant way with copy offload requests
> where source and destination LBA ranges map onto different block
> devices and potentially different block drivers.

Why ? As long as REQ_OP_COPY_SRC carries both source and destination
information, DM can trivially detect that the copy is not within a single device
and either return ENOTSUPP or switch to using a regular read+write operations
using block layer helpers. Or the block layer can fallback to that emulation
itself if it gets a ENOTSUPP from the device.

I am not sure how a REQ_OP_COPY_SRC BIO definition would look like. Ideally, we
want to be able to describe several source LBA ranges with it and for the above
issue also have the destination LBA range as well. If we can do that in a nice
way, I do not see the need for switching back to a single BIO, though we could
too I guess. From what Martin said for scsi token-based copy, it seems that 2
operations is easier. Knowing how the scsi stack works, I can see that too.


-- 
Damien Le Moal
Western Digital Research

