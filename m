Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5146C19F2D
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Aug 2022 07:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2sn/w0thFboLpl56s2vfF60evzxWWJp9npgykafakSQ=; b=EzmKcDb2e2GPNFsq8Sc7H3RJ4B
	lfNYWN5NnlYxyO8M/51o1i/leYluBc3axzB7tCCNaZU9M3jUtljk+/B5eRao9y3lFAhx8ZQjmkUaJ
	KvY5SgXqW1hG1lv8B+v+QzcYqgH6SS7u0E9B037jFlEifidz35uL30+2QZ02HEGXvl6MPnVynrsmf
	TKhmooXPpbVPOfGGYpyLMIdkRogaCC6rMZXlLS3RlJpmYcd+LRuXLJ0IEMnlGVlUsvs1401TPHDJe
	GHcPpcCn7O2yGJHBa1/MUWhZLpd38FcpL0qP5R29ncMNZOl+DPQrZvgQhgVeBvDDbixfm/6/yOa2r
	Dh57SHtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLJTl-002IU1-Be; Tue, 09 Aug 2022 07:16:41 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLJTi-002IRr-Lm
	for linux-nvme@lists.infradead.org; Tue, 09 Aug 2022 07:16:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A29FD68AA6; Tue,  9 Aug 2022 09:16:32 +0200 (CEST)
Date: Tue, 9 Aug 2022 09:16:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mike Christie <michael.christie@oracle.com>
Cc: bvanassche@acm.org, linux-block@vger.kernel.org, dm-devel@redhat.com,
	snitzer@kernel.org, axboe@kernel.dk, hch@lst.de,
	linux-nvme@lists.infradead.org, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, james.bottomley@hansenpartnership.com
Subject: Re: [PATCH v2 14/20] scsi: Retry pr_ops commands if a UA is
 returned.
Message-ID: <20220809071632.GA11161@lst.de>
References: <20220809000419.10674-1-michael.christie@oracle.com> <20220809000419.10674-15-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809000419.10674-15-michael.christie@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220809_001638_928247_FE9CEEBF 
X-CRM114-Status: GOOD (  15.01  )
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

On Mon, Aug 08, 2022 at 07:04:13PM -0500, Mike Christie wrote:
> It's common to get a UA when doing PR commands. It could be due to a
> target restarting, transport level relogin or other PR commands like a
> release causing it. The upper layers don't get the sense and in some cases
> have no idea if it's a SCSI device, so this has the sd layer retry.

This seems like another case for the generic in-kernel passthrugh
command retry discussed in the other thread.

Can you split out two series with just bug fixes for nvme and scsi
as I think we should probably get those into 6.0, and then we can
do the actual feature on top of those?

