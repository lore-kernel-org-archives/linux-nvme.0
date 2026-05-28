Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A03FFCD5BD0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2026 01:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rwygTp2mARrzZlBrAwz1tP6ZHcucWtK2gK/Pcd3NLTA=; b=ekrp57by8HL/sdvsbh0oplxMw4
	5yueprqXtwTz2Ia/9cxY678nSlrrvFIuf0Tuu4QDbax3aIWHuMerv5W7IFE6ayiVV3LBxdMbR/STL
	/KGYTlIx3Vj7+0KNftm23jrWHhnoUZSgjFwwql8VRhHuVWTnO2wqNaIVSaYwbb4bGWskOnKqzxfQx
	qaU/6hIkT47pQm4K/Ag8BBF3TWpHPV5Vj+6GEU529QFwHkkC2om8u2eVN3usNRPiBtTs27XIcPY6y
	tdLXHUn+hL9m3965/vUl7O6UdgpMhIsh+fKMq4lKHyNlHzftotWvhBflJEfOcHkhD2XZW1+eDkThz
	D2y4sUxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSPhR-00000004x50-3SRV;
	Thu, 28 May 2026 01:38:17 +0000
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSPhP-00000004x4f-3hY0
	for linux-nvme@lists.infradead.org;
	Thu, 28 May 2026 01:38:17 +0000
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-83975e992e1so5034315b3a.2
        for <linux-nvme@lists.infradead.org>; Wed, 27 May 2026 18:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779932295; x=1780537095; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rwygTp2mARrzZlBrAwz1tP6ZHcucWtK2gK/Pcd3NLTA=;
        b=MWWei9dMual8F6J4LOEA4cZco7ZJ/jgy1ze7sVudE/lQvEcw9ip8JDkrLgXhWeQYGe
         erTN5DWZVUxdJJV6Ed8pzVtZLMttgrIWdLZhKW8OglqmFH2VEgefV13McVNK8hbBLL69
         +imMBSZkIe7468ojM06g3gxgOKgu90HAAksoyg0j0NXfK5qTlgdlqkQe/7yNq44OmQJf
         eQRcLv21S+rkAesh2xTT7zZ6Tp2/ysTVKsyVeOLZkHYun7rFTwRgcnjUytz6uT5iX2qM
         YYLibqMsCXFTPc1ZY21U62+Xjz5h49FFa9GXLB6kfkps+gLDFAkp2EV4k4mY8IdyMK4V
         x87Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779932295; x=1780537095;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rwygTp2mARrzZlBrAwz1tP6ZHcucWtK2gK/Pcd3NLTA=;
        b=eDF2sAXLbOK6x2WdmIpzV0lJzXuL9nbWKKphua4KGSc1QeLaGR8eJD2AGrlSLsGU7z
         DybNmjrzf4d39Gu8eS4pCkXEZudG9YCD/Fv/Fcq/dEenqw5S7s/JXdT3nY7xIYpTJ5CP
         aHuMRl7ksi9YNk40uBaulN3dLKWuU/Y5uJ0yOqBqZ4DuwdwqfPBk9yZDzwFILUBzgX0w
         YRIbDnpt+0jVY6WPEFuXEkf+BCFVKOe4k+YcfJa2TsUaYfhzT2Ghce75jbuo5U3SEr2P
         iY2hgGsnAFZtX/5w5MehppQwZ+aCW7/pSZs4riDjwSno0I/RdRPD88sHTU+ofuQpvPD0
         lKBA==
X-Forwarded-Encrypted: i=1; AFNElJ9a8ZRdcGjFjbQevvD/jqE8vw2pGlnrJf6DH3DF0BEoRWy1kXSVanH20DIrIr98QqvVsrB7n9Bw2d3G@lists.infradead.org
X-Gm-Message-State: AOJu0Ywsjow/4qmrJ60oVAmsF1ZjIFz3vRWQY4xN7Pu/O+ZzkZCdGrqg
	oIIjfweoxmP/zpPIARZjy+9thr3A8aeaxImEw0ezEiFaQP5ecMIL9Eff
X-Gm-Gg: Acq92OHD9u/8sLf7txpjVB6mxG99OeWs76m5eQybHXleSN0xX0bQodCfGolKZXGrLgw
	U63lb60NjSb6cH4wm57du1aeduffSWLjlWgeZ39v67RKwtjemhJf3Wy7kC6k5aQpQVre7LyWYhD
	KqgiPnIFOi9F78T8Ys5ZPkgv/4JFe2XgfqiskEJPuCYcGC9Z5mWlcuDWv7m7EDA6o8pgTqc5S2O
	5nCUE8+kZfSqCwTbSYblsbuMrbdbdujeMTYERMX5wsdjIftleYaqgljz3w4xvBfxFZbOn4mh1kE
	TFDHhtsYjHTueV+7LWInpG0ALr2ufJE6MXAiiipFDri/2LslipOqc8QVe1RMiPOJRCO4o6KdOOQ
	wHG5xUclNBCTFazFHLIMX0fzchOkmwzCuDwfZJyCstKklt/UWcYYzJlOxLRuuYeDTJg7ACKjr1q
	Y1l4Lbp+XFsPRd9MV/WDjpUqyW5ZRCt+1uUyDhREKq/UtwL39hqncBxz5/wSrH
X-Received: by 2002:a05:6a00:1a0d:b0:841:edbf:6425 with SMTP id d2e1a72fcca58-841edbf656emr1068316b3a.3.1779932294619;
        Wed, 27 May 2026 18:38:14 -0700 (PDT)
Received: from [100.82.106.192] ([203.208.167.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d70b855csm3482467b3a.38.2026.05.27.18.38.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 18:38:14 -0700 (PDT)
Message-ID: <942dd4eb-8a5b-45f9-b0f2-fb0ccc1d453e@gmail.com>
Date: Thu, 28 May 2026 09:38:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/1] nvme-pci: detect I/O queue depth changes after
 reset
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Guzebing <guzebing@bytedance.com>
References: <20260527075320.3178600-1-guzebing1612@gmail.com>
 <20260527131951.GA11071@lst.de>
From: guzebing <guzebing1612@gmail.com>
In-Reply-To: <20260527131951.GA11071@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_183815_920515_52313E14 
X-CRM114-Status: GOOD (  11.76  )
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


在 2026/5/27 21:19, Christoph Hellwig 写道:
> On Wed, May 27, 2026 at 03:53:19PM +0800, guzebing wrote:
>> This RFC instead takes the smaller approach of detecting the reset-time
>> CAP.MQES change and making it visible.  If the live I/O queue depth
>> shrinks, reset recovery is failed before recreating I/O queues.  If it
>> grows, the driver warns and continues with the existing queue resources.
> 
> Unlike the other version this at least sounds doable without creating
> a complete mess.  So if we can live with this version that'd make me
> much happier.

Thanks, Christoph.

Yes, that is the direction I would like to take here.

The goal of this RFC is to avoid the live queue-depth resize path for 
now and keep the reset recovery policy explicit: fail reset before 
recreating I/O queues if the CAP.MQES-derived depth shrinks, and warn 
but keep using the existing queue resources if it grows.

I will keep this lightweight approach unless there are objections, and 
will wait a bit for other comments before sending a non-RFC version.

Thanks,
Guzebing




