Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A589DC5AD7B
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2026 00:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YXDPeV0frzKO1XCETmGtDDKJhEwmiS95+OxrQDY2p/o=; b=AanXKgS8QIJ8HP8Jb5O8ywILrC
	H/sTP3ePpgtmRD7JXrVThadwORZc6ft2ABVygl164JnGsFKT3hDpTsDErTNPlutqpI+qAFL7YbOvq
	Nhqxp6TeFFTuxwHu5TqYA5H8q9BmqJLz/m0+dz6MtcvArGEqRVXFaKE+hD1OTCEFetB0yzrhzkEqA
	GhrErMf3mFWHmu62J/odlLFQ6u3Zbqbi/8PdBRRKEs/UFCNH6bqk2Uj0d4YE+MExrELClDE/Ws734
	R2vOlnliEiUAzdvEm6iLTIPbCTPXj6mwo3x6vvcm9hOc0qydkIa1Jb8j2x9ZRp9+wsMapCa/ePIZz
	dreX2Bbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtamS-0000000D5t9-434N;
	Tue, 11 Aug 2026 00:55:48 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtamQ-0000000D5t3-48IA
	for linux-nvme@lists.infradead.org;
	Tue, 11 Aug 2026 00:55:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D7098600AA;
	Tue, 11 Aug 2026 00:55:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE071F000E9;
	Tue, 11 Aug 2026 00:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786409745;
	bh=YXDPeV0frzKO1XCETmGtDDKJhEwmiS95+OxrQDY2p/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h976ZzrArYIP/kUdX6Ae/iQclmMCtoZe2sp9rmhfqBiHqJnvhrj5jazg7mSagtQkk
	 Z8g3esSrZLX7LR461IfdwO1fU8M3G29hcTU8i3GOYN2oqmq0qYuTdn9IoPWsp5y6OU
	 q1+JR1GQJwREi1lNUH0oz5B6055YVdODXmHJo9jjXFWyB7EcqFK4vV0HLng3cYwltg
	 896GO6dFXHfcvXhORgs2XCwOtLbe1cbmKIInlFZvwz2Nu2IDviDuYrV61cTJQhWgTR
	 5B/Rkc4ejsDKjEd9ac/r7ZUW1cjXXC5+4wbF/X4bSU/uJzjw9IjzLHdTW/O3xfhqF+
	 D22gHZs3RJ+ZA==
Date: Mon, 10 Aug 2026 18:55:43 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: John Garry <john.garry@linux.dev>, Christoph Hellwig <hch@lst.de>,
	sagi@grimberg.me, axboe@fb.com, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH RFC] nvme-multipath: fix diskstats for partitions
Message-ID: <anpzD5PaOn-_K5hn@kbusch-mbp>
References: <20260721114553.1657841-1-john.g.garry@oracle.com>
 <20260724050152.GA3680@lst.de>
 <987782a9-e12a-4098-b438-a54a5765c2ae@oracle.com>
 <amNegPEvRX99EvPN@kbusch-mbp>
 <f76e9466-4b66-4a32-a491-728e24d34052@linux.dev>
 <amOGxr3rxvDflHLv@kbusch-mbp>
 <94ed42ce-895d-4197-994b-60fc1d3f040c@linux.dev>
 <d3058b64-e162-4bfc-990d-13ff5f03143a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3058b64-e162-4bfc-990d-13ff5f03143a@oracle.com>
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

On Thu, Jul 30, 2026 at 01:52:00PM +0100, John Garry wrote:
> 
> With that, /sys/class/block/ looks a bit different (with the per-path
> partitions):
> 
> #ls -l /sys/class/block/ | grep nvme0
> lrwxrwxrwx    1 root     root             0 Jul 30 12:39 nvme0c0n1 ->
> ../../devices/virtual/nvme-fabrics/ctl/nvme0/nvme0c0n1
> lrwxrwxrwx    1 root     root             0 Jul 30 12:39 nvme0c0n1p1
> -> ../../devices/virtual/nvme-fabrics/ctl/nvme0/nvme0c0n1/nvme0c0n1p1
> lrwxrwxrwx    1 root     root             0 Jul 30 12:39 nvme0c1n1 ->
> ../../devices/virtual/nvme-fabrics/ctl/nvme1/nvme0c1n1
> lrwxrwxrwx    1 root     root             0 Jul 30 12:39 nvme0c1n1p1
> -> ../../devices/virtual/nvme-fabrics/ctl/nvme1/nvme0c1n1/nvme0c1n1p1
> lrwxrwxrwx    1 root     root             0 Jul 30 12:39 nvme0n1 ->
> ../../devices/virtual/nvme-subsystem/nvme-subsys0/nvme0n1
> lrwxrwxrwx    1 root     root             0 Jul 30 12:39 nvme0n1p1 ->
> ../../devices/virtual/nvme-subsystem/nvme-subsys0/nvme0n1/nvme0n1p1
> 
> Thoughts?

Yes, looks good to me, though I don't really know why partition scanning
was skipped in the first place. I always thought the important part was
the HIDDEN devices don't automatically enumerate in /dev/.

