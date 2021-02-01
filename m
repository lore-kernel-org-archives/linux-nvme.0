Return-Path: <SRS0=DeHG=HD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD22C433E6
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 05:42:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 778D564E15
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 05:42:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 778D564E15
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jKWU60WEtnRffqjSRWmewb/mTXEyb1QTQQMxZFezL1Q=; b=ZJesLymm9Vkzde25k3Snard8V
	IhWo6wvjlBbioB8r+S2zDonnNnG2T0QXs5EIzMQUGgpc8hL1enBwrY9ahGyWw+TaL1Acng0xnNV10
	VubpVMGiv7hdynJvDXiEF9uPOGMqKejjNt5Di1SKrqtQbmNgwzxwNUfG9adBCIArczSzxYI6gizWo
	N+/Hv9bPJNuT6rP2SfbqF1Hnkm5t/hcMQuFa+dg0dnBlvYQ527Ti2rOdriQceBxyuCeN22j8W3OMC
	bUSPxovcStEoELyrnmBeRORcB+ovliuW+j1FjpPK3I+nb8pETCNMEx4FvjGHYKExGfAOSoSWOyuie
	yoBAe6x/g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6RzC-00057P-1Q; Mon, 01 Feb 2021 05:42:54 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6Rz7-00055J-PH
 for linux-nvme@lists.infradead.org; Mon, 01 Feb 2021 05:42:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612158169; x=1643694169;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HLNCgs6FmGmZpmRQvprKO971sRF9/BEIJ/U3TacA39k=;
 b=VZPUozbeI1hcBjZmjhr9cjnTOmvtfIkZ0gUmRtY9UXC3rCzrY1oSN5Q0
 BskwnYUrijYo0PjvXOLUe3xs6a2q97Hs5pTXvR49+USu+9RXFHwzwqjun
 B1e0K9M5YLSNkuxVkXnDMLdlIF5RuOHYozwGyk5sCZuPdGeEgP+q24Ash
 A1hIZzq3AMjpDye9zuF6gtncVeOHFZc0gSVgmSMzpO0ibCDHA93wckOZG
 o+6zqs37qJD08KHMUqMI83lru3ve+0ABYXgHZnrnGIHrV9zPgzgTFjuUS
 N+83UIgSkvd/756M62Hy7HMhSn12iKAgzysKoMy+vhqPwZWh82fgJhoCV g==;
IronPort-SDR: S6dLhIuGNPa6Je1mu0KuUjnr7e4/qFjKkyoZCIrrJGsAmXo3pm675fNoV/2x7kcz+aXOuA4alL
 1hEjM+B1DVUCwd9uis/Au81BTHePZgIbUIyqhrJTsYkMuHBRkc9JXOH225Kx7qvAlw+EKo8V41
 hGfAcdQC/OXc9ZWyp9PjcAP+PuXqOj9Emp0NOi/5LOEJUBxpLeV7vHadVED1m8QMFm1SbpzU0v
 3Jkhc0+6Xt71BXdNa2wPIDbQ9WSAMKRxIzp5lVAaSPqii9CiyUUdRrx8cw4OAQZRf5kofdfkhB
 e+0=
X-IronPort-AV: E=Sophos;i="5.79,391,1602518400"; d="scan'208";a="158785543"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2021 13:42:47 +0800
IronPort-SDR: E0E1Z4x3W5ybrsrWaXIpNkKgbkEU9+6l6vHEAwnRRAqt3Gvx1deAojzLGyV7Hg0B3Bdk1KmZx+
 4JPheFh9Wg6WnJ3mniNi04O6sVtPDB2up8r3CpPWYj7m5Pw498xYxzvtY+GzYLG0khP6w5XZ+3
 OHDvkk1nVgrVTPpsQ4zS+6uJVmKTCPP2KO0rqS795lKtgU10iVXaSWmehfkO1gbD6uu7IB1PiW
 XrdvNODcjwjQreA2T83cVUaua9lcBmaWEiuoUJBcwcn+O1Fz1wfCK/A8FTZc0Ex5jbV511Y9nZ
 8NEETm/r4W1bQh7+LwocpbfX
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2021 21:24:58 -0800
IronPort-SDR: vYEyr0OK4mhdWywCTxWQu4/lbtIuFUQcYfoeylTKWwUd7eKBmn7mwUs1NN0IuwmzjllSVMyjVf
 lPohBKQ8rQJtyjBnrab5D3/yJ+MhncK8R4X4s2SQzOzBhF4SxaNnvd1SdvaShPXLJZQsCcMJ67
 azAF5kk8s9460H5zaAOsnbxLxSMRnonIGRVGo69V8M//3kvmJaj20rkdwbfxHNV2Sve4U89ek4
 WzCSC2l7TZfMWhC8+nVhShYVJZIuQafzIirL9y0flURKxyDu/Yox5J6gGjsbYSkHmDk+i27zOb
 dSo=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 31 Jan 2021 21:42:49 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 09/10] nvmet: use min of device_path and disk len
