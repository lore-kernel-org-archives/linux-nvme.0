Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41754C44515
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2026 15:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cQJcbivB06LUeR8fEVZ640cFExN3f0ofPOWFG+trce4=; b=XNPSakkw37Ctas
	J1cUorrr2VoJcjNcEr5GLtmxgkry4P0oz0C+HMEYqIfjI10IpVfjpNysFlne+9q+EjHhMPxghFyNB
	eCC5WBwESo34SmwXBSyPxN9Col/gBYxFOHk61UeeHUTe7MU0EA0EGQ2bn1BYfhv0Yfknw493B8pEN
	PiwUMLVu6rgs7c3TXj3fUv9Y4QKbD/FSBQhD7HvrPSuzhdPpYgTcOvo6HRJOjRho4dUX8OGF9IL/p
	EfR03HvXHJTYRRaPaoF/DnhQ3uzqfHgg70KyE80oUf7k8O7dnB5a332oHnp8o97aeWg4LVxn4b9rW
	NfqohxIMKbgBJCRQ/HAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlqOb-00000007HvD-0Cij;
	Mon, 20 Jul 2026 15:59:09 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlqOY-00000007HuM-3ifD
	for linux-nvme@lists.infradead.org;
	Mon, 20 Jul 2026 15:59:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=cQJcbivB06LUeR8fEVZ640cFExN3f0ofPOWFG+trce4=; b=nznyCqQe109737/c013kSuon6G
	oJtENCeICPQ703VOz3VGz16PIL2sFqY3vx4wsPJvsQ8kP8ToTuH4hArmC21fm0T9qGFWTdyuSaY8C
	09dZbBnX7H47XjthYepcAW544lcAyPtyAo5NI47t3G28q0oXDOEguq3w3DGWGabjRt5qLPtjDSAbW
	i5diWFZrHzkDww6r1RdKT8IsCGes1kxI021uL7nEDPQtZg+ZWdSt/VRzOb5tujotWydtCzC8f1ZDS
	FwYP9Vfhy4ojAVDN5o87R1/W/yjXZPKR2xRagVFguNy76R78FHcs2lZvJVg7M13qV+UbVRGAUMK4N
	b3SFwc3w==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wlqOS-0000000B5xA-0AZp;
	Mon, 20 Jul 2026 09:59:00 -0600
Message-ID: <426e56e7-0248-4b85-bb59-2da6816443ab@deltatee.com>
Date: Mon, 20 Jul 2026 09:58:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Mykola Marzhan <mykola@meshstor.io>, Jens Axboe <axboe@kernel.dk>,
 Song Liu <song@kernel.org>, Yu Kuai <yukuai@fygo.io>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: Li Nan <magiclinan@didiglobal.com>, Xiao Ni <xiao@kernel.org>,
 Leon Romanovsky <leonro@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Kiran Kumar Modukuri <kmodukuri@nvidia.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Shivaji Kant <shivajikant@google.com>, Pranjal Shrivastava
 <praan@google.com>, Henrique Carvalho <henrique.carvalho@suse.com>,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20260718162547.448892-1-mykola@meshstor.io>
 <20260718162547.448892-2-mykola@meshstor.io>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260718162547.448892-2-mykola@meshstor.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: mykola@meshstor.io, axboe@kernel.dk, song@kernel.org, yukuai@fygo.io, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, linux-block@vger.kernel.org, linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org, magiclinan@didiglobal.com, xiao@kernel.org, leonro@nvidia.com, jgg@nvidia.com, kmodukuri@nvidia.com, kch@nvidia.com, bhelgaas@google.com, shivajikant@google.com, praan@google.com, henrique.carvalho@suse.com, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 1/6] blk-mq-dma: restore BLK_STS_TARGET for unsupported
 P2P transfers
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260720_085906_925733_07E4B10A 
X-CRM114-Status: UNSURE (   6.15  )
X-CRM114-Notice: Please train this message.
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



On 2026-07-18 10:25, Mykola Marzhan wrote:
> Fixes: 858299dc6160 ("block: add scatterlist-less DMA mapping helpers")
> Fixes: 7ce3c1dd78fc ("nvme-pci: convert the data mapping to blk_rq_dma_map")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Mykola Marzhan <mykola@meshstor.io>


Looks correct to me, thanks!

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

