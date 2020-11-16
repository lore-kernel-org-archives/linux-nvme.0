Return-Path: <SRS0=rzv5=EW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3147BC55ABD
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 08:12:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC284222C4
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 08:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fWL2LOkh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC284222C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=y9+Uofdyr4VD+XcMGxV+ROjwv4byR2yiklQwwRpg5cU=; b=fWL2LOkhx2jktp4TCImk86QQ0
	SCkp+hUUGd63LNWLl9ftCZ04jDsMggaTEzp5L2hutxU2cyiJcfDDYxA5hMEPruV7PfIHftPKo4H+g
	yH3gPMGEV8mjpnWDtLXV2FPr+kY7djz/jdJQILEZyRGZy7nZjhNbFzGsjDZvt+/sI710v7iRh4wBR
	eZ6y+2HPamJCq+G9nYAT/jrLDtRhf12GWk4eorjP22qDT1ma+or6pBXDz+ms0qYr+MQht7J6iDW3M
	uZrk5JsGOVr3daWF0bI6tHl85Pzb/KGX77HSQNwcfTnTLWVrMfSGFrZOy21wsz9h/LzRbFuHwMjE9
	Iro+DgRVQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1keZck-00051U-5S; Mon, 16 Nov 2020 08:12:30 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1keZcf-0004zm-S2
 for linux-nvme@lists.infradead.org; Mon, 16 Nov 2020 08:12:27 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id C724CAC2E;
 Mon, 16 Nov 2020 08:12:24 +0000 (UTC)
Subject: Re: [PATCH v4 17/19] lpfc: vmid: Adding qfpa and vmid timeout check
 in worker thread
To: Muneendra <muneendra.kumar@broadcom.com>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, tj@kernel.org, linux-nvme@lists.infradead.org
References: <1604895845-2587-1-git-send-email-muneendra.kumar@broadcom.com>
 <1604895845-2587-18-git-send-email-muneendra.kumar@broadcom.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <0ded4be6-f4e1-8d13-5b1a-930045247237@suse.de>
Date: Mon, 16 Nov 2020 09:12:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1604895845-2587-18-git-send-email-muneendra.kumar@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201116_031226_335097_70C4A975 
X-CRM114-Status: GOOD (  27.46  )
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
Cc: pbonzini@redhat.com, jsmart2021@gmail.com, mkumar@redhat.com,
 emilne@redhat.com, Gaurav Srivastava <gaurav.srivastava@broadcom.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTEvOS8yMCA1OjI0IEFNLCBNdW5lZW5kcmEgd3JvdGU6Cj4gRnJvbTogR2F1cmF2IFNyaXZh
