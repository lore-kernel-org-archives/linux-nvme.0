Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A730C27C5E
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jun 2024 05:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d/Xvwk8apUZsol+MDSIOy35JXYnSVjueR83rSqb25FM=; b=MlGS3namja1ubk9S4gm5CzRInN
	0C07s9kSkdnRjbAFUpsceaMl4NpJxMEzlYcu7r/3sUoQz+TpSLo4c2+pGJgPHY3/fEZfS5naNPBod
	IHZRLg91+VuAcGFg+doKgpmVwS8wS3XZeFiGQuul07sA3/Y+g3Zgubq+guHVdPPxIY9ZvRcq154/g
	VRB8314hDAHakYUbvQY+HCX08Wz3C9+UayGwsdcm/6MWnhnAyWPAEVF+qKGbMe6l6phHOQbkQ5xpc
	Tm6yb8TCmUrC3n5dKuOboUAB3UqHh4xQS4HaEuG6e7yQkQA5I4JfwEo/NAIIG7sNY0bUa+H7Sem5q
	r0LIVQ8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGuM5-00000007ZbM-3tP1;
	Tue, 11 Jun 2024 05:47:37 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGuM2-00000007ZZn-36fj
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jun 2024 05:47:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BD8C367373; Tue, 11 Jun 2024 07:47:26 +0200 (CEST)
Date: Tue, 11 Jun 2024 07:47:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	javier.gonz@samsung.com, bvanassche@acm.org, gost.dev@samsung.com,
	Hui Qi <hui81.qi@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH v2] nvme: enable FDP support
Message-ID: <20240611054726.GA2680@lst.de>
References: <CGME20240528151007epcas5p32583675f647553923e5ba4987e9bc6ed@epcas5p3.samsung.com> <20240528150233.55562-1-joshi.k@samsung.com> <ZmMj3d1Rvv-5E6Ey@kbusch-mbp.dhcp.thefacebook.com> <20240608051740.GA24010@lst.de> <5e686875-21de-869d-4b19-bdd9e272d690@samsung.com> <yq1r0d53vi4.fsf@ca-mkp.ca.oracle.com> <20240610115541.GB19495@lst.de> <ZmcTHMWb-T78Crfn@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmcTHMWb-T78Crfn@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240610_224734_954724_EEE64A42 
X-CRM114-Status: GOOD (  15.85  )
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

On Mon, Jun 10, 2024 at 08:52:12AM -0600, Keith Busch wrote:
> I agree the FDP setup is complicated, but none of that is taken on by
> the driver. It just discovers the capabilities and maps an arbitrary
> software "hint" to an arbitrary device "hint". It's up to the
> application to use those optimally; the driver just performs the
> requested mapping.
> 
> Is it because the names of those hints indicate data lifetime? These are
> just arbitrary numbers used by applications to separate placement. If
> they were called HINT_A, HINT_B, HINT_C, would that make this ok?

No, the other problem is that FDP very much has an implicit contract
that the host actually aligns to it resources units, and actually
has a really complicated mangement.  It's not a simple throw a
lifetime hint at the drive.  Note that the implicit is indeed very
implicit - it is a really horrible spec with a lot of assumptions
but nothing actually enforcing it.  If you just use it for dumb
lifetime hints changes are that you actually increase write
amplificiation.

