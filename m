Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C39C4345F
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Apr 2024 16:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PGS5RDH4e0+f/gfH2Y3w4BDXALjg/4RV3jm7ITV7ElQ=; b=XHbrJJM/l4B8aP5guGZYd6CDYS
	gRtknppgl72XedXMFC0XPOZQ4wDUSYlOD50X5GPZH8cbW8+3oiY5Iw7L1nNOOmWAF4vJ4AhLmPgy1
	VzAnRerbIp0OA1bvikpJKph2Z4TuMIbOQ/jipzh8ArOlu8xEKDK9FPFNT3SzGyk45EZzya+uAnLQ8
	18mc3H9Jrlt4fRSR6GFKb2jvR/L+8OqjuBcmSVsG+Hu9tKlO3lpQ1OztRv73aOW0LX5EfJxMKbLaq
	31vzfXfdxXAxTDoUSfK1SakgU+2v+GfKdIrbI2RkRMdNSIuREOGamayTvr3YCOcGGbJe+FIvQz2OJ
	xuZGv2Ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwlvH-0000000D3si-1EQ0;
	Tue, 16 Apr 2024 16:44:43 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwlvE-0000000D3s6-1pmE
	for linux-nvme@lists.infradead.org;
	Tue, 16 Apr 2024 16:44:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id DA89C6124A;
	Tue, 16 Apr 2024 16:44:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30ECEC2BD10;
	Tue, 16 Apr 2024 16:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713285879;
	bh=PGS5RDH4e0+f/gfH2Y3w4BDXALjg/4RV3jm7ITV7ElQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XkRoTG/ihWnTv65NU06MuQ9tD6FNLRJx1MpA2JY2/Wwxrm15PxNhJoDuROwWVQ+K5
	 hNRtxE2LgvVhUMXgSycAAG1biBJs0zjo0bwu2jqYDOFXQzJuHmm0wR3sokZ3DmJVZB
	 DgIoWqMUcQZR0KwI33coSL00XwMNB5mMRyrzXHmn02yXpRYE+HKY0v82BSkO0Eu+DK
	 wvl3WYIR2xBMSkFIg0D+KCsuR4DLRresBkmN6HFS6iZ01ROMQfN7YZxJjYIc0KDXdh
	 AjcHlehkmEiff0H+579SPlem8VkiDTUoWDCyd0QhChHGb3qFQp2KpakC4tnxmqoSyI
	 vYjIgpi2bUk9Q==
Date: Tue, 16 Apr 2024 10:44:37 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	gjoyce@linux.ibm.com, axboe@fb.com, chaitanyak@nvidia.com
Subject: Re: [PATCHv3] nvme: find numa distance only if controller has valid
 numa id
Message-ID: <Zh6q9dhnABofvGei@kbusch-mbp>
References: <20240416082102.914152-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416082102.914152-1-nilay@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240416_094440_559029_19065C5B 
X-CRM114-Status: UNSURE (   8.56  )
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

On Tue, Apr 16, 2024 at 01:49:23PM +0530, Nilay Shroff wrote:
> On system where native nvme multipath is configured and iopolicy
> is set to numa but the nvme controller numa node id is undefined
> or -1 (NUMA_NO_NODE) then avoid calculating node distance for
> finding optimal io path. In such case we may access numa distance
> table with invalid index and that may potentially refer to incorrect
> memory. So this patch ensures that if the nvme controller numa node
> id is -1 then instead of calculating node distance for finding optimal
> io path, we set the numa node distance of such controller to default 10
> (LOCAL_DISTANCE).

Thanks, applied to nvme-6.9.

