Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C7BCEE322
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Oct 2024 15:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SIb6hkbSWsP1vI5hhqM6vtQwcLZCjg36srSuc2OI+TE=; b=oXhNRPdNNpbW9Mp1YpLymYw1HI
	gh99pmXypSyE6mYU5MVJVSNefyv3y60FrkFIuaBocf9M/9Lfa54Whro8hN06MyJ8z4diux5+1Q5Va
	Ai7oPEZxFBqDhPS5JF/lzdCmkGzKqkBaq5w9O79IQkbrb3DAGImBUlSpesQusUYD+2aNYs9XqmwlU
	dHBkybwP+Lftz4eJ73tDOktJ+GgkdplKmjxoE6A5lbFsXxh7k+eedYF5fRs5mPvwtOUR4xf9B07rR
	rXvxxSPlRWVudlEGi8bsHCXjk+/pyaNT0EyPxeUyuBxepqW4F19iF4wltGMaDUPWGYeuL7MW2BhJ8
	WBVLyWxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syYnC-00000009mXh-0YzN;
	Wed, 09 Oct 2024 15:40:02 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syYn8-00000009mWP-3nQm
	for linux-nvme@lists.infradead.org;
	Wed, 09 Oct 2024 15:40:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6AA855C5940;
	Wed,  9 Oct 2024 15:39:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB765C4CEC3;
	Wed,  9 Oct 2024 15:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728488397;
	bh=wU/oslILGgn2F02+9wwryHYoFa/vr8Fs/rJ85NNedk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q9V768ykh3aN7rPScVW+4Bs8j6jHHeBrn6xA4l+k6uQPIpyQ2iA550JFNvRzG5YvL
	 L/HXrfJsoZqfAYBzxtrnLm9r0f3nqmjlTy6J0yCU4O0McvZbfe3lnxpS+stNUzArXH
	 hvkkeycnx5TOAqOm0lRTN/JaLNj5AouPWYx+qYGkfzBJOK7u6iPkyX3EwapqgRXn2x
	 pvTTK3DFRHSTx8fjne9RL2cSyUjtQniny+1kj2/3N5nM8kPPJT3nIxRP4PsO1pxbqL
	 UhIkskcnZxWlwPAd8FXHMPajsocgQ7j2NAKrwON0fxevk0ztvTmhiQkZvri5JwqY7Z
	 4v2g/lF81nF4Q==
Date: Wed, 9 Oct 2024 09:39:54 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Matias =?iso-8859-1?Q?Bj=F8rling?= <m@bjorling.me>, dlemoal@kernel.org,
	cassel@kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Matias =?iso-8859-1?Q?Bj=F8rling?= <matias.bjorling@wdc.com>,
	Wang Yugui <wangyugui@e16-tech.com>
Subject: Re: [PATCH 0/2] nvme: add rotational support
Message-ID: <ZwajykF81QLOkObY@kbusch-mbp>
References: <20241008145503.987195-1-m@bjorling.me>
 <20241009074355.GA16181@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241009074355.GA16181@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241009_083959_004951_02D0C3C9 
X-CRM114-Status: GOOD (  14.23  )
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

On Wed, Oct 09, 2024 at 09:43:55AM +0200, Christoph Hellwig wrote:
> On Tue, Oct 08, 2024 at 04:55:01PM +0200, Matias Bjørling wrote:
> > From: Matias Bjørling <matias.bjorling@wdc.com>
> > 
> > Enable support for NVMe devices that identifies as rotational.
> > 
> > Thanks to Keith, Damien, and Niklas for their feedback on the patchset.
> 
> Hmm, the only previous version I've seen was the the RFCs from
> Wang Yugui, last seen in August.

Oops, that slipped by me as well. I think the right thing to do is bring
that one forward and retain the original credit. I agree with Matias
that we ought to be able to query the independent identification without
relying on CRWMS, though.

