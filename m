Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F4DCFD2F6
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Nov 2025 07:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mg+PdZwdO0sia44+fBnEmBbsN7z3KLsWp8ZG90Kr2co=; b=22DgiE7TeKE40ZlVRSdON5UnKd
	24UyseNYGlOxGZQOKa3NFVQPWz9UjPjUH05R4xMsPGsMevhZL8+8tQtwcCAKHqseZzbLF8cKvwvif
	1T/SrM6CLRZHdI95GRAymfGTne8Q9peZzhkgC4HCV0UrpLn7YIumxpQmlXE0YWPHpnUtg9cuN/lxl
	YEdv9ptbNdhAbJ8P8LHx2atH5pUapJ28C1nU/sO+IZGUfnS88v0j+omDIWkDSRsBvLKA+X3eOIbMs
	FZbgmG6LpxEjthN0yI1o8CJCMkpm+cJn3EaDF4FGX0E/l/bV4i+k5DsQLr9AgpMdMIxZDgTKlOdsW
	CfQL1Vnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOWCv-0000000G6cD-0q41;
	Thu, 27 Nov 2025 07:14:25 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOWCt-0000000G6bt-2k36;
	Thu, 27 Nov 2025 07:14:23 +0000
Date: Wed, 26 Nov 2025 23:14:23 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Stephen Zhang <starzhangzsd@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Ming Lei <ming.lei@redhat.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev, virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org, gfs2@lists.linux.dev,
	ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org,
	zhangshida@kylinos.cn
Subject: Re: Fix potential data loss and corruption due to Incorrect BIO
 Chain Handling
Message-ID: <aSf6T6z6f2YqQRPH@infradead.org>
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
 <aSBA4xc9WgxkVIUh@infradead.org>
 <CANubcdVjXbKc88G6gzHAoJCwwxxHUYTzexqH+GaWAhEVrwr6Dg@mail.gmail.com>
 <aSP5svsQfFe8x8Fb@infradead.org>
 <CANubcdVgeov2fhcgDLwOmqW1BNDmD392havRRQ7Jz5P26+8HrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANubcdVgeov2fhcgDLwOmqW1BNDmD392havRRQ7Jz5P26+8HrQ@mail.gmail.com>
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

On Thu, Nov 27, 2025 at 03:05:29PM +0800, Stephen Zhang wrote:
> No, they are not using bcache.

Then please figure out how bio_chain_endio even gets called in this
setup.  I think for mainline the approach should be to fix bcache
and eorfs to not call into ->bi_end_io and add a BUG_ON() to
bio_chain_endio to ensure no new callers appear.  I

> If there are no further objections or other insights regarding this issue,
> I will proceed with creating a v2 of this series.

Not sure how that is helpful.  You have a problem on a kernel from stone
age, can't explain what actually happens and propose something that is
mostly a no-op in mainline, with the callers that could even reach the
area being clear API misuse.


