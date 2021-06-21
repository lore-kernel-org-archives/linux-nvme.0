Return-Path: <SRS0=I4H8=LP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3719C48BE5
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jun 2021 07:33:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63CF960FDC
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jun 2021 07:33:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63CF960FDC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lKIuW4xc4eqn2ZqLawQ2VJ2LEMei6UL6989AKee6ttw=; b=fCKVFST7dlerIg8xoTc1ITSP+J
	HRM1UDlqEodhSOBVDMxx6V22OL3xpi0DmAzrpGkm5OeVbOCixzWL37BQsNHNp1WCVl3/JCwEoYIV4
	KsWvcYefkxjWKJ3Ytno2RuLC5JwmRzGSROIbNlutnJIdJ+CKqP92fbRpq1CkXFnoJ83rSnjSDc+Tz
	V4uAel2PWq4/k6VtVUE40oSptxt7NMpuxykHqFmNa6B0tqrlUU3DTXriqJrNZgoR1LO8E+CGopFbo
	D696H1w/Od0O+KDopebazxBoIiA92M1LS3ADyaTKCKw7DapbdvEecMabUkJVX2CLWmsizX0ZPqr8d
	wuqQf0ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lvER3-002Y3s-HE; Mon, 21 Jun 2021 07:33:33 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lvEQz-002Xy6-NL
 for linux-nvme@lists.infradead.org; Mon, 21 Jun 2021 07:33:31 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 293C921A97;
 Mon, 21 Jun 2021 07:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1624260806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4IFwuncNXeF7w1Sh+b3vsXhs8nqGOl0QeuCIO3baB7E=;
 b=UowcFKwo+lZW9sWC4JUdOUcDYri+69aMCGAdKUCTq64XG3iUAT/zJB8EJVi0PxYMEhFAXZ
 uTHN31qA0YibLICFDaKzgPxUIu0djpWMIx4XWN6vlvwi/ZYqYvm9hJSdDCYFp58EUooqmn
 l+RQDjsgqfB2XtuYLenLkUT5DcNJcv8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1624260806;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4IFwuncNXeF7w1Sh+b3vsXhs8nqGOl0QeuCIO3baB7E=;
 b=uSuMgP0e76nwaiMOZIk1Kw5iotGtuJ4tvxK1BqGelseUQR5vQjHrDxMUwH0stjornEmbu1
 AuIGvmQqMEowKzCA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id C64DC118DD;
 Mon, 21 Jun 2021 07:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1624260806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4IFwuncNXeF7w1Sh+b3vsXhs8nqGOl0QeuCIO3baB7E=;
 b=UowcFKwo+lZW9sWC4JUdOUcDYri+69aMCGAdKUCTq64XG3iUAT/zJB8EJVi0PxYMEhFAXZ
 uTHN31qA0YibLICFDaKzgPxUIu0djpWMIx4XWN6vlvwi/ZYqYvm9hJSdDCYFp58EUooqmn
 l+RQDjsgqfB2XtuYLenLkUT5DcNJcv8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1624260806;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4IFwuncNXeF7w1Sh+b3vsXhs8nqGOl0QeuCIO3baB7E=;
 b=uSuMgP0e76nwaiMOZIk1Kw5iotGtuJ4tvxK1BqGelseUQR5vQjHrDxMUwH0stjornEmbu1
 AuIGvmQqMEowKzCA==
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id wqHeLMVA0GDKCgAALh3uQQ
 (envelope-from <hare@suse.de>); Mon, 21 Jun 2021 07:33:25 +0000
Subject: Re: [PATCHv6] nvme: allow to re-attach namespaces after all paths are
 down
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20210609150118.130650-1-hare@suse.de>
 <20210621063820.GA5618@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <9c02c4bb-992d-3be1-8e66-1c5aa90de515@suse.de>
Date: Mon, 21 Jun 2021 09:33:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210621063820.GA5618@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210621_003329_950126_E80C243B 
X-CRM114-Status: GOOD (  22.94  )
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

