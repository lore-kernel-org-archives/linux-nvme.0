Return-Path: <SRS0=oqNq=DJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21811C4727E
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Oct 2020 02:57:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59B04206DB
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Oct 2020 02:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sZ0ci7rv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Z9cRRGYz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59B04206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uxAJKWHuRw8bkAoQHJ3DmvYB8hP3ClnsVxwR850sUuQ=; b=sZ0ci7rveIscT8sRyhGPoNGVjA
	KPdvZVrv4pPiqIYt1k3HrHifcGr6z6ecTi0emwvw38zNmUQSVOTmC7U6qgYo7VCPFy4Zof8QSAQoW
	+E253tEeu+Ihh1b6rlT46XLa++nw1/DMunVZBF0tlfl3c5Ko5Om+1E1GaVB+E+vpgNE9EEUpL0Cae
	H8cATrmgOZyeCUbjuPOdPqeDLfO6b0btJwxApaYO8Eef3/tcTGrJQq/D+jfbC27KPIf22UNvR0NoI
	GIZX00lfN5MBGnYN8k0e/F32KoEQ2qevLwN8TtRX6EEs6OPPJyMzt1Pu4ssUQMeF9WNUwYYH5JQvj
	OmUA34XQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kOBFh-0004sR-5H; Fri, 02 Oct 2020 02:56:57 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kOBFe-0004rs-5D
 for linux-nvme@lists.infradead.org; Fri, 02 Oct 2020 02:56:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601607414; x=1633143414;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=H5uiSpRJvHoyhnXylPcN5J17oWMW7NCWA/1WIskTDvc=;
 b=Z9cRRGYzF1PuaWy6dFE6vlV5IUyJz7EbVOow21gZsudleWJE0pEv0Rvm
 e7QjglWtgDj4PiTm96v1YppEzy0Wx8PC/g0w9hGLo7DzAlRuwkhdC1Jil
 e01SXcTihOw+CTlD/+ljbgrqxYK5YhGBJhHPKtHEqEABZX+mAkjFo+dIv
 iEBvMFoX0rd75YvONrfQguSDmLaHIggnl2U88ugMyrOc3vOoQ3QNGS/Ab
 6AQgqLIcegUD+VDQ371bsdEkcC/H9BACOcDjrwBQoUXnLPfdc8Fwo9v/1
 r0WS1zinNdmZITPP/JdokLhn1oKAZtKVcEHEvgN0OM9AbiEyOg5ofRo5X g==;
IronPort-SDR: LSrwDnJWfcf7KGjJ2YGfDT8hZUD5PfZt0y+Q+7QDTHCNkHzUn3jpoIBbHigRznqppgs7plkM2x
 2+6s+AuxxVkXwxbz8wcMn4m9nev9ikmq3MauK4S6ycJWzh5Fg8d8nzd3bCgEEyke7VV3PsQxfL
 uWN1hlRfGwyslbtGNuwxZyMsg5VeOubl+zy5L4x7GOigoY+fdmhEV4c0mGAIFwRysXWPo3Qh8G
 KagrwQtJ1j2nv/2FTla5d28alU1x7z+1jLX42lfvVt4TFZ6BZL6A32/p570Y0yYgj3eL1H2qdn
 AJs=
X-IronPort-AV: E=Sophos;i="5.77,326,1596470400"; d="scan'208";a="150086569"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2020 10:56:50 +0800
IronPort-SDR: 8dtjZo97uhMeZVm+2Adb948vbraqvHFytMJAdWgMlg/rD/J5LIlhecBYUUSJaj1gLZ7Xc6KiE9
 FgUPujO1ntbw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2020 19:42:47 -0700
IronPort-SDR: 7iISZScJZRsYrNvO6R6oYFWQ6ym5zuor792h2ZqAvey6lACR1vyz+UcyOA6a6XXwkFpJqvh1KY
 Xao9B3keMnYQ==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 01 Oct 2020 19:56:51 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 0/4] nvmet: allow target to export readonly ns
