Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79158C43334
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jul 2022 08:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U7BbGBqamk4i1RxeMC2zuBrRdmDZ/kxIUbhAwTpJ0Pg=; b=c3Wr7XtsEPywryM2IN8R+t3ts/
	uvtoJbBz49ds7Li+Gbck9czNUVAwqDplAwxzV0kgGcnpmlX665wA+VR24V22/I26RmeCSzeBgIsKt
	WGhcjGtT4NyhPSF/UZKVOxw09r8X4FVKtJLMk3b5XtiTFLpDIFxUNy3dNpC/VAtPp0VTQVnIxIpUE
	P7ngWNa3ERz86lasBWD8J6aNSVtkCX68VH3+Mw8cQ3nLtlAw8Gf7iUCMhu9QUvZL9yTppQRwx+fL+
	enpUimbpnQ2oyRCIgLkfMaMiQ85yzaZtb1w0QmHyR+4DM/s98cbAOuJ8aa7pGWoAoMq8GwelQBVAY
	0TL6qfwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8e4r-00GGTo-TS; Tue, 05 Jul 2022 08:38:37 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8e0j-00GEWl-Cj
	for linux-nvme@lists.infradead.org; Tue, 05 Jul 2022 08:34:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 521C168AA6; Tue,  5 Jul 2022 10:34:16 +0200 (CEST)
Date: Tue, 5 Jul 2022 10:34:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	axboe@kernel.dk, agk@redhat.com, song@kernel.org, djwong@kernel.org,
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
	martin.petersen@oracle.com, viro@zeniv.linux.org.uk,
	javier@javigon.com, johannes.thumshirn@wdc.com, bvanassche@acm.org,
	dongli.zhang@oracle.com, ming.lei@redhat.com, willy@infradead.org,
	jefflexu@linux.alibaba.com, josef@toxicpanda.com, clm@fb.com,
	dsterba@suse.com, jack@suse.com, tytso@mit.edu,
	adilger.kernel@dilger.ca, jlayton@kernel.org, idryomov@gmail.com,
	danil.kipnis@cloud.ionos.com, ebiggers@google.com,
	jinpu.wang@cloud.ionos.com
Subject: Re: [PATCH 1/6] block: add support for REQ_OP_VERIFY
Message-ID: <20220705083416.GA19123@lst.de>
References: <20220630091406.19624-1-kch@nvidia.com> <20220630091406.19624-2-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630091406.19624-2-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220705_013421_640898_67C1201B 
X-CRM114-Status: GOOD (  15.68  )
X-Mailman-Approved-At: Tue, 05 Jul 2022 01:38:36 -0700
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

On Thu, Jun 30, 2022 at 02:14:01AM -0700, Chaitanya Kulkarni wrote:
> This adds a new block layer operation to offload verifying a range of
> LBAs. This support is needed in order to provide file systems and
> fabrics, kernel components to offload LBA verification when it is
> supported by the hardware controller. In case hardware offloading is
> not supported then we provide API to emulate the same. The prominent
> example of that is SCSI and NVMe Verify command. We also provide
> an emulation of the same operation that can be used in case H/W does
> not support verify. This is still useful when block device is remotely
> attached e.g. using NVMeOF.

What is the point of providing the offload?

