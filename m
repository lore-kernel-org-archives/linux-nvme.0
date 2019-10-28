Return-Path: <SRS0=TJkX=YV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A7ACA9EC0
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2019 18:23:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CD5B214B2
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2019 18:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rCU7/cZX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IVhakUxz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CD5B214B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Ka7tIzqezZNvLZbWMZLn9qCjOZWrRwvB9bDE8gvfyHs=; b=rCU7/cZXp6r0J6
	0dNNc9VijHbYenKvNOxTNSK1RvboZAw/wIW/SeE8pNAmiE82b/dcOJIqUnd0lMToH/86pXhhL4fMR
	OY3Us4RYOVTVzJlxbSmNfIe9T0Vs+voxKH//r8cmPQW/mb6SLvyN5TCkCDXjID6ykjhY2md9RGQt6
	9qnI1m+htKnD+hXYPQgMFfEBriTsC7eR+UlSOu8/3dKmnniNdHuZptwHhNTmq2Nb1CHBy5JNfeBwq
	SKUu5ZF9cqY8NFUTCkMcNqmcMqWI7dHdbRxu8tF+qmMQ0ylRbQAFBQEnnpKoX/gj8svc66HkLJq9q
	zjnIIKuu8TJKzrBFH70g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iP9fy-0001dz-DB; Mon, 28 Oct 2019 18:23:34 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iP9fu-0001ZL-9b
 for linux-nvme@lists.infradead.org; Mon, 28 Oct 2019 18:23:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1572287010; x=1603823010;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=/01gYfXSUc77ofu5LtVttmYnwMMJ/d1KzNZuqMsEBKo=;
 b=IVhakUxzfaaJmOiWLC7iIExb521KyclhWIWVWQhgUcHs57agjY4Ugh7F
 h+cN27/Dxhx6BAPJ6b+iJ1WfbUac8oBMRF0jVMl2S/K8ZtL3aC8B+8s1C
 qr+JEFeD1RUsqErc585NFnWH4uQJi2YfGnPEKv6bkr15txclDReW7iyZ3
 /VhfKgvUOYGvTg0eqfKPy66EcWvF0MUZ51nEf+O2l3CDr53gxS2lfrfrE
 Zhb3ibZrJ++EB8QqGlyjQ9srBJ0NbHDeuueVOyHcBZfiCMVRy4vttPSQf
 d+zW3l2JJYGH73P0EEImDZ52/lpg35Z7bx7HWZUC0ztOOoWWDyH5xHCYj w==;
IronPort-SDR: 0ufFnm2l6hrooaykoMHdzk9odDFAVrkjmV0HjU2+RVOINozLNBS6bq5flZVg196gLv85CDeuOW
 /V7kYX51odQMl++Iw01/AKpodeO6ugaLoCA7WwsWgVzYMP+t+EfUWRixUd2XXqm3IpLrGImxg1
 8fC1YM+MWnIpsAX2Z58XQPb+KLS9OS1YVxowkFz85U+xYfBvHhWH1ibwiF1jrnDaWpMm6oH+Z5
 h0qAB0UTJeXpQer9tXTCahzoIQuzCUBmvlQbYkecxJOb9eIFNub/dqSvRLNq384j3L6A9ouqGu
 i7A=
X-IronPort-AV: E=Sophos;i="5.68,240,1569254400"; d="scan'208";a="125916853"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 29 Oct 2019 02:23:28 +0800
IronPort-SDR: XjqCcpiss0sCEUqtBvdOl4lqVyC6RT14JWiGM/266z4gv51Wk1GzBT80aKD6yFP6Iox5XDh2bO
 bzmagvRqw2PqHTGaCoblufmXOX16YYtVMg5kYGhrJooNwnSQIgdoyzx8XR6HBM8RA1RGw3Lkq+
 FIITHHTUORK8DzOVSTgyuWFeBFLs+tLrJvkc4s+saJgiQvhJ42p1UeVHqX9meyzcLwQe7XeA/A
 MFcPFVJq9Wz+/b61Q9CRx86QfybGln8gLU346qXcprs0KCGUCOsR/ysKgHXOgOSDxFfQGytve+
 GtE8Op3dWWKLm8AYZ7wQxlfA
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2019 11:18:48 -0700
IronPort-SDR: SE61Lz/JpzSFoEYZbF2+xbbEA8lvottfXObqfJ6gXmOj2K17ycFc9xoiQ3Kx3/FnjQII6M1jgC
 P9pQ6dW9Odc0wZDZpHZ1H+pxyUzflfHMQflvOHGFZ7SRpEBIjq3o3QL6IixANMbXM5p3w7WMoY
 fmMEjVIUXiOz8cNeL8QPgGlrr7csxti78XHW7+fQguXIpFvjuJACR7IGCremGDSZA8nDJ/w7Z8
 4UB38QI6IkBNil4uOIkPA+aYjxlvOkKAjRQxhm2A9179Z/Pn6OpQXc0gQ0rFfCOpXIkxzeEfMo
 ga0=
