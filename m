Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A643C2BD09
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jun 2024 21:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ntoRXSEN9SZCphIaQ2aupyFZT1WapB0YDpMf+o5RoFQ=; b=pBI4Lmtxz/F9QY/TAjfoU9ME9u
	mduYfFCKQOtnna8ur4YjAzezxE5IjNQosmeYUUf7MtfVoJJxSepe9pzdSVeKdQZ6nKRtsztw5VlkM
	lTQUkibthTtPUwPV2vtqTQvnOrNiZTDPjmPEz9H7iE+OxoO7cfa2EBYC4RdvRoPil4p0OSLWid/uG
	Excr8KC0yrt90ys5v+qoBolNXSjoTU1hbvDsfLH3NPVJmqFk9Y33Ly/PmI0tlFxibjUgtjl50jmma
	EqyItbx7Zyf3CWqErhuwTfVBvnbvHljYJI+fHl2zBucdl/2LRHO6J9YMcuIA/sDUipFgeOvJ6JH7r
	la0Ufa0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLrf0-00000000l8D-1pLg;
	Mon, 24 Jun 2024 21:55:38 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLrey-00000000l7n-0dfh
	for linux-nvme@lists.infradead.org;
	Mon, 24 Jun 2024 21:55:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E6FFB61178;
	Mon, 24 Jun 2024 21:55:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11C22C2BBFC;
	Mon, 24 Jun 2024 21:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719266134;
	bh=ssw0CE3X6rtJAiVWYNCh9l8N9P1eQeBKDrj05miOGGg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h5e5otElt6qUnWFncwXReRgalS93n3GWdHfZI61HaUNM702vEiLU2OL3hRtmeZ7pW
	 ohhQ3/5IVk0g8hUUHWlUqfFBEMPtZPqq9cQTQXiwSXMSd207XtxM9X16zMkpmCwa1h
	 P7loUD40U+W2bSN567WlBElAPghrvm140h9uxIRABpJMhzaJxKaale7wIivArgxwds
	 17sJnrpbor04AXrsi4bw/9WuT16U52EHU+4DHQipBM/gHcQC+G9CN1yr9Xg4UveXWD
	 yQLKSBhNO7cmx1X2iEik5+dutOQ4SzhHG4PwsLAFryjtPCKpTROi/LdExZix+Cs8Gm
	 97NMXmBhfGsSg==
Message-ID: <de54c406-9270-4145-ab96-5fc3dd51765e@kernel.org>
Date: Tue, 25 Jun 2024 06:55:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 02/12] Add infrastructure for copy offload in block
 and request layer.
To: Bart Van Assche <bvanassche@acm.org>,
 Nitesh Shetty <nj.shetty@samsung.com>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 martin.petersen@oracle.com, david@fromorbit.com, hare@suse.de,
 damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com, joshi.k@samsung.com,
 nitheshshetty@gmail.com, gost.dev@samsung.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
References: <eda6c198-3a29-4da4-94db-305cfe28d3d6@acm.org>
 <9f1ec1c1-e1b8-48ac-b7ff-8efb806a1bc8@kernel.org>
 <a866d5b5-5b01-44a2-9ccb-63bf30aa8a51@acm.org>
 <665850bd.050a0220.a5e6b.5b72SMTPIN_ADDED_BROKEN@mx.google.com>
 <abe8c209-d452-4fb5-90eb-f77b5ec1a2dc@acm.org> <20240601055931.GB5772@lst.de>
 <d7ae00c8-c038-4bed-937e-222251bc627a@acm.org>
 <20240604044042.GA29094@lst.de>
 <4ffad358-a3e6-4a88-9a40-b7e5d05aa53c@acm.org>
 <20240605082028.GC18688@lst.de>
 <CGME20240624105121epcas5p3a5a8c73bd5ef19c02e922e5829a4dff0@epcas5p3.samsung.com>
 <6679526f.170a0220.9ffd.aefaSMTPIN_ADDED_BROKEN@mx.google.com>
 <4ea90738-afd1-486c-a9a9-f7e2775298ff@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <4ea90738-afd1-486c-a9a9-f7e2775298ff@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240624_145536_332718_A8A1CB65 
X-CRM114-Status: GOOD (  26.27  )
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

On 2024/06/25 1:25, Bart Van Assche wrote:
> On 6/24/24 3:44 AM, Nitesh Shetty wrote:
>> For reference, I have listed the approaches we have taken in the past.
>>
>> a. Token/payload based approach:
>> 1. Here we allocate a buffer/payload.
>> 2. First source BIO is sent along with the buffer.
>> 3. Once the buffer reaches driver, it is filled with the source LBA
>> and length and namespace info. And the request is completed.
>> 4. Then destination BIO is sent with same buffer.
>> 5. Once the buffer reaches driver, it retrieves the source information from
>> the BIO and forms a copy command and sends it down to device.
>>
>> We received feedback that putting anything inside payload which is not
>> data, is not a good idea[1].
> 
> A token-based approach (pairing copy_src and copy_dst based on a token)
> is completely different from a payload-based approach (copy offload
> parameters stored in the bio payload). From [1] (I agree with what has
> been quoted): "In general every time we tried to come up with a request
> payload that is not just data passed to the device it has been a
> nightmare." [ ... ] "The only thing we'd need is a sequence number / idr
> / etc to find an input and output side match up, as long as we
> stick to the proper namespace scope."
> 
>> c. List/ctx based approach:
>> A new member is added to bio, bio_copy_ctx, which will a union with
>> bi_integrity. Idea is once a copy bio reaches blk_mq_submit_bio, it will
>> add the bio to this list.
>> 1. Send the destination BIO, once this reaches blk_mq_submit_bio, this
>> will add the destination BIO to the list inside bi_copy_ctx and return
>> without forming any request.
>> 2. Send source BIO, once this reaches blk_mq_submit_bio, this will
>> retrieve the destination BIO from bi_copy_ctx and form a request with
>> destination BIO and source BIO. After this request will be sent to
>> driver.
>>
>> This work is still in POC phase[2]. But this approach makes lifetime
>> management of BIO complicated, especially during failure cases.
> 
> Associating src and dst operations by embedding a pointer to a third
> data structure in struct bio is an implementation choice and is not the
> only possibility for assocating src and dst operations. Hence, the
> bio lifetime complexity mentioned above is not inherent to the list
> based approach but is a result of the implementation choice made for
> associating src and dst operations.
> 
> Has it been considered to combine the list-based approach for managing
> unpaired copy operations with the token based approach for pairing copy
> src and copy dst operations?

I am still a little confused as to why we need 2 BIOs, one for src and one for
dst... Is it because of the overly complex scsi extended copy support ?

Given that the main use case is copy offload for data within the same device,
using a single BIO which somehow can carry a list of LBA sources and a single
destination LBA would be far simpler and perfectly matching nvme simple copy and
ATA write gathered. And I think that this would also match the simplest case for
scsi extended copy as well.

-- 
Damien Le Moal
Western Digital Research


