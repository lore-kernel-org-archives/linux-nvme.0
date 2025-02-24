Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57362C021B8
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 22:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Nw7biZXGAv6lIJ8dxcwXuNqFUNGABtB3Yb28XrDopqc=; b=remuPBEeq8CyJE9ALquZPiugXI
	R3SWGnLXb4UQf6N0ITqrmWKEFed0E1agAG3uOwjbfE1ilX/ZmsXCVQFSbF1GRtS2tiMW5gSjawTEc
	4bQsPamiMMNUFpWTgrADF+xphFWUsMmFvp/2EZX49MAI/GPlu3cM+csCWFbyuF14XMiwIwzkfOKmX
	3kyKnQBgxNESfPDenuFisYosE4HHQUtFLpKGNE/ktnIUZNbBtaQaqU+xuKTCdpqWU3MAb4p7yYGY+
	GHNd2ZAq4iTgOuSrxrQxv7enrTj1LqvSkUe6OIqdPaO7UlR5S3H7qI6tx0e1kBJAt5Tk8j8t9kjdr
	UOWCdEiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmgzC-0000000FNcb-3M0h;
	Mon, 24 Feb 2025 22:31:38 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmgya-0000000FNVu-0JTU
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 22:31:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 74450611FA;
	Mon, 24 Feb 2025 22:30:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C27C4CEE6;
	Mon, 24 Feb 2025 22:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740436259;
	bh=p/IFHAVjap4l+ke/N/IzPoZVdLMq/7iLO94XDHC0yf0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HjyDKn9ziMRE/QvR0U0drC3Ud+3DWwUosuA1aB/xZ7jf1B6J0RSbbxl/a0EPtROJL
	 A9GuP7X1EY0HUOPilVd6AUDSVv/Tgq6Yi45C8C85FDQNGzrKi+selLqLKbt0rHuFtx
	 GZX7+tBnztD3dbpqtKR8Utm7Wjbm/cRBF/c+eFClPpTvxpA8PkL4LlSBgG391UXlij
	 ZY6PgNgoCEdlNv+IFoCrJVfkvggRj9rlc88qOKJUXu1R+2ac56WMSwBU2WLubxImWz
	 4d1HrOiNchk7mcDl8a5aRn2w9P+q341m0u48NN0NtS8IOtu54LLKSLFH2mtPsWZYjy
	 sQTWfhl8vCEvg==
Message-ID: <e27ba7c9-109a-4a6b-b3c0-3892502799a9@kernel.org>
Date: Tue, 25 Feb 2025 07:30:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] nvme-ioctl: combine alloc and map
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, sagi@grimberg.me
Cc: Keith Busch <kbusch@kernel.org>
References: <20250224182128.2042061-1-kbusch@meta.com>
 <20250224182128.2042061-6-kbusch@meta.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250224182128.2042061-6-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 2/25/25 03:21, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The same pattern repeats, so combine it. Also, the existing mapping
> leaks a request if a user requests to map a vectored fixed buffer, or
> unsupportable metadata formts, so these get fixed here too.

s/formts/formats

Maybe split this patch to have the fix come first with a Fixes tag ?

Other than that, Looks OK to me.

-- 
Damien Le Moal
Western Digital Research

