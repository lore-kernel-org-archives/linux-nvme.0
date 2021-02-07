Return-Path: <SRS0=2jH7=HJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2175C433DB
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Feb 2021 04:50:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 408F864E0F
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Feb 2021 04:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 408F864E0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UTYT+ISi8KYl5rS8SjRHHLrnpqHyPJI7ZgW7F0GDomM=; b=BfR4SeP4EixxqnB73YSZo5HHm
	n2EcD4xE462L08WiP7g2K+houNsKNfZPhsTw0NW/vcYiIiSA/9m19ZSxFODcq0yqAzowDlusSI6FL
	oou6/AWPErj4d9Mjk8EwdqRTGATrub3NO14JKEsME8rdjOZ1ssxtNLl/M47ocqNigRib/TFnWRwx6
	kjU/Wr1Qw0qPqy7/LmlpWff8Y5zhjuuxsDG14uzcWnhcCtdQtEG5/tay9bzBctymzyd0cCKYBYA9C
	6zgQGLu0SX0vbVHYtohJ6f+eSpkbDPebZi/eRDBWN7X0Q4a16Ji9SrDguavvteCYzS6s4/b26ojo7
	cmRg03cFA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l8c1k-0003jT-9d; Sun, 07 Feb 2021 04:50:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l8c1d-0003j5-4R
 for linux-nvme@lists.infradead.org; Sun, 07 Feb 2021 04:50:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612673416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ErY66w4dhgf5LV2CZcSNdVtB+mUOpkXGVfPnBx1/S5o=;
 b=HDh/wTinjl/ELLLYANdzSzcgwJgchWY7KU1apLGSDEEfvhEt7KYJ19xOEZ0PyYNT/uyHAr
 DVumAlPbFnjAW/kCcTHNij1JFJXF6/EnLnKNLYPXnF6tpwzkCzNmfX9JHxJzqizWQREJoN
 12n/A0EKm3pPLMXkN3E0r9pTP9Ffwps=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-iLvtF_prOHuUHLPmKpmrdQ-1; Sat, 06 Feb 2021 23:50:12 -0500
X-MC-Unique: iLvtF_prOHuUHLPmKpmrdQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9A4B107ACE6;
 Sun,  7 Feb 2021 04:50:10 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-23.pek2.redhat.com [10.72.12.23])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 457731C923;
 Sun,  7 Feb 2021 04:50:03 +0000 (UTC)
Subject: Re: kernel null pointer at nvme_tcp_init_iter[nvme_tcp] with blktests
 nvme-tcp/012
From: Yi Zhang <yi.zhang@redhat.com>
To: linux-nvme@lists.infradead.org, linux-block <linux-block@vger.kernel.org>
References: <cki.F3E139361A.EN5MUSJKK9@redhat.com>
 <630237787.11660686.1612580898410.JavaMail.zimbra@redhat.com>
Message-ID: <80b7184e-cdfb-cebc-fe07-a228ce57a9e7@redhat.com>
Date: Sun, 7 Feb 2021 12:50:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <630237787.11660686.1612580898410.JavaMail.zimbra@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210206_235021_430162_8F2AB765 
X-CRM114-Status: GOOD (  11.37  )
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
Cc: axboe@kernel.dk, Rachel Sibley <rasibley@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, CKI Project <cki-project@redhat.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

