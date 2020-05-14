Return-Path: <SRS0=zrHs=64=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95EF4C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 03:40:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C1B9206BE
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 03:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t62O+ppp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gq7FU1Uy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C1B9206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=X8mGj4WKkvRSBqk2O7HZiILmyYrDDzl8Xp7BTqqwqDs=; b=t62O+pppn0ne7c
	yWLfseY0cg5J23fEPtjX3SJd8Odgb7lO9/JKwarl8EmxYXwfwCQm7OrcgYXD+cW3J4TtNQIqq+nai
	Y0lfDTO0SGspqbVM4JltAbduxEKAA8xphMNYLDUj6Dn/s3M6NDwP56sOX1zNCPKoiZbjyW2oau4NW
	Z8mWX90JwYwVoMk4VFNVKeSTu5wovb+OfsSCVBFAOGz65+KtZlbX/vEwsCXkyxsvCEmw2GxuVY0sO
	fZLUm4rLsCeOi0JFf6xMbmIXmLA6m8W6ChFQ9OW96nFp23RpY78NNWtIaxqgXgew8O71Qkr9ZxqAk
	9B3YExzStnVA8Q+Xcs1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jZ4jl-0001Yn-W1; Thu, 14 May 2020 03:40:45 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jZ4jk-0001Y6-0Y
 for linux-nvme@lists.infradead.org; Thu, 14 May 2020 03:40:45 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 74650206BE;
 Thu, 14 May 2020 03:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589427640;
 bh=jtC8xve7kToz69NkCwP2e5hx3uLsfMlMo9DWGsQOp/A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Gq7FU1UyQ+ga8KTEbnoK/WvRGFNtUVkn948hy7hZ2Ap4Q9uyXbF8OKlkAnoZV2qjk
 0e+NjuI25q70UmPzjPgILo0oKduogJVjN6pEUhdJ8if1xqiYXZjRnZWK7sdoOkX+eO
 jhjTKEgXPOPgUKkXNEgZodbtHO8VlCdXznYwyIlw=
Date: Thu, 14 May 2020 12:40:33 +0900
From: Keith Busch <kbusch@kernel.org>
To: Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH] nvme: Fix io_opt limit setting
Message-ID: <20200514034033.GB1833@redsun51.ssa.fujisawa.hgst.com>
References: <20200514015452.1055278-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200514015452.1055278-1-damien.lemoal@wdc.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200513_204044_073664_54D7C2AE 
X-CRM114-Status: GOOD (  13.36  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, May 14, 2020 at 10:54:52AM +0900, Damien Le Moal wrote:
> Currently, a namespace io_opt queue limit is set by default to the
> physical sector size of the namespace and to the the write optimal
> size (NOWS) when the namespace reports this value. This causes problems
> with block limits stacking in blk_stack_limits() when a namespace block
> device is combined with an HDD which generally do not report any optimal
> transfer size (io_opt limit is 0). The code:
> 
> /* Optimal I/O a multiple of the physical block size? */
> if (t->io_opt & (t->physical_block_size - 1)) {
> 	t->io_opt = 0;
> 	t->misaligned = 1;
> 	ret = -1;
> }
> 
> results in blk_stack_limits() to return an error when the combined
> devices have different but compatible physical sector sizes (e.g. 512B
> sector SSD with 4KB sector disks).
> 
> Fix this by not setting the optiomal IO size limit if the namespace does
> not report an optimal write size value.

Won't this continue to break if a controller does report NOWS that's not
a multiple of the physical block size of the device it's stacking with?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
