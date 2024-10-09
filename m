Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C6FCEDDA4
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Oct 2024 15:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=if+fzPRcbjsk76t24bBaaYKzJnID87iOpTP3I1zPCoU=; b=HjE/ZJvw5m+yJxA++WpMoSjN0y
	DfRWW9BKis9kPGY6IqS1XCOkiNB52KupavQao5Ss+M2z78L3KuxI+1xt4FPLhkckI3EKSgz7HoHPN
	bztBX9FGeYwl73He/WMHgBUoRpeEpk4u+g4pi2j2XzfE5ZF5kowQtImYqt+kxNCJBZxMfLTpgBUfe
	OUIAZ3olcUvauRI6p26J9z22C1Moa1O3E0Ianzvzh8aTEkFLinb73Jo1qQAyoQsQQSi/PUA2GuZCd
	+ZNLRlhl1gIRaawLL8itmfS+h+qevTuECGat6A/f28Ex8iSv0O3j8htajwfqp2BcaGlDOd6AJ/ovZ
	R55CT5Fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syYGn-00000009iGc-0tSS;
	Wed, 09 Oct 2024 15:06:33 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syYGk-00000009iFn-03vc
	for linux-nvme@lists.infradead.org;
	Wed, 09 Oct 2024 15:06:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 31E335C5806;
	Wed,  9 Oct 2024 15:06:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E87CC4CEC5;
	Wed,  9 Oct 2024 15:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728486389;
	bh=GOfOzG0fD+GRAJQcUGGAR2F6juLmVMJ1gpAQWILv1vI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dHgBTrUv1SJ4J1xPqWa86y8KnZRku+OSTxa1E7iRUFfjrpSn5XA3sMXPrT/3ISx2Q
	 LsvrdcVswPRIAFyxqIG7C/PYfRNYO8iQ2WyLuY3vzpyYTJB+UlZMqCzfHd/OP9mGMf
	 I2fToIWXK1w5UqrOT4KtRx8bnsg7o0bfKbabdTOIxH96Kaff/cifh/w//w1SEIlELG
	 70bscEQ9TTwSqI38JRrGuy3s9VawyMk+j8Aq5e2zoxoOTG7kLarXza1YD4otS1LrzE
	 N6z+y7zDxoQZvcNjcODDpymOYqROIB+dJwJXyfK4WhpBkwmSbaCv07J+IxtDyrRY5w
	 XCipjlUVQSNLg==
Date: Wed, 9 Oct 2024 09:06:25 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
	Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Kanchan Joshi <joshi.k@samsung.com>, hare@suse.de, sagi@grimberg.me,
	brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	jaegeuk@kernel.org, bcrl@kvack.org, dhowells@redhat.com,
	bvanassche@acm.org, asml.silence@gmail.com,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, linux-block@vger.kernel.org,
	linux-aio@kvack.org, gost.dev@samsung.com, vishak.g@samsung.com
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
Message-ID: <Zwab8WDgdqwhadlE@kbusch-mbp>
References: <CGME20241004053129eucas1p2aa4888a11a20a1a6287e7a32bbf3316b@eucas1p2.samsung.com>
 <20241004053121.GB14265@lst.de>
 <20241004061811.hxhzj4n2juqaws7d@ArmHalley.local>
 <20241004062733.GB14876@lst.de>
 <20241004065233.oc5gqcq3lyaxzjhz@ArmHalley.local>
 <20241004123027.GA19168@lst.de>
 <20241007101011.boufh3tipewgvuao@ArmHalley.local>
 <20241008122535.GA29639@lst.de>
 <ZwVFTHMjrI4MaPtj@kbusch-mbp>
 <20241009092828.GA18118@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009092828.GA18118@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241009_080630_115517_E1954804 
X-CRM114-Status: GOOD (  14.66  )
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

On Wed, Oct 09, 2024 at 11:28:28AM +0200, Christoph Hellwig wrote:
> On Tue, Oct 08, 2024 at 08:44:28AM -0600, Keith Busch wrote:
> > Then let's just continue with patches 1 and 2. They introduce no new
> > user or kernel APIs, and people have already reported improvements using
> > it.
> 
> They are still not any way actually exposing the FDP functionality
> in the standard though.  How is your application going to align
> anything to the reclaim unit?  Or is this another of the cases where
> as a hyperscaler you just "know" from the data sheet?

As far as I know, this is an inconsequential spec detail that is not
being considered by any applications testing this. And yet, the expected
imrpovements are still there, so I don't see a point holding this up for
that reason.

