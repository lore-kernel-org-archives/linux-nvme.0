Return-Path: <SRS0=1D85=OM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D20C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 13:07:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3316F60F6D
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 13:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3316F60F6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RtBkpGXa+v9svATMDkKGffN/eYHxj+lYPZ3x2znaV3s=; b=zsho8HweT9fY7b
	Ti+XXkzKP6tncbiWY3+i7CNqC+QZqF5ks0OZ9SPJf5D8Yeu2uTIDP6FeEFoaGXrBRwmp7MDterU3V
	0vYT/Z14zSPQZsRxK5pHY1iLm+ilVtkI1pN8eNyeh7YW5+Ll++Db3lDmWPTqTKfTsc+9DEw+SNG3t
	tWGWLrMLITLCb+lMpzPdzoZJTyvPqwMUdDHSVR7tzjNoEokXl0uDzjojnA/6qZ7850jzzdU9pORtY
	8HDa4w2w/6r9HVFnAvBdRbQYMV5fz6vPFJfHkjaW4jA7ez0/FUx9ylnT14Sw1r8vfiUw+Z4h4382i
	iT9V3SpjYxV80uFFShGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mT1xh-008X3j-59; Wed, 22 Sep 2021 13:06:57 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mT1sA-008Ugd-0U
 for linux-nvme@lists.infradead.org; Wed, 22 Sep 2021 13:01:16 +0000
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HDywf68lnz8ydc;
 Wed, 22 Sep 2021 20:56:34 +0800 (CST)
