Return-Path: <SRS0=qQKB=H2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D3FC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 09:13:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B200564E24
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 09:13:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B200564E24
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Zt6KMpu5RcnvxDuZ/jMU13/xVgbHXr8M3fb4Im8pWtw=; b=A5ToLpS8JTwzv+P8Cl3bhDCRh
	w8LidNLvBf0NBp1Nsrbyy8dnxiBp9Bp8r38AgRsKOiT+TydM4KQBMeo79sdxqUwepcIXVqGSI0ZKo
	TfylECV4um7oMqvWeElbM4cMeUV38yBAutU+N/4Aw1chm/rOlHmM5pAYJOAS29QmBWySrLOvVnFRF
	4mxedmkeNjY9EL2Natmt9uUUiCXO9k6QyWWMnIez2Ot4lexvui5UOS4WTgidrBowoEOGBdpDL9JZ7
	ftlvb5yvwXkc/p/ffJ510OqOri/HxT+bzYSMMuqRTiL+ZP/b/6GBkZsB2uH3seY7fn8NQxwafWQun
	z6obVFvTQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEqEd-0000Zc-Fj; Wed, 24 Feb 2021 09:13:31 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEqEb-0000Yw-4J
 for linux-nvme@lists.infradead.org; Wed, 24 Feb 2021 09:13:29 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id EDB5A68D0A; Wed, 24 Feb 2021 10:13:26 +0100 (CET)
Date: Wed, 24 Feb 2021 10:13:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH] nvme-pci: prevent SK Hynix PE8000 from using Write
 Zeroes command
Message-ID: <20210224091326.GA5159@lst.de>
References: <20210209045902.72345-1-gtiwari@redhat.com>
 <YCOxjZhBTBchOq0n@infradead.org>
 <211078952.30654328.1612955843198.JavaMail.zimbra@redhat.com>
 <20210210131557.GB29904@lst.de>
 <BYAPR04MB49650A271CD1C1B3EFA72F3D868D9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20210211070748.GA13852@lst.de>
 <BYAPR04MB4965C95C3F826D7222EB3176868C9@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB4965C95C3F826D7222EB3176868C9@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210224_041329_325998_32810010 
X-CRM114-Status: GOOD (  10.21  )
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
Cc: "hch@infradead.org" <hch@infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, Gopal Tiwari <gtiwari@redhat.com>,
 Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Feb 11, 2021 at 06:11:19PM +0000, Chaitanya Kulkarni wrote:
> On 2/10/21 11:07 PM, Christoph Hellwig wrote:
> >>> I'd also love to retest most Write Zeroes quirks with that in place.
> >> Do you prefer some variant of the following patch (totally untested)? OR
> >> something else ?
> > Somwhat.  As said I suspect defaulting to MDTS with a big fat comment
> > might make most sense unless the new WZSL is set.
> >
> Okay, will send out patche(s) soon.

Did you get to this?  Or did I just miss it?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
