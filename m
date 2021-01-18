Return-Path: <SRS0=Iqha=GV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E55C433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jan 2021 18:28:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D360222CA1
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jan 2021 18:28:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D360222CA1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PX4NdFFpoObjOCaNakIo+ebVQqBfivhpih7THNb0OGQ=; b=FH9hBw5BuieA+Wrd3jtyefQA3
	uWF+xybSGYuJCsT+2/Kn8sjiBIUflHuIEnCDksN1HjN2rsp5t2jnHror+uPL9uECipzwVFQZNBLDD
	KxHYl0aZzu7Z08Bn9SYqWP30Td8yFf6JpXVyO37azik66SiUHrgkBPAbhYfDxRhMzw3z/m+pTkNUy
	dDXhgP5AsF3pZCyr/VjX5B+oSnJd4a2gF40bojVfyt7BlyegRYwuxdMnKgwIxIsW9I+EVlWJCg1nv
	DyDPk9I8TdS1kpJOAiK4ZuKBKtRiYvoUZEwls7vBgGsxA4V5/6c12KXNlRI3X/pVL/IXw8NuC4NOY
	UI1vhPVrA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l1ZG4-0000RY-To; Mon, 18 Jan 2021 18:28:08 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l1ZG1-0000R1-SC
 for linux-nvme@lists.infradead.org; Mon, 18 Jan 2021 18:28:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 379AF67373; Mon, 18 Jan 2021 19:28:04 +0100 (CET)
Date: Mon, 18 Jan 2021 19:28:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH V9 5/9] nvmet: add bio get helper for different backends
Message-ID: <20210118182803.GE11082@lst.de>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
 <20210112042623.6316-6-chaitanya.kulkarni@wdc.com>
 <20210112073315.GA24288@lst.de>
 <BYAPR04MB4965361DC74566BD26E3DC7B86A90@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB4965361DC74566BD26E3DC7B86A90@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210118_132806_052896_4DE83843 
X-CRM114-Status: GOOD (  14.00  )
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
 Damien Le Moal <Damien.LeMoal@wdc.com>, Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jan 13, 2021 at 05:03:05AM +0000, Chaitanya Kulkarni wrote:
> On 1/11/21 23:33, Christoph Hellwig wrote:
> > I'm not a huge fan of this helper, especially as it sets an end_io
> > callback only for the allocated case, which is a weird calling
> > convention.
> >
> 
> The patch has a right documentation and that end_io is needed
> for passthru case. To get rid of the weirdness I can remove
> passthru case and make itend_io assign to inline and non-inline bio
> to make it non-weired.
> 
> Since this eliminates exactly identical lines of the code in atleast two
> backend which we should try to use the helper in non-wried way.

I really do not like helper that just eliminate "duplicate lines" vs
encapsulating logic that makes sense one its own.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
