Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E140C28B30
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Mar 2025 03:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qfYiyKdftASUDZaG/tQuefxHwRQD8kKwrRp8XkLToRM=; b=Cgd15hgL8xtzAF9/sVB7ObzeiP
	rxq4qjzaAOCvM8JIDeHHd5XDKcdzOI8G5BvDgVLVs51dyDjkJZjJUyf8mhTvKgU252SlwJvIjwG//
	G+K0bejDfPm444e+Irfj+5oqnwErGFbJ4623q4ARD2kyB003xW/fKItvMs1n5Hdk/3GmlgjlVcgQL
	IASho4QbsMfs7ED9WEpTSmZBao6muAWX8zuGN2s1li3LW56bt82c5zh7MaWfZuE9r3bqNdNtgx71+
	6uZTuFnfhIRrBTOmoKFmwHgNGzcsb2Gf6G7Sea6Hjoof3u2ITboaTBTqYJl4KsuJ8OgYcL5rpJv0c
	nY0mSRRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txHk5-00000007Uzj-19yV;
	Wed, 26 Mar 2025 03:47:49 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txHk3-00000007UzL-0X48
	for linux-nvme@lists.infradead.org;
	Wed, 26 Mar 2025 03:47:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E4B6E43A86;
	Wed, 26 Mar 2025 03:47:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433C9C4CEE2;
	Wed, 26 Mar 2025 03:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742960866;
	bh=bYXS2SsX/Qi2gSv2wWb1FHs98/UR/lhfVEIgUK70Scw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nbZmNViNSaeDldYLoMtg6puSuGB8XRZJuZOaotC6DrFrEcGt8+NgPrqr7L57ALNIh
	 siTD5bPIdv3l/wPCfUQ//c/DW4Xl3lnAU793oMQV0TpPfeT8TM//QBmuJCVRUWA246
	 KxjFrrOydPctMiqAJyKUtMC+U4BzyQAGqqZFVsaIRG7I9+eE905tR1O0a+d3oWJAGh
	 306sAM2cm94t+6+x5S8yCHrvZALSWQ1sCpCBOHAwolLsY8RzZolfWWMdYWBR+cxYuU
	 Q0AD9+cT0nGqZNzV+4au+QGwXE19tkcQS5s6O+ZkDx2I9iCdBH81TMiwuB3kp/XCD6
	 d7nk7XuoWRMRQ==
Date: Tue, 25 Mar 2025 23:47:43 -0400
From: Keith Busch <kbusch@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Xinyu Zhang <xizhang@purestorage.com>,
	linux-nvme@lists.infradead.org, io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] nvme_map_user_request() cleanup
Message-ID: <Z-N439fyHEyweXq0@kbusch-mbp>
References: <20250324200540.910962-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324200540.910962-1-csander@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250325_204747_188020_6906BA48 
X-CRM114-Status: GOOD (  15.29  )
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

On Mon, Mar 24, 2025 at 02:05:37PM -0600, Caleb Sander Mateos wrote:
> The first commit removes a WARN_ON_ONCE() checking userspace values.
> The last 2 move code out of nvme_map_user_request() that belongs better
> in its callers, and move the fixed buffer import before going async.
> As discussed in [1], this allows an NVMe passthru operation submitted at
> the same time as a ublk zero-copy buffer unregister operation to succeed
> even if the initial issue goes async. This can improve performance of
> userspace applications submitting the operations together like this with
> a slow fallback path on failure. This is an alternate approach to [2],
> which moved the fixed buffer import to the io_uring layer.
> 
> There will likely be conflicts with the parameter cleanup series Keith
> posted last month in [3].
> 
> The series is based on block/for-6.15/io_uring, with commit 00817f0f1c45
> ("nvme-ioctl: fix leaked requests on mapping error") cherry-picked.

Thanks, I've queued these up internally for 6.15; the next nvme pull
request will need to rebase once the upstream branches sync with the
existing outstanding pulls, so this series will be included in the next
one for this merge window after that happens.

