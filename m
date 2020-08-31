Return-Path: <SRS0=W+Vz=CJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4CDC433E2
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 05:25:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 605312068E
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 05:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Kzn0mNg6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LOvIe8bQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 605312068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0+II7zttWjutiG1n4sn3QYM0u1ESJiAtHZNYHdbfGUQ=; b=Kzn0mNg6XeX0ejm1em5Lm+v6S
	BfSM7iIXHkiplqgIkEIq4sY8oV0mokkp8d5s+ApMj/CiRjc4EMm0xWJU+1LChchNbWlHqXVFNsOff
	V+9pnebHpYoD1Vv9/UrrH9jXHZEsXkjoi/3I62uaLk0tLUv3upkaR/ItHgpTKR98n0zrEOVFnsnQz
	qbI1aLAUNtxBBrhmNaJZMlGObCkxpPUz5i33XY3HheJ+3qDLLWpte09PZe6h+q3lV0PO3x3IgdF5d
	N7oCkiBzcEj3aO5MPqhSUuWqpm0yIkzNBv0V31PbOKqLKJzgseCOwnIbWwI10YCQ5GmwRndfHExlW
	/WJobKy3g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kCcJz-0008Go-Au; Mon, 31 Aug 2020 05:25:35 +0000
Received: from us-smtp-1.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kCcJw-0008GT-8C
 for linux-nvme@lists.infradead.org; Mon, 31 Aug 2020 05:25:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598851528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2cQpMUFJARc0o6WOj0yd9X3EysEBl5aQOvHs7B797Bs=;
 b=LOvIe8bQGqiz2Y/Cn1YtVTelKifSWF+lOwh6Sq3vUvugZaHEeNMN7AJ7zBcR1fKNSdZFJC
 mtEFohUPlsDiggPSguWVgExZc3Ptwk3zGiLmHt88Z4F935nbucKzS2sIkPCfJhGU2cTI45
 u9My9Dv7bEc+OV6E2zT4e7DfE+45uYc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-nmslZr57Pa6q19HjOaYKFw-1; Mon, 31 Aug 2020 01:25:26 -0400
X-MC-Unique: nmslZr57Pa6q19HjOaYKFw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCE3C10ABDA4;
 Mon, 31 Aug 2020 05:25:24 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-249.pek2.redhat.com
 [10.72.12.249])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4166181180;
 Mon, 31 Aug 2020 05:25:22 +0000 (UTC)
Subject: Re: [bug report] reset_controller operation on NVMe/IB need more than
 10s
To: Sagi Grimberg <sagi@grimberg.me>, maxg@mellanox.com
References: <769167569.38843663.1598589784057.JavaMail.zimbra@redhat.com>
 <3138aa7e-612c-8a17-4bce-dd42078892b6@grimberg.me>
