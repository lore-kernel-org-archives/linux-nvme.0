Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EFBEC4332F
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Nov 2023 04:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tjjnDhVC5ReuDngAV/XZFo/K586yUkLmKub14z/Af+s=; b=nMadnhzvFrOTa9+NR8z3l+H3W5
	4g4h79LAMVcqCG2ecVQ5Vnhg8odB1RQon+hCm+yf15x/XwguUQevDvbBy61kjDRjz/nxvZ7v0Buro
	PZ3Ajm1iEQM9D+HumXWQ3AGIw1pN0bWtPJ6XwKt/KiyOvSqMuJ3OLNTRSBlRRV2OyPn9Gj74DYGcl
	4yFWbEBlswPu73X1iXFxu4jumUeHxoGxzMdRLneGwgh7Fu7tmRYBpYXtdgu3rp1b7QopR5m4W5+dh
	inazg+6lxUHdr73iWXEIcrmf/CvxNGlMo6+hvF9EncvNZ5f3Akq/T7a5Jg6lzR5kePnGlV8lqA0DH
	k1kabdlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0x1t-005HDh-1i;
	Thu, 09 Nov 2023 04:52:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0x1q-005HDE-0p
	for linux-nvme@lists.infradead.org;
	Thu, 09 Nov 2023 04:52:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7444F67373; Thu,  9 Nov 2023 05:52:22 +0100 (CET)
Date: Thu, 9 Nov 2023 05:52:22 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Alon Zahavi <zahavi.alon@gmail.com>
Subject: Re: [Bug Report] NVMe-oF/TCP - Slab OOB Read in
 `nvmet_ctrl_find_get`
Message-ID: <20231109045222.GC28458@lst.de>
References: <CAK5usQuJ=-1wt5LxHnWtrS_3iOeG-TWy9D88WA1EHSVv+hUNJQ@mail.gmail.com> <1dd5331f-626c-4503-9323-77de0b0db886@nvidia.com> <CAK5usQsOP+4oV3YEcNN6Oe6_kBqP_u=e1DggJvNanH3qDG8+wA@mail.gmail.com> <7942920c-b3f8-4f52-b6a4-78a3cef2cba7@nvidia.com> <CAK5usQu_mi68_ChP4OckVmY42djdPx8L3hGg7_Jj0fa1yQ2mPw@mail.gmail.com> <20231108140312.GA32730@lst.de> <afbb268d-5098-4b81-ab1e-a25f0b9013a1@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afbb268d-5098-4b81-ab1e-a25f0b9013a1@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231108_205230_436117_15D888AE 
X-CRM114-Status: GOOD (  14.55  )
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

On Wed, Nov 08, 2023 at 10:09:27PM +0000, Chaitanya Kulkarni wrote:
> I specifically didn't send this patch when I wrote it initially, coz we are
> modifying connect data and yes it will work just fine functionally but
> in principal we should not touch connect data after nvmet_copy_from_sgl()
> call even for the sake of debug prints or string comparison since it's
> a data that we've received from host and should be in read-only mode.
> 
> please correct me if connect data should not be treated as read-only...

Why would it?  It's purely in-memory and any data transfer is copied
into it.

