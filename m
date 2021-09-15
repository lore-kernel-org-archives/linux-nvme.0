Return-Path: <SRS0=dHSS=OF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2887CC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Sep 2021 13:47:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF46760FC0
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Sep 2021 13:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BF46760FC0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BqL3T36W9CPTJlWMZq3s4BJyrRem/unE3/xnXBxOHxg=; b=f9D4TgNOBC6Xzk
	+MxH6Ob02xQ/DhSpT4HqP4x6pGU/41vvEXPd9WybFUfHqdH8+eER4rPxh0SE862FAHzuG/jzeh2w+
	VNT0v27tHQPqUxSHvWQ9awmnZlB7qv9JJn1FQqOQHZP5VnADefryKrGLlyGl/kBdKFdFBClrDwnaV
	fG65honFwbCykLR9ySJ4yfKqGZ/qNAeF0Cj4x7inm1CqEFtuuKOMeV4x8Z9uqcdQj7Vufbt7fh0er
	N2WQJDu08b4XiWKFqCYHxc/ojMbbYSXhhESUf5P4RgRH4qzXPq18TSSLaGXfaCuwEd1TooA7puNQZ
	wkaKsLKyn/iFv+Y247Ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQVG4-009Dh4-5N; Wed, 15 Sep 2021 13:47:28 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQVG1-009Dge-Dk
 for linux-nvme@lists.infradead.org; Wed, 15 Sep 2021 13:47:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2CC1F67357; Wed, 15 Sep 2021 15:47:19 +0200 (CEST)
Date: Wed, 15 Sep 2021 15:47:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Damien Le Moal <Damien.LeMoal@wdc.com>, Christoph Hellwig <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "anton.eidelman@gmail.com" <anton.eidelman@gmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: keep ctrl->namespaces ordered
Message-ID: <20210915134718.GA14571@lst.de>
References: <20210915072006.956307-1-hch@lst.de>
 <DM6PR04MB708140E359AE0511803F1346E7DB9@DM6PR04MB7081.namprd04.prod.outlook.com>
 <20210915123735.GB3778445@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210915123735.GB3778445@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210915_064725_661489_50E7B92B 
X-CRM114-Status: GOOD (  20.15  )
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

On Wed, Sep 15, 2021 at 05:37:35AM -0700, Keith Busch wrote:
> On Wed, Sep 15, 2021 at 07:36:04AM +0000, Damien Le Moal wrote:
> > > +static void nvme_ns_add_to_ctrl_list(struct nvme_ns *ns)
> > > +{
> > > +	struct nvme_ns *tmp;
> > > +
> > > +	list_for_each_entry_reverse(tmp, &ns->ctrl->namespaces, list) {
> > > +		if (tmp->head->ns_id < ns->head->ns_id) {
> > > +			list_add(&tmp->list, &ns->ctrl->namespaces);
> > > +			return;
> > > +		}
> > > +	}
> > > +
> > > +	list_add_tail(&ns->list, &ns->ctrl->namespaces);
> > 
> > I wonder if it is worth checking that ns->head->id is not equal to the ID of the
> > first NS in the list. That can only happen for a very buggy system or device,
> > but that is not unheard of...
> 
> We would never be able to hit the condition of two heads with matching
> NSID's. If the controller was broken and provided duplicate NSIDs in the
> namespace list, this driver will just recheck the first namespace rather
> than allocate a new one.

Indeed.  So back to v1 for review then.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
