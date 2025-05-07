Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7251DC3ABC0
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 06:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z7fdpT+khwLOs1Slz2YYJE6m0TEmTkBc10XHvd081z8=; b=Hplw5U2uOaD/L1MKdOJ5furF5/
	H12wXYTXqmIEfn/bRBl3z2KYwvpUpeUTWnNReeQzX9kBWYkbfF43Adjp+UAaWQL6s1xLBOjM4DTAX
	0DxSldILy2G6fYjdpIplRbnMzXygx4Kc/njzSgC5z5ZzHQYXavkXnyOuZMgCSxpGrxNMnC77CP+xu
	Dyxl3Xk41reODWqvip1FIQG4XUoIPczgUwruWMO/DbHTqdfg85mNj/6yl3NuEbMHJSKPjaHis5vJF
	Rg2e1ZNa13Pozqg34tb/Q4A8jFXqNIUTvERPirmL3V7pkuF0l5Pe2xKYhtMeepNaqyR0YLcrX4+jf
	YojDWKGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCYd6-0000000EQIE-1lSX;
	Wed, 07 May 2025 06:51:44 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCYYR-0000000EPjR-0ihk
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 06:46:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8014E68BEB; Wed,  7 May 2025 08:46:46 +0200 (CEST)
Date: Wed, 7 May 2025 08:46:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: alan.adamson@oracle.com
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	kch@nvidia.com, kbusch@kernel.org, sagi@grimberg.me
Subject: Re: [PATCH 2/2] nvme: all namespaces in a subsystem must adhere to
 a common atomic write size
Message-ID: <20250507064646.GA31415@lst.de>
References: <20250430171830.1494033-1-alan.adamson@oracle.com> <20250430171830.1494033-3-alan.adamson@oracle.com> <20250502065239.GA8227@lst.de> <e8a55150-54fd-4519-977c-2468aa573137@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8a55150-54fd-4519-977c-2468aa573137@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_234655_358535_9FF8E6F9 
X-CRM114-Status: GOOD (  19.05  )
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

On Tue, May 06, 2025 at 08:57:35AM -0700, alan.adamson@oracle.com wrote:
>
> On 5/1/25 11:52 PM, Christoph Hellwig wrote:
>> On Wed, Apr 30, 2025 at 10:18:30AM -0700, Alan Adamson wrote:
>>> The first namespace that is configured in a subsystem will define the
>>> subsystem's atomic write size.  This will be based on either AWUPF or
>>> NAWUPF. Configuring subsequent namespaces in the subsystem requires its
>>> atomic write size as defined by its AWUPF or NAWUPF to match the
>>> subsystem's atomic write size. If a namespace doesn't adhere to the
>>> subsystem's atomic write size, its atomic queue limits will be based on an
>>> atomic write size of 512 bytes and an error message will be logged.
>
> Along with the error message, we are setting atomic_write_max_bytes to 512b 
> which will at least allow the device to still be used.

But that means you change the limit when later adding a new path for
a namespace, and file systems do not expect it to change underneath
them.  This is especially fatal because nvme will not even fail
writes not fitting into the atomic boundary.

So we can't do anything but reject adding the new controller if the
limit is smaller than the existing limit.


