Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E47D2E014
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Oct 2024 05:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yTydEBNToFgbZazQC634v6DHQrH9ektGC3j3oX0bLFQ=; b=ftJxibd47xjGM60SWwOfD3HBaq
	SbdRDr7XyDBBRiQxfJkPSQNvYOctqKQ6Ry86q2axbs5tpuBO6qBxb8JiXogERSybJHym+fF46LdUp
	N1OMpDhKYw7aXZo+TAQqIW73RX7+RPGLFhVPpM75zNMQMBiXUVD7JX5zAn/UF8IkJtnXKbSanpTW7
	0KagxNyADqOSdvcRUfQ/NZ9UR9lYuV8V4WD5g7KZWXuRaIoZGLCXny36ZNENzZudZFTwoO/XCBHVV
	D3np+ZYTfJEAzxz8NzCS273g1TNIdj3p6HJj89eBUrVJ9S7Bkg3UruxZS/NDegq6MfcCxX5X6OOuS
	gE4/ZJeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3Tne-0000000D23m-2TZi;
	Wed, 23 Oct 2024 05:20:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3Tnb-0000000D235-3bpK
	for linux-nvme@lists.infradead.org;
	Wed, 23 Oct 2024 05:20:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B2446227A87; Wed, 23 Oct 2024 07:20:43 +0200 (CEST)
Date: Wed, 23 Oct 2024 07:20:42 +0200
From: hch <hch@lst.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: hch <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@meta.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Jirong Feng <jirong.feng@easystack.cn>
Subject: Re: [PATCH] nvme-loop: set blocking flag
Message-ID: <20241023052042.GB1341@lst.de>
References: <20241017172052.2603389-1-kbusch@meta.com> <7846e57b-fb03-42ed-af8e-0df88cc566a4@kernel.dk> <ZxFRpdU-GI76uetA@kbusch-mbp.dhcp.thefacebook.com> <20241018051056.GC19831@lst.de> <64f4d599-3261-4544-90c2-4cb3e1ad96fb@grimberg.me> <20241022062810.GC10573@lst.de> <20241022070252.GA11389@lst.de> <ygq2tospvgesry2uuhh2fh5gzdm3vbkatdm42v2fjqlddzj43d@sdoplqu4vg62>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ygq2tospvgesry2uuhh2fh5gzdm3vbkatdm42v2fjqlddzj43d@sdoplqu4vg62>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241022_222048_068854_8496A394 
X-CRM114-Status: GOOD (  13.21  )
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

On Tue, Oct 22, 2024 at 08:08:31AM +0000, Shinichiro Kawasaki wrote:
> As for the BUG caused by the commit 505363957fad, the blktests test case
> nvme/052 can confirm if any patch fixes the BUG or not. It is recreate in
> stable manner on my test node [1], so I'm happy to help testing.
> 
> If you mean a test case to confirm that the commit 505363957fad achieves its
> purpose, I'm not sure about it. According to its commit log, I guess Jirong
> might have a test environment.

Yes, that's the main thing I want to be able to test.


