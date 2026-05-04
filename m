Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA0DFF885A
	for <linux-nvme@archiver.kernel.org>; Mon,  4 May 2026 15:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JTReAJBRtrEN050pOinCvG1qLugpFlFxRiDBF5vEgm4=; b=rxFzSW/fJmHlbLxpiN78DMYWgg
	lXeDc7KWhdh3CoyyEnK2fAocgyUd3lJaRnO9jZcEfhWuC4aHfQVlfvavblQvH1iF0P3isya9dVzR8
	FM7t4ObJ0GTN9krvFwf0x2ut33hGbzfXclZ0x8wa5ppRXV2hSzcTHyfubTul8db8SyC4HV02E7oWl
	40Mz/ZlpceUQE4evIHn5zpvYZncFNA8cmJ3F3HnyfnrQSd9rIKX3SHp61VVC4Ywe425tvnw4NA23c
	g4n8hb/DQJVhdU48zY3I5FNnNlzL9Q2pTwtZPcN4EOj7kNp19BePWD/HONYAjIhTA5Z1gth3D8P8u
	QGXEVSyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wJvFS-0000000DbdH-3yrW;
	Mon, 04 May 2026 15:30:18 +0000
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wJvFR-0000000Dbca-0SMt
	for linux-nvme@lists.infradead.org;
	Mon, 04 May 2026 15:30:18 +0000
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso33782025e9.3
        for <linux-nvme@lists.infradead.org>; Mon, 04 May 2026 08:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777908615; x=1778513415; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JTReAJBRtrEN050pOinCvG1qLugpFlFxRiDBF5vEgm4=;
        b=ciR9w7DCBMijgsjvW1p0iIp/DQXWzWQUzXaPvdNDvYriJ4iV38V/7Vt4gaNfUYRN8m
         0mHa5l31/mIhJ6yJkXL+ZDC6vPegqtJ6VD2nwQQah495g07JeDH+1oE0RuyKdnX6UfkT
         ehu2H0Bdg+pxWoedOf20Gomuv/mD5FIyr8qCmjkzgQ3FUZUEbAki1xQAvLmwI4gw/H9/
         mMOcVtQFRrZzhvRQXv3QswMexfXZhm7WFWP/uivQyduB8CelAW6K7E5ZLz7AVW2CtPN3
         HiJznmlHT8tl86ny1zST2/NhC/o1bFN+CZj7hsEE7dvzD5OXOU60qv4ssKbSdDas6gWv
         pPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777908615; x=1778513415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JTReAJBRtrEN050pOinCvG1qLugpFlFxRiDBF5vEgm4=;
        b=X21czmjJ81AGYDs8FbHDzSdZB9exdqoDW9nHrDxyTZklh6ZC7mD+ID6khBnHNF8p65
         /ojjSJHYIS0Dowr6OFfGMi279hogNpk2BYxoQMiCFjl7a5Dfo0i9zIbcPigAUmFNO8gw
         RbXQmgoT2BT5DtpMBaCiVKKHyMwP7CqS8NGj6aiezHV52HN76FyuV3VsyEJeEzvdu1Ai
         5gh6IJSY5t5mqQcGMRbItt6cSRwnRaDZp2t2vsEnI88t8hGtYYfh4dlKDDN3+P2xYEYK
         7GOwd7VrIvPD1UA0fk+4Lc605JBYS8AUiB+JFqWaRyaCyXTx85K3TekBnK6e7sFRxFMZ
         JzxQ==
X-Forwarded-Encrypted: i=1; AFNElJ+jLijt9Pp/6/d2PbBcSHYAoqforsGuOa387Ser13giNaGEHQy1t5uqBozSvcC8QsGzKsfLbCKlQNlU@lists.infradead.org
X-Gm-Message-State: AOJu0YwVLQ/oZ/jSGo+A2AsYFthiJ2m7QG01lqnTO6p4ttR4EZgSvRBr
	jCYNIRD1fbPDBLlqlM49ZY3UZy0KXQC4WJend6ZFpBc3wvgJrvS8YtCH