WDCIronportException: Internal
Received: from cvenusqemu.hgst.com ([10.202.66.73])
 by uls-op-cesaip02.wdc.com with ESMTP; 28 Oct 2019 11:23:28 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet: add plugging for read/write when ns is bdev
Date: Mon, 28 Oct 2019 11:23:26 -0700
Message-Id: <20191028182326.14311-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191028_112330_381387_89A6451E 
X-CRM114-Status: GOOD (  10.78  )
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
Cc: kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

RnJvbTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+CgpXaXRoIHJlZmVyZW5jZSB0byB0
aGUgZm9sbG93aW5nIGlzc3VlIHJlcG9ydGVkIG9uIHRoZSBtYWlsaW5nIGxpc3QgOi0KaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvcGlwZXJtYWlsL2xpbnV4LW52bWUvMjAxOS1PY3RvYmVyLzAy
NzYwNC5odG1sCnRoaXMgcGF0Y2ggYWRkcyBwbHVnZ2luZyBmb3IgdGhlIGJkZXYtbnMgdW5kZXIg
bnZtZXRfYmRldl9leGVjdXRlX3J3KCkuCgpXZSBjYW4gc2VlIHRoZSBmb2xsb3dpbmcgcGVyZm9y
bWFuY2UgaW1wcm92ZW1lbnQgaW4gcmFuZG9tIHdyaXRlCndvcmtsb2FkIEkvT3Mgd2l0aCB0aGUg
c2V0dXAgZGVzY3JpYmVkIGluIHRoZSBsaW5rIHdoZW4gZGV2aWNlX3BhdGgKY29uZmlndXJlZCBh
cyAvZGV2L21kMC4KCldpdGhvdXQgdGhpcyBwYXRjaCA6LQoKwqAgd3JpdGU6IElPUFM9NDAuOGss
IEJXPTE1OU1pQi9zICgxNjdNQi9zKSg0Nzc3TWlCLzMwMDAybXNlYykKwqAgd3JpdGU6IElPUFM9
NDEuMmssIEJXPTE2MU1pQi9zICgxNjlNQi9zKSg0ODMxTWlCLzMwMDExbXNlYykKwqAgwqAgc2xh
dCAodXNlYyk6IG1pbj04LCDCoG1heD0xMDgyMywgYXZnPTE1LjY0LCDCoHN0ZGV2PTE2Ljg1CsKg
IMKgIHNsYXQgKHVzZWMpOiBtaW49OCwgwqBtYXg9NDAxLCDCoCBhdmc9MTUuNDAsIMKgc3RkZXY9
IDkuNTYKwqAgwqAgY2xhdCAodXNlYyk6IG1pbj01NCwgbWF4PTI0OTIsIMKgYXZnPTc1OS4wNywg
c3RkZXY9MTcyLjYyCsKgIMKgIGNsYXQgKHVzZWMpOiBtaW49NTYsIG1heD0xOTk3LCDCoGF2Zz03
NjguMDYsIHN0ZGV2PTE3OC43MgoKV2l0aCB0aGlzIHBhdGNoIDotCgrCoCB3cml0ZTogSU9QUz0x
MjNrLCBCVz00ODBNaUIvcyAoNTA0TUIvcykoMTQuMUdpQi8zMDAxMW1zZWMpCsKgIHdyaXRlOiBJ
T1BTPTEyM2ssIEJXPTQ4MU1pQi9zICg1MDRNQi9zKSgxNC4xR2lCLzMwMDAybXNlYykKwqAgwqAg
c2xhdCAodXNlYyk6IG1pbj04LCDCoG1heD05OTQxLCDCoGF2Zz0xMy4zMSwgwqBzdGRldj0gOC4w
NArCoCDCoCBzbGF0ICh1c2VjKTogbWluPTgsIMKgbWF4PTI4OSwgwqAgYXZnPTEzLjMxLCDCoHN0
ZGV2PSAzLjM3CsKgIMKgIGNsYXQgKHVzZWMpOiBtaW49NDMsIG1heD0xNzYzNSwgYXZnPTI0NS40
Niwgc3RkZXY9MTcxLjIzCsKgIMKgIGNsYXQgKHVzZWMpOiBtaW49NDQsIG1heD0xNzc1MSwgYXZn
PTI0NS4yNSwgc3RkZXY9MTgzLjE0CgpTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8
aGNoQGxzdC5kZT4KU2lnbmVkLW9mZi1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxjaGFpdGFueWEu
a3Vsa2FybmlAd2RjLmNvbT4KLS0tCiBkcml2ZXJzL252bWUvdGFyZ2V0L2lvLWNtZC1iZGV2LmMg
fCAzICsrKwogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbnZtZS90YXJnZXQvaW8tY21kLWJkZXYuYyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvaW8t
Y21kLWJkZXYuYwppbmRleCAwNGE5Y2QyLi4wN2U0ZjhjIDEwMDY0NAotLS0gYS9kcml2ZXJzL252
bWUvdGFyZ2V0L2lvLWNtZC1iZGV2LmMKKysrIGIvZHJpdmVycy9udm1lL3RhcmdldC9pby1jbWQt
YmRldi5jCkBAIC0xNDcsNiArMTQ3LDcgQEAgc3RhdGljIHZvaWQgbnZtZXRfYmRldl9leGVjdXRl
X3J3KHN0cnVjdCBudm1ldF9yZXEgKnJlcSkKIAlpbnQgc2dfY250ID0gcmVxLT5zZ19jbnQ7CiAJ
c3RydWN0IGJpbyAqYmlvOwogCXN0cnVjdCBzY2F0dGVybGlzdCAqc2c7CisJc3RydWN0IGJsa19w
bHVnIHBsdWc7CiAJc2VjdG9yX3Qgc2VjdG9yOwogCWludCBvcCwgb3BfZmxhZ3MgPSAwLCBpOwog
CkBAIC0xODUsNiArMTg2LDcgQEAgc3RhdGljIHZvaWQgbnZtZXRfYmRldl9leGVjdXRlX3J3KHN0
cnVjdCBudm1ldF9yZXEgKnJlcSkKIAliaW8tPmJpX2VuZF9pbyA9IG52bWV0X2Jpb19kb25lOwog
CWJpb19zZXRfb3BfYXR0cnMoYmlvLCBvcCwgb3BfZmxhZ3MpOwogCisJYmxrX3N0YXJ0X3BsdWco
JnBsdWcpOwogCWZvcl9lYWNoX3NnKHJlcS0+c2csIHNnLCByZXEtPnNnX2NudCwgaSkgewogCQl3
aGlsZSAoYmlvX2FkZF9wYWdlKGJpbywgc2dfcGFnZShzZyksIHNnLT5sZW5ndGgsIHNnLT5vZmZz
ZXQpCiAJCQkJIT0gc2ctPmxlbmd0aCkgewpAQCAtMjA0LDYgKzIwNiw3IEBAIHN0YXRpYyB2b2lk
IG52bWV0X2JkZXZfZXhlY3V0ZV9ydyhzdHJ1Y3QgbnZtZXRfcmVxICpyZXEpCiAJfQogCiAJc3Vi
bWl0X2JpbyhiaW8pOworCWJsa19maW5pc2hfcGx1ZygmcGx1Zyk7CiB9CiAKIHN0YXRpYyB2b2lk
IG52bWV0X2JkZXZfZXhlY3V0ZV9mbHVzaChzdHJ1Y3QgbnZtZXRfcmVxICpyZXEpCi0tIAoxLjgu
My4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGlu
dXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
