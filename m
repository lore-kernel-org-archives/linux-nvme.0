Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4505ECD5BB1
	for <linux-nvme@archiver.kernel.org>; Mon, 25 May 2026 15:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sRxOUxStqxdr7ToPr/z6CmzNEjf8/d5APNiGmvmk6X0=; b=b883iUY6K6VCc06XIWkz8gqWBW
	HAppa/r8hm5xtKsT/hqE3clpXDg2n8lgzRlXvrLkgA4l5KrY15IokVcm3GIfKVlYV+vm1CxNPkbMU
	9xEQZDxd8IHBE5Ufh353yea1xXl8hIXlnsoe2MN1NCyeR9XuN5C8PwoTSb0RQ55ApRoIeu2/Llov8
	fASeXiZ3nz8SHVUda2tGwxfFPkSumfFhf0Mzuu6IlUu1Rl2FHrnR/IeMG7PA50ceEJyoMCyTLHki+
	lfNo2a+8IMfZEgw4CKW8m3RLpMFJRBXyTZcqB2YN8J0wNB1OVd69TIR9R7+L8V5PxfL7O9DVstOgV
	vhD2qsKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRXYY-0000000HYdF-40BP;
	Mon, 25 May 2026 15:49:30 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRXYX-0000000HYcb-1Edo
	for linux-nvme@lists.infradead.org;
	Mon, 25 May 2026 15:49:30 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5D59040BF8;
	Mon, 25 May 2026 15:49:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F391F000E9;
	Mon, 25 May 2026 15:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779724168;
	bh=sRxOUxStqxdr7ToPr/z6CmzNEjf8/d5APNiGmvmk6X0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V9jBY2BTNbs4SFj0tf+g+3EF4U9ADRJ2jZuWAWh91wmrf1B7L/JeYZOxG7HGp8eHC
	 wvacoVas7/3LAyBdaJH5cCz5uEj4So+8jRZ4LygljjrXnOam/SZd0997r7y7LxhFRD
	 YDjZBdp50CUb0164zek5j14gvJvUn0c1aLvB/PHCipRtNPr8/jBcd5NS6O5zzCveHV
	 MQkZA/MH8a6SsbdFBbZoFgFMLeowb30BHGhW2AXMZzsfSY7Onx2sMRTB52ukxMTmnv
	 EjkGRmTF7sjrSi/HXEGu9jJ334IrTgNqe3eNOAAm2VA0o49qUBaTiXXiuTui3JjKA7
	 PFG2lW8+7wlKw==
Date: Mon, 25 May 2026 09:49:26 -0600
From: Keith Busch <kbusch@kernel.org>
To: Tokunori Ikegami <ikegami.t@gmail.com>
Cc: Chao Shi <coshi036@gmail.com>, linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>,
	Tatsuya Sasaki <tatsuya6.sasaki@kioxia.com>,
	Maurizio Lombardi <mlombard@arkamax.eu>,
	linux-kernel@vger.kernel.org, Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH v5] nvme: reject passthrough of driver-managed Set
 Features
Message-ID: <ahRvhmaMCCqnxV62@kbusch-mbp>
References: <20260523225629.3964037-1-coshi036@gmail.com>
 <cda74a96-cff1-402a-bcdb-745c85f6c87b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda74a96-cff1-402a-bcdb-745c85f6c87b@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260525_084929_356829_BAEB9215 
X-CRM114-Status: GOOD (  10.69  )
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

On Tue, May 26, 2026 at 12:34:03AM +0900, Tokunori Ikegami wrote:
> > +static bool nvme_cmd_allowed(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
> > +			     struct nvme_command *c, unsigned int flags,
> > +			     bool open_for_write)
> 
> The struct nvme_ns does already have the struct nvme_ctrl *ctrl as a member
> variable as below so seems not necessary to add the function argument struct
> nvme_ctrl *ctrl.

This filter is for admin commands, so the 'ns' parameter is NULL for
this case.

