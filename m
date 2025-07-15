Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 919D1C83F21
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jul 2025 12:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A33SYO1f1TFl7htpYmaPxVOHkIHPGGsvvyVdiUx7m+o=; b=Z3H8lOkErrUp6uMdwoDtMI2+9Z
	BTy12aIoAMwBKD4IOx32rS+mADToM1Ue5Qb43/duUHz4yBiqEsZvz9I5CblWhHQyaWY0uddYF0CYA
	zT48NpgBOkSzZ0km1Qsgw+0qzgFOmQlHnnAeeh1NrRohHK4ofWj87DyM0LCI8LF0+gM5VsnKl7fZ4
	BnXPdzPP2P7w8hipsPxbGFcpnR4DEQk2gZzgTnoYY6X60r8A22X8EfhgqPU94XYlJ5eB22cI1aABP
	vCOTG/JDjZVY09MA8rLUjETTUteXRWr5MTKlUeMX027lw6GCLUXwvjuMC1qg402JsCWUoxnTFNeh+
	l0DSEcQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubex8-000000055uS-2hkC;
	Tue, 15 Jul 2025 12:40:10 +0000
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubeJP-000000050ej-3rSA
	for linux-nvme@lists.infradead.org;
	Tue, 15 Jul 2025 11:59:09 +0000
Received: from trampoline.thunk.org (pool-108-26-156-131.bstnma.fios.verizon.net [108.26.156.131])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 56FBwvGV022147
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 07:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1752580740; bh=A33SYO1f1TFl7htpYmaPxVOHkIHPGGsvvyVdiUx7m+o=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=j3mm3jeGrGK+8Z/OG4HSOTiPwSeWSrcJACXPh3387iNdNwoAYIWZ2Oj56Q1dRwA8S
	 uzhoiNRZG9T5yd3OWgqQ9qfbOn4CVJv3wyBmOIkyePTLlrb965tDVxtxuC6gfQuCDa
	 iX18lC+Ysz8hHwIE6yngVRXnukfg7fLORJQ8ol3BsDcX/M56ESyKn23vdLzSHOOpm7
	 mHZ3vD4S1nxtrdWwTve9K5eZxlHORc3CAoIpZf4SiG/BqeNTDGxRjnu57adwGsqHHa
	 RUT7zlDvkRiI+oktOgSnz5a7pmhTphnLMhKMFLPXwx9eF6NUYKBkani0Q6QW0/gjBu
	 /XoPjbgXKWk4A==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 773342E00D5; Tue, 15 Jul 2025 07:58:57 -0400 (EDT)
Date: Tue, 15 Jul 2025 07:58:57 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, John Garry <john.g.garry@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: Do we need an opt-in for file systems use of hw atomic writes?
Message-ID: <20250715115857.GB74698@mit.edu>
References: <20250714131713.GA8742@lst.de>
 <6c3e1c90-1d3d-4567-a392-85870226144f@oracle.com>
 <aHULEGt3d0niAz2e@infradead.org>
 <6babdebb-45d1-4f33-b8b5-6b1c4e381e35@oracle.com>
 <20250715060247.GC18349@lst.de>
 <20250715-rundreise-resignieren-34550a8d92e3@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715-rundreise-resignieren-34550a8d92e3@brauner>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250715_045908_109466_69254808 
X-CRM114-Status: GOOD (  17.28  )
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

On Tue, Jul 15, 2025 at 12:02:06PM +0200, Christian Brauner wrote:
> 
> It feels like this is something that needs to be done on the block
> layer. IOW, maybe add generic block layer ioctls or a per-device sysfs
> entry that allows to turn atomic writes on or off. That information
> would then also potentially available to the filesystem to e.g.,
> generate an info message during mount that hardware atomics are used or
> aren't used. Because ultimately the block layer is where the decision
> needs to be made.

I'd really like it if we can edit the atomic write granularity by
writing to the sysfs file to make it easier to test the atomic write
codepaths in the file system.

So I'd suggest combining this with John Garry's suggestion to allow
atomic writes by default on NVMe devices that report NAWUPF, not to
ignore AWUPF.  If system admistrators need to make atomic writes on
legacy devices that only report AWUPF, they can manually set the
atomic write granulairty.  And if they screw up --- well, that's on
them.

And file system developers who don't care about data safety on power
failure (which we can't directly test via fstests anyway), but just
want to test the code paths, we can manually write to the sysfs file
as well.

Cheers,

						- Ted

