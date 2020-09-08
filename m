Return-Path: <SRS0=ETB4=CR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DC1C43461
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Sep 2020 17:30:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2BBD20738
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Sep 2020 17:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="zLlapOXg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2BBD20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EAi4UUlBKksjEnsErsCMVruXiVA7qyPXcu28WyYoTtc=; b=zLlapOXg7/iuEOwbb0dEDVXWI
	Y+SngPVH+zm4ga+Sjls9WGl+xHx8fCIShfSxa8J1VrnuYhZUgoThM5Lvpv7kRBO/eXgL7gJg0xLCp
	KiKacivuZnKz3N76RwyHJMwSMsZRoOawLYjytWpYoDAYB823kJRT0LUTAWntYRdfsFGDpJU5BIGy3
	hVuTbhR5/QQ7nJQ1qP7oMc3EztBMXm87c8SzfZtsja07xudyioZQxzdaG6hGJ4M6Vi67RtHr76IYM
	qFD2Dc5vK/XIrmPTea8KkbJoYvitjAvpOF1MJZvGqBzkepzvf5tyPjN8qJvFfj1JHm9e0DUF8Fh7H
	CsS10Zqiw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kFhRi-0005ry-7I; Tue, 08 Sep 2020 17:30:18 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kFhRg-0005rK-9O
 for linux-nvme@lists.infradead.org; Tue, 08 Sep 2020 17:30:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 080E668B02; Tue,  8 Sep 2020 19:30:13 +0200 (CEST)
Date: Tue, 8 Sep 2020 19:30:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH V2 1/6] nvme-core: use I/O timeout in submit sync cmd
Message-ID: <20200908173012.GA19919@lst.de>
References: <20200904001626.5694-1-chaitanya.kulkarni@wdc.com>
 <20200904001626.5694-2-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200904001626.5694-2-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200908_133016_435179_41027856 
X-CRM114-Status: UNSURE (   8.36  )
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
Cc: keith.busch@intel.com, hch@lst.de, linux-nvme@lists.infradead.org,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Can you add a nvme_default_timeout() function instead of open coding
this here and in the next patch?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
