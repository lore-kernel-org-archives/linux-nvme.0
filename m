Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F7BC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 20 May 2022 17:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U1vEEBx5l6lck/ZVYtVMS6/WSLGFTxzXzQhGy8n6n1Y=; b=WFdf3XEIiMaiCjZ45Use8WIDfc
	KcnshxbTx/ukVRkAyUHt6hwNbylLGsJw+kWWolTRGHtoeXnEiypCK/kpazBPgSmAeKiKLJXmXsDHJ
	o8M/Piw8+eDz7oE+vWOP78d4CdiYsvP523GZLyWscJXzRC9qsCBZHEx+k8qdkdanyr9PQOkApuFal
	ltoN89VdXxv985ZVpUft81Vq8FrLCKQN5qAC989Z8F6IJPCCx9+1JteNSDrpHE6OtvfL7k3o5kuuC
	fZu/tXne65KqV+LJbXNMVgM0H/nXG0nptXvGN/7/Uy/aK80mnnrxvcBDiLKRTKsh4m3mGCsoioNMa
	YjT55gMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ns6L6-00DtA6-57; Fri, 20 May 2022 17:23:00 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ns6L2-00Dt76-Iv
 for linux-nvme@lists.infradead.org; Fri, 20 May 2022 17:22:58 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 050A01F899;
 Fri, 20 May 2022 17:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1653067371;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U1vEEBx5l6lck/ZVYtVMS6/WSLGFTxzXzQhGy8n6n1Y=;
 b=1K0EXYYgwzsP5pttWIVJPO7peR7LU+5/FGwrIehUJrgtYp1b2Z1gmnbsrlrvfd9lUvK2VA
 zu24tnaYU76hI6QXg7nbkOeg0BgdflDuWpJoTzQjH360AGI4TCOxit8DE29sKLWYXVeAlH
 Jl7ARw2GtOYQYSYYjCB3PhyECWDOHus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1653067371;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U1vEEBx5l6lck/ZVYtVMS6/WSLGFTxzXzQhGy8n6n1Y=;
 b=fdfW8UYvFzHZKAsM32Bd+yUPieD8tKqZpNTkU0+Ww4cQ9TxtNrH3v7+6LIxP4Bdiz6Gq/f
 1Yvz9mmtz7ulOzDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 83B7A13AF4;
 Fri, 20 May 2022 17:22:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 53QXH2rOh2KIPwAAMHmgww
 (envelope-from <dsterba@suse.cz>); Fri, 20 May 2022 17:22:50 +0000
Date: Fri, 20 May 2022 19:18:30 +0200
From: David Sterba <dsterba@suse.cz>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
 Hannes Reinecke <hare@suse.de>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Mike Snitzer <snitzer@redhat.com>, Christoph Hellwig <hch@lst.de>,
 Luis Chamberlain <mcgrof@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
 "pankydev8@gmail.com" <pankydev8@gmail.com>,
 "gost.dev@samsung.com" <gost.dev@samsung.com>,
 "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "dsterba@suse.com" <dsterba@suse.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>
Subject: Re: [dm-devel] [PATCH v4 00/13] support non power of 2 zoned devices
Message-ID: <20220520171830.GR18596@twin.jikos.cz>
Mail-Followup-To: dsterba@suse.cz, Pankaj Raghav <p.raghav@samsung.com>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
 Hannes Reinecke <hare@suse.de>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Mike Snitzer <snitzer@redhat.com>, Christoph Hellwig <hch@lst.de>,
 Luis Chamberlain <mcgrof@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
 "pankydev8@gmail.com" <pankydev8@gmail.com>,
 "gost.dev@samsung.com" <gost.dev@samsung.com>,
 "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "dsterba@suse.com" <dsterba@suse.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>
References: <YoPAnj9ufkt5nh1G@mit.edu>
 <7f9cb19b-621b-75ea-7273-2d2769237851@opensource.wdc.com>
 <20220519031237.sw45lvzrydrm7fpb@garbanzo>
 <69f06f90-d31b-620b-9009-188d1d641562@opensource.wdc.com>
 <PH0PR04MB74166C87F694B150A5AE0F009BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
 <4a8f0e1b-0acb-1ed4-8d7a-c9ba93fcfd02@opensource.wdc.com>
 <16f3f9ee-7db7-2173-840c-534f67bcaf04@suse.de>
 <20220520062720.wxdcp5lkscesppch@mpHalley-2.localdomain>
 <be429864-09cb-e3fb-2afe-46a3453c4d73@opensource.wdc.com>
 <aee22e8a-b89b-378c-3d5b-238c1215b01d@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aee22e8a-b89b-378c-3d5b-238c1215b01d@samsung.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220520_102256_795571_55D8C3D1 
X-CRM114-Status: GOOD (  16.29  )
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
Reply-To: dsterba@suse.cz
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, May 20, 2022 at 11:30:09AM +0200, Pankaj Raghav wrote:
> On 5/20/22 08:41, Damien Le Moal wrote:
> >> Note that for F2FS there is no blocker. Jaegeuk picked the initial
> >> patches, and he agreed to add native support.
> > 
> > And until that is done, f2fs will not work with these new !po2 devices...
> > Having the new dm will avoid that support fragmentation which I personally
> > really dislike. With the new dm, we can keep support for *all* zoned block
> > devices, albeit needing a different setup depending on the device. That is
> > not nice at all but at least there is a way to make things work continuously.
> 
> I see that many people in the community feel it is better to target the
> dm layer for the initial support of npo2 devices. I can give it a shot
> and maintain a native out-of-tree support for FSs for npo2 devices and
> merge it upstream as we see fit later.

Some of the changes from your patchset are cleanups or abstracting the
alignment and zone calculations, so this can be merged to minimize the
out of tree code.

