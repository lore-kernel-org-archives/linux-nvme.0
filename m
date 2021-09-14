Return-Path: <SRS0=UXA3=OE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5DDC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 05:44:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6405961155
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 05:44:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6405961155
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2R8UqyrujMS2zSIYJ+hzLYn2H/pXcBbpNFd04mSmwl4=; b=YP8npYrxbePXHr
	L209Khrexg0dfBU9rIwF5vWdPKhZYTHBYLIodK3QJaRAJ6K+qLX0yNEFBDN5K6I9gVqa5pa5WzHxi
	pqwtZZiIQNgyqNo0nQFWidApTpTW+wtD6LsUDvyywgw0HCu4ETbTvO9Bg+2MkWfenSuzzfbXo7u5E
	7ntVPYV823TW0tWQyPBVMLiiX6jaWxAbpV62S6Qxb9nP8lWYzSzJqzt1OKEJaoYfjPYF6ci0CTGLI
	FM7Etirz3olI5nNGs5epSZnOP0TLcX02TbM0zyOy73lqvD+Ju2TgM4q2CeDmq/dte/E+rGhtVNBaG
	/+Nf0a5xc6XXnIrEi7Pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQ1F2-004EFN-Iy; Tue, 14 Sep 2021 05:44:24 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQ1Ez-004EEx-C2
 for linux-nvme@lists.infradead.org; Tue, 14 Sep 2021 05:44:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 48F6568AFE; Tue, 14 Sep 2021 07:44:11 +0200 (CEST)
Date: Tue, 14 Sep 2021 07:44:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Anton Eidelman <anton.eidelman@gmail.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 sagi@grimberg.me, axboe@fb.com
Subject: Re: [PATCH v2 2/3] nvme/multipath: cosmetic: keep ns nsid locally
Message-ID: <20210914054410.GA26026@lst.de>
References: <20210912185459.13496-4-anton@lightbitslabs.com>
 <20210913153023.70879-1-anton@lightbitslabs.com>
 <20210913153023.70879-3-anton@lightbitslabs.com>
 <20210913160220.GB6442@lst.de> <20210913201935.GA83181@anton-latitude>
 <20210913205717.GE3283786@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210913205717.GE3283786@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210913_224421_608807_914E8F2B 
X-CRM114-Status: GOOD (  19.95  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Sep 13, 2021 at 01:57:17PM -0700, Keith Busch wrote:
> > > I can't really see any improvement here.  Also checkpath as so often
> > > these days is fundamentally wrong here.
> > 
> > Do we you prefer to scrap this commit?
> > 
> > I just wanted to get rid of multiple occurances of "ns->head->ns_id",
> > and just use a local variable that only changes
> > once in the for_each iteration.
> 
> I personally think "unsigned" is a well defined type in C and we should
> ignore check-patch complaints on its use.

Agreed.  If we want to cleanup nsids (and at this point I don't), we
should move them all over to u32 instead..

> Otherwise, I don't have a
> problem with the patch.

Well, it is obviously correct, but I also don't see the point of it.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
