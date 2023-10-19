Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B4ECDB482
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Oct 2023 05:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0eeSz9ay89iv1EzlLlEyR0fCbuIVA8AowEt8FWx2BDA=; b=sY11BF126HB9luQuSwGtZwsHHA
	tMH54oLfyqcj/BpVO0OWKXdP7Oc3kqpa13zjDSd2ff79j4DySn3SltS4+Du8ax/mKFa88ds2ZUmmp
	Wr5QhISus1qtBkKeNiugXkcP6O/tCyhsiiwBv/k6xVkn/t/1G625GDoPmrKEXz0X9U5kI6RAzIMUh
	glIrQqCJhMHUph0v3hyFc35FOS5wGpKUPZWgdqVgMQb6sEfnxsspFFBe1U/0bpLBfx2QI9zztC0cH
	HKAFSGjk/JMhkLEPxJ/NrxI9u8c80L2n+eiKmaZcHY8DsIBdB02kiBJdIcFTBOl8rE0oqdl8EmTyp
	RKKvXBOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtLlp-00GMuM-0t;
	Thu, 19 Oct 2023 05:40:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtLll-00GMt3-2w
	for linux-nvme@lists.infradead.org;
	Thu, 19 Oct 2023 05:40:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8A63867373; Thu, 19 Oct 2023 07:40:26 +0200 (CEST)
Date: Thu, 19 Oct 2023 07:40:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	io-uring@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
	joshi.k@samsung.com, martin.petersen@oracle.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 2/4] nvme: use bio_integrity_map_user
Message-ID: <20231019054026.GD14346@lst.de>
References: <20231018151843.3542335-1-kbusch@meta.com> <20231018151843.3542335-3-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231018151843.3542335-3-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231018_224030_118807_417BDA4F 
X-CRM114-Status: GOOD (  15.36  )
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

On Wed, Oct 18, 2023 at 08:18:41AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Map user metadata buffers directly instead of maintaining a complicated
> copy buffer.
> 
> Now that the bio tracks the metadata through its bip, nvme doesn't need
> special metadata handling, callbacks, or additional fields in the pdu.
> This greatly simplifies passthrough handling and avoids a "might_fault"
> copy_to_user in the completion path. This also creates pdu space to
> track the original request separately from its bio, further simplifying
> polling without relying on special iouring fields.
> 
> The downside is that nvme requires the metadata buffer be physically
> contiguous, so user space will need to utilize huge pages if the buffer
> needs to span multiple pages. In practice, metadata payload sizes are a
> small fraction of the main payload, so this shouldn't be a problem.

We can't just remove the old path.  We might still need bounce
buffering to due misalignment and/or because it is notcontiguous.
Same as we have a direct map and a copy path for data.


