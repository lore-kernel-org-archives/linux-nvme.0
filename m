Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D9CC4345F
	for <linux-nvme@archiver.kernel.org>; Wed,  1 May 2024 07:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1P5X+DLLfFskele4mxWbUufiXi3HjTi3zSso0xqbfKY=; b=GbNDljFMoYTh4vIgK7aJtFzZyI
	HAIRkSi0NK0mf4TsF+p5MLKdVG+I3d2h90CrznAXEPCuBS0CuO2Bmrf2QBUWIWLvnJwg1CnXyESYb
	kFTQp6FwtH7iLjVYi65y3GAboCpe1CWqpet65qbYLMpOyw0/Wgj+0fUji59+6GCtJtnBc1fssthrq
	LOfkFlrAFztCL48hyu2Qr0kvYBk7Q6Lc3zacWQGIZTfnsK3kNlGRl8tcw8NOYkleAv3GLTlAjKAA2
	Qy39VD+ZVvYB71/mzPH9QXs8epigadq8cs4UzWotcZ+C+AueLTsBk+a7nSetKC7jHtG3jHofUwKCU
	XvagbEDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s24jo-00000008n99-3jaK;
	Wed, 01 May 2024 07:50:48 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s24jk-00000008n8Y-2d6X
	for linux-nvme@lists.infradead.org;
	Wed, 01 May 2024 07:50:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 214B5227A87; Wed,  1 May 2024 09:50:40 +0200 (CEST)
Date: Wed, 1 May 2024 09:50:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
	martin.petersen@oracle.com, kbusch@kernel.org, brauner@kernel.org,
	asml.silence@gmail.com, dw@davidwei.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH 02/10] block: copy bip_max_vcnt vecs instead of
 bip_vcnt during clone
Message-ID: <20240501075039.GC2325@lst.de>
References: <20240425183943.6319-1-joshi.k@samsung.com> <CGME20240425184653epcas5p28de1473090e0141ae74f8b0a6eb921a7@epcas5p2.samsung.com> <20240425183943.6319-3-joshi.k@samsung.com> <20240427070331.GB3873@lst.de> <73cc82c3-fbf6-ea3e-94ec-3bdce55af541@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73cc82c3-fbf6-ea3e-94ec-3bdce55af541@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240501_005044_828934_CB2FB878 
X-CRM114-Status: GOOD (  18.39  )
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

On Mon, Apr 29, 2024 at 04:58:37PM +0530, Kanchan Joshi wrote:
> On 4/27/2024 12:33 PM, Christoph Hellwig wrote:
> >> If bio_integrity_copy_user is used to process the meta buffer, bip_max_vcnt
> >> is one greater than bip_vcnt. In this case bip_max_vcnt vecs needs to be
> >> copied to cloned bip.
> > Can you explain this a bit more?  The clone should only allocate what
> > is actually used, so this leaves be a bit confused.
> > 
> 
> Will expand the commit description.
> 
> Usually the meta buffer is pinned and used directly (say N bio vecs).
> In case kernel has to make a copy (in bio_integrity_copy_user), it 
> factors these N vecs in, and one extra for the bounce buffer.
> So for read IO, bip_max_vcnt is N+1, while bip_vcnt is N.
> 
> The clone bio also needs to be aware of all N+1 vecs, so that we can 
> copy the data from the bounce buffer to pinned user pages correctly 
> during read-completion.

No.  The underlying layer below the clone/split/etc should never have
to care about your bounce buffer.  The bvecs are just data containers,
and if they are mapped, copied or used in any other way should remain
entirely encapsulated in the caller.

