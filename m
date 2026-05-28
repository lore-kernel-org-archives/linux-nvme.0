Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E971ACD5BD1
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2026 03:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g5uXlb9DClg+oUz25HJ7qILql8lXt55AWGux+JMMJXc=; b=mXHdd9Enize3JYay8J2in61po8
	34BoGY6Kf5LYAF/qq2RJBN4tQNZ2sNOmvpPAML2mrwuKNcrT8qvpRZ1FMIQdlkuEiVxdyfgJPnxt5
	vTFA3sO7yVIyGtlkABxuWwFbD+juu/FwE9JljRWri3HD47waYtHBCALODcZQCJuJKGgKoyWoNmL5K
	7+2lv0IVxxw/lzXNRYjl2pMEOE7fcw64voauRXMT1DS8+pcMD8We18hJTgJVG37M6NWvkGxf3M0av
	WVIXAf2uECkY/OuosQZyzjB16g+U/yv5483EfHKmEjIIQqqCGr0EYT1HoRTqRSAQPPsz9ThVAS4Nc
	L57y7t5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSRUF-0000000542V-0sx7;
	Thu, 28 May 2026 03:32:47 +0000
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSRUD-00000005424-0GY7
	for linux-nvme@lists.infradead.org;
	Thu, 28 May 2026 03:32:46 +0000
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-8b9f2295a9dso135141226d6.3
        for <linux-nvme@lists.infradead.org>; Wed, 27 May 2026 20:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779939163; x=1780543963; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g5uXlb9DClg+oUz25HJ7qILql8lXt55AWGux+JMMJXc=;
        b=NeNwFlNndJ+nJe1eUK+yEAPFiYVCQ901ruMaeyP0PwvyY4TskHcfzlkOsKfl5m6Te0
         VL31kt9Fr+RbGHpqjWlPFZDB3pTpsqHcuBSumpgxnc8qDHgeFU5X2YO8gbwUyRGgM1UG
         vcfKtVv3R1keXVXae22uSzSZ/8qDUrGOBTi4aczomqGQYfo0wWTR98yhcOy3tPVEjf+7
         T5EfsPPspfKHlqEiBMW/7cGNgutzDaqwTlBf3TNFL753TkalBUryVFDOiheTSA3z6KW3
         9pk9UIFxGFo0DSc/VLjmZrw0Q5i0mYmxDy6rTEqaQdpxkteFzcSWIYESc8XHvDtSrOVn
         y2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779939163; x=1780543963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g5uXlb9DClg+oUz25HJ7qILql8lXt55AWGux+JMMJXc=;
        b=FlHPBAjSBt8SSxSUkLcsx0EryEB6c+GGNSPWiXjcrFevuxmdIqpNUd/LC9yRWO7QWi
         5JCVoI43E3qhpL+Yn9rbpFXLkWrdgIvgnW/AjyTRE8kF4JwuE65udDkaXiiPNhOEZWLL
         3WEX5Mamxpt1Qy1LM+fuiTP/yBovA26Tz1z4jyfXdsENOYHMqoYbOvFFBahJsEHUsw8O
         rvetw7kUG9Q/BQOZMWIg9wHiodUZlkaqHcKNXRv1Au5Dlf0399E29RTjf9bnuQ+/JKQK
         uG65VXU5K59Kphnxrq2KJeGPVzv8UqbdEaoDPUVI1i4GWuqAGhMv7wPcnYhqONxdt4YW
         akeA==
X-Forwarded-Encrypted: i=1; AFNElJ/BkmliNcGgWEwatD0+5Msbjke02tEcEijNbH3dkfbSx06efqZAApFJ9SAu9VOkgw4iN4LfRf9EDbol@lists.infradead.org
X-Gm-Message-State: AOJu0YzhKtXggq5wiIqEnf6U95fvGmFG+mBrEJCtid8MRm696U7RB2tB
	M+i/SRuYI9WQ4a/NQFlWsBo3FLCpln6ckFIKj73Xu+RpXri+BPzribyi
X-Gm-Gg: Acq92OGXcjPaGB6hbRftQWV+bjL8MzZZH3/32/cvcraX2X+Q6pNel3ud6pxd3s0tKSc
	OYJwg4IgcVC5P72+4NmPrqGJAtGyFtsDfBUZzJZYrLJkd5sfwdF0/dpPmq+tsJ0qmX+5zlhx9vw
	kTqasNXn+fVmccbQKn/ASytuIrFeXEWwLVJmES8uepMC4VxuojY+JzSw8j/+5/7SYzVSFrInx70
	BBtsZRkEx6irTSZqGYN5muT7+QbeFiTEWh30BxItWghsoSwYSp89FrJFVjRbWpEDStpBdyxf9U+
	8sSggF6PJHbrD8xqkbS9txo7QI54mk1vMr/UUI35mQpOFFvQbd7v3uKJmxMFRDzi8kvRwB0JZ+a
	qzDkA5Hvs6cYaj/tZVVwvEqscaa2942L+EgIvWoOXOSguLDJtpnzM45zO3AkQwctazXNIM2Hkxc
	HneQW5DlsDN/gpuG9OC9RspSvp1czfU7sD+72Ku0IpvL0yF7q1lu6NBTdUJ6CkdWjXDBwwTbmrK
	6IDT1r7Fi24zc9AkSAfGNLuCMmogw10XfnxiorbkPA=
X-Received: by 2002:a05:6214:246e:b0:8ca:10aa:e1f9 with SMTP id 6a1803df08f44-8cc7b5d16e0mr418713706d6.42.1779939163439;
        Wed, 27 May 2026 20:32:43 -0700 (PDT)
Received: from fedora ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccd78d2ab1sm795366d6.6.2026.05.27.20.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 20:32:43 -0700 (PDT)
Date: Wed, 27 May 2026 22:32:37 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bart Van Assche <bvanassche@acm.org>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/3] loop: cleanup lo_rw_aio
Message-ID: <ahe3VevXiPHqxOGh@fedora>
References: <20260527151043.2349900-1-hch@lst.de>
 <20260527151043.2349900-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527151043.2349900-2-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_203245_124046_D98F8B56 
X-CRM114-Status: GOOD (  13.61  )
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

On Wed, May 27, 2026 at 05:10:20PM +0200, Christoph Hellwig wrote:
> Port over the changes from the zloop driver to remove the need for
> the local bio, bvec and offset variables and clean up the code by
> that.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ming Lei <tom.leiming@gmail.com>

Thanks,
Ming

