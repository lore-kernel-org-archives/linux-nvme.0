Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78691C83F1A
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jul 2025 02:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Ma+XubITUws4CjwLU3PupcZ0ggOxF9fPfX9v27IM2ZI=; b=iRHTINoZfgCCQaiau+phZ1bHKI
	NXelXOsVQ8pEa+E0Ca2FBTooQCFJg6sfHhFWv5kEHXSCURoFiP7zE0pDq0rhSKd5LfXcZDPFznGEn
	cLk/nwdlTl2egpSIHP6vG7Zc5n9mNUh6e7iqpSFGPqwHHX+8CBH0ttFHc3UKM9Rti9EVOR1E1z77G
	bCnEuTLbmsJVoNzJi//Lq9cOqFnBXSTfpDVOrwa7jo/PeB2o0fEbotv6JXivcs9SuuSHzalGDCQ+w
	mTvDR1TyYV5YbyqEEuzee8Ou2rphFPEpIsE9GEZddhYE2sqS8euSmizWsjPwrnGAotibcFFRWbbMC
	yF1NbryA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udg8L-0000000FyT7-2KnD;
	Mon, 21 Jul 2025 02:20:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udg8J-0000000FySJ-3Ni5
	for linux-nvme@lists.infradead.org;
	Mon, 21 Jul 2025 02:20:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753064403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ma+XubITUws4CjwLU3PupcZ0ggOxF9fPfX9v27IM2ZI=;
	b=VbQ/5vYjKBasBBxeDNjNUDUM9dxoU05Xhmhp4XyCfui3qhC0dDfvwBm+Uq6DbfrQbCBEq2
	e7YGiBbrFrUdFOJp+wrYyBuM3fkaY81Qc6j69txDF0IqgesMJzEVqzjjhk3kkI7wemdP45
	0tVjO1c2x5NSswl67EerqCfdVVRmATk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-DlMFTJ2SM5i8GC_pzvC45w-1; Sun,
 20 Jul 2025 22:17:35 -0400
X-MC-Unique: DlMFTJ2SM5i8GC_pzvC45w-1
X-Mimecast-MFC-AGG-ID: DlMFTJ2SM5i8GC_pzvC45w_1753064254
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C535F180028E;
	Mon, 21 Jul 2025 02:17:33 +0000 (UTC)
Received: from cleech-thinkpadt14sgen2i.rmtusor.csb (unknown [10.2.16.27])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2686B30001B9;
	Mon, 21 Jul 2025 02:17:31 +0000 (UTC)
From: Chris Leech <cleech@redhat.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>,
	Prashanth Nayak <prashanth.nayak@netapp.com>,
	John Meneghini <jmeneghi@redhat.com>
Subject: [PATCH 0/1] NVMe/TLS connection issues to SPDK
Date: Sun, 20 Jul 2025 19:17:17 -0700
Message-ID: <20250721021718.1159879-1-cleech@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VzqQq3IvXHUfDd8AgnWTUAfkWISc6TpOvZ6nCBXHPP0_1753064254
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250720_192003_923799_C48847A3 
X-CRM114-Status: GOOD (  12.81  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I was attempting to debug connecting the Linux driver / libnvme /
ktls-utils host stack to the SPDK nvmf_tgt over TLS, and ran into some
issues.

The TLS connection fails to complete a handshake because the TLS PSKs
are different. The NVMe/TCP specified key derivation steps from the
configured interchange format, to a retained PSK and finally the TLS
PSK, is implemented incompatibly in libnvme and SPDK.  After some
investigation, I believe the SPDK implementation to be correct and am
providing a libnvme patch to match it. With libnvme modified, I see the
TLS handshake complete in tlshd.

(Note that this was tested using the obsolete "version 0" PSK Identity
and TLS PSK derivation from the TCP transport 1.0 specification, as SPDK
has not been updated with the "version 1" changes)

The NVMe/TCP host driver then quickly fails when SPDK sends a TLS "New
Session Ticket" message before ICResp.

While possibly pointless due to the transport specification prohibition
on session resumption and 0-RTT data, I don't think this is necessarily
wrong and the host driver should be able to safely ignore it and
continue.

I'm working on testing that out, but a more general TLS message demuxing
layer to deal with post-handshake messages other than application data
may be wanted to avoid sprinkling checks around the nvme driver.

Chris Leech (1):
  libnvme: TLS PSK derivation fixes

 src/nvme/linux.c | 86 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 57 insertions(+), 29 deletions(-)

-- 
2.50.1


