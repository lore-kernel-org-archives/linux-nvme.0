Return-Path: <SRS0=H+rW=EL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C4AC00A89
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2020 07:32:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CC1A20936
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2020 07:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lZTt5mln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CC1A20936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IHtjNj2p4JwfHpqpoCNYfBZHp6MXcQvte/j/jZTbYVY=; b=lZTt5mlniX195QhorffMrRhW7
	K3TR0oxhZP5cMv0bwn6EmrHCfuc1k0WQ1vB9B0VzmlP4g8Dnv4G0Wdbi+MjnZpyRWneu+T5n+OHom
	k9iPN1qAxh/qC2nbdwpouEQ65w5NV4SmIpRuXmIkbezgHT+0I/tgz2w1FgQAvIoAtP2Yl/nU1kyfq
	aiPX5RC+Rmg1EqomMVbo8qy4JiWA/RXyaDDquwPWcTU0tAflvZXOyLO/1ItVbs6cYiJKwYi7jPYk9
	iSAd2DBpJEbQlnI4bbLJQmbkcVu6GuN0CVWZ+bJKsoFcDcFwmNAuLlTF/LmvXQXjw+udbSj/di5wR
	2ivxXgcWQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kaZlK-0003wt-Te; Thu, 05 Nov 2020 07:32:50 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kaZlI-0003wK-Fx
 for linux-nvme@lists.infradead.org; Thu, 05 Nov 2020 07:32:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id D0C2B68B02; Thu,  5 Nov 2020 08:32:46 +0100 (CET)
Date: Thu, 5 Nov 2020 08:32:46 +0100
From: "hch@lst.de" <hch@lst.de>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH V6 2/5] nvmet: add passthru admin timeout value attr
Message-ID: <20201105073246.GC4540@lst.de>
References: <20201104203736.62745-1-chaitanya.kulkarni@wdc.com>
 <20201104203736.62745-3-chaitanya.kulkarni@wdc.com>
 <6c080198-dd74-4758-e916-9414e24a445a@grimberg.me>
 <BYAPR04MB49655CAAD9809FFC21D5418686EE0@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB49655CAAD9809FFC21D5418686EE0@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201105_023248_666906_B6FDF56F 
X-CRM114-Status: UNSURE (   8.44  )
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
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Nov 05, 2020 at 12:24:41AM +0000, Chaitanya Kulkarni wrote:
> Are you saying that since it is a scaler we can get away without
> 
> locking ? If so I'll send V7 without locking in the configfs.
---end quoted text---

Yes.  Strictly speaking we should probably use WRITE_ONCE and READ_ONCE
for it these days to make the memory model happy, but it has always worked.

Btw, you mailer hasn't properly quoted replies for the past few weeks.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
