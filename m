Return-Path: <SRS0=6U9w=JQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AF6C433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Apr 2021 07:08:15 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AB916101D
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Apr 2021 07:08:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AB916101D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=k9lMA/qo87H2AgbvjkhiIWyN1l1D+EiOy/0Q/YG+twM=; b=TshP32L7w8H7VNsNdTfYWRK/P
	4FY6JlWR+EjbPEya9nOS1b0VNy29HKfnIlO7Aw8ta0YkO4LkflIe7a5M2pX1fsLFeZ37cfQw1O2Ic
	JkeH1IEJ41Eqmq1sEjea17aJ8JNGnrQayuSAVSCqR7k2nK8V5cxiVLWZR65VFceQDZLUvgDR9Hech
	XKuur8FR+oUORr8qIIgLtXc1hMGX1lNbHVwHeuV1Txg+11K4/X4K8cytfcjLfHixcpfeeXaMcZzUB
	xsnAsv+V2wkjghK/unThaRCVaRC2scCoFqWO0IvwO+ftrcU4qbLhvB3g0AbMbiqoyNKedv61J3kzh
	jC1rZ/Liw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYO0U-009IDa-3M; Mon, 19 Apr 2021 07:07:42 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYO0S-009IDT-Kv
 for linux-nvme@desiato.infradead.org; Mon, 19 Apr 2021 07:07:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=QOUxP/Fb2cvssP/XcvFuBvdrn0JpSzD0nYchQQU9Z6c=; b=4XbkCo8FPYvtIVCCkY9OwQviJ2
 H+RrRvfvGifjrmbCmrsM0EZRWwtLXj5P2iOScgvS9lyjsk8WqurjS7K18xc24LxUj5IxS+OXhpPVE
 1zIO4avz09mSoHnbeg7tFDXfP/IzPCVI4ZWga7G7nDNalj256RknNVKzaleqYzrFA6gM/VJiq/Kzp
 fcjXFkGyEe2cbgXJNf25MQSTAdX9k/A51+44u+arDHB/LZdqPYer7UTeGoCNt/yTXpIK5nkyIdfKx
 2sy6QqXlxWGt/kn+W75lkNCRDjmnlleWjiwr88pUUq3DL8IlJ/0qZJ+0wHPjEhEKBdCXNwRQulvsP
 gVtVUX2g==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYO0Q-00B6Zn-0I
 for linux-nvme@lists.infradead.org; Mon, 19 Apr 2021 07:07:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5567567373; Mon, 19 Apr 2021 09:07:35 +0200 (CEST)
Date: Mon, 19 Apr 2021 09:07:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: cleanup nvme_configure_apst
Message-ID: <20210419070735.GA19499@lst.de>
References: <20210409094524.1920584-1-hch@lst.de>
 <YHCFmClWBxLCX9yN@x1-carbon.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YHCFmClWBxLCX9yN@x1-carbon.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210419_000738_211402_A3760AFA 
X-CRM114-Status: GOOD (  19.61  )
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

Any chance to get a review on this patch?

On Fri, Apr 09, 2021 at 04:49:30PM +0000, Niklas Cassel wrote:
> On Fri, Apr 09, 2021 at 11:45:24AM +0200, Christoph Hellwig wrote:
> > Remove a level of indentation from the main code implementating the table
> > search by using a goto for the APST not supported case.  Also move the
> > main comment above the function.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> 
> (snip)
> 
> >  
> > +done:
> >  	ret = nvme_set_features(ctrl, NVME_FEAT_AUTO_PST, apste,
> >  				table, sizeof(*table), NULL);
> >  	if (ret)
> >  		dev_err(ctrl->device, "failed to set APST feature (%d)\n", ret);
> > -
> >  	kfree(table);
> >  	return ret;
> >  }
> 
> Since your patch includes whitespace cleanup related to apst,
> perhaps you could remove the trailing whitespace after the
> nvme_configure_apst() call (in nvme_init_ctrl_finish()) as well?
> 
> It's the only trailing whitespace that we have in all of core.c,
> and it makes my eyes flinch everytime I see it ;)
> 
> 
> Kind regards,
> Niklas---end quoted text---

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
