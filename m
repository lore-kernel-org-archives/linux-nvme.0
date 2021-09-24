Return-Path: <SRS0=ODQg=OO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D1EC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Sep 2021 21:08:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B098C6140F
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Sep 2021 21:08:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B098C6140F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=I6jSFcOjgjC3F7SXwmlGIx7ycEilzfTQEJ0gaB/Er7M=; b=eoluCfq8G4LMAS
	rD+DlfAviPmqar0ACT1+6qkPoPxPEqVxY3BeooVbuXnPfl+DtzMIrS33y/0o+C2qDz/acaADXB4++
	m5sM/JH+qLDA9X13RmG0UQLu+bZ9kT9K+Hpk9CErfkjgGYUH63EmPeljHmfXxPiQQtVsv0MyvyAGl
	LE7V5H66DsE3tQ2UJghLk9nAq4MUASZ3WZaXRihy+iUDMZ+82KeYhEM75Pv0KeWEiQH6h9OjZJWs/
	KhAgiPfrH1wOKj+9K+3kGi9O5/9CH4lbIuII18RtD16/0kUVgYSXfmxvUAkAk1v5ppYt05jaAOXdc
	SugHonZXYA2OK3h8dcow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mTsQo-00FXHv-8f; Fri, 24 Sep 2021 21:08:30 +0000
