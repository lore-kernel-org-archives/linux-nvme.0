Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D40DC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 19 May 2022 07:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aW2t7yTek+58ic9bYfqDmwss0RouRMYLFnp8ZF7DOcE=; b=bldEncRLn1HscFnweh86linurP
	dd9pHtkzqURv2mFCwzJ07t2jTSUD6dHsHhTu6MNWgB13W5zDTx1j6GMJpJeGGNgL544gD5zR8D+ie
	dulL9ws22+xdZp1pq1I4hn82jZXBqdDvy9Hf9jSrdMjcCTL/y9i3jTY/4zF+iOLQUloj8wUgLqDCI
	w0gIh3wlA1BixCLz1RhoQOuDqDBk1JXYOZg6O5SabBdkXyMXx4d6UjW9JxnPsFMKtnq1CFmJmzLsX
	7go5EuQjRhcExeObXZh/B4hEy82PJbqhGv7+YwVMkVcVktKg4+M6/f84D6VIDPF3xn8yq0oB1QpkA
	IgyIYIjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nraI2-005ROv-DU; Thu, 19 May 2022 07:09:42 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nraHp-005RIk-Bb
 for linux-nvme@lists.infradead.org; Thu, 19 May 2022 07:09:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 00AED68AFE; Thu, 19 May 2022 09:09:21 +0200 (CEST)
Date: Thu, 19 May 2022 09:09:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Subject: Re: cleanup blk_execute_rq*
Message-ID: <20220519070921.GA22301@lst.de>
References: <20220517064901.3059255-1-hch@lst.de>
 <28682d9a-ac58-ea19-6d51-73fbd87bfb5e@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28682d9a-ac58-ea19-6d51-73fbd87bfb5e@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220519_000929_577882_6EAC8DEB 
X-CRM114-Status: GOOD (  14.83  )
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

On Wed, May 18, 2022 at 04:40:55PM -0600, Jens Axboe wrote:
> On 5/17/22 12:48 AM, Christoph Hellwig wrote:
> > Hi Jens,
> > 
> > this series cleans up the blk_execute_rq* helpers.  It simplifies the
> > plugging mess a bit, fixes the sparse __bitwise warnings and simplifies
> > the blk_execute_rq_nowait API a bit.
> 
> Looks good to me, but let's do this series post flushing out the
> initial bits. It ends up depending on the passthrough changes,
> yet also conflicts with the nvme changes on the driver side.

Ok.  I'll resend after the initial merged, the buildbot also complained
about a UFS hunk.

