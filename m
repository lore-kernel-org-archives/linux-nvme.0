Return-Path: <SRS0=cokh=E7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CF5C5519F
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2020 07:36:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9669A206B5
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2020 07:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="owcB4SpY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E3sDqi0y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9669A206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5DrphbGsZl3L8S+2SVvMGbUJcOBNfF6iZKwxtSas4QY=; b=owcB4SpYNT/2gPcpS+LlaTTM8
	uBh1MTOjSgsaAdHKt/4epohGBeSpxTYO8nn81xGV31fk0Ti11hQToOfe55YS/0x/I2YkGc/3TmTs6
	enbyWj/X4dFXQSn6CBOc/ejvK7RsBydKs+Q+uvV7ANDyjQPka5Da/YMYo1GDEVZR2XITiJnhyTK2h
	RQ0k902Yvx+l86PT/LdkiGCn3NytsNRKxzMRPA3vfAgyTJgAur1WTbuO0rES7t3kyvRgzaQjfgpnx
	JhkESFiMuS/mgnWLohjJa6W0na3kcY/ratO74yKCLUAG//jUhqGx4Uu69oZoXPKTNkGPR4Y8LszQY
	go/uB9cHA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1khpLe-0000fc-JX; Wed, 25 Nov 2020 07:36:18 +0000
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khpLZ-0000dx-8B
 for linux-nvme@lists.infradead.org; Wed, 25 Nov 2020 07:36:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606289772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hCPkwGoXkBAlp7t4JLhYbkUTm9+RLSJqjI18VgzPKQU=;
 b=E3sDqi0y8Jk90TMeyX+9+H41PsbFLEfEZLHBaV1qIBwaoMXRyYF2cxsxNH1Opk3QarqXVY
 +Rk9wxMv1gmbwiererGyIkc5ISEe7hjZOQlScpxwGIbJouj/71pPHbUz1e873qym73I0B8
 qXEzo3/OqDxfbCUnhf/X0KClngpA4oQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-jovdcSbjNSS4Om5QtFXIxA-1; Wed, 25 Nov 2020 02:36:09 -0500
X-MC-Unique: jovdcSbjNSS4Om5QtFXIxA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC3C918C89DA;
 Wed, 25 Nov 2020 07:36:07 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-67.pek2.redhat.com [10.72.12.67])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 026825C1A1;
 Wed, 25 Nov 2020 07:36:05 +0000 (UTC)
Subject: Re: [PATCH blktests 1/5] tests/srp/rc: update the ib_srpt module name
To: Bart Van Assche <bvanassche@acm.org>, osandov@osandov.com
References: <20201124010427.18595-1-yi.zhang@redhat.com>
 <20201124010427.18595-2-yi.zhang@redhat.com>
 <7b6d00d7-2cf8-5a4b-f861-a7efe152843f@acm.org>
 <54f41dc8-41a5-e782-e135-dc7dc81209c0@redhat.com>
 <3e4208ef-3508-0db2-3b1d-96f055e1a37f@acm.org>
