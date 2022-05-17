Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 433AAC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 17 May 2022 11:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XWV9I8vEC/gVBQMdfp4ZLR/XCARFFY3wFzVWUZZsLyM=; b=q9AyxWJRvp9mKBtoYwoLTKnM70
	7CNCA8bRItz49eVDeq41TGVr+D+jzYiU6IVX7lQQyv191bqKZdmBXEn9g/ElBHtRUZFPSicGNJqiW
	db8NJs4VYj5ijWb7V9sPaneVXBMrxKR5sC/wpwjbZ07dUhsfn53RWr6u8t8wV0ItgaetnCbzQyNcD
	zLhOzzvc+gbwquF1mBt+Hqyt5xenfAmIsX51M6jTRkHddNk5qcUhBR8ZqBveaKJ2ulg6uvhOZCN0j
	3qs/8TRsqhJgB8DaoovUg6VYKZ/DHosSBRTg4Z3nsddJcX8NvTwtDXvCXzBpCLvzXZTgqt8NnrcNT
	uTjzjzvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nqvno-00DQvE-Cg; Tue, 17 May 2022 11:55:48 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nqvnl-00DQtp-KK
 for linux-nvme@lists.infradead.org; Tue, 17 May 2022 11:55:47 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1FA761F8F7;
 Tue, 17 May 2022 11:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652788540;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XWV9I8vEC/gVBQMdfp4ZLR/XCARFFY3wFzVWUZZsLyM=;
 b=j9NlYg+lgeZw9lxeHS9hEMqYh9EWqsSTl22Ibl6SLszboSCxHZeZodscBEl49w/4vIrcOB
 uAXkoX1nvTKjUM1EUBcvOyjjqjRbNUJbZ/kq4stZ+0/lerrP5gO4626alqaz99tsnRPc1F
 LBtIqYYF955Cs3zK/ONXbGQa4CWL9/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652788540;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XWV9I8vEC/gVBQMdfp4ZLR/XCARFFY3wFzVWUZZsLyM=;
 b=dxEL63L4qVfrlSY8/gFaeGBil7Jzz5/q5q2u14C3uE+vuxIzDaaJnUvlZVhVxGzwFZtcYq
 HrloqJOf4p4mS8Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B7A1D13305;
 Tue, 17 May 2022 11:55:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id nQDZKzuNg2JOAwAAMHmgww
 (envelope-from <dsterba@suse.cz>); Tue, 17 May 2022 11:55:39 +0000
Date: Tue, 17 May 2022 13:51:21 +0200
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Pankaj Raghav <p.raghav@samsung.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
 "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
 "pankydev8@gmail.com" <pankydev8@gmail.com>,
 "dsterba@suse.com" <dsterba@suse.com>, "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "gost.dev@samsung.com" <gost.dev@samsung.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v4 06/13] btrfs: zoned: Make sb_zone_number function non
 power of 2 compatible
Message-ID: <20220517115121.GA18596@twin.jikos.cz>
Mail-Followup-To: dsterba@suse.cz,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Pankaj Raghav <p.raghav@samsung.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
 "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
 "pankydev8@gmail.com" <pankydev8@gmail.com>,
 "dsterba@suse.com" <dsterba@suse.com>, "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "gost.dev@samsung.com" <gost.dev@samsung.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 Luis Chamberlain <mcgrof@kernel.org>
References: <20220516165416.171196-1-p.raghav@samsung.com>
 <CGME20220516165427eucas1p1cfd87ca44ec314ea1d2ddc8ece7259f9@eucas1p1.samsung.com>
 <20220516165416.171196-7-p.raghav@samsung.com>
 <PH0PR04MB741673F9764EFCA93F1932809BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB741673F9764EFCA93F1932809BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220517_045545_890270_FF0AF02E 
X-CRM114-Status: GOOD (  14.47  )
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

On Tue, May 17, 2022 at 06:53:40AM +0000, Johannes Thumshirn wrote:
> On 16/05/2022 18:54, Pankaj Raghav wrote:
> >  	/* Cache the sb zone number */
> >  	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; ++i) {
> >  		zone_info->sb_zone_location[i] =
> > -			sb_zone_number(zone_info->zone_size_shift, i);
> > +			sb_zone_number(bdev, i);
> 
> I think this easily fits on one line now, doesn't it? But given David's
> statement, it'll probably can go away anyways.

I agree that the formatting can be adjusted, but I'm never sure if I
should point it out during the phase of functional changes so it's fixed
in the next iteration as well, or not to point it out to avoid fixups
that would go away anyway. I think I've seen more, a styling pass will
be done anyway once we're close to the final version..