From: Yi Zhang <yi.zhang@redhat.com>
Message-ID: <14e3d9d2-0a3e-f79d-dae1-c73ef9cb53a5@redhat.com>
Date: Mon, 31 Aug 2020 13:25:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <3138aa7e-612c-8a17-4bce-dd42078892b6@grimberg.me>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yi.zhang@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200831_012532_532865_F61155EA 
X-CRM114-Status: GOOD (  13.30  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Q2hhbmdlIHRoZSBTdWJqZWN0Li4uCgpGaW5hbGx5IEkgZm91bmQgdGhlIE9PTSB3YXMgbm90IHRy
aWdnZXJlZCBieSByZXNldF9jb250cm9sbGVyLCBidXQgZHVlIAp0byBteSA1MDAgdGltZXMnIHJl
c2V0X2NvbnRyb2xsZXIgbm90IGZpbmlzaGVkIGluIDEgaG91ciwgYW5kIHRyaWdnZXJlZCAKdGVz
dCBoYXJuZXNzIHdhdGNoZG9nIGFuZCBsZWFkIE9PTS4KClNvIHRoZSBpc3N1ZSBoZXJlIGlzIHRo
ZSByZXNldF9jb250cm9sbGVyIG9wZXJhdGlvbiBuZWVkIG1vcmUgdGhhbiAxMHMgCm5vd1sxXSwg
YnkgYmlzZWN0aW5nIEkgZm91bmQgaXQgd2FzIGludHJvZHVjZWQgZnJvbSBjb21taXRbMl0sIGFu
ZCBpdCAKd2lsbCBqdXN0IG5lZWQgMiBzZWNvbmRzIGlmIHcvbyB0aGlzIHBhdGNoLgoKWzFdCiMg
dGltZSBlY2hvIDEgPi9zeXMvYmxvY2svbnZtZTBuMS9kZXZpY2UvbnZtZTAvcmVzZXRfY29udHJv
bGxlcgoKcmVhbMKgwqDCoCAwbTEwLjM5MnMKdXNlcsKgwqDCoCAwbTAuMDAwcwpzeXPCoMKgwqAg
MG0wLjAwMHMKClsyXQpjb21taXQgNWVjNWQzYmRkYzZiOTEyYjdkZTllM2ViNmMxZjIzOTdmYWVj
YTJiYwpBdXRob3I6IE1heCBHdXJ0b3ZveSA8bWF4Z0BtZWxsYW5veC5jb20+CkRhdGU6wqDCoCBU
dWUgTWF5IDE5IDE3OjA1OjU2IDIwMjAgKzAzMDAKCiDCoMKgwqAgbnZtZS1yZG1hOiBhZGQgbWV0
YWRhdGEvVDEwLVBJIHN1cHBvcnQKCiDCoMKgwqAgRm9yIGNhcGFibGUgSENBcyAoZS5nLiBDb25u
ZWN0WC01L0Nvbm5lY3RYLTYpIHRoaXMgd2lsbCBhbGxvdyAKZW5kLXRvLWVuZAogwqDCoMKgIHBy
b3RlY3Rpb24gaW5mb3JtYXRpb24gcGFzc3Rocm91Z2ggYW5kIHZhbGlkYXRpb24gZm9yIE5WTWUg
b3ZlciBSRE1BCiDCoMKgwqAgdHJhbnNwb3J0LiBNZXRhZGF0YSBvZmZsb2FkIHN1cHBvcnQgd2Fz
IGltcGxlbWVudGVkIG92ZXIgdGhlIG5ldyBSRE1BCiDCoMKgwqAgc2lnbmF0dXJlIHZlcmJzIEFQ
SSBhbmQgaXQgaXMgZW5hYmxlZCBmb3IgY2FwYWJsZSBjb250cm9sbGVycy4KCiDCoMKgwqAgU2ln
bmVkLW9mZi1ieTogTWF4IEd1cnRvdm95IDxtYXhnQG1lbGxhbm94LmNvbT4KIMKgwqDCoCBTaWdu
ZWQtb2ZmLWJ5OiBJc3JhZWwgUnVrc2hpbiA8aXNyYWVsckBtZWxsYW5veC5jb20+CiDCoMKgwqAg
U2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+CgpbM10gdy9vIGFi
b3ZlIHBhdGNoCiMgdGltZSBlY2hvIDEgPi9zeXMvYmxvY2svbnZtZTBuMS9kZXZpY2UvbnZtZTAv
cmVzZXRfY29udHJvbGxlcgoKcmVhbMKgwqDCoCAwbTIuMTMycwp1c2VywqDCoMKgIDBtMC4wMDBz
CnN5c8KgwqDCoCAwbTAuMDAwcwoKCgpPbiA4LzI4LzIwIDExOjU3IFBNLCBTYWdpIEdyaW1iZXJn
IHdyb3RlOgo+Cj4+IEhlbGxvCj4+Cj4+IMKgRnJvbSA1LjgtcmMxIHN0cmVzcyByZXNldF9jb250
cm9sbGVyIG9wZXJhdGlvbiB3aWxsIGxlYWQgc3lzdGVtIE9PTSAKPj4gb24gYm90aCB0YXJnZXQv
aG9zdCBzaWRlLgo+PiBUaGlzIGlzc3VlIGNhbm5vdCBiZSByZXByb2R1Y2VkIG9uIHY1LjcgYW5k
IHN0aWxsIGNhbiBiZSByZXByb2R1Y2VkIAo+PiBvbiB2NS45LXJjMSwgbGV0IG1lIGtub3cgaWYg
eW91IG5lZWQgbW9yZSBpbmZvLCB0aGFua3MuCj4KPiBEb2VzIGttZW1sZWFrIGNvbXBsYWluIGR1
cmluZyB0aGUgdGVzdD8KPgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LW52bWUK
