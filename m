Return-Path: <SRS0=lFsX=ZM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9157C432C0
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Nov 2019 06:36:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B93A2245B
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Nov 2019 06:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LsYES3Rq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DX9Ynnnt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B93A2245B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=THvFQpd1zIRm3SD8Vv2JkRhRGX5hE6YhDUsd5h4QzHk=; b=LsYES3RqMeQJNc
	kG2zEcIi5dOdPVYFpyD/9I24qwVz2NGjkiBV9NUACLVL49b4Zu4rNckNIcRGiR1rvbDGWOWmf//D3
	E6w8X4KCumrbEDHo4gwpkCCKL5bzJuthRkoPXj34UQP3oc8asoQ8giFGEtDD7C1fxpNe/69XJfrtj
	oQXjggYhX816ltjAWM2hHCO6IPq4zFhUQgRpk2/dHma7rA2PH1ajZCrVnj5NOu1XPxNXEe+rAwCt1
	LI404EoDICQaWqEfKFjCd4NvpgOvQMNthZl8xQuB26nfGP9IGYxxuTsglwNyW7ukH04cOToaafPCm
	y4s5uFMgzzYMDDB310Jg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iXJb4-0001Ev-HB; Wed, 20 Nov 2019 06:36:14 +0000
Received: from us-smtp-2.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iXJb0-0001Dt-CS
 for linux-nvme@lists.infradead.org; Wed, 20 Nov 2019 06:36:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574231766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hsXkh/VQI3KB8Zl4hHKe473v7riRmv/Z4J6X27T5pmM=;
 b=DX9Ynnnt5jNbSXhVp9n/0A0UBNmBG64yJNW+NDNjLxKPX4mYgH51IcaWQKcgisyx/LNmHX
 aKqIYYn20QOn6oIV9YIJN2M8KAJRo/aCHFtruWs1QgmwewFK4cLKyfB0RmHfVK40oHUCqb
 tfknsXgsvF64Fy8n3xg/NNuz0nW1Oug=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-TZ6SJJfHPPCktfDD586oLw-1; Wed, 20 Nov 2019 01:36:04 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60D021005500;
 Wed, 20 Nov 2019 06:36:02 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 78B055C1B2;
 Wed, 20 Nov 2019 06:35:55 +0000 (UTC)
Date: Wed, 20 Nov 2019 14:35:50 +0800
From: Ming Lei <ming.lei@redhat.com>
To: James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH RFC 0/3] blk-mq/nvme: use blk_mq_alloc_request() for
 NVMe's connect request
Message-ID: <20191120063550.GA3664@ming.t460p>
References: <20191115104238.15107-1-ming.lei@redhat.com>
 <8f4402a0-967d-f12d-2f1a-949e1dda017c@grimberg.me>
 <20191116071754.GB18194@ming.t460p>
 <016afdbc-9c63-4193-e64b-aad91ba5fcc1@grimberg.me>
 <fda43a50-a484-dde7-84a1-94ccf9346bdd@broadcom.com>
MIME-Version: 1.0
In-Reply-To: <fda43a50-a484-dde7-84a1-94ccf9346bdd@broadcom.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: TZ6SJJfHPPCktfDD586oLw-1
X-Mimecast-Spam-Score: 0
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191119_223610_507755_23B8CD96 
X-CRM114-Status: GOOD (  17.14  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Nov 19, 2019 at 09:56:45AM -0800, James Smart wrote:
> On 11/18/2019 4:05 PM, Sagi Grimberg wrote:
> > =

> > This is a much simpler fix that does not create this churn local to
> > every driver. Also, I don't like the assumptions about tag reservations
> > that the drivers is taking locally (that the connect will have tag 0
> > for example). All this makes this look like a hack.
> =

> Agree with Sagi on this last statement. When I reviewed the patch, it was
> very non-intuitive. Why dependency on tag 0, why a queue number squirrell=
ed
> away on this one request only. Why change the initialization (queue point=
er)
> on this one specific request from its hctx and so on. For someone without
> the history, ugly.
> =

> > =

> > I'm starting to think we maybe need to get the connect out of the block
> > layer execution if its such a big problem... Its a real shame if that is
> > the case...
> =

> Yep. This is starting to be another case of perhaps I should be changing
> nvme-fc's blk-mq hctx to nvme queue relationship in a different manner.=
=A0 I'm
> having a very hard time with all the queue resources today's policy is
> wasting on targets.

Wrt. the above two points, I believe both are not an issue at all by
this driver specific approach, see my comment:

https://lore.kernel.org/linux-block/fda43a50-a484-dde7-84a1-94ccf9346bdd@br=
oadcom.com/T/#mb72afa6ed93bc852ca266779977634cf6214b329


Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
