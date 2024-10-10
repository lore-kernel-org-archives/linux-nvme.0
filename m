Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA06CF07DD
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2024 09:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YH3pehWN7rSJhW07A1UluEjSI6zrGcLDffuxxWvQRd0=; b=rVA1txwZGIRRp5vRQnb7NpgHVh
	T8oiVKTi+2jZPV08Zhr3s089G+LthwK6uIZCUGeUE1AL6PjxFVxcSishMR9GrbzM/ROYe95D+DFAg
	QSMWGLpUnKq04jxCq+DoGcobXkXUJMNDcoT5xeIzJ8uPOUlYoSLJQBiF+GC9gQKxk1U4TuYlaGYlS
	r4CzPgkw2CFJp61GVuxbGclMPk3gYzD4Yc5HgMEkPqt2MhuSTuyW+V4RdSqsthMpd3cURc5+GWfAC
	3EcI1VOPcrfSj/0fhSLvkHA6eOW6+elKXg4Tv++rmlasdbZd+EmLxbaFgvbliTD5eDy2Bd06TkprJ
	8EY1Vslg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sypEu-0000000CBHO-1xpa;
	Thu, 10 Oct 2024 09:13:44 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sypEt-0000000CBGn-0EWk
	for linux-nvme@bombadil.infradead.org;
	Thu, 10 Oct 2024 09:13:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=YH3pehWN7rSJhW07A1UluEjSI6zrGcLDffuxxWvQRd0=; b=RMwUaqbueH1F4MdqH5gHeWFIGc
	TDRiiyb3r4a5qYYcU/MlBHhc3yXpTUqesXpc76XoUUeWxamLjHJ/mULhx3DHwRDPPMti2H5plYl+l
	gMum2bSTDKI2YcykAZovlcRlCzVIr4eaOlJZcTrNR2M4dTox1/4s64XKZ2661ZKXs4ezrV0enN+Wc
	3j6pYp81jBu4+BhSdcPYIKT3MXq2lCKxsLX8zCS7tSx/pXSK4psE+GN0ieSwoacZj1q3EjnYxQCtq
	z6I1EpWMSn2TDe20AdvQo/5qz3c1EHllupY9e9HdQv4IHyjwkWhr0mb9ZqqbFJEeqr7I7KX+iJ+Vg
	PsSzXUZQ==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sypEp-00000005JHA-3qTC
	for linux-nvme@lists.infradead.org;
	Thu, 10 Oct 2024 09:13:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 370CF227A8E; Thu, 10 Oct 2024 11:13:34 +0200 (CEST)
Date: Thu, 10 Oct 2024 11:13:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
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
Message-ID: <20241010091333.GB9287@lst.de>
References: <20241004062733.GB14876@lst.de> <20241004065233.oc5gqcq3lyaxzjhz@ArmHalley.local> <20241004123027.GA19168@lst.de> <20241007101011.boufh3tipewgvuao@ArmHalley.local> <20241008122535.GA29639@lst.de> <ZwVFTHMjrI4MaPtj@kbusch-mbp> <20241009092828.GA18118@lst.de> <Zwab8WDgdqwhadlE@kbusch-mbp> <CGME20241010070738eucas1p2057209e5f669f37ca586ad4a619289ed@eucas1p2.samsung.com> <20241010070736.de32zgad4qmfohhe@ArmHalley.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241010070736.de32zgad4qmfohhe@ArmHalley.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241010_101340_075795_1F984E12 
X-CRM114-Status: GOOD (  24.59  )
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

On Thu, Oct 10, 2024 at 09:07:36AM +0200, Javier González wrote:
> I think we should attempt to pursue that with an example in mind. Seems
> XFS is the clear candidate. You have done work already in enable SMR
> HDDs; it seems we can get FDP under that umbrella. This will however
> take time to get right. We can help with development, testing, and
> experimental evaluation on the WAF benefits for such an interface.

Or ZNS SSDs for that matter.

> However, this work should not block existing hardware enabling an
> existing use-case. The current patches are not intrusive. They do not
> make changse to the API and merely wire up what is there to the driver.
> Anyone using temperaturs will be able to use FDP - this is a win without
> a maintainance burden attached to it. The change to the FS / application
> API will not require major changes either; I believe we all agree that
> we cannot remove the temperatures, so all existing temperature users
> will be able to continue using them; we will just add an alternative for
> power users on the side.

As mentioned probably close to a dozen times over this thread and it's
predecessors:  Keeping the per-file I/O hint API and mapping that to
FDP is fine.  Exposing the overly-simplistic hints to the NVMe driver
through the entire I/O stack and locking us into that is not.

> So the proposal is to merge the patches as they are and commit to work
> together on a new, better API for in-kernel users (FS), and for
> applications (syscall, uring).

And because of that the whole merge it now and fix it later unfortunately
doesn't work, as a proper implementation will regress behavior for at
least some users that only have the I/O hints API but try to emulate
real stream separation with it.  With the per-I/O hints in io_uring that
is in fact almost guaranteed.


