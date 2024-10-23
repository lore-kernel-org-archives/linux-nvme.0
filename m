Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D6BCF538A
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Oct 2024 13:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GWmpGiv5LbeO6Ebd0w4FKoUkxqo10k2JdeGdrhpAPiA=; b=a8Pi8AUV0aLZWHDGcru4dV18WW
	0PyRchqSLnEt+tKYu0xFwzBE3dAyB+k6YH+0Jm6kgci5Iue9b82SLP+xLCbL08vKR7LxHezaneyHT
	53iG6tBzm4GoNEV8wsjr0VACaBLsiojjVSL9pzxi6coZKD7rLBNP6sHFOFApqcxjoVUgz3eLaWVFy
	sKgesKpBNuUeNRTHfuPmOjpX/Nwnq6IiKKdFEWFESIa3QF4Kus7MRHkFj0h5poEZzggZJe2xzn6Vo
	suwPVQ8FD12wsXhtLU8Zf6+fMqgcbwcX8QKOP7cw7IVqMcvIFymWyVNXUElYT75KVFgDPcD+Njgpn
	MwVJqyrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3bGS-0000000EVgL-3wqK;
	Wed, 23 Oct 2024 13:19:05 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t3bGR-0000000EVfy-1Sb1;
	Wed, 23 Oct 2024 13:19:03 +0000
Date: Wed, 23 Oct 2024 06:19:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Tokunori Ikegami <ikegami.t@gmail.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4] nvme: change nvme_ns_has_pi() to
 nvme_ns_supports_pract()
Message-ID: <Zxj3xwDyP1j8Y1Ms@infradead.org>
References: <20241023100915.11263-1-ikegami.t@gmail.com>
 <ZxjwAsny4yOUHvUD@infradead.org>
 <Zxj2rPzTGILnrUup@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zxj2rPzTGILnrUup@kbusch-mbp>
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

On Wed, Oct 23, 2024 at 07:14:20AM -0600, Keith Busch wrote:
> You can't just have a patch declare that PRACT works this way. The spec
> says it only works if ms == PI tuple size, otherwise it doesn't do
> anything.

Well, that means the patch as-is is broken, isn't it?

Which leaves me even more confused about what is is trying to do.

