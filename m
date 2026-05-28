Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C0DCD4F54
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2026 18:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9zfQVtS7zyt1UNfdGE5qkvygfJ2lT/N6CFtv5qKDbrk=; b=r0uLMiSZAXFs572gaFT1Vbbgdj
	Vng7g2O3TsJ8I0GrenRY1isFgiF6AQOBYixb4v/VudOLIB21/7Y8VKWaZXmgvppcaUnh3gXojfL+C
	soUrcl4jxcNtIuKHWmG5htakCmeAy9jNIyPvyBKvW1gfdkcP/8PZioQRuNfNO9CW6BP9Ebj9e9X7P
	GXgCki6A4DfO5SKXmoqOLhUakrEjtVYm5h2PasQNLZrIOAp33bM71LOxJX8zFqUiakXzbL4f3fqp1
	muY6Bx90ftAGpCWqg4vlDVswKJ8FqhvyjYBpBudWdfd01mVRFNQcUXDv6sOUvP3tLB3tiw+keqeAK
	C2kidJYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSfKA-00000006ArV-2AaP;
	Thu, 28 May 2026 18:19:18 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSfK7-00000006Aqz-32s6
	for linux-nvme@lists.infradead.org;
	Thu, 28 May 2026 18:19:16 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B8E1840B4B;
	Thu, 28 May 2026 18:19:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129971F000E9;
	Thu, 28 May 2026 18:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779992354;
	bh=9zfQVtS7zyt1UNfdGE5qkvygfJ2lT/N6CFtv5qKDbrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CHnvxN+XbVHln5GN22bEU2DwuYKOLZj5zBnsHY7uYUJYtgLStmeZBgZI5iwEAeoW1
	 UAbb/TmzhPagoPnMxqDC+j24wYy4VtfZLogzWU+I02dzskNiBT8x+Qup1QHfOfxITg
	 y1zvbhEtk8nC1CC6cShHaV9Tf5lTGv/kbLlo8IIIEv8n7OMr1Yih2MhyE7BBYZDQd7
	 9Bx5yLx0o8OqL++j+d1zBEZe7Y32uxEfJbTBpLLTIQEm88e//aJVSY3/NzghQ8aQ04
	 oN/m/MgPw6HKU9YTWqkjT/3xFKNI+GTJDRsWKBSh6kQoqXkdY6WEWD+Oj/swFOSZtQ
	 KtSwbX2gFC35A==
Date: Thu, 28 May 2026 12:19:12 -0600
From: Keith Busch <kbusch@kernel.org>
To: "Achkinazi, Igor" <Igor.Achkinazi@dell.com>
Cc: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] nvme-multipath: set BIO_REMAPPED on bios remapped to
 per-path namespace disks
Message-ID: <ahiHIEhsV2zuG5vH@kbusch-mbp>
References: <MW5PR19MB548483D1FAE4F322E4C97352FD032@MW5PR19MB5484.namprd19.prod.outlook.com>
 <DS0PR19MB76963295FC34844B413479F9FD092@DS0PR19MB7696.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR19MB76963295FC34844B413479F9FD092@DS0PR19MB7696.namprd19.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260528_111915_792241_7B41D92A 
X-CRM114-Status: GOOD (  10.50  )
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

On Thu, May 28, 2026 at 03:24:27PM +0000, Achkinazi, Igor wrote:
> The SRCU read lock prevents synchronize_srcu() from completing, but
> does not prevent set_capacity(0) from executing.  The bio fails the
> EOD check before it reaches the NVMe driver, so nvme_failover_req()
> never gets a chance to redirect it to another path of multipath.  IO errors
> are reported to the application despite another path being available.

I double checked the sequences here, and yes, I think the
synchronize_srcu's already in place ensure every caller sees the EOD
error before it could fail the bio_queue_enter(), so this looks like it
happens to be sufficient. I'm okay with it. 

