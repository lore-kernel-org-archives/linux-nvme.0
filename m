Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971D4C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 22:54:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 602F12073E
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 22:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sxBDhvm6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 602F12073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=T+AMrm23YHrh3jSpepmp6KKKsZaDuPSuD3t7ACweEK8=; b=sxBDhvm6Ch/zYJpLUTmgafX26
	RklutmTMCAZaz3XtVRNLWiVEbidrScYAFrQiU+Od1Z/MYl7rjzRlXQf5g9LRHp88grvoeoeyGmsx4
	nPE9HERcUpDTJV8V/QFZxLHLCfgNwmdyCwheTNo8h5NkziRruGTYIqCm8ccjFgJdNW7/Xz+l8SX4X
	eG+lJH7i1e9632dAxcP+UIItd5DsgPEA0uYmcUxzjbRCHaDHxrjep57bSLnRoUO/Ecq0eLNpiPWkm
	PulJ/cam8KRh/dse+dSZmYUTz3WGq6kETeaTX+NMHGlL/tzOXwW3Z4bR4TycBshOKc2gi1o0aF5nN
	EuwKLHJNQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1joEHX-0000dn-Nd; Wed, 24 Jun 2020 22:54:15 +0000
Received: from mail-wr1-f66.google.com ([209.85.221.66])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joEHU-0000cP-J6
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 22:54:13 +0000
Received: by mail-wr1-f66.google.com with SMTP id r12so3841299wrj.13
 for <linux-nvme@lists.infradead.org>; Wed, 24 Jun 2020 15:54:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=33903KaPiAOi/i63l5Msg94Z9C+lGW9AhLEb2Yr0CGI=;
 b=OwHdX0kllYBf4eCjYOmws1wxx1qtw1IBDEpzvfgZBOUjoz+UTNyjL044YDDG5bZCFQ
 4J9qzL7HpmWKc2i4wtZt1V2VhzSJUxxIShR9TLvsmoHEonD+fzI5aTqAi12K5eMMelxd
 mwwEoof0nG3KE/hxsRDLZtg0ZSzT+UFBZ7QhiOoZW826aZgEaJTslMm/tOBbD4hdFPh8
 FnlwmsB+za4oGT0VlyvLjq4phIaarBhsbwx6pdf/OfIsdz0o7cc4qj2IWZoetXah90S8
 CWV5YUwa7hILx1gFwL5ZFG0CI+aqKp89IhlA+GUhODZ4Xlks8Tz0VbGlAzgrHoEJVoma
 faVA==
X-Gm-Message-State: AOAM532pkXqLGD5P6feOBpFTwhDseuuQmePwa1OHaEyXHg88pICl9ZIv
 i6sTH6/y/GKZpls+ccWf88NT1vZ7
X-Google-Smtp-Source: ABdhPJzCWUw8kGbErxQBOztMvbk5ui8rJevdqB8idOw43yREDr8283C2QqGnF10QwDcftrN1JgFjdg==
X-Received: by 2002:a5d:5388:: with SMTP id d8mr25648959wrv.35.1593039250720; 
 Wed, 24 Jun 2020 15:54:10 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4c08:474f:e61d:6947?
 ([2601:647:4802:9070:4c08:474f:e61d:6947])
 by smtp.gmail.com with ESMTPSA id l17sm10028400wmi.16.2020.06.24.15.54.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2020 15:54:10 -0700 (PDT)
