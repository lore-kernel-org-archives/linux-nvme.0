Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73513C8303C
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jul 2025 10:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BYv1wR7Zs1GMDNCHMJxl5ewzHP/Szptw36X1RBi5G/M=; b=nz/jBFg9t0c2PI1nebExFsJkVj
	l6qnH58ajGozx2M8x8lqwSv6KawAjWKwEZw6QmNjfGaItcz7ImagyGZ0t+3dam6fZERA0qRUAXD9/
	MjgwIpITkkyE6TinBAMYyxMfx5B6iXPuC0ZFm9LuVByr76OOdtMrYtGqlmU6pgyQ6VySVH0FydYuA
	CSVIrsBH0/uNQY5i+B5leDbUISOEesd2Y3iWQca434vqztULkwidJe0qQ+qo+NSrDgJhQFSio5d8k
	UivCLCYxjgtDVE/Ef5VIH/8BRMYPu0kRjXtFpkdIfyO9bSTuZO7q+kL4umPdjLsVBCxhWVtBq+clc
	ztuMdtKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZ58p-00000004zru-2xzh;
	Tue, 08 Jul 2025 10:01:35 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZ4mF-00000004ubn-0426
	for linux-nvme@lists.infradead.org;
	Tue, 08 Jul 2025 09:38:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 133CD61472;
	Tue,  8 Jul 2025 09:38:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0955C4CEED;
	Tue,  8 Jul 2025 09:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751967493;
	bh=eGSqzBlgJtyGwKfHlLMl/4aUgIxMeyvHHU67qG1cZKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WlBvHc0ePW+GsEM4s1HqYb1AXGKJqczxyp/O2dKo1T/q2DmqKJZFIeRBt0AfAflno
	 2Ss/Lpdz9s5AbKV7rQCbnJt3ZptOohf1Kbz+QKx7I3XG26kvWf54tefTETCWpUYqie
	 XBLZIdfv4g/n++W5I8rp2ssAZ8gyODMLIKVCzj1doomadtkLJQgS3a1j4eCCcv9JuI
	 Vew3hLnWrSGi4/tggZp914KVc9j85wgcr/rrmkKIejOxnjf/6vs8X7ysSeEHFoPYYG
	 vNpaOGXL9pTJCTeBtFSN2tw/tetr+cxugLfMAox4ODMyhpLkI9UXC3YaakO7sesE47
	 nH/3KrDk1Z4xQ==
Date: Tue, 8 Jul 2025 11:38:09 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Alan Adamson <alan.adamson@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	Keith Busch <kbusch@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: What should we do about the nvme atomics mess?
Message-ID: <aGznAUVxSl5_Xa3E@ryzen>
References: <20250707141834.GA30198@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707141834.GA30198@lst.de>
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

On Mon, Jul 07, 2025 at 04:18:34PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> I'm a bit lost on what to do about the sad state of NVMe atomic writes.
> 
> As a short reminder the main issues are:
> 
>  1) there is no flag on a command to request atomic (aka non-torn)
>     behavior, instead writes adhering to the atomicy requirements will
>     never be torn, and writes not adhering them can be torn any time.
>     This differs from SCSI where atomic writes have to be be explicitly
>     requested and fail when they can't be satisfied
>  2) the original way to indicate the main atomicy limit is the AWUPF
>     field, which is in Identify Controller, but specified in logical
>     blocks which only exist at a namespace layer.  This a) lead to
>     various problems because the limit is a mess when namespace have
>     different logical block sizes, and it b) also causes additional
>     issues because NVMe allows it to be different for different
>     controllers in the same subsystem.
> 
> Commit 8695f060a029 added some sanity checks to deal with issue 2b,
> but we kept running into more issues with it.  Partially because
> the check wasn't quite correct, but also because we've gotten
> reports of controllers that change the AWUPF value when reformatting
> namespaces to deal with issue 2a.
> 
> And I'm a bit lost on what to do here.
> 
> We could:
> 
>  I.	 revert the check and the subsequent fixup.  If you really want
>          to use the nvme atomics you already better pray a lot anyway
> 	 due to issue 1)
>  II.	 limit the check to multi-controller subsystems
>  III.	 don't allow atomics on controllers that only report AWUPF and
>  	 limit support to controllers that support that more sanely
> 	 defined NAWUPF

I like III.

But NVMe should probably push to deprecate AUWPF, and introduce a new field
that is like AUWPF but which is specified in a fixed unit, e.g. bytes or
CAP.MPSMIN. (I'm thinking of e.g. Zone Append Size Limit (ZASL) which is also
a per controller limit, but the value is specified in units of CAP.MPSMIN,
just like the Maximum Data Transfer Size (MDTS).)


Kind regards,
Niklas

