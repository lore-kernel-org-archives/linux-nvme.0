Return-Path: <SRS0=1rws=HL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8748C433DB
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 04:09:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 560F464EAA
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 04:09:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 560F464EAA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jKWU60WEtnRffqjSRWmewb/mTXEyb1QTQQMxZFezL1Q=; b=uqy60wS4INdkrUsde9eiP7z0p
	95AT2frX90uYXHAr66ml7+Jp/gccHD0oTQP9PaV5uEJfx23UxxkL8o25YNkRYyirKJQ3jucy1vqW8
	ImzSSZDVpQX7IDSHtmqEDuybZQWbI7jZfumW2rHKpnWoJl/lz7xdh0Za5elwd0LrnARISVotexg7x
	4X2lQIqL2KBs5WI3bQQnr2wbAt6OKwLm0y3Y171FW723oJNp+f+TJspfVVkHXY4NKF56VgFdrqAdv
	eVWDCJ3sOgpkWkWJhDbpCLVoQktZ6cRy+mfcO+Cg8Yx3GnQR9KkPP2m/1ZnP6dZvQmX/XDj7rE+B2
	I8QodiUxg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9KKz-00034F-34; Tue, 09 Feb 2021 04:09:17 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9KKh-0002vT-CX
 for linux-nvme@lists.infradead.org; Tue, 09 Feb 2021 04:09:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612843739; x=1644379739;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HLNCgs6FmGmZpmRQvprKO971sRF9/BEIJ/U3TacA39k=;
 b=SW9gxshZbNMFY3Wm06TihVIiH4oCmqjUfsFmoJBRLLok9LW9uGRmGS3v
 vzUMb0Qz7B2s/ed1Yi1WdIF9mk3P8kUg9pyTKOihw8k29Glg+cYxsoHW6
 QDAr7RAZylvw6IYGajJOqetXor/53ASscNcMe9b3+uR97yVrJPpWLJLuR
 Mu5PFBIsg77s21GmuBEvALOOctj3OhSdXhydBw0Nhi0B66LBRc4gxnevq
 6yGQkTYMpC8Q54H8D5yl7ZWKeMsMwsp8VeBuHFbSxWnlVXsk2G7IX0p28
 cb428pwBlK00A/Ny8CvLLpxCxzLz8JfCU+Ddgrzzn6x4NVCidO35zRf0a A==;
IronPort-SDR: MHhysJeTba1ZikqZmg0uQYNzwrTgLCq7R0JUR6XUj88XhjLKSGbGDFEIQ/ImuTXY0YkbEpsjtX
 2P7gNjgYeG+Xbu17z0xwMz4QFB4trnIPTpO/Edx2f5ije1er/i8DEM6cf0NontKdNlBkGHYLR+
 xKYqvaPr5S08vy1jdstiS2UFmZnWGgpNTN1ganXyPJYV8TcF1lIlYqUcSmIEmL3bdTfl02JM+R
 60tYHx578FEWxmSlAW2DnpQMjPeP+1Nzz60ROkt10AI4FOjr+Cz6SiLnqkjXMedhTd1y9jpUTG
 obY=
X-IronPort-AV: E=Sophos;i="5.81,164,1610380800"; d="scan'208";a="269970524"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 09 Feb 2021 12:08:59 +0800
IronPort-SDR: /Pcea6rZospXg2tHcCMNvabeJqDhBxjvz+RKsGPUiIH9Xx0cBXb5JMnYu8NK87yM05pvFyBSry
 ZZlbIZqfoJ2kcnaOg3fm5iTfwq3GbG88inr7zjAuUObJEZp1ELzPdAWIESq4fg6dsC8eoSF+7N
 w0cax75hbDSpYg/gqA9DayT8zdbI/S+eJf6G0vbK5F2eCpyaqjegi9vQGE/kNQDrMgueKKGZ3Y
 gpbYE028Utbm2/LPDGsk/j1XsTEuVHDVigbccWyEydWPm7rZtDSWGLgjJYiHIv9QXAb/YF/q5L
 FQABrE549JVbljZMAkmbU7T8
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2021 19:50:53 -0800
IronPort-SDR: 7WeOD9Mq38SzE7xGUbMOSHRXGfqdWhLCO0fT9dzeilwPStmv00cL0CDWXSA4aiYn9Bc9yWimPN
 hJ1snmdSx5bUYRt2mW45pnAG7RNmNPfYoCJCFzm4jABLF0c85/OjJdhkFVYmKSx1ZQjj42Sk9v
 meYqHdjjrx1+QfqRLw/8LbRmpLOpnP4O3UEOAqdNU1NcMY3nub5epkyVxp0ihLSfxjSQWfVkHQ
 evnvJuN/x3HUARpjZZK0uJZQQSqYGubl5ZVp5QfVIpT9tHd6eN+dlhj3F6oUxfxcu+2ulMcOiu
 Qfs=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 08 Feb 2021 20:09:00 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 08/11] nvmet: use min of device_path and disk len
Date: Mon,  8 Feb 2021 20:08:40 -0800
Message-Id: <20210209040843.45572-9-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210209040843.45572-1-chaitanya.kulkarni@wdc.com>
References: <20210209040843.45572-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210208_230859_688647_1237CBC6 
X-CRM114-Status: GOOD (  13.20  )
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
