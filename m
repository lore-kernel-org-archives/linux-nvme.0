Return-Path: <SRS0=3Lap=G6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DC1C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jan 2021 03:36:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EAB2206C2
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jan 2021 03:36:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EAB2206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3y2O3lJ4qBDZHb1e9jCjQqu6Ufk7+9IIGKUHEzp+xIU=; b=opHrkZ4lSTs13qBFMPMNca4oye
	3O3VWQ8mMrIte8PyZhti5K72NXBOy4+iahSst55Hru4QxvQXhNaSM9A71gttlllONEhf/zxLDrogw
	p/xsD2eWncDf9vrQl2vvDm3bOSB4ici3u16p4EEPUsx2mUHOZgtcsW5/ZELvccTKRYFxqeYKHoRGq
	CHCU597C5QUBrpWatR/k06keh3VhejQaQQTvDfaX3w14QmnArSD85rNCkK7ZOuzBLFt2mlrwwYTab
	DS59CtkyInVky9/aa22a5b+/MIvgjmNRA9EWGeRWXgP5C9xb2hw5jwUGzdg7qu9L80+KZRZ0IHetZ
	Q8wXxPCA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4bct-0006lK-9K; Wed, 27 Jan 2021 03:36:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4bcp-0006kx-BU
 for linux-nvme@lists.infradead.org; Wed, 27 Jan 2021 03:36:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611718568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GGauNbQJE4gZcmKAVJ/S8dpbkKoVJ8W6XTFX6CrOHC8=;
 b=W5/V7x/56io8etXFyO2CnA/ZYhs2WxMjDcgEnjwn+pijtWJbSYUX5TEXtE2tAtCUxeagpE
 3hQoIna0xxelQcaIyBdGleHVdYe6lA6CKb6Rv0GLSHyD7WB20sYGCp8QaAcg/DEFQNveW5
 C9M1yueBrvab5kG7EiEIbdYK37Bgpxs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-oKqj0jL-O7SB9uXxQSilLQ-1; Tue, 26 Jan 2021 22:36:03 -0500
X-MC-Unique: oKqj0jL-O7SB9uXxQSilLQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8B821922021;
 Wed, 27 Jan 2021 03:36:02 +0000 (UTC)
