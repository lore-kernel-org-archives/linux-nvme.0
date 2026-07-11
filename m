Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E911EC43458
	for <linux-nvme@archiver.kernel.org>; Sat, 11 Jul 2026 07:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Yq9ugPgqSi+vvCA2JUOrVgCq0uNPuvnlAUK0ndk5THo=; b=XT0yDFUZBPoxYflkIDXjXSh87A
	WSVJdPZSE+Jckg1345FoUlV/H02j8RhZ9B3zCc92hjun/bC90CHcOkW02frVGI7Ktj7Og4s8LtTjQ
	4uu0uX3OZ50WhE07kQHMk74+XS/PG4GAgbD2ndFkN2y+tMPw3Wa5iBszNKEi8AYnJTxREqqZ7CSc7
	stQMjP+SXPpb8oRIUDEEBqtN6ozxPD/P4czU4zKSh6ROxMxoIribJIs7vJIErOP4K6PRUXm/rvOKu
	R3yPVkuHY+6c5hGVOTwnshBPCyc5Er/NS/ZuMcdYnx6mZO0279DXSreoqdZOuPbn0n5nCmCiaeBdq
	c3Qwd27w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiSXF-00000006L2g-2Fg3;
	Sat, 11 Jul 2026 07:54:05 +0000
Received: from sender-op-o17.zoho.eu ([136.143.169.17])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiSX8-00000006L27-1Yyh
	for linux-nvme@lists.infradead.org;
	Sat, 11 Jul 2026 07:54:00 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1783756429; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=XGjAkknBmAke5pGc1MBdG5w2FJOAxojSYgb8KVm4SzSWCVfvTMaBXOENz9IgiXSA6REdPBFzJHgVUs4Ldu+4n0EgC+Jf6hD/CBfcU5p53x7T/XOMcYLOnGLnbQyFxBn5tYaBsles9wy5RSjxPXqyP29u4SToyI6FaMDhUXsk2bo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1783756429; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Yq9ugPgqSi+vvCA2JUOrVgCq0uNPuvnlAUK0ndk5THo=; 
	b=fVFI5v/SEafWpVuKoIW/1r81qOoTGecy5jE8yphTcKYGzK2t3fY7Bg1KfgV92FvbMjfgylkDHyEXC8NBaQlpGGAppBNTNfD5YvJ0AKkOCm5nEckqWguTALKu1u8S4xhdB9Eic8a7W2w2Num/8VjAtP/aqyfn97tk0gkTaSyBB08=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=auditcode.ai;
	spf=pass  smtp.mailfrom=security@auditcode.ai;
	dmarc=pass header.from=<security@auditcode.ai>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783756429;
	s=zmail; d=auditcode.ai; i=security@auditcode.ai;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Yq9ugPgqSi+vvCA2JUOrVgCq0uNPuvnlAUK0ndk5THo=;
	b=CU0fpnAqscKwgEh5QP3XjwHlNryiaLNT+7jzxCdw4jf/CysdDy4WAY4vXxo8g0wv
	8AgsGYg282CLbEVk3puwfhJiPAemexcn+lZbqSK55RpMjhTIyYIb+S+kRUls4RUuWTi
	sQ0giJjguMBDgnvr7ywE+JyZSB1JeJZy/1RW1oGk=
Received: by mx.zoho.eu with SMTPS id 17837564262591023.3003370679169;
	Sat, 11 Jul 2026 09:53:46 +0200 (CEST)
From: Ibrahim Hashimov <security@auditcode.ai>
To: hare@suse.de,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet-auth: fix uninitialized-memory leak in AUTH_RECEIVE
Date: Sat, 11 Jul 2026 09:53:42 +0200
Message-ID: <20260711075342.54787-1-security@auditcode.ai>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260709132520.44160-1-security@auditcode.ai>
References: <20260709132520.44160-1-security@auditcode.ai>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260711_005358_720822_5FC591B6 
X-CRM114-Status: UNSURE (   5.26  )
X-CRM114-Notice: Please train this message.
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

Please disregard this patch -- it duplicates Bryam Vargas's
"nvmet-auth: zero the AUTH_RECEIVE response buffer"
(https://lore.kernel.org/linux-nvme/20260702-b4-disp-127414cf-v1-1-e5395cc0f9ae@proton.me/),
which fixes the same uninitialized-memory leak with the same
kmalloc() -> kzalloc() change and the same Fixes: tag, and already has
Christoph's Reviewed-by. I missed it before sending; sorry for the
noise.

Ibrahim

