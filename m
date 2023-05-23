Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA3AC77B75
	for <linux-nvme@archiver.kernel.org>; Tue, 23 May 2023 06:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UKYq24LBFhLnQ5Jd8c5uaO01i2xfa3v6GVQUx/k4EzE=; b=VB3/TryiKwb1ffYEqUk7wOsk6c
	RMGs+Jrh4xOxLieM42+8b3CMzt1jEpk+8jheLZFVZeoX2ayD7Zw9i18FGClkguAlNkJuEm7jjJUCC
	WyZcWSeL/WymPBv9PmfJoQBE1xpdYlS99VzCJlpnz0o3LSLBEOSQpzoAP4k91SjPEGuZTc/GFHIoe
	+6PbCYyqqNPcSZeQdhtvetLv86yKLuw+Pkb0TVfy02wDGWO25MuQeTDYLTJVZaZvhXDhgNel5tpUM
	lZJxlY5Jw91vDflX9q7o7uHuLYlzrBBDvu766H6VGWcGgx2uAcesR0hKf/3Qux5qta2pVpKMR+3GJ
	F7Jm/Q1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q1Lx7-0098Vi-1N;
	Tue, 23 May 2023 06:57:01 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q1Lx4-0098VA-2K
	for linux-nvme@lists.infradead.org;
	Tue, 23 May 2023 06:56:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 19ECF67373; Tue, 23 May 2023 08:56:56 +0200 (CEST)
Date: Tue, 23 May 2023 08:56:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: hare@suse.de, linux-nvme@lists.infradead.org, hch@lst.de,
	sagi@grimberg.me
Subject: Re: [PATCH 3/3] nvmet-auth: use helper for auth send/recv cmd prep
Message-ID: <20230523065655.GC8224@lst.de>
References: <20230522083713.107001-1-kch@nvidia.com> <20230522083713.107001-4-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522083713.107001-4-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230522_235658_907616_964D7184 
X-CRM114-Status: UNSURE (   8.75  )
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

> +	u16 sts = nvmet_auth_check_secp_spsp(req);
> +
> +	return sts ? sts : nvmet_auth_alloc_transfer_buffer(req, buf, len);

I'd much prefer just spelling things out here as usual:

	if (sts)
		return sts;
	return nvmet_auth_alloc_transfer_buffer(req, buf, len);


