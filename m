Return-Path: <SRS0=kA4j=JG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B445C433B4
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 05:43:15 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA3BB610CB
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 05:43:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA3BB610CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=uUeLPlB2SHTxkKwKIADaj2Rp5BWu00J3H+fnUJpQABg=; b=I9/pPiuZ/IyVfwaM3chma9vcp
	R21c9mx6rje8V6cR5hFIT6k5RXxqicvH4ctMmDCpbgwfmjeymRgZ2kFzcB3AhFjdn0YiOSUHornQP
	ANPBV5DWsK/Pt3nhoyvNIr4Y0g9hma9hHpd4Do+KKcJKqKmUN/LIBPb9HsRNxMUY3vFG9DEEkFuWt
	kXcGGj4GOFe4EYbklDz5AZ0RJONSxkNBK/nxF8kn9fINgNOkYBcAIcdYoqnXT5d/FwLBUfSpWyeH1
	AEkIEYj9Vyr+slkIlMHztxd+FK3qBy0NsBNZIus2h3kRjWzpwNfwcyW4coFzdzzrnm6GqrQoxhyzN
	JNmSDM3Mg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUjv2-00ABD9-6A; Fri, 09 Apr 2021 05:43:01 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUjt0-00AAqg-HL
 for linux-nvme@lists.infradead.org; Fri, 09 Apr 2021 05:41:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 830B168BEB; Fri,  9 Apr 2021 07:40:53 +0200 (CEST)
Date: Fri, 9 Apr 2021 07:40:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH V13 2/4] nvmet: add ZBD over ZNS backend support
Message-ID: <20210409054053.GA2783@lst.de>
References: <20210408001427.20501-1-chaitanya.kulkarni@wdc.com>
 <20210408001427.20501-3-chaitanya.kulkarni@wdc.com>
 <20210408072337.GB24502@lst.de>
 <BYAPR04MB496576AC2F66933D9509A22286749@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB496576AC2F66933D9509A22286749@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210409_064134_851679_3DF97D61 
X-CRM114-Status: GOOD (  16.33  )
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

On Thu, Apr 08, 2021 at 09:14:24PM +0000, Chaitanya Kulkarni wrote:
> >> +	if (rz->zrasf == NVME_ZRASF_ZONE_REPORT_ALL)
> >> +		goto record_zone;
> >> +
> >> +	/*
> >> +	 * Make sure this zone condition's value is mapped to NVMe ZNS zone
> >> +	 * condition value.
> >> +	 */
> >> +	if (z->cond > ARRAY_SIZE(blk_zcond_to_nvme_zstate) ||
> >> +	    !blk_zcond_to_nvme_zstate[z->cond])
> >> +		return -EINVAL;
> >> +
> >> +	/* filter zone by condition */
> >> +	if (blk_zcond_to_nvme_zstate[z->cond] != rz->zrasf)
> >> +		return 0;
> >> +
> >> +record_zone:
> > While not bad per se I ind the structure a little odd.  I'd move the
> > checks into a level of indentation instead.
> >
> 
> Can you please elaborate on this ?

If we have a condition that limits a query having that inside the
conditional just flows much easier than a goto that jumps over the
checks.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
