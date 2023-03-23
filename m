Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E968CC6FD1C
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Mar 2023 15:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gGyjbK25A5fLzkX+hIsW9kQZpkrTVOcdb2FDSKVkFPQ=; b=lOsxDsWI9OLNkIy4/nhEePDlCx
	wUfv4Vhz1kQwFAxCsldsQvk6C33n4AzQPFOGkUx3pw1FLvdPOifGTm319e3SRn0Ph9BiHOI2Snkq3
	4htZX1NYNlwXc3CgFCGXMeU94nyDvt5sNgU3bAWLZNlcEfmv/MIdQLPAedNH6EJF1Eq4uw71xgPGq
	F5CVEzPLld1gPfPFs13PcpXSzExj7g9hXPXgKS98ok9waGJwH1MRLfQraf8HhIzUKFOVe08VCpkJw
	Rqrq0TuUU2TT7n3hHIcT6mcrPjXYQjULvW/QhXdSKK3upcDBFsmm9mBj1iW4RgWGMzaFY2SkK6G/R
	OA7GgGhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfNKD-002PSv-1P;
	Thu, 23 Mar 2023 15:58:01 +0000
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfNKA-002PRX-06
	for linux-nvme@lists.infradead.org;
	Thu, 23 Mar 2023 15:57:59 +0000
Received: by mail-qt1-x831.google.com with SMTP id hf2so22928943qtb.3
        for <linux-nvme@lists.infradead.org>; Thu, 23 Mar 2023 08:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1679587074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gGyjbK25A5fLzkX+hIsW9kQZpkrTVOcdb2FDSKVkFPQ=;
        b=E0rgqX50pLyXP+81+1VFu1+NvLWajW6EaC3lQOvlQNz/J96UCIafgWL1SnIW6Z3a6b
         nX+J4CA4xizxiSkXAXeSTQRXfD6uANpHRDaDuMJN95SzmcBLSE3pZo0fGsFzTjFlrRDu
         5xaxx0qu0JhEPzo6krnUO7av0rJslRwPNXE+c9dOKobwZhqu4d7arwob0WlS2MiPrHzN
         LiQNBbizMO9hdSZLEJyCjyyfq/99Byf9WYTWxHP4Wgvjq4Dm73jKUR590EKwZZKl3u1S
         3oNI0bP5sc6q01/oh46moJXIW/BeQcwlyp0vJWZx4PTw7H+UDl51LHzn8FSZIxYFWmwU
         3UxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679587074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGyjbK25A5fLzkX+hIsW9kQZpkrTVOcdb2FDSKVkFPQ=;
        b=JTgrRmIluqiijFH1k3Mu6Qfm0eKefRNQv97i8gjRXa0ywWbFyyh8Q4aa5+5qwRXeYr
         y1GBJ0iqSO6L3KCq4df7HpsmcI5Yf+nC/J33tJHK2KDX84FhZh7AFMYSA/63f4DDcfB5
         d6E40l1ZFo8gOjAnzud7dW+UrlW4oIj3miY0vcchpiDM0EnGkwcVCzLHCWFveShkT1hd
         S505S/gbedF5zKctlB0jNZSy/jUsx9D1Y4HdCJPIN7naeVN/N7fco+XxQj9z4HI5kI0D
         lLi9wyufZEn3G/ObBlMFSGAK3Qo1ZwNVxJz56GqbVCNArUyIdJAs8t0xBHvOfJEv5n1X
         DnsQ==
X-Gm-Message-State: AO0yUKXB9mt6/k58lp9/KDVuCKjk9dLn71pb5NvYpx3wS+JMbYHLiPpt
	GD5TlBqplNz164xru2yUd7ZTCBnOnb3JsnAzlDk=
X-Google-Smtp-Source: AK7set+C0r03cEybZ+1MOP3W3s0zXKghh6HbhSu+aoQAuNc5b+ZpVQmRxxUfyLjMcNbp/TYds5SVyw==
X-Received: by 2002:a05:622a:18f:b0:3bf:e13e:438f with SMTP id s15-20020a05622a018f00b003bfe13e438fmr9905893qtw.36.1679587074059;
        Thu, 23 Mar 2023 08:57:54 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id n69-20020a374048000000b00743a0096e8csm13480280qka.39.2023.03.23.08.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 08:57:53 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1pfNK4-001UO9-Ei;
	Thu, 23 Mar 2023 12:57:52 -0300
Date: Thu, 23 Mar 2023 12:57:52 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Leon Romanovsky <leon@kernel.org>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH] blk-mq-rdma: remove queue mapping helper for rdma devices
Message-ID: <ZBx3AI5pothCuvTx@ziepe.ca>
References: <20230322123703.485544-1-sagi@grimberg.me>
 <ZBr6kNVoa5RbNzSa@ziepe.ca>
 <c51d3d99-5bc9-cb47-6efa-5371ef3cc0f4@grimberg.me>
 <ZBsHnq6FlpO0p10A@ziepe.ca>
 <20230323120515.GE36557@unreal>
 <ZBxOHZwre3x8DkWN@ziepe.ca>
 <e1b00740-3c75-8b90-4d68-76a5f341a117@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1b00740-3c75-8b90-4d68-76a5f341a117@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230323_085758_369738_C61CC795 
X-CRM114-Status: GOOD (  25.48  )
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

On Thu, Mar 23, 2023 at 05:07:24PM +0200, Sagi Grimberg wrote:
> 
> > > > > > > No rdma device exposes its irq vectors affinity today. So the only
> > > > > > > mapping that we have left, is the default blk_mq_map_queues, which
> > > > > > > we fallback to anyways. Also fixup the only consumer of this helper
> > > > > > > (nvme-rdma).
> > > > > > 
> > > > > > This was the only caller of ib_get_vector_affinity() so please delete
> > > > > > op get_vector_affinity and ib_get_vector_affinity() from verbs as well
> > > > > 
> > > > > Yep, no problem.
> > > > > 
> > > > > Given that nvme-rdma was the only consumer, do you prefer this goes from
> > > > > the nvme tree?
> > > > 
> > > > Sure, it is probably fine
> > > 
> > > I tried to do it two+ years ago:
> > > https://lore.kernel.org/all/20200929091358.421086-1-leon@kernel.org
> > 
> > Christoph's points make sense, but I think we should still purge this
> > code.
> > 
> > If we want to do proper managed affinity the right RDMA API is to
> > directly ask for the desired CPU binding when creating the CQ, and
> > optionally a way to change the CPU binding of the CQ at runtime.
> 
> I think the affinity management is referring to IRQD_AFFINITY_MANAGED
> which IIRC is the case when the device passes `struct irq_affinity` to
> pci_alloc_irq_vectors_affinity.
> 
> Not sure what that has to do with passing a cpu to create_cq.

I took Christoph's remarks to be that the system should auto configure
interrupts sensibly and not rely on userspace messing around in proc.

For instance, I would expect that the NVMe driver work the same way on
RDMA and PCI. For PCI it calls pci_alloc_irq_vectors_affinity(), RDMA
should call some ib_alloc_cq_affinity() and generate the affinity in
exactly the same way.

So, I have no problem to delete these things as the
get_vector_affinity API is not part of solving the affinity problem,
and it seems NVMe PCI doesn't need blk_mq_rdma_map_queues() either.

Jason

