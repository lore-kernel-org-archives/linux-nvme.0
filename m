Return-Path: <SRS0=3azT=MH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_ADSP_ALL,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14081C07E96
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Jul 2021 14:22:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD8F061380
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Jul 2021 14:22:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD8F061380
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=natalenko.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gepWsxUbi+dgeLoNaL5if/9nMJkHUx9n1Z/J+R7lhxI=; b=yMjF8qOFifu91j
	DU6/Umt+weIE8dxgEW5Or60qBfuBwMXvxnpcSZbA9++RAOGkki/mCGVo/4YaihoqCiHVIs+/rxciY
	l/dPl/n7kVl+Ns3qM9nEPUnDr7VL3vRWYNmt0jzRewyhBlFfuzkjzb+bevR9h3+hW94DJkyUxfPfi
	mt5K3gU94YWUrLG+qH1Sb8KOs/zgH7Rqf4jDM/5v+tpdG4YdetHd7FcwXXOdlZgiNbaG5W/IMJpxi
	4zYp+svxTuiaD2OnEUSupSzuuGxxVzhWtuIlfdOqp7PMyYXIJ+CWzKQempsTlzu0FymYEU57bU53X
	ivv9ZZFYcyjPmbVJUwkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m42FH-0014iz-TB; Thu, 15 Jul 2021 14:21:47 +0000
Received: from vulcan.natalenko.name ([2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1m42FE-0014hc-AT
 for linux-nvme@lists.infradead.org; Thu, 15 Jul 2021 14:21:45 +0000
Received: from spock.localnet (unknown [151.237.229.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by vulcan.natalenko.name (Postfix) with ESMTPSA id D8687B35AC9;
 Thu, 15 Jul 2021 16:21:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
 s=dkim-20170712; t=1626358901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LlgiOkZHXNEIEfSaNUhKVoHJLJHo0vEdnYWGRcJTLVg=;
 b=atQl93tNGGkJYXUalUq6dTShLQ02fCz+2Uz1rMv8IgGbVFofErY+X5nMClLN1Ak2PztfIu
 p5sdaqx5L+xSCGGx63OwdmG0o4VpU8CSvnkxdB1U+XE2uNOJAWzgUZwaCV9vHq9LqBuiI3
 TU5E0lilVrBCarvau3atvWe37ot+oQ0=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, David Jeffery <djeffery@redhat.com>,
 Ming Lei <ming.lei@redhat.com>, Laurence Oberman <loberman@redhat.com>,
 Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>,
 Sasha Levin <sashal@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: Re: New warning in nvme_setup_discard
Date: Thu, 15 Jul 2021 16:21:39 +0200
Message-ID: <18913178.CfhFyDH87r@natalenko.name>
In-Reply-To: <YPBD8z+yqC0ShjrZ@kroah.com>
References: <4729812.CpyZKHjjVO@natalenko.name> <YPBD8z+yqC0ShjrZ@kroah.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210715_072144_555009_DC772E7A 
X-CRM114-Status: UNSURE (   5.16  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SGVsbG8uCgpPbiDEjXR2cnRlayAxNS4gxI1lcnZlbmNlIDIwMjEgMTY6MTk6MzEgQ0VTVCBHcmVn
IEtyb2FoLUhhcnRtYW4gd3JvdGU6Cj4gQ2FuIHlvdSBydW4gJ2dpdCBiaXNlY3QnIHRvIGZpbmQg
dGhlIG9mZmVuZGluZyBwYXRjaD8KCk9mIGNvdXJzZSwgYXMgc29vbiBhcyBJIHJlcHJvZHVjZSB0
aGlzIHJlbGlhYmx5LgoKVGhhbmtzLgoKLS0gCk9sZWtzYW5kciBOYXRhbGVua28gKHBvc3QtZmFj
dHVtKQoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpM
aW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
