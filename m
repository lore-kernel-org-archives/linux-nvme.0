Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E49FC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 14:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X4cn6JV8O5AWRhPuK4Wz8bFqAnv8oC3Dsib+SHAacxc=; b=Nkcwy2Px0VPSlHDwWwIC5g7vUf
	Yg/t3mD1FjfDWNVv+HPOmaakySVtA81mkXzzbm8F5ptlx6nclUZR0ctzk17JtCbhqD+7SL0Y4o3on
	N3ebNhQchvoKm6i8AubDLzXfUQ7S0jL5/jebAvnWAPQUvh8Osoz2Bn8bK1NXY6MSAcO4w6CG00Q9U
	YSgnLI4b6XCBnC2ymPE5mnK9MrM3djBmskg+McXfzjE4lrbChWVIOEiiSfy5SrqUMezlIKDEw0cKq
	nH75gworRv5ESnOXJZADZkukWQJTt4W+ZEmdS2jcEr8AnIywIY6P54TN/3aUpKDW3OgQ/WQ+g7k2P
	F/1q7OXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU8DG-009SY4-6q; Tue, 15 Mar 2022 14:31:50 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU8DC-009SWP-SH
 for linux-nvme@lists.infradead.org; Tue, 15 Mar 2022 14:31:48 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 0A4571F391;
 Tue, 15 Mar 2022 14:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1647354702;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X4cn6JV8O5AWRhPuK4Wz8bFqAnv8oC3Dsib+SHAacxc=;
 b=AeePv1tYMjuFa+aHT+vLeUHCFANUp2upgQvR8FONiCoHkfgRPwtYn+YcU47g8mQR8xGMjj
 dF8lRdVfTicMFe2IfCiJWp6NsR35uAjZHmWjG+23uQTEi+1BZcWZ4Dn05qtApxxz8hgCKN
 /KHQseXyUpbpX4EqAUILwbcg7z/PUQ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1647354702;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X4cn6JV8O5AWRhPuK4Wz8bFqAnv8oC3Dsib+SHAacxc=;
 b=taUQzUafQQZZAq34Z4BXfJfJMlBB/yEH93K5d2DJbUxkQyKCDrlRYIsIzerMcwkYGj5E20
 MrNXb5dXtx/3sNAg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
 by relay2.suse.de (Postfix) with ESMTP id 196C0A3B81;
 Tue, 15 Mar 2022 14:31:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
 id 22423DA7E1; Tue, 15 Mar 2022 15:27:40 +0100 (CET)
Date: Tue, 15 Mar 2022 15:27:40 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
 Christoph Hellwig <hch@lst.de>,
 Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Pankaj Raghav <p.raghav@samsung.com>,
 Adam Manzanares <a.manzanares@samsung.com>,
 "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
 kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>, Pankaj Raghav <pankydev8@gmail.com>,
 Kanchan Joshi <joshiiitr@gmail.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Message-ID: <20220315142740.GU12643@twin.jikos.cz>
Mail-Followup-To: dsterba@suse.cz,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
 Christoph Hellwig <hch@lst.de>,
 Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Luis Chamberlain <mcgrof@kernel.org>,
 Keith Busch <kbusch@kernel.org>,
 Pankaj Raghav <p.raghav@samsung.com>,
 Adam Manzanares <a.manzanares@samsung.com>,
 "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
 kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>,
 Pankaj Raghav <pankydev8@gmail.com>,
 Kanchan Joshi <joshiiitr@gmail.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
References: <20220314104938.hv26bf5vah4x32c2@ArmHalley.local>
 <BYAPR04MB49682B9263F21EE67070A4B1F10F9@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220314195551.sbwkksv33ylhlyx2@ArmHalley.local>
 <BYAPR04MB49688BD817284E5C317DD5D8F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315130501.q7fjpqzutadadfu3@ArmHalley.localdomain>
 <BYAPR04MB49689803ED6E1E32C49C6413F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315132611.g5ert4tzuxgi7qd5@unifi>
 <20220315133052.GA12593@lst.de>
 <20220315135245.eqf4tqngxxb7ymqa@unifi>
 <PH0PR04MB74167377D7D86C60C290DAB29B109@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH0PR04MB74167377D7D86C60C290DAB29B109@PH0PR04MB7416.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_073147_111112_3975F4EF 