Received: from dhcp-12-105.nay.redhat.com (unknown [10.66.61.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A5B4E5D768;
 Wed, 27 Jan 2021 03:36:01 +0000 (UTC)
From: Yi Zhang <yi.zhang@redhat.com>
To: kbusch@kernel.org
Subject: [PATCH nvme-cli] Documentation: fix typo rtyep -> rtype
Date: Wed, 27 Jan 2021 11:35:59 +0800
Message-Id: <20210127033559.20737-1-yi.zhang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yi.zhang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210126_223611_435339_3A0C1614 
X-CRM114-Status: GOOD (  12.18  )
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

U2lnbmVkLW9mZi1ieTogWWkgWmhhbmcgPHlpLnpoYW5nQHJlZGhhdC5jb20+Ci0tLQogRG9jdW1l
bnRhdGlvbi9udm1lLXJlc3YtYWNxdWlyZS4xICAgIHwgMiArLQogRG9jdW1lbnRhdGlvbi9udm1l
LXJlc3YtYWNxdWlyZS5odG1sIHwgMiArLQogRG9jdW1lbnRhdGlvbi9udm1lLXJlc3YtYWNxdWly
ZS50eHQgIHwgMiArLQogRG9jdW1lbnRhdGlvbi9udm1lLXJlc3YtcmVsZWFzZS4xICAgIHwgMiAr
LQogRG9jdW1lbnRhdGlvbi9udm1lLXJlc3YtcmVsZWFzZS5odG1sIHwgMiArLQogRG9jdW1lbnRh
dGlvbi9udm1lLXJlc3YtcmVsZWFzZS50eHQgIHwgMiArLQogNiBmaWxlcyBjaGFuZ2VkLCA2IGlu
c2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9u
dm1lLXJlc3YtYWNxdWlyZS4xIGIvRG9jdW1lbnRhdGlvbi9udm1lLXJlc3YtYWNxdWlyZS4xCmlu
ZGV4IGZlZjIzOTguLjEwODg0NzkgMTAwNjQ0Ci0tLSBhL0RvY3VtZW50YXRpb24vbnZtZS1yZXN2
LWFjcXVpcmUuMQorKysgYi9Eb2N1bWVudGF0aW9uL252bWUtcmVzdi1hY3F1aXJlLjEKQEAgLTU5
LDcgKzU5LDcgQEAgQ3VycmVudCBSZXNlcnZhdGlvbiBLZXk6IFRoZSBmaWVsZCBzcGVjaWZpZXMg
dGhlIGN1cnJlbnQgcmVzZXJ2YXRpb24ga2V5IGFzc29jaWEKIFByZWVtcHQgUmVzZXJ2YXRpb24g
S2V5OiBJZiB0aGUgUmVzZXJ2YXRpb24gQWNxdWlyZSBBY3Rpb24gaXMgc2V0IHRvIDAwMWIgKGlc
Ji5lXCYuLCBQcmVlbXB0KSBvciAwMTBiIChpXCYuZVwmLiwgUHJlZW1wdCBhbmQgQWJvcnQpLCB0
aGVuIHRoaXMgZmllbGQgc3BlY2lmaWVzIHRoZSByZXNlcnZhdGlvbiBrZXkgdG8gYmUgdW5yZWdp
c3RlcmVkIGZyb20gdGhlIG5hbWVzcGFjZVwmLiBGb3IgYWxsIG90aGVyIFJlc2VydmF0aW9uIEFj
cXVpcmUgQWN0aW9uIHZhbHVlcywgdGhpcyBmaWVsZCBpcyByZXNlcnZlZFwmLgogLlJFCiAuUFAK
LVwtdCA8cnR5cGU+LCBcLVwtcnR5ZXA9PHJ0eXBlPgorXC10IDxydHlwZT4sIFwtXC1ydHlwZT08
cnR5cGU+CiAuUlMgNAogUmVzZXJ2YXRpb24gVHlwZTogVGhpcyBmaWVsZCBzcGVjaWZpZXMgdGhl
IHR5cGUgb2YgcmVzZXJ2YXRpb24gdG8gYmUgY3JlYXRlZFwmLgogLlRTCmRpZmYgLS1naXQgYS9E
b2N1bWVudGF0aW9uL252bWUtcmVzdi1hY3F1aXJlLmh0bWwgYi9Eb2N1bWVudGF0aW9uL252bWUt
cmVzdi1hY3F1aXJlLmh0bWwKaW5kZXggMTdiM2Q5NC4uZmFiZDhmZCAxMDA2NDQKLS0tIGEvRG9j
dW1lbnRhdGlvbi9udm1lLXJlc3YtYWNxdWlyZS5odG1sCisrKyBiL0RvY3VtZW50YXRpb24vbnZt
ZS1yZXN2LWFjcXVpcmUuaHRtbApAQCAtODE1LDcgKzgxNSw3IEBAIHJlc2VydmF0aW9uIGhlbGQg
b24gYSBuYW1lc3BhY2UuPC9wPjwvZGl2PgogLXQgJmx0O3J0eXBlJmd0OwogPC9kdD4KIDxkdCBj
bGFzcz0iaGRsaXN0MSI+Ci0tLXJ0eWVwPSZsdDtydHlwZSZndDsKKy0tcnR5cGU9Jmx0O3J0eXBl
Jmd0OwogPC9kdD4KIDxkZD4KIDxwPgpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9udm1lLXJl
c3YtYWNxdWlyZS50eHQgYi9Eb2N1bWVudGF0aW9uL252bWUtcmVzdi1hY3F1aXJlLnR4dAppbmRl
eCA0MWNiZjhmLi4xYjZlMTEwIDEwMDY0NAotLS0gYS9Eb2N1bWVudGF0aW9uL252bWUtcmVzdi1h
Y3F1aXJlLnR4dAorKysgYi9Eb2N1bWVudGF0aW9uL252bWUtcmVzdi1hY3F1aXJlLnR4dApAQCAt
NDQsNyArNDQsNyBAQCBPUFRJT05TCiAJdGhpcyBmaWVsZCBpcyByZXNlcnZlZC4KIAogLXQgPHJ0
eXBlPjo6Ci0tLXJ0eWVwPTxydHlwZT46OgorLS1ydHlwZT08cnR5cGU+OjoKIAlSZXNlcnZhdGlv
biBUeXBlOiBUaGlzIGZpZWxkIHNwZWNpZmllcyB0aGUgdHlwZSBvZiByZXNlcnZhdGlvbgogCXRv
IGJlIGNyZWF0ZWQuCiArCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL252bWUtcmVzdi1yZWxl
YXNlLjEgYi9Eb2N1bWVudGF0aW9uL252bWUtcmVzdi1yZWxlYXNlLjEKaW5kZXggMzBmZTlhOS4u
NWFkZTdmNSAxMDA2NDQKLS0tIGEvRG9jdW1lbnRhdGlvbi9udm1lLXJlc3YtcmVsZWFzZS4xCisr
KyBiL0RvY3VtZW50YXRpb24vbnZtZS1yZXN2LXJlbGVhc2UuMQpAQCAtNTMsNyArNTMsNyBAQCBP
dmVycmlkZSB0aGUgbnNpZCBmaWVsZFwmLiBJZiB1c2luZyB0aGUgYWRtaW4gY2hhcmFjdGVyIGRl
dmljZSwgdGhpcyBwYXJhbWV0ZXIgaQogQ3VycmVudCBSZXNlcnZhdGlvbiBLZXk6IElmIHRoZSBS
ZXNlcnZhdGlvbiBSZWdpc3RlciBBY3Rpb24gaXMgMDAxYiAoaVwmLmVcJi4sIFVucmVnaXN0ZXIg
UmVzZXJ2YXRpb24gS2V5KSBvciAwMTBiIChpXCYuZVwmLiwgUmVwbGFjZSBSZXNlcnZhdGlvbiBL
ZXkpLCB0aGVuIHRoaXMgZmllbGQgY29udGFpbnMgdGhlIGN1cnJlbnQgcmVzZXJ2YXRpb24ga2V5
IGFzc29jaWF0ZWQgd2l0aCB0aGUgaG9zdFwmLiBGb3IgYWxsIG90aGVyIFJlc2VydmF0aW9uIFJl
Z2lzdGVyIEFjdGlvbiB2YWx1ZXMsIHRoaXMgZmllbGQgaXMgcmVzZXJ2ZWRcJi4gVGhlIGNvbnRy
b2xsZXIgaWdub3JlcyB0aGUgdmFsdWUgb2YgdGhpcyBmaWVsZCB3aGVuIHRoZSBJZ25vcmUgRXhp
c3RpbmcgS2V5IChJRUtFWSkgYml0IGlzIHNldCB0byBcKG9xMVwoY3FcJi4KIC5SRQogLlBQCi1c
LXQgPHJ0eXBlPiwgXC1cLXJ0eWVwPTxydHlwZT4KK1wtdCA8cnR5cGU+LCBcLVwtcnR5cGU9PHJ0
eXBlPgogLlJTIDQKIFJlc2VydmF0aW9uIFR5cGU6IFRoaXMgZmllbGQgc3BlY2lmaWVzIHRoZSB0
eXBlIG9mIHJlc2VydmF0aW9uIHRvIGJlIGNyZWF0ZWRcJi4KIC5UUwpkaWZmIC0tZ2l0IGEvRG9j
dW1lbnRhdGlvbi9udm1lLXJlc3YtcmVsZWFzZS5odG1sIGIvRG9jdW1lbnRhdGlvbi9udm1lLXJl
c3YtcmVsZWFzZS5odG1sCmluZGV4IDg4NGRjNzguLjA5NGM4OWEgMTAwNjQ0Ci0tLSBhL0RvY3Vt
ZW50YXRpb24vbnZtZS1yZXN2LXJlbGVhc2UuaHRtbAorKysgYi9Eb2N1bWVudGF0aW9uL252bWUt
cmVzdi1yZWxlYXNlLmh0bWwKQEAgLTgwMiw3ICs4MDIsNyBAQCBoZWxkIG9uIGEgbmFtZXNwYWNl
LjwvcD48L2Rpdj4KIC10ICZsdDtydHlwZSZndDsKIDwvZHQ+CiA8ZHQgY2xhc3M9ImhkbGlzdDEi
PgotLS1ydHllcD0mbHQ7cnR5cGUmZ3Q7CistLXJ0eXBlPSZsdDtydHlwZSZndDsKIDwvZHQ+CiA8
ZGQ+CiA8cD4KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vbnZtZS1yZXN2LXJlbGVhc2UudHh0
IGIvRG9jdW1lbnRhdGlvbi9udm1lLXJlc3YtcmVsZWFzZS50eHQKaW5kZXggYTZhODk1ZS4uNmVi
MGI0MyAxMDA2NDQKLS0tIGEvRG9jdW1lbnRhdGlvbi9udm1lLXJlc3YtcmVsZWFzZS50eHQKKysr
IGIvRG9jdW1lbnRhdGlvbi9udm1lLXJlc3YtcmVsZWFzZS50eHQKQEAgLTM3LDcgKzM3LDcgQEAg
T1BUSU9OUwogCWJpdCBpcyBzZXQgdG8g4oCYMeKAmS4KIAogLXQgPHJ0eXBlPjo6Ci0tLXJ0eWVw
PTxydHlwZT46OgorLS1ydHlwZT08cnR5cGU+OjoKIAlSZXNlcnZhdGlvbiBUeXBlOiBUaGlzIGZp
ZWxkIHNwZWNpZmllcyB0aGUgdHlwZSBvZiByZXNlcnZhdGlvbgogCXRvIGJlIGNyZWF0ZWQuCiAr
Ci0tIAoyLjIxLjAKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1l
Cg==