Received: from smtp-fw-9102.amazon.com ([207.171.184.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mTsQl-00FXFy-Bp
 for linux-nvme@lists.infradead.org; Fri, 24 Sep 2021 21:08:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1632517708; x=1664053708;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=bytO563cptjEHgdQr+tA7n5yBGInrybpPMl5AoMUUfo=;
 b=vupZY9E1bt3wq+f1TgFyPO0v5ADfd7MjDYHqh2Lp6w7bPG2o1eJdooSy
 UkDzOINv5Lf6XLXPi8qgmcutQB4PP83lExErWXnzbHoru1JnNTw9mB+ea
 lg/gJehDkvS7gcNA/dDBhnJRpXGXSWy91Y7hWb1oL9HSPgxr7eo+XWGBl k=;
X-IronPort-AV: E=Sophos;i="5.85,321,1624320000"; d="scan'208";a="162527696"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO
 email-inbound-relay-pdx-2b-22c2b493.us-west-2.amazon.com) ([10.25.36.214])
 by smtp-border-fw-9102.sea19.amazon.com with ESMTP; 24 Sep 2021 21:08:20 +0000
Received: from EX13MTAUWB001.ant.amazon.com
 (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
 by email-inbound-relay-pdx-2b-22c2b493.us-west-2.amazon.com (Postfix) with
 ESMTPS id 1012141AF5; Fri, 24 Sep 2021 21:08:19 +0000 (UTC)
Received: from EX13D04UWA003.ant.amazon.com (10.43.160.212) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Fri, 24 Sep 2021 21:08:18 +0000
Received: from dev-dsk-nikitina-1d-36de5be9.us-east-1.amazon.com
 (10.43.162.216) by EX13D04UWA003.ant.amazon.com (10.43.160.212) with
 Microsoft SMTP Server (TLS) id 15.0.1497.23; Fri, 24 Sep 2021 21:08:17 +0000
From: Andrey Nikitin <nikitina@amazon.com>
To: <linux-nvme@lists.infradead.org>
CC: <benh@kernel.crashing.org>, <davebuch@amazon.com>, Andrey Nikitin
 <nikitina@amazon.com>
Subject: [RFC PATCH 0/3] nvme sq associations
Date: Fri, 24 Sep 2021 21:08:06 +0000
Message-ID: <20210924210809.14536-1-nikitina@amazon.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Originating-IP: [10.43.162.216]
X-ClientProxiedBy: EX13D44UWC003.ant.amazon.com (10.43.162.138) To
 EX13D04UWA003.ant.amazon.com (10.43.160.212)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210924_140827_485802_727A166D 
X-CRM114-Status: UNSURE (   9.70  )
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

VGhlIE5WTWUgc3BlY2lmaWNhdGlvbiBhbGxvd3MgZm9yIG5hbWVzcGFjZXMgd2l0aCBkaWZmZXJl
bnQgcGVyZm9ybWFuY2UKY2hhcmFjdGVyaXN0aWNzLCBhcyB3ZWxsIGFzIGFsbG93aW5nIElPcyBz
dWJtaXNzaW9ucyB0byBhbnkgbmFtZXNwYWNlIHZpYQphbnkgbm9uLWVtcHR5IHN1Ym1pc3Npb24g
cXVldWUuIEhvd2V2ZXIsIHNoYXJpbmcgcXVldWUgcmVzb3VyY2VzIGJldHdlZW4KbmFtZXNwYWNl
cyB3aXRoIGRpZmZlcmVudCBwZXJmb3JtYW5jZSBjaGFyYWN0ZXJpc3RpY3MgY2FuIGNhdXNlIHVu
ZGVzaXJlZApiZWhhdmlvciAoZS5nLiBoZWFkLW9mLWxpbmUtYmxvY2tpbmcgZm9yIElPcyB0aGF0
IHRhcmdldCBhIGhpZ2gtcGVyZm9ybWFuY2UKbmFtZXNwYWNlIGJlaGluZCBJT3MgdGhhdCB0YXJn
ZXQgYSBsb3cgcGVyZm9ybWFuY2UgbmFtZXNwYWNlIHZpYSB0aGUgc2FtZQpxdWV1ZSkuIEluIGFk
ZGl0aW9uLCB0aGUgbGFjayBvZiBoYXJkd2FyZSBxdWV1ZSBpc29sYXRpb24gc3VwcG9ydCBjYW4g
Y2F1c2UK4oCcbm9pc3kgbmVpZ2hib3LigJ0gdHlwZSBwcm9ibGVtcyBmb3IgYXBwbGljYXRpb25z
IGlzc3VpbmcgSU9zIHRvIGRpZmZlcmVudApuYW1lc3BhY2VzIG9mIHRoZSBzYW1lIGNvbnRyb2xs
ZXIuIFRoaXMgcHJvYmxlbSBtYXkgYmUgZXNwZWNpYWxseSBwcm9ub3VuY2VkCmluIG11bHRpLXRl
bmFudCBlbnZpcm9ubWVudHMgc3VjaCBhcyB0aGUgb25lcyBwcm92aWRlZCBieSBjbG91ZCBzZXJ2
aWNlcy4KClRoZSBOVk1lIDEuNCBzcGVjaWZpY2F0aW9uIGhhcyBpbnRyb2R1Y2VkIHNvbWUgb3B0
aW9uYWwgZmVhdHVyZXMgKE5WTSBzZXRzCmFuZCBTUSBhc3NvY2lhdGlvbnMpIHRoYXQgY2FuIGJl
IHV0aWxpemVkIHRvIGltcHJvdmUgdGhpcyBzaXR1YXRpb24gcHJvdmlkZWQKdGhlc2UgZmVhdHVy
ZXMgYXJlIHN1cHBvcnRlZCBieSBib3RoIGNvbnRyb2xsZXJzIGFuZCBob3N0IGRyaXZlcnMuIE5h
bWVzcGFjZXMKY2FuIGJlIGFzc2lnbmVkIHRvIE5WTSBzZXRzIChieSBwZXJmb3JtYW5jZSBjaGFy
YWN0ZXJpc3RpY3MsIGZvciBleGFtcGxlKQp3aGljaCBlYWNoIE5WTSBzZXQgaGF2aW5nIGl0cyBv
d24gc2V0IG9mIGFzc29jaWF0ZWQgcXVldWVzLgoKVGhpcyBwYXRjaCBzZXJpZXMgcHJvcG9zZXMg
YSBzaW1wbGUgaW1wbGVtZW50YXRpb24gb2YgTlZNIHNldHMgYW5kClNRIGFzc29jaWF0aW9ucyBm
b3IgdGhlIE5WTWUgaG9zdCBQQ0kgbW9kdWxlLiAgQSBjb250cm9sbGVyIHRoYXQgc3VwcG9ydHMK
dGhlc2UgZmVhdHVyZXMsIGFsb25nIHdpdGggYSBzdWZmaWNpZW50IG51bWJlciBvZiBxdWV1ZSBw
YWlycyAoYXQgbGVhc3QKb25lIHBlciBOVk0gc2V0KSwgd2lsbCBoYXZlIHRoZSBhdmFpbGFibGUg
cXVldWUgcGFpcnMgYXNzb2NpYXRlZCB1bmlmb3JtbHkKYWNyb3NzIGVhY2ggTlZNIHNldC4gSU8g
cmVxdWVzdHMgZGlyZWN0ZWQgYXQgdGhlIGNvbnRyb2xsZXIgd2lsbCBob25vcgp0aGUgbmFtZXNw
YWNlL05WTSBzZXQvcXVldWUgYXNzb2NpYXRpb24gYnkgdmlydHVlIG9mIGVhY2ggTlZNIHNldCBo
YXZpbmcKaXRzIG93biBibGstbXEgdGFnc2V0IGFzc29jaWF0ZWQgd2l0aCBpdC4KCkFuZHJleSBO
aWtpdGluICgzKToKICBudm1lOiBzcGxpdCBhZG1pbiBxdWV1ZSBpbiBwY2kKICBudm1lOiBhZGQg
TlZNIHNldCBzdHJ1Y3R1cmVzCiAgbnZtZTogaW1wbGVtZW50IFNRIGFzc29jaWF0aW9ucwoKIGRy
aXZlcnMvbnZtZS9ob3N0L2NvcmUuYyAgIHwgIDE4ICstCiBkcml2ZXJzL252bWUvaG9zdC9mYy5j
ICAgICB8ICAgMSArCiBkcml2ZXJzL252bWUvaG9zdC9udm1lLmggICB8ICAxMCArCiBkcml2ZXJz
L252bWUvaG9zdC9wY2kuYyAgICB8IDM2MyArKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0t
LS0tLS0tCiBkcml2ZXJzL252bWUvaG9zdC9yZG1hLmMgICB8ICAgMSArCiBkcml2ZXJzL252bWUv
aG9zdC90Y3AuYyAgICB8ICAgMSArCiBkcml2ZXJzL252bWUvdGFyZ2V0L2xvb3AuYyB8ICAgMSAr
CiBpbmNsdWRlL2xpbnV4L252bWUuaCAgICAgICB8ICAxMSArLQogOCBmaWxlcyBjaGFuZ2VkLCAy
ODYgaW5zZXJ0aW9ucygrKSwgMTIwIGRlbGV0aW9ucygtKQoKLS0gCjIuMzIuMAoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGlu
ZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