From: Yi Zhang <yi.zhang@redhat.com>
Message-ID: <3cdec4ab-37af-b55a-377a-17f2362e4575@redhat.com>
Date: Wed, 25 Nov 2020 15:36:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <3e4208ef-3508-0db2-3b1d-96f055e1a37f@acm.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201125_023613_318086_E248DF09 
X-CRM114-Status: GOOD (  19.20  )
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
Cc: linux-block@vger.kernel.org, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAxMS8yNS8yMCAxMTo0NyBBTSwgQmFydCBWYW4gQXNzY2hlIHdyb3RlOgo+IE9uIDExLzI0
LzIwIDY6MDEgQU0sIFlpIFpoYW5nIHdyb3RlOgo+PiBPbiAxMS8yNC8yMCAxMToyMyBBTSwgQmFy
dCBWYW4gQXNzY2hlIHdyb3RlOgo+Pj4gT24gMTEvMjMvMjAgNTowNCBQTSwgWWkgWmhhbmcgd3Jv
dGU6Cj4+Pj4gLcKgwqDCoCBpbnNtb2QgIi9saWIvbW9kdWxlcy8kKHVuYW1lCj4+Pj4gLXIpL2tl
cm5lbC9kcml2ZXJzL2luZmluaWJhbmQvdWxwL3NycHQvaWJfc3JwdC5rbyIgIiR7b3B0c1tAXX0i
IHx8Cj4+Pj4gcmV0dXJuICQ/Cj4+Pj4gK8KgwqDCoCBpbnNtb2QgIiQobHMgL2xpYi9tb2R1bGVz
LyIkKHVuYW1lCj4+Pj4gLXIpIi9rZXJuZWwvZHJpdmVycy9pbmZpbmliYW5kL3VscC9zcnB0L2li
X3NycHQuKikiICIke29wdHNbQF19IiB8fAo+Pj4+IHJldHVybiAkPwo+Pj4gSXMgJ2xzJyBuZWVk
ZWQgaGVyZSBvciBpcyAnZWNobycgc3VmZmljaWVudD8KPj4gQWN0dWFsbHkgaXQgZG9lc24ndCB3
b3JrIHdpdGhvdXQgbHMKPj4gJCBpbnNtb2QgIi9saWIvbW9kdWxlcy8iJCh1bmFtZQo+PiAtciki
L2tlcm5lbC9kcml2ZXJzL2luZmluaWJhbmQvdWxwL3NycHQvaWJfc3JwdC4qIgo+PiBpbnNtb2Q6
IEVSUk9SOiBjb3VsZCBub3QgbG9hZCBtb2R1bGUKPj4gL2xpYi9tb2R1bGVzLzUuMTAuMC1yYzUv
a2VybmVsL2RyaXZlcnMvaW5maW5pYmFuZC91bHAvc3JwdC9pYl9zcnB0Lio6IE5vCj4+IHN1Y2gg
ZmlsZSBvciBkaXJlY3RvcnkKPj4KPj4gYW5kIGl0IHdvcmtzIHdpdGggZWNobywgSSBjYW4gY2hh
bmdlIHRvIGVjaG8gaWYgeW91IHByZWZlcgo+PiAkIGluc21vZCAiJChlY2hvIC9saWIvbW9kdWxl
cy8iJCh1bmFtZQo+PiAtcikiL2tlcm5lbC9kcml2ZXJzL2luZmluaWJhbmQvdWxwL3NycHQvaWJf
c3JwdC4qKSIgIiR7b3B0c1tAXX0iIHx8Cj4+IHJldHVybiAkPwo+ICdlY2hvJyBpcyBhIHNoZWxs
IGJ1aWx0LWluIHdoaWxlIGxzIGlzIG5vdCBidWlsdC1pbiBpbnRvIGJhc2gsIHNvIGVjaG8KPiBp
cyBmYXN0ZXIuCnllYWgsIHRoYW5rcyBmb3IgdGhlIGluZm8uCj4gSG93IGFib3V0IGluc21vZCAi
L2xpYi9tb2R1bGVzLyQodW5hbWUKPiAtcikva2VybmVsL2RyaXZlcnMvaW5maW5pYmFuZC91bHAv
c3JwdC9pYl9zcnB0LiIqIChubyBlY2hvLCBubyBscywKPiBhc3RlcmlzayBvdXRzaWRlIGRvdWJs
ZSBxdW90ZXMpPwpUaGlzIHdvcmtzLCBoYXZlIHVwZGF0ZWQgdG8gVjIKCj4gVGhhbmtzLAo+Cj4g
QmFydC4KPgo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KPiBMaW51eC1udm1lIG1haWxpbmcgbGlzdAo+IExpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFk
Lm9yZwo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
bnZtZQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxp
bnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
