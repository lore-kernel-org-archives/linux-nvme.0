Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE505EA7959
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Feb 2026 03:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PU4GlXydM1MAqgXjMDFq3vjCStUesvrTn2wdEAI/iFs=; b=LObJ30R+NK9wU8uDRnb4Wokif0
	Uy3wQvknlqeOvbkKDDtU9Sye34HLZ0w294wG0csEu2e7zm2ITLK6x/0xwjYZEgEqP1TOk3dgI3s7i
	vLu1Mq8JOvd9awiHTyZa5opJqaztCmo5rzxtP4BCGckOH6hm8zJzT8noSrPi6BThOcC2Vp/fYCtk3
	yisGe729zf06oWaDwGXGpp4As0p8qRmNRI6mSwXEAfgrc5esUZJgBcTJ1EBdHMInZWvNDGxmPeeh7
	ryQmAMe6K2GXgr8+6y4uyJWXgpdygr7BDtWvrbtHumQAW0tm9OalG+VkY56FdtAXZgpFmVULW7FBL
	7BGzu8zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnpnE-00000009LgE-3Ihd;
	Thu, 05 Feb 2026 03:12:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnpnB-00000009Lfl-1MNX
	for linux-nvme@lists.infradead.org;
	Thu, 05 Feb 2026 03:12:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770261145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PU4GlXydM1MAqgXjMDFq3vjCStUesvrTn2wdEAI/iFs=;
	b=iqE0JwnPI7kuhoa9IJo4B9QD3UtMAcAIwYO2trxIpne+yDP2pvU/EkppZTr0g/pK9TXG9r
	4T0bWTZl8yQ3ljE484nXeTSqKmik2KoHiXj006tILV1v/DG+7WyU9Xoj+ltesBKh184N3o
	IBRKRIVn05gFmg82niY8KFYu7SiVlFk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-TVTha8Z0ON-75qSXyp4XFg-1; Wed,
 04 Feb 2026 22:12:22 -0500
X-MC-Unique: TVTha8Z0ON-75qSXyp4XFg-1
X-Mimecast-MFC-AGG-ID: TVTha8Z0ON-75qSXyp4XFg_1770261140
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 74E0C18003F6;
	Thu,  5 Feb 2026 03:12:19 +0000 (UTC)
Received: from fedora (unknown [10.72.116.36])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6B1171800465;
	Thu,  5 Feb 2026 03:12:11 +0000 (UTC)
Date: Thu, 5 Feb 2026 11:12:05 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, io-uring <io-uring@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"Gohad, Tushar" <tushar.gohad@intel.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
Subject: Re: [LSF/MM/BPF TOPIC] dmabuf backed read/write
Message-ID: <aYQKhcnTJLimnbEn@fedora>
References: <4796d2f7-5300-4884-bd2e-3fcc7fdd7cea@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4796d2f7-5300-4884-bd2e-3fcc7fdd7cea@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: VUF_3e8WyScJ71t_KEV4rdxYlTDzQHLHTwxxlmmUH2M_1770261140
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260204_191229_456454_99D0C688 
X-CRM114-Status: GOOD (  17.07  )
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

On Tue, Feb 03, 2026 at 02:29:55PM +0000, Pavel Begunkov wrote:
> Good day everyone,
> 
> dma-buf is a powerful abstraction for managing buffers and DMA mappings,
> and there is growing interest in extending it to the read/write path to
> enable device-to-device transfers without bouncing data through system
> memory. I was encouraged to submit it to LSF/MM/BPF as that might be
> useful to mull over details and what capabilities and features people
> may need.
> 
> The proposal consists of two parts. The first is a small in-kernel
> framework that allows a dma-buf to be registered against a given file
> and returns an object representing a DMA mapping. The actual mapping
> creation is delegated to the target subsystem (e.g. NVMe). This
> abstraction centralises request accounting, mapping management, dynamic
> recreation, etc. The resulting mapping object is passed through the I/O
> stack via a new iov_iter type.
> 
> As for the user API, a dma-buf is installed as an io_uring registered
> buffer for a specific file. Once registered, the buffer can be used by
> read / write io_uring requests as normal. io_uring will enforce that the
> buffer is only used with "compatible files", which is for now restricted
> to the target registration file, but will be expanded in the future.
> Notably, io_uring is a consumer of the framework rather than a
> dependency, and the infrastructure can be reused.

I am interested in this topic.

Given dma-buf is inherently designed for sharing, I hope the io-uring
interface can be generic for covering:

- read/write with same dma-buf can be submitted to multiple devices

- read/write with dma-buf can cross stackable devices(device mapper, raid,
  ...)


Thanks,
Ming