Date: Thu,  1 Oct 2020 19:56:45 -0700
Message-Id: <20201002025649.30724-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201001_225654_383254_F6ABBA99 
X-CRM114-Status: GOOD (  18.79  )
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SGksCgpUaGlzIHBhdGNoIHNlcmllcyBhbGxvd3MgdGhlIHRhcmdldCB0byBleHBvcnQgdGhlIHJl
YWQtb25seSBucy4gVGhlIGZpcnN0CnBhdGNoIGNoYW5nZXMgdGhlIHR5cGUgb2YgdGhlIG5zIGJv
b2wgcmVhZC1vbmx5IGF0dHIgdG8gbnZtZV9uc193cF9zdGF0ZQp3cml0ZS1wcm90ZWN0IHNvIHRo
YXQgd2UgY2FuIHN0b3JlIHRoZSBzdGF0ZS4KClRoZSBzZWNvbmQgcGF0Y2ggYWRkcyB0aGUgbmV3
IG5zIHdyaXRlX3Byb3RlY3QgY29uZmlnZnMgYXR0ciB3aGljaCB1c2VyCmNhbiBzZXQgdG8gbWFr
ZSBucyByZWFkLW9ubHksIHdlIGRvbid0IGFsbG93IHVzZXIgdG8gY2hhbmdlIHRoZSAKd3JpdGUt
cHJvdGVjdCB2YWx1ZSB3aGVuIGl0IGlzIHNldCBmcm9tIGNvbmZpZ2ZzLgoKVGhlIGxhc3QgdHdv
IHBhdGNoZXMgYWxsb3cgdGhlwqB1c2VyIHRvIG9wZW4gdGhlIG5zIGluIHRoZSByZWFkLW9ubHkg
bW9kZSBzaW5jZQpieSBkZWZhdWx0IHdlIG9wZW4gdGhlIG5zIGluIHJlYWQtd3JpdGUgbW9kZSB3
aGljaCB3aWxsIGZhaWwgaWYgbnMKYmFja2VuZCBpcyBzZXQgdG8gcmVhZC1vbmx5LgoKUmVnYXJk
cywKQ2hhaXRhbnlhCgoqIENoYW5nZXMgZnJvbSBWMTotCgoxLiBBZGQgYSBwcmVwIHBhdGNoIHRv
IHN0b3JlIHRoZSBucyB3cml0ZSBwcm90ZWN0IHN0YXRlLgoyLiBEb24ndCBhbGxvdyB0aGUgaG9z
dCB0byBjaGFuZ2UgdGhlIG5zLXdyaXRlLXByb3RlY3Qgc3RhdGUgd2hlbiB0aGUgc3RhdGUKwqAg
wqBpcyBzZXQgZnJvbSBjb25maWdmcyB0byB0aGUgTlZNRV9OU19XUklURV9QUk9URUNUX1BFUk1B
TkVOVC4KMy4gQ2hhbmdlIHRoZSBucyBib29sIHR5cGUgcmVhZG9ubHkgdG8gbnZtZV9uc193cF9z
dGF0ZSB0eXBlCsKgIMKgd3JpdGVfcHJvdGVjdC4KNC4gVXBkYXRlIHRoZSBpZC1jdHJsIGZpZWxk
IG53cGMgdG8gaW5pZGljYXRlIHN1cHBvcnQgZm9yIHdyaXRlIHByb3RlY3Rpb24KICAgcGVybWFu
ZW50IHN0YXRlIGFuZCBkb24ndCBzZXQgdGhlIGJpdCAxIG9mIHRoZSByZXBsYXkgcHJvdGVjdGlv
biBibG9jawogICBOYW1lc2FwY2UgV3JpdGUgUHJvdGVjdGlvbiBDb250cm9sIHNvIGluZGljYXRl
IGFueSBhdHRlbXB0cyBvZgogICBzZXQtZmVhdHVyZSBjbWQgd2l0aCBwZXJtYW5lbnQgd3JpdGUg
cHJvdGVjdGlvbiBucyB2YWx1ZSB3aWxsIGZhaWwuCgpDaGFpdGFueWEgS3Vsa2FybmkgKDQpOgog
IG52bWV0OiBjaGFuZ2UgdGhlIHR5cGUgb2YgdGhlIG5zLT5yZWFkb25seQogIG52bWV0OiBhbGxv
dyB1c2VyIHRvIHNldCB0aGUgbnMgcmVhZG9ubHkKICBudm1ldDogYWxsb3cgcmVhZG9ubHkgYmRl
di1ucyB0byBiZSBjb25maWd1cmVkCiAgbnZtZXQ6IGFsbG93IHJlYWRvbmx5IGZpbGUtbnMgdG8g
YmUgY29uZmlndXJlZAoKIGRyaXZlcnMvbnZtZS90YXJnZXQvYWRtaW4tY21kLmMgICB8IDM2ICsr
KysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0KIGRyaXZlcnMvbnZtZS90YXJnZXQvY29uZmln
ZnMuYyAgICB8IDMzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysKIGRyaXZlcnMvbnZtZS90
YXJnZXQvY29yZS5jICAgICAgICB8ICAzICsrLQogZHJpdmVycy9udm1lL3RhcmdldC9pby1jbWQt
YmRldi5jIHwgIDQgKystLQogZHJpdmVycy9udm1lL3RhcmdldC9pby1jbWQtZmlsZS5jIHwgIDIg
Ky0KIGRyaXZlcnMvbnZtZS90YXJnZXQvbnZtZXQuaCAgICAgICB8ICAyICstCiBpbmNsdWRlL2xp
bnV4L252bWUuaCAgICAgICAgICAgICAgfCAgMiArLQogNyBmaWxlcyBjaGFuZ2VkLCA2NCBpbnNl
cnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkKCi0tIAoyLjIyLjEKCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApM
aW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
