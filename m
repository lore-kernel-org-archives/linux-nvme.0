Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06CD7C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Feb 2022 16:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q/peAGBWtsQBU0632/2ZHPNzyLKa2P7sBW0VQL5RzMU=; b=A5VSWWslPyhbzvGHk4FTygbWh9
	TLQr2hY0+L7vHzxaqTvFnj6PxqwhQoySCGuRLtnDSyStq2IEw5ppnyyxbY+hIv2X4ICfGwVAcG3cC
	nlWHTBlyMZ47JW4h4rGUzht6Kz75gnfhZkX6uGRWlEJxvn97Dxl/2UFWkeJFS+x3pysCqneCAVtiR
	kvHZ1jmZdDZU1djVGs0sD9qTujlDUnBT+xLqgMI4X8C8NeZdInnysFn75LwUqGqSCf0MNrKaA8fFp
	F/AttHf0+H1inXzchStDIqvXBKVnYWYEUdaPQ7MyfuB3R97U7FdXN3sRVGxth2E5OF/pFP8h8yH+v
	jitrkN/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nNdDR-005qVe-GF; Fri, 25 Feb 2022 16:13:09 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nNdDO-005qTc-8K
 for linux-nvme@lists.infradead.org; Fri, 25 Feb 2022 16:13:07 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 20361B83258;
 Fri, 25 Feb 2022 16:13:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C090C340E7;
 Fri, 25 Feb 2022 16:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645805581;
 bh=jt01kIc8j089u4k2Qkwdo2wyv3o+TW0lyH1J9zmLffY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mtsCG6GWUXJc3Bz0PD+LGadcwO49hYXB9NxWwK58IRveizIGJHxPcl/nCtE9xDB3O
 zzUF3KVgw5qJhG4u3RaGtW1rOebnEJo6nyfO4ed9pMr7IOgujwZHqRdb3l0LUa/xdO
 1Y22GWteHEf5kfOz4bfoty8L1/jT2nsSMVVEZgU4JaYe+JomrfvrT1ZQrhgVAKMVV5
 BVRB70E5ynby6zEgleP5g85w3DsopvUV962TRS6mDzIigOUNH4OG1iCuAMShznJIwI
 4JwDzSI3XRPpKfQam2qHoRSf2yNBadLgfV9TRLtWmArvp+5yE6ZBEl6B+BOA5Kaotm
 8TpOo2S0DJneQ==
Date: Fri, 25 Feb 2022 08:12:59 -0800
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-crypto@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, axboe@kernel.dk,
 martin.petersen@oracle.com, colyli@suse.de
Subject: Re: [PATCHv3 07/10] lib: add crc64 tests
Message-ID: <20220225161259.GA4111669@dhcp-10-100-145-180.wdc.com>
References: <20220222163144.1782447-1-kbusch@kernel.org>
 <20220222163144.1782447-8-kbusch@kernel.org>
 <20220225160509.GE13610@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225160509.GE13610@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220225_081306_482171_1BC20BA3 
X-CRM114-Status: GOOD (  18.21  )
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

On Fri, Feb 25, 2022 at 05:05:09PM +0100, Christoph Hellwig wrote:
> On Tue, Feb 22, 2022 at 08:31:41AM -0800, Keith Busch wrote:
> > Provide a module to test the rocksoft crc64 calculations with well known
> > inputs and exepected values. Check the generic table implementation and
> > whatever module is registered from the crypto library, and compare their
> > speeds.
> 
> The code looks good, but isn't the trent to use the kunit framework
> for these kinds of tests these days?

I don't have experience with kunit, but I'll look into that.

I am already changing the way this gets tested. Eric recommended adding
to the crypto "testmgr", and I've done that on my private tree. That
test framework exercises a lot more than this this patch, and it did
reveal a problem with how I've implemented the initial XOR when the
buffer is split, so I have some minor updates coming soon.

