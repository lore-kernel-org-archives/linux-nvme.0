Return-Path: <SRS0=x9Yf=BX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D455AC433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2020 17:47:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C05620781
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2020 17:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mDUGENOh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RHckZJDV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C05620781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2kLYubwQT3WGmmkaNO8hejBI8ZD+WTNxavoXj2z0kyU=; b=mDUGENOhevZKsAGGwWta8nd94
	bQgFSwrPaq4Sr9LKoMa9YrKB1cW10oL4Ydd/PnWbIXvtxlxyGuaTuA1HyQgHxSn+fSHICam1CTlLW
	mea0SMdteVPOKJWOHeJYlFka9Bdvkpm3GinYSXMsYdbWivqQlDNjyJ8EnCFsZxXcAQbF9JrCBUPNB
	hC4tEEeWEw9zwsF6iuoA3blpYBKNm/Yd7qzRIAjTsC1I/2Cxf89Y47dWZakv5csN/n1MRpH+dsz4z
	5DHOetNcuCoRNbVtChhTSSCmCT043zIwx3TfhyGq1Uvol5se1cK8zjcQ6EBBMDGHc4QftzEX3q+EZ
	Qowk/fAbQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6HJu-0005mj-HU; Thu, 13 Aug 2020 17:47:18 +0000
Received: from us-smtp-1.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6HJr-0005m1-Ui
 for linux-nvme@lists.infradead.org; Thu, 13 Aug 2020 17:47:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597340834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f7EgRSuHl/zyEcRjJfLEsNCCNcV6J6Y2HHN1vQdhBKU=;
 b=RHckZJDVRrUby2dOHL6LSJfRhwtFCBXW5x/SqHpGw8FrJ00ApJThZSkO7TA57ca57POlRY
 znoOq1Nu0Xh9+fQN+6JKfY7gYGcZY9jEhux+grmVL7TtM1gISpRj2Vi+7Xg/HUiy5xg4Hc
 mtoiqOqRsy8rp7e+NBCUgQj83+WBTIE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-LFXUej9xNFyCo5sh6W-33A-1; Thu, 13 Aug 2020 13:47:09 -0400
X-MC-Unique: LFXUej9xNFyCo5sh6W-33A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 212878712FE;
 Thu, 13 Aug 2020 17:47:08 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E702B600D4;
 Thu, 13 Aug 2020 17:47:04 +0000 (UTC)
Date: Thu, 13 Aug 2020 13:47:04 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RESEND PATCH] nvme: explicitly use normal NVMe error handling
 when appropriate
Message-ID: <20200813174704.GA6137@redhat.com>
References: <20200806191943.GA27868@redhat.com>
 <6B826235-C504-4621-B8F7-34475B200979@netapp.com>
 <20200807000755.GA28957@redhat.com>
 <510f5aff-0437-b1ce-f7ab-c812edbea880@grimberg.me>
 <20200807045015.GA29737@redhat.com>
 <fec745aa-0091-ee1f-cb0f-da9e18cf0aa2@grimberg.me>
 <20200810143620.GA19127@redhat.com>
 <20200810172209.GA19535@redhat.com>
 <20200813144811.GA5452@redhat.com>
 <20200813153623.GA30905@infradead.org>
MIME-Version: 1.0
In-Reply-To: <20200813153623.GA30905@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=msnitzer@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200813_134716_048440_B6F5696A 
X-CRM114-Status: GOOD (  19.28  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Ewan Milne <emilne@redhat.com>,
 dm-devel@redhat.com, linux-nvme@lists.infradead.org,
 Chao Leng <lengchao@huawei.com>, Keith Busch <kbusch@kernel.org>, "Meneghini,
 John" <John.Meneghini@netapp.com>, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Aug 13 2020 at 11:36am -0400,
Christoph Hellwig <hch@infradead.org> wrote:

> On Thu, Aug 13, 2020 at 10:48:11AM -0400, Mike Snitzer wrote:
> > Commit 764e9332098c0 ("nvme-multipath: do not reset on unknown
> > status"), among other things, fixed NVME_SC_CMD_INTERRUPTED error
> > handling by changing multipathing's nvme_failover_req() to short-circuit
> > path failover and then fallback to NVMe's normal error handling (which
> > takes care of NVME_SC_CMD_INTERRUPTED).
> > 
> > This detour through native NVMe multipathing code is unwelcome because
> > it prevents NVMe core from handling NVME_SC_CMD_INTERRUPTED independent
> > of any multipathing concerns.
> > 
> > Introduce nvme_status_needs_local_error_handling() to prioritize
> > non-failover retry, when appropriate, in terms of normal NVMe error
> > handling.  nvme_status_needs_local_error_handling() will naturely evolve
> > to include handling of any other errors that normal error handling must
> > be used for.
> > 
> > nvme_failover_req()'s ability to fallback to normal NVMe error handling
> > has been preserved because it may be useful for future NVME_SC that
> > nvme_status_needs_local_error_handling() hasn't been trained for yet.
> > 
> > Signed-off-by: Mike Snitzer <snitzer@redhat.com>
> 
> I don't see how this would change anything.  nvme_failover_req simply
> retuns false for NVME_SC_CMD_INTERRUPTED, so your change is a no-op.

This is just a tweak to improve the high-level fault tree of core NVMe
error handling.  No functional change, but for such basic errors,
avoiding entering nvme_failover_req is meaningful on a code flow level.
Makes code to handle errors that need local retry clearer by being more
structured, less circuitous.

Allows NVMe core's handling of such errors to be more explicit and live
in core.c rather than multipath.c -- so things like ACRE handling can be
made explicitly part of core and not nested under nvme_failover_req's
relatively obscure failsafe that returns false for anything it doesn't
care about.

Mike


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
