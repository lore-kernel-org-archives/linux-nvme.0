Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 119EAC6FA90
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Sep 2022 15:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=C81BnwO1LLn7rzdtw/smuBPO9/byip/ucPGw7WJmXyg=; b=R+1oo7dY9wIli5
	UsZVi6yXVD4zZZYVXxK4Xc4IDyW4Vtd6a2boPHePYVC4NDH3BkvzjYALf+fpi84V4L4FaVrOp8pMB
	NdRPh252aR4+fBCfJ8yuW5QScJVyFGESqTpBxgNw7e9XRlq/3AgUt80yTyUxg1J/N1fYtqezDJLbF
	MBJT0H9NuqoBa4nNRoCpxS3FRnwRBmKlFo9R+hL7TxLBqUQDVPpy//XQsidl/J7gtR9j7NXPXf6aq
	jZEGwq7O/p5Bx+LoaJCy5I0EnkFwwjjHxhow+nKVaAWS2rOdWR10l6ltbq3Q0Kh2xLDsIoZ9uIlDH
	KONeB7bkMoSYyEpF3Pig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obkZ8-004oDR-Sp; Fri, 23 Sep 2022 15:26:10 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obkZ5-004oCD-LD
	for linux-nvme@lists.infradead.org; Fri, 23 Sep 2022 15:26:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=C81BnwO1LLn7rzdtw/smuBPO9/byip/ucPGw7WJmXyg=; b=EJgXMvWjdf974BGnhZ/H5B5xwv
	NXJvfp4f6oUfUKuWpK1vn1hJDJ0w7XSUyC8/69ObFbcR/PleMfld5liF8hFbsFBeRRknZIjUPWs3X
	yXCrUnVnYpYjPoX7DA9F2T28JKXXJEIV7eTiD4lUYvbR+CyKq571MvlRFoZLyNdx9mPjUl2mvtlUo
	4fENvdIPwCyPgnqLNKCqyCRjsdhyoNHJAHPEzP7urRTm3wzaZDx02UPRrCfibr/1UFAwFMnP9bcfC
	s6eTzyHYgenOqLfahifc1Kx60xlysc8n5Vi/VtS1oTf1H5v275xPlJz5io+LMX8mSVIvh25GxjhUK
	dq0M7DHg==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <logang@deltatee.com>)
	id 1obkYz-008uiH-2J; Fri, 23 Sep 2022 09:26:01 -0600
Message-ID: <47004362-15ec-5356-6c1e-ba69b1910cef@deltatee.com>
Date: Fri, 23 Sep 2022 09:25:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-CA
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, Daniel Vetter
 <daniel.vetter@ffwll.ch>, Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Ira Weiny <ira.weiny@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Ralph Campbell <rcampbell@nvidia.com>, Stephen Bates <sbates@raithlin.com>
References: <20220922163926.7077-1-logang@deltatee.com>
 <20220923060123.GA15698@lst.de>
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20220923060123.GA15698@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: hch@lst.de, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, gregkh@linuxfoundation.org, dan.j.williams@intel.com, jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, dave.b.minturn@intel.com, jason@jlekstrand.net, dave.hansen@linux.intel.com, jianxin.xiong@intel.com, helgaas@kernel.org, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, rcampbell@nvidia.com, sbates@raithlin.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v10 0/8] Userspace P2PDMA with O_DIRECT NVMe devices
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220923_082607_719714_0B269677 
X-CRM114-Status: GOOD (  14.08  )
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




On 2022-09-23 00:01, Christoph Hellwig wrote:
> Thanks, the entire series looks good to me now:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Given that this is spread all over, what tree do we want to take it
> through?

Yes, while this is ostensibly a feature for NVMe it turns out we didn't
need to touch any NVMe code at all.

The most likely patch in my mind to have conflicts is the iov_iter patch
as there's been a lot of churn there in the last few cycles and there
are continued discussions.

There are 2 PCI patches, but Bjorn's aware of them and has acked them.
I'm also fairly confident this shouldn't conflict with anything in his tree.

Besides that, there is one mm/gup patch which is the next likely to
conflict; one scatterlist patch and three block layer patches which have
largely been stable when I've done rebases.

Logan

