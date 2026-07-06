Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD681C43458
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jul 2026 16:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zTniQXSYOJwfVjI36+G4ARx+s4Kmaf63AFkK+MNloRw=; b=k8PccYn1DZKB8QxwNt43xj0M4L
	OOX4WM2QOQbQ65GM74GFt4mCqAiWm+htdfRXtxE0CRSa48xlhL3DFOq2NvBHbTeBdPQoMb+V+u4N1
	FMAYw9Tc8lwjhULmQkE4GxdwYzQbTpkniZUgok7Q0nk9A+McXFEIhJLxLypAe2sB+Bn624hWR7NWe
	2lFdqLehhEg8WjojTW0ivssC9ubqgXr8FKPu7gwfDkX5FXmCB288eLR2gkxgqo0TTJ1FO0SI0kjCU
	SsvsnlsYRZQqsecP6dya99m0QPbqwy3KGdiA1Q8EjC4udUTNEz28RD80vB5fM5LOlSlLA5wqIFENC
	eFkkMZ2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wglrr-0000000Cztb-3zN1;
	Mon, 06 Jul 2026 16:08:23 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wglrr-0000000CztV-0H3V
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jul 2026 16:08:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2B56260098;
	Mon,  6 Jul 2026 16:08:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D455B1F000E9;
	Mon,  6 Jul 2026 16:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783354101;
	bh=zTniQXSYOJwfVjI36+G4ARx+s4Kmaf63AFkK+MNloRw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=bfTToFSd6IxpErF7jppzKGkiQ0m4SPCtQFcgZ1smpSmTo7tEWI7arTfwWva5+8hQ7
	 RjMNLckDKsVXe79oJQ1oaneKmXTSHuoHi2pX3cLg1GtoCITG0ejffVF0FqSV5a56sP
	 AkNsdXowTm+/yzo1KUY05/jfoZiEwBX4LcdfbziXcRebY4vqwBkYdJQ9TwB57vWvKg
	 h7NHrkxrw1Rv91RZ973kh+wl89Ho92s3l2lw+sT+1O8nGosFuaeKYyVQY8OB1O8u9J
	 d2j2kf9x5gst1LVM3cJYHLhUfbm1U4VsjpxlgQY3YDrm4Qsyi9d4C9g2anouaueZbA
	 6v1WxAduyALzg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9DBA4CE091C; Mon,  6 Jul 2026 09:08:21 -0700 (PDT)
Date: Mon, 6 Jul 2026 09:08:21 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	hch@lst.de, elver@google.com, kbusch@kernel.org, sagi@grimberg.me,
	axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com
Subject: Re: [PATCH v3 05/18] nvme: add context annotations for
 nvme_ns_head::current_path
Message-ID: <03e47f32-5998-41e1-9340-ce757c5e188c@paulmck-laptop>
References: <20260706141452.3008233-1-nilay@linux.ibm.com>
 <20260706141452.3008233-6-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706141452.3008233-6-nilay@linux.ibm.com>
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
Reply-To: paulmck@kernel.org
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Jul 06, 2026 at 07:44:07PM +0530, Nilay Shroff wrote:
> Annotate nvme_ns_head::current_path[] with __rcu_guarded so that
> Clang's context analysis can validate accesses to the SRCU/RCU
> protected pointer.
> 
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>

From an RCU perspective:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  drivers/nvme/host/nvme.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 5e746ae1c805..610c685e2263 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -575,7 +575,7 @@ struct nvme_ns_head {
>  #define NVME_NSHEAD_DISK_LIVE		0
>  #define NVME_NSHEAD_QUEUE_IF_NO_PATH	1
>  #define NVME_NSHEAD_CDEV_LIVE		2
> -	struct nvme_ns __rcu	*current_path[];
> +	struct nvme_ns __rcu_guarded	*current_path[];
>  #endif
>  };
>  
> -- 
> 2.53.0
> 

