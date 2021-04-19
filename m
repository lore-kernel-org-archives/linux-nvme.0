Return-Path: <SRS0=6U9w=JQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F282C433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Apr 2021 16:51:10 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CFE361157
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Apr 2021 16:51:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CFE361157
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:Reply-To:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nDTou13G/wHSAWZ2rpYrl7f0BlAh3YTalwHqzd8VArY=; b=R7ULBIdpWomN6vfWDnjMCo0Q0
	dIneJ2gWhQA971HwL1If8oOIQi0lXt+Mhr9jgp3VbTqIwy2X/um689uSIPR7HXBhsbimA08XgO5Re
	NhlCWXEZGkpd0iG6IxPxdtJ1x/qMCh08aJ08Hib7i4zp6MpdcNR4Y7NzEFhHN1I45mlzqPYqg0zqN
	DBxNjLEY0ZD7uNEvj4xDcM+ErP05JIKAH2/8pCtqOW2QHekSxQ3mZNopXYnjb6ZDeQsRmFJXb33s/
	x3rSOU7aMPm9JyuKnSa4pGWZYmBeuPcgpauY5UBujMkvvjLIOEkk/W4JsnmKL22uxoyd5o5FNG5ah
	ezA1+t1Mw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYX6q-00AJS2-D4; Mon, 19 Apr 2021 16:50:52 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYX6o-00AJRs-GV
 for linux-nvme@desiato.infradead.org; Mon, 19 Apr 2021 16:50:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=yrSVs0lsE+YCubTc1rixphDFIwuf2KjCzYEjJTfu8gw=; b=zxXFwl4L06ZyZy/iGvnRUSA0r9
 T8KphFvfjxJXSyp+CTsT2ek2G6fhBB1ojNAji5nzT0cCzDrK1KIy1fIz6D16aOJwKT9c7+MVjsPjk
 NKGfTGNSVctYyEnPVNmYhj9Jy5ZUorej9QR/r/nVP3/lYQHt/BtxZRA5JaEIzT960j8I9MzmvOOLA
 EqfeVmwIpzHjA9cNDVwA4+K7EiV2jlood4G9wCy676lZthOSnCsBQhIEuiYhDCbVTwsqAT2EhjuVY
 QIMtMGrFU7D5p794dQEbHfBA7AKhR7Vuy4tiLKtT1dFzwIyCkginBvoM8r03CmE0OBfISfXrQCI/u
 WLRc5FIg==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYX6i-00BXQW-Jd
 for linux-nvme@lists.infradead.org; Mon, 19 Apr 2021 16:50:49 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 10B3BB30F;
 Mon, 19 Apr 2021 16:50:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
 id 45999DA732; Mon, 19 Apr 2021 18:48:22 +0200 (CEST)
Date: Mon, 19 Apr 2021 18:48:22 +0200
From: David Sterba <dsterba@suse.cz>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
 "dsterba@suse.cz" <dsterba@suse.cz>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 Mike Snitzer <snitzer@redhat.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Jens Axboe <axboe@kernel.dk>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH 3/4] btrfs: zoned: fail mount if the device does not
 support zone append
Message-ID: <20210419164822.GN7604@twin.jikos.cz>
Mail-Followup-To: dsterba@suse.cz, Damien Le Moal <Damien.LeMoal@wdc.com>,
 "hch@infradead.org" <hch@infradead.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 Mike Snitzer <snitzer@redhat.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Jens Axboe <axboe@kernel.dk>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Naohiro Aota <Naohiro.Aota@wdc.com>
References: <20210416030528.757513-1-damien.lemoal@wdc.com>
 <20210416030528.757513-4-damien.lemoal@wdc.com>
 <20210416161720.GA7604@twin.jikos.cz>
 <20210419092855.GA3223318@infradead.org>
 <BL0PR04MB651459AE484861FD4EA20669E7499@BL0PR04MB6514.namprd04.prod.outlook.com>
 <20210419093921.GA3226573@infradead.org>
 <BL0PR04MB65145DA8B6252C452EAA8BC9E7499@BL0PR04MB6514.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BL0PR04MB65145DA8B6252C452EAA8BC9E7499@BL0PR04MB6514.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210419_095044_978097_9ED22E0F 
X-CRM114-Status: GOOD (  20.45  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Apr 19, 2021 at 09:46:36AM +0000, Damien Le Moal wrote:
> On 2021/04/19 18:41, hch@infradead.org wrote:
> > On Mon, Apr 19, 2021 at 09:35:37AM +0000, Damien Le Moal wrote:
> >> This is only to avoid someone from running zoned-btrfs on top of dm-crypt.
> >> Without this patch, mount will be OK and file data writes will also actually be
> >> OK. But all reads will miserably fail... I would rather have this patch in than
> >> deal with the "bug reports" about btrfs failing to read files. No ?
> >>
> >> Note that like you, I dislike having to add such code. But it was my oversight
> >> when I worked on getting dm-crypt to work on zoned drives. Zone append was
> >> overlooked at that time... My bad, really.
> > 
> > dm-crypt needs to stop pretending it supports zoned devices if it
> > doesn't.  Note that dm-crypt could fairly trivially support zone append
> > by doing the same kind of emulation that the sd driver does.
> 
> I am not so sure about the "trivial" but yes, it is feasible. Let me think about
> something then. Whatever we do, performance with ZNS will no be great, for
> sure... But for SMR HDDs, we likely will not notice any difference in performance.

So this needs to be fixed outside of btrfs. The fix in btrfs would make
sense in case we can't sync the dm-crypt and btrfs in a released kernel.
Having a mount check sounds like a better option to me than to fail
reads, we can revert it in a release once everything woks as expected.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