c3RhdmEgPGdhdXJhdi5zcml2YXN0YXZhQGJyb2FkY29tLmNvbT4KPiAKPiBUaGlzIHBhdGNoIGFk
ZCB0aGUgcGVyaW9kaWMgY2hlY2sgZm9yIGlzc3Vpbmcgb2YgcWZwYSBjb21tYW5kIGFuZCB2bWlk
Cj4gdGltZW91dCBpbiB0aGUgd29ya2VyIHRocmVhZC4gVGhlIGluYWN0aXZpdHkgdGltZW91dCBj
aGVjayBpcyBhZGRlZCB2aWEKPiB0aGUgdGltZXIgZnVuY3Rpb24uCj4gCj4gU2lnbmVkLW9mZi1i
eTogR2F1cmF2IFNyaXZhc3RhdmEgIDxnYXVyYXYuc3JpdmFzdGF2YUBicm9hZGNvbS5jb20+Cj4g
U2lnbmVkLW9mZi1ieTogSmFtZXMgU21hcnQgPGpzbWFydDIwMjFAZ21haWwuY29tPgo+IAo+IC0t
LQo+IHY0Ogo+IE5vIGNoYW5nZQo+IAo+IHYzOgo+IE5vIGNoYW5nZQo+IAo+IHYyOgo+IFBvcnRl
ZCB0aGUgcGF0Y2ggb24gdG9wIG9mIDUuMTAvc2NzaS1xdWV1ZQo+IC0tLQo+ICAgZHJpdmVycy9z
Y3NpL2xwZmMvbHBmY19oYmFkaXNjLmMgfCA0MiArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDQyIGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9zY3NpL2xwZmMvbHBmY19oYmFkaXNjLmMgYi9kcml2ZXJzL3Njc2kvbHBmYy9s
cGZjX2hiYWRpc2MuYwo+IGluZGV4IGIyMDAxMzg2Njk0Mi4uMzhkZjNjNDM0MWY5IDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvc2NzaS9scGZjL2xwZmNfaGJhZGlzYy5jCj4gKysrIGIvZHJpdmVycy9z
Y3NpL2xwZmMvbHBmY19oYmFkaXNjLmMKPiBAQCAtNDMzLDYgKzQzMywzMiBAQCBscGZjX2Rldl9s
b3NzX3Rtb19oYW5kbGVyKHN0cnVjdCBscGZjX25vZGVsaXN0ICpuZGxwKQo+ICAgCXJldHVybiBm
Y2ZfaW51c2U7Cj4gICB9Cj4gICAKPiArdm9pZCBscGZjX2NoZWNrX3ZtaWRfcWZwYV9pc3N1ZShz
dHJ1Y3QgbHBmY19oYmEgKnBoYmEpCj4gK3sKPiArCXN0cnVjdCBscGZjX3Zwb3J0ICp2cG9ydDsK
PiArCXN0cnVjdCBscGZjX3Zwb3J0ICoqdnBvcnRzOwo+ICsJaW50IGksIHJldDsKPiArCj4gKwl2
cG9ydHMgPSBscGZjX2NyZWF0ZV92cG9ydF93b3JrX2FycmF5KHBoYmEpOwo+ICsJaWYgKCF2cG9y
dHMpCj4gKwkJcmV0dXJuOwo+ICsKPiArCWZvciAoaSA9IDA7IGkgPD0gcGhiYS0+bWF4X3Zwb3J0
czsgaSsrKSB7Cj4gKwkJaWYgKCghdnBvcnRzW2ldKSAmJiAoaSA9PSAwKSkKPiArCQkJdnBvcnQg
PSBwaGJhLT5wcG9ydDsKPiArCQllbHNlCj4gKwkJCXZwb3J0ID0gdnBvcnRzW2ldOwo+ICsJCWlm
ICghdnBvcnQpCj4gKwkJCWJyZWFrOwo+ICsKPiArCQlpZiAodnBvcnQtPnZtaWRfZmxhZyAmIExQ
RkNfVk1JRF9JU1NVRV9RRlBBKSB7Cj4gKwkJCXJldCA9IGxwZmNfaXNzdWVfZWxzX3FmcGEodnBv
cnQpOwo+ICsJCQl2cG9ydC0+dm1pZF9mbGFnICY9IH5MUEZDX1ZNSURfSVNTVUVfUUZQQTsKPiAr
CQl9Cj4gKwl9Cj4gKwlscGZjX2Rlc3Ryb3lfdnBvcnRfd29ya19hcnJheShwaGJhLCB2cG9ydHMp
Owo+ICt9Cj4gKwo+ICAgLyoqCj4gICAgKiBscGZjX3NsaTRfcG9zdF9kZXZfbG9zc190bW9faGFu
ZGxlciAtIFNMSTQgcG9zdCBkZXZsb3NzIHRpbWVvdXQgaGFuZGxlcgo+ICAgICogQHBoYmE6IFBv
aW50ZXIgdG8gaGJhIGNvbnRleHQgb2JqZWN0Lgo+IEBAIC03NDQsNiArNzcwLDIyIEBAIGxwZmNf
d29ya19kb25lKHN0cnVjdCBscGZjX2hiYSAqcGhiYSkKPiAgIAlpZiAoaGFfY29weSAmIEhBX0xB
VFQpCj4gICAJCWxwZmNfaGFuZGxlX2xhdHQocGhiYSk7Cj4gICAKPiArCS8qIEhhbmRsZSBWTUlE
IEV2ZW50cyAqLwo+ICsJaWYgKGxwZmNfaXNfdm1pZF9lbmFibGVkKHBoYmEpKSB7Cj4gKwkJaWYg
KHBoYmEtPnBwb3J0LT53b3JrX3BvcnRfZXZlbnRzICYKPiArCQkgICAgV09SS0VSX0NIRUNLX1ZN
SURfSVNTVUVfUUZQQSkgewo+ICsJCQlscGZjX2NoZWNrX3ZtaWRfcWZwYV9pc3N1ZShwaGJhKTsK
PiArCQkJcGhiYS0+cHBvcnQtPndvcmtfcG9ydF9ldmVudHMgJj0KPiArCQkJCX5XT1JLRVJfQ0hF
Q0tfVk1JRF9JU1NVRV9RRlBBOwo+ICsJCX0KPiArCQlpZiAocGhiYS0+cHBvcnQtPndvcmtfcG9y
dF9ldmVudHMgJgo+ICsJCSAgICBXT1JLRVJfQ0hFQ0tfSU5BQ1RJVkVfVk1JRCkgewo+ICsJCQls
cGZjX2NoZWNrX2luYWN0aXZlX3ZtaWQocGhiYSk7Cj4gKwkJCXBoYmEtPnBwb3J0LT53b3JrX3Bv
cnRfZXZlbnRzICY9Cj4gKwkJCSAgICB+V09SS0VSX0NIRUNLX0lOQUNUSVZFX1ZNSUQ7Cj4gKwkJ
fQo+ICsJfQo+ICsKPiAgIAkvKiBQcm9jZXNzIFNMSTQgZXZlbnRzICovCj4gICAJaWYgKHBoYmEt
PnBjaV9kZXZfZ3JwID09IExQRkNfUENJX0RFVl9PQykgewo+ICAgCQlpZiAocGhiYS0+aGJhX2Zs
YWcgJiBIQkFfUlJRX0FDVElWRSkKPiAKUmV2aWV3ZWQtYnk6IEhhbm5lcyBSZWluZWNrZSA8aGFy
ZUBzdXNlLmRlPgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAg
ICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0
aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBO
w7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxp
bmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
