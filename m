Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F137EC83F0F
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jul 2025 10:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZgEn8AnLgdDvzESVy78J2eP8KOP6/Ai/nlT2IPLQ268=; b=yMOjGVF+SM7pQ02XiSqYrKCfGJ
	pum7gLGAHqfqRaFYtl7eLRLu5CZ9R7QkQVGgBTT4CLxV8Keei45VHQyYC+B90Lunneex71+isDdXz
	5uu4U9e51zTrTyU2aZJb+73nBa6HIC09YNTjzAZe0bXVWI/bEqh5ASdbJvWdg8G5XuqdK3YAWcv3S
	UkAPk6shczrtjiZxf2fvH/ZE/EVdYdyEfkyJSjs1rNcWEHqqtvq/t7+XDsfFFSi3cwVy9GMddwOTI
	gPuA3Ld+FLTsK2kVmC592+U2fsQeiQdRQHv7iIlEhvvmtL9S/AMXyc9oFwwvpez0RXQWGrGuZRqEw
	AVBrnZWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZ5Fh-000000051N7-2yxK;
	Tue, 08 Jul 2025 10:08:41 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZ4vk-00000004viO-206I
	for linux-nvme@lists.infradead.org;
	Tue, 08 Jul 2025 09:48:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 46FE868C4E; Tue,  8 Jul 2025 11:47:49 +0200 (CEST)
Date: Tue, 8 Jul 2025 11:47:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
	Alan Adamson <alan.adamson@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: What should we do about the nvme atomics mess?
Message-ID: <20250708094748.GB27634@lst.de>
References: <20250707141834.GA30198@lst.de> <aGvYnMciN_IZC65Z@kbusch-mbp> <b2ff30b5-5f12-4276-876d-81a8b2f180c1@suse.de> <aGvuRS8VmC0JXAR3@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGvuRS8VmC0JXAR3@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250708_024804_657965_B337BF84 
X-CRM114-Status: GOOD (  17.24  )
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

On Mon, Jul 07, 2025 at 09:56:53AM -0600, Keith Busch wrote:
> I think the NVMe TWG might want to consider an ECN to deprecate or at
> least recommend against AUWPF, too.

Yeah.  A wording that every controller SHOULD implement NAWUPF if it
implements AWUPF might be good, eventually upgraded to a SHALL.

> Just to throw AWUPF a lifeline for legecy devices, we could potentially
> make sense of the value if Identify Controller says:
> 
>   1. CMIC == 0; and
>   2. OACS.NMS == 0; and

What is NMS meant to say?  namespace management support?

>   3.
>     a. FNA.FNS == 1; or
>     b. NN == 1
> 
> And if those conditions are true, then the controller and namespace
> scopes resolve to a single namespace format, so the values should be one
> in the same. The only way it could change, then, is a format command,
> which means there couldn't be an in-use filesystem depending on it not
> changing.

We could.  But are there many controllers where that would be the
case and where people want to use atomics?

