Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AFCFC0015E
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Aug 2023 13:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wqPO3fjYCFSZoxri1VRwX01Ep7+zcmQMJe0Oi2gC3UY=; b=sy05y1NEWEy/P5/Zk0zskflrnt
	zi9+y2xS4NNcJfa62k8xtlMUhrdg8oRmhKgHO19CFdB6pgw3JZvS5vphxK+K6Kxer3TstumlFPV/c
	etwpx0i3F0K4/F5o8bo2HtwCyX6ySdcp6j74nQOTrLKf3t31HEYLkxyFyyAx6VDn8VYFiLEqxPymA
	C94dpD41mGsFpKputzuGPwMlgfiBqgemXMNl+cR1nbmLK5E3V99h7S72pu9+SWg6VO0qyFT71H5Dv
	XHLWMCRO68PFB2FQltVtGxjjNfZPLwd27VdRQaEjgfFpg5dQLb2tZOgowcVoKjRfNxmutGEEnhFnk
	+BYgw8IA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qURut-00Ah17-1f;
	Fri, 11 Aug 2023 13:10:59 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qURuq-00AgyY-2N;
	Fri, 11 Aug 2023 13:10:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4DD1867373; Fri, 11 Aug 2023 15:10:49 +0200 (CEST)
Date: Fri, 11 Aug 2023 15:10:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	Wen Xiong <wenxiong@linux.ibm.com>, Keith Busch <kbusch@kernel.org>,
	linuxppc-dev@lists.ozlabs.org, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	Baoquan He <bhe@redhat.com>, Pingfan Liu <piliu@redhat.com>
Subject: Re: [PATCH V3 01/14] blk-mq: add blk_mq_max_nr_hw_queues()
Message-ID: <20230811131049.GA20991@lst.de>
References: <20230808104239.146085-1-ming.lei@redhat.com> <20230808104239.146085-2-ming.lei@redhat.com> <20230809134401.GA31852@lst.de> <ZNQqt1C0pXspGl3d@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNQqt1C0pXspGl3d@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230811_061056_924727_880FA0D7 
X-CRM114-Status: GOOD (  12.86  )
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

On Thu, Aug 10, 2023 at 08:09:27AM +0800, Ming Lei wrote:
> 1) some archs support 'nr_cpus=1' for kdump kernel, which is fine, since
> num_possible_cpus becomes 1.
> 
> 2) some archs do not support 'nr_cpus=1', and have to rely on
> 'max_cpus=1', so num_possible_cpus isn't changed, and kernel just boots
> with single online cpu. That causes trouble because blk-mq limits single
> queue.

And we need to fix case 2.  We need to drop the is_kdump support, and
if they want to force less cpus they need to make nr_cpus=1 work.


