Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87040C76195
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Mar 2023 13:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JT5kxqVOLNs1cddye30QvhqujBIE6P8vkXfghBDUxrs=; b=ZSyBb2Mfmwa0h3sNhXyr27ou+A
	IB80tS0YnmnKrEG2Kn9AVPfNrBtWzh8O/iDeAnYS37v+rNYHGb/ilTvJFiz1fhaT1x55b6fZCTwi7
	mcgiMAwJefaa2+DwTGelctq5apZmt1fUgqdAeWGK/PVFvd/LsUJmwIeDj/61AApid8zeEDJAUoYl+
	k3MmXurJ39h/DIYFFOz9Fp1JJVTp62BASdx8HQPGNevpxiyI2fh1Tf5kqXWn96fa6RAfXAB1x+2xA
	Oy3P6JGiaB8r4AGNun833+GzHmBdxuWIiW9iy+vFRGZktkqA6ZosI9szNK0A6jZ9GeMvP9mUQis5u
	ky/EwDGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfKbO-0020VX-2w;
	Thu, 23 Mar 2023 13:03:34 +0000
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfKbI-0020Ul-28
	for linux-nvme@lists.infradead.org;
	Thu, 23 Mar 2023 13:03:33 +0000
Received: by mail-qt1-x829.google.com with SMTP id n2so26418350qtp.0
        for <linux-nvme@lists.infradead.org>; Thu, 23 Mar 2023 06:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1679576607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JT5kxqVOLNs1cddye30QvhqujBIE6P8vkXfghBDUxrs=;
        b=fsnlSj1wYC+oyegO1q1yDBhN8AGGfS4B+/UJULqMDG1jdL9i5Fbq8O1r0UzJVbgZ5N
         CurbRDFSblDK9jc415qglfplweQjxGgBmqJhkAyt51A78hYTvBHd5fNCjBUuHTPn12EM
         Y1zKMRG6J4vTDaSNZyUJtcdDE+Bc4WCdEGj2SxETTQC9dX65jzYjndPxJagfadtzcHCH
         KucPqK8M85ho9lf87J55E+JMepmXIqa3pD+e1u9JzACYKTlMkED7tsKMjIDWBNd1fGTF
         U3Y7TJ6KcgnjkwfOD17f24lPxk4X4kA8SUtwmE3gF+qqh2vrzBTq+F7nq338bAMfL5EK
         qakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679576607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JT5kxqVOLNs1cddye30QvhqujBIE6P8vkXfghBDUxrs=;
        b=UwKBeOB92e4l0Lkj/TjaDz/hYCeH4+u44XrjefxcxkC2XMNxH4qdM3/2fbugV6BNWP
         Luv7QyQnG8MF9j+aaeB9s4HJdLe8hbcGWHow4UreerveJO3elsnkFL6zPS7uQ4mcnwz/
         kT7bzNWDBwWiubV/6uRY7tRzBV5Zy0WFmxPag3gggzCTNMQ0jEySuwxOfMy6AkHgAnhB
         aISBmJ0tenazLtnWIQ+xOTtKmFTlhsZvZaHvq+L6rsJZteoLkcxg48uZWYFqvTSiYFf1
         SjRMnSoVnCXxP0Qr02ezuExtxGz2D9AIvw1a65HVlLzE1quzCepZ2YWgdEEpLydpKRMC
         ATLQ==
X-Gm-Message-State: AO0yUKV0tDE4g7//x1vR65hhzD7Dm9aWgKP+qFJNlrMchP6dqqa0loFI
	kyK9KMDYxY9tupzrZ0/3+uUOO0XzhcX5VfnTz9E=
X-Google-Smtp-Source: AK7set9Nd0IROYibAsNWzp2/wBVMkNxgJf3eiBJQdDWBUctTuOee3WY/j00WoSi5pcTukOCIoBjA4w==
X-Received: by 2002:ac8:7dd1:0:b0:3e2:7a9e:a04e with SMTP id c17-20020ac87dd1000000b003e27a9ea04emr9731248qte.18.1679576606971;
        Thu, 23 Mar 2023 06:03:26 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id c9-20020ac80549000000b003d8d1ec2672sm11612362qth.89.2023.03.23.06.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 06:03:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1pfKbF-001D0h-LK;
	Thu, 23 Mar 2023 10:03:25 -0300
Date: Thu, 23 Mar 2023 10:03:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH] blk-mq-rdma: remove queue mapping helper for rdma devices
Message-ID: <ZBxOHZwre3x8DkWN@ziepe.ca>
References: <20230322123703.485544-1-sagi@grimberg.me>
 <ZBr6kNVoa5RbNzSa@ziepe.ca>
 <c51d3d99-5bc9-cb47-6efa-5371ef3cc0f4@grimberg.me>
 <ZBsHnq6FlpO0p10A@ziepe.ca>
 <20230323120515.GE36557@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323120515.GE36557@unreal>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230323_060328_904077_9BF9152E 
X-CRM114-Status: GOOD (  19.63  )
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

On Thu, Mar 23, 2023 at 02:05:15PM +0200, Leon Romanovsky wrote:
> On Wed, Mar 22, 2023 at 10:50:22AM -0300, Jason Gunthorpe wrote:
> > On Wed, Mar 22, 2023 at 03:00:08PM +0200, Sagi Grimberg wrote:
> > > 
> > > > > No rdma device exposes its irq vectors affinity today. So the only
> > > > > mapping that we have left, is the default blk_mq_map_queues, which
> > > > > we fallback to anyways. Also fixup the only consumer of this helper
> > > > > (nvme-rdma).
> > > > 
> > > > This was the only caller of ib_get_vector_affinity() so please delete
> > > > op get_vector_affinity and ib_get_vector_affinity() from verbs as well
> > > 
> > > Yep, no problem.
> > > 
> > > Given that nvme-rdma was the only consumer, do you prefer this goes from
> > > the nvme tree?
> > 
> > Sure, it is probably fine
> 
> I tried to do it two+ years ago:
> https://lore.kernel.org/all/20200929091358.421086-1-leon@kernel.org

Christoph's points make sense, but I think we should still purge this
code.

If we want to do proper managed affinity the right RDMA API is to
directly ask for the desired CPU binding when creating the CQ, and
optionally a way to change the CPU binding of the CQ at runtime.

This obfuscated 'comp vector number' thing is nonsensical for a kAPI -
creating a CQ on a random CPU then trying to backwards figure out what
CPU it was created on is silly.

Jason

