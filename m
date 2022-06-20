Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3779C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jun 2022 07:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8sbgNKowbB8p2kSqOBP1nsPa9GasIvhVlmlCJT/2rGg=; b=orIoaqxi7DyP6kTev2WYkCagHi
	sdmtj15jK4i83lCqqrFPrvHlJ1zEjrmRUHKNUdt7C8dH1HSaBCMciLT/4/97SfSwi0wKdQ0QKAB4H
	ObH3H3ObWW53GKxc4XqCejD6Hh6wmizDopl2EaKDVo65MJgKu1vx282vK/67ZMOXIKbh74WCx5pxu
	6+HbDAclyx6Lq81oh12WIMjvWqrM7HXlR4rzK0wlhUP5Vo/9bkTiv+8W+1lxlN3q9vK7eJAUwuJuQ
	uoPiWjvX48gx5dg8RPo3q/kS7kRLdfA1T7SdtX4suXxKQyu21w7SUyfC6H3xUIKg1V0QcU43A/nYN
	7BGJe6ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3BaO-00Gbx8-7p; Mon, 20 Jun 2022 07:12:36 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3BaL-00Gbw6-TC
	for linux-nvme@lists.infradead.org; Mon, 20 Jun 2022 07:12:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8F79668AA6; Mon, 20 Jun 2022 09:12:29 +0200 (CEST)
Date: Mon, 20 Jun 2022 09:12:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mike Christie <michael.christie@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	dm-devel@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
	martin.petersen@oracle.com, james.bottomley@hansenpartnership.com,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 0/8] Use block pr_ops in LIO
Message-ID: <20220620071229.GB11418@lst.de>
References: <20220603065536.5641-1-michael.christie@oracle.com> <20220603114645.GA14309@lst.de> <2634b3ae-f63d-c711-36cd-bf8f56ecc43b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2634b3ae-f63d-c711-36cd-bf8f56ecc43b@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220620_001234_133116_A19E2BC4 
X-CRM114-Status: GOOD (  17.00  )
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

On Fri, Jun 03, 2022 at 12:55:33PM -0500, Mike Christie wrote:
> However, for nvme and for the interface we want to provide to userspace,
> do we want to implement an interface like READ_FULL_STATUS and report
> reservations where we report the host/controller/port info? If so, below
> is a patch I started.

If we wire the ops up to the nvme target we'd need that.  But for now
I think the more useful case would be to use nvme as the underlying
devices for the scsi target that already has all the PR infrastructure
and helps to validate the interface.

> Notes:
> 1. I hit some issues with SCSI targets not reporting the IDs sometimes or
> sometimes they report it incorrectly. For nvme, it seems easier. SCSI has 
> to handle a hand full of ways to report the ID where nvme has 2 ways to
> do the host ID.

Yeah.

> 2. I couldn't find a nvme device to test. Qemu and nvmet don't seem to
> support reservations.

Basically any dual ported PCIe SSD should support them, typically those
are the U.2 format factor ones found in servers or enclosures.

