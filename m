Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCC5D6B6D5
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 20:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rdfDSmeOqJInklxhIi/x9HCj03Oxx4jJoZjK5F5hO9U=; b=TOKY/IIfWpwP7tLBK798bQIpsV
	SFdi+4O9FXY2DPL6gn/+Yvx4ekGYig+dwMfl3hsV8yyms75YwcRHu+ilDXiTroXXta6T8S1Lcg5lf
	x+JW16o8iyxmsetoRL/LK7vg1mxSNhMJEuO7tU7TWMHNBHnhR5dhBVl6Oc77W0Oz4u8W8J5Rd8OSc
	5l1oGedkxXmJsdf9NK50PhjqcJhS94hrt1wLeXMLSOV04Vxyw0weS81+sgDCwl6LtLgabWku/zdsj
	PSUNxo18AepfqsEW9gvoCInTF/IsxgjfG0driE4MNxBWaYQ6t6+Wldp1qBPhd9x2RRqr9wM1gBa1+
	1zmR4xNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6F2m-00000001cUo-1PuV;
	Wed, 30 Oct 2024 20:11:52 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6F2j-00000001cU0-0ZWD
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 20:11:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4EA055C5EA0;
	Wed, 30 Oct 2024 20:11:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F2DC4CECE;
	Wed, 30 Oct 2024 20:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730319107;
	bh=9xxRKEESrcbPlUbEacTObvDmHtRajxp0C89Y8pmgNZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JvcaSxIZWVXsT2nD1KY5BGzDrS2q3a9Z0Sd3N1iMi0mY0+bcuyd6HIT6OMgvEJJee
	 bndn73Xmm0OhipBMLGiuU6rGd1Mde68iMUX4i3Dk+3atz2WxSJu1EMgkTdX45IY6Iz
	 q505ptcEG0R3oezySaAgBU4SdJ6G6rhQiOXxQLwoaWHdFEenqlAJIYtgMbZ+E2MZXg
	 Nkfeufptp+NxmK6RqHE6I88y4rAcdqZoqzq3UE+HiZSni+4T5z4j2+oGZDpasgqW86
	 KYL7fO4P6J9Ftfr7WVjjtiWSWN5h99RehzQQRhYthWQE6f7b/PNESjM2laktTDEFq1
	 yLOVZGY6YmR7w==
Date: Wed, 30 Oct 2024 14:11:44 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, joshi.k@samsung.com,
	javier.gonz@samsung.com
Subject: Re: [PATCHv10 4/9] block: allow ability to limit partition write
 hints
Message-ID: <ZyKTACiLUsCEcJ-R@kbusch-mbp.dhcp.thefacebook.com>
References: <20241029151922.459139-1-kbusch@meta.com>
 <20241029151922.459139-5-kbusch@meta.com>
 <a1ff3560-4072-4ecf-8501-e353b1c98bf0@acm.org>
 <20241030044658.GA32344@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030044658.GA32344@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_131149_239464_B35D6552 
X-CRM114-Status: GOOD (  14.90  )
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

On Wed, Oct 30, 2024 at 05:46:58AM +0100, Christoph Hellwig wrote:
> On Tue, Oct 29, 2024 at 10:25:11AM -0700, Bart Van Assche wrote:
> >> +}
> >
> > bitmap_copy() is not atomic. Shouldn't the bitmap_copy() call be
> > serialized against the code that tests bits in bdev->write_hint_mask?
> 
> It needs something.  I actually pointed that out last round, but forgot
> about it again this time :)

I disagree. Whether we serialize it or not, writes in flight will either
think it can write or it won't. There's no point adding any overhead to
the IO path for this as you can't stop ending up with inflight writes
using the tag you're trying to turn off.

This is the same as the "ro" attribute. If you're changing it with
BLKROSET ioctl with writes in flight, some of those writes may get past
blkdev_write_iter's read-only check, others may not. No serialization
done there, and this pretty much the same thing.