T24gNi8yMS8yMSA4OjM4IEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBPbiBXZWQsIEp1
biAwOSwgMjAyMSBhdCAwNTowMToxOFBNICswMjAwLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9kcml2ZXJzL252bWUvaG9z
dC9jb3JlLmMKPj4gaW5kZXggMTc3Y2FlNDRiNjEyLi42ZDdjMjk1OGIzZTIgMTAwNjQ0Cj4+IC0t
LSBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+PiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9j
b3JlLmMKPj4gQEAgLTU2Niw2ICs1NjYsOSBAQCBzdGF0aWMgdm9pZCBudm1lX2ZyZWVfbnNfaGVh
ZChzdHJ1Y3Qga3JlZiAqcmVmKQo+PiAgIAlzdHJ1Y3QgbnZtZV9uc19oZWFkICpoZWFkID0KPj4g
ICAJCWNvbnRhaW5lcl9vZihyZWYsIHN0cnVjdCBudm1lX25zX2hlYWQsIHJlZik7Cj4+ICAgCj4+
ICsJbXV0ZXhfbG9jaygmaGVhZC0+c3Vic3lzLT5sb2NrKTsKPj4gKwlsaXN0X2RlbF9pbml0KCZo
ZWFkLT5lbnRyeSk7Cj4+ICsJbXV0ZXhfdW5sb2NrKCZoZWFkLT5zdWJzeXMtPmxvY2spOwo+PiAg
IAludm1lX21wYXRoX3JlbW92ZV9kaXNrKGhlYWQpOwo+PiAgIAlpZGFfc2ltcGxlX3JlbW92ZSgm
aGVhZC0+c3Vic3lzLT5uc19pZGEsIGhlYWQtPmluc3RhbmNlKTsKPj4gICAJY2xlYW51cF9zcmN1
X3N0cnVjdCgmaGVhZC0+c3JjdSk7Cj4+IEBAIC0zODA2LDggKzM4MDksNiBAQCBzdGF0aWMgdm9p
ZCBudm1lX2FsbG9jX25zKHN0cnVjdCBudm1lX2N0cmwgKmN0cmwsIHVuc2lnbmVkIG5zaWQsCj4+
ICAgIG91dF91bmxpbmtfbnM6Cj4+ICAgCW11dGV4X2xvY2soJmN0cmwtPnN1YnN5cy0+bG9jayk7
Cj4+ICAgCWxpc3RfZGVsX3JjdSgmbnMtPnNpYmxpbmdzKTsKPj4gLQlpZiAobGlzdF9lbXB0eSgm
bnMtPmhlYWQtPmxpc3QpKQo+PiAtCQlsaXN0X2RlbF9pbml0KCZucy0+aGVhZC0+ZW50cnkpOwo+
PiAgIAltdXRleF91bmxvY2soJmN0cmwtPnN1YnN5cy0+bG9jayk7Cj4+ICAgCW52bWVfcHV0X25z
X2hlYWQobnMtPmhlYWQpOwo+PiAgICBvdXRfZnJlZV9xdWV1ZToKPj4gQEAgLTM4MjgsOCArMzgy
OSw2IEBAIHN0YXRpYyB2b2lkIG52bWVfbnNfcmVtb3ZlKHN0cnVjdCBudm1lX25zICpucykKPj4g
ICAKPj4gICAJbXV0ZXhfbG9jaygmbnMtPmN0cmwtPnN1YnN5cy0+bG9jayk7Cj4+ICAgCWxpc3Rf
ZGVsX3JjdSgmbnMtPnNpYmxpbmdzKTsKPj4gLQlpZiAobGlzdF9lbXB0eSgmbnMtPmhlYWQtPmxp
c3QpKQo+PiAtCQlsaXN0X2RlbF9pbml0KCZucy0+aGVhZC0+ZW50cnkpOwo+PiAgIAltdXRleF91
bmxvY2soJm5zLT5jdHJsLT5zdWJzeXMtPmxvY2spOwo+PiAgIAo+PiAgIAlzeW5jaHJvbml6ZV9y
Y3UoKTsgLyogZ3VhcmFudGVlIG5vdCBhdmFpbGFibGUgaW4gaGVhZC0+bGlzdCAqLwo+PiBAQCAt
Mzg0OSw3ICszODQ4LDcgQEAgc3RhdGljIHZvaWQgbnZtZV9uc19yZW1vdmUoc3RydWN0IG52bWVf
bnMgKm5zKQo+PiAgIAlsaXN0X2RlbF9pbml0KCZucy0+bGlzdCk7Cj4+ICAgCXVwX3dyaXRlKCZu
cy0+Y3RybC0+bmFtZXNwYWNlc19yd3NlbSk7Cj4+ICAgCj4+IC0JbnZtZV9tcGF0aF9jaGVja19s
YXN0X3BhdGgobnMpOwo+PiArCW52bWVfbXBhdGhfY2hlY2tfbGFzdF9wYXRoKG5zLT5oZWFkKTsK
Pj4gICAJbnZtZV9wdXRfbnMobnMpOwo+PiAgIH0KPj4gICAKPj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbnZtZS9ob3N0L211bHRpcGF0aC5jIGIvZHJpdmVycy9udm1lL2hvc3QvbXVsdGlwYXRoLmMK
Pj4gaW5kZXggMjM1NzNmZTNmYzdkLi4zMTE1M2Y2ZWM1ODIgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZl
cnMvbnZtZS9ob3N0L211bHRpcGF0aC5jCj4+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L211bHRp
cGF0aC5jCj4+IEBAIC0yNjYsNiArMjY2LDggQEAgaW5saW5lIHN0cnVjdCBudm1lX25zICpudm1l
X2ZpbmRfcGF0aChzdHJ1Y3QgbnZtZV9uc19oZWFkICpoZWFkKQo+PiAgIAlpbnQgbm9kZSA9IG51
bWFfbm9kZV9pZCgpOwo+PiAgIAlzdHJ1Y3QgbnZtZV9ucyAqbnM7Cj4+ICAgCj4+ICsJaWYgKCEo
aGVhZC0+ZGlzay0+ZmxhZ3MgJiBHRU5IRF9GTF9VUCkpCj4+ICsJCXJldHVybiBOVUxMOwo+PiAg
IAlucyA9IHNyY3VfZGVyZWZlcmVuY2UoaGVhZC0+Y3VycmVudF9wYXRoW25vZGVdLCAmaGVhZC0+
c3JjdSk7Cj4+ICAgCWlmICh1bmxpa2VseSghbnMpKQo+PiAgIAkJcmV0dXJuIF9fbnZtZV9maW5k
X3BhdGgoaGVhZCwgbm9kZSk7Cj4+IEBAIC0yODEsNiArMjgzLDggQEAgc3RhdGljIGJvb2wgbnZt
ZV9hdmFpbGFibGVfcGF0aChzdHJ1Y3QgbnZtZV9uc19oZWFkICpoZWFkKQo+PiAgIHsKPj4gICAJ
c3RydWN0IG52bWVfbnMgKm5zOwo+PiAgIAo+PiArCWlmICghKGhlYWQtPmRpc2stPmZsYWdzICYg
R0VOSERfRkxfVVApKQo+PiArCQlyZXR1cm4gZmFsc2U7Cj4+ICAgCWxpc3RfZm9yX2VhY2hfZW50
cnlfcmN1KG5zLCAmaGVhZC0+bGlzdCwgc2libGluZ3MpIHsKPj4gICAJCWlmICh0ZXN0X2JpdChO
Vk1FX0NUUkxfRkFJTEZBU1RfRVhQSVJFRCwgJm5zLT5jdHJsLT5mbGFncykpCj4+ICAgCQkJY29u
dGludWU7Cj4+IEBAIC03NzEsMjAgKzc3NSwzNiBAQCB2b2lkIG52bWVfbXBhdGhfYWRkX2Rpc2so
c3RydWN0IG52bWVfbnMgKm5zLCBzdHJ1Y3QgbnZtZV9pZF9ucyAqaWQpCj4+ICAgI2VuZGlmCj4+
ICAgfQo+PiAgIAo+PiAtdm9pZCBudm1lX21wYXRoX3JlbW92ZV9kaXNrKHN0cnVjdCBudm1lX25z
X2hlYWQgKmhlYWQpCj4+ICt2b2lkIG52bWVfbXBhdGhfY2hlY2tfbGFzdF9wYXRoKHN0cnVjdCBu
dm1lX25zX2hlYWQgKmhlYWQpCj4+ICAgewo+PiArCWJvb2wgbGFzdF9wYXRoID0gZmFsc2U7Cj4+
ICAgCWlmICghaGVhZC0+ZGlzaykKPj4gICAJCXJldHVybjsKPj4gKwo+PiArCS8qIFN5bmNocm9u
aXplIHdpdGggbnZtZV9pbml0X25zX2hlYWQoKSAqLwo+PiArCW11dGV4X2xvY2soJmhlYWQtPnN1
YnN5cy0+bG9jayk7Cj4+ICsJaWYgKGxpc3RfZW1wdHkoJmhlYWQtPmxpc3QpKQo+PiArCQlsYXN0
X3BhdGggPSB0cnVlOwo+PiArCW11dGV4X3VubG9jaygmaGVhZC0+c3Vic3lzLT5sb2NrKTsKPj4g
KwlpZiAobGFzdF9wYXRoKSB7Cj4+ICsJCWtibG9ja2Rfc2NoZWR1bGVfd29yaygmaGVhZC0+cmVx
dWV1ZV93b3JrKTsKPj4gKwkJaWYgKGhlYWQtPmRpc2stPmZsYWdzICYgR0VOSERfRkxfVVApIHsK
Pj4gKwkJCW52bWVfY2Rldl9kZWwoJmhlYWQtPmNkZXYsICZoZWFkLT5jZGV2X2RldmljZSk7Cj4+
ICsJCQlkZWxfZ2VuZGlzayhoZWFkLT5kaXNrKTsKPj4gKwkJfQo+PiAgIAl9Cj4+ICt9Cj4+ICsK
Pj4gK3ZvaWQgbnZtZV9tcGF0aF9yZW1vdmVfZGlzayhzdHJ1Y3QgbnZtZV9uc19oZWFkICpoZWFk
KQo+PiArewo+PiArCWlmICghaGVhZC0+ZGlzaykKPj4gKwkJcmV0dXJuOwo+PiAgIAlibGtfc2V0
X3F1ZXVlX2R5aW5nKGhlYWQtPmRpc2stPnF1ZXVlKTsKPj4gICAJLyogbWFrZSBzdXJlIGFsbCBw
ZW5kaW5nIGJpb3MgYXJlIGNsZWFuZWQgdXAgKi8KPj4gICAJa2Jsb2NrZF9zY2hlZHVsZV93b3Jr
KCZoZWFkLT5yZXF1ZXVlX3dvcmspOwo+PiAgIAlmbHVzaF93b3JrKCZoZWFkLT5yZXF1ZXVlX3dv
cmspOwo+PiAgIAlibGtfY2xlYW51cF9xdWV1ZShoZWFkLT5kaXNrLT5xdWV1ZSk7Cj4+IC0JaWYg
KCF0ZXN0X2JpdChOVk1FX05TSEVBRF9ESVNLX0xJVkUsICZoZWFkLT5mbGFncykpIHsKPj4gKwlp
ZiAoIXRlc3RfYW5kX2NsZWFyX2JpdChOVk1FX05TSEVBRF9ESVNLX0xJVkUsICZoZWFkLT5mbGFn
cykpIHsKPj4gICAJCS8qCj4+ICAgCQkgKiBpZiBkZXZpY2VfYWRkX2Rpc2sgd2Fzbid0IGNhbGxl
ZCwgcHJldmVudAo+PiAgIAkJICogZGlzayByZWxlYXNlIHRvIHB1dCBhIGJvZ3VzIHJlZmVyZW5j
ZSBvbiB0aGUKPiAKPiBTbyBpZiBhIG52bWVfbXBhdGhfc2V0X2xpdmUgY29tZXMgaW4gYmV0d2Vl
biBudm1lX21wYXRoX2NoZWNrX2xhc3RfcGF0aAo+IGFuZCBudm1lX21wYXRoX3JlbW92ZV9kaXNr
IHdlJ2xsIGVuZCB1cCB3aXRob3V0IGEgZ2VuZGlzayBzdGlsbCwgZG9uJ3Qgd2U/Cj4gCkkgY2Fu
J3Qgc2VlIGhvdyB3ZSBjYW4gZW5kIHVwIHRoZXJlLgpJZiB3ZSBjYWxsIG52bWVfbXBhdGhfc2V0
X2xpdmUoKSB3ZSB3aWxsIGhhdmUgdG8gaGF2ZSBhIHJlZmVyZW5jZSBvbiAKbnNfaGVhZCwgY29u
c2VxdWVudGx5IG52bWVfbXBhdGhfcmVtb3ZlX2Rpc2soKSB3aWxsIG5vdCBiZSBjYWxsZWQgZm9y
IAp0aGF0IG5zX2hlYWQgYXMgdGhhdCBmdW5jdGlvbiBpcyBjYWxsZWQgZnJvbSB0aGUga3JlZiBj
YWxsYmFjayBvbmNlIGFsbCAKcmVmZXJlbmNlcyBhcmUgZHJvcHBlZC4KCkFtIEkgbWlzc2luZyBz
b21ldGhpbmc/CgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAg
ICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRp
b25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7D
vHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGlu
ZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
