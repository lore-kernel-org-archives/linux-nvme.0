Return-Path: <SRS0=tyWw=HF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D91CC433DB
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 19:34:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D440264DDC
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 19:34:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D440264DDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Z+7ABd+D1bXCC8WZzoEoV2BbHPLr3uDvlzJKVszdb8Y=; b=JdcCP9pJsEuX2Z5TODeOpVck4
	fVQ2yrHYcgloXJ+WUfMx+xk8JvjRHSs4p/UKz/fpqVUPNqv3UEM5mSpAPRBalBSlEj2hPmBVjWAAd
	liZ4cMK6rmj2muSdIC6BG3Ab3zu+H85qKIHRgHbrMIzPjspOyJdYTRsOU0m95D+exk1JhBnYwfc7R
	ssgBhQR0/vXfGvt88ay4aEEDzq0o7FZ3N3dxphgqawVa8JLkK/cc2KQZ20r1R2Bl2e5b/jeXdoNyC
	4+BI7AzldAbXJlymMA9BpWOfIUYBSZJ3NS8eH6t89+Wmzrn6ReNDBLNkIJp4nO20iMPGx3wFXg8qi
	Oka7UdrqA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7NvD-0002XD-15; Wed, 03 Feb 2021 19:34:39 +0000
Received: from mga04.intel.com ([192.55.52.120])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7Nv9-0002Wp-UV
 for linux-nvme@lists.infradead.org; Wed, 03 Feb 2021 19:34:37 +0000
IronPort-SDR: cD+7er12WAzxDj1/Te8HX0CFiEUG9F8aYkgsxnfWvtaQMNIssQz10benWINpR00Uhgh6oOVrvx
 ilGbE/xCXXDQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="178543029"
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; d="scan'208";a="178543029"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2021 11:34:34 -0800
IronPort-SDR: KMYc5m6y1qew0epiy/aL3Gs0A0RnOPmZyGoUSc1qC0R7zLd9n01mIKjMMtvfqPTxjhuY/a8TX/
 wGgGG9RN5nvg==
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; d="scan'208";a="371603427"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2021 11:34:34 -0800
Date: Wed, 3 Feb 2021 11:34:34 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 net-next 01/21] iov_iter: Introduce new procedures for
 copy to iter/pages
Message-ID: <20210203193434.GD3200985@iweiny-DESK2.sc.intel.com>
References: <20210201100509.27351-1-borisp@mellanox.com>
 <20210201100509.27351-2-borisp@mellanox.com>
 <20210201173548.GA12960@lst.de>
 <CAJ3xEMjLKoQe_OB_L+w2wwUGck74Gm6=GPA=CK73QpeFbXr7Bw@mail.gmail.com>
 <20210203165621.GB6691@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210203165621.GB6691@lst.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210203_143436_128432_B2617456 
X-CRM114-Status: GOOD (  20.81  )
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
Cc: smalin@marvell.com, David Ahern <dsahern@gmail.com>,
 Sagi Grimberg <sagi@grimberg.me>, yorayz@nvidia.com, boris.pismenny@gmail.com,
 Ben Ben-Ishay <benishay@mellanox.com>, Yoray Zack <yorayz@mellanox.com>,
 linux-nvme@lists.infradead.org, David Miller <davem@davemloft.net>,
 axboe@fb.com, Eric Dumazet <edumazet@google.com>,
 Or Gerlitz <ogerlitz@nvidia.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Linux Netdev List <netdev@vger.kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Or Gerlitz <ogerlitz@mellanox.com>,
 benishay@nvidia.com, Saeed Mahameed <saeedm@nvidia.com>,
 Or Gerlitz <gerlitz.or@gmail.com>, Boris Pismenny <borisp@mellanox.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Feb 03, 2021 at 05:56:21PM +0100, Christoph Hellwig wrote:
> On Tue, Feb 02, 2021 at 08:00:51PM +0200, Or Gerlitz wrote:
> > will look into this, any idea for a more suitable location?
> 
> Maybe just a new file under lib/ for now?
> 
> > > Overly long line.  But we're also looking into generic helpers for
> > > this kind of things, not sure if they made it to linux-next in the
> > > meantime, but please check.
> > 
> > This is what I found in linux-next - note sure if you were referring to it
> > 
> > commit 11432a3cc061c39475295be533c3674c4f8a6d0b
> > Author: David Howells <dhowells@redhat.com>
> > 
> >     iov_iter: Add ITER_XARRAY
> 
> No, that's not it.  Ira, what is the status of the memcpy_{to,from}_page
> helpers?

Converting the entire kernel tree in one series has become unwieldy so I've
given up.

But I have a series to convert btrfs which I could release by the end of the
week.  That should be good enough to push the memcpy_*_page() support in.

I'm get it formatted and submitted,
Ira

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
