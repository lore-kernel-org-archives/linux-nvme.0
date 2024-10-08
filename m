Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5775CEF162
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Oct 2024 12:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Cq8TVZkjVXWgdpoRFNdDz4M+b7l0a5CPhAgpyeEfnQU=; b=xdGLHEbuOTAtck7ndazmCEloEd
	aou2iPLaxLlYZ19w1OGQg5uM6P7hpU5BEoKBJ8d22ddt44D4N2aOj3gisVLg8lCiCGc4lXpQu/qn9
	Fm7Ezg/W5X9PcBPEwKdjdeu5PGEmwFLmOjoymCg57sd7EJpA7gXf3N3CIIcVFITnW2Iyy04ni+x2A
	q5hYof6kNLetGqTg2c2ry4fcbb7ozkgmwpZAeNeGKKS2iXPB9FfVB0WWDdiTPHDa8T82IOUIDuvNg
	wSXQlOPbYaTsGpu3PPA5vdGkVg1jusWSXxxKvLA2QLdBLR3bChLtBgjhJ/MlXGu1i5KtAbp4FOzym
	BHY9Hubw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sy9Kf-00000005oSw-2cLO;
	Tue, 08 Oct 2024 12:28:53 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sy9HZ-00000005nn7-3X68
	for linux-nvme@lists.infradead.org;
	Tue, 08 Oct 2024 12:25:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C8B4F227A88; Tue,  8 Oct 2024 14:25:35 +0200 (CEST)
Date: Tue, 8 Oct 2024 14:25:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>,
	Kanchan Joshi <joshi.k@samsung.com>, hare@suse.de, sagi@grimberg.me,
	brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	jaegeuk@kernel.org, bcrl@kvack.org, dhowells@redhat.com,
	bvanassche@acm.org, asml.silence@gmail.com,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, linux-block@vger.kernel.org,
	linux-aio@kvack.org, gost.dev@samsung.com, vishak.g@samsung.com
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
Message-ID: <20241008122535.GA29639@lst.de>
References: <yq17caq5xvg.fsf@ca-mkp.ca.oracle.com> <20241003125400.GB17031@lst.de> <c68fef87-288a-42c7-9185-8ac173962838@kernel.dk> <CGME20241004053129eucas1p2aa4888a11a20a1a6287e7a32bbf3316b@eucas1p2.samsung.com> <20241004053121.GB14265@lst.de> <20241004061811.hxhzj4n2juqaws7d@ArmHalley.local> <20241004062733.GB14876@lst.de> <20241004065233.oc5gqcq3lyaxzjhz@ArmHalley.local> <20241004123027.GA19168@lst.de> <20241007101011.boufh3tipewgvuao@ArmHalley.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241007101011.boufh3tipewgvuao@ArmHalley.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241008_052542_045817_9EAAE8D9 
X-CRM114-Status: GOOD (  14.68  )
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

On Mon, Oct 07, 2024 at 12:10:11PM +0200, Javier González wrote:
> In summary, what we are asking for is to take the patches that cover the
> current use-case, and work together on what might be needed for better
> FS support.

And I really do not think it is a good idea.  For one it actually
works against the stated intent of the FDP spec.  Second extending
the hints to per per-I/O in the io_uring patch is actively breaking
the nice per-file I/O hint abstraction we have right now, and is
really unsuitable when actually used on a file and not just a block
device.  And if you are only on a block device I think passthrough
of some form is still the far better option, despite the problems
with it mentioned by Keith.


