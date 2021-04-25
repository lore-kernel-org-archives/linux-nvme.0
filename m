Return-Path: <SRS0=MVBk=JW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20F7C433B4
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Apr 2021 11:35:24 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 594FB61354
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Apr 2021 11:35:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 594FB61354
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=C+2BU9fW5kpixxUGAu2q0ihkr9C1CTWBmoz1WZ0HT+4=; b=cdc2JfF0tIdJcSOHFWZOFdIdo
	RkZ8b/mI0gDUyDcmyJZmkBk9Vyj/7SIs7f1PbUQEb99fexlPa9WWJmvYTeFkDNAL+GU0e3lQ8RNf4
	gNGQKhXOPazT6l87Q/hq8lY/R1IhMGWrArX7u3nO8Hbp/0EW9Db3jd/H7XvxCkkoA/oizQJgmQovY
	GKbt5rDITqITIpugU8NRFYZiJB2ck5tVVIZyop8Oy1IRnH6nPlBuEECpeOVQ20pkzUHwGKH245GaH
	0C8HuqLcAGBRbVF72vPJXgOwGtfMrJyxOkn2k+plXHwUnh0HHS5hfo87Tw9yhf12/ZT6I7PTMP7Pr
	tUrreWNwQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lad2V-005Y2T-QU; Sun, 25 Apr 2021 11:35:04 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lad2Q-005Y20-TO
 for linux-nvme@desiato.infradead.org; Sun, 25 Apr 2021 11:34:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=xxQfbOt2Kc/9R6HaORcDiS3eo0XYP2XFzrIJpr4hWIE=; b=EGR1drfSAlyY1zlMBT7XqOjyxL
 r+nvfItOLb9viGTfd04UiKQqpiiRTsJitWRJxLW7GrI8+4GMX0gJ3B5C1iYt1W5byzIXOYswVSOM7
 YmrTJ4snWsUTc3e4NBjCjCzMy4yTdGd89YZcriHtc+EjsmWJSSQZD0SIvJi1a/iTDFODQyuajlckB
 jGU8TlCYuCq4osxhxoinxWVqBoRc577MAb2r88APaxFyYpoPqUfYytclQrpYAeZFrMBG2Z6ky2MzW
 2yUnvxZ58Aenumh+IyaPy/9bbOWS6Eti0dKboZ5zTVGOevpE2L3bQ+KnT0iyWHXMRawRxXG6A82o7
 173oGopQ==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lad2O-00FQ4h-2N
 for linux-nvme@lists.infradead.org; Sun, 25 Apr 2021 11:34:57 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 2EF85AE37;
 Sun, 25 Apr 2021 11:34:52 +0000 (UTC)
Subject: Re: [PATCH v2] nvme: rdma/tcp: call nvme_mpath_stop() from reconnect
 workqueue
To: mwilck@suse.com, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Chao Leng <lengchao@huawei.com>
Cc: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
References: <20210423133835.25479-1-mwilck@suse.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <65167282-84e7-d08b-f97d-edb0d1372a49@suse.de>
Date: Sun, 25 Apr 2021 13:34:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210423133835.25479-1-mwilck@suse.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210425_043456_302398_4A76F445 
X-CRM114-Status: GOOD (  16.70  )
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

