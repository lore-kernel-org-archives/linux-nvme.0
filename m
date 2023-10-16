Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E45CDB465
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Oct 2023 05:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FNZqBNhUVo/x95BL9oUFX3uZRSSBLvHPnYvzlPg/o3E=; b=VWSdyM23t8rPKnwxuiI6jf6isH
	JyiN6b+1vvRM7r37ZsoByU7SDLVjlgTIHasdC+A6M1/015inA6p61n6nHMBv18QHF67FHfIhCr0cu
	/Y/7BNdTBkvKoaDu09E2riR6coRK1IftHF02mrZxvqcmc7B/wprpSdxu6VBHUpcVDGvfj3IOxneEA
	A3L/LpeBnKmaZgyWzaoep484yG5wSso2AIBhSZZ0rXe6iCuCmMkwKDl17l+0ZdtilmNh5tyQZr3Zb
	h4RLUwNQkGrtaZcwnoKMSGgL1ud/rmBVNMzLB1vMo+TOajKDXYbwLJgin4IDH8d24H5t6L2w7C0kX
	2pjRXuCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qsGRL-008QVo-1f;
	Mon, 16 Oct 2023 05:46:55 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qsGRI-008QU5-0Y
	for linux-nvme@lists.infradead.org;
	Mon, 16 Oct 2023 05:46:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 197936732A; Mon, 16 Oct 2023 07:46:48 +0200 (CEST)
Date: Mon, 16 Oct 2023 07:46:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshiiitr@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
	Keith Busch <kbusch@kernel.org>, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, vincentfu@gmail.com,
	ankit.kumar@samsung.com, stable@vger.kernel.org,
	Vincent Fu <vincent.fu@samsung.com>
Subject: Re: [PATCH v4] nvme: fix corruption for passthrough meta/data
Message-ID: <20231016054647.GA26170@lst.de>
References: <CGME20231013052157epcas5p3dc0698c56f9846191d315fa8d33ccb5c@epcas5p3.samsung.com> <20231013051458.39987-1-joshi.k@samsung.com> <20231013052612.GA6423@lst.de> <8c755915-2366-28ff-ffd4-be17d797557c@samsung.com> <ZSlL-6Oa5J9duahR@kbusch-mbp> <3438f3b8-f7d4-f0bd-44ef-7efb09ed6151@samsung.com> <20231013154708.GA17455@lst.de> <CA+1E3rKaUW0YN+bphe9n26ZRTX1rq6M0z7Hpc=zLOJE1AER9hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+1E3rKaUW0YN+bphe9n26ZRTX1rq6M0z7Hpc=zLOJE1AER9hw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231015_224652_350079_DE090CFF 
X-CRM114-Status: UNSURE (   9.66  )
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

On Mon, Oct 16, 2023 at 12:49:45AM +0530, Kanchan Joshi wrote:
> OTOH, this patch implemented a software-only way out. There are some
> checks, but someone (either SW or HW) has to do those to keep things
> right.

It only verifies it to the read/write family of commands by
interpreting these commands.  It still leaves a wide hole for any
other command.

