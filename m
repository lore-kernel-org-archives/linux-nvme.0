Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20BE1C25B75
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Jun 2024 15:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=maVyEw5qAJ9exIjeLqhPdHWdOFMAGD+uPnPP3rBtN3k=; b=fkPUxAJ369IdC6i0aF3R+EIMKD
	RHz7BcmxWpgBSb8A2zKafwD47loy3W7u04knPWI0761htkoZYpcJotaig8nhjsHk2EN11B51dVIOK
	xyNTWQyQn1JGukkN0f7pRHtdF7q4CRaIktocB1E6PmEbT/Ya7/maNg5JB6Hn4BDKZM4jiowzs8u0m
	0A91gUYsGLRv1LECoesz5nlXfPB+iFzplb5roW5L5xR/97HsN67r5v89jfbuUC+9dm4r0CIwSOW3V
	tNBtmXnDhWhkPbyUIa1S0VesujkceX44CbiuUvXtAZu2JVPJDo6b3jkphfdDf3xrSf/xzpv3lsgny
	SH83Hu+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFFCb-0000000AKov-2iWk;
	Thu, 06 Jun 2024 15:38:57 +0000
Received: from 008.lax.mailroute.net ([199.89.1.11])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFFCV-0000000AKoT-1zgi
	for linux-nvme@lists.infradead.org;
	Thu, 06 Jun 2024 15:38:53 +0000
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4Vw7lt02qZz6Cnk9X;
	Thu,  6 Jun 2024 15:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1717688322; x=1720280323; bh=maVyEw5qAJ9exIjeLqhPdHWd
	OFMAGD+uPnPP3rBtN3k=; b=4vcq+ZeJ2Tz8h7FvTWtkYye5ybBsQeKzH7LiB/h4
	RYBFunjMs54P5sT/WycS/guHMkgCJiCBlloYezqTZ7mr4FVcPxejYkxIFpmibeR4
	gNcRz8zWHzoBC0D/RNYq4CY9i+rCWkWp9HSvPl+aI/mGFgL3HEgyEyWWFY0FP7RT
	p4mDdyjMwbI/dAP+dOok6Euj9jCvqV3uWVKT/LC4nIMzdjWLziQV0jQRBqkROenn
	QBV7UL2/XVsMrQPtjqxzYzZ1APOdCg5KIjvDbKk6qP23vrMGcWMj4GMZHuvMCcMv
	TzcM9QPqn10RI6Vb3+k9KbjWoPv2Osa6VBpxuHAfjkFXBQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id w919G5Ov9keK; Thu,  6 Jun 2024 15:38:42 +0000 (UTC)
Received: from [172.20.24.239] (unknown [204.98.150.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4Vw7lg5CCkz6Cnk9W;
	Thu,  6 Jun 2024 15:38:39 +0000 (UTC)
Message-ID: <2cbf3443-de1c-4bfc-a249-afd1a4e13211@acm.org>
Date: Thu, 6 Jun 2024 09:38:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/12] block: remove the blk_integrity_profile structure
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Song Liu <song@kernel.org>, Yu Kuai <yukuai3@huawei.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-raid@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
References: <20240605063031.3286655-1-hch@lst.de>
 <20240605063031.3286655-5-hch@lst.de>
 <fee6338e-4aae-456c-90a3-228a19fae58a@acm.org> <20240606045048.GC8395@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240606045048.GC8395@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240606_083851_569515_31EBF744 
X-CRM114-Status: GOOD (  16.43  )
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

On 6/5/24 22:50, Christoph Hellwig wrote:
> On Wed, Jun 05, 2024 at 10:31:27AM -0600, Bart Van Assche wrote:
>>> +	case BLK_INTEGRITY_CSUM_CRC64:
>>> +		if (bi->flags & BLK_INTEGRITY_REF_TAG)
>>> +			return "EXT-DIF-TYPE1-CRC64";
>>> +		return "EXT-DIF-TYPE3-CRC64";
>>> +	default:
>>> +		return "nop";
>>> +	}
>>> +}
>>
>> Since bi->csum_type has an enumeration type, please leave out the "default:"
>> and move return "nop" outside the switch statement. This will make the
>> compiler issue a warning if a new enumeration label would be added without
>> updating the above switch statement. Otherwise this patch looks good to me.
> 
> For that to work you'd need to make csum_type the enum type and not an
> unsigned char, which would bloat the block limits.  You'd also need to
> keep the return "nop" where it is, but use the explicit case instead of
> the default.

Has it been considered to add __packed to the definition of enum
blk_integerity_checksum such that its size changes from 4 to 1 bytes and to
change "unsigned char csum_type" into  "enum blk_integerity csum_type"?

Thanks,

Bart.



