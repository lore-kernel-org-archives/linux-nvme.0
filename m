Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1214F606A31C
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2026 18:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=cHZumnPh;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RnbOb5T4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=YRBjyPu84lp4cqJfHOslyQe74Trku2U25uT6q/9g5go=; b=cHZumnPhRf8OuoHLED6JMfXMJ2
	GrcbvBh4+1dtjXPp6LO9DWDpTYhlFYau9my9+r6Ls+0Lr67Ucb0tHk7+03gc/Q1CCp4bMV70bBX6N
	N113VW1uQnEZ1NeChOgUjCP0KTFWOP7zOnmt4nwAffCN3yZBEyLk1Bv6bxWQqAISHeKdfVgXd57oJ
	0LzeNbH7L+9zMBcovIGxEJCMCO9xdfJJDSGjviAtxLfEhdXLmgkT1aqmwX/spUQ/24LuCWsCbtb6O
	vcUvfLMGyxiUO9Lgiz7RJpFCzIn8tZJtGXGoFNeFyCFaASPaVa46LVQtpSsvCni2A3iuzllrfpjX4
	Gl7TJ09w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRZq6-0000000AtCf-0Wvh;
	Thu, 12 Nov 2026 18:48:02 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRZq0-0000000AtCI-3zds
	for linux-nvme@lists.infradead.org;
	Thu, 12 Nov 2026 18:48:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794509275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=YRBjyPu84lp4cqJfHOslyQe74Trku2U25uT6q/9g5go=;
	b=RnbOb5T4/CuubU/x423vdt1Pl161LcOAQ8d3jb9OL3S9JD8GsxjmoAYF/L50ObqJYyB9xm
	7ErR62oyArghltYsSAB4PqProca3TxomPy//xx0k8KgVxlSd+vAQ7S1LDmjUU6HERUIvwU
	Mc9/S/XijghSiX1+/XVpz68L7iampyE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-1YgoFJy4Pg-qdi1JBqujlQ-1; Thu,
 12 Nov 2026 13:46:20 -0500
X-MC-Unique: 1YgoFJy4Pg-qdi1JBqujlQ-1
X-Mimecast-MFC-AGG-ID: 1YgoFJy4Pg-qdi1JBqujlQ_1794509179
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 307D618004DA;
	Thu, 12 Nov 2026 18:46:19 +0000 (UTC)
Received: from cleech-thinkpadt14sgen2i.rmtusor.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 12B3B1956087;
	Thu, 12 Nov 2026 18:46:17 +0000 (UTC)
Date: Thu, 12 Nov 2026 10:46:16 -0800
From: Chris Leech <cleech@redhat.com>
To: linux-nvme@lists.infradead.org
Cc: Surabhi Gogte <sgogte@purestorage.com>, 
	Hannes Reinecke <hare@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: nvme-tls failing with (61b0ed3be81b6) nvme-tcp: parallelize I/O
 queue allocation and startup
Message-ID: <20261112-9505880f2c33f0134ef20c39@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Yp3pE-CTxRR16L0B1J5Z7-hmm3VGNwPwIvcwtLrrgVk_1794509179
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261112_104757_162591_0B9EA43A 
X-CRM114-Status: UNSURE (   6.25  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.8 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

I was testing some patchs and ran into trouble with nvme-tls that I
bisected back to this change (61b0ed3be81b6 nvme-tcp: parallelize I/O
queue allocation and startup).

I haven't determined what exactly is happening yet, but blktests
nvme/062 and nvme/063 both fail with this applied and pass again if I
revert it.

- Chris


