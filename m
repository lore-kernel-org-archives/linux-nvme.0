Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BFB6CDB465
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Oct 2023 18:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K8mPNXe3IwvtOAWvqEcsrI42do340Ga05b8mbAC9/Gg=; b=oPKG+3AM0Ak7TyV7pTHq1P24f5
	eS9ObvvJ5p+ZIT6draedHb7ZOyMaa4EhadQADejDGN+RqaSupCHLAyRygSbgexUwVQi6iHxMnYMfe
	VYZSh1dsnoVPpmFJYAa3fiUbb0ThY35pYMYRtBWW30x9ERqjfp+PrAm1l+k6EadbN/NKAc5DpbIKI
	dpgjPXUy87WlfI0bx+Tk6tEkzRHNsJPsfolVU4detuzhIgms4MBmnjbk/iL+fMTvO+z5NB9ijMKiq
	yyVrXxbinE9NvBYvaXoNXU2ffct3AwvSlTVsbkL8kDw1j4sfVrdspAJW4NVZBF7v3dHRL6fXcv1Xm
	fHRCWnGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qsSQX-00AL8f-2J;
	Mon, 16 Oct 2023 18:34:53 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qsSQU-00AL8G-09
	for linux-nvme@lists.infradead.org;
	Mon, 16 Oct 2023 18:34:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4CD6267373; Mon, 16 Oct 2023 20:34:38 +0200 (CEST)
Date: Mon, 16 Oct 2023 20:34:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Kanchan Joshi <joshiiitr@gmail.com>, Christoph Hellwig <hch@lst.de>,
	Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	vincentfu@gmail.com, ankit.kumar@samsung.com,
	stable@vger.kernel.org, Vincent Fu <vincent.fu@samsung.com>
Subject: Re: [PATCH v4] nvme: fix corruption for passthrough meta/data
Message-ID: <20231016183438.GA15911@lst.de>
References: <CGME20231013052157epcas5p3dc0698c56f9846191d315fa8d33ccb5c@epcas5p3.samsung.com> <20231013051458.39987-1-joshi.k@samsung.com> <20231013052612.GA6423@lst.de> <8c755915-2366-28ff-ffd4-be17d797557c@samsung.com> <ZSlL-6Oa5J9duahR@kbusch-mbp> <3438f3b8-f7d4-f0bd-44ef-7efb09ed6151@samsung.com> <20231013154708.GA17455@lst.de> <CA+1E3r+gSWvN3VR38Uu=rHLy=9+iC-G5ta2sXq6LEXTG+OK_-g@mail.gmail.com> <ZS2BA_Oj4kcwRbiY@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS2BA_Oj4kcwRbiY@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231016_113450_256598_5E86B399 
X-CRM114-Status: GOOD (  12.38  )
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

On Mon, Oct 16, 2023 at 12:29:23PM -0600, Keith Busch wrote:
> It sounds like the kernel memory is the only reason for the concern, and
> you don't really care if we're corrupting user memory. If so, let's just
> use that instead of kernel bounce buffers. (Minor digression, the
> current bounce 'buf' is leaking kernel memory on reads since it doesn't
> zero it).

No, arbitrary memory overwrite is always an issue, userspace or kernel,
data or metadata buffer.

Note that even without block layer bounce buffering, there can always
be other kernel memory involved, e.g. swiotlb.

We need to get the fix to disable the unprivileged passthrough in ASAP.


