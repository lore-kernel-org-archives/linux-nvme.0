Return-Path: <SRS0=H+rW=EL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80377C4741F
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2020 03:43:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06E0E2072E
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2020 03:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ukme+gjw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ncx/p/p9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kYvi+DHO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06E0E2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=GfPp5f0j6KOGup9LfvFT6kKwiO8VEWSUkC5dIiH2zYw=; b=Ukme+gjwu57iPeFAi5w3gRmG5W
	+O92qhOB2A8bT5ycd5A+4QlqTgasZbHBFQxxpu4a7dh/7D05gADkuJajfHYEFC8dbO7DCeYrt+/OQ
	iRqed7WqwalV/bjbigNu9K/jWPm6mI6CiDDcT4y7OjFzB68cthggkI7ufl7V5mIZC5JR0YA+LPne7
	181Szm83R8VKqe5zFliZd3FP/0SG2yfX1jVfwH/x3QjsqJfe7wTZNveA6rVbE/F9lo6fEkZ14Hg4/
	6DExq9Fy0DPfqbyW6Gs9G+Tcoacikg9yZjFFkp2BzpkKkEY0DF0Y6Mg/DTklazA63BmxciT+vVUk+
	oOUv1RZA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kaWBJ-0004Ci-Of; Thu, 05 Nov 2020 03:43:25 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kaW9X-00038y-Ot
 for linux-nvme@merlin.infradead.org; Thu, 05 Nov 2020 03:41:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=DzgQ3jLOhxDdsRSoyiPv0VCKLvXpE422zqo+SmRM52w=; b=ncx/p/p9hvf6iJOAdfVFk7mKFg
 Vm1jntmQEtFEdQXGNqN/IG22Fy/mifPnSCO4bSRRUq5Hw8RtEVcbizbFu4yaBZziKUolRoaFZypsV
 kFjqy8puP17LoAOQINdqZ+MSmAV6iQi9skwdMnpXw/7iB8V36knbJwHeKdizZiWy8bYxU0mXr+IBo
 ddvFk1bzK5wr97xbir32fS+JD9s0ZM7EWh4OwEcrbNo8nu07pqUVxdEF3QhOQjt1enoucLVBYQWOL
 xg7DD4UY82JbHOvk/sWginDs191R/r6aeRxs1gbQwVSO3xrnwe1GBprx0UfbF9mX2Aj+vavp0hZ83
 KFXx/8UA==;
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kaPXg-0005cH-9u
 for linux-nvme@lists.infradead.org; Wed, 04 Nov 2020 20:38:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604522284; x=1636058284;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=hwIEslx9xb5XQHOiN2xCO/SRx37orr1oV0h1TutTrSo=;
 b=kYvi+DHO65gNiykOoa9BtvSDHP9G1Bp2RYOdlEGY2Y7MgGJgbwWBWTWW
 Fg4sVjfSLGw7qrQu2Eu5A3LADxF2mv3sur2S5cTSd4cN6z138RO2tSi/i
 P/Ddmf5ZuXtAYLhb+KylFzOmHBVthLOnH7yvbL766OczPfGK4LxCHu5My
 nkt52dqwKwe8Wq7IP2JJK9KtCKWCFhfvfrbP5cEU5bfx/YNE7iHgO4ERF
 6bKTdgyRIvYP9sy8I6GePhVr+XjvTlsxZjCdeB5ECEZUIF3IltUR1GtD/
 HafcpjZKJ5tDb/zStEgDMP0Bq3ZWee3FHra/3PPEZE+MZ7cR+uJvSit3J A==;
IronPort-SDR: pfcmbKAxDa+d+9p6O/Cjlpujt4n06rSnFAJ4Z+pV/6vU5cUX8BkRp0yDz6JGnZOimkvU1vjfn7
 zmk32AgO9sB8hpuykef3RWIpcANEUdhQVzXCoRytPAGHmp+gbqJyUi2R2gGzMslHV7L3UYwkEW
 DkP31NslOaO9vfFcCDGvGBV+v9Bs/x+jXpEFf0L74oY9XCo8ephkHhUTQxKw0oVYy+/k/FwwaB
 MaB7oLdkw3fssKqiR15rR5onNUJxFATrvm3qiGpqHtaJCHFpIy+m6gLu99JUZXENV6I9I8KlRi
 Zoo=
