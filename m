Return-Path: <SRS0=W+Vz=CJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1CBC433E2
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 06:17:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57B7F20738
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 06:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0hZesCco"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57B7F20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=a1DipvK7a9OUtXYBT/2O94vUpooNBW1z6YJy1dZIj8o=; b=0hZesCco7/3IyBZxvPyxCjQZ2
	gUQWQFeYyNKQefQ6Xl+TQVHa1+RNcsMKKe3Ld5hNT2/OJYTgWbY/Lu3r8nd/KWsDlMrphFIa5WF7y
	7tchfs7cjBz6ldJhIkx/0dwfkVkei7cuzBvcEdQMwMdRJ4yTNZ+35fuHSZfi0suDkVDa+vFbiX4lc
	EAGTnbYwH9yO+GePArDXLq98iAQLB/txC50O6iPk4gZYIECnxKB63X6ahgvXONKeSG5Irq3pOKBaY
	eoOGsraUqmprsnKFQv9eQrU78CGBPSxYWsJ6ITSX0DyPiXogLaAlgNBLabTyi1mQ91JcTT2EgId6i
	z84+YGbqA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kCd8D-00040V-NP; Mon, 31 Aug 2020 06:17:29 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kCd8A-0003zm-Cg
 for linux-nvme@lists.infradead.org; Mon, 31 Aug 2020 06:17:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9AE8268CEC; Mon, 31 Aug 2020 08:17:20 +0200 (CEST)
Date: Mon, 31 Aug 2020 08:17:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH v2] nvme: fix error handling in nvme_ns_report_zones
Message-ID: <20200831061720.GA27617@lst.de>
References: <20200830100010.1262680-1-hch@lst.de>
 <CY4PR04MB3751C089FDF4DD46B7A8A50FE7510@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CY4PR04MB3751C089FDF4DD46B7A8A50FE7510@CY4PR04MB3751.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200831_021726_585598_770C55B8 
X-CRM114-Status: GOOD (  18.05  )
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
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Aug 31, 2020 at 12:20:43AM +0000, Damien Le Moal wrote:
> On 2020/08/30 19:25, Christoph Hellwig wrote:
> > nvme_submit_sync_cmd can return positive NVMe error codes in addition to
> > the negative Linux error code, which are currently ignored.  Fix this
> > by removing __nvme_ns_report_zones and handling the errors from
> > nvme_submit_sync_cmd in the caller instead of multiplexing the return
> > value and the zone size into a single return value.
> 
> s/zone size/number of zones reported/

Yes.

> > +		c.zmr.slba = cpu_to_le64(nvme_sect_to_lba(ns, sector));
> > +		ret = nvme_submit_sync_cmd(ns->queue, &c, report, buflen);
> > +		if (ret)
> >  			goto out_free;
> 
> Isn't there a problem here ? goto out_free will do "return ret;" and if ret is a
> positive error code, then that value will be interpreted as a number of zones
> reported. ret must be a standard "-Exxx" error code since this is a file method
> and the caller does not expect an NVMe error code.

Yes, we'll need to translate the nvme to a Linux status first.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
