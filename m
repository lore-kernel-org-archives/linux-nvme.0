Return-Path: <SRS0=T5dq=OD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87434C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 16:11:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5111260F58
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 16:11:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5111260F58
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4HftXC3MIpvObaq8y1Xgj1bSDpIUVq5ceSWeGWtvnEY=; b=Atv9Mq5miTuGBn
	cSfm+L1NfsavxhVD0yEOlpjcM63ezvJfqgVFOKUn2or6oEr1J/lRohTmJAWVqGQ02CbpVHDT/1tyL
	lv/PfqWjweOd+TGD1DuG8sNDKz8ZCyQ17c0+ie+9UI6tnZd6yaRryww6wn8m/pYjDEPHiOl+xqvJZ
	HN4AKS0adTjbrHqvT3bwJa6XQrsKP7SD1f8By3V/ZrT0n+Qc6FmjgCUJjr0/akBtklRvNJQnyHu5C
	RNVFEp2vZNVeFh61ULjX8EYp5OmTKTkfjIe3UkqajSQgLTdz6CdbeDtmSLYMTj1XVnoWpcuQWh0FP
	P//MJZDbyZZoSJ8LIkYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mPoY2-002IzM-RL; Mon, 13 Sep 2021 16:11:10 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPoXz-002Iyj-Pw
 for linux-nvme@lists.infradead.org; Mon, 13 Sep 2021 16:11:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id DEFC467357; Mon, 13 Sep 2021 18:11:04 +0200 (CEST)
Date: Mon, 13 Sep 2021 18:11:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Anton Eidelman <anton.eidelman@gmail.com>,
 linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
 axboe@fb.com, Anton Eidelman <anton@lightbitslabs.com>
Subject: Re: [PATCH v2 3/3] nvme/multipath: fix stale ana state for
 namespaces just added by scan work
Message-ID: <20210913161104.GA7634@lst.de>
References: <20210912185459.13496-4-anton@lightbitslabs.com>
 <20210913153023.70879-1-anton@lightbitslabs.com>
 <20210913153023.70879-4-anton@lightbitslabs.com>
 <20210913160756.GB3283786@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210913160756.GB3283786@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210913_091108_027534_A1C3CD2D 
X-CRM114-Status: GOOD (  12.27  )
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

On Mon, Sep 13, 2021 at 09:07:56AM -0700, Keith Busch wrote:
> I guess this works for the structures we have in place, but I think we
> should replace the sorted list and with xarray. Then you can get
> something simpler to follow like:

I guess that's fine for the short term.  It mean we'll have to walk
the list for every namespace in the decriptor, but I've not actually
seen deployments with crazy numbers of namespaces yet.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
