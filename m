Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1091AE77198
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2025 13:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D8mjgkrVOreFM3ccFW64iXKbeH7Uh2ZLs+0lDojl73o=; b=Tqzt1fW+X4JVzxa3HjMEbdHK88
	Apz5LCGR2QD3fZw09K3+IYpGHBUJk/fiN/gLijDE6kJ4e3XHkh0036bGG/5I9cBozt1Fp5sP/PUh9
	o6GdlohoMRP9n87LKz528zBRV7Jcw5aKQu2Se6dnhyz/944YDcfcyHFCbFMXQl4wA7GHpe8kYtIyq
	7gz057Pk8rntnOxhTmGqMbV0ipss5j0xVMzvwrSsPezmGR/6suLaqRAzfmgUB335srcHnCda1yNTc
	zyagQ0ZvxUyneBatP30D6VGLiIFJAZBoaKgEcJ2oCOr62X54g2SBd7xtfVMuC8TlEPfsuD6vzuv7F
	m281Q3SA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUn13-00000001NAy-3lks;
	Mon, 06 Jan 2025 13:19:33 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUmrA-00000001L6X-0Ggr
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jan 2025 13:09:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 5F6CCA4161B;
	Mon,  6 Jan 2025 13:07:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA76C4CED2;
	Mon,  6 Jan 2025 13:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736168958;
	bh=LOAg8h56rNknhvkQW9bBtvxkT/tYtQaf+5iBZRhzhwI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mVZK0Qt9V9R6rsS1of2npm5DS4L36FTlIJGY7+xPX5wx3mFAzj5FQohWkDVU2XRyz
	 7n/2cTBTFpq2PU3nXvxCTSfirLciNWP/1MPzMKiwUYTda+mxr4rrYUdJaMdnkY1iZI
	 uBRhncH2HZCpeSgqXKStlmme172qYcPgr0DOBWHy/wpIQl0g0OcU5FrSyzm5Ai3GFb
	 i/VS5E8FhgHmRp2AZXt1tppN233nc4qhlIDJG7e2CDyqmeS1WNTQCNGEG+as4xTC6x
	 mtF0jl48v/v3853HHkzxIE7MACWuOxF+uznsSW8M4uOUxYRQ9ITBNj5UPAMdVWNtUf
	 rb3ZdCU6hgzAg==
Message-ID: <3cf61c5f-b53b-43b6-90de-e42272f74e3f@kernel.org>
Date: Mon, 6 Jan 2025 22:09:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] virtio_blk: use queue_limits_commit_update_frozen
 in cache_type_store
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
 Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, nbd@other.debian.org,
 virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
 usb-storage@lists.one-eyed-alien.net
References: <20250106100645.850445-1-hch@lst.de>
 <20250106100645.850445-7-hch@lst.de>
 <07353499-b62d-488a-9575-12de5d9b6f2e@kernel.org>
 <20250106105957.GC21833@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250106105957.GC21833@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250106_050920_175510_C8B2431E 
X-CRM114-Status: GOOD (  12.41  )
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

On 1/6/25 19:59, Christoph Hellwig wrote:
> On Mon, Jan 06, 2025 at 07:56:19PM +0900, Damien Le Moal wrote:
>> On 1/6/25 7:06 PM, Christoph Hellwig wrote:
>>> So far cache_type_store didn't freeze the queue, fix that by using the
>>> queue_limits_commit_update_frozen helper.
>>>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>
>> This should be squashed in patch 2, no ?
> 
> patch 2 is supposed to just be a mechanical conversion, and each
> behavior change should be in it's own patch.

Sounds good to me, but let's be consistent then: do not remove the
freeze/unfreeze from virtio_blk in patch 2 and do it here in this patch.
Otherwise, patch 2 *does* change the behavior of virtio_blk, introducing a bug
(missing freeze around commit update).


-- 
Damien Le Moal
Western Digital Research

