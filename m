Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69603C531FC
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2026 15:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pAsOaMbYD+VLrKmhf9xajBJNx4DVk5XK8SrCLkgsxyc=; b=I0EBwVIopSDZYd
	1THSG0dDAI0fWrSmvWeJa2c0cYuC1yi1jhwk4zIFNkVIK7OWnoU/TFmD5YW3kXyuLgOszWfg+hmWx
	nNwv1T1mL8ieZVJe60Lq4acvSxkKT9HLapYiJz0XoY207naFoUIUNQBC9Tj46FfyR0mLmJnoqXMjC
	wPiblw6Wq3nywG5XUgiSUoPyGbzOk9gOD5262pQgVelPhO+XXbQr3rSdSyGWdJMHVjfTXSrFWMwSN
	iUKqFXQtGdalrVHHWqy9YyB4O75biEloVFE+d9TTQi6XwhMeTgVrDhJ1MmyTE9O2fwH461gSrgaYW
	Cst5XeXK2LestgQoUgCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woNa9-00000003EBI-09Us;
	Mon, 27 Jul 2026 15:49:33 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woNa6-00000003EAq-34qc
	for linux-nvme@lists.infradead.org;
	Mon, 27 Jul 2026 15:49:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=pAsOaMbYD+VLrKmhf9xajBJNx4DVk5XK8SrCLkgsxyc=; b=ZsYU5w7MEJcCZBLtMtpliX1JwA
	/y8H3I10OsJZWklS/25iu56zAVAZ8t/+TlzVdpnHXVphyuImR1Idx0/8+CTzcBebY62EPLblLBSfz
	tolaxekj2wdB9OJMK6gyR4PskuKv9cllyHRS9GfwKKEZ7A9W0fnf4UpgnSs3906atM7muZ8njM85i
	ajLfOJymqCg24FUJdIfr0JWwd18k8h+HPao5khF1R4Yasfv21ZP6rrHxs7ksPkyGvK67DRT6qO12+
	v98wGAvY0y6GnqR7PTMLlajN6WRLcmEHnA66pt8y4qwllU2Kb5bONRdju7kUIzmDPKunMe9wE62dp
	0ooG+icg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1woNa3-0000000GHTa-2lIC;
	Mon, 27 Jul 2026 09:49:28 -0600
Message-ID: <ba159aaa-648c-418e-b762-29822aaf12ab@deltatee.com>
Date: Mon, 27 Jul 2026 09:49:27 -0600
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
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 Thorsten Leemhuis <regressions@leemhuis.info>, Martin Wilck <mwilck@suse.com>
References: <20260726113229.2154269-1-mykola@meshstor.io>
 <20260726113229.2154269-13-mykola@meshstor.io>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260726113229.2154269-13-mykola@meshstor.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: mykola@meshstor.io, axboe@kernel.dk, song@kernel.org, yukuai@fygo.io, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, linux-block@vger.kernel.org, linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org, magiclinan@didiglobal.com, xiao@kernel.org, guoqing.jiang@linux.dev, leon@kernel.org, jgg@ziepe.ca, kmodukuri@nvidia.com, kch@nvidia.com, bhelgaas@google.com, shivajikant@google.com, praan@google.com, henrique.carvalho@suse.com, stable@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org, regressions@leemhuis.info, mwilck@suse.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v6 12/12] nvme-rdma: factor out the scatterlist DMA
 mapping helper
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260727_084930_784380_933E1A96 
X-CRM114-Status: UNSURE (   9.87  )
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



On 2026-07-26 05:32, Mykola Marzhan wrote:
> The data and the metadata mapping do the same thing: describe the
> segments blk_rq_map_sg() produced in a local sg_table -- the embedded
> one's orig_nents is the allocated size, not the valid-segment count --
> map that, and hand back the DMA-mapped count.  Fold both into a
> helper.
> 
> No functional change.
> 
> Suggested-by: Logan Gunthorpe <logang@deltatee.com>
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Mykola Marzhan <mykola@meshstor.io>

In the future, it's usually better to do the refactoring commits before
the commits that change things (as that makes the important commits
easier to understand). But that is a very minor nit. Thanks!

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

