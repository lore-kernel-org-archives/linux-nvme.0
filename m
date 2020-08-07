Return-Path: <SRS0=rw3x=BR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F70FC433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 02:28:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9BFB20855
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 02:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XR8cbQZq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9BFB20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=q8id5Qiq+b7CBiXswn1+IW0Q6Lo22rtIgOlweJHOIq4=; b=XR8cbQZqBE8RnuQhR8mOcgSoz
	E1wMnvmrWCqWHoPSqC+rV9qFxu9mz2/ZSrmr+jqfKBZj5pVikzWmXLDJ8D8NZzU6c07BYAB7zv3ji
	y4vbYaKwrYW+RvBVJEG/eF6YNGRcIb4u72q8fIaPN4bv0Lk/ftEb55OQkVG/VF5xy6lgumEKufJIu
	kVI7ZmvX17HmZ9c2SnRmXJeuxaTIf8wmFTnvfaIFmpUac9GVvnLhOp74822NHbcH/hVC28BIIA5eg
	MpdYpqmf+nyRf59b+L+oXT7kO1r5Iqndq9rg6DTNdCWVYLN5Yrv+R3DTJaKitm6bwr8gLcAEyxPY6
	YdVbSlxnQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3s7G-00008t-QN; Fri, 07 Aug 2020 02:28:18 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3s7C-00007O-RN
 for linux-nvme@lists.infradead.org; Fri, 07 Aug 2020 02:28:15 +0000
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 5EAFDDBA1443F1FA4722;
 Fri,  7 Aug 2020 10:28:08 +0800 (CST)
Received: from [10.169.42.93] (10.169.42.93) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0;
 Fri, 7 Aug 2020 10:28:02 +0800
Subject: Re: [PATCH] nvme-core: fix io interrupt when work with dm-multipah
To: Sagi Grimberg <sagi@grimberg.me>, "Meneghini, John"
 <John.Meneghini@netapp.com>, Keith Busch <kbusch@kernel.org>
References: <20200727055818.21430-1-lengchao@huawei.com>
 <20200728111956.GA31546@lst.de>
 <6df01884-5498-0809-b358-0c9f7d775a73@huawei.com>
 <20200729055903.GC31113@lst.de>
 <43e5dee8-1a91-4d8b-fdb5-91f9679ddeb3@huawei.com>
 <8d01b123-478f-f057-1598-8283dd099b03@huawei.com>
 <20200805152905.GB1982647@dhcp-10-100-145-180.wdl.wdc.com>
 <255d55e3-f824-a968-e478-3efeda095696@huawei.com>
 <20200806142625.GA3075319@dhcp-10-100-145-180.wdl.wdc.com>
 <729820BC-5F38-4E22-A83A-862E57BAE201@netapp.com>
 <9d641d7d-8b3f-759b-afa5-1e5d4be0ff82@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <57d8aacb-b479-3bca-3331-ec3b875cddcb@huawei.com>
Date: Fri, 7 Aug 2020 10:28:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <9d641d7d-8b3f-759b-afa5-1e5d4be0ff82@grimberg.me>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_222815_151841_01CE5B95 
X-CRM114-Status: GOOD (  10.91  )
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
Cc: Christoph Hellwig <hch@infradead.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Hannes de <hare@suse.de>, Ewan Milne <emilne@redhat.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAyMDIwLzgvNyA4OjAzLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+PiBJIHRoaW5rIHRoZSBw
cm9ibGVtIGhlcmUgaXMgdGhhdCB0aGUgY3VycmVudCBCTEtfU1RTIGFuZCBGQVNUX0ZBSUwgbWVj
aGFuaXNtcwo+PiB3ZXJlIGRlc2lnbmVkIHN1cHBvcnQgbGVnYWN5IHByb3RvY29scyBsaWtlIFND
U0kuwqAgVGhleSBhc3N1bWUgdGhhdCBhbGwgcmV0cnkgYmVoYXZpb3IgaXMKPj4gY29udHJvbGxl
ZCBieSBvdGhlciBjb21wb25lbnRzIGluIHRoZSBzdGFjay7CoCBOVk1lIGlzIHByZXNlbnRpbmcg
bmV3IHByb3RvY29sIGZlYXR1cmVzCj4+IGFuZCBzZW1hbnRpY3Mgd2hpY2ggcHJvYmFibHkgY2Fu
J3QgYmUgZWZmZWN0aXZlbHkgc3VwcG9ydGVkIGJ5IHRob3NlIGxlZ2FjeSBCTEtfU1RTCj4+IGFu
ZCBGQVNUX0ZBSUwgbWVjaGFuaXNtcyB3aXRob3V0IHBhc3NpbmcgbW9yZSBpbmZvcm1hdGlvbiB1
cCB0aGUgc3RhY2suCgo+IAo+IE5vdCBzdXJlIGhvdyBnZW5lcmljIHRoaXMgbmV3IGJsayBzdGF0
dXMgd291bGQgYmUuLiBJdCB3b3VsZCBwcm9iYWJseQo+IG1ha2UgYSBsb3QgbW9yZSBzZW5zZSBv
ZiB0aGVyZSBhcmUgb3RoZXIgY29uc3VtZXJzIGZvciBzdWNoIGEgc3RhdHVzCj4gY29kZS4KPiAK
PiBNYXliZSB3ZSBjb3VsZCBzZXQgaXQgdG8gQkxLX1NUU19USU1FT1VUIHdpdGggYSBiaWcgZmF0
IGNvbW1lbnQgZm9yIHdoeQo+IHdlIGFyZSBkb2luZyB0aGlzLi4uCkludHJvZHVjZSBhIG5ldyBC
TEtfU1RTIGVycm9yIG1heWJlIGEgZ29vZCBjaG9pY2UsIGJ1dCBpcyBub3QgZnJpZW5kbHkKdG8g
Zm9yd2FyZCBjb21wYXRpYmlsaXR5LgoKTm93IHdlIGhhdmUgMyBjaG9pY2U6QkxLX1NUU19USU1F
T1VULCBCTEtfU1RTX1JFU09VUkNFIG9yIEJMS19TVFNfSU9FUlIKYnkgZGVmYXVsdC4gRE0tbXVs
dGlwYXRoIHdpbGwgZmFpbCBwYXRoIGFuZCB0aGVuIGZhaWwgb3ZlciB0byByZXRyeS4KVGhlIGRp
ZmZlcmVuY2UgaXMgQkxLX1NUU19SRVNPVVJDRSB3aWxsIGRlbGF5IDEwMG1zIHRvIHJldHJ5LApC
TEtfU1RTX1RJTUVPVVQgYW5kIEJMS19TVFNfSU9FUlIgd2lsbCByZXRyeSBpbW1lZGlhdGx5LgoK
Tm93IHRoZXJlIGlzIG5vIHBlcmZlY3QgY2hvaWNlLCBidXQgd2UgaGF2ZSB0byBjaG9vc2Ugb25l
LiBJIHN1Z2dlc3QKa2VlcCBkZWZhdWx0LCB0cmFuc2xhdGUgTlZNRV9TQ19DTURfSU5URVJSVVBU
RUQgdG8gQkxLX1NUU19JT0VSUi4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LW52bWUK
