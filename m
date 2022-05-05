Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84DF3C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  5 May 2022 19:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AHqVvZLGSCZCDSx1K3+XOWxfAWUm++VCLghWIpwiCio=; b=eTA5WkjmP6JaSmgjBbmKLAmLWg
	FV2L+3YlvO/zQMCyQEdJ9QtNgln8zBrnitM2je8iAP66/GqbZm/l4+tvSOfGMagLU7Fy7r5KLiRax
	5u8bJvTHJdXXY+O87qb24QbkTjF/Puu76Bv5y9v0afQHRpRtPZxJIpnc75+6wLwckGqKWLzEDNZMt
	CUWni2touOptWH3jIv+3hvVGyu29uhfJVoPy5IF141t38UTne2Jc+FPYY0D7Y/NAa6rLXAeuC8fEI
	0gg6aRdW99ceORSHWclMUWEl0lsUIpXnOyl4L3LTpSIKeQbMtCAoABaDXpbApBki+bJFuE2av6gx/
	6oLTmVTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmhWF-0000d5-W3; Thu, 05 May 2022 19:52:12 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmhUt-00HahB-IY
 for linux-nvme@lists.infradead.org; Thu, 05 May 2022 19:50:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2B03F68AA6; Thu,  5 May 2022 21:50:40 +0200 (CEST)
Date: Thu, 5 May 2022 21:50:39 +0200
From: "hch@lst.de" <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Clay Mayers <Clay.Mayers@kioxia.com>,
 Kanchan Joshi <joshi.k@samsung.com>, "hch@lst.de" <hch@lst.de>,
 "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "asml.silence@gmail.com" <asml.silence@gmail.com>,
 "ming.lei@redhat.com" <ming.lei@redhat.com>,
 "mcgrof@kernel.org" <mcgrof@kernel.org>, "shr@fb.com" <shr@fb.com>,
 "joshiiitr@gmail.com" <joshiiitr@gmail.com>,
 "anuj20.g@samsung.com" <anuj20.g@samsung.com>,
 "gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [PATCH v4 3/5] nvme: refactor nvme_submit_user_cmd()
Message-ID: <20220505195039.GA7032@lst.de>
References: <20220505060616.803816-1-joshi.k@samsung.com>
 <CGME20220505061148epcas5p188618b5b15a95cbe48c8c1559a18c994@epcas5p1.samsung.com>
 <20220505060616.803816-4-joshi.k@samsung.com>
 <80cde2cfd566454fa4b160492c7336c2@kioxia.com>
 <ce25812c-9cf4-efe5-ac9e-13afd5803e64@kernel.dk>
 <93e697b1-42c5-d2f4-8fb8-7b5d1892e871@kernel.dk>
 <0b16682a30434d9c820a888ae0dc9ac5@kioxia.com>
 <70c1a8d3-ed82-0a5b-907a-7d6bedd73ccc@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70c1a8d3-ed82-0a5b-907a-7d6bedd73ccc@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220505_125047_796098_81113005 
X-CRM114-Status: GOOD (  11.17  )
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

On Thu, May 05, 2022 at 01:31:28PM -0600, Jens Axboe wrote:
> >> Jens Axboe
> > 
> > This does work and got me past the null ptr segfault.
> 
> OK good, thanks for testing. I did fold it in.

It might make sense to just kill nvme_meta_from_bio and pass the
meta pointer directly with this version of the code.

