Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB862D0C601
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2024 12:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2gR5DYOQIaIYHxPAgnKsME6durGnBAfGyV2RML7XQHQ=; b=qn/EWlzItY5EqrRrbQc3Rz3f3q
	JNqs5c3sDSvjw4HY7mncq3Qv27VHvANZHWFGOOJyFEpxn8by64zOozMh7DwYXk3s+qfaBIujr8ri8
	VdiswS2W/A3PBqZwkUG6pDkf9RADGtr+0XP7zBlE9XnqLYEG/VdFVfC+WUOq7caz0nZujJr/w8OeH
	vNfXY6eljqCYga7BaQLSoj2u5orrUTSKaA6gspvL5AsAFMC4jQExOKF9eLzK6kiOv6shBFw5/Povn
	O/6ww+GE2I/qN8Pf1oRKWHZSvRioOMVIwRwhI6T5mQUUa6p1t2mFMXNo743OEdK5rApKrXGROLKYL
	AbFNjrnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4JJh-00000003dLz-12gU;
	Fri, 25 Oct 2024 12:21:21 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4JIZ-00000003d6X-1DZJ
	for linux-nvme@lists.infradead.org;
	Fri, 25 Oct 2024 12:20:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 75910227A88; Fri, 25 Oct 2024 14:20:04 +0200 (CEST)
Date: Fri, 25 Oct 2024 14:20:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, joshi.k@samsung.com,
	javier.gonz@samsung.com
Subject: Re: [PATCHv8 2/6] block: use generic u16 for write hints
Message-ID: <20241025122004.GA22710@lst.de>
References: <20241017160937.2283225-1-kbusch@meta.com> <20241017160937.2283225-3-kbusch@meta.com> <20241018054643.GA20262@lst.de> <Zxqjvu0w9OsJN2uB@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zxqjvu0w9OsJN2uB@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_052011_491572_C5C379EA 
X-CRM114-Status: GOOD (  16.97  )
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

On Thu, Oct 24, 2024 at 01:45:02PM -0600, Keith Busch wrote:
> I'm not sure I follow this feedback. The SCSI feature is defined as a
> lifetime stream association in SBC-5. So it's still a stream for SCSI,
> but you want to call it "WRITE_HINT", which is not a term used in the
> SCSI spec for this feature. But, you want to call it STREAM_SEPARATION
> for NVMe only, even though the FDP spec doesn't use that term? What's
> wrong with just calling it a generic hint support feature?

The "Constrained Streams with Data Lifetimes" are called streams for
political reasons but they are not.  They are buckets of different data
lifetimes.

> I also don't see why SCSI couldn't use per-io hints just like this
> enables for NVMe. The spec doesn't limit SCSI to just 5 streams, so this
> provides a way to access them all through the raw block device.

I don't mind passing per-I/O temperature hints to SCSI block devices.

But we should not confuse a streams/FDP like streams that are different
context which are assumed to be discarded together and have a concept of
Stream Granularity Size or Reclaim Unit size with the data temperature
hints that are at the storage level fundamentally per-I/O and just bucket
into temperature group without any indication of data locality.

