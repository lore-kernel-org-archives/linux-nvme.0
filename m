Return-Path: <SRS0=W+Vz=CJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEEBC433E6
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 21:39:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6321E2083E
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 21:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JkkHC6va";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MbcfzzZa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6321E2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9XWoiPN4ItUPuXZKjxzRzPY60auWVYvixQB87MuwiZ8=; b=JkkHC6vac5KVbtfrAttRNPI2H
	dT+sVwUjzNlToZcPxLTwirIwKuBaIqM4syMpFyMaQnljTI4T4HK5VOuoxhTaB+lPi4yH2sMZJgz0N
	2i8uQc9i+VVCZmDLYpNxXg/YgWLqVyfaXfDom8hGFBcTf1KP3K4clyoj7/URlLQVZ/u35OkonKvsz
	pd6nVprrXEjrKQ6QpR72L+m66PptqZy+V2IXc16+WrzTOxbC7M/BI3FKInCInJ/7ZkkRbEAkGt0nM
	LH+O7GWjI6iRXkA0h/PbLZ0XNFJunvz+gEqJdA7mgBISkc/zmTJe5IoZro5jv4ikKHBci/I63LuHN
	8MNNY605Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kCrWg-0001l8-3j; Mon, 31 Aug 2020 21:39:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kCrWb-0001kP-LB
 for linux-nvme@lists.infradead.org; Mon, 31 Aug 2020 21:39:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598909977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=shXDN7epIXr1xKF0FP/e/dOSu/2L1o3ebJb/voO3flU=;
 b=MbcfzzZaQFiKqgcno8Ga3K/yBBYyoS0YhuH1CD4HUXfVbY8L/v7CjhCU32oR8qnAp3POI5
 qbATjwl06jeCXiQmn8v4ZfRysMGHNoEmZT7LNc4Na3Qk2/TW72kMbKrLKrWKy6EKjap2Gu
 7NRscxB7xMDDuThboLtWb6LnfgzHYsY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-4Pk0cBKVPDGxgDioDneKyQ-1; Mon, 31 Aug 2020 17:39:34 -0400
X-MC-Unique: 4Pk0cBKVPDGxgDioDneKyQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E029C1888A10;
 Mon, 31 Aug 2020 21:39:33 +0000 (UTC)
