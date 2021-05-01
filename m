Return-Path: <SRS0=FZGd=J4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B63BC433B4
	for <linux-nvme@archiver.kernel.org>; Sat,  1 May 2021 11:59:54 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39CF7613F8
	for <linux-nvme@archiver.kernel.org>; Sat,  1 May 2021 11:59:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39CF7613F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Fp0dLjvMO1SPWWd7s8onf+PbTO6bacAmnLb+DdVrspg=; b=rFtPPPclXxJuZKGHxYByGMLKv
	aMZhECiihGEOAOzR8LAOq/tqk5MbCnc9lFeQ1YVfRt4Cdju7k6c9k+DOyp4LUqKYmktLxmtx6LjCi
	68+uQdJhFl5fQTKSZLgVPyt455mC6nD2SUR2J6zVCvJkLHuihfilBVp2o7vioeDRItZ1dw0W0s9Ld
	sFmiUy6xV13+dRaiuZ6KxFp7EbODEWPC6dF8tHSlYs1wLXQgaSGJTa5I/4PlzyRP/SwsAWwxNuhNc
	Kp1QDHTLRFdH8pS6FzMVgEwWtNRJH28Vr3hLejNNsxmzdQsD4b1RQ5jquUrDSw7v3X8/Lz5ArVg+w
	dRD0WV+RQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lcoHU-009zpJ-5N; Sat, 01 May 2021 11:59:32 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcoHK-009zoP-BN
 for linux-nvme@desiato.infradead.org; Sat, 01 May 2021 11:59:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
 Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
 bh=ARaCrxhJtsNEW98t4jwH4GZyZ3beWASQ1d2D85383e8=; b=aJfE8293bW/oq/Jwy90i2ZJ85L
 giOzGrnCk/UAE/6utSQrlgHqmVdsMPdOk41sPKRaYNJqH5qTfTPSBk4rs8ugPd+V6G4YwxOiXRlAi
 QYgRKs3+UYRSb5ltNhq5Zo9Ph3uBgOi5D1XwK0UbChmVyZPdyhLl0lq53+xiUjQ/ETbdTXXZ+dW1A
 pe+gG5P9wRDn65OMjYLull1LaI9CrEzFLMuaWNUpa5HiK9QX+NmX6QcV6+KvXZtrcl6wnRWbPeU++
 gTc+6ZqpG7L9fBjnpNrv3CI7y0tDOy/gqt4ZZqdoO9eEqNTjU8wdGYlTN3mFeQRWRS0vS65fIImiQ
 uBV6T6UQ==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcoHH-001yIq-QL
 for linux-nvme@lists.infradead.org; Sat, 01 May 2021 11:59:21 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 89E22B221
 for <linux-nvme@lists.infradead.org>; Sat,  1 May 2021 11:59:18 +0000 (UTC)
Subject: Re: [PATCHv2] nvme-mpath: delete disk after last connection
To: linux-nvme@lists.infradead.org
References: <20210416062411.47958-1-hare@suse.de>
 <20210420141610.GB14300@redsun51.ssa.fujisawa.hgst.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <59942a93-3234-2bca-ef67-4ccf9580d073@suse.de>
Date: Sat, 1 May 2021 13:59:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210420141610.GB14300@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210501_045920_023927_19DF5AAD 
X-CRM114-Status: GOOD (  13.69  )
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

T24gNC8yMC8yMSA0OjE2IFBNLCBLZWl0aCBCdXNjaCB3cm90ZToKPiBPbiBGcmksIEFwciAxNiwg
MjAyMSBhdCAwODoyNDoxMUFNICswMjAwLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+IE5vdyBk
ZWxldGUgYWxsIHBhdGhzIHRvIG9uZSBvZiB0aGUgbmFtZXNwYWNlczoKPj4KPj4gICAjIGVjaG8g
MSA+IC9zeXMvY2xhc3MvbnZtZS9udm1lMy9kZWxldGVfY29udHJvbGxlcgo+PiAgICMgZWNobyAx
ID4gL3N5cy9jbGFzcy9udm1lL252bWU0L2RlbGV0ZV9jb250cm9sbGVyCj4+Cj4+IFdlIGhhdmUg
bm8gcGF0aCwgYnV0IG1kc3RhdCBzYXlzOgo+Pgo+PiAgICMgY2F0IC9wcm9jL21kc3RhdAo+PiAg
IFBlcnNvbmFsaXRpZXMgOiBbcmFpZDFdCj4+ICAgbWQwIDogYWN0aXZlIChhdXRvLXJlYWQtb25s
eSkgcmFpZDEgbnZtZTVuMVsxXQo+PiAgICAgICAgIDY0NTEyIGJsb2NrcyBzdXBlciAxLjIgWzIv
MV0gW19VXQo+Pgo+PiBBbmQgdGhpcyBpcyByZXBvcnRlZCB0byBjYXVzZSBhIHByb2JsZW0uCj4+
Cj4+IFdpdGggdGhlIHByb3Bvc2VkIHBhdGNoLCB0aGUgZm9sbG93aW5nIG1lc3NhZ2VzIGFwcGVh
cjoKPj4KPj4gICBbICAyMjcuNTE2ODA3XSBtZC9yYWlkMTptZDA6IERpc2sgZmFpbHVyZSBvbiBu
dm1lM24xLCBkaXNhYmxpbmcgZGV2aWNlLgo+PiAgIFsgIDIyNy41MTY4MDddIG1kL3JhaWQxOm1k
MDogT3BlcmF0aW9uIGNvbnRpbnVpbmcgb24gMSBkZXZpY2VzLgo+Pgo+PiBBbmQgbWRzdGF0IHNo
b3dzIG9ubHkgdGhlIHZpYWJsZSBtZW1iZXJzOgo+Pgo+PiAgICMgY2F0IC9wcm9jL21kc3RhdAo+
PiAgIFBlcnNvbmFsaXRpZXMgOiBbcmFpZDFdCj4+ICAgbWQwIDogYWN0aXZlIChhdXRvLXJlYWQt
b25seSkgcmFpZDEgbnZtZTVuMVsxXQo+PiAgICAgICAgIDY0NTEyIGJsb2NrcyBzdXBlciAxLjIg
WzIvMV0gW19VXQo+IAo+IEkgdGhpbmsgdGhlcmUncyBhIGNvcHktcGFzdGUgZXJyb3IgaW4gdGhp
cyBjaGFuZ2UgbG9nIChwcm9iYWJseSBteQo+IG1pc3Rha2UpLiBUaGUgZmlyc3QgbWRzdGF0IHNo
b3VsZCBoYXZlIHNob3duIG52bWUzbjEgd2FzIHN0aWxsIHRoZXJlLAo+IHJpZ2h0Pwo+IApQb3Nz
aWJseS4gV2lsbCBiZSByZXNlbmRpbmcuCgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMg
UmVpbmVja2UgICAgICAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3Vz
ZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0Ug
U29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpI
UkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2
cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxp
bnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