X-IronPort-AV: E=Sophos;i="5.77,451,1596470400"; d="scan'208";a="151931238"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 05 Nov 2020 04:37:39 +0800
IronPort-SDR: Dj3x4sMgCva2oOA4X2y1FPCIjgPYCf6LPhqOLkBhk/CRoREMnOmzYVMlmULDffh+MaC5on0f/b
 8dpeu8d24fQ2dO9SBO+erKrvn248TBngtyXiWrVn63sMw1ThIKSB1esOvoCoIYybc5UOoT4Ed8
 XvLZfzeUim2/4BMb47AZnwTYuy0bh/AdtvEm8b941QMSD7eEj/TKgS/rYuN4Mp5IO8Zw1XBXbJ
 egcpZLclTKim6wBCT7F7Q55NXwLhxEFPXyaGGkNqTlDf4Q6thy5LGlPLxNnLNBMfSbN+YqPe2Q
 TqR87JnmBoeZCOH1a3gDRMz3
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2020 12:22:36 -0800
IronPort-SDR: 4temKUo5S1R8P6WXC5CBFHCTMsEoN+/pYOdcMpQyIIBJ22b/J6MJwZdV0/QljenziSgt7EwXRa
 lpeI11fJMAd0IA1hFZ83Qn+J8EzdHst2pi0vbsZMY+p9FQASMU7c00tF76I/RaLpE+r+kxGWQb
 67Nla7drQ4Xbtl3iE8BIwLFDMUMRTCOXy1e2PHnmn978i7qzhwdHOfXVHxPo83aLRlapV3SEmG
 jVCe7rpT58dyvK2q0yME1EZKeWYBm/I43VbDZQMqCyFq2TmE95P2cHev9ImvIuJUxyIacXiAVZ
 IBI=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 04 Nov 2020 12:37:39 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V6 0/5] nvme-core: timeout related fixes and cleanup 
