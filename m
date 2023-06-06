Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF46C7EE2A
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jun 2023 08:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=92up3nEwXcDy6umn1R/TACHJg19u+fh56JX1+wfCWP8=; b=WkFu72PQcGS+cdizRlKzOXdKF7
	ewFzoKlsv43VEydjptOA+9d/Uh6vG7i+RdmFaUXFBA4wfFjbUu/l8DgEh0I+2/hDUKXRfBV8EiuTU
	I0R6HJkIkWzuTLNypTmJY4dQm7jzDtgkuJY7kcIYzV6C7AVfXQjQAqwlm+xcw3LjrW21l0JUMntwS
	3gbACUjE/rpT/3wCOSGUAZQig5lULv+xJlO+Cl81UtCg1lYPVGg29xZgweQ2S8GW9rlfWEwqGxL4v
	JNuN3g2L/hWJ83HlvRSxXypJxdyUGeyy2E0PxVR0FjM0yYnXwvxQkzI/srh6AqJu8cf1HLljrQl5e
	fTDtULMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6S2K-000o0s-1S;
	Tue, 06 Jun 2023 08:27:28 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6S2H-000nyq-1P;
	Tue, 06 Jun 2023 08:27:26 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 9D24262ECE;
	Tue,  6 Jun 2023 08:27:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF06C433D2;
	Tue,  6 Jun 2023 08:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686040044;
	bh=Ul2cGfsXNIMiykZwhFC1GhCumtuf5drHj+O/jqIfKC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MIGMl8H6ZE1RDdRAyTflrfjbWgwVzW92xqGaMt1JiQ4SA+mJ4HMs0LbcBMXK3XGit
	 s8AH6LT5xvGT0yz9De/gwc9rycYwPfPg/PTSp4QuSkk0vOtIYZ0sGO7Zr/oqRQEn3Q
	 bZTC+xvpq4ZzHyydtCd2+MUht7VjSMVAc+QW6ZPVxfiAMzISs3v9vRyYsu+gqogzM9
	 HTOpqo1f7t7P4IpAfgrmShg7Yu9telb/BuewQOoAVz62LWjeBpYBAlToNuiqrKvZSi
	 OO2A9iQpLezyTGvSBIIeI/aI3LzBW6+Umq+ZCMYqHmmp9Dt2Hg5qaDReScqKNzXi7c
	 tDihS0qt4RtdA==
Date: Tue, 6 Jun 2023 10:27:14 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>,
	Josef Bacik <josef@toxicpanda.com>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Phillip Potter <phil@philpotter.co.uk>, Coly Li <colyli@suse.de>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
	linux-block@vger.kernel.org, linux-um@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: decouple block open flags from fmode_t
Message-ID: <20230606-raumtemperatur-languste-045c5472f6a0@brauner>
References: <20230606073950.225178-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230606073950.225178-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230606_012725_507418_539F0597 
X-CRM114-Status: GOOD (  12.15  )
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

On Tue, Jun 06, 2023 at 09:39:19AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series adds a new blk_mode_t for block open flags instead of abusing

Trying to look at this series applied but doesn't apply cleanly for
anything v6.4-rc* related. What tree is this on?

