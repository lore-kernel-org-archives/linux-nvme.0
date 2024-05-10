Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6DA8C25B10
	for <linux-nvme@archiver.kernel.org>; Fri, 10 May 2024 15:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A9Pov9+KC2IIoqKLTUpuUx5CGWm5+OizuP9xcaM6fbo=; b=tJZ4ZT5BZr7Msq3C0xh6+i511t
	YIlfKW+71ctgCqA4PKvpRyLNw3I9zAeabR9yzXsjHcOkGD2cFVEgnF9NV9iv7RJPw0YGnjMHZO1SS
	TOy5I4IvxPaegKGDFerixmGxfcroXpzfWE2bCCrFQ7Di3CF3vrmw4h0MEoI+POU/TwAWeP9uLNmeN
	yIrrdSCTSyHlhRHpfG1odZaiwiZYpZ/eCITpHIxNvYBo89dX4uejvC5rbObxVxdTKXSwR3wLmqefa
	L/Mgr3utOz7qD/Z8hkF73/pH7yRvU9D9eWeGW0qOOOfjB4UdaU75FUzG4TZnafqBprRas+A22NyuM
	cMCdg/5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5Ryn-00000005gTm-2WI7;
	Fri, 10 May 2024 15:16:13 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5Ryk-00000005gSp-2eY6
	for linux-nvme@lists.infradead.org;
	Fri, 10 May 2024 15:16:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715354167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A9Pov9+KC2IIoqKLTUpuUx5CGWm5+OizuP9xcaM6fbo=;
	b=UUxrujlw14GbwLz7ARL1A571csX1GKTuAlm3rQcpb6iUD/7Nt5u1Rlp2rui/fc4uWVdiH3
	WGWqcxN7Ga7k8bZcXTtBa6RI+Yzcft8LZxvCyP0pcIsIzOHpf9HyzvlK0YIYWUAIfLhMTc
	BOYMEj7bEmKx9N68QcxJmbJfGLMHrPU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-sec5aB0YMteQ3ha-QDNx7g-1; Fri,
 10 May 2024 11:16:03 -0400
X-MC-Unique: sec5aB0YMteQ3ha-QDNx7g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BD31829AC03B;
	Fri, 10 May 2024 15:16:02 +0000 (UTC)
Received: from fedora (unknown [10.72.116.93])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 26BEDCF5E1B;
	Fri, 10 May 2024 15:15:57 +0000 (UTC)
Date: Fri, 10 May 2024 23:15:54 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	hch@lst.de, tglx@linutronix.de, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/2] genirq/affinity: remove rsvd check against minvec
Message-ID: <Zj46KiMO5trL09RA@fedora>
References: <20240510141459.3207725-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510141459.3207725-1-kbusch@meta.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240510_081610_768849_1EC7DACF 
X-CRM114-Status: GOOD (  16.95  )
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

On Fri, May 10, 2024 at 07:14:58AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The reserved vectors are just the desired vectors that don't need to be
> managed.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  kernel/irq/affinity.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> index 44a4eba80315c..74b7cccb51a16 100644
> --- a/kernel/irq/affinity.c
> +++ b/kernel/irq/affinity.c
> @@ -113,9 +113,6 @@ unsigned int irq_calc_affinity_vectors(unsigned int minvec, unsigned int maxvec,
>  	unsigned int resv = affd->pre_vectors + affd->post_vectors;
>  	unsigned int set_vecs;
>  
> -	if (resv > minvec)
> -		return 0;
> -

This behavior is introduced in 6f9a22bc5775 ("PCI/MSI: Ignore affinity if pre/post
vector count is more than min_vecs"), which is one bug fix.

Thanks,
Ming