Received: from [10.10.113.65] (ovpn-113-65.rdu2.redhat.com [10.10.113.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 309C610013C4;
 Mon, 31 Aug 2020 21:39:32 +0000 (UTC)
Subject: Re: [PATCH] nvme-rdma: flush async events before freeing qe
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 hch@lst.de
References: <1598899458-15153-1-git-send-email-dmilburn@redhat.com>
 <875bfa87-ae62-8f88-105e-ca480a3528eb@grimberg.me>
From: David Milburn <dmilburn@redhat.com>
Message-ID: <ee18d375-c222-e9cb-36e7-fd60c5b3846c@redhat.com>
Date: Mon, 31 Aug 2020 16:39:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <875bfa87-ae62-8f88-105e-ca480a3528eb@grimberg.me>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dmilburn@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200831_173937_884690_CD127DAB 
X-CRM114-Status: GOOD (  19.87  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SGkgU2FnaSwKCk9uIDA4LzMxLzIwMjAgMDM6NTIgUE0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4g
Cj4+IEZsdXNoIGFzeW5jIGV2ZW50IHdvcmtxdWV1ZSBpbiBjYXNlIGFzeW5jIGV2ZW50IGhhcyBi
ZWVuCj4+IHF1ZXVlZCB1cCBiZWZvcmUgZnJlZWluZyBxZSBhbmQgc2V0dGluZyBjdHJsLT5hc3lu
Y19ldmVudF9zcWUuZGF0YQo+PiB0byBOVUxMLiBPdGhlcndpc2UsIHdlIGNhbiBnZXQgaW50byBh
IHN0YXRlIHdlcmUgbnZtZV9yZG1hX3N1Ym1pdF8KPj4gYXN5bmNfZXZlbnQoKSBydW5zIHdpdGgg
c3FlLT5kYXRhIHNldCB0byBOVUxMIGxlYWRpbmcgdG8gY3Jhc2guCj4+Cj4+IFNpZ25lZC1vZmYt
Ynk6IERhdmlkIE1pbGJ1cm4gPGRtaWxidXJuQHJlZGhhdC5jb20+Cj4+IC0tLQo+PiDCoCBkcml2
ZXJzL252bWUvaG9zdC9yZG1hLmMgfCAxICsKPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9yZG1hLmMgYi9kcml2
ZXJzL252bWUvaG9zdC9yZG1hLmMKPj4gaW5kZXggOGU1ZmZlMmYxMTdkLi43NmYxMTc0NjJkNWIg
MTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L3JkbWEuYwo+PiArKysgYi9kcml2ZXJz
L252bWUvaG9zdC9yZG1hLmMKPj4gQEAgLTgzNSw2ICs4MzUsNyBAQCBzdGF0aWMgdm9pZCBudm1l
X3JkbWFfZGVzdHJveV9hZG1pbl9xdWV1ZShzdHJ1Y3QgCj4+IG52bWVfcmRtYV9jdHJsICpjdHJs
LAo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgYmxrX21xX2ZyZWVfdGFnX3NldChjdHJsLT5jdHJsLmFk
bWluX3RhZ3NldCk7Cj4+IMKgwqDCoMKgwqAgfQo+PiDCoMKgwqDCoMKgIGlmIChjdHJsLT5hc3lu
Y19ldmVudF9zcWUuZGF0YSkgewo+PiArwqDCoMKgwqDCoMKgwqAgZmx1c2hfd29yaygmY3RybC0+
Y3RybC5hc3luY19ldmVudF93b3JrKTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIG52bWVfcmRtYV9m
cmVlX3FlKGN0cmwtPmRldmljZS0+ZGV2LCAmY3RybC0+YXN5bmNfZXZlbnRfc3FlLAo+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNpemVvZihzdHJ1Y3QgbnZtZV9jb21tYW5k
KSwgRE1BX1RPX0RFVklDRSk7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBjdHJsLT5hc3luY19ldmVu
dF9zcWUuZGF0YSA9IE5VTEw7Cj4gCj4gV2h5IG5vdCBjYW5jZWwgdGhlIHdvcms/CgpPaywgY2Fu
Y2VsX3dvcmtfc3luYyB3b3VsZCBoYXZlIGJlZW4gYSBiZXR0ZXIgY2hvaWNlLgoKPiAKPiBJIGFs
c28gdGhpbmsgdGhhdCB3ZSB3aWxsIHdhbnQgdG8gaGF2ZSB0aGlzIGluIG52bWUtY29yZSwgbm90
Cj4gc3BlY2lmaWNhbGx5IHRvIG52bWUtcmRtYT8KPgoKSSBzZWUgaG93IHRjcC5jIG1heSBydW4g
aW50byB0aGUgc2FtZSBwcm9ibGVtIHdpdGgKbnZtZV90Y3BfZnJlZV9hZG1pbl9xdWV1ZSgpLCBi
dXQgc2luY2Ugd2UgcXVldWUgZXJyX3dvcmsKZnJvbSByZG1hLmMsIHRjcC5jLCBmYy5jLCBub3Qg
c3VyZSBob3cgdG8gbW92ZSB0aGUKY2hhbmdlIHRvIGNvcmUuYz8KCkVhY2ggY2FsbHMgbnZtZV9j
b21wbGV0ZV9hc3luY19ldmVudCgpLCBidXQgZG9lc24ndApsb29rIGxpa2Ugd2UgY291bGQgY2hl
Y2sgdGhlcmUuCgpUaGFua3MsCkRhdmlkCgoKCgoKCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1l
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1udm1lCg==