Date: Sun, 31 Jan 2021 21:41:37 -0800
Message-Id: <20210201054138.34324-10-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210201054138.34324-1-chaitanya.kulkarni@wdc.com>
References: <20210201054138.34324-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_004250_477226_34341D24 
X-CRM114-Status: GOOD (  13.63  )
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

SW4gZnVuY3Rpb24gX19hc3NpZ25fcmVxX25hbWUoKSBpbnN0ZWFkIG9mIHVzaW5nIHRoZSBERVZJ
Q0VfTkFNRV9MRU4gaW4Kc3RybmNweSgpIHVzZSBtaW4gb2YgRElTS19OQU1FX0xFTiBhbmQgc3Ry
bGVuKHJlcS0+bnMtPmRldmljZV9wYXRoKS4KClRoaXMgaXMgbmVlZGVkIHRvIHR1cm4gb2ZmIHRo
ZSBmb2xsb3dpbmcgd2FybmluZ3M6LQoKSW4gZmlsZSBpbmNsdWRlZCBmcm9tIGRyaXZlcnMvbnZt
ZS90YXJnZXQvY29yZS5jOjE0OgpJbiBmdW5jdGlvbiDigJhfX2Fzc2lnbl9yZXFfbmFtZeKAmSwK
ICAgIGlubGluZWQgZnJvbSDigJh0cmFjZV9ldmVudF9yYXdfZXZlbnRfbnZtZXRfcmVxX2luaXTi
gJkgYXQgZHJpdmVycy9udm1lL3RhcmdldC8uL3RyYWNlLmg6NTg6MToKZHJpdmVycy9udm1lL3Rh
cmdldC90cmFjZS5oOjUyOjM6IHdhcm5pbmc6IOKAmHN0cm5jcHnigJkgc3BlY2lmaWVkIGJvdW5k
IDMyIGVxdWFscyBkZXN0aW5hdGlvbiBzaXplIFstV3N0cmluZ29wLXRydW5jYXRpb25dCiAgIHN0
cm5jcHkobmFtZSwgcmVxLT5ucy0+ZGV2aWNlX3BhdGgsIERJU0tfTkFNRV9MRU4pOwogICBefn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgpJbiBmdW5jdGlv
biDigJhfX2Fzc2lnbl9yZXFfbmFtZeKAmSwKICAgIGlubGluZWQgZnJvbSDigJhwZXJmX3RyYWNl
X252bWV0X3JlcV9jb21wbGV0ZeKAmSBhdCBkcml2ZXJzL252bWUvdGFyZ2V0Ly4vdHJhY2UuaDox
MDA6MToKZHJpdmVycy9udm1lL3RhcmdldC90cmFjZS5oOjUyOjM6IHdhcm5pbmc6IOKAmHN0cm5j
cHnigJkgc3BlY2lmaWVkIGJvdW5kIDMyIGVxdWFscyBkZXN0aW5hdGlvbiBzaXplIFstV3N0cmlu
Z29wLXRydW5jYXRpb25dCiAgIHN0cm5jcHkobmFtZSwgcmVxLT5ucy0+ZGV2aWNlX3BhdGgsIERJ
U0tfTkFNRV9MRU4pOwogICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fgpJbiBmdW5jdGlvbiDigJhfX2Fzc2lnbl9yZXFfbmFtZeKAmSwKICAgIGlubGlu
ZWQgZnJvbSDigJhwZXJmX3RyYWNlX252bWV0X3JlcV9pbml04oCZIGF0IGRyaXZlcnMvbnZtZS90
YXJnZXQvLi90cmFjZS5oOjU4OjE6CmRyaXZlcnMvbnZtZS90YXJnZXQvdHJhY2UuaDo1MjozOiB3
YXJuaW5nOiDigJhzdHJuY3B54oCZIHNwZWNpZmllZCBib3VuZCAzMiBlcXVhbHMgZGVzdGluYXRp
b24gc2l6ZSBbLVdzdHJpbmdvcC10cnVuY2F0aW9uXQogICBzdHJuY3B5KG5hbWUsIHJlcS0+bnMt
PmRldmljZV9wYXRoLCBESVNLX05BTUVfTEVOKTsKICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KSW4gZnVuY3Rpb24g4oCYX19hc3NpZ25fcmVxX25h
bWXigJksCiAgICBpbmxpbmVkIGZyb20g4oCYdHJhY2VfZXZlbnRfcmF3X2V2ZW50X252bWV0X3Jl
cV9jb21wbGV0ZeKAmSBhdCBkcml2ZXJzL252bWUvdGFyZ2V0Ly4vdHJhY2UuaDoxMDA6MToKZHJp
dmVycy9udm1lL3RhcmdldC90cmFjZS5oOjUyOjM6IHdhcm5pbmc6IOKAmHN0cm5jcHnigJkgc3Bl
Y2lmaWVkIGJvdW5kIDMyIGVxdWFscyBkZXN0aW5hdGlvbiBzaXplIFstV3N0cmluZ29wLXRydW5j
YXRpb25dCiAgIHN0cm5jcHkobmFtZSwgcmVxLT5ucy0+ZGV2aWNlX3BhdGgsIERJU0tfTkFNRV9M
RU4pOwogICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fgoKU2lnbmVkLW9mZi1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxjaGFpdGFueWEua3Vsa2FybmlA
d2RjLmNvbT4KLS0tCiBkcml2ZXJzL252bWUvdGFyZ2V0L3RyYWNlLmggfCA0ICsrKy0KIDEgZmls
ZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL252bWUvdGFyZ2V0L3RyYWNlLmggYi9kcml2ZXJzL252bWUvdGFyZ2V0L3RyYWNlLmgK
aW5kZXggYzE0ZTMyNDlhMTRkLi45NThkY2E3YmNmYzcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbnZt
ZS90YXJnZXQvdHJhY2UuaAorKysgYi9kcml2ZXJzL252bWUvdGFyZ2V0L3RyYWNlLmgKQEAgLTQ4
LDggKzQ4LDEwIEBAIHN0YXRpYyBpbmxpbmUgc3RydWN0IG52bWV0X2N0cmwgKm52bWV0X3JlcV90
b19jdHJsKHN0cnVjdCBudm1ldF9yZXEgKnJlcSkKIAogc3RhdGljIGlubGluZSB2b2lkIF9fYXNz
aWduX3JlcV9uYW1lKGNoYXIgKm5hbWUsIHN0cnVjdCBudm1ldF9yZXEgKnJlcSkKIHsKKwlzaXpl
X3QgbGVuID0gbWluX3Qoc2l6ZV90LCBESVNLX05BTUVfTEVOLCBzdHJsZW4ocmVxLT5ucy0+ZGV2
aWNlX3BhdGgpKTsKKwogCWlmIChyZXEtPm5zKQotCQlzdHJuY3B5KG5hbWUsIHJlcS0+bnMtPmRl
dmljZV9wYXRoLCBESVNLX05BTUVfTEVOKTsKKwkJc3RybmNweShuYW1lLCByZXEtPm5zLT5kZXZp
Y2VfcGF0aCwgbGVuKTsKIAllbHNlCiAJCW1lbXNldChuYW1lLCAwLCBESVNLX05BTUVfTEVOKTsK
IH0KLS0gCjIuMjIuMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52
bWUK