X-CRM114-Status: GOOD (  41.02  )
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

On Tue, Mar 15, 2022 at 02:14:23PM +0000, Johannes Thumshirn wrote:
> On 15/03/2022 14:52, Javier González wrote:
> > On 15.03.2022 14:30, Christoph Hellwig wrote:
> >> On Tue, Mar 15, 2022 at 02:26:11PM +0100, Javier González wrote:
> >>> but we do not see a usage for ZNS in F2FS, as it is a mobile
> >>> file-system. As other interfaces arrive, this work will become natural.
> >>>
> >>> ZoneFS and butrfs are good targets for ZNS and these we can do. I would
> >>> still do the work in phases to make sure we have enough early feedback
> >>> from the community.
> >>>
> >>> Since this thread has been very active, I will wait some time for
> >>> Christoph and others to catch up before we start sending code.
> >>
> >> Can someone summarize where we stand?  Between the lack of quoting
> >> from hell and overly long lines from corporate mail clients I've
> >> mostly stopped reading this thread because it takes too much effort
> >> actually extract the information.
> > 
> > Let me give it a try:
> > 
> >   - PO2 emulation in NVMe is a no-go. Drop this.
> > 
> >   - The arguments against supporting PO2 are:
> >       - It makes ZNS depart from a SMR assumption of PO2 zone sizes. This
> >         can create confusion for users of both SMR and ZNS
> > 
> >       - Existing applications assume PO2 zone sizes, and probably do
> >         optimizations for these. These applications, if wanting to use
> >         ZNS will have to change the calculations
> > 
> >       - There is a fear for performance regressions.
> > 
> >       - It adds more work to you and other maintainers
> > 
> >   - The arguments in favour of PO2 are:
> >       - Unmapped LBAs create holes that applications need to deal with.
> >         This affects mapping and performance due to splits. Bo explained
> >         this in a thread from Bytedance's perspective.  I explained in an
> >         answer to Matias how we are not letting zones transition to
> >         offline in order to simplify the host stack. Not sure if this is
> >         something we want to bring to NVMe.
> > 
> >       - As ZNS adds more features and other protocols add support for
> >         zoned devices we will have more use-cases for the zoned block
> >         device. We will have to deal with these fragmentation at some
> >         point.
> > 
> >       - This is used in production workloads in Linux hosts. I would
> >         advocate for this not being off-tree as it will be a headache for
> >         all in the future.
> > 
> >   - If you agree that removing PO2 is an option, we can do the following:
> >       - Remove the constraint in the block layer and add ZoneFS support
> >         in a first patch.
> > 
> >       - Add btrfs support in a later patch
> 
> (+ linux-btrfs )
> 
> Please also make sure to support btrfs and not only throw some patches 
> over the fence. Zoned device support in btrfs is complex enough and has 
> quite some special casing vs regular btrfs, which we're working on getting
> rid of. So having non-power-of-2 zone size, would also mean having NPO2
> block-groups (and thus block-groups not aligned to the stripe size).
> 
> Just thinking of this and knowing I need to support it gives me a 
> headache.

PO2 is really easy to work with and I guess allocation on the physical
device could also benefit from that, I'm still puzzled why the NPO2 is
even proposed.

We can possibly hide the calculations behind some API so I hope in the
end it should be bearable. The size of block groups is flexible we only
want some reasonable alignment.

> Also please consult the rest of the btrfs developers for thoughts on this.
> After all btrfs has full zoned support (including ZNS, not saying it's 
> perfect) and is also the default FS for at least two Linux distributions.

I haven't read the whole thread yet, my impression is that some hardware
is deliberately breaking existing assumptions about zoned devices and in
turn breaking btrfs support. I hope I'm wrong on that or at least that
it's possible to work around it.

