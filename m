Return-Path: <SRS0=Gy4h=HM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3CBC433E6
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 05:49:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1015864E3E
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 05:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1015864E3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jKWU60WEtnRffqjSRWmewb/mTXEyb1QTQQMxZFezL1Q=; b=23CdXJoayKZlaYNvDx8G+o2p8
	lQgXhF0sEwo7EEnI3PsjKjLT8lYUEaIcSOb2pB5/u12uFx7kppUBL+sPZ37F1x5FXLrQ5CkH88udc
	2XvYrO/fXTwLTG1tK8qXI8E6VK0V39BFsd9dts3B1MnwY6DFWEaYce98JnNfuL5gDxU22CxxALywV
	GAZrO5+bhVR7O0RfG7g6W0HLjcOdU7XqzpwCZ9BHM2v7iMVuO+BA2hnfiP3xSWNbwaAIa4I3kXEVH
	yZdWaNT0CDqf78zMVqi1bZnVZSbf+maPR9cz+xcxk309GlPEkCYdJFntHeo8e/Hiu9mFAFcJviSeL
	KvaMRO32g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9iNB-00072G-Mb; Wed, 10 Feb 2021 05:49:09 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9iN8-00070U-Rl
 for linux-nvme@lists.infradead.org; Wed, 10 Feb 2021 05:49:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612936146; x=1644472146;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HLNCgs6FmGmZpmRQvprKO971sRF9/BEIJ/U3TacA39k=;
 b=h5htByxLVhh7NA3xfXfXY0JG5o8tecubkS49K9fDSYX+rxGIySpPqrw5
 ThRpROHM6P/X9Y5Iv+dMyT1OYH3gFte9O4d7YwDOadCBA1EHH9Dn3x37Z
 cSdff4RKtXAaMKLwb0qyPjGB1xDOn/3+4OleqUgIWS+4MwYsb4MtJ2GWB
 B9Ht68Y2mUdlNrdsJHs9qf72HCi0sCyE6VK12JK2+Yf3D7Ea9MxX1i7dM
 C21fJlTONANLcLvXp8SA94jGj5z8EVC7Evf3R9EsUJqhBf20qVNj1fi0K
 8lbRufo87Vlga7qXBhZL/ZJHJgvZpepwRMdryDS7QHktIje0+C92j5ucM g==;
IronPort-SDR: cSUMXFcxIqeurhBOy0OkcBXsEpqaAl+qY5KTi/nchgkYuHOjAF9mjXX6dP1hXHdnToGGMYWSJw
 z3RrcJcSPn0cirVAuQ7qAprtaevDQ6aXU7YDx/JpyzwCF43ZOjwArKaHp98WjDN1mmT8mOIU2V
 6jV3/AKHoVYJn3+u2ZQYl5a7qIeotD+/5VE29qopsjiVRdcYcoIQNsOZDQrfdAj6TnQtY3Xq+6
 pfkVU4AHxEY/mH47bVXhxnFL6Etsq8rha02heKswKOigROGOUoJyLz2JN7/t8lgImWshwWbBD4
 XU0=
X-IronPort-AV: E=Sophos;i="5.81,167,1610380800"; d="scan'208";a="270080502"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2021 13:49:05 +0800
IronPort-SDR: 7KQrGlTVFZJi9R/sCUYA8WGBQsS/3edmdEw7Ymqy8Z76Yu8i9fTiBxTjNY0gMpqszaO/DWy5BF
 Tdvyx/f5IZSaQsbLmrFbk86c/RsekSX5UPyA3amSstvWGxILvo9dM3d7aNlphBj3OywQMys949
 SiPz0dHfbPVKI3x+YaEwSxSa1kC/Fawln3gpeuREOWeGHLJa7R9SBR+oUI0E3Eb1GF3aGUoNV/
 80Wb9tJUoSAKeJTF9j+4Z0WUiUtJ/p/McceR4nFv+ad0fGk/88uFam+rIcE6gBXHwRceMoWIQa
 dYZJC0F35Zm27a8032qShqA/
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2021 21:30:59 -0800
IronPort-SDR: hjr2RTn7MRch0DNLJdyF6SLkgU6yOr412BNc6+EID0T4fywZnza4E+PCpO24JpYR/v/j5iEf4k
 /UMPWGa+s4EigqmOMwC2lODv3KR59p2mfrZJSlg4uWrEBduc/x/tiKUc/XdwZubTf49aK14MEt
 q1Y9VxtL+V4I1DDvUPcaNRcOqQpadzLvEm2CkMhZYf6KQBIBvlz7hpp5j6llflqzLyBETpp6c+
 mh9Q8oVygWXHTwnGOWft9G6u0kPVUm5qwWV1/5ZczyBgVvwA+bo36hThwQtg14VHF9jKN+172n
 zZ4=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Feb 2021 21:49:06 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V3 08/11] nvmet: use min of device_path and disk len
Date: Tue,  9 Feb 2021 21:47:59 -0800
Message-Id: <20210210054802.34269-9-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210210054802.34269-1-chaitanya.kulkarni@wdc.com>
References: <20210210054802.34269-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210210_004907_071508_B50BDCEA 
X-CRM114-Status: GOOD (  13.04  )
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
