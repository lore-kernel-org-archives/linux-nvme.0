Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B05CA0FED
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Sep 2025 06:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=G/EPaorfj+fFyTEHaVMF0Aq5nU/5YHn8ZldlmV9nSRU=; b=Zr03l8P4g6VUY4
	GGF1RGvaaS8x1ClsTxg+tafrXQXbNp+1inmOegwJScR5lH/1zUT74gsXN+B41ByPve650TgOwJCNu
	kUKRa+58TGhM1T+SUQpDLWfBhgx5ca0rqrRdz6TnP5AvGcMS2nPcKNyWjD8Nshh0C+KdqtwRnbsAM
	5oRmc3vJxqRo3Jy3clHVwjb8LuPc0hnb7Yqg14gJO7URTsbHuNYlSA3uPfXGokS/rW0zPcOrlllKF
	HLuoDX4ewb1f0KPXl3q0aYUjzrm6iFC8lgbwxprhAm7W0qajGX7P2+yQh4TYlSfo++Ypzd+1qdew/
	OU+jGSiH6ls2BsivAJNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvs6k-00000004mC4-0p0R;
	Tue, 09 Sep 2025 06:45:38 +0000
Received: from fhigh-a3-smtp.messagingengine.com ([103.168.172.154])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvGKb-0000000BT43-0JnM
	for linux-nvme@lists.infradead.org;
	Sun, 07 Sep 2025 14:25:26 +0000
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C2941140003F;
	Sun,  7 Sep 2025 10:25:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sun, 07 Sep 2025 10:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1757255121; x=1757341521; bh=G/
	EPaorfj+fFyTEHaVMF0Aq5nU/5YHn8ZldlmV9nSRU=; b=LxAEL1hA32JcJEnG98
	oeJWFJW96Ab1ZdHJgGFlspwkJEj8Aiavk+dntTuQR94KmnDxtmALl7CB+fX7pbmo
	zvwHV9izosIpgEyayMmq4HTHRSL2iK4fMKWHMvvD41vWIEJCTnEIIqxOvjqUMPdN
	FaaZNPb2cDEYVHxVXwipUcCnSOWtlHTWUV9b7UKVDN46YphS5bUyXSD3O2FSIvg3
	JUD1TcNnZpGiXsQ7MCTj1TVHQ3ohhj+xY79FbL/+BRd7wIICp8XkFAHyKTyD/8lm
	yl+rKrALxeGxgT5Cn2F0n3Vujw7PsQdn7K1EKLloRiZFtuJG1JI5PkcjOkt6ZukQ
	tPFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757255121; x=1757341521; bh=G/EPaorfj+fFyTEHaVMF0Aq5nU/5YHn8Zld
	lmV9nSRU=; b=gkkyoHxlYwH2iEfC+POnjbirfwG9a7+WNBFdUULpIUfCF6QwBKD
	CXcsXkweDWwsQzN7Gd/GbXOk1SV+QIJUgWkOe1GLc0VVeUYBy346pR/YD304mG7z
	1ztsB7KcR9c74q1QJaQIjsplL9rOCD+fGXEZYd3b1CaBQnjtDDPbNZDWICkLf5pp
	E+qxogYXjT9un6LXfyJoljBVnMPFxj2E3BW22x2ShtmyGXx44gZthxk9ic+CJ+5v
	xe6lmL0VZ16DWgsUqgTs96f66G7saKooHJEnRz+Yld+xGqzw4yGMu+xPzsXFPe8w
	GNdDDSQNNRcQqEmj5hrowrarHbImiv5H7QA==
X-ME-Sender: <xms:zpW9aHBBt0nmuBo9smDJ2pyc66XAz51H2zLxPIL-bKuIIirEqr75FQ>
    <xme:zpW9aP5GM0Oa9oXSpXiYSqnaKLnHMrts9xFSY3EInc6RNC_Ob2dxgDJB8d83jBdim
    fy3XXGQESbNHiHsUNQ>
