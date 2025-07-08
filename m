Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6415C83030
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jul 2025 02:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ku/rduJUL16lk7JqLnMragH8M6Kmzlsc4XCY1ogkqwk=; b=Kef9YJebBnkq/enrMBSUV8rjGE
	1ddXdl9Wkijc3BqKNdOubUO9a85ZPhDpraTaRGyJmztYbS5zy18oNRrIAWyW3ccdtOQp6yRXirxOS
	9iA0tGzJrTL1m5maeajD6KMkvYhA8I9BHb28EXtYBVEjfSPQENbUhYUUDmXPyyELstK71YsyoyoXM
	VtEey4nrDu6t4t6lX0W89fFlV+RG6YN4DSoZujg+7bS1G0MCbos2/o40S68bLR5ciH1CpiaKHaRlO
	a/iP4iktS9Bu326V1JUDgkAxjldOj/XV10O7AHPik9p3btQZ2kCj23VtupPRG690hXGuiH73YOB9G
	HmlRPtqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYy3h-000000045It-35Hi;
	Tue, 08 Jul 2025 02:27:49 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYy3f-000000045HU-0wo6
	for linux-nvme@lists.infradead.org;
	Tue, 08 Jul 2025 02:27:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2456E5C5EA6;
	Tue,  8 Jul 2025 02:27:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C60C4CEE3;
	Tue,  8 Jul 2025 02:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751941665;
	bh=01pWccaiT/a3nvWnmcclCumAkVqj/xd68Zh8X2khoIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L9Hi+X9cD5E7akEXAU0QbGsKkA67wgvWCrIVK1bf24lZzV1uBaiaQlwwanNqM4x10
	 0hFSos+T/UqUMd9XzUjKUUCzZArtly01DSDT+ggVGjEs8GSUBMpI87yvPLU0kKkInQ
	 lYrnJ9mcJLC4foqZ78KjGXzuEB293pyge5I9Cb7tWfzULUxKvn33oTHQ+OmHF1VPse
	 gS3bifBOoiC9EvCO/HSjnyLk1Kfcd0rmpXUbfOAfIncdOBnideNh1OBZRlz5MXJaCd
	 37pGCefGAStdG3R5IdOZFWtMFxrhoZjtdCumq+od+sWr+U/7X+8mOiRv/XrLML5wrj
	 e1VGzgB/xC3LQ==
Date: Mon, 7 Jul 2025 20:27:43 -0600
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Alan Adamson <alan.adamson@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: What should we do about the nvme atomics mess?
Message-ID: <aGyCH8TOQgVY3AP9@kbusch-mbp>
References: <20250707141834.GA30198@lst.de>
 <aGxz6s9oUp2FkbyX@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGxz6s9oUp2FkbyX@fedora>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250707_192747_299683_0711B9D2 
X-CRM114-Status: GOOD (  21.03  )
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

On Tue, Jul 08, 2025 at 09:27:06AM +0800, Ming Lei wrote:
> On Mon, Jul 07, 2025 at 04:18:34PM +0200, Christoph Hellwig wrote:
> > Hi all,
> > 
> > I'm a bit lost on what to do about the sad state of NVMe atomic writes.
> > 
> > As a short reminder the main issues are:
> > 
> >  1) there is no flag on a command to request atomic (aka non-torn)
> >     behavior, instead writes adhering to the atomicy requirements will
> >     never be torn, and writes not adhering them can be torn any time.
> >     This differs from SCSI where atomic writes have to be be explicitly
> >     requested and fail when they can't be satisfied
> >  2) the original way to indicate the main atomicy limit is the AWUPF
> >     field, which is in Identify Controller, but specified in logical
> >     blocks which only exist at a namespace layer.  This a) lead to
> 
> If controller-wide AWUPF is a must property, the length has to be aligned
> with block size.

What block size? The controller doesn't have one. Block sizes are
properties of namespaces, not controllers or subsystems. If you have 10
namespaces with 10 different block formats, what does AUWPF mean? If the
controller must report something, the only rational thing it could
declare is reduced to the greatest common denominator, which is out of
sync with the true value reported in the appropriately scoped NAUWPF
value.

