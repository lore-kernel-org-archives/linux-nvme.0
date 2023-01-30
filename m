Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B8EC54EAA
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jan 2023 18:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MLc0EmnbmDLQl/XjwdiVtxxTKE3CWo6yvTVSfu/evZU=; b=ePjoZvD5BMWTxfar8ZuJorVEmP
	Nai3IrmWErQBZiz/6Ns/aesQOHYhvR5eFnX+xxdYG0gwWZGWwI+raBHVA9tr1LKiThpcgtQT7hHNR
	jFTz48RhGzg7NAORCA+nENv1GemW6sbiOD9LKCRyjsykIoLCGyGPKyUza58Yz2LgHY5Gxdh0NxHrQ
	aTXx5QrMeVwQ//ENaaua7ctzSyc4qLAs8+msm+SJD9QNWkASVfwnfVWyPkv6xCYLRuYHn0B6FVbXH
	kMuJ80nTrVXv8Thj5Qr4RtCxA7D1TEOzfHG31Ra94Oa2S9uk8LHtzFnWTn5E94Su1zWy7yHoy+VWF
	uEl7uZCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMZ0N-0053Rm-FH; Mon, 30 Jan 2023 18:35:47 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMZ0K-0053OA-C8
	for linux-nvme@lists.infradead.org; Mon, 30 Jan 2023 18:35:45 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 43CAEB8125E;
	Mon, 30 Jan 2023 18:35:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90AC7C433D2;
	Mon, 30 Jan 2023 18:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1675103738;
	bh=2dREi5KPAZNxUz+kH4/SG2GL2ykhxm1D2smoWkJPxWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UERc/tp6ttMoSiTYyZLk06s80HXJtcyVPm3QH3ujNVEFHRQqaWEaM7D1wQfn9fML4
	 88jyBVMc4kYyEty0CVqkC6nAwNYnEky92zCY+7BO3jwCdKiVGSqky4qGseOVgEB78Q
	 GTbfvtlPsEFJ4q7WwAZmiR0KG7cjqba+4jOIWgHqpx/bDdTQQ5CP0/0IEggOmI9P+V
	 svoBc/SqAUTP80nyWRRfklGywm5W2DkIoDZE18dpjiLewHYhfmshMzuMdMAcARNsot
	 6z1271+a7A2wPBx8416PS/eOa4MjrgU+pfCF/Ka55SpgjOxzMd8aAXdQ6BKMz+xGGT
	 Ye7b+kh4ihq1Q==
Date: Mon, 30 Jan 2023 11:35:36 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org,
	Maciej Grochowski <Maciej.Grochowski@sony.com>
Subject: Re: [PATCH] nvme-pci: fix resume after AER recovery
Message-ID: <Y9gN+FsDZQBcKJvk@kbusch-mbp.dhcp.thefacebook.com>
References: <20230130101449.1772800-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130101449.1772800-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230130_103544_612559_51AECD74 
X-CRM114-Status: GOOD (  14.85  )
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

On Mon, Jan 30, 2023 at 11:14:49AM +0100, Christoph Hellwig wrote:
> All I/O on a nvme controllers hangs after injecting a malformed TLP error
> using aer-inject with an error file like:
> 
> --- snip ---
> AER
> PCI_ID WWWW:XX.YY.Z
> UNCOR_STATUS COMP_TIME
> HEADER_LOG 0 1 2 3
> --- snip ---
> 
> This is because in this case the ->resume method will be called after
> ->error_injected and not ->slot_reset, leaving the controller in disabled
> state and the queue frozen.  Fix this by doing a controller reset to
> resume as well.

Why isn't slot_reset being called after error_detected? Driver should be
returning "RESULT_NEEDS_RESET", which should have the pcie error handling
always invoke the slot_reset callback.