Subject: Re: [PATCHv3 3/5] nvme: implement I/O Command Sets Command Set support
To: Keith Busch <kbusch@kernel.org>
References: <20200623112551.GB117742@localhost.localdomain>
 <20200623221012.GA1291643@dhcp-10-100-145-180.wdl.wdc.com>
 <b5b7f6bc-22d4-0601-1749-2a631fb7d055@grimberg.me>
 <20200624172509.GD1291930@dhcp-10-100-145-180.wdl.wdc.com>
 <e59e402b-de74-e670-59d1-a6c51680a31d@grimberg.me>
 <20200624180323.GE1291930@dhcp-10-100-145-180.wdl.wdc.com>
 <1ddbf614-f5a7-a265-b1a2-7c5ed0922f18@grimberg.me>
 <76966a48-0588-3f3c-0ec1-842cd2ac413d@grimberg.me>
 <20200624184016.GF1291930@dhcp-10-100-145-180.wdl.wdc.com>
 <06623bef-7269-f45b-9f43-8c854ddf812d@grimberg.me>
 <20200624214916.GG1291930@dhcp-10-100-145-180.wdl.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c217a3a9-990f-b134-b3d5-ea719d9e2062@grimberg.me>
Date: Wed, 24 Jun 2020 15:54:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200624214916.GG1291930@dhcp-10-100-145-180.wdl.wdc.com>
Content-Language: en-US
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 Daniel Wagner <dwagner@suse.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
 "hch@lst.de" <hch@lst.de>, Matias Bjorling <Matias.Bjorling@wdc.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiA2LzI0LzIwIDI6NDkgUE0sIEtlaXRoIEJ1c2NoIHdyb3RlOgo+IE9uIFdlZCwgSnVuIDI0
