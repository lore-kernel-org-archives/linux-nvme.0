Return-Path: <SRS0=B93q=GO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D6CC433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Jan 2021 07:35:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9303D22A85
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Jan 2021 07:35:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9303D22A85
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LLB30roRsFCpvfv9M7idKFg7xBjPmMPPT2Czr2XMSss=; b=wg9Pm75zCxqh99RTLUn+SMUaV
	jAX28QdPW1SmK/TNL9RePfDLugkoGljlHi/wTKfISLGMKDatxMfJhzI+c0C7IwpoZ9kG0Y3zw2AJg
	dUwmDuxnGCpCzTdcVxLlg7ZviX55wrhlWEySOxT5Q+MfAk2R+eB20A8dztIi7W0gn/xszt9rcqCON
	u7+36fVpsMx6O/hBZdtPJbShZAGrRx7AUVKNu9jSKghNM/Jb+qmWH10g3L170vhMi18CG8uOWtjaY
	YI3jo8Ilgsrzs/4/jgUNa0wHfhcp5XPiEkvcgQXt71o6uMtMJapUNN2hV0ztC82rg/7bMLdNwkIat
	YfD2wkhMg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kyrjR-0006uX-Nb; Mon, 11 Jan 2021 07:35:17 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kyrjP-0006tB-65
 for linux-nvme@lists.infradead.org; Mon, 11 Jan 2021 07:35:16 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 07679AD57;
 Mon, 11 Jan 2021 07:35:14 +0000 (UTC)
Subject: Re: [PATCH v7 06/16] lpfc: vmid: Forward declarations for APIs
To: Muneendra <muneendra.kumar@broadcom.com>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, tj@kernel.org, linux-nvme@lists.infradead.org
References: <1609970430-19084-1-git-send-email-muneendra.kumar@broadcom.com>
 <1609970430-19084-7-git-send-email-muneendra.kumar@broadcom.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <a6dcbb12-8525-c88f-3ddc-2cdce2b1a166@suse.de>
Date: Mon, 11 Jan 2021 08:35:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1609970430-19084-7-git-send-email-muneendra.kumar@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210111_023515_373823_FE333516 
X-CRM114-Status: GOOD (  22.94  )
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
Cc: jsmart2021@gmail.com, mkumar@redhat.com, emilne@redhat.com,
 Gaurav Srivastava <gaurav.srivastava@broadcom.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMS82LzIxIDExOjAwIFBNLCBNdW5lZW5kcmEgd3JvdGU6Cj4gRnJvbTogR2F1cmF2IFNyaXZh
