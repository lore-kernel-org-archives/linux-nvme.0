Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 638F2C44520
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2026 18:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:From:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tWVcfovXhN8cxDj/Xsa7BNxive3cX8kl3EtbJmWADi0=; b=1f3M19+LRoGqB/
	Bc32U3x0f/XbhtmbuvhqcDgccdGHYCT6XllN4B1Tm9AVwkEYVVazOO8yBB+exUFE1QUkhKukUFlYi
	L9te/FSQAE6oQvvwL4Hok2IScVj5ExWjVO86dcrvjhjVfxu4190i6Y1La/6e0qGJ2iWUWrgj6dTJT
	9w05SjWBkaMda7BTfQVG6kvB3dyriNKGtuDlUnPeByvrt+h1TIYASFmTd6aNHC4JVDWxEEDqkshvg
	Gn1IouhdVXztVurwa7DzUS1j/waPP4B1GJ6nqTPS5I33uU4iyOXSiHaC/7GI/vrSmhSqbje6DrtN9
	50E46ye7M3RWDXcg1/ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlt3p-00000007gt8-17xr;
	Mon, 20 Jul 2026 18:49:53 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlt3m-00000007gsa-1qIH
	for linux-nvme@lists.infradead.org;
	Mon, 20 Jul 2026 18:49:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:References:Cc:To:From:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=tWVcfovXhN8cxDj/Xsa7BNxive3cX8kl3EtbJmWADi0=; b=AZbZhiSJqYd3Zz72aRzaU2Q+7r
	LeHCfYG/DCURfZzP0tmeStZbYIgmTYtJBtAAUpV9AIineZrVT2anzIPDHsduvcAazBuhSH7uuYiu4
	yCnQ1pN3uusFysYxxTRM+xQ85WuBSNqX5iOTYNrPPPls3lDtgw0btWJ5oSSaAwRv0y8ARiVMsa7+b
	9/RzsOOwSpCVDDm7Xw4SxMiKqWs6WiF9JscB4LgWxTyjEoak6tEdMmm1m3krjjJENiXJMSWahzWMM
	89u0YkHKTGFZXEBSs7eXuA5ewRYSMMWexkmYsc49e53+W9k/KDLJv9xHs0ftQT72hBnxSO1oHrr+C
	lQEChNyA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wlt3h-0000000B7lj-3Vlj;
	Mon, 20 Jul 2026 12:49:46 -0600
Message-ID: <cb297ebf-3731-425a-8f48-6be3c7944366@deltatee.com>
Date: Mon, 20 Jul 2026 12:49:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Logan Gunthorpe <logang@deltatee.com>
To: Mykola Marzhan <mykola@meshstor.io>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>,
 Yu Kuai <yukuai@fygo.io>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
 Li Nan <magiclinan@didiglobal.com>, Xiao Ni <xiao@kernel.org>,
 Guoqing Jiang <guoqing.jiang@linux.dev>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kiran Kumar Modukuri <kmodukuri@nvidia.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Shivaji Kant <shivajikant@google.com>, Pranjal Shrivastava
 <praan@google.com>, Henrique Carvalho <henrique.carvalho@suse.com>,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20260719105327.864949-1-mykola@meshstor.io>
 <20260719105327.864949-2-mykola@meshstor.io> <20260720144943.GA17375@lst.de>
 <CAPzsNDv6hUV3gHdaxuwjRcr4couUKq_M5DKObFNaYqCHnm7ZMw@mail.gmail.com>
 <b2c37f4f-79dd-428f-915a-2a862d20924c@deltatee.com>
Content-Language: en-CA
In-Reply-To: <b2c37f4f-79dd-428f-915a-2a862d20924c@deltatee.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: mykola@meshstor.io, hch@lst.de, axboe@kernel.dk, song@kernel.org, yukuai@fygo.io, kbusch@kernel.org, sagi@grimberg.me, linux-block@vger.kernel.org, linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org, magiclinan@didiglobal.com, xiao@kernel.org, guoqing.jiang@linux.dev, leon@kernel.org, jgg@ziepe.ca, kmodukuri@nvidia.com, kch@nvidia.com, bhelgaas@google.com, shivajikant@google.com, praan@google.com, henrique.carvalho@suse.com, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v2 1/7] blk-mq-dma: restore BLK_STS_TARGET for unsupported
 P2P transfers
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260720_114950_481479_C75FDC27 
X-CRM114-Status: GOOD (  19.79  )
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



On 2026-07-20 12:42, Logan Gunthorpe wrote:
> 
> 
> On 2026-07-20 11:30, Mykola Marzhan wrote:
>> On Mon, Jul 20, 2026 at 4:49 PM Christoph Hellwig <hch@lst.de
>>> This is a really weird writing style, and suggested to me you neither
>>> understand the code nor the problem.  Please actually think yourself,
>>> write the patches and commit logs yourself instdad of this garbage.
>>>
>>> And please also explain how you even generate the I/O that fails this
>>> way.
>> - md mirrors the write: the copy to member 1 succeeds, the copy to far
>> member fails as BLK_STS_INVAL.
>> - md deliberately ignores BLK_STS_INVAL, so the write is counted as
>> written and the mirror silently diverges.
> 
> Seeing I just reviewed this and answered it for myself I'll expand on
> what's going on here:
> 
> The switch statement will take the default branch when
> pci_p2pdma_state() returns PCI_P2PDMA_MAP_NOT_SUPPORTED. This indicates
> the memory that's trying to be mapped in this way will not succeed
> because it's going through an unsupported host bridge (or if the device
> isn't a PCI device, etc, but this is rarer or perhaps not possible).
> Returning BLK_STS_INVAL doesn't seem correct here, to me. (Arguably it
> might have been clearer if the switch case explicitly stated
> PCI_P2PDMA_MAP_NOT_SUPPORTED instead of relying on the default).
> 
> Returning -EREMOTEIO/BLK_STS_TARGET was the convention for this I had
> originally set when I wrote some of this and differentiating the error
> does seem important in Patch 6 in this series.

Sorry, one other note I almost forgot about which is probably important:
BLK_STS_INVAL will attempt a retry, where BLK_STS_TARGET will not (I
think that's part of why I chose that specific error in the first
place). A retry here doesn't make any sense because it will always hit
the same case and fail. So it's probably worth applying this patch even
without the specific error being used in Patch 6.

Logan



