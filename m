Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB6AC531FA
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2026 10:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HOnlwpVNoGMDBiGGoD0lysWaKgTTK7WSMM8d/NjAOBo=; b=NXklpq8fn0yq3+20jbI8umFIim
	E0HVuTezHl31GNTeSDMbnYonPVc1agTEWbugAbWWR64qg4pWqoOXfycbHIRV+8dgnRHbZUVAsPff6
	mmV2yLJQHdKyYmIEbeVdCbplUkoVu7+c9CAtwXLd/IeJntg3dDVotoeVm3KriOPY+nVmbVp/qSoO5
	9X4pPJ/1+nu6ymQ9gP0MfgiFq4KgyqAsLxEYzUUIVrxmgbccxWU5vGOE3cOX4ooQ/m1HDK6TIHxJZ
	m4h5S8asoqizpk7Ayi57EmD/opIg6TFP2ojvHfWJKlLLH+DoD6JdgTzbxmPPx62SFwpmObNrKb/GT
	8pAtJnvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnD2P-0000000G4qX-1Mi7;
	Fri, 24 Jul 2026 10:21:53 +0000
Received: from relay.yourmailgateway.de ([46.38.247.119])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnD2D-0000000G4iB-0v9F
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jul 2026 10:21:47 +0000
Received: from mors-relay-8404.netcup.net (localhost [127.0.0.1])
	by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4h63tj5HkRz8L7H;
	Fri, 24 Jul 2026 12:21:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1784888493;
	bh=o1i6BGbHsXA2S1cnmSyWtCQB/tcY7gOoTS0f9ZPd+gw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OhU8R58QE2v8FnEHmf0IhAkFnRUuHit96VHskuy0c3JPF1BGKgCXqzPr2+mRaGFrW
	 25ztoWyqndgjKpnp8dZOfBnZ7RLHAWpwD40klhqzrmQNymveo2M3PEH7GmUPm/J0pI
	 hcJeQIaWflrRB5MPwxYKbL/DVvZDX4MljnWrEN1DnjnKuem3XavSdGp3bPp7DRLS3+
	 XtvpCCPpXUt+B2RV4ShIi0UVyvkgPl54eVp/jBAyzng+0qiUKVpiMCmrdzvO0J4brH
	 APWAqi+TQHpdM25cnoQ1jkxKabAVocNi6TH4dhWefm5syPRvKW9TGdkskDAEIXP0hl
	 aOPyBDTylUrAA==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4h63tj4Wrsz4xJK;
	Fri, 24 Jul 2026 12:21:33 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4h63tg5329z8tH7;
	Fri, 24 Jul 2026 12:21:31 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 666925F9DB;
	Fri, 24 Jul 2026 12:21:30 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <c969f48f-833c-4a0d-8e3c-c7e88f9a052d@leemhuis.info>
Date: Fri, 24 Jul 2026 12:21:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/10] block,md,nvme: correct handling of unsupported
 P2PDMA transfers
To: Mykola Marzhan <mykola@meshstor.io>,
 Kiran Kumar Modukuri <kmodukuri@nvidia.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Jens Axboe <axboe@kernel.dk>
Cc: Li Nan <magiclinan@didiglobal.com>, Xiao Ni <xiao@kernel.org>,
 Song Liu <song@kernel.org>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Guoqing Jiang <guoqing.jiang@linux.dev>, linux-raid@vger.kernel.org,
 Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Logan Gunthorpe <logang@deltatee.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Shivaji Kant <shivajikant@google.com>, Pranjal Shrivastava
 <praan@google.com>, Henrique Carvalho <henrique.carvalho@suse.com>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, Yu Kuai <yukuai@fygo.io>,
 Keith Busch <kbusch@kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20260723204206.76930-1-mykola@meshstor.io>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <20260723204206.76930-1-mykola@meshstor.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <178488849128.3023183.9483321544575683507@mxe9fb.netcup.net>
X-NC-CID: bgfn6WwD6tNqsJl92qX4PPcCQ3rLaKDwr3eppdgdbpQWarfWVJI=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260724_032141_609823_D52845F2 
X-CRM114-Status: UNSURE (   7.58  )
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

On 7/23/26 22:41, Mykola Marzhan wrote:
> md treats an unsupported P2PDMA transfer to a member as success, and
> nvme-rdma retries one forever.  Whether peer memory can be DMA-mapped
> depends on the PCIe topology between the two devices, and since v6.17
> the failure completes as BLK_STS_INVAL: retryable for multipath and
> deliberately ignored by md for member failures, so mirrors silently
> diverge.
> [...]
> Routing: patch 1 block, 2-8 md, 9-10 nvme; 7, 8 and 10 use the new
> status.  Patch 1 alone stops the divergence and the dm-multipath
> requeue loop; the nvme-rdma loop also needs 9-10; everything else
> refines the fallout, so the series bisects safely.  The md patches
> fix a v7.2-rc1 regression (02666132403a), except 3 (older bug,
> stable) and 5 (refactor).
This landed on my radar due to the word "regression" here. Given the
complexity of this patch-set and that we are at v5 please allow me to ask:

Should 02666132403aec ("md: propagate BLK_FEAT_PCI_P2PDMA from member
devices to RAID device") [v7.2-rc1] maybe be removed for now and
reapplied later once this was sorted out? Or is that for some reason
unneeded? Note, no need for a long explanation needed in the latter
case, a brief statement from long-term developer will suffice.

Ciao, Thorsten

