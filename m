Return-Path: <SRS0=dg6g=FI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D3DC433FE
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Dec 2020 08:46:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 344F5225A9
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Dec 2020 08:46:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 344F5225A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IKhT1TPNE8E3U7pN5tAJoMGkJbWPrLO3k/POFCO4PLc=; b=yHVDO1Yl+QORhKEg6f286Jkmw
	LbYvsN35SiGoXZLhvUyM67uBDToChRbb+HXxogyggl8reKWrK74DKgPdPigzEfzRvqLpc2S2nHsHz
	l5XwY5yE8Q4+nRMc8GpsYuADzF2Cq8JuN9/wk3mRMl3e8qw9UXKUdFy3JoQmJBaiLvRsnVTba06vj
	xCrQzMRk1rMloreLSKZhrtXIWAA+suMPaBLdU+Eymkx9T7LXjjYs7W8FZSmlODWuKQms7oMbPxrH/
	x6TnHg2uR55XW/lQdFZbdpQ1cQXoq2eZGbDMXhh3surVwJdJJDKolslHZrLAdQiDTkseSfrVUPPzo
	nZ+eds0Hw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kl6jj-00012G-Gz; Fri, 04 Dec 2020 08:46:43 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kl6je-00011D-Ju
 for linux-nvme@lists.infradead.org; Fri, 04 Dec 2020 08:46:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 907636736F; Fri,  4 Dec 2020 09:46:34 +0100 (CET)
Date: Fri, 4 Dec 2020 09:46:34 +0100
From: "hch@lst.de" <hch@lst.de>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH V4 1/9] block: allow bvec for zone append get pages
Message-ID: <20201204084634.GA5845@lst.de>
References: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com>
 <20201202062227.9826-2-chaitanya.kulkarni@wdc.com>
 <20201202085531.GA2050258@infradead.org>
 <BYAPR04MB49652F70D16357D420E616AE86F10@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB49652F70D16357D420E616AE86F10@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201204_034638_768090_DAE7E675 
X-CRM114-Status: GOOD (  14.80  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@infradead.org" <hch@infradead.org>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Dec 04, 2020 at 02:43:10AM +0000, Chaitanya Kulkarni wrote:
> >> Remove the bvec check in the bio_iov_iter_get_pages() for
> >> REQ_OP_ZONE_APPEND so that we can reuse the code and build iter from
> >> bvec.
> > We should do the same optimization for bvec pages that the normal path
> > does.  That being said using bio_iov_iter_get_pages in nvmet does not
> > 	make any sense to me whatsover.
> >
> Are you referring to the inline bvec ? then yes, I'll add it in next
> version.
> 
> I did not understand bio_iov_iter_get_pages() comment though.
> 
> Reimplementing the bio loop over sg with the use of bio_add_hw_page() seems
> 
> repetition of the code which we already have in bio_iov_iter_get_pages().
> 
> 
> Can you please explain why bio_iov_iter_get_pages() not the right way ?

bio_iov_iter_get_pages is highly inefficient for this use case, as we'll
need to allocate two sets of bio_vecs.  It also is rather redundant as
Zone Append should be able to just largely reuse the write path.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
