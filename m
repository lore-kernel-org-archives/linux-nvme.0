Return-Path: <SRS0=ghx+=G7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01167C433E6
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 08:05:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AA9864DDB
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 08:05:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AA9864DDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Dw97BDl1RzZWKFU4vv6Ccs5uJgL2U9pdn03E3VUdmZ0=; b=tjq9UZV+2AfOXWCEFFOjjrzNn
	Z0hTJzvdkm0ieFBVljEx7U43RDeQyOCUhaqstzfbM43WOz/VUZ+WTMM6Ie4h8jUKLWo1VRPsRfrbb
	wA8INaGecgZkgjZXlOavGvNYHbFsM82oRswf7QXccNBPA5QtnKnIPirV9c/bpiMmSHl4/dTzzspED
	K0Yt8EhIZV/IG7vDoov6omcXGm/HNxGL63YYZ6Bc8zJhbHimq5jiW/NTscNz1o24CBY2wtzNFpxvu
	mLM8cKZMbgq27R0xRGTPEESiLVZ/gqvfX3hPdFUhID5XK6P/KfQbXHwYH4FJ9p66hvDd1/QNGWaAB
	qI4jodb8Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l52IT-0007Lt-LM; Thu, 28 Jan 2021 08:04:57 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l52IS-0007LB-1b
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 08:04:56 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 16D4B64DDA;
 Thu, 28 Jan 2021 08:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1611821094;
 bh=GuLi/8pmF+rCgjPXwttqZpfpUDWjxcO0+aBtX7a6cpk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PJNlFazuzogyHS95uUijQnggfofbJSHp4E1kJjQrb9wi7AOPHtoRGgcFljLsNPOsI
 dAiKEea5u8NcfJs6yeXLXdg4+We5/Nt6h5G8s9pjXEpsTUNn2Mz9zTaovvLzmjt7EE
 JfRf+akhzadrBzz//k88tU5HlhLlEJyPUsxYYbZI=
Date: Thu, 28 Jan 2021 09:04:50 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jianxiong Gao <jxgao@google.com>
Subject: Re: [PATCH 0/3] Adding offset keeping option when mapping data via
 SWIOTLB.*
Message-ID: <YBJwImu3RoQsGhJq@kroah.com>
References: <20210128003829.1892018-1-jxgao@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210128003829.1892018-1-jxgao@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_030456_188957_65D24C12 
X-CRM114-Status: GOOD (  19.84  )
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
Cc: axboe@fb.com, heikki.krogerus@linux.intel.com, sagi@grimberg.me,
 saravanak@google.com, konrad.wilk@oracle.com, marcorr@google.com,
 rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, kbusch@kernel.org, bgolaszewski@baylibre.com,
 iommu@lists.linux-foundation.org, jroedel@suse.de, erdemaktas@google.com,
 dan.j.williams@intel.com, andriy.shevchenko@linux.intel.com,
 robin.murphy@arm.com, hch@lst.de, m.szyprowski@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jan 27, 2021 at 04:38:26PM -0800, Jianxiong Gao wrote:
> NVMe driver and other applications may depend on the data offset
> to operate correctly. Currently when unaligned data is mapped via
> SWIOTLB, the data is mapped as slab aligned with the SWIOTLB. This
> patch adds an option to make sure the mapped data preserves its
> offset of the orginal addrss.
> 
> Without the patch when creating xfs formatted disk on NVMe backends,
> with swiotlb=force in kernel boot option, creates the following error:
> meta-data=/dev/nvme2n1           isize=512    agcount=4, agsize=131072 blks
>          =                       sectsz=512   attr=2, projid32bit=1
>          =                       crc=1        finobt=1, sparse=0, rmapbt=0, refl
> ink=0
> data     =                       bsize=4096   blocks=524288, imaxpct=25
>          =                       sunit=0      swidth=0 blks
> naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
> log      =internal log           bsize=4096   blocks=2560, version=2
>          =                       sectsz=512   sunit=0 blks, lazy-count=1
> realtime =none                   extsz=4096   blocks=0, rtextents=0
> mkfs.xfs: pwrite failed: Input/output error
> 
> Jianxiong Gao (3):
>   Adding page_offset_mask to device_dma_parameters
>   Add swiotlb offset preserving mapping when
>     dma_dma_parameters->page_offset_mask is non zero.
>   Adding device_dma_parameters->offset_preserve_mask to NVMe driver.


Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