X-Gm-Gg: AeBDietq+Y9/Guu3GhmjPDx+Ad7ZcRyIF8To3pFZ5xMkJU2o1sOpgjYIwovWwuF7XaU
	gDgrdDdXjsXC58tpaULtzypNUdf2p25JTqf+UJOsly3hQorxfJI8Mp6WbZbelbl3B2zrdYYG7lU
	sG0dLRNIeNoajSSapz92tvhT+G/pbYjQcf7Ipzn1X8h2KkZ18s/8DaI2tJLzRyNWwacgeba8+Zt
	gWOHQKmIP2TjFpsbJDLciDJJEjhnnnObudX1opWWxr9uawzGLBs+lZMzpjLtNqolGlAseSHvCHR
	mlYt9Jvj6ZMhxwFEbXl9yq0H6HRXeAbQ40zmF625DrDjhiFiYizNvQs6NpofK8hgImD8iXQiuBA
	sp1i9BRJojLZ2c6U/prXCmQh3+VVa6yhFULWJA3X1PbIwGMfpZfV38IWI+G79ulXW37owXR83cH
	BGrfgf4tpkodTMjKdQ+Cse5IfEyAVefli4MO0Pn9ggpVV8sH5ingjn9OQKEoQe8pxnneO2wcGQg
	c4nAgvscFB0J+PbYEK0kg2Q
X-Received: by 2002:a05:600c:4f91:b0:489:1ba8:5be9 with SMTP id 5b1f17b1804b1-48a98676b26mr157938505e9.29.1777908614504;
        Mon, 04 May 2026 08:30:14 -0700 (PDT)
Received: from fedora (185-147-212-251.par.as62651.net. [185.147.212.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a8ea7cfd2sm25250825f8f.2.2026.05.04.08.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 08:30:13 -0700 (PDT)
Date: Mon, 4 May 2026 23:29:55 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 00/10] Add dmabuf read/write via io_uring
Message-ID: <afi7c-VUJWOLlC1m@fedora>
References: <cover.1777475843.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1777475843.git.asml.silence@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260504_083017_192533_4CA63491 
X-CRM114-Status: GOOD (  24.97  )
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

On Wed, Apr 29, 2026 at 04:25:46PM +0100, Pavel Begunkov wrote:
> The patch set allows to register a dmabuf to an io_uring instance for
> a specified file and use it with io_uring read / write requests. The
> infrastructure is not tied to io_uring and there could be more users
> in the future. A similar idea was attempted some years ago by Keith [1],
> from where I borrowed a good number of changes, and later was brough up
> by Tushar and Vishal from Intel.
> 
> It's an opt-in feature for files, and they need to implement a new
> file operation to use it. Only NVMe block devices are supported in this
> series. The user API is built on top of io_uring's "registered buffers",
> where a dmabuf is registered in a special way, but after it can be used
> as any other "registered buffer" with IORING_OP_{READ,WRITE}_FIXED
> requests. It's created via a new file operation and the resulted map is
> then passed through the I/O stack in a new iterator type. There is some
> additional infrastructure to bind it all, which also counts requests
> using a dmabuf map and managing lifetimes, which is used to implement
> map invalidation.
> 
> It was tested for GPU <-> NVMe transfers. Also, as it maintains a
> long-term dma mapping, it helps with the IOMMU cost. The numbers
> below are for udmabuf reads previously run by Anuj for different
> IOMMU modes:

Plain registered buffer is long-live too, which raises question: does this
framework need to take it into account from beginning?

BTW, inspired by this approach, I adds similar feature to ublk via UBLK_IO_F_SHMEM_ZC
which can maintain long-term vfio dma mapping over registered user-place aligned buffer.



Thanks, 
Ming

