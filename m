Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC5A1C25B0E
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Aug 2022 19:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=90MZxOEHExE9o/mWVAIq7NZQ2k2Re129UmHEMBWb/cE=; b=kOf0VMHUrkDsxv1m/1RgXl/PI6
	oRcynvKsfWpfO7VZX3zPbt3Ftp1rE9TtjAnKhs+pleXdopnmoIiHKGbo6T4ETIXH0fUaTrY++8hrG
	pQBZE7GSrhm7obH7UARZ8tKd3GrQ2gqWAJUgo+6xENCkyP3G1tSYCenmaxF7u5hsYHFD1ND5A7h1k
	2fxGZ6PIUEyHr9WuObGO+FJCIPmzEBSfeeCEkKtte4DWH6DVRF8JYYD2acI/EFFJrgIQqMa0AP9Ff
	1rOBQDGg4Q+OAxRe83JxDCZhifaUdK9AxxzNB8PuY6FhhrNltjKZgu7psV9LmFjZ9R5O9clRSPy0I
	5QEGAKYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oO1nC-0066YD-QK; Tue, 16 Aug 2022 18:59:58 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oO1nA-0066V9-PO
	for linux-nvme@lists.infradead.org; Tue, 16 Aug 2022 18:59:57 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 6917D61448;
	Tue, 16 Aug 2022 18:59:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34836C433C1;
	Tue, 16 Aug 2022 18:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1660676392;
	bh=Ho0zP0tjQ5vo8CvRRj/Yp9BYqpgN6hZxTc9hBSwpJt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aLAqWpKFE7/Q2xz/1RM36PQ4Ky8Xy+Emnh7gYOfh0g17UUUTfh/vXcXyCn9AmOK03
	 3IHEeCROFVguFxE86RLvqtz0ai7XTbNSGjdNEfJ6LZ/9H/ZkXZAYMxMwCItAbl2OTs
	 40YliqLfzFWAUiK/goTrz/t1GK0Olca8tmKSQWUL1RO5gnCpAPavrNYb354vQFPCGt
	 cVk+LQCC+sZxMPaCf9uBB4YwuSmBQMYvmKxdUQXdJ9qgycHLjJCbwBwoUUkXHSaV93
	 r1syMAyXciFHW6mWf0otMqp0LHItGSVDjSDzX17ueCyQNApgnPMfdepEmP2xLoW2Yr
	 iZUmhwDOc+rtw==
Date: Tue, 16 Aug 2022 12:59:49 -0600
From: Keith Busch <kbusch@kernel.org>
To: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [RFC PATCH] nvmet-tcp: Don't kmap() pages which can't come from
 HIGHMEM
Message-ID: <YvvpJbOT9iv6rnm2@kbusch-mbp.dhcp.thefacebook.com>
References: <20220816091808.23236-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816091808.23236-1-fmdefrancesco@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220816_115956_897964_6EEFFFEA 
X-CRM114-Status: GOOD (  13.70  )
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

On Tue, Aug 16, 2022 at 11:18:08AM +0200, Fabio M. De Francesco wrote:
> 
> Therefore, I have two questions: am I right about thinking that the pages
> mapped in nvmet_tcp_map_pdu_iovec() are allocated with GFP_KERNEL? 

I think you are correct.

> If so, can anyone with more knowledge than mine please say if my changes make
> any sense?

I think it does make sense. I like the code simplification, though this use
was't really paying the kmap penalty since, as you mentioned, this is never
highmem.

You should also remove the cmd's 'nr_mapped' field while you're at it,
otherwise you'll hit the WARN in nvmet_tcp_free_cmd_buffers().