T24gNC8yMy8yMSAzOjM4IFBNLCBtd2lsY2tAc3VzZS5jb20gd3JvdGU6Cj4gRnJvbTogTWFydGlu
IFdpbGNrIDxtd2lsY2tAc3VzZS5jb20+Cj4gCj4gV2UgaGF2ZSBvYnNlcnZlZCBhIGZldyBjcmFz
aGVzIHJ1bl90aW1lcl9zb2Z0aXJxKCksIHdoZXJlIGEgYnJva2VuCj4gdGltZXJfbGlzdCBzdHJ1
Y3QgYmVsb25naW5nIHRvIGFuIGFuYXR0X3RpbWVyIHdhcyBlbmNvdW50ZXJlZC4gVGhlIGJyb2tl
bgo+IHN0cnVjdHVyZXMgbG9vayBsaWtlIHRoaXMsIGFuZCB3ZSBzZWUgYWN0dWFsbHkgbXVsdGlw
bGUgb25lcyBhdHRhY2hlZCB0bwo+IHRoZSBzYW1lIHRpbWVyIGJhc2U6Cj4gCj4gY3Jhc2g+IHN0
cnVjdCB0aW1lcl9saXN0IDB4ZmZmZjkyNDcxYmNmZGM5MAo+IHN0cnVjdCB0aW1lcl9saXN0IHsK
PiAgICBlbnRyeSA9IHsKPiAgICAgIG5leHQgPSAweGRlYWQwMDAwMDAwMDAxMjIsICAvLyBMSVNU
X1BPSVNPTjIKPiAgICAgIHBwcmV2ID0gMHgwCj4gICAgfSwKPiAgICBleHBpcmVzID0gNDI5NjAy
MjkzMywKPiAgICBmdW5jdGlvbiA9IDB4ZmZmZmZmZmZjMDZkZTVlMCA8bnZtZV9hbmF0dF90aW1l
b3V0PiwKPiAgICBmbGFncyA9IDIwCj4gfQo+IAo+IElmIHN1Y2ggYSB0aW1lciBpcyBlbmNvdW50
ZXJlZCBpbiBydW5fdGltZXJfc29mdGlycSgpLCB0aGUga2VybmVsCj4gY3Jhc2hlcy4gVGhlIHRl
c3Qgc2NlbmFyaW8gd2FzIGFuIEkvTyBsb2FkIHRlc3Qgd2l0aCBsb3RzIG9mIE5WTWUKPiBjb250
cm9sbGVycywgc29tZSBvZiB3aGljaCB3ZXJlIHJlbW92ZWQgYW5kIHJlLWFkZGVkIG9uIHRoZSBz
dG9yYWdlIHNpZGUuCj4gCi4uLgoKQnV0IGlzbid0IHRoaXMgdGhlIHJlc3VsdCBvZiBkZXRhY2hf
dGltZXIoKT8gSUUgdGhpcyBzdXNwaWNpb3VzbHkgbG9va3MgCmxpa2UgcGVyZmVjdGx5IG5vcm1h
bCBvcGVyYXRpb247IGlzIHlvdSBsb29rIGF0IGV4cGlyZV90aW1lcnMoKSB3ZSdyZSAKZmlyc3Qg
Y2FsbGluZyAnZGV0YWNoX3RpbWVyKCknIGJlZm9yZSBjYWxsaW5nIHRoZSB0aW1lciBmdW5jdGlv
biwgaWUgCmV2ZXJ5IGNyYXNoIGluIHRoZSB0aW1lciBmdW5jdGlvbiB3b3VsZCBoYXZlIHRoaXMg
c2lnbmF0dXJlLgpBbmQsIGluY2lkZW50YWxseSwgc28gd291bGQgYW55IHRpbWVyIGZ1bmN0aW9u
IHdoaWNoIGRvZXMgbm90IGNyYXNoLgoKU29ycnkgdG8ga2lsbCB5b3VyIGFuYWx5c2lzIC4uLgoK
VGhpcyBkb2Vzbid0IG1lYW4gdGhhdCB0aGUgcGF0Y2ggaXNuJ3QgdmFsaWQgKGluIHRoZSBzZW5z
ZSB0aGF0IGl0IApyZXNvbHZlIHRoZSBpc3N1ZSksIGJ1dCB3ZSBkZWZpbml0ZWx5IHdpbGwgbmVl
ZCB0byB3b3JrIG9uIHJvb3QgY2F1c2UgCmFuYWx5c2lzLgoKQ2hlZXJhLAoKSGFubmVzCi0tIApE
ci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVj
dApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUz
IDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBO
w7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogRmVs
aXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1u
dm1lCg==
