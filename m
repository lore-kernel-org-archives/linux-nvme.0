Return-Path: <SRS0=cPwJ=HN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6586CC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Feb 2021 07:08:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8F2264E6F
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Feb 2021 07:07:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8F2264E6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UPuuIlZyD3KNQNzSskZwv8EDCtZbc8oZEil55uXehEE=; b=LrSKoURllMR5Ftl98aTD3MhsO
	WVBEQL/XewcOzuLUA7uN5/e1JX9om8dcEZZiBMymg2+Mb+zKvxo8zmS8dyqZakNBjkyGm1I7ny+ze
	O7kkaxI9nf/lJwqOyInu5Q6DZm2K0zduzC+pg7x4xntdBSYPF/53eoHSpCBw2aDmiwLOnExx3+GUI
	DL2L6bJEBTUzfbivdnbwqxZ3DC9C9swfFbwfGmzgan9kT7enOC1gFN0691lAJRtynbc3eTgM9PykX
	bjVaXLlQ3ur9/BsGfz1+qY4dA82EY6dfJjQSTm8LmiYNhLoXnK0VwmJ6f3MnpZiY1fXutY6/Uhpp+
	IinRkPaew==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lA64x-0002v5-AK; Thu, 11 Feb 2021 07:07:55 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lA64t-0002uB-PX
 for linux-nvme@lists.infradead.org; Thu, 11 Feb 2021 07:07:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 770A06736F; Thu, 11 Feb 2021 08:07:48 +0100 (CET)
Date: Thu, 11 Feb 2021 08:07:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH] nvme-pci: prevent SK Hynix PE8000 from using Write
 Zeroes command
Message-ID: <20210211070748.GA13852@lst.de>
References: <20210209045902.72345-1-gtiwari@redhat.com>
 <YCOxjZhBTBchOq0n@infradead.org>
 <211078952.30654328.1612955843198.JavaMail.zimbra@redhat.com>
 <20210210131557.GB29904@lst.de>
 <BYAPR04MB49650A271CD1C1B3EFA72F3D868D9@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB49650A271CD1C1B3EFA72F3D868D9@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210211_020752_010325_FE3647EE 
X-CRM114-Status: GOOD (  15.34  )
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

On Wed, Feb 10, 2021 at 10:11:15PM +0000, Chaitanya Kulkarni wrote:
> On 2/10/21 5:20 AM, Christoph Hellwig wrote:
> > MDTS vs Write Zeroes is a common misconception.  We had that discussion
> > in the NVMe working group, and while the text should pretty clear that
> > MDTS only applies to data transfers many implementators did not understand
> > that, which is why we added the clarification you quoted.
> >
> > Also the next NVMe spec will allow devices to advertise an explicit
> > Write Zeroes limit, take a look at TP4040 from the "NVM Express 1.4 Ratified
> > TPs" at https://nvmexpress.org/developers/nvme-specification/.
> >
> > So I think limiting to MDTS unless the new WZSL is set might be a fail
> > safe option, even if it is more pessimistic than what the spec says.
> >
> > I'd also love to retest most Write Zeroes quirks with that in place.
> 
> Do you prefer some variant of the following patch (totally untested)? OR
> something else ?

Somwhat.  As said I suspect defaulting to MDTS with a big fat comment
might make most sense unless the new WZSL is set.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
