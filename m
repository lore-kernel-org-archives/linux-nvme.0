Return-Path: <SRS0=D68J=FL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B6AC433FE
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 18:13:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 671FF235F7
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 18:13:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 671FF235F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cMDRe7KLua+7yWGIMWPr+G0oFDl23A5tFzd6Pn0Q40g=; b=Rx3oeaGIiWEtmcoq3oayen4YW
	6tzzn+oCvKxIMRN+bC6VfQaUEbVZtK3JQRkmqsGFKudyVkZ/3aOJusISdc8mdu1QzVwk10VDhNIF2
	oou7iHNz51k1ZgmXzmQvAMLgtUbG5BMyeQPCcn8Z+iDH9jlnzvw+ISn2UE60VvR9uSDUULnmDtg8q
	vfv9rUfFNop33dO4R9M4yvsdDPNGrJrkE51R1ShfVwp7wH4C1FRmNJSBqxoebxEN/JYHS8Fp5hFg7
	o4bdxhRsCL6NQOq2TzxzgiBWR08pxNTYXK746vx/Cf4ywxf8eCnzrK/vwtsj/I5Lm+IcGGRBcnbyN
	4x/X1Wwjg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmL1C-0000ew-FE; Mon, 07 Dec 2020 18:13:50 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmL17-0000eU-IM
 for linux-nvme@lists.infradead.org; Mon, 07 Dec 2020 18:13:46 +0000
Date: Mon, 7 Dec 2020 10:13:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607364824;
 bh=gCgAvkXT5IcZqeDOSIos+2lUJLoXppjLnbnmm7iABTQ=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=FXvgRMLzbqdzex6v9XJtk+QYQ3jOE7bEdeopiDZYCQISM/QgSzITgAXWz5WqGgRWb
 GFf9WIYfblqZ+Cy58bYLmaoZnKzTh2QBfqCo7PokX3nOUxM/vWnc8chQJbIP9XnX1j
 zxMoFcawpthxmfVJ41VQaJvLNXkIrI4MtX2cex1o3VSrDaWtusqufao8X5b8+8W6Ig
 p5tTqL2ewbNHqMHvkw/8Nz/kiIpzX2hYtAgQHQ5d5bW4EfOKFPRxaTudaYFa1IDmDA
 migWBgPCJ10F0eP/K3i1ih67T7i/qgFVk2Fw8CAMmeHeDRnOlV3Dd3vZcS1d3V5jPv
 jv5Yl/eNXjc4Q==
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 6/6] nvme: allow revalidate to set a namespace read-only
Message-ID: <20201207181341.GD3679937@dhcp-10-100-145-180.wdc.com>
References: <20201207131918.2252553-1-hch@lst.de>
 <20201207131918.2252553-7-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201207131918.2252553-7-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201207_131345_731019_B58847F8 
X-CRM114-Status: UNSURE (   9.30  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 Mike Snitzer <snitzer@redhat.com>, Oleksii Kurochko <olkuroch@cisco.com>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>, linux-block@vger.kernel.org,
 dm-devel@redhat.com, linux-nvme@lists.infradead.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Dec 07, 2020 at 02:19:18PM +0100, Christoph Hellwig wrote:
> Unconditionally call set_disk_ro now that it only updates the hardware
> state.  This allows to properly set up the Linux devices read-only when
> the controller turns a previously writable namespace read-only.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
