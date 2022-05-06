Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C593C433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  6 May 2022 05:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4eZhwFvUagtVpH1IGTk1wfBLMGHAewSczwqQ4E7GLn0=; b=0ZpsTeCIspWNdk1WyT2Qh6vqeR
	OMW8XuXOoJAs/yw/x75OdErodzDAKgmYz5vBDrdjv0IrINKUx7vNdE4pajU5t5nU1jXv7U2pNAnEr
	k6D3249mLHnuNJ6NLrEWGMJvH/D7P1t0+yxdXjVlK7y1igV5AfVhhFqwwmL57R5fn/7if0s0P4FZC
	02BDXwMtVR4zTmKbMTNAFIylpqybDd3grjsBNKL8hRXBTA0fR6oTpFOn7PEUdCElQTEaVnjedKgI1
	FkK/6JQM9W5GP6im96ZxGH9MPrtaDycWuy0EdU3jC6Ftz0GRuNI6dUnu8qnyRQzshBfYNmX4mYpz/
	AuedyfeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmqwj-001WcT-4X; Fri, 06 May 2022 05:56:09 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmqwf-001Wbi-RV
 for linux-nvme@lists.infradead.org; Fri, 06 May 2022 05:56:07 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5FDB768AA6; Fri,  6 May 2022 07:56:00 +0200 (CEST)
Date: Fri, 6 May 2022 07:56:00 +0200
From: "hch@lst.de" <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "hch@lst.de" <hch@lst.de>, Clay Mayers <Clay.Mayers@kioxia.com>,
 Kanchan Joshi <joshi.k@samsung.com>,
 "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "asml.silence@gmail.com" <asml.silence@gmail.com>,
 "ming.lei@redhat.com" <ming.lei@redhat.com>,
 "mcgrof@kernel.org" <mcgrof@kernel.org>, "shr@fb.com" <shr@fb.com>,
 "joshiiitr@gmail.com" <joshiiitr@gmail.com>,
 "anuj20.g@samsung.com" <anuj20.g@samsung.com>,
 "gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [PATCH v4 3/5] nvme: refactor nvme_submit_user_cmd()
Message-ID: <20220506055600.GA22544@lst.de>
References: <20220505060616.803816-1-joshi.k@samsung.com>
 <CGME20220505061148epcas5p188618b5b15a95cbe48c8c1559a18c994@epcas5p1.samsung.com>
 <20220505060616.803816-4-joshi.k@samsung.com>
 <80cde2cfd566454fa4b160492c7336c2@kioxia.com>
 <ce25812c-9cf4-efe5-ac9e-13afd5803e64@kernel.dk>
 <93e697b1-42c5-d2f4-8fb8-7b5d1892e871@kernel.dk>
 <0b16682a30434d9c820a888ae0dc9ac5@kioxia.com>
 <70c1a8d3-ed82-0a5b-907a-7d6bedd73ccc@kernel.dk>
 <20220505195039.GA7032@lst.de>
 <06a03ddf-215a-b558-4ff6-bae46c33d51d@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06a03ddf-215a-b558-4ff6-bae46c33d51d@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220505_225606_084198_A73C2DB3 
X-CRM114-Status: GOOD (  16.89  )
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

On Thu, May 05, 2022 at 02:44:40PM -0600, Jens Axboe wrote:
> On 5/5/22 1:50 PM, hch@lst.de wrote:
> > On Thu, May 05, 2022 at 01:31:28PM -0600, Jens Axboe wrote:
> >>>> Jens Axboe
> >>>
> >>> This does work and got me past the null ptr segfault.
> >>
> >> OK good, thanks for testing. I did fold it in.
> > 
> > It might make sense to just kill nvme_meta_from_bio and pass the
> > meta pointer directly with this version of the code.
> 
> Do you want to do an incremental for that? Looking at
> nvme_execute_user_rq() and nvme_uring_task_cb() there's a fair bit of
> duplication of the meta copy.

Yes, there is.  And the right way is to keep the integrity payload alive
longer, but I'm not sure we are going to get that done in time..

