Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D96DFCF5386
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Oct 2024 13:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L9CUTgEm1eCgGAYuJ7TIXxA4YJM6rwiSmTkv3Kfjh7I=; b=tKYlltk8OpUtTbeXM9IhUf8/mY
	ZN5R1/3hBw/Dq6jGQb2vkVLYXg6ElJnyxcF+s9nxTncYxFG3eao0ifPqmfiD/hq7g7afcezfXgRtR
	01T78rlPgpg6PcG2106J0GdOLLwFqKTSDYuLI1gzqt973RxwRiVY+LNMUTgN0mVfVFAR4XFgB+jid
	gmdLtnklcOa/0kQ2w9QQZZZhF2TPYT8zeq1wbhri89rCZRL7b27CXED/Y2+Cq+n646JmCvaSL8Pr3
	v9abiWLhOGxn+HaSdihU4vxEQ951lIpKekT3a/pHxrucZCRDYJSL9a/FMeb3K8KNsQypo6TSreDB3
	k2SvDaPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3bBz-0000000EUfu-1CIP;
	Wed, 23 Oct 2024 13:14:27 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3bBv-0000000EUeY-45Pb
	for linux-nvme@lists.infradead.org;
	Wed, 23 Oct 2024 13:14:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id F305FA44E34;
	Wed, 23 Oct 2024 13:14:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3F9C4CEC6;
	Wed, 23 Oct 2024 13:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729689262;
	bh=4sJxGjuKp7KH6wnouPUReXO+2FlJT2wmobWTP5TMFJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e0+tnelyWySB8PSlrcDAHIXEXYHba/DZYH2RGTHOMTHYsIq/DNN1JZdkZdM40JrPs
	 BNGvek65fOb1YhQRFtj+qMsEMZpCz4dL0VycIX5VVuR0aoQT+Kk7+F/TReTDQrkMad
	 ftEj8VJ6p/9tgMDy+7Fz5OS4lNkCH9qWuJp74PIbSyLCyH7VODheeFzoqwHYgMwcc9
	 fMIAYab4CpWU/WZKm9o7vfLfcu31SR6F+4sdWBx+iV/IX03eYOkf/rbctb3f4jzkpq
	 ox8eEH5phYh1SpIzBO5XHuFPA6k2ibVKB1+AKH2/a9wh00coXGj8VQhQp2d3eJU7/7
	 8Xq4ufU5aLc1g==
Date: Wed, 23 Oct 2024 07:14:20 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Tokunori Ikegami <ikegami.t@gmail.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4] nvme: change nvme_ns_has_pi() to
 nvme_ns_supports_pract()
Message-ID: <Zxj2rPzTGILnrUup@kbusch-mbp>
References: <20241023100915.11263-1-ikegami.t@gmail.com>
 <ZxjwAsny4yOUHvUD@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxjwAsny4yOUHvUD@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_061424_097599_8963805C 
X-CRM114-Status: GOOD (  13.82  )
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

On Wed, Oct 23, 2024 at 05:45:54AM -0700, Christoph Hellwig wrote:
> On Wed, Oct 23, 2024 at 07:08:36PM +0900, Tokunori Ikegami wrote:
> > The PI is the first bytes or last bytes of the metadata.
> > So its size is not equal to the metadata size only but below also.
> > Then fix the function to check PI size if metadata size or below.
> 
> So basically what the patch does is to make PRACT work for PI where
> the metadata size is bigger than the PI tuple size, right?  Maybe state
> that clearly and put less emphasis on the mechanics of the change.

You can't just have a patch declare that PRACT works this way. The spec
says it only works if ms == PI tuple size, otherwise it doesn't do
anything.

