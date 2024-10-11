Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA3DCFD2F5
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Oct 2024 09:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pQbRATIO+J3+8s6fUV/KjmcT6NeYyIape4vJU+9M3Vk=; b=TmN3N9NsmrdUSSLCpKarCVlAtB
	oEZRTEfSnp9rEnUYJAlzP3kQU1pw8SDSUl2t3IcrAhWOxmfhyXu/LtkbdNzwans9oJwR7aOIdEwml
	7t+aJ6MERiX9Knxp5UpH9A0BFZ9vV1527tOOeVeyFPUDQ4Rv95LQCejliRZHhRuls4ooGlzv0sgDs
	B25NKJgaCOHIGXK0WCfnUzYWxD5TURHqc6CSh2LA1xOUPmFz2vIUOcmUxYPXN11TF9h1fEuGlZdWU
	m3Y3BzqvfSjibVZblKGwfznWaOajlRsTxLB1N2Yz7dNKhzwqBHT4ZjyDw07Vvcu/iOex1xnujyIk6
	XIoN0/wQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1szBXb-0000000FlqP-3D24;
	Fri, 11 Oct 2024 09:02:31 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1szBXY-0000000FloT-3QuF
	for linux-nvme@lists.infradead.org;
	Fri, 11 Oct 2024 09:02:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AD211227AB3; Fri, 11 Oct 2024 11:02:24 +0200 (CEST)
Date: Fri, 11 Oct 2024 11:02:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Kanchan Joshi <joshi.k@samsung.com>, hare@suse.de, sagi@grimberg.me,
	brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	jaegeuk@kernel.org, bcrl@kvack.org, dhowells@redhat.com,
	bvanassche@acm.org, asml.silence@gmail.com,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, linux-block@vger.kernel.org,
	linux-aio@kvack.org, gost.dev@samsung.com, vishak.g@samsung.com
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
Message-ID: <20241011090224.GC4039@lst.de>
References: <20241004123027.GA19168@lst.de> <20241007101011.boufh3tipewgvuao@ArmHalley.local> <20241008122535.GA29639@lst.de> <ZwVFTHMjrI4MaPtj@kbusch-mbp> <20241009092828.GA18118@lst.de> <Zwab8WDgdqwhadlE@kbusch-mbp> <CGME20241010070738eucas1p2057209e5f669f37ca586ad4a619289ed@eucas1p2.samsung.com> <20241010070736.de32zgad4qmfohhe@ArmHalley.local> <20241010091333.GB9287@lst.de> <20241010115914.eokdnq2cmcvwoeis@ArmHalley.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241010115914.eokdnq2cmcvwoeis@ArmHalley.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241011_020229_111279_7B78636E 
X-CRM114-Status: GOOD (  15.09  )
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

On Thu, Oct 10, 2024 at 01:59:14PM +0200, Javier González wrote:
>> As mentioned probably close to a dozen times over this thread and it's
>> predecessors:  Keeping the per-file I/O hint API and mapping that to
>> FDP is fine.  Exposing the overly-simplistic hints to the NVMe driver
>> through the entire I/O stack and locking us into that is not.
>
> I don't understand the "locking us into that" part.

The patches as submitted do the two following two things:

 1) interpret the simple temperature hints to map to FDP reclaim handles
 2) add a new interface to set the temperature hints per I/O

and also rely on an annoying existing implementation detail where the I/O
hints set on random files get automatically propagated to the block
device without file system involvement.

This means we can't easily make the nvme driver actually use smarter
hints that expose the actual FDP capabilities without breaking users
that relied on the existing behavior, especially the per-I/O hints that
counteract any kind of file system based data placement.


