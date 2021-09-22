Return-Path: <SRS0=1D85=OM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DFAC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 13:15:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7CE5611B0
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 13:15:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B7CE5611B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:To:Subject:MIME-Version:
	Date:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aR1VS8XkTZPAPd88q4Xl4O5JN46OLLNHE5xC6jsmL0g=; b=NJzIuCDA2yPnx3fBL7w1GZK2iZ
	/eL57DXdklykkzE/0nyJtzap5SV8/wzNbK4KBhuuFvbhyb5ho+nGkitXURqmMyDzDjU00v1ORfDwD
	I81KNp46T5wS7KLfNR19vDYCaRxzZUdSpruA02Gz/7ap4m1qFjkpeH3EYKx4dzwhmhdOWfqn06lwj
	yQqlqJv4X8oK6zcxSOQfENJGsl3MCYVKynh/k2N4yZz6vYYBQBzo0tTFXvxwVMTq3iNcsVykQl6AY
	KYjUjW8rRkSwnxlcOLuibM6yKzUyA5lO7TdmI6OwQ2qoh60IThO7UXU1uDT21izJjNfF3sVapcXCL
	q+TyIoBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mT25E-008ZoD-KA; Wed, 22 Sep 2021 13:14:44 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mT22D-008Yi0-RN
 for linux-nvme@lists.infradead.org; Wed, 22 Sep 2021 13:11:41 +0000
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HDz97227nzRPnc;
 Wed, 22 Sep 2021 21:07:23 +0800 (CST)
Received: from dggpeml500006.china.huawei.com (7.185.36.76) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 22 Sep 2021 21:11:35 +0800
Received: from [10.169.63.14] (10.169.63.14) by dggpeml500006.china.huawei.com
 (7.185.36.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.8; Wed, 22 Sep
 2021 21:11:34 +0800
Message-ID: <62a3e56f-58e6-11a3-1526-d0cbbbeeaf70@huawei.com>
Date: Wed, 22 Sep 2021 21:11:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0
Subject: Re: [PATCH nvme-cli 0/2] add "State" field in command "nvme list"
To: <linux-nvme@lists.infradead.org>, Chaitanya Kulkarni
 <chaitanyak@nvidia.com>
References: <20210915132912.3004-1-chengjike.cheng@huawei.com>
 <e40fa754-60ae-ab6f-bd2e-27b8ed7251a1@nvidia.com>
From: "Chengjike (ISSP)" <chengjike.cheng@huawei.com>
In-Reply-To: <e40fa754-60ae-ab6f-bd2e-27b8ed7251a1@nvidia.com>
X-Originating-IP: [10.169.63.14]
X-ClientProxiedBy: dggeme719-chm.china.huawei.com (10.1.199.115) To
 dggpeml500006.china.huawei.com (7.185.36.76)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210922_061138_186218_2D0D73B3 
X-CRM114-Status: UNSURE (   8.29  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CuWcqCAyMDIxLzkvMTcgMDo1OCwgQ2hhaXRhbnlhIEt1bGthcm5pIOWGmemBkzoKPiBPbiA5LzE1
LzIxIDY6MjkgQU0sIGNoZW5namlrZSB3cm90ZToKPj4gV2hlbiBOVk1lIFN1YnN5c3RlbSBpcyBj
b25uZWN0ZWQgd2l0aCBvbmUgb3IgbW9yZSBjb250cm9sbGVycyB2aWEgZmFicmljLCBzdWNoIGFz
IE5WTWUtb0Ygb3ZlciBSRE1BLAo+PiBpZiBzb21lIGxpbmtzIGFyZSBkb3duLCBzb21lIG52bWUg
ZGlza3Mgb24gdGhlIGhvc3QgYXJlIGZhdWx0eSBhbmQgdGhleSB3b24ndCBiZSBkZWxldGVkIGlt
bWVkaWF0ZWx5Lgo+PiBCdXQgdGhlICJudm1lIGxpc3QiIGNvbW1hbmQgZG9lcyBub3Qgc2hvdyB0
aGVzZSBmYXVsdHkgZGlza3MuCj4+IFNvIGFkZCAiU3RhdGUiIGZpZWxkICBpbiBjb21tYW5kICJu
dm1lIGxpc3QiLCBhbmQgZGlzcGxheSB0aGUgc3RhdHVzIG9mIGVhY2ggZGlzayBmb3IgdXNlcnMu
Cj4+IEZvciBleGFtcGxlOgo+PiBbcm9vdEBsb2NhbGhvc3QgbnZtZS1jbGldIyBudm1lIGxpc3QK
Pj4gTm9kZSAgICAgICAgU04gICAgICAgICAgICAgICAgICAgTW9kZWwgICAgICAgICBOYW1lc3Bh
Y2UgVXNhZ2UgICAgICAgICAgICAgICAgICAgIEZvcm1hdCAgICAgICAgICAgRlcgUmV2ICAgU3Rh
dHVzCj4+IC0tLS0tLS0tLS0tIC0tLS0tLS0tLS0tLS0tLS0tLS0tIC0tLS0tLS0tLS0tLS0gLS0t
LS0tLS0tIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSAtLS0tLS0tLS0tLS0tLS0tIC0tLS0tLS0t
IC0tLS0tLS0tCj4+IG52bWUwbjIgICAgIDI1NjU4NTUyNjU2NjU1NDU2MjY1IEh1YXdlaS1YU0cx
ICAgMiAgICAgICAgIDIuODMgIEdCIC8gIDEwLjc0ICBHQiAgICA1MTIgICBCICsgIDAgQiAgIDEw
MDAwMDEgIGxpdmUKPj4gbnZtZTBuMSAgICAgMjU2NTg1NTI2NTY2NTU0NTYyNjUgSHVhd2VpLVhT
RzEgICAxICAgICAgICAgMi43OCAgR0IgLyAgMTAuNzQgIEdCICAgIDUxMiAgIEIgKyAgMCBCICAg
MTAwMDAwMSAgZmF1bHR5Cj4+Cj4gd2hhdCBpZiBuYW1lc3BhY2UgaXMgbm9uIE5WTWVPRiA/IGFs
c28geW91IG5lZWQgdG8gbWFrZSB0aGUgcHJpbnRpbmcKPiBzdGF0dXMgb3B0aW9uYWwuCgoKU29y
cnkgZm9yIHRoZSBsYXRlIHJlcGx5KHdlIGFyZSBvbiB2YWNhdGlvbiBpbiBvdXIgY291bnRyeSku
Clllcy4gSWYgbmFtZXNwYWNlIGlzIG5vbiBOVk1lT0YsIHRoZSBjb21tYW5kIG9mICJudm1lIGxp
c3QiCmFsc28gZGlzcGxheXMgdGhlIHN0YXR1cyBvZiBlYWNoIGRpc2suCgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxp
c3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