ClRoZSBpc3N1ZSB3YXMgaW50cm9kdWNlZCBhZnRlciBtZXJnZSB0aGUgTlZNZSB1cGRhdGVzCgpj
b21taXQgMGZkNjQ1NmZkMWY0YzhmM2VjNWEyZGY2ZWQ3ZjM0NDU4YTE4MDQwOSAoSEVBRCkKTWVy
Z2U6IDQ0ZDEwZTRiMmYyYyAwZDczODk3MThjMzIKQXV0aG9yOiBKZW5zIEF4Ym9lIDxheGJvZUBr
ZXJuZWwuZGs+CkRhdGU6wqDCoCBUdWUgRmViIDIgMDc6MTI6MDYgMjAyMSAtMDcwMAoKIMKgwqDC
oCBNZXJnZSBicmFuY2ggJ2Zvci01LjEyL2RyaXZlcnMnIGludG8gZm9yLW5leHQKCiDCoMKgwqAg
KiBmb3ItNS4xMi9kcml2ZXJzOiAoMjIgY29tbWl0cykKIMKgwqDCoMKgwqAgbnZtZS10Y3A6IHVz
ZSBjYW5jZWwgdGFnc2V0IGhlbHBlciBmb3IgdGVhciBkb3duCiDCoMKgwqDCoMKgIG52bWUtcmRt
YTogdXNlIGNhbmNlbCB0YWdzZXQgaGVscGVyIGZvciB0ZWFyIGRvd24KIMKgwqDCoMKgwqAgbnZt
ZS10Y3A6IGFkZCBjbGVhbiBhY3Rpb24gZm9yIGZhaWxlZCByZWNvbm5lY3Rpb24KIMKgwqDCoMKg
wqAgbnZtZS1yZG1hOiBhZGQgY2xlYW4gYWN0aW9uIGZvciBmYWlsZWQgcmVjb25uZWN0aW9uCiDC
oMKgwqDCoMKgIG52bWUtY29yZTogYWRkIGNhbmNlbCB0YWdzZXQgaGVscGVycwogwqDCoMKgwqDC
oCBudm1lLWNvcmU6IGdldCByaWQgb2YgdGhlIGV4dHJhIHNwYWNlCiDCoMKgwqDCoMKgIG52bWU6
IGFkZCB0cmFjaW5nIG9mIHpucyBjb21tYW5kcwogwqDCoMKgwqDCoCBudm1lOiBwYXJzZSBmb3Jt
YXQgbnZtIGNvbW1hbmQgZGV0YWlscyB3aGVuIHRyYWNpbmcKIMKgwqDCoMKgwqAgbnZtZTogdXBk
YXRlIGVudW1lcmF0aW9ucyBmb3Igc3RhdHVzIGNvZGVzCiDCoMKgwqDCoMKgIG52bWV0OiBhZGQg
bGJhIHRvIHNlY3QgY29udmVyc2lvbiBoZWxwZXJzCiDCoMKgwqDCoMKgIG52bWV0OiByZW1vdmUg
ZXh0cmEgdmFyaWFibGUgaW4gaWRlbnRpZnkgbnMKIMKgwqDCoMKgwqAgbnZtZXQ6IHJlbW92ZSBl
eHRyYSB2YXJpYWJsZSBpbiBpZC1kZXNjbGlzdAogwqDCoMKgwqDCoCBudm1ldDogcmVtb3ZlIGV4
dHJhIHZhcmlhYmxlIGluIHNtYXJ0IGxvZyBuc2lkCiDCoMKgwqDCoMKgIG52bWU6IHJlZmFjdG9y
IG5zLT5jdHJsIGJ5IHJlcXVlc3QKIMKgwqDCoMKgwqAgbnZtZS10Y3A6IHBhc3MgbXVsdGlwYWdl
IGJ2ZWMgdG8gcmVxdWVzdCBpb3ZfaXRlcgogwqDCoMKgwqDCoCBudm1lLXRjcDogZ2V0IHJpZCBv
ZiB1bnVzZWQgaGVscGVyIGZ1bmN0aW9uCiDCoMKgwqDCoMKgIG52bWUtdGNwOiBmaXggd3Jvbmcg
c2V0dGluZyBvZiByZXF1ZXN0IGlvdl9pdGVyCiDCoMKgwqDCoMKgIG52bWU6IHN1cHBvcnQgY29t
bWFuZCByZXRyeSBkZWxheSBmb3IgYWRtaW4gY29tbWFuZAogwqDCoMKgwqDCoCBudm1lOiBjb25z
dGlmeSBzdGF0aWMgYXR0cmlidXRlX2dyb3VwIHN0cnVjdHMKIMKgwqDCoMKgwqAgbnZtZXQtZmM6
IHVzZSBSQ1UgcHJvY3RlY3Rpb24gZm9yIGFzc29jX2xpc3QKCgpPbiAyLzYvMjEgMTE6MDggQU0s
IFlpIFpoYW5nIHdyb3RlOgo+IGJsa3Rlc3RzIG52bWUtdGNwLzAxMgoKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0
CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