c3RhdmEgPGdhdXJhdi5zcml2YXN0YXZhQGJyb2FkY29tLmNvbT4KPiAKPiBUaGlzIHBhdGNoIGNv
bnRhaW5zIHRoZSBmb3J3YXJkIGRlY2xhcmF0aW9ucyBvZiBjb21tb25seSB1c2VkIEFQSXMgd2hp
Y2gKPiBhcmUgdXNlZCBvdXRzaWRlIHRoZSBzY29wZSBvZiB0aGUgZmlsZS4KPiAKPiBTaWduZWQt
b2ZmLWJ5OiBHYXVyYXYgU3JpdmFzdGF2YSA8Z2F1cmF2LnNyaXZhc3RhdmFAYnJvYWRjb20uY29t
Pgo+IFNpZ25lZC1vZmYtYnk6IEphbWVzIFNtYXJ0IDxqc21hcnQyMDIxQGdtYWlsLmNvbT4KPiAK
PiAtLS0KPiB2NzoKPiBObyBjaGFuZ2UKPiAKPiB2NjoKPiBObyBjaGFuZ2UKPiAKPiB2NToKPiBO
byBjaGFuZ2UKPiAKPiB2NDoKPiBObyBjaGFuZ2UKPiAKPiB2MzoKPiBObyBjaGFuZ2UKPiAKPiB2
MjoKPiBQb3J0ZWQgdGhlIHBhdGNoIG9uIHRvcCBvZiA1LjEwL3Njc2ktcXVldWUKPiAtLS0KPiAg
IGRyaXZlcnMvc2NzaS9scGZjL2xwZmNfY3J0bi5oIHwgMTEgKysrKysrKysrKysKPiAgIDEgZmls
ZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2Nz
aS9scGZjL2xwZmNfY3J0bi5oIGIvZHJpdmVycy9zY3NpL2xwZmMvbHBmY19jcnRuLmgKPiBpbmRl
eCBmNzhlNTJhMThiMGIuLjdlYjAyMDBlY2FhOCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3Njc2kv
bHBmYy9scGZjX2NydG4uaAo+ICsrKyBiL2RyaXZlcnMvc2NzaS9scGZjL2xwZmNfY3J0bi5oCj4g
QEAgLTYwNiwzICs2MDYsMTQgQEAgZXh0ZXJuIHVuc2lnbmVkIGxvbmcgbHBmY19ub19oYmFfcmVz
ZXRbXTsKPiAgIGV4dGVybiB1bmlvbiBscGZjX3dxZTEyOCBscGZjX2lyZWFkX2NtZF90ZW1wbGF0
ZTsKPiAgIGV4dGVybiB1bmlvbiBscGZjX3dxZTEyOCBscGZjX2l3cml0ZV9jbWRfdGVtcGxhdGU7
Cj4gICBleHRlcm4gdW5pb24gbHBmY193cWUxMjggbHBmY19pY21uZF9jbWRfdGVtcGxhdGU7Cj4g
Kwo+ICsvKiB2bWlkIGludGVyZmFjZSAqLwo+ICtpbnQgbHBmY192bWlkX3V2ZW0oc3RydWN0IGxw
ZmNfdnBvcnQgKnZwb3J0LCBzdHJ1Y3QgbHBmY192bWlkICp2bWlkLCBib29sIGlucyk7Cj4gK3Vp
bnQzMl90IGxwZmNfdm1pZF9nZXRfY3NfY3RsKHN0cnVjdCBscGZjX3Zwb3J0ICp2cG9ydCk7Cj4g
K2ludCBscGZjX3ZtaWRfY21kKHN0cnVjdCBscGZjX3Zwb3J0ICp2cG9ydCwKPiArCQkgIGludCBj
bWRjb2RlLCBzdHJ1Y3QgbHBmY192bWlkICp2bWlkKTsKPiAraW50IGxwZmNfdm1pZF9oYXNoX2Zu
KGNoYXIgKnZtaWQsIGludCBsZW4pOwo+ICtzdHJ1Y3QgbHBmY192bWlkICpscGZjX2dldF92bWlk
X2Zyb21faGFzdGFibGUoc3RydWN0IGxwZmNfdnBvcnQgKnZwb3J0LAo+ICsJCQkJCSAgICAgIHVp
bnQzMl90IGhhc2gsIHVpbnQ4X3QgKmJ1Zik7Cj4gK3ZvaWQgbHBmY192bWlkX3Zwb3J0X2NsZWFu
dXAoc3RydWN0IGxwZmNfdnBvcnQgKnZwb3J0KTsKPiAraW50IGxwZmNfaXNzdWVfZWxzX3FmcGEo
c3RydWN0IGxwZmNfdnBvcnQgKnZwb3J0KTsKPiAKSSdkIHJhdGhlciBtZXJnZSB0aGlzIHBhdGNo
IHdpdGggdGhhdCBwYXRjaCBkZWZpbmluZyB0aGUgZnVuY3Rpb25zOyBidXQgCnRoaXMgaXMgbW9y
ZSBhIHN0eWxlIGlzc3VlLgoKUmV2aWV3ZWQtYnk6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNl
LmRlPgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAg
ICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBH
bWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJl
cmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlz
dApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
