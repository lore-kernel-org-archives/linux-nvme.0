Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B10FCFC52A
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Nov 2025 12:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vmlRhYF93waksWBjUZONe38VIF8D8AG9X1Um5Uz6pF4=; b=yrzHY1LoXBOwwvrsf3kxSnBP8y
	5UL0TlgAw1ivFPFJv2OiIUf455MIjWo0aJE5Ii5EAnOEiFIRNGf7dGAZfha0SRgCfOQqgahF8yfs2
	IULAnqn/DPtAYF5PFu9t8Aj+YlEk1djmZl1p+RtGi/SM6bNN8OzV8axQuSRw7+yr7dQVSfW/rmK4s
	lu1h/USrgpFB3BRYVIujI8qYGXt3iA6AeQV/tqxw81mgeYpE4nPK9NBzn/NnMx+bQ8P3uzWlUaut0
	jGZOJnmMh1onMFOBliL/UzwkSwU4o3pNJDOR+ECnZcNa6604bNKQDgcYmURE4HAdfQxFnDVYRRUyu
	Ix2EMRsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMmXJ-00000009XiK-44Mw;
	Sat, 22 Nov 2025 12:16:17 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMmXG-00000009Xho-4AbH
	for linux-nvme@lists.infradead.org;
	Sat, 22 Nov 2025 12:16:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763813773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vmlRhYF93waksWBjUZONe38VIF8D8AG9X1Um5Uz6pF4=;
	b=TlPXgOr1kbIpHj/TqAT7wH5WM3csggjM6r7cSv4Y97mCAhAxbF4drPsyNfMIckC+SW/gzJ
	NmAyG13tredi9wsdoit5UfR30Fovw0d9fOqDIBncYO2fc9p/zeADxQmcPsdVb65g526Aw0
	LoIX232B9n/OlGqpDQVqQ+OXLjPzypM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-267-IA69egs5O4SMsSW-UikYOA-1; Sat,
 22 Nov 2025 07:16:09 -0500
X-MC-Unique: IA69egs5O4SMsSW-UikYOA-1
X-Mimecast-MFC-AGG-ID: IA69egs5O4SMsSW-UikYOA_1763813768
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 71F481956089;
	Sat, 22 Nov 2025 12:16:07 +0000 (UTC)
Received: from fedora (unknown [10.72.116.33])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 61ACC30044DC;
	Sat, 22 Nov 2025 12:15:59 +0000 (UTC)
Date: Sat, 22 Nov 2025 20:15:41 +0800
From: Ming Lei <ming.lei@redhat.com>
To: zhangshida <starzhangzsd@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev, virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org, gfs2@lists.linux.dev,
	ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org,
	zhangshida@kylinos.cn
Subject: Re: [PATCH 1/9] block: fix data loss and stale date exposure
 problems during append write
Message-ID: <aSGpbb3VUdQEGfmu@fedora>
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
 <20251121081748.1443507-2-zhangshida@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121081748.1443507-2-zhangshida@kylinos.cn>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251122_041615_106050_334C6C9D 
X-CRM114-Status: GOOD (  15.13  )
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

On Fri, Nov 21, 2025 at 04:17:40PM +0800, zhangshida wrote:
> From: Shida Zhang <zhangshida@kylinos.cn>
> 
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> ---
>  block/bio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index b3a79285c27..55c2c1a0020 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -322,7 +322,7 @@ static struct bio *__bio_chain_endio(struct bio *bio)
>  
>  static void bio_chain_endio(struct bio *bio)
>  {
> -	bio_endio(__bio_chain_endio(bio));
> +	bio_endio(bio);
>  }
 
bio_chain_endio() should never get called, so how can this change make any
difference?

Thanks,
Ming


