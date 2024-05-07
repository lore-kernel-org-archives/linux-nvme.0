Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3AD4C10F1A
	for <linux-nvme@archiver.kernel.org>; Tue,  7 May 2024 15:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nH2vx0YkvNz5vvfTPz6SlMzx8PYsvfYrqsQogZQ8GpQ=; b=XayMddJT58vHLTmfT+A4Yfk/4A
	FHGzlwKq5YcCp5oRkFEl9BlmA8PfI9jCqcLMM6RGss+VD8j+A9gKZgDpa2ltN1Wqd96n9JtQIVl55
	pXxZKF+gDz1dQYZDyzv6N3Rg4ukxmY3RRmg+r+RJGMthTTvpsaRpcxLD2J+RVexSTbJLgnWCrepk4
	UsQeT2lupo5fKGbYH8+wnGBwTzeqPknWyPRxiJDJ8jbADPZvo3IE3qZYVoDaoXBmmJ0/nUPk0Zwup
	AZ8jyB46hz2w+CTZYBRuPwOgSo2/6KEsmbhKIjjBdzN1ctxb4rcEjKqkM6ats2kLAdbsmy815jjpF
	iXg2PFSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4MPk-0000000BfDE-3mRc;
	Tue, 07 May 2024 15:07:33 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4MPh-0000000BfBE-0ziI
	for linux-nvme@lists.infradead.org;
	Tue, 07 May 2024 15:07:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 40771CE126E;
	Tue,  7 May 2024 15:07:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A07BC2BBFC;
	Tue,  7 May 2024 15:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715094446;
	bh=ihsdor+K+Ga6KqHtWo4SjDNaDB4Lux0mgpW64hVuJw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=suFL4bejJ1IogQJcfZOb2qHPnO1rR0gvvGuFA/3VWy9v+nUDc9nnuhTI8KDbIAzf/
	 c+vJi1RMhUFdBymBosLmNMcZV/S/LfRh344QsvFZa+jbT6kHqt5YiemKZLY0I/dHbj
	 oC4JdguNPI3sgbpouz2q4C880/uY0wfe9VOBQu2pkBu0HlbC0T3k39pbYTRRJs5qwZ
	 wE25fh92GJOBv8WYZ5J3DzTGRQp89stWoP+pv8HZvgoWoCWKMD63K4ulmcnGT+wbrD
	 NiCYqYQ5cTeOW3G+U4Gsq4hSTkm4oNVQosfrPJL9M8Fl+ide0A88K+ExNLSdVfS3QD
	 XPsyWO55C0LUQ==
Date: Tue, 7 May 2024 09:07:24 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH v2] nvmet: make nvmet_wq unbound
Message-ID: <ZjpDrJmz6rIk04E6@kbusch-mbp.dhcp.thefacebook.com>
References: <20240507065410.1107169-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507065410.1107169-1-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240507_080729_493704_B47B9327 
X-CRM114-Status: GOOD (  10.43  )
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

On Tue, May 07, 2024 at 09:54:10AM +0300, Sagi Grimberg wrote:
> From: Sagi Grimberg <sagi.grimberg@vastdata.com>
> 
> When deleting many controllers one-by-one, it takes a very
> long time as these work elements may serialize as they are
> scheduled on the executing cpu instead of spreading. In general
> nvmet_wq can definitely be used for long standing work elements
> so its better to make it unbound regardless.
> 
> Signed-off-by: Sagi Grimberg <sagi.grimberg@vastdata.com>

Applied to nvme-6.9, thanks.

