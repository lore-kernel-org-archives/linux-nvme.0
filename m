Return-Path: <SRS0=B5n5=C6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3F2C4363C
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2020 19:25:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D67D216C4
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2020 19:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hnc9n1mn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D67D216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ydyIfN8MhlCfX4oegGHwL7eQWFJ7FUJ2IGpD2nUGcxw=; b=hnc9n1mnXkHT/HB9R07Mjh531
	amsqHcBHwNNlONdABh55f7kJJsqcRTLYCbdgv1ZKr26Y0Dfqopok84JTlcYUSua3QR6pxesVNDgpn
	1R9qRXziAQw/x/9+SDsdbzjCTtd7BOxkViTAnNpqvKixac8dKs+Ak0w0StPutIQplcImaD+RJhy2s
	KtTeJK8rt6nmHLaDQmDXFlOdUvjWrMvHEfhAvSLOeXEHqf88E1fkuWFGPJUbcR56BZZWXYNTWM/+9
	Fr0D4rhVWn8lJdBRP3qNOzM3UnA7XtwhJK+y9jhCHet+yVTJ5t2cqcYxFQdMgxwMZqmh7dboE77kB
	j0N8OpcHQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kKRRH-00011l-5N; Mon, 21 Sep 2020 19:25:27 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKRRE-00011C-P2
 for linux-nvme@lists.infradead.org; Mon, 21 Sep 2020 19:25:25 +0000
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94) (envelope-from <johannes@sipsolutions.net>)
 id 1kKRRA-008OT5-6V; Mon, 21 Sep 2020 21:25:20 +0200
Message-ID: <f3b8ef76decf5b3204463f8a2267ba456562f691.camel@sipsolutions.net>
Subject: Re: [PATCH 0/3] [backport] nvme: Consolidate chunk_sectors settings
From: Johannes Berg <johannes@sipsolutions.net>
To: Revanth Rajashekar <revanth.rajashekar@intel.com>, 
 linux-nvme@lists.infradead.org, hch@lst.de
Date: Mon, 21 Sep 2020 21:25:08 +0200
In-Reply-To: <20200921184728.11291-1-revanth.rajashekar@intel.com>
 (sfid-20200921_204456_447027_687C7A95)
References: <20200921184728.11291-1-revanth.rajashekar@intel.com>
 (sfid-20200921_204456_447027_687C7A95)
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200921_152524_824016_189CB165 
X-CRM114-Status: UNSURE (   8.89  )
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
Cc: kbusch@kernel.org, damien.lemoal@wdc.com, backports@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, 2020-09-21 at 12:47 -0600, Revanth Rajashekar wrote:
> Backport commit 38adf94e166e3cb4eb89683458ca578051e8218d and it's
> dependencies to linux-stable 5.4.y.
> 

backports@vger.kernel.org isn't for backporting kernel patches...

I guess you want to CC stable if they need to pick up any of this, or
perhaps something else, but almost certainly not backports@.

johannes


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
