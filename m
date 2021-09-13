Return-Path: <SRS0=T5dq=OD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF9CC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 15:32:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 227856103B
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 15:32:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 227856103B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YMqcBUUcvfl7Eevi5yJdZGDNoXeX3zoksGOYE6Yy8aM=; b=1nS6ODchY/VYnp
	s4COUAjhF2gaEPFpd2OdfdWjkWvd83AILTWwEiAD13it/Gamb3yEOFH5MeJXo1X85RyJPMMSWYrUE
	iArhxDlDq82BEOYOFUM3SXB2hFcu4dV3mUbqoCgwOPpdIVPR+QsGe0qbRpXRt3Kn1tZn+LavViJye
	wA5/lNCEQEln5oIgOH12lh5kzP5wZ2m8xGrGQxIxkY1JyXI8waA0FWIermhKvIWjc2aZK+skvovdq
	Be2IIrts/wU083xY0M3ikRn6TfEcFRCeDET7yPquNB744thisaAJ2+KMz2JEEwRNJsAl7Vgy0KzEd
	52pofIGg9N7v0DNcGyMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mPnwN-002BCp-OH; Mon, 13 Sep 2021 15:32:15 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPnwK-002BBh-2J
 for linux-nvme@lists.infradead.org; Mon, 13 Sep 2021 15:32:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2D35867357; Mon, 13 Sep 2021 17:32:08 +0200 (CEST)
Date: Mon, 13 Sep 2021 17:32:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anton Eidelman <anton.eidelman@gmail.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, axboe@fb.com, Anton Eidelman <anton@lightbitslabs.com>
Subject: Re: [PATCH v2 0/3] nvme/mpath: fix missed namespaces in ana state
 update
Message-ID: <20210913153207.GA4555@lst.de>
References: <20210912185459.13496-4-anton@lightbitslabs.com>
 <20210913153023.70879-1-anton@lightbitslabs.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210913153023.70879-1-anton@lightbitslabs.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210913_083212_304425_F63A2AA7 
X-CRM114-Status: GOOD (  14.76  )
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

On Mon, Sep 13, 2021 at 09:30:20AM -0600, Anton Eidelman wrote:
> Fixed two issues in nvme_update_ana_state() that caused ana_work
> to miss existing namespaces and consequently a failure to update
> the namespace ANA state based on the ANA log page.
> 
> 1) A plain bug: we skipped an nsid in desc->nsids in a certain
>    combination of nsids present and nsids reports in the ANA log,
>    and failed to match this nsid to an existing namespace.
> 2) Unhandled situation when scan_work appended new namespaces to
>    ctrl->namespaces and did not sort the list yet.
>    In such transient state ana_work would fail to match nsids
>    to those new namespaces.
> 
> Both issues potentially caused some namespaces to get stuck
> in an incorrect ANA state, e.g. to never become live.

What are the changes to v1?  That should always go into the cover letter.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
