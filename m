Return-Path: <SRS0=Nwsb=7A=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FE4C433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2020 17:03:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA02D20758
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2020 17:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dnpCzaXM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ArCwzYAb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA02D20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=plpxVDlb90KC1c/XGF7npZc5+81JR4MTh+tGDcmp5zk=; b=dnp
	CzaXM/Q0Eo+6f5/TPBxxjTes4gmB/Aqi6jFE8FyNJXRmirWeSuympEqpajt2Gt9gYS7WsvuB2tYtH
	CXFB0mNbwLHNYjZzp3yioMy+fdT7ZLWcbhA/dDGfGlgaa/MCu2pqw8DtssYnJd6B6bxGA3RabBRvG
	aUqz7xrGwmfVj5MeYU3Kh+J8mVm6Oonkrwim3u+yQxHKZxaYvluRrkPspsOleB/5ERxTCA5HKdMW4
	hgs9oOp9dL0bgP0JVVHZE50t/KhR6SrB38jBg1BsqLIRFHaIu7XLUzoMHUL+3ItpYLbem6e6hNhVF
	+76UPirTvmjcBUfUR+fngrOXenGFeRA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jajAZ-000107-AQ; Mon, 18 May 2020 17:03:15 +0000
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jajAV-0000yw-NG
 for linux-nvme@lists.infradead.org; Mon, 18 May 2020 17:03:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589821390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=Zh8qzOYq2qmH5KasgZjhwGOKhyvuPOk/BU8IPTjeq/w=;
 b=ArCwzYAbRF31w/6R67Di/cQPcKLhc5Yhp8U/ZfBMDv2Qxo6LenyUoaFTgbqwY18lib2QZN
 D1EQdlRiI3btFcYcFmZaugkxXHpSu2bmaH1PSaXBNU47lcSnVqYwN6iSURJSmW0Dx1bbp2
 I7v3FsFQ1Av7XFt24KpFSFW6sN03gJI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-UNcwMbF9NXS4EEn24fXfjA-1; Mon, 18 May 2020 13:03:08 -0400
X-MC-Unique: UNcwMbF9NXS4EEn24fXfjA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 275C0835B41;
 Mon, 18 May 2020 17:03:07 +0000 (UTC)
Received: from hpz440.redhat.com (ovpn-112-213.phx2.redhat.com [10.3.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9566B60BE1;
 Mon, 18 May 2020 17:03:06 +0000 (UTC)
From: David Milburn <dmilburn@redhat.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 0/2] nvmet: fixup processing async events
Date: Mon, 18 May 2020 12:03:04 -0500
Message-Id: <1589821386-43424-1-git-send-email-dmilburn@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200518_100311_922465_1BE04A42 
X-CRM114-Status: UNSURE (   5.99  )
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
Cc: hch@infradead.org, chaitanya.kulkarni@wdc.com, dwagner@suse.de
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This patch series changes how async events are processed
and freed based upon review from Christoph Hellwig and
Daniel Wagner, this was discovered while debugging a memory 
leak after clearing connection on the target.


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
