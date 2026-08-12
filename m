Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E13F7C5B572
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2026 14:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wax1t+J1+D4JHs3MLr//7ZVVQ+YfBVoQOpV29LLh7uo=; b=JZbIv1qupaTdHplMuVDJ4VQTuX
	9Euect2xQZwn6JvsH0eR13CW4NOOsOlwOMq6y5ZfEX7Y2ZaQ1qOGXHp7kVEfJTJn5IRPSrEVSlmFq
	H1U5p5W7ei/g8CqwKmQ1m9CKB1hMVVQgUw2DbKSLtn93Bb7srj1WrdCpSKbskTXbkosNDjWkmni8T
	O5u4HBMCbhFK7fLlTne9ajD64D5hBVUqFnipytGAHa9IpLFT1NXNFCeCU7xY2JYw9y2iOYNZshE+N
	EU+8jMzz8LDGCoi11w73eZ9ZDGRhOliZ+Yuj1neY3txF+rlHd+WEFoNpqQ3Lyvdj0iro+RNhtPPtJ
	uytd3dfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu9ym-0000000GOZm-2QAM;
	Wed, 12 Aug 2026 14:30:52 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu9yk-0000000GOZP-300o
	for linux-nvme@lists.infradead.org;
	Wed, 12 Aug 2026 14:30:52 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2B6D260A9E;
	Wed, 12 Aug 2026 14:30:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92AE51F000E9;
	Wed, 12 Aug 2026 14:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786545049;
	bh=wax1t+J1+D4JHs3MLr//7ZVVQ+YfBVoQOpV29LLh7uo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T3hCstbZYue6SXbbFIimZk7VdVvHA4hdrsfN6DNkdEh2EOKsabNjfzLAFc6MVKBOP
	 tWoWc4O9nqPqL1ZgoexiA7uH8eGLFXs8LdM47hrYp7T8qy27x6ct3pJlIOlvnLKDQ3
	 EpwTljn7W2y2AxzgvQz7He4eT9eYkflxBsP+jG58LHwzbB5bJB8K3Y5K9xC80mMCV0
	 TdnlGx0f1rK54NTCvjQFPhIX963VkPVzEF8ybZzuW4NftGe4IwFr1/IZbsPP1VFPzS
	 fD4HrDrFHYdlNYouSVZ0siN6Dcr05QQT9QYeO5GMNGE7RR/Ne8b4fhk45D2IPwM+30
	 w9skhDaDX+isA==
Date: Wed, 12 Aug 2026 16:30:45 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Rihyeon Kim <rihyeon8648@gmail.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
	justin.tee@broadcom.com, nareshgottumukkala83@gmail.com,
	paul.ely@broadcom.com, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-fc: fix double free of fabrics options when
 nvme_add_ctrl() fails
Message-ID: <anyDld8md5isTbn6@ryzen>
References: <ansfMnm1WntoQRi_@ryzen>
 <20260812105941.55577-1-rihyeon8648@gmail.com>
 <anyCi32WjlR0hyeC@ryzen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anyCi32WjlR0hyeC@ryzen>
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

On Wed, Aug 12, 2026 at 04:26:24PM +0200, Niklas Cassel wrote:
> 
> To me, it seems like fc.c should simply look more like tcp.c and fc.c.

[...] more like tcp.c and rdma.c.


Kind regards,
Niklas

