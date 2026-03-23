Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFFDAF483E3
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2026 18:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ToOogBdsYrd/3/xbqgvjtW++AB1EHK6SLRL9uHr0BgY=; b=hUvjDuCLzRyJVSCCiahRZkgE7W
	QTQBZBOhJQQ2Lg7Y7JP+ZtQNCe/AVHSHcZWCqxw29jwGYUzT4Xtq6FPAGiUHfAxeliyUhzbQJgl6E
	th8Jj1MMbsYi93mEIgR616YKGrsBMjRIlYzY9gcdk36CU08MqK3PREqGm2NrlXNaegJsXxHolD0Ku
	sT98ANwD0BONZ2Hu3SwO+UK12SmsVdzlNawoOhlU1pIe7ygGhxJGSAFJ7BG3f6EsVowL2j+Zejv3Q
	lUZmAwTuMspWKMMindrfTERZMlRxr/WVOCTYIk+GmHiO9NAQ8s3mWM4O9k0nnp6Xe/yjEJXZkZdX9
	u7lKV2PQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4kA2-0000000HM5x-3xrR;
	Mon, 23 Mar 2026 18:37:58 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4kA0-0000000HM4v-2C2R
	for linux-nvme@lists.infradead.org;
	Mon, 23 Mar 2026 18:37:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id CAD9343E45;
	Mon, 23 Mar 2026 18:37:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E849C4CEF7;
	Mon, 23 Mar 2026 18:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774291075;
	bh=9cWlpHllNXUZoJ7LY2GMkPMHETTroz/3ii4+41Mehmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pckru7UaNEpGLmZ0N8YZLOgopPVNZAZYGBqlVQ1uv5M0q6hfEWvcea+fG5cQoVlb9
	 nzYRhMgm/Bi98XcK4NEurlsg8bdU5uWjwz186WBErbITfkVYbS/fNH2G5bkakHBw0X
	 wYdkld2M5umHVbhZmahbhwt7div6zEOTCxZzGGa+M1XHFhAGqAvVoPvaCOlUNIODfG
	 bAa0T1OaDqtKJkVf8btm/taUNj3IW2QfNbuu9Tuirw65LWjnjk5zy9UG6qgM++87LD
	 +ycBs2Kr69wL5QT1e8S7Qsi3KyEgfrhcnvbR23ybW/3GdZ5vNdpiNOgK+NOPmTa5v3
	 DoOhazik86Njg==
Date: Mon, 23 Mar 2026 12:37:53 -0600
From: Keith Busch <kbusch@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/8] nvme: set discard_granularity from NPDG/NPDA
Message-ID: <acGIgY7TzngPJkxs@kbusch-mbp>
References: <20260227202354.1012322-1-csander@purestorage.com>
 <aaXc7oun2IgjJ21F@kbusch-mbp>
 <CADUfDZoRZ9mZC+C9xVaGna=ufr9wzTP-4BNkY2KyEFzpesYRZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZoRZ9mZC+C9xVaGna=ufr9wzTP-4BNkY2KyEFzpesYRZg@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260323_113756_817125_AC83B77D 
X-CRM114-Status: GOOD (  22.88  )
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

On Mon, Mar 23, 2026 at 08:29:25AM -0700, Caleb Sander Mateos wrote:
> On Mon, Mar 2, 2026 at 10:54 AM Keith Busch <kbusch@kernel.org> wrote:
> >
> > On Fri, Feb 27, 2026 at 01:23:45PM -0700, Caleb Sander Mateos wrote:
> > > NVMe block devices always report the logical block size for the
> > > discard_granularity queue limit. However, more accurate values may be
> > > available in the NPDG/NPDA fields of the Identify Namespace structure or
> > > the NPDGL/NPDAL fields of the NVM Command Set Specific Identify
> > > Namespace structure. So use these values to compute discard_granularity.
> > >
> > > Also fix the use of the OPTPERF field to better comply with version 2.1
> > > of the NVMe spec.
> > >
> > > Update the target side to report NPDGL and NPDAL as well, in case the
> > > discard granularity doesn't fit in the 16-bit NPDG and NPDA fields.
> >
> > This series looks good to me. I'll queue it up later this week. I just
> > want to get a pull request for my currently way-behind 7.0 nvme commits,
> > then rebase the tree for new stuff.
> 
> Hi Keith, I see this series in the nvme-7.1 tree, but it looks like
> you might have accidentally applied v4 instead of v5? I don't see a
> few of the changes I made in response to your comments on the last
> revision.

Oh, thanks for the notice! I'll take a look and fix it up.

