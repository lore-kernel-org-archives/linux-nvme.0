Return-Path: <SRS0=tknV=IJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C906C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 17:54:50 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF25164F9C
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 17:54:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF25164F9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=r9lC1NqNtHrWLw+PGXONENR30BtIDuGvSsk4/eWzFjU=; b=jLb5qCtQvRuvURKydcHWOCc0b
	26sBAlT2/leUUA+mkDXutzERWwkIykpSh4stK35l13fB/K/6akZJo5jJIbrspQULneO9o29mjHg4o
	wj9vNvdFaTGEiPW0lHwh6zhoSfJi6C2o8m/7DOnYxadoHJNIyh/lGMBOpPD6ulrrB/hi3rhYUmDRH
	fNgxSXV2vfatn8Cwf9mkL//UP/2DHmjY/BwiZlE/kzT7IHiyi+J2woRrnv7zEqrZu62Fxhqlititr
	ybpnLS9wsRZLEyPuCMtDnX0QeiK6OmuodRATUkYvpVpbZxk35R45lAWseRvnzD7Ap+KHDFDfA79g5
	nLIC2aVKQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKPW4-009mCc-LS; Thu, 11 Mar 2021 17:54:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKPVy-009mC0-Gv
 for linux-nvme@lists.infradead.org; Thu, 11 Mar 2021 17:54:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615485265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IsmeGoTcs2FtwWCXgS0ipFs8J/97oLER5JFDijQ5YaQ=;
 b=ATg2jGTT5Hh8lwb7haNR/J0XhFMI723H82Bq72255VUBxACw5P6fluPCiMeyLf9beBU3XJ
 abJkfaACuViQ85i54Yl6pNuNcuJ893nown1UR2QcrnJFvODnlj+omtBKk3rOrz23O2EUS5
 pONRp+re4dueZw529bW52bmPfQVONd0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-jmhFCp3APNiW4fSZRZN4VA-1; Thu, 11 Mar 2021 12:54:22 -0500
X-MC-Unique: jmhFCp3APNiW4fSZRZN4VA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4CF461015C84
 for <linux-nvme@lists.infradead.org>; Thu, 11 Mar 2021 17:54:21 +0000 (UTC)
Received: from ovpn-113-87.phx2.redhat.com (ovpn-113-87.phx2.redhat.com
 [10.3.113.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0C4971001281
 for <linux-nvme@lists.infradead.org>; Thu, 11 Mar 2021 17:54:20 +0000 (UTC)
Message-ID: <d7238333e74114e053cbeda242863e4a8ebe7d91.camel@redhat.com>
Subject: Re: [PATCHv2] nvme: send uevent once a multipath namespace is
 operational again
From: "Ewan D. Milne" <emilne@redhat.com>
To: linux-nvme@lists.infradead.org
Date: Thu, 11 Mar 2021 12:54:20 -0500
In-Reply-To: <cf86b4b2-47a4-857f-eafa-4e673f1f5c9d@grimberg.me>
References: <20210303121227.65688-1-hare@suse.de>
 <cf86b4b2-47a4-857f-eafa-4e673f1f5c9d@grimberg.me>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=emilne@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210311_175426_711148_535A5989 
X-CRM114-Status: GOOD (  18.93  )
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

On Fri, 2021-03-05 at 13:00 -0800, Sagi Grimberg wrote:
> > In an all paths down scenario I/O will be requeued or aborted, and
> > no
> > further I/O will be ongoing on this namespace.
> > This leaves the upper layers unable to determine if the namespace
> > becomes operational again eg. after a successful controller reset.
> 
> Who is upper-layers here?

While a notification that I/O is unlikely to fail or get queued
waiting for a controller to reconnect does seem like a nice feature,
it seems like without some ability to notify that we have *entered*
the all paths down state, what is userspace supposed to do with a
"it's working now" uevent?

Also, what about the case where there are paths available but they
are all in the ANA INACCESSIBLE state?  Isn't that the same thing from
a user perspective?  This would be a common scenario e.g. when a
storage device has to change the ANA state if a array-side link fails.

-Ewan

> 
> > With this patch a 'change' uevent will be sent per multipathed
> > namespace
> > once the underlying controller moved to LIVE and started I/O
> > processing
> > by calling nvme_kick_requeue_lists().
> > 
> 
> Other than that looks reasonable to me..
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
> 


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
