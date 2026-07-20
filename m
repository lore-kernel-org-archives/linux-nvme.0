Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FBE0C44515
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2026 18:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YELh0b3QajkSD4msD1qE3xlvEfmbrtR4vMSO8zUFNP4=; b=PYjJwPoy3nLsGl
	lYjI6O1pSERTbQ1J9XvCTiiDayJi5DRUi44zb1n68oiiP2+FxFUQlNtr2oiN0yPtIbk7Dstcbgdqk
	GVKkurmVVRZ8PhIxkD8PfETmmt/e+fBkXIaqQ69BBKLDMh9DzAteGfY50+myvgZiHXhyX2hKafZ5r
	0FlS7PK9/oAATXF6O111bFrpf3hlvUs0fmuF4wrYZ3Jy1xe1kQGkHYTcMJ0Q4Hh7RhWYSpbpmv6f6
	5DiPigfk6FUOGgJK+Kgd0cO/hqRr78BwCwY5u4qLbeazbLIzDX87rHJYo/qhf0tC4D9LXkrbS6PqG
	E5BrIEvcKtIoym2xCxIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlsxS-00000007gGS-19jj;
	Mon, 20 Jul 2026 18:43:18 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlsxP-00000007gG2-2k5u
	for linux-nvme@lists.infradead.org;
	Mon, 20 Jul 2026 18:43:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=YELh0b3QajkSD4msD1qE3xlvEfmbrtR4vMSO8zUFNP4=; b=G78R0G4ApJYfZi/9vAbiWuWhBT
	yw/nzVk23WLIDxAxG4p8fgkx8rE8TaNly1j1YYzp9MmCQmD6/RWuWBzYbnqTsTMtJzGYBKOoGWby+
	4SiaXgSFbifrGrkVFDWWqFSYfoLAAhIniOb3YLTfQ/mhFupBe+ASo7FyWIIN8AlHr4OljXgP6eDLZ
	ZzplaghNrp6Xw9vS7ZQUgHAAgVWAwO7MFIEoOSECgJEQk5WcUbXOJQlnQeIrPHt2hGm5+JRpqg28C
	ugA/Edsoo0QLXysrw65j4Sfe39CWGmpmmtuRxwM8liCCK6a4Qnt0KZy6m3GUjPmjP0+dB8Jxld5FH
	XAKLxcJg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wlsxK-0000000B7jc-1nFA;
	Mon, 20 Jul 2026 12:43:11 -0600
Message-ID: <b2c37f4f-79dd-428f-915a-2a862d20924c@deltatee.com>
Date: Mon, 20 Jul 2026 12:42:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <CAPzsNDv6hUV3gHdaxuwjRcr4couUKq_M5DKObFNaYqCHnm7ZMw@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20260720_114315_694165_FFD71E4D 
X-CRM114-Status: GOOD (  14.96  )
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



On 2026-07-20 11:30, Mykola Marzhan wrote:
> On Mon, Jul 20, 2026 at 4:49 PM Christoph Hellwig <hch@lst.de
>> This is a really weird writing style, and suggested to me you neither
>> understand the code nor the problem.  Please actually think yourself,
>> write the patches and commit logs yourself instdad of this garbage.
>> 
>> And please also explain how you even generate the I/O that fails this
>> way.
> - md mirrors the write: the copy to member 1 succeeds, the copy to far
> member fails as BLK_STS_INVAL.
> - md deliberately ignores BLK_STS_INVAL, so the write is counted as
> written and the mirror silently diverges.

Seeing I just reviewed this and answered it for myself I'll expand on
what's going on here:

The switch statement will take the default branch when
pci_p2pdma_state() returns PCI_P2PDMA_MAP_NOT_SUPPORTED. This indicates
the memory that's trying to be mapped in this way will not succeed
because it's going through an unsupported host bridge (or if the device
isn't a PCI device, etc, but this is rarer or perhaps not possible).
Returning BLK_STS_INVAL doesn't seem correct here, to me. (Arguably it
might have been clearer if the switch case explicitly stated
PCI_P2PDMA_MAP_NOT_SUPPORTED instead of relying on the default).

Returning -EREMOTEIO/BLK_STS_TARGET was the convention for this I had
originally set when I wrote some of this and differentiating the error
does seem important in Patch 6 in this series.

Logan

