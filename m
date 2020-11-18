Return-Path: <SRS0=Qd0E=EY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D188FC5519F
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2020 16:24:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEE0A247BE
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2020 16:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LS7EMMMV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEE0A247BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7VLWdPtUqxeI9A8F//G8P29QX8Ei00LOL5DVe7oOGr8=; b=LS7EMMMVukwgOuMw9RvcCsryb
	2ZNX17qjYw6HU7sYD5rVsACUrWYizezqLlKQtV8zQjqbDSgBSMZfbhhFlMLlMnJueD33MjvYBwJtH
	WdZ+slbh3fzdWuR2eCZxcOXX8DmIrRW34oG6gwwvzot+KbHi3p8rXV5nNFt5EOIhoibodF+7bRtHq
	mDsw6I/1XG3QWaH9meSTauMxO3wj0aXXY2WC4orETXvinF4i6NUv6mZjt6sLM0jjuofK0G0M3HugX
	anSn5px0CX1SkfPx35LWQdznS5fS1qRd11b/scLNZ1xhW+PG29kBSyJ/Tqhv5RiHzv+gbaZ8fl2vS
	EibPxiFRA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kfQFr-000262-Br; Wed, 18 Nov 2020 16:24:23 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kfQFo-00025c-On
 for linux-nvme@lists.infradead.org; Wed, 18 Nov 2020 16:24:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 08F6068B05; Wed, 18 Nov 2020 17:24:15 +0100 (CET)
Date: Wed, 18 Nov 2020 17:24:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Martin George <martinus.gpy@gmail.com>
Subject: Re: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
Message-ID: <20201118162415.GA16753@lst.de>
References: <20201118114859.7985-1-marting@netapp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201118114859.7985-1-marting@netapp.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201118_112420_932003_2EDBF97E 
X-CRM114-Status: GOOD (  10.88  )
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
Cc: kbusch@kernel.org, Martin George <marting@netapp.com>, hch@lst.de,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Nov 18, 2020 at 05:18:59PM +0530, Martin George wrote:
> From: Martin George <marting@netapp.com>
> 
> The current nvme rescan triggered in response to a NS Attr Changed
> AEN, fails to add a namespace if belonging to a new ANA group. This
> is because ana_log_buf->ngrps is not updated in nvme_parse_ana_log(),
> due to which it is unable to locate the new ANA group's descriptor,
> eventually resulting in the failure to add the namespace during the
> rescan. Fix this by reading the ANA log page as part of ana_work so
> that ngrps gets updated, prior to invoking nvme_queue_scan().

How can the namespace reference an ANA group that we haven't been
notified about using the NVME_AEN_CFG_ANA_CHANGE AEN before?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
