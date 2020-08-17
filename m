Return-Path: <SRS0=j3u6=B3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6629EC433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 15:08:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 349A8204EC
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 15:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LXFw20eF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PHGu5Gu+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 349A8204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=U+ookp2s6h72S+lV0lj5XwhM6j3pbwTeZcHbRn21/n0=; b=LXFw20eF9EzIg4LEmS897ZM/D
	rMZDW/PLFIGmpj/g4xZwTP2MICL5g950takgQpeNkjNVH9aYejwm4lbxsPeTqXVJ8yW58DcyAgDAf
	xL5GYc8UWDD5olmZrM+J9rAf3zVZtEQVoYY3SdL4pYRkqHRTNajzuZI4TbNLg9WhJDFmCCCnu6Uvb
	qZD1QaKOVIQet9excFSYYlpjq4t8mjJXae//4eOmN9OLDmar+47XEKs+8QDhaq5v/1fLYYQmwiBTM
	w9aPafunlwaoyYLbaALfDhA28vQ9GbRMrWLUy0wAWaEIVmbjsLQ0MuzdVUbp3fTCK3LV6AJlH5iYd
	Uz9+owzrw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k7gkf-0003Cb-QI; Mon, 17 Aug 2020 15:08:45 +0000
Received: from us-smtp-1.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7gkd-0003C7-Ae
 for linux-nvme@lists.infradead.org; Mon, 17 Aug 2020 15:08:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597676922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1MWubGhbe66rZJCCWsU7x4OPz6g2HOciuySF3H6ONLM=;
 b=PHGu5Gu+1JBkOq5IG0y6h7G29tWUvi2vm7nZZCXOlmN0LWxjpkoBiNer01PjGA2g89CoGF
 ouiOvVcPICTM/r4EKyjXTFD3YTsRSomtubi0u4Ae8HaT/982nOa9qcLf2Hz2LOldWZP7D6
 7T1IE5FiawfSb+ouq3fTdnGB9taNii0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-549-koVJq2pQPz63MtJhhQ1MkQ-1; Mon, 17 Aug 2020 11:08:40 -0400
X-MC-Unique: koVJq2pQPz63MtJhhQ1MkQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF97B425E0;
 Mon, 17 Aug 2020 15:08:37 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B2984614F9;
 Mon, 17 Aug 2020 15:08:37 +0000 (UTC)
Date: Mon, 17 Aug 2020 11:08:36 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/4] nvme: refactor command completion
Message-ID: <20200817150836.GB30005@redhat.com>
References: <20200817081544.837699-1-hch@lst.de>
 <20200817081544.837699-3-hch@lst.de>
MIME-Version: 1.0
In-Reply-To: <20200817081544.837699-3-hch@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=msnitzer@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200817_110843_496838_3EEF1C44 
X-CRM114-Status: GOOD (  14.35  )
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
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Chao Leng <lengchao@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Aug 17 2020 at  4:15am -0400,
Christoph Hellwig <hch@lst.de> wrote:

> Lift all the code to decide the dispostition of a completed command
> from nvme_complete_rq and nvme_failover_req into a new helper, which
> returns an emum of the potential actions.  nvme_complete_rq then
> just switches on those and calls the proper helper for the action.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Great work, really like this. Think it will help keep NVMe error
handling robust and more approachable if some unexplained behaviour
occurs in future.

Reviewed-by: Mike Snitzer <snitzer@redhat.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
