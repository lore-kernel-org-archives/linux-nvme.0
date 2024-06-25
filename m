Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 721EFC30653
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Jun 2024 21:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8lhzXpxVFCFxr89KtUFo6fb7+KsEvzH28TW/QTLrLI0=; b=k9480vARLB+6DNn6emRChBieBM
	4FIRmu9itqQ76pwVfFjoWMX702oP1RdiSMBqp3+4VNeZivy8Zzcijcng4xeRL4EcMq5HKigCTXq/E
	DInpk1W+hOF9FrHVoPkKd5DfzYWRNDmeuD5g6NTDQLEzyCRRWXjV/0sxAfJqYEh/2v36BMD2AFL3z
	IJEj/499QAGU7JPqTyPmZ6ZeyYKrGLDKr/+d0Vzsm0ws5t3hLPqiNr/clzeFjydo4FmEQrE2H94Rn
	2zRDEmrEib461jLf3xqZqWrJ8XICmAYaJ7VUrh600g9Anqvx+ysHpLUYwmVkdnh5KxEuwaQF3NRXr
	YJ6+mudA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMDYa-00000004XJe-3M2C;
	Tue, 25 Jun 2024 21:18:28 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMDYY-00000004XI8-1Cv7
	for linux-nvme@lists.infradead.org;
	Tue, 25 Jun 2024 21:18:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 816FF61792;
	Tue, 25 Jun 2024 21:18:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91760C32781;
	Tue, 25 Jun 2024 21:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719350305;
	bh=KPOiqngDeZl30NH1XxIF5gTrFiubBnjvbTlQRWh4xYg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=t0hfLTOHb4/Mwqe3tFIXULykvTPoVb2REU4j7462zAQty0DovUsgeBXIqkLjqTLCw
	 HAGGft70l/PDuzHefiOHehrFlRKSrR2du/bLm5kK/kbDVcfh5m4xuWI0nWWxN56Lse
	 xoUzU8Gzwq8KVXsiWU7/X+KQsUpd/zU0nzfWUbMkzVLwAg5YNaPWJvF4vmbMa+Jo//
	 ejLlCdHGRNNyLNU47GweDERCIXIrzxqnH6i4N7xmQwTBfwy2yhYXdAO9k3GDtb+dyH
	 MVVxfnSkqkn+xi+mkIsrRuWCPS7HdZdlkTRY04vfu/n9mTzh99hGbiMKV9MjDu+sWU
	 wHnnw0LQ19EWA==
Message-ID: <05c7c08d-f512-4727-ae3c-aba6e8f2973f@kernel.org>
Date: Wed, 26 Jun 2024 06:18:18 +0900
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
 <de54c406-9270-4145-ab96-5fc3dd51765e@kernel.org>
 <b5d93f2c-29fc-4ee4-9936-0f134abc8063@acm.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <b5d93f2c-29fc-4ee4-9936-0f134abc8063@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240625_141826_491324_D99B78AA 
X-CRM114-Status: GOOD (  16.40  )
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

On 6/26/24 03:18, Bart Van Assche wrote:
> On 6/24/24 2:55 PM, Damien Le Moal wrote:
>> I am still a little confused as to why we need 2 BIOs, one for src and one for
>> dst... Is it because of the overly complex scsi extended copy support ?
>>
>> Given that the main use case is copy offload for data within the same device,
>> using a single BIO which somehow can carry a list of LBA sources and a single
>> destination LBA would be far simpler and perfectly matching nvme simple copy and
>> ATA write gathered. And I think that this would also match the simplest case for
>> scsi extended copy as well.
> 
> Hi Damien,
> 
> What are the implications for the device mapper code if the copy source
> and destination LBAs are encoded in the bio payload instead of in
> bio->bi_sector?

DM can deal with "abnormal" BIOs on its own. There is code for that.
See is_abnormal_io() and __process_abnormal_io(). Sure, that will need more code
compared to a bio sector+size based simple split, but I do not think it is a big
deal given the potential benefits of the offloading.

-- 
Damien Le Moal
Western Digital Research


