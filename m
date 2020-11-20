Return-Path: <SRS0=Qryz=E2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450BBC5519F
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2020 09:46:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B526222227
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2020 09:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HFxmhZ8Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B526222227
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vIISqDiv46OzPPdLUA8Pu5fUB6PlCb8sRaWt8w8ZCXY=; b=HFxmhZ8ZjNPp3iHZ+2Fz0RT0p
	zNUPWa/rFFVc7jMcJwOy3n6moBQdvr4Xv8BmbXTeBNkDCkrFp2wX/g/XuhNLySje5dG2R9YTpJNwX
	ku6GyfY5EwPrcj5tP/n63NROXeJrt8k7/4ENMLwvmeevpKmZM0YepyTJGgK9Zj8//s5CTOYdM1v1J
	7FMfaew7VezBDmpCXO9vbONI0TCPFsv1DuXdAVUr8+fgnrX27VGL3df/lBZgBnCOc26gtEk4DCJGo
	5155u3AUvwEEOMcfDiiQsKUhiVey4k6E1uY8tDoYwtQbS9OhdI/x70GwWT19ZFNcn5/scd2DjoQEP
	dyPkJVrYg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kg2zY-00056S-48; Fri, 20 Nov 2020 09:46:08 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kg2zV-00055Q-8L
 for linux-nvme@lists.infradead.org; Fri, 20 Nov 2020 09:46:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id AE66C67373; Fri, 20 Nov 2020 10:46:03 +0100 (CET)
Date: Fri, 20 Nov 2020 10:46:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
Message-ID: <20201120094603.GB25846@lst.de>
References: <20201118114859.7985-1-marting@netapp.com>
 <cc8f2a9b-43cd-7921-ac97-1d1d899748a5@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cc8f2a9b-43cd-7921-ac97-1d1d899748a5@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201120_044605_459442_032FFEB3 
X-CRM114-Status: GOOD (  10.16  )
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
Cc: kbusch@kernel.org, Martin George <marting@netapp.com>,
 Martin George <martinus.gpy@gmail.com>, hch@lst.de,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Nov 18, 2020 at 08:51:30AM -0800, Sagi Grimberg wrote:
>
>> Fix this by reading the ANA log page as part of ana_work so
>> that ngrps gets updated, prior to invoking nvme_queue_scan().
>
> Nothing guarantees ordering here..

Yeah.  My memory is fading, but if we processed all events on the
same workqueue we'd be able to order processing of the ANA AEN that
needs to be sent first with the ns changed one that needs to come
later.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
