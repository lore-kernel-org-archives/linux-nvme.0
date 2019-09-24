Return-Path: <SRS0=cpn7=XT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50F6C432C1
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Sep 2019 04:53:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83FF2207FD
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Sep 2019 04:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eu96jQO0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83FF2207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=k4kFRGLT1iLFrI7WbsqKi5ue50TVkwaisTzwAo82bmc=; b=eu96jQO0GcMvzi
	LEpSRMlHv/mgxgJCKk8dKIr7pygrGaRBp5SFyzzM0GMLcIQdfDOjHYsR5GlZ8dSTY74V2odP6ci9v
	Yhg2hmVMEfpqXfZ8vX7OFE6AbQtelzmYx/pgUHyfEgVjsLEF6oyp4+TVCu1xwdXeEP9MYsHPSy3Y0
	XI9QQDgWZ9YRWkorzBXlzOgdRrvqxbQF7w+nYKlPBQqsZYJ6lfTQel/IZ1G+Nml8OFA+EVHTUVVsT
	yoSuTGnl5f4DqUnjbTr92HlX9xBYb1jwQVTafX6jFAgjHdTiKpWfnJ3vqOTkT/7F8Edp/5gcC8iZX
	h8uzoeLsH2fe1ceeBlRQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iCcos-0001ds-He; Tue, 24 Sep 2019 04:52:58 +0000
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iCcop-0001dT-1O
 for linux-nvme@lists.infradead.org; Tue, 24 Sep 2019 04:52:57 +0000
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E83D5C049E17;
 Tue, 24 Sep 2019 04:52:53 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DD7D560852;
 Tue, 24 Sep 2019 04:52:53 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com
 (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id C0A634E589;
 Tue, 24 Sep 2019 04:52:53 +0000 (UTC)
Date: Tue, 24 Sep 2019 00:52:52 -0400 (EDT)
From: Yi Zhang <yi.zhang@redhat.com>
To: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <116222781.3022437.1569300772965.JavaMail.zimbra@redhat.com>
In-Reply-To: <0a8fffe2-f607-26ac-43f5-86182b1c782e@mellanox.com>
References: <1437535598.446597.1568798016422.JavaMail.zimbra@redhat.com>
 <2ea07772-3905-fb82-4d73-7458a963677c@mellanox.com>
 <1a2ef415-72fd-7a78-33b3-5a2656246f77@redhat.com>
 <d8526cc2-e270-baf0-1ff6-728e69e8d86a@grimberg.me>
 <0a8fffe2-f607-26ac-43f5-86182b1c782e@mellanox.com>
Subject: Re: NVMeoF RDMA IB: I/O timeout and NULL pointer observed during
 rescan_controller/reset_controller with fio background
MIME-Version: 1.0
X-Originating-IP: [10.68.5.41, 10.4.195.6]
Thread-Topic: NVMeoF RDMA IB: I/O timeout and NULL pointer observed during
 rescan_controller/reset_controller with fio background
Thread-Index: vbgc8fEBbemmlYnIMe+4WqbE73k8hw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Tue, 24 Sep 2019 04:52:54 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190923_215255_117724_48561EAE 
X-CRM114-Status: GOOD (  12.32  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SGkgTWF4L1NhZ2kKU29ycnkgZm9yIHRoZSBsYXRlIHJlc3BvbnNlLCB3aWxsIHVwZGF0ZSBpdCB0
b2RheS4KCkJlc3QgUmVnYXJkcywKICBZaSBaaGFuZwoKCi0tLS0tIE9yaWdpbmFsIE1lc3NhZ2Ug
LS0tLS0KRnJvbTogIk1heCBHdXJ0b3ZveSIgPG1heGdAbWVsbGFub3guY29tPgpUbzogIlNhZ2kg
R3JpbWJlcmciIDxzYWdpQGdyaW1iZXJnLm1lPiwgIllpIFpoYW5nIiA8eWkuemhhbmdAcmVkaGF0
LmNvbT4sIGxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpTZW50OiBNb25kYXksIFNlcHRl
bWJlciAyMywgMjAxOSAxMToyNTozMSBQTQpTdWJqZWN0OiBSZTogTlZNZW9GIFJETUEgSUI6IEkv
TyB0aW1lb3V0IGFuZCBOVUxMIHBvaW50ZXIgb2JzZXJ2ZWQgZHVyaW5nIHJlc2Nhbl9jb250cm9s
bGVyL3Jlc2V0X2NvbnRyb2xsZXIgd2l0aCBmaW8gYmFja2dyb3VuZAoKQW55IHVwZGF0ZSBZaSA/
Cgp3ZSBtdXN0IGZpeCB0aGlzIGlzc3VlLi4KCk9uIDkvMjAvMjAxOSA3OjU4IFBNLCBTYWdpIEdy
aW1iZXJnIHdyb3RlOgo+IFRoYW5rcyBmb3IgcmVwb3J0aW5nIFlpLAo+Cj4gRG9lcyB0aGlzIGZp
eCB5b3VyIGlzc3VlPwo+Cj4gLS0gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L3Jk
bWEuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L3JkbWEuYwo+IGluZGV4IGRmYTA3YmI5ZGZlYi4uOTgx
ZGE5Y2UzY2ZjIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L3JkbWEuYwo+ICsrKyBi
L2RyaXZlcnMvbnZtZS9ob3N0L3JkbWEuYwo+IEBAIC02MTQsNyArNjE0LDggQEAgc3RhdGljIGlu
dCBudm1lX3JkbWFfc3RhcnRfcXVldWUoc3RydWN0IAo+IG52bWVfcmRtYV9jdHJsICpjdHJsLCBp
bnQgaWR4KQo+IMKgwqDCoMKgwqDCoMKgIGlmICghcmV0KSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHNldF9iaXQoTlZNRV9SRE1BX1FfTElWRSwgJnF1ZXVlLT5mbGFncyk7Cj4g
wqDCoMKgwqDCoMKgwqAgfSBlbHNlIHsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBf
X252bWVfcmRtYV9zdG9wX3F1ZXVlKHF1ZXVlKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBpZiAodGVzdF9iaXQoTlZNRV9SRE1BX1FfQUxMT0NBVEVELCAmcXVldWUtPmZsYWdzKSkK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgX19udm1lX3Jk
bWFfc3RvcF9xdWV1ZShxdWV1ZSk7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRl
dl9pbmZvKGN0cmwtPmN0cmwuZGV2aWNlLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgImZhaWxlZCB0byBjb25uZWN0IHF1ZXVlOiAlZCByZXQ9JWRcbiIs
IGlkeCwgCj4gcmV0KTsKPiDCoMKgwqDCoMKgwqDCoCB9Cj4gLS0gCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApM
aW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1udm1lCg==
