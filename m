Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72CB3C88E72
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2026 15:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qcoSAwE9zefKlbQiWsh/nwew0C3OkmsRFs6wDdVfjvU=; b=oyTltdBkQK318zK8tPnlXtuKHL
	S5ZhaUz84Ttsnm0hw/cyX/hqgbqq1xZsQW6MMkOZZ1aDvfjQhARKujL2K7fmLXLYJrhcp0cxI4gut
	xjEYDfY4qe6+z/WWfNf33/mUekAvbPjbWp2hv1XW2jExZy4AdB/9LAzS3eeG0DZikZHIqwpYY9W3W
	aflx0k4L135Z3KX4cTHa5TuI3SrcSS8LqHeh+3jKe7eS5cPi0hLm3AldD/HRDWWfkJTgpJHiSThtB
	NrQGIQyWe8WFaIOiRjkVXaKe+e7uE1RIEThq39Oi44t1Sr7IFGWaEM11NrmyLS19rsY9Sb4CELQnn
	jTsohyBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x68F8-0000000466N-0k86;
	Mon, 14 Sep 2026 15:05:14 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x68F6-0000000465v-3f1I
	for linux-nvme@lists.infradead.org;
	Mon, 14 Sep 2026 15:05:12 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1F0BE6025A;
	Mon, 14 Sep 2026 15:05:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 518E91F000FF;
	Mon, 14 Sep 2026 15:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789398311;
	bh=qcoSAwE9zefKlbQiWsh/nwew0C3OkmsRFs6wDdVfjvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S86Noa06ouwos4TBtj15zmuRA5laUT2AJAn+K3K4el3eYSXbnj7QCCdMNpozzy/SA
	 y/zFBcw/BM2ufdl8rSEqunXa7MVRNQg/L5BqSgrFyIm7eP9QIglIYuvQh43U+diSDf
	 Q0CwHlKjL7iiMvMaYK6i7F62JuckGan7wK8BmPKsixf5zzwaRL27ZLcTWnUczyAnnf
	 W7FG9LeHvlJZrZtnyHt4we7KVTuPYS/KcCddyuup3MdsGC6IQ5DkKHetyqmIUPGyzk
	 N1c7vEkXO2CZAVBczpYYID3JIEdUExuyvC2eu40j9FqppQipPVdFPWUa+niEU0IbG6
	 dmL3RDQsmBSRQ==
Date: Mon, 14 Sep 2026 09:05:09 -0600
From: Keith Busch <kbusch@kernel.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@opensource.wdc.com>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Eric Dumazet <edumazet@google.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH 0/2] nvme-tcp: do not use dynamic lockdep key for socket
 instances
Message-ID: <aqgNJdeLZlPlWk1F@kbusch-mbp>
References: <20260914074853.3990397-1-shinichiro.kawasaki@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914074853.3990397-1-shinichiro.kawasaki@opensource.wdc.com>
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

On Mon, Sep 14, 2026 at 04:48:51PM +0900, Shin'ichiro Kawasaki wrote:
> From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> 
> Keith and the maintainers, please consider this series for upstream.
> The commit 19bdb70c77d3 tried to avoid a lockdep WARN issue, but it
> was imperfect. With Eric's help, I propose this series as a better
> solution.

Thanks, applied to nvme-7.3.