Date: Wed,  4 Nov 2020 12:37:31 -0800
Message-Id: <20201104203736.62745-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201104_203805_069773_AA4E6575 
X-CRM114-Status: GOOD (  22.25  )
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
Cc: kbusch@kernel.org, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SGksCgpUaGlzIHBhdGNoIHNlcmllcyB1c2VzIE5WTUVfSU9fVElNRU9VVCBmb3IgdGhlIHN5bmMg
cmVxdWVzdCBzdWJtaXNzaW9uCmFuZCB1c2VyIHJlcXVlc3Qgc3VibWlzc2lvbiB3aGVuIHRoZSB0
aW1lb3V0IGlzIG5vdCBzcGVjaWZpZWQgYnkgdGhlIApjYWxsZXIgYW5kIHJlcXVlc3QgcXVldWUg
ZGF0YSBpcyBzZXQgdG8gTlVMTCB3aGljaCBpcyB0cnVlIGZvciBhZG1pbiAKcXVldWUuCgpBbHNv
IGluIHRoaXMgdmVyc2lvbiwgSSd2ZSBhZGRlZCB0aW1lb3V0IHZhbHVlcyBzZXR0aW5nIGZvciB0
aGUgTlZNZU9GCnBhc3N0aHJ1IGNvbnRyb2xsZXIgZ2l2ZW4gdGhhdCBwYXNzdGhydSBWVUNzIChi
b3RoIGFkbWluIGFuZCBJL08gVlVDcykKY2FuIGRpZmZlciBpbiBleGVjdXRpb24gdGltZSB0aGFu
IGdlbmVyYWwtcHVycG9zZSBhZG1pbiBhbmQgSS9PIGNvbW1hbmQKc2V0IGZvbGxvd2luZyBpcyB0
aGUgZGV0YWlsZWQgc2NlbmFyaW8gOi0KCkNvbnNpZGVyIE5WTWVPRiB0YXJnZXQgaXMgc2V0dXAg
aW4gdGhlIHBhc3N0aHJ1IG1vZGUgYW5kIGJvdGggdGFyZ2V0CmFuZCBob3N0IG1vZHVsZXMgYXJl
IGxvYWRlZCB3aXRoIHRoZSBkZWZhdWx0IHRpbWVvdXQgdmFsdWVzIHByZXNlbnQKaW4gdGhlIG52
bWUtY29yZS4KCjEuIFVzZXIgaXNzdWVzIG52bWUgY21kIGZyb20gdGhlIGhvc3QgdG8gdGhlIHRh
cmdldCBvZiBudm1lLWNsaSB3aGVyZQrCoCDCoHRpbWVvdXQgaXMgdGFrZW4gZnJvbSB0aGUgY29u
dHJvbGxlciBsb2cgcGFnZSDCoGUuZy4gOi0KwqAgwqAjIG52bWUgaW8tcGFzc3RocnUgLS10aW1l
b3V0PVhYWCAuLi4gCsKgIMKgT1IgwqAKwqAgwqAjIG52bWUgYWRtaW4tcGFzc3RocnUgLS10aW1l
b3V0PVhYWCAuLi4gCsKgIMKgVGhlIHRpbWVvdXQgdmFsdWUgaW4gdGhlIGFib3ZlIGV4YW1wbGUg
aXMgZ3JlYXRlciB0aGFuIHRoZSBkZWZhdWx0CsKgIMKgdGltZW91dCB2YWx1ZSBwcmVzZW50IGlu
IGhvc3QtY29yZSBmb3IgYm90aCBvbiBob3N0IG1hY2hpbmUgYW5kIHRoZSAKwqAgwqB0YXJnZXQg
bWFjaGluZS4KMi4gVGhlIGhvc3QtY29yZSBvbiB0aGUgaG9zdCBzaWRlIHdpbGwgc2V0IHRoZSB0
aW1lb3V0IGZvciB0aGUgaG9zdArCoCDCoHJlcXVlc3QgYW5kIGlzc3VlcyBOVk1lIGNtZCBvdmVy
IHRyYW5zcG9ydC4KMy4gSW4gdGhlIGFic2VuY2Ugb2YgWzFdIHRhcmdldCB3aWxsIHNldCB0aGUg
dGltZW91dCB2YWx1ZSB3aGljaCBpcwrCoCDCoGRlZmF1bHQgdGltZW91dCBhbmQgdGhhdCBpcyBz
bWFsbGVyIHRoYW4gdGhlIHRpbWVvdXQgc2V0IG9uIHRoZSBob3N0CsKgIMKgc2lkZS4KNC4gRHVl
IHRvIGxhY2sgb2YgdGltZW91dCB2YWx1ZSBub3QgcGFzc2VkIG92ZXIgdGhlIHRyYW5zcG9ydCBs
ZWFkaW5nCsKgIMKgdG8gc21hbGxlciB0aW1lb3V0IHZhbHVlIGZvciB0aGUgcmVxdWVzdCBvbiB0
aGUgdGFyZ2V0IHRoYW4gdGhlIGhvc3QKwqAgwqBzaWRlLCB0YXJnZXQgc2lkZSBjb21tYW5kIHdp
bGwgdGltZW91dC4KwqAgwqAKwqAgwqBUaGlzIGJyZWFrcyB0aGUgc2NlbmFyaW8gd2hlcmUgdGhl
IHNhbWUgY29tbWFuZCB3aXRoIHRpbWVvdXQgdmFsdWUKICAgZnJvbSBudm1lLWNsaSBpcyBhYmxl
IHRvIGV4ZWN1dGUgd2l0aCBzdWNjZXNzIHdoZW4gaXNzdWVkIHRvIE5WTWUKICAgUENJZSBjdHJs
IGJ1dCB3aWxsIGZhaWwgd2hlbiBpdCBpcyBleGVjdXRlZCBvbiB0aGUgTlZNZU9GIFBhc3N0aHJ1
CiAgIGN0cmwuCgpUaGUgbGFzdCBwYXRjaCBjZW50cmFsaXplcyB0aGUgc2V0dGluZyBvZiB0aGUg
cmVxdWVzdCBlbmRfaW9fZGF0YQpwYXJhbWV0ZXIgaW50byBudm1lX2FsbG9jX3JlcXVlc3QoKSBz
aW1pbGFyIHRvIHdoYXQgd2UgaGF2ZSBkb25lIGZvcgpzZXR0aW5nIHVwIHRoZSByZXF1ZXN0IHRp
bWVvdXQgdmFsdWUgaW4gdGhpcyB2ZXJzaW9uLgoKUmVnYXJkcywKQ2hhaXRhbnlhCgpbMV0gbnZt
ZXQ6IGFkZCBwYXNzdGhydSBhZG1pbiB0aW1lb3V0IHZhbHVlIGF0dHIKICAgIG52bWV0OiBhZGQg
cGFzc3RocnUgaW8gdGltZW91dCB2YWx1ZSBhdHRyCgoqIENoYW5nZXMgZnJvbSBWNTotCgoxLiBS
ZWJhc2Ugb24gdGhlIGxhdGVzdCBudm1lLTUuMTAuCjIuIENlbnRyYWxpemUgc2V0dGluZyB1cCB0
aGUgcmVxdWVzdC0+dGltZW91dCB2YWx1ZSBpbnRvCiAgIG52bWVfYWxsb2NfcmVxdWVzdCgpLgoz
LiBDZW50cmFsaXplIHNldHRpbmcgdXAgdGhlIHJlcXVlc3QtPmVuZF9pb19kYXRhIHZhbHVlIGlu
dG8KICAgbnZtZV9hbGxvY19yZXF1ZXN0KCkuCjQuIFVwZGF0ZSB0aGUgTlZNZU9GIHBhc3N0aHJ1
IG52bWV0X3Bhc3N0aHJ1X2V4ZWN1dGVfY21kKCkgc3VjaCB0aGF0CiAgIGl0IHJlbGZlY3QgbnZt
ZV9hbGxvY19yZXF1ZXN0KCkgY2hhbmdlcyBmcm9tIHRoZSBmaXJzdCBwYXRjaCB3aGVuCiAgIGhh
bmRsaW5nIGlvIGFuZCBhZG1pbiB0aW1lb3V0cy4KNS4gTW92ZSBudm1lX3JlcV9zZXRfZGVmYXVs
dF90aW1lb3V0KCkgdG8gaG9zdC9jb3JlLmMgc2luY2UgdGhlcmUgaXMKICAgb25seSBvbmUgY2Fs
bGVyIG5vdy4KCiogQ2hhbmdlcyBmcm9tIFY0Oi0KCjEuIFJlYmFzZSBhbmQgcmV0ZXN0IG9uIG52
bWUtNS4xMC4KCiogQ2hhbmdlcyBmcm9tIFYzOi0KCjEuIFJlYmFzZSBhbmQgcmV0ZXN0IG9uIG52
bWUtNS4xMC4KMi4gVXBkYXRlIHRoZSBjb3Zlci1sZXR0ZXIgd2l0aCBkZXRhaWxlZCBzY2VuYXJp
byB3aHkgTlZNZU9GIHRhcmdldAogICBwYXNzdGhydSBpcyBuZWVkZWQuCjMuIFdyYXAgdGhlIGxp
bmUgdW5kZXIgODAgY2hhciBmb3IgdGhlIGxhc3QgcGF0Y2guCjQuIENoYW5nZSB0aGUgbnZtZV9k
ZWZhdWx0X3RpbWVvdXQoKSAtPiBudm1lX3NldF9yZXFfZGVmYXVsdF90aW1lb3V0KCkKICAgc3Vj
aCB0aGF0IGl0IHdpbGwgbm90IHRha2UgdGltZW91dCBhcmd1bWVudC4KCiogQ2hhbmdlcyBmcm9t
IFYyOi0KCjEuIEludHJvZHVjZSBudm1lX2RlZmFsdF90aW1lb3V0KCkgaGVscGVyIGFuZCB1c2Ug
aXQgaW4gaG9zdC9jb3JlLmMuCjIuIFVzZSBudm1lX2RlZmF1bHRfdGltZW91dCgpIGluIHRoZSBs
aWdodG52bWUuYwoKKiBDaGFuZ2VzIGZyb20gVjE6LQoKMS4gSW5zdGVhZCBvZiB1c2luZyBxaWQg
dG8gZGVjaWRlIElPIG9yIEFETUlOIHRpbWVvdXQgdXNlIHJlcXVlc3QKICAgcXVldWUncyBxdWV1
ZWRhdGEgd2hjaCB3ZSBvbmx5IHNldCBmb3Igbm9uIGFkbWluIHF1ZXVlCiAgIF9fbnZtZV9zdWJt
aXRfc3luY19jbWQoKS4KMi4gQWRkIHNlY29uZCBwYXRjaCB0byBzZXQgSU8gdGltZW91dCBmb3Ig
bnZtZV9zdWJtaXRfdXNlcl9jbWQoKS4KMy4gU2V0IHRoZSBOVk1lT0YgcGFzc3RocnUgY3RybCB0
aW1lb3V0IHZhbHVlcyB3aXRoIGRlZmF1bHQgdmFsdWVzIGZyb20KICAgbnZtZS1jb3JlIG1vZHVs
ZS4KNC4gQWRkIGFkbWluIGFuZCBJL08gdGltZW91dCBjb25maWdmcyBhdHRyaWJ1dGVzIGZvciBO
Vk1lT0YgcGFzc3RocnUKICAgY29udHJvbGxlci4KCkNoYWl0YW55YSBLdWxrYXJuaSAoNSk6CiAg
bnZtZTogY2VudHJhbGl6ZSBzZXR0aW5nIHJlcSB0aW1lb3V0CiAgbnZtZXQ6IGFkZCBwYXNzdGhy
dSBhZG1pbiB0aW1lb3V0IHZhbHVlIGF0dHIKICBudm1ldDogYWRkIHBhc3N0aHJ1IGlvIHRpbWVv
dXQgdmFsdWUgYXR0cgogIG52bWU6IHVzZSBjb25zaXN0ZW50IG1hY3JvIG5hbWUgZm9yIHRpbWVv
dXQKICBudm1lOiBjZW50cmFsaXplIHNldHRpbmcgcmVxIGVuZF9pb19kYXRhCgogZHJpdmVycy9u
dm1lL2hvc3QvY29yZS5jICAgICAgIHwgMzUgKysrKysrKysrKysrLS0tLS0tLQogZHJpdmVycy9u
dm1lL2hvc3QvZmMuYyAgICAgICAgIHwgIDIgKy0KIGRyaXZlcnMvbnZtZS9ob3N0L2xpZ2h0bnZt
LmMgICB8ICA5ICsrKy0tCiBkcml2ZXJzL252bWUvaG9zdC9udm1lLmggICAgICAgfCAgNSArLS0K
IGRyaXZlcnMvbnZtZS9ob3N0L3BjaS5jICAgICAgICB8IDE1ICsrKystLS0tCiBkcml2ZXJzL252
bWUvaG9zdC9yZG1hLmMgICAgICAgfCAgMiArLQogZHJpdmVycy9udm1lL2hvc3QvdGNwLmMgICAg
ICAgIHwgIDIgKy0KIGRyaXZlcnMvbnZtZS90YXJnZXQvY29uZmlnZnMuYyB8IDY0ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysKIGRyaXZlcnMvbnZtZS90YXJnZXQvbG9vcC5jICAg
ICB8ICAyICstCiBkcml2ZXJzL252bWUvdGFyZ2V0L252bWV0LmggICAgfCAgMiArKwogZHJpdmVy
cy9udm1lL3RhcmdldC9wYXNzdGhydS5jIHwgMTIgKysrKysrLQogMTEgZmlsZXMgY2hhbmdlZCwg
MTE3IGluc2VydGlvbnMoKyksIDMzIGRlbGV0aW9ucygtKQoKLS0gCjIuMjIuMQoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGlu
ZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