X-ME-Received: <xmr:zpW9aNLIKTgt7t1RechOqALMeiJc4jvDTVIeA0j8Y6R9TLQOMTuGJFNVHgmJLi83Qw1w6W0IAc1sMtpcdOdKwHPv5EDXH_yn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeekkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgrshhhihcu
    ufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjpheqne
    cuggftrfgrthhtvghrnhepveehudehueekveelteevkeevkeeiudfgtdeivdehjeetffdt
    vdeukeekheeitdetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjphdpnhgspghrtghp
    thhtohepfeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjghhgsehnvhhiug
    hirgdrtghomhdprhgtphhtthhopehmrdhsiiihphhrohifshhkihesshgrmhhsuhhnghdr
    tghomhdprhgtphhtthhopegrsgguihgvlhdrjhgrnhhulhhguhgvsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhlihguvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopegr
    lhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghkphhmsehlih
    hnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehhtghhsehlshhtrdgu
    vgdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepihhomh
    hmuheslhhishhtshdrlhhinhhugidruggvvh
X-ME-Proxy: <xmx:zpW9aESQOTluGcoqM_cunEP_CQ11Qvxrpy5aGTfr1MzqwvK2MTzWog>
    <xmx:zpW9aFHJqGCH6u0UWGJG3VtNOeC2T8wJ8cwxckTphVMd0qLeV964DA>
    <xmx:zpW9aNpr-peDJ1nPk1kSevLyeyufAy3XpVeJTpuplknDlKhO7wcF7A>
    <xmx:zpW9aLNxtTkNoAukVHmomnYFXm7ah-6QwcR2-dfdjXXF-bo6zSTB0A>
    <xmx:0ZW9aEVsvUTTHZprT5gFlKyXEiCBT6fpdOnxgCny8ixcqLiQ3QkTgVqI>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Sep 2025 10:25:11 -0400 (EDT)
Date: Sun, 7 Sep 2025 23:25:09 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>,
	iommu@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
	Jens Axboe <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Corbet <corbet@lwn.net>, Juergen Gross <jgross@suse.com>,
	kasan-dev@googlegroups.com, Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-nvme@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-trace-kernel@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Michael S. Tsirkin" <mst@redhat.com>,	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, rust-for-linux@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,	virtualization@lists.linux.dev,
 Will Deacon <will@kernel.org>,	xen-devel@lists.xenproject.org
Subject: Re: [PATCH v4 00/16] dma-mapping: migrate to physical address-based
 API
Message-ID: <20250907142509.GA507575@workstation.local>
Mail-Followup-To: Jason Gunthorpe <jgg@nvidia.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>,
	iommu@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
	Jens Axboe <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Corbet <corbet@lwn.net>, Juergen Gross <jgross@suse.com>,
	kasan-dev@googlegroups.com, Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-nvme@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-trace-kernel@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Michael S. Tsirkin" <mst@redhat.com>,	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, rust-for-linux@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,	virtualization@lists.linux.dev,
 Will Deacon <will@kernel.org>,	xen-devel@lists.xenproject.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905174324.GI616306@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250907_072525_637697_1B3A765F 
X-CRM114-Status: GOOD (  12.12  )
X-Mailman-Approved-At: Mon, 08 Sep 2025 19:46:38 -0700
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

Hi,

I'm a present maintainer of Linux FireWire subsystem, and recent years
have been working to modernize the subsystem.

On Fri, Sep 05, 2025 at 14:43:24PM -0300, Jason Gunthorpe wrote:
> There is only one user I found of alloc_pages:
>
> drivers/firewire/ohci.c:                ctx->pages[i] = dma_alloc_pages(dev, PAGE_SIZE, &dma_addr,
>
> And it deliberately uses page->private:
>
>		set_page_private(ctx->pages[i], dma_addr);
>
> So it is correct to use the struct page API.

I've already realized it, and it is in my TODO list to use modern
alternative APIs to replace it (but not yet). If you know some
candidates for this purpose, it is really helpful to accomplish it.


Regards

Takashi Sakamoto

