Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC16C433EF
	for <linux-nvme@archiver.kernel.org>; Sat, 23 Apr 2022 17:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fiz2jMqZWyKv6L3Dn2JLWhMkmn5VF9KPcqgTA7X/dHA=; b=3IMjCJwiUCxn8yPlV0JhOi77Mx
	PZVchu2eKi4meD0nxRfSoxH8n7wNhuK3MV9fHCWsq98uLraVaAR+1GWh1dl8P468jjEXFahPWjS4L
	L7XwVZWZIKWscg5cVeew0nwzy57lwwoznjQN384OvSdOhSWJqFkiKdO9LiBHqUBNeMAgpmwj/W53q
	2uLe2ByCq6d2QN4raWoahxIuUS225+2ICC7a114sIsZv9+c4LuE595oy5Ds1mcsbXcRVPBBpPL5Rf
	0pB/MCqhSWv4Qz20whw91kvIvKGWcl8pENl9hjJzSvArJmwMFJ/H1GayoYNg3hY4UA9UnN+m4Poae
	VB5gOHVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1niJwj-004nzo-3G; Sat, 23 Apr 2022 17:53:25 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1niJwZ-004nz4-Jm
 for linux-nvme@lists.infradead.org; Sat, 23 Apr 2022 17:53:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 95F4568D05; Sat, 23 Apr 2022 19:53:09 +0200 (CEST)
Date: Sat, 23 Apr 2022 19:53:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshiiitr@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
 Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, Pavel Begunkov <asml.silence@gmail.com>,
 Ming Lei <ming.lei@redhat.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Pankaj Raghav <pankydev8@gmail.com>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
 Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [RFC 5/5] nvme: wire-up support for async-passthru on char-device.
Message-ID: <20220423175309.GC29219@lst.de>
References: <20220401110310.611869-1-joshi.k@samsung.com>
 <CGME20220401110838epcas5p2c1a2e776923dfe5bf65a3e7946820150@epcas5p2.samsung.com>
 <20220401110310.611869-6-joshi.k@samsung.com> <20220404072016.GD444@lst.de>
 <CA+1E3rJ+iWAhUVzVrRDiFTUmp5sNF7wqw_7oVqru2qLCTBQrqQ@mail.gmail.com>
 <20220405060224.GE23698@lst.de>
 <CA+1E3rJXrUnmc08Zy3yO=0mGJv1q0CaJez4eUDnTpaJcSh_1FQ@mail.gmail.com>
 <CA+1E3rK3EzyNVwPEuR3tJfRGvScwwrDhxAc9zs=a5XMc9trpmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+1E3rK3EzyNVwPEuR3tJfRGvScwwrDhxAc9zs=a5XMc9trpmg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220423_105315_831148_4C89919E 
X-CRM114-Status: GOOD (  14.11  )
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

On Wed, Apr 06, 2022 at 10:50:14AM +0530, Kanchan Joshi wrote:
> > In that case we will base the newer version on its top.
> But if it saves some cycles for you, and also the travel from nvme to
> linux-block tree - I can carry that refactoring as a prep patch in
> this series. Your call.

FYI, this is what I have so far:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/nvme-passthrough-refactor

the idea would be to use these lower level helpers for uring, and
not really share the higher level function at all.  This does create
a little extra code, but I think it'll be more modular and better
maintainable.  Feel free to pull this in if it helps you, otherwise
I'll try to find some time to do more than just light testing and
will post it.

