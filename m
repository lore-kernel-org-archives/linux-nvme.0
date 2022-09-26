Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7CCEC32771
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Sep 2022 14:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7a/V89npBHRwzuuTz3Nss9tFstt+7uZ2MJdGjbIq5wU=; b=IIzwF69fSSBLHj/Bf83HdQjR4c
	a03rebqQgJz+HRRf3Bmq/bappnNK6pPFOWpHAxgFvpN+GFbQe9WHsmLqbLn5MlPhSIVtS/XZeSEFe
	BsbrRKn3JjOgf2obcZ2ABsiB5yImDfHSut1Il1ctZvQfdkolSvhFEYinUob0/8oS0OwZwmlNK0mQ+
	ysC69bKlWnDgbkHeNC0I+7940SsWOBMr8GcLWSGgJbeVW5QibSlQOVMyWEf1XRoe+6JBnae9H1piw
	zKVTve7PUD2x9YgfuOV6ApvwNB+n+5wJzcLgCg6yEISXFtp3gRA5ELWvFDMriXaco3/9j6HIQt2kg
	33Rp1oiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocpUm-005WMz-BJ; Mon, 26 Sep 2022 14:54:08 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocpUj-005WL4-2i
	for linux-nvme@lists.infradead.org; Mon, 26 Sep 2022 14:54:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 914A868AFE; Mon, 26 Sep 2022 16:54:01 +0200 (CEST)
Date: Mon, 26 Sep 2022 16:54:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH for-next v9 6/7] block: introduce helper to map bvec
 iterator
Message-ID: <20220926145401.GA20939@lst.de>
References: <20220925202304.28097-1-joshi.k@samsung.com> <CGME20220925203336epcas5p39e910479f992d7d9e233210e0647a6bf@epcas5p3.samsung.com> <20220925202304.28097-7-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220925202304.28097-7-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220926_075405_293375_5A1E2C5E 
X-CRM114-Status: GOOD (  12.66  )
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

On Mon, Sep 26, 2022 at 01:53:03AM +0530, Kanchan Joshi wrote:
> Add blk_rq_map_user_bvec which maps the pages from bvec iterator into a
> bio, and places the bio into the request. This helper will be used by
> nvme for uring-passthrough path with pre-mapped buffers.

I still don't think this should be separate per the ongoing discussion.

It would also be nice if we had a chance to finish the discussion
without seeing a reposted series before we've made much progress on
it.

