Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68431C44520
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2026 16:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YYL05epQu09BiBSr5PNusLFDqwuNDaosRFFB/h9tybo=; b=U3/LAq6i4JPZYk
	XqHSsYZRI1iy/lk4eSjIIX9in9iNOl7m2PNfiEst0OUmgNHgboCQbjkvcI9d8OW6JOk/M5TReHyWp
	14GMHTUmHxqqQEbrBvvxVoWcb/+yI9ZdG8DMBQBzqpkQ+nzTTnwEfqPkoDIXGWZa2S0E4ioldX5vv
	XfPlydDXQNd1pvvqtgMzAxcf3fhKRipVICvBonPILgiaQChQ2pWxX5oVE7MYwEUkoY2JvFULxeDiI
	o39UQ4uyo0ZH5H1H2k0oidBnX9U4iwx2sie4NZxQMT1vH60OTw7Y8cu1PVOgAmGfKGWHnXeyGYxGx
	vrxLhtMJiQgI8KgCeVVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlrB2-00000007Qpa-1tuF;
	Mon, 20 Jul 2026 16:49:12 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlrAz-00000007QoT-2vI2
	for linux-nvme@lists.infradead.org;
	Mon, 20 Jul 2026 16:49:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=YYL05epQu09BiBSr5PNusLFDqwuNDaosRFFB/h9tybo=; b=lUrb8QGAIKHH8XNsAn4DH31GNb
	7pJSLAJ+N2/ga/ONySFdI6oDNwO8URdhxhAm6ZNuQa26FXOsO2znTZkY00e2aH22cCAMuVle9ks2Y
	Jr04yHux6mPAh+g1sezb74gocr26o+tUenFYzOGV4C+DaIEcN+uAOE3Cq4sop5niXyY06EQoU1u9J
	c/0pPGEMLPjZrQKaRx/UGUGgwedzCqf/0oV49O2oaAtNe7NMCYayNPy9R80kaDuSmONndf/rwSTcX
	J8lTc3kqqITZ1jaCi92f5gnRAAuR0TrGD7bB02G7r5qWnjJyHSaRJM4mozl6wb/RLibcfS4on2/TH
	DVH/wUig==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wlrAv-0000000B6Zd-40ka;
	Mon, 20 Jul 2026 10:49:06 -0600
Message-ID: <ee312bcb-92f4-4884-91cd-3bd56180c8c7@deltatee.com>
Date: Mon, 20 Jul 2026 10:49:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Mykola Marzhan <mykola@meshstor.io>, Jens Axboe <axboe@kernel.dk>,
 Song Liu <song@kernel.org>, Yu Kuai <yukuai@fygo.io>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: Li Nan <magiclinan@didiglobal.com>, Xiao Ni <xiao@kernel.org>,
 Guoqing Jiang <guoqing.jiang@linux.dev>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kiran Kumar Modukuri <kmodukuri@nvidia.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Shivaji Kant <shivajikant@google.com>, Pranjal Shrivastava
 <praan@google.com>, Henrique Carvalho <henrique.carvalho@suse.com>,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20260719105327.864949-1-mykola@meshstor.io>
 <20260719105327.864949-7-mykola@meshstor.io>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260719105327.864949-7-mykola@meshstor.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: mykola@meshstor.io, axboe@kernel.dk, song@kernel.org, yukuai@fygo.io, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, linux-block@vger.kernel.org, linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org, magiclinan@didiglobal.com, xiao@kernel.org, guoqing.jiang@linux.dev, leon@kernel.org, jgg@ziepe.ca, kmodukuri@nvidia.com, kch@nvidia.com, bhelgaas@google.com, shivajikant@google.com, praan@google.com, henrique.carvalho@suse.com, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v2 6/7] md/raid1,raid10: skip futile retries on P2PDMA
 mapping failures
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260720_094909_742145_AD6B0DCB 
X-CRM114-Status: GOOD (  11.12  )
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



On 2026-07-19 04:53, Mykola Marzhan wrote:
>  drivers/md/raid1.c  | 56 +++++++++++++++++++++++++++++++-----
>  drivers/md/raid1.h  |  2 ++
>  drivers/md/raid10.c | 69 ++++++++++++++++++++++++++++++++++++++-------
>  drivers/md/raid10.h |  2 ++

This is an intimidating and massive patch to review. I gotta second the
verbosity of the AI commit messages comment from Keith.

My eyes glazed over a bit. But one point is that maybe this could be
split into multiple patches: one patch introduces R1BIO_P2PDMA, one
patch for raid1 and another patch for raid10? That might make it a bit
more manageable.

Also, I'm not sure if it's possible without digging deeper but, instead
of adding a !p2pdma_unmappable check to every if() statement in the
raid*_end_write_request() functions, might it be possible to factor out
a helper function and return early from it? Maybe the helper could be
shared between raid10 and raid1 as they look very similar. The
differences between the two are minimal -- there might be a bug fix that
was applied to one that should be applied to both?

Thanks!

Logan

