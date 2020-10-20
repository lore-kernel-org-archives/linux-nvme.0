Return-Path: <SRS0=uU0g=D3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA63C54FB2
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 13:49:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 526532224F
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 13:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YsQihUlw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F0z9bH/x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 526532224F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FLANFkYEvJ/x5RCDZ6f0RYnWH2wCj85wrHylxSAGj5s=; b=YsQihUlwzu6qwJ+l6kXUeNsonL
	J53pDkaNGksaMQ5n4UcRBWj4fZmoVHyCE99ld3aXs5yC5rdNIWcBXe/JAhlwA+6LWRwtv5B6S79r+
	CIlJFwz6VpdOfFc8lFTUBNe1bOY8Q86dItp5eojs1UvaEHZXgeH6M5YcUK4BhqdA8QXnt0MQAUCWi
	ydCvHjzT6X56LABBAJrBVybRYpQ/GnBYlOqAUUgmAMFD/VUFzrzmMIWU6uzvNB1orn0W4/UMyxSiW
	hXmDewilcg7ewZOahjvg8AGfTrNzEC8Drk+Hfe3g3dIUcu5G9Zm7ZeRTL4aVXIzqxRHtc58kbserL
	qxo44GDA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kUs19-0003Uy-V7; Tue, 20 Oct 2020 13:49:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kUs17-0003Uf-Ku
 for linux-nvme@lists.infradead.org; Tue, 20 Oct 2020 13:49:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603201772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vsJD29LfFzmo5RqW2y8UR/4xGaSNx0w7RtgtMB5dn8s=;
 b=F0z9bH/xgQGvqnBYBuO7ssV+rkf3gWh/zeAKJcOPIfv3cTFgVBNPc/Vz/z7KZPsjlg4yVG
 qirR55HffmJukktHbY476GWo9Cmcoy8nvOQ9TU460JhofcD2ocxa5qvDbToWh3P3oQ878t
 Ds8AH+iokWe51gr4ErtOGgTuFQgxBsU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-TGSnI60EMJOqUqrpoCwpeQ-1; Tue, 20 Oct 2020 09:49:31 -0400
X-MC-Unique: TGSnI60EMJOqUqrpoCwpeQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38611835B92;
 Tue, 20 Oct 2020 13:49:30 +0000 (UTC)
Received: from localhost.redhat.com (ovpn-13-146.pek2.redhat.com
 [10.72.13.146])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D28206EF40;
 Tue, 20 Oct 2020 13:49:28 +0000 (UTC)
From: Han Han <hhan@redhat.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH libnvme 0/2] Two fixes for the rpmbuild spec
Date: Tue, 20 Oct 2020 21:49:19 +0800
Message-Id: <20201020134921.270042-1-hhan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201020_094933_881077_BD9561B3 
X-CRM114-Status: UNSURE (   9.43  )
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
Cc: kbusch@kernel.org, Han Han <hhan@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Han Han (2):
  spec: Use the correct url of libnvme
  spec: Fix the sub-include dir name to nvme

 libnvme.spec | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
