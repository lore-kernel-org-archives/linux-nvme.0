Return-Path: <SRS0=k+Rq=MI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_ADSP_ALL,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C8DC12002
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Jul 2021 05:53:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2AFF613E9
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Jul 2021 05:53:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2AFF613E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=natalenko.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yj0HWLAwKsh1tMaMzQT859FBlUeJm6aGWN8r2bprqXM=; b=Q7BF+idFD6MWQ5
	AZx2BODo3y15rNJdDUwJTfguuPDa4DkDTMbkkWSvPcjnBtun89kqu072ghks3xT6lgwHrPf2Jocpb
	oYU6AsZgod2fDHH5IPFActd8PPmIv/VxlYWNMtI73pAYZ48JueN8eWKI8mCb1+HCJU//Jjj6wxXPd
	QncP3L/Tc95dpkvHtBS7cxZ6nPbw1l/KDMN5qEyKG2W4/vg6biVm+4EDuS89lSkx5cvotr0uitVu9
	q9R6LCURUemRTVRXAHB//fqk4xBXgV15HKIUcQ1/M4xxwDpfApLnDGOmvEkq5w0dFdIwTk+ZHdjdG
	P1MY+w2oZqXDSK7Fx4sA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m4Gn1-003HtK-FD; Fri, 16 Jul 2021 05:53:35 +0000
Received: from vulcan.natalenko.name ([104.207.131.136])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m4Gmy-003Hsg-Pe
 for linux-nvme@lists.infradead.org; Fri, 16 Jul 2021 05:53:34 +0000
Received: from spock.localnet (unknown [151.237.229.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by vulcan.natalenko.name (Postfix) with ESMTPSA id 2AF0BB37293;
 Fri, 16 Jul 2021 07:53:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
 s=dkim-20170712; t=1626414811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tld40cpEkGCNsmVNqC9ejnCY9hMvScB5LN5M3UpSOec=;
 b=NcYFQaS95iwX4RFWyB1v+WBBTnfwwBGtEj4uv6HRuluQnEjny4JbKehbhlsBUnLiB//Zkf
 vHU1h2JsFU4FZ3iXqR+I4fxnIrnWLqJ9IGoBjG7dZDrhM4hBaLWCEehKb4F/VKcjlvIIae
 r9kwMgMzBzTGcpqhOWraBJBan88gTz4=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, David Jeffery <djeffery@redhat.com>,
 Laurence Oberman <loberman@redhat.com>,
 Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>,
 Sasha Levin <sashal@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Keith Busch <kbusch@kernel.org>
Subject: Re: New warning in nvme_setup_discard
Date: Fri, 16 Jul 2021 07:53:28 +0200
Message-ID: <81322754.HEIg0oD171@natalenko.name>
In-Reply-To: <YPDr8ucoDCE4NBSe@T590>
References: <4729812.CpyZKHjjVO@natalenko.name> <YPDr8ucoDCE4NBSe@T590>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210715_225333_041184_087692DC 
X-CRM114-Status: UNSURE (   9.08  )
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

SGVsbG8uCgpPbiBww6F0ZWsgMTYuIMSNZXJ2ZW5jZSAyMDIxIDQ6MTY6MTggQ0VTVCBNaW5nIExl
aSB3cm90ZToKPiA+ICA4NTAgICAgIGlmIChXQVJOX09OX09OQ0UobiAhPSBzZWdtZW50cykpIHsK
PiAKPiBXaGF0IGlzICduJyBhbmQgJ3NlZ21lbnRzJz8KClNvLCBJIHVzZWQgdGhpcyBjaGFuZ2Ug
dG8gY2hlY2sgdGhhdDoKCmBgYApkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5j
IGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCmluZGV4IDY2OTczYmI1NjMwNS4uMGE2NGYyZjc3
ZGFmIDEwMDY0NAotLS0gYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKKysrIGIvZHJpdmVycy9u
dm1lL2hvc3QvY29yZS5jCkBAIC04NDcsNyArODQ3LDggQEAgc3RhdGljIGJsa19zdGF0dXNfdCBu
dm1lX3NldHVwX2Rpc2NhcmQoc3RydWN0IG52bWVfbnMgKm5zLCAKc3RydWN0IHJlcXVlc3QgKnJl
cSwKIAkJbisrOwogCX0KIAotCWlmIChXQVJOX09OX09OQ0UobiAhPSBzZWdtZW50cykpIHsKKwlp
ZiAodW5saWtlbHkobiAhPSBzZWdtZW50cykpIHsKKwkJcHJfd2FybigibnZtZV9zZXR1cF9kaXNj
YXJkOiBuICE9IHNlZ21lbnRzICgldSAhPSAldSlcbiIsIG4sIApzZWdtZW50cyk7CiAJCWlmICh2
aXJ0X3RvX3BhZ2UocmFuZ2UpID09IG5zLT5jdHJsLT5kaXNjYXJkX3BhZ2UpCiAJCQljbGVhcl9i
aXRfdW5sb2NrKDAsICZucy0+Y3RybC0+ZGlzY2FyZF9wYWdlX2J1c3kpOwogCQllbHNlCgpgYGAK
CmFuZCB0aGUgcmVzdWx0IGlzOgoKYGBgCm52bWVfc2V0dXBfZGlzY2FyZDogbiAhPSBzZWdtZW50
cyAoMyAhPSAyKQpudm1lX3NldHVwX2Rpc2NhcmQ6IG4gIT0gc2VnbWVudHMgKDEyICE9IDExKQpg
YGAKCih0aG9zZSBhcmUgZnJvbSBkaWZmZXJlbnQgYm9vdHMpCgpUaGFua3MuCgotLSAKT2xla3Nh
bmRyIE5hdGFsZW5rbyAocG9zdC1mYWN0dW0pCgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LW52bWUK
