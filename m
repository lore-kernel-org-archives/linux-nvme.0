Return-Path: <SRS0=Uo3O=YD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121C9C4360C
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 15:10:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA214206A1
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 15:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EExtCLa/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA214206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SmGggBASLzdPp/jdVgz8Bn75i+YZXNojuRJ7kRkH1ag=; b=EExtCLa/lfBqY5
	DNiCX9e9tuNHd9bkRpyUtHPVaO5aarzDKmQuquAnzod3L/ucQ3MilINL7oyNXOCZok5g/8dKaGW1Y
	QxPSuB678EPsOJY0z3c3LtuRdVdENh619pdDWYood3q5n8xQfNf/9QgVR+injJjtGG+l6HyTT3krQ
	k0JBM2dUbrI5Gzz33pLAkQYm+FtB/9Ps5GXrf36p1JHC0C4mXDd5BrnsbcswEwqZMO3QJRZLv84Je
	JAhwBNaM493wKKZoiKZwa+nRhvzN64NsJY5tmJ7812BBNlyeZsDbpOA7gVkZcpRVhWftTVFtv/MGl
	jyXSqU9B1r43xhw9W0Yg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iIa5F-0006qk-LM; Thu, 10 Oct 2019 15:10:29 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iIa5B-0006qH-L0
 for linux-nvme@lists.infradead.org; Thu, 10 Oct 2019 15:10:26 +0000
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
 (envelope-from <bigeasy@linutronix.de>)
 id 1iIa59-0003kv-L5; Thu, 10 Oct 2019 17:10:23 +0200
Date: Thu, 10 Oct 2019 17:10:23 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme-tcp: Remove access to sk->sk_ll_usec
Message-ID: <20191010151023.gru6fhrhy7gxxwye@linutronix.de>
References: <20191010150622.reqmasxgavug4amm@linutronix.de>
 <20191010150719.GA617@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191010150719.GA617@lst.de>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191010_081025_831688_117AEAD4 
X-CRM114-Status: UNSURE (   8.02  )
X-CRM114-Notice: Please train this message.
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 tglx@linutronix.de, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2019-10-10 17:07:19 [+0200], Christoph Hellwig wrote:
> The changelog doesn't match the patch, which just removes the assignment
> unconditionally.

I said that it has to be behind CONFIG_.* _but_ shouldn't be needed due
to the setsockopt() thingy. Isn't this working? If not I can put it
behind the ifdef. Be aware that the setsockopt() returns an error if
this polling is not available.

Sebastian

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
