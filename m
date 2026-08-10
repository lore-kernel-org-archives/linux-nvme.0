Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76808C5AD7B
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2026 19:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=13NUffwAFvTle5TtheNyvG1LDrJsnRlC3j+reqguo+c=; b=f6SEQbD2sOXj8VqIuApNYLNqOs
	d14D0C6Z3LHtTYpV95+VCOiwyAIFjRdPkCFTGiNT98tOJqQX4kCG2H5jpL5swZIgYd0EyRVa7p4LF
	tfQ7qP7l3U1lGCAIZCAjI1WyEdYZMIdvBtxUthywwQV4HV+859XE2jVA+UKrTUfOb+lpV3L17xzfj
	rZjZpJVCjLAZThXJvvI02vlspFtV3FC2iPjRAkbdEPF/s0cWFSreJY9hWyaMCjNiAjIJV7tGL8D6z
	sPnw+2Z+MZ7plxSLOJEclXJzNOK34szpF3x2pIKbvyLAPzNzz4lAS60a9EgY7/k22TEk7gCHPGDXB
	263YwDUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtVN2-0000000CiBL-05XQ;
	Mon, 10 Aug 2026 19:09:12 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtVN0-0000000CiAu-3SdT
	for linux-nvme@lists.infradead.org;
	Mon, 10 Aug 2026 19:09:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B5F6B412BC;
	Mon, 10 Aug 2026 19:09:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4875D1F000E9;
	Mon, 10 Aug 2026 19:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786388946;
	bh=13NUffwAFvTle5TtheNyvG1LDrJsnRlC3j+reqguo+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f5BJ7zZPEps1hSew/35/ASJoAspl48P8UGlIGjXyIDYSqBqreVWJkAadN/1YZzkpy
	 pksURFK+7qvVsDYqGNmhDuVt2OkoUut0dTHnDqM5bqLKVNOJD0iytkHVpZVCSsaeDJ
	 O2iW+IXuAf7D3iPi45F8qjSXDHTZfJOJIbOdRWa9tYLD+Rvq6sUbvsE0DFVZHJCMbh
	 8imb0eAz44Gm2tNkqQzTK61lJ/K8Uau704FbvE3ontT+XzOWqLqtVQybh9lSSUxiyj
	 1bo2k03zwK+dk4QrnQdi/OHj7VZlzlWrMtYgvjtogxIZ6j/7uG+U03J8iRwK9R+Hv+
	 nA8WANt3mdjFw==
Date: Mon, 10 Aug 2026 13:09:04 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jiang HongHui <jiang_hh2019@163.com>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet-fc: fix invalid free in LS IOD error path
Message-ID: <anoh0AcoZR8TAWpT@kbusch-mbp>
References: <20260729110206.207755-1-jiang_hh2019@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729110206.207755-1-jiang_hh2019@163.com>
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

On Wed, Jul 29, 2026 at 07:02:06PM +0800, Jiang HongHui wrote:
> nvmet_fc_alloc_ls_iodlist() advances iod while initializing the LS IOD
> array. If an rqstbuf allocation or response buffer DMA mapping fails,
> the unwind loop decrements iod past the start of the array. The final
> kfree(iod) therefore frees an address before the allocated object.

Thanks, applied to nvme-7.3.

