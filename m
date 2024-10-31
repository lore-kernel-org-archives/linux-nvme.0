Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C528FE67485
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2024 20:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZlDdWjIwcF/8pUBLz0z5LqqxMf6+H+v/mtLue+A0j/A=; b=40oyRyX4P72tGfJ8E2TlpDg4f2
	Cbd6mXjWaryztwwKVguHQ3tbLEH8pLm+rM/E1ujU9Ev/6GeCnrjkjjSscWg6pRv3y4gDC9MK6LqoQ
	80XPKrWpGVOqwIajrvDlcs3G2MpWkP9GFKXXqB8hOSk7WVbmmcCNYTuspQluj1MGuBwE75fyiUBu5
	x2U3zbzW6V62ZQ8zzI6A9gc0reXIvPlJHS62L5UTqDheJMTcRLV3sOrXaSmHoBNpEPiZiq2fdERl9
	LYblA0JkC0+KVTJot1uktxAPguDVMBdzD/EravAN9jNXey4c+ZSzcyPlKgk2v5xTqSfg6F3lnDtIX
	/k/QChdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6cFx-00000004qyq-3Uab;
	Thu, 31 Oct 2024 20:59:01 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6cFv-00000004qyL-0SbF
	for linux-nvme@lists.infradead.org;
	Thu, 31 Oct 2024 20:59:00 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XfbvQ5NP0zlgMVV;
	Thu, 31 Oct 2024 20:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1730408329; x=1733000330; bh=ZlDdWjIwcF/8pUBLz0z5Lqqx
	Mf6+H+v/mtLue+A0j/A=; b=KQItnnFo7mG7FWlSn3t8mhT5t9clJf67jiW5lKnA
	ZppzqrwKZgP8zNGovmxHxm4CgKw1QIgMkZL2m/uWgA9EFnGppkBxNloFeY2nBD1s
	ZZ07cMTdtM3ysyJ9elPwZuRYvrT0OrA/gN1i6yMy2myCM+hqyS+zYZ+UjaGfu7R2
	fngVCGsv9pCcGdCAX0ZD8Ou0QW/I9uJWEEMJX7Iy7N4DsjR03B2mVlP4fjVQ0dvh
	UJP2d9IJ4Ng9+UjXBh5e2JDMfcPA0PjQLHmFQzdvAtVj63xiEvvV2PLxyQOlpYxj
	pR/9i5KIYfJjjDVF135v4xvdMr5gQhkX72qeykrLw4SqHQ==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id fkPnSCZ1Z4-b; Thu, 31 Oct 2024 20:58:49 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Xfbv36gp4zlgTWK;
	Thu, 31 Oct 2024 20:58:39 +0000 (UTC)
Message-ID: <d4378502-6bc2-4064-8c35-191738105406@acm.org>
Date: Thu, 31 Oct 2024 13:58:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/7] block: don't merge different kinds of P2P
 transfers in a single bio
To: Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>, Yishai Hadas <yishaih@nvidia.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
References: <cover.1730037261.git.leon@kernel.org>
 <34d44537a65aba6ede215a8ad882aeee028b423a.1730037261.git.leon@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <34d44537a65aba6ede215a8ad882aeee028b423a.1730037261.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241031_135859_192596_482AE12B 
X-CRM114-Status: GOOD (  12.15  )
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

On 10/27/24 7:21 AM, Leon Romanovsky wrote:
> +		/*
> +		 * When doing ZONE_DEVICE-based P2P transfers, all pages in a
> +		 * bio must be P2P pages from the same device.
> +		 */
> +		if ((bio->bi_opf & REQ_P2PDMA) &&
> +		    !zone_device_pages_have_same_pgmap(bv->bv_page, page))
> +			return 0;

It's probably too late to change the "zone_device_" prefix into
something that cannot be confused with a reference to zoned block
devices?

Thanks,

Bart.