LCAyMDIwIGF0IDEyOjAzOjQxUE0gLTA3MDAsIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4+Cj4+Pj4+
PiBJZiB0aGUgY29udHJvbGxlciBkb2VzIG5vdCBzdXBwb3J0IHRoZSBDTlMgdmFsdWUsIGl0IG1h
eSByZXR1cm4gSW52YWxpZAo+Pj4+Pj4gRmllbGQgd2l0aCBETlIgc2V0LiBUaGF0IGVycm9yIGN1
cnJlbnRseSBnZXRzIHByb3BvZ2F0ZWQgYmFjayB0bwo+Pj4+Pj4gbnZtZV9pbml0X25zX2hlYWQo
KSwgd2hpY2ggdGhlbiBhYmFuZG9ucyB0aGUgbmFtZXNwYWNlLiBKdXN0IGFzIHRoZSBjb2RlCj4+
Pj4+PiBjb21lbnRzIHNheSwgd2UgaGFkIGJlZW4gaGlzdG9yaWNhbGx5IGJlZW4gY2xlYXJpbmcg
c3VjaCBlcnJvcnMgYmVjYXVzZQo+Pj4+Pj4gd2UgaGF2ZSBvdGhlciB3YXlzIHRvIGlkZW50aWZ5
IHRoZSBuYW1lc3BhY2UsIGJ1dCBub3cgd2UncmUgbm90IGNsZWFyaW5nCj4+Pj4+PiB0aGF0IGVy
cm9yLgo+Pj4+Pgo+Pj4+PiBJIGRvbid0IHVuZGVyc3RhbmQgd2hhdCB5b3UgYXJlIHNheWluZyBL
ZWl0aC4KPj4+Pj4KPj4+Pj4gTXkgY29tbWVudCB3YXMgZm9yIHRoaXMgYmxvY2s6Cj4+Pj4+IC0t
IAo+Pj4+PiAgICDCoMKgwqDCoGlmICghc3RhdHVzICYmIG52bWVfbXVsdGlfY3NzKGN0cmwpICYm
ICFjc2lfc2Vlbikgewo+Pj4+PiAgICDCoMKgwqDCoMKgwqDCoCBkZXZfd2FybihjdHJsLT5kZXZp
Y2UsICJDb21tYW5kIHNldCBub3QgcmVwb3J0ZWQgZm9yIG5zaWQ6JWRcbiIsCj4+Pj4+ICAgIMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBuc2lkKTsKPj4+Pj4gICAgwqDCoMKgwqDCoMKgwqAgc3Rh
dHVzID0gLUVJTlZBTDsKPj4+Pj4gICAgwqDCoMKgwqB9Cj4+Pj4+IC0tIAo+Pj4+Pgo+Pj4+PiBJ
IHdhcyBzYXlpbmcgdGhhdCAhc3RhdHVzIGRvZXNuJ3QgbmVjZXNzYXJpbHkgbWVhbiBzdWNjZXNz
LCBidXQgaXQgY2FuCj4+Pj4+IGFsc28gbWVhbiB0aGF0IGl0cyBhbiByZXRyeS1hYmxlIGVycm9y
IHN0YXR1cyAoZHVlIHRvIHRyYW5zcG9ydCBvcgo+Pj4+PiBjb250cm9sbGVyKS4gSWYgd2Ugc2Vl
IGEgcmV0cnktYWJsZSBlcnJvciB3ZSBzaG91bGQgc3RpbGwgY2xlYXIgdGhlCj4+Pj4+IHN0YXR1
cyBzbyB3ZSBkb24ndCBhYmFuZG9uIHRoZSBuYW1lc3BhY2UuCj4+Pj4+Cj4+Pj4+IFRoaXMgZm9y
IGV4YW1wbGUgd291bGQgYWNoaWV2ZSB0aGF0Ogo+Pj4KPj4+IFdlJ3JlIG5vdCB0YWxraW5nIGFi
b3V0IHRoZSBzYW1lIHRoaW5nLiBJIGFtIG9ubHkgdGFsa2luZyBhYm91dCB3aGF0Cj4+PiBpbnRy
b2R1Y2VkIHRoZSBETlIgY2hlY2ssIGZyb20gY29tbWl0IDU5YzdjM2NhYWFmODcuCj4+Pgo+Pj4g
SSBrbm93IHlvdSBhZGRlZCBpdCBiZWNhdXNlIHlvdSB3YW50IHRvIGFib3J0IGNvbXBhcmluZyBp
ZGVudGlmaWVycyBvbiBhCj4+PiByZXNjYW4gd2hlbiByZXRyaWV2aW5nIHRoZSBpZGVudGlmaWVy
cyBmYWlsZWQuIFRoYXQncyBmaW5lLCBidXQgSSBhbQo+Pj4gc2F5aW5nIHRoaXMgZmFpbHMgbmFt
ZXNwYWNlIGNyZWF0aW9uIGluIHRoZSBmaXJzdCBwbGFjZSBmb3Igc29tZSB0eXBlcwo+Pj4gb2Yg
ZGV2aWNlcyB0aGF0IHVzZWQgdG8gc3VjY2VlZC4KPj4KPj4gT0ssIG5vdyBJIHRoaW5rIEkgdW5k
ZXJzdGFuZCAodGhhbmtzIGZvciBjbGFyaWZ5aW5nIHRoYXQgdGhlIGRpc2N1c3Npb24KPj4gaXMg
bm90IG9uIHBhdGNoIDMvNSwgYnV0IHJhdGhlciBvbiA1OWM3YzNjYWFhZjg3KS4KPj4KPj4gU28g
dGhlIG9yaWdpbmFsIHByb3Bvc2FsIHdhcyB0byBjaGVjayBOVk1FX1NDX0hPU1RfUEFUSF9FUlJP
UiAoYW5kIG5vdwo+PiB3ZSBoYXZlIE5WTUVfU0NfSE9TVF9BQk9SVEVEX0NNRCkgYnV0IHdpdGgg
dGhlIHJldmlldyBDaHJpc3RvcGggZ2F2ZQo+PiBpdCBzZWVtZWQgdG8gbWFrZSBtb3JlIHNlbnNl
IHRoYXQgd2UgZ2VuZXJhbGl6ZSBhbmQgY2hlY2sgdGhlIEROUiBiaXQuCj4gCj4gT2theSwgSSBk
aWRuJ3QgcXVlc3Rpb24gdGhpcyBhcHByb2FjaCB3aGVuIGl0IGZpcnN0IHdlbnQgdGhyb3VnaCwg
c28KPiBzb3JyeSBhYm91dCB0aGlzIGRpZ3Jlc3Npb24sIGJ1dCBJIHJlYWxseSBkb24ndCBnZXQg
aG93IHRoaXMgRE5SIGNoZWNrCj4gaGVscHMgYXQgYWxsLgo+IAo+IFRoZSBjb2RlIGN1cnJlbnRs
eSByZXR1cm5zIGFuIGVycm9yIGlmIEROUiBpcyBzZXQuCgpSaWdodC4KCj4gQmFzZWQgb24gdGhl
IGNvbW1pdAo+IG1lc3NhZ2VzLCBpdCBzb3VuZHMgbGlrZSB5b3UgbmVlZCB0aGF0IGVycm9yIHRv
IHNraXAgY29tcGFyaW5nCj4gaWRlbnRpZmllcnMgdGhyb3VnaCBudm1lJ3Mgc2Nhbl93b3JrIGNh
bGxpbmcgcmV2YWxpZGF0ZV9kaXNrKCk6Cj4gc3VwcHJlc3NpbmcgdGhlIGVycm9yIGhhcyByZXZh
bGlkYXRlX2Rpc2soKSBmYWlsIHdpdGggLUVOT0RFViB3aGVuCj4gY29tcGFyaW5nIGlkZW50aWZp
ZXJzIGZhaWxzLgoKWW91ciB1bmRlcnN0YW5kaW5nIGlzIGNvcnJlY3QuCgo+IFNpbmNlIHdlIGRv
IHJldHVybiB0aGUgZXJyb3Igd2hlbiBETlIgaXMgc2V0LCB3ZSBza2lwIGNvbXBhcmluZwo+IGlk
ZW50aWZpZXJzIGFuZCByZXR1cm4gYmxrX3N0YXR1c190b19lcnJubyhudm1lX2Vycm9yX3N0YXR1
cyhyZXQpKQo+IGluc3RlYWQuIEhvdyBpcyB0aGF0IGVycm5vIGFuIGltcHJvdmVtZW50PwoKU2Vl
IG52bWVfcmV2YWxpZGF0ZV9kaXNrOgpvdXQ6CiAgICAgICAgIC8qCiAgICAgICAgICAqIE9ubHkg
ZmFpbCB0aGUgZnVuY3Rpb24gaWYgd2UgZ290IGEgZmF0YWwgZXJyb3IgYmFjayBmcm9tIHRoZQog
ICAgICAgICAgKiBkZXZpY2UsIG90aGVyd2lzZSBpZ25vcmUgdGhlIGVycm9yIGFuZCBqdXN0IG1v
dmUgb24uCiAgICAgICAgICAqLwogICAgICAgICBpZiAocmV0ID09IC1FTk9NRU0gfHwgKHJldCA+
IDAgJiYgIShyZXQgJiBOVk1FX1NDX0ROUikpKQogICAgICAgICAgICAgICAgIHJldCA9IDA7CiAg
ICAgICAgIGVsc2UgaWYgKHJldCA+IDApCiAgICAgICAgICAgICAgICAgcmV0ID0gYmxrX3N0YXR1
c190b19lcnJubyhudm1lX2Vycm9yX3N0YXR1cyhyZXQpKTsKICAgICAgICAgcmV0dXJuIHJldDsK
ClNvIHdlIGRvbid0IGFjdHVhbGx5IHByb3BhZ2F0ZSB0aGUgZXJyb3IgYmFjayBpZiBpdHMgYSBu
b24tRE5SIChoZW5jZQpyZXRyeS1hYmxlIGVycm9yKS4gVGhlIGVycm5vIHdhcyB0aGVyZSBiZWZv
cmUgaW4gb3JkZXIgdG8gbm90IGxlYWsgTlZNZQplcnJvcnMgdG8gdGhlIGJsb2NrIGxheWVyLgoK
PiBBbmQgdGhlbiBpZiBETlIgaXMgbm90IHNldCwgd2Ugc3VwcHJlc3MgdGhlIGVycm9yIGFuZCBw
cm9jZWVkIHdpdGgKPiBjb21wYXJpbmcgaWRlbnRpZmllcnM/PwoKV2FpdCwgSSB0aGluayB0aGF0
IEkgcmUtcmVhZCBpdCBpdCdzIGJhY2t3YXJkcy4gVGhlIGludGVudCB3YXMgdG8gaW5kZWVkCmNs
ZWFyIHRoZSBlcnJvciBmb3IgdGhlIEROUiBjYXNlIGFuZCBwcm9wYWdhdGUgdGhlIGVycm9yIGZv
ciB0aGUgbm9uLUROUgpjYXNlIQoKVGhlIGNvZGUgbmVlZHMgdG8gYmU6Ci0tCmRpZmYgLS1naXQg
YS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKaW5k
ZXggMmFmZWQzMmQzODkyLi4zZTg0YWI2YzJiZDMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbnZtZS9o
b3N0L2NvcmUuYworKysgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKQEAgLTExMzAsNyArMTEz
MCw3IEBAIHN0YXRpYyBpbnQgbnZtZV9pZGVudGlmeV9uc19kZXNjcyhzdHJ1Y3QgbnZtZV9jdHJs
IAoqY3RybCwgdW5zaWduZWQgbnNpZCwKICAgICAgICAgICAgICAgICAgICogRG9uJ3QgdHJlYXQg
YW4gZXJyb3IgYXMgZmF0YWwsIGFzIHdlIHBvdGVudGlhbGx5IAphbHJlYWR5CiAgICAgICAgICAg
ICAgICAgICAqIGhhdmUgYSBOR1VJRCBvciBFVUktNjQuCiAgICAgICAgICAgICAgICAgICAqLwot
ICAgICAgICAgICAgICAgaWYgKHN0YXR1cyA+IDAgJiYgIShzdGF0dXMgJiBOVk1FX1NDX0ROUikp
CisgICAgICAgICAgICAgICBpZiAoc3RhdHVzID4gMCAmJiAoc3RhdHVzICYgTlZNRV9TQ19ETlIp
KQogICAgICAgICAgICAgICAgICAgICAgICAgc3RhdHVzID0gMDsKICAgICAgICAgICAgICAgICBn
b3RvIGZyZWVfZGF0YTsKICAgICAgICAgfQotLQoKVGhpcyB3YXksIGlmIHRoZSBjb250cm9sbGVy
IGZhaWxlZCB0aGUgaWRlbnRpZnkgaXQgd2lsbCBiZSB3aXRoIEROUgpzdGF0dXMgYW5kIHdlIHdp
bGwgc2lsZW50bHkgaWdub3JlLCBhbmQgaWYgdGhlIHRyYW5zcG9ydCBmYWlsZWQgaXRzCmEgbm9u
LUROUiBzdGF0dXMsIGFuZCB3ZSBwcm9wYWdhdGUgdGhlIHN0YXR1cyBiYWNrLCBza2lwIHRoZSBp
ZCBjb21wYXJlLAphbmQgdGhlbiBzaWxlbnRseSBpZ25vcmUgdGhlIGVycm9yIGluIG52bWVfcmV2
YWxpZGF0ZV9kaXNrIChhcyBhYm92ZSkuCgpMb29raW5nIGludG8gdGhlIG9yaWdpbmFsIGZpeCB3
ZSBoYWQgaW50ZXJuYWxseSwgdGhpcyB3YXMgdGhlIGNhc2UsIGFuZApnb3QgZmF0LWZpbmdlcmVk
IGluIEkgY2FuIG9ubHkgYXNzdW1lLi4uCgpXaWxsIHNlbmQgYSBmaXggcmlnaHQgYXdheSwgZ29v
ZCBjYXRjaCBrZWl0aCEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52
bWUK
