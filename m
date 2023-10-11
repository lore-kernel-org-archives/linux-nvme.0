Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80107CDB46B
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Oct 2023 17:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cdJpfQzF+kj649TVGXIDyptPx93QrQTodIHdFOp8NvM=; b=NLFY8mA7rvGeOu/1vimxhAh3F5
	Pyf76YluHIgQw89fn9mrsV0DWlQClwIFzbbbfutF2n06uJbVJZaIdGC89+pg3drs0Ysvi48VRvuF+
	JnzfbUxpCecIP9HRTNNbNllIozXMGdyA+Un2DZs4dDeI4nwtEyzJVsAKxltYUGG6DznhGSfodDx71
	yOPPOa/Oww+19PLxZpkYBqHVgUso63JfYcdtAzj8vEa8Vh2KU4tVznYDOzcvcl/yalRxOfN+TZaXW
	KRnIHfl6ciEf/oj7XfvjrJhsQwWsmLg3olvAfisJNA9S/dxHZFYrnDW3K8KQuGwWOGWi8p6BLL+4e
	5180tOvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqcdt-00GJEP-0w;
	Wed, 11 Oct 2023 17:05:05 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qqcdr-00GJDS-0D
	for linux-nvme@lists.infradead.org;
	Wed, 11 Oct 2023 17:05:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C7263614CE;
	Wed, 11 Oct 2023 17:05:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B48C433C8;
	Wed, 11 Oct 2023 17:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697043901;
	bh=UR5o0B3rdl0E39dkU0JdIMUuq8WRJmDYDAz+Ok0M5Yk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EwZmIqiJGcYWy13YSxdMXC80wMJbg8f3C9PHceMsg6vz+8EO9mbui4oklsbguazyk
	 8jDJc82WeEV8IPlmv/969bOYMjdJsbOO0KCRgLPvDfWBH9oMtO/aBBlkUMPmwpj+Du
	 PWanziJUg6mrjFEM0QtgOStDasEO4B10loDO62MXzTHBgLmZlmp0x1oGa15/qZF2NW
	 TUDhk6RdpsIgfBuYtccuZkTYRl7wCy02+8k6M8bmHVe3WVwF/LKcyVKZ6NbI+anGgh
	 WcUogr+fZc5kkjPRxONR7SZXMMGlhQLzxPU2c/IGNBTaJkkduCub86dyzEXM07tvQG
	 545xnD0B9v3kQ==
Date: Wed, 11 Oct 2023 11:04:58 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshiiitr@gmail.com>,
	Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	vincentfu@gmail.com, ankit.kumar@samsung.com, cpgs@samsung.com,
	stable@vger.kernel.org, Vincent Fu <vincent.fu@samsung.com>
Subject: Re: [PATCH v3] nvme: fix memory corruption for passthrough metadata
Message-ID: <ZSbVuuE8YxgwpqM8@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20231006135322epcas5p1c9acf38b04f35017181c715c706281dc@epcas5p1.samsung.com>
 <1891546521.01696823881551.JavaMail.epsvc@epcpadp4>
 <20231010074634.GA6514@lst.de>
 <CA+1E3r+2Ce4BCZ2feJX37e1-dtvpZtY6ajiaO_orn8Airu2Bqg@mail.gmail.com>
 <20231011050254.GA32444@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011050254.GA32444@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231011_100503_175506_E279CBC4 
X-CRM114-Status: GOOD (  15.28  )
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

On Wed, Oct 11, 2023 at 07:02:54AM +0200, Christoph Hellwig wrote:
> On Tue, Oct 10, 2023 at 07:09:54PM +0530, Kanchan Joshi wrote:
> > 
> > Given the way things are in NVMe, I do not find a better way.
> > Maybe another day for commands that do (or can do) things very
> > differently for nlb and PI representation.
> 
> Fixing just a subset of these problems is pointless.  If people want
> to use metadata on vendor specific commands they need to work with
> NVMe to figure out a generic way to pass the length.

NVMe already tried to solve that with NDT and NDM fields, but no vendor
implemented it. Maybe just require SGL's for passthrough IO since that
encodes the buffer sizes.

I don't think it's reasonable for the driver to decode every passthrough
command to validate the data lengths, or reject ones that we don't know
how to decode. SG_IO doesn't do that either.

