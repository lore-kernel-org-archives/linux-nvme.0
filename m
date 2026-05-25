Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B0EECD5BC0
	for <linux-nvme@archiver.kernel.org>; Mon, 25 May 2026 06:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AZyjXsJPKPUb5sZiK03F4zfZEhYjoxVcPaCwMeCPDzw=; b=G6gmZtMioVAjjRtHqHa2krik+E
	NVVKtru9OGb/WRLB89Hn0Q/5Q//Jext2w87QaUKFLy34LymZcbJ9+W5LuwDQlbxCmqvdWDotggz+I
	deIOagaLjwMLzJ+1ZMgzkAw2pNo23p9cop3wpNHDsbk8SICs4g0Q8lY86DWPxUcxzulfUG8feHldC
	ZSle06kbaTYS4VjKi+aZ0sT2to8CJJ6oPbKJDkfXHMXtkGvjv30FdYpqjv+ubScvPYc41PINiQHMx
	ps13rorAkKeD7HhIQWI/cPDBFurr2LOaSinjZv2ADNkeNbJo2ZhdHir1Xt4hz4rrup3SsYDe/y9k0
	ET/PlSrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wROz9-0000000GRT2-3NZj;
	Mon, 25 May 2026 06:40:23 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wROz3-0000000GRRw-1eDo
	for linux-nvme@lists.infradead.org;
	Mon, 25 May 2026 06:40:21 +0000
X-UUID: 90dcb100580411f1aa26b74ffac11d73-20260525
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:79965269-8da9-46f3-b9c2-db11a4aeedb8,IP:10,
	URL:0,TC:0,Content:2,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:12
X-CID-INFO: VERSION:1.3.12,REQID:79965269-8da9-46f3-b9c2-db11a4aeedb8,IP:10,UR
	L:0,TC:0,Content:2,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:12
X-CID-META: VersionHash:e7bac3a,CLOUDID:83a07abcf4e01ed4cd3814fefa9cd095,BulkI
	D:260522172147KL7QIPWB,BulkQuantity:1,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|127|841|865|898,TC:nil,Content:4|15|50,EDM:-3,IP:-2,URL:0,File:nil
	,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,D
	KP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 90dcb100580411f1aa26b74ffac11d73-20260525
X-User: sangyao@kylinos.cn
Received: from sang-pc [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2047336700; Mon, 25 May 2026 14:40:05 +0800
Date: Mon, 25 May 2026 14:40:26 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@kernel.dk,
	sagi@grimberg.me, shinichiro.kawasaki@wdc.com
Subject: Re: [PATCH v2] nvme: recompute multipath zoned limits from ready
 paths
Message-ID: <20260525064026.2fxlbmztsfyzzn25@sang-pc>
References: <20260522075806.3168366-1-sangyao@kylinos.cn>
 <20260522092136.GA8708@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522092136.GA8708@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260524_234017_749907_5F79E74C 
X-CRM114-Status: GOOD (  13.72  )
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

On Fri, May 22, 2026 at 11:21:36AM +0200, Christoph Hellwig wrote:
> On Fri, May 22, 2026 at 03:58:06PM +0800, Yao Sang wrote:
> > This was found while debugging a zoned NVMe multipath setup, where the
> > namespace head reported 0/0 for max_open_zones and max_active_zones
> > while the live path still reported finite limits.
> 
> How?  Having the different path report different limits is bogus.
> I guess we just need to fix it and reject a device with mismatching
> parameters.
Hi Christoph,

Thanks for looking at this.

Sorry, the changelog was imprecise.

What I saw was not different live paths of the same namespace
reporting different zoned limits. On a QEMU VM with native NVMe
multipath enabled, two emulated NVMe controllers shared the same ZNS
namespace and advertised CMIC.MULTI_CTRL, so the kernel created a
multipath namespace head. In that setup, both controller paths
reported max_open_zones=16 and max_active_zones=16, while the
multipath namespace head for the same namespace reported 0/0.

I also checked Identify Namespace data through both controllers. In
both cases, nvme zns id-ns reported mor=15 and mar=15, so I did not
observe any path-to-path MOR/MAR mismatch. The mismatch was between
the namespace head and the controller paths.

So the issue here is not inconsistent zoned limits across paths. It
is that the namespace head can still show bogus 0/0 even when
multiple live paths report the same 16/16 limits.

After the patch, I reran nvme/005, nvme/057, and nvme/058, and
rechecked the head and path limits after reset, ANA failover/failback,
and namespace remap. In all cases, head and path stayed at 16/16.

If you prefer, I can respin this with changelog text that states only
that observed head/path mismatch.

Thanks,
Yao