Received: from dggpeml500006.china.huawei.com (7.185.36.76) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 22 Sep 2021 21:01:07 +0800
Received: from [10.169.63.14] (10.169.63.14) by dggpeml500006.china.huawei.com
 (7.185.36.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.8; Wed, 22 Sep
 2021 21:01:06 +0800
Message-ID: <3003a276-53c9-26cd-1f0c-cf940a02e9bf@huawei.com>
Date: Wed, 22 Sep 2021 21:01:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0
Subject: Re: [PATCH nvme-cli 0/2] add "State" field in command "nvme list"
To: Sagi Grimberg <sagi@grimberg.me>, <kbusch@kernel.org>,
 <linux-nvme@lists.infradead.org>
CC: <sunao.sun@huawei.com>, <jiangtao62@huawei.com>
References: <20210915132912.3004-1-chengjike.cheng@huawei.com>
 <efc0a9d9-0ebd-e90b-faf0-3ee8c53d4f98@grimberg.me>
From: "Chengjike (ISSP)" <chengjike.cheng@huawei.com>
In-Reply-To: <efc0a9d9-0ebd-e90b-faf0-3ee8c53d4f98@grimberg.me>
X-Originating-IP: [10.169.63.14]
X-ClientProxiedBy: dggeme707-chm.china.huawei.com (10.1.199.103) To
 dggpeml500006.china.huawei.com (7.185.36.76)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210922_060114_313340_AD8773B5 
X-CRM114-Status: GOOD (  10.65  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CuWcqCAyMDIxLzkvMTkgMjI6MDUsIFNhZ2kgR3JpbWJlcmcg5YaZ6YGTOgo+Cj4+IFdoZW4gTlZN
ZSBTdWJzeXN0ZW0gaXMgY29ubmVjdGVkIHdpdGggb25lIG9yIG1vcmUgY29udHJvbGxlcnMgdmlh
IAo+PiBmYWJyaWMsIHN1Y2ggYXMgTlZNZS1vRiBvdmVyIFJETUEsCj4+IGlmIHNvbWUgbGlua3Mg
YXJlIGRvd24sIHNvbWUgbnZtZSBkaXNrcyBvbiB0aGUgaG9zdCBhcmUgZmF1bHR5IGFuZCAKPj4g
dGhleSB3b24ndCBiZSBkZWxldGVkIGltbWVkaWF0ZWx5Lgo+PiBCdXQgdGhlICJudm1lIGxpc3Qi
IGNvbW1hbmQgZG9lcyBub3Qgc2hvdyB0aGVzZSBmYXVsdHkgZGlza3MuCj4+IFNvIGFkZCAiU3Rh
dGUiIGZpZWxkwqAgaW4gY29tbWFuZCAibnZtZSBsaXN0IiwgYW5kIGRpc3BsYXkgdGhlIHN0YXR1
cyAKPj4gb2YgZWFjaCBkaXNrIGZvciB1c2Vycy4KPj4gRm9yIGV4YW1wbGU6Cj4+IFtyb290QGxv
Y2FsaG9zdCBudm1lLWNsaV0jIG52bWUgbGlzdAo+PiBOb2RlwqDCoMKgwqDCoMKgwqAgU07CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTW9kZWzCoMKgwqDCoMKgwqDCoMKgIE5h
bWVzcGFjZSAKPj4gVXNhZ2XCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBG
b3JtYXTCoMKgwqDCoMKgwqDCoMKgwqDCoCBGVyBSZXbCoMKgIFN0YXR1cwo+PiAtLS0tLS0tLS0t
LSAtLS0tLS0tLS0tLS0tLS0tLS0tLSAtLS0tLS0tLS0tLS0tIC0tLS0tLS0tLSAKPj4gLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tIC0tLS0tLS0tLS0tLS0tLS0gLS0tLS0tLS0gLS0tLS0tLS0KPj4g
bnZtZTBuMsKgwqDCoMKgIDI1NjU4NTUyNjU2NjU1NDU2MjY1IEh1YXdlaS1YU0cxwqDCoCAywqDC
oMKgwqDCoMKgwqDCoCAyLjgzIEdCIC/CoCAKPj4gMTAuNzTCoCBHQsKgwqDCoCA1MTLCoMKgIEIg
K8KgIDAgQsKgwqAgMTAwMDAwMcKgIGxpdmUKPj4gbnZtZTBuMcKgwqDCoMKgIDI1NjU4NTUyNjU2
NjU1NDU2MjY1IEh1YXdlaS1YU0cxwqDCoCAxwqDCoMKgwqDCoMKgwqDCoCAyLjc4IEdCIC/CoCAK
Pj4gMTAuNzTCoCBHQsKgwqDCoCA1MTLCoMKgIEIgK8KgIDAgQsKgwqAgMTAwMDAwMcKgIGZhdWx0
eQo+PiBbcm9vdEBsb2NhbGhvc3QgbnZtZS1jbGldIwo+Cj4gU3RhdGUgaXMgdG9vIGdlbmVyaWMs
IE1heWJlICJQYXRoIEFjY2VzcyIgb3Igc29tZXRoaW5nPwo+IFRoZSBwb2ludCBoZXJlIGlzIHRv
IHByb3ZpZGUgZ2VuZXJhbCBmZWVkYmFjayBmb3IgdGhlIHVzZXIgdG8gZ28gYW5kCj4gbG9vayBp
biBudm1lIGxpc3Qtc3Vic3lzPwo+IC4KWWVzLCBJIHRoaW5rICJQYXRoIEFjY2VzcyIgaXMgYmV0
dGVyIGFwcHJvcHJpYXRlIHRoYW4gIlN0YXRlIi4KClRoZSBwdXJwb3NlIG9mIHRoaXMgcGF0Y2gg
aXMgdG8gaW1wcm92ZSB1c2FiaWxpdHkgZm9yIHVzZXJzLgpJbmRlZWQsIHdoZW4gc29tZSBsaW5r
cyBhcmUgZG93biwgV2UgcnVuICJudm1lIGxpc3QiIGFuZCAibnZtZSBsaXN0LXN1YnN5cyIKdG8g
ZGV0ZXJtaW5lIHdoZXRoZXIgdGhlIGRpc2sgaXMgZmF1bHR5IG9yCmhhcyBiZWVuIGRlbGV0ZWQo
dGhlICJudm1lIGxpc3QiIGNvbW1hbmQgZG9lcyBub3Qgc2hvdyBmYXVsdHkgZGlza3MpLgpBZnRl
ciBhZGQgIlBhdGggQWNjZXNzIiBmaWVsZCBpbiBjb21tYW5kICJudm1lIGxpc3QiLAp0aGUgc3Rh
dHVzIG9mIGRpc2sgd2lsbCBiZSBtb3JlIGludHVpdGl2ZSBmb3IgdXNlcnMKYW5kIGp1c3Qgb25s
eSBydW4gIm52bWUgbGlzdCIuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1udm1lCg==
