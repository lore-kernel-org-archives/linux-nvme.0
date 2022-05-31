Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F86C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 31 May 2022 05:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xBM3SjSADpCtaGTcU20MqvmhiyUnvgFDR0aC/pBuNI4=; b=bwQ3c7dWi2hGlv2OwTg13NwPXs
	9DfTTiaWSGAewlzoH/456ybilZ4P2QE1BsX6eI8FyJukT8YxMYnPIJmDGMJGU2LwcyqABivCPa3d+
	ohi2ktW2Xw9eu65XGQn+qGFtEpSb7BqOoZ9hgTUP7HyQ5QA4IY+vvCQrGXDZjM/98B9df73f8fEHz
	/rdJMuFW5f0BSPLqmJP0zUBbRJdKV95kfrVSYBEdpgAqWRe3hr5DE49FdIzYZC670sVhy2jzTZzSA
	NhAKp/HWvPghhpB3CGa9wGxIyK6zmU+VE5PkNHJizQ43pNDpvnk6VPlcznH9e6B14FN7nQA1ONrhz
	A3AGwGkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nvueP-009OwE-UA; Tue, 31 May 2022 05:42:41 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nvueM-009Otw-G8
	for linux-nvme@lists.infradead.org; Tue, 31 May 2022 05:42:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BA2D768AFE; Tue, 31 May 2022 07:42:27 +0200 (CEST)
Date: Tue, 31 May 2022 07:42:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: Christoph Hellwig <hch@lst.de>, kernel-janitors@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: fix typo in comment
Message-ID: <20220531054227.GA20486@lst.de>
References: <20220521111145.81697-26-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521111145.81697-26-Julia.Lawall@inria.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220530_224238_771327_1A65FCFB 
X-CRM114-Status: UNSURE (   8.86  )
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

Thanks,

applied to nvme-5.19.

