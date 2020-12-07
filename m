Return-Path: <SRS0=D68J=FL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91152C433FE
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 22:21:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C25D2396F
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 22:21:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C25D2396F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=interlog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:Reply-To:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OZsRUsjO1z6XeSFwq16b9tVAQgF6A+g71UgpaVa88iQ=; b=v4Lj2tRwKilQt6
	rPMpCXco1+QePqSzx0lSFwEB5+DmiwXIGZigmd9xlk1BPzuGwTDbjtcdDpEm5gJ0VUdZH2inhO7o2
	Vthui5e45B7JIhWtTC1PbPz+CVFCKzq3pdRFUiAPDmDhltxE6idnVVa25uiqI7mJaPd1RCzKnOKXB
	09SXGOqoGKS4/PBmB1RnnIxzH0Pe13Z1ilw+DRGQcqxdeYfSQf0lbBut1zk9PbHBA6oYfOnlidczJ
	oavODgY5BufcvPnJ9G/tIt6Qb8rq7asbFV7EIcflE9Ml0CxVl4Ud0hvqjDwiBhfPE7239KHXK4Ikk
	Iss3v6ZhMghHsmOrNYVA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmOsv-0003VT-Um; Mon, 07 Dec 2020 22:21:33 +0000
Received: from mail-1.ca.inter.net ([208.85.220.69])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmOst-0003V1-AU
 for linux-nvme@lists.infradead.org; Mon, 07 Dec 2020 22:21:32 +0000
Received: from localhost (offload-3.ca.inter.net [208.85.220.70])
 by mail-1.ca.inter.net (Postfix) with ESMTP id 57DD82EA0BF;
 Mon,  7 Dec 2020 17:12:22 -0500 (EST)
Received: from mail-1.ca.inter.net ([208.85.220.69])
 by localhost (offload-3.ca.inter.net [208.85.220.70]) (amavisd-new, port 10024)
 with ESMTP id G7eYR5PKV6Ue; Mon,  7 Dec 2020 17:01:35 -0500 (EST)
Received: from [192.168.48.23] (host-104-157-204-209.dyn.295.ca
 [104.157.204.209])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: dgilbert@interlog.com)
 by mail-1.ca.inter.net (Postfix) with ESMTPSA id 2ED332EA040;
 Mon,  7 Dec 2020 17:12:20 -0500 (EST)
Subject: Re: [RFC PATCH v2 0/2] add simple copy support
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 SelvaKumar S <selvakuma.s1@samsung.com>
References: <CGME20201204094719epcas5p23b3c41223897de3840f92ae3c229cda5@epcas5p2.samsung.com>
 <20201204094659.12732-1-selvakuma.s1@samsung.com>
 <20201207141123.GC31159@lst.de>
 <01fe46ac-16a5-d4db-f23d-07a03d3935f3@suse.de>
From: Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <194d7813-8c8c-85c8-e0c8-94aaab7c291e@interlog.com>
Date: Mon, 7 Dec 2020 17:12:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <01fe46ac-16a5-d4db-f23d-07a03d3935f3@suse.de>
Content-Language: en-CA
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201207_172131_393073_D428ECDD 
X-CRM114-Status: GOOD (  26.01  )
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
Reply-To: dgilbert@interlog.com
Cc: axboe@kernel.dk, damien.lemoal@wdc.com, sagi@grimberg.me,
 snitzer@redhat.com, selvajove@gmail.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 dm-devel@redhat.com, Mikulas Patocka <mpatocka@redhat.com>,
 joshi.k@samsung.com, "Martin K. Petersen" <martin.petersen@oracle.com>,
 kbusch@kernel.org, javier.gonz@samsung.com, linux-scsi@vger.kernel.org,
 nj.shetty@samsung.com, Bart Van Assche <bvanassche@acm.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMjAyMC0xMi0wNyA5OjU2IGEubS4sIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPiBPbiAxMi83
LzIwIDM6MTEgUE0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+PiBTbywgSSdtIHJlYWxseSB3
b3JyaWVkIGFib3V0Ogo+Pgo+PiDCoCBhKSBhIGdvb2QgdXNlIGNhc2UuwqAgR0MgaW4gZjJmcyBv
ciBidHJmcyBzZWVtIGxpa2UgZ29vZCB1c2UgY2FzZXMsIGFzCj4+IMKgwqDCoMKgIGRvZXMgYWNj
ZWxhdGluZyBkbS1rY29weWQuwqAgSSBhZ3JlZSB3aXRoIERhbWllbiB0aGF0IGxpZnRpbmcgZG0t
a2NvcHlkCj4+IMKgwqDCoMKgIHRvIGNvbW1vbiBjb2RlIHdvdWxkIGFsc28gYmUgcmVhbGx5IG5p
Y2UuwqAgSSdtIG5vdCAxMDAlIHN1cmUgaXQgc2hvdWxkCj4+IMKgwqDCoMKgIGJlIGEgcmVxdWly
ZW1lbnQsIGJ1dCBpdCBzdXJlIHdvdWxkIGJlIG5pY2UgdG8gaGF2ZQo+PiDCoMKgwqDCoCBJIGRv
bid0IHRoaW5rIGp1c3QgYWRkaW5nIGFuIGlvY3RsIGlzIGVub3VnaCBvZiBhIHVzZSBjYXNlIGZv
ciBjb21wbGV4Cj4+IMKgwqDCoMKgIGtlcm5lbCBpbmZyYXN0cnVjdHVyZS4KPj4gwqAgYikgV2Ug
aGFkIGEgYnVuY2ggb2YgZGlmZmVyZW50IGF0dGVtcHRzIGF0IFNDU0kgWENPUFkgc3VwcG9ydCBm
b3JtIElJUkMKPj4gwqDCoMKgwqAgTWFydGluLCBCYXJ0IGFuZCBNaWt1bGFzLsKgIEkgdGhpbmsg
d2UgbmVlZCB0byBwdWxsIHRoZW0gaW50byB0aGlzCj4+IMKgwqDCoMKgIGRpc2N1c3Npb24sIGFu
ZCBtYWtlIHN1cmUgd2hhdGV2ZXIgd2UgZG8gY292ZXJzIHRoZSBTQ1NJIG5lZWRzLgo+Pgo+IEFu
ZCB3ZSBzaG91bGRuJ3QgZm9yZ2V0IHRoYXQgdGhlIG1haW4gaXNzdWUgd2hpY2gga2lsbGVkIGFs
bCBwcmV2aW91cyAKPiBpbXBsZW1lbnRhdGlvbnMgd2FzIGEgbWlzc2luZyBRb1MgZ3VhcmFudGVl
Lgo+IEl0J3MgbmljZSB0byBoYXZlIHNpbXBseSBjb3B5LCBidXQgaWYgdGhlIGltcGxlbWVudGF0
aW9uIGlzIF9zbG93ZXJfIHRoYW4gZG9pbmcgCj4gaXQgYnkgaGFuZCBmcm9tIHRoZSBPUyB0aGVy
ZSBpcyB2ZXJ5IGxpdHRsZSBwb2ludCBpbiBldmVuIGF0dGVtcHRpbmcgdG8gZG8gc28uCj4gSSBj
YW4ndCBzZWUgYW55IHByb3Zpc2lvbnMgZm9yIHRoYXQgaW4gdGhlIFRQQVIsIGxlYWRpbmcgbWUg
dG8gdGhlIGFzc3VtcHRpb24gCj4gdGhhdCBOVk1lIHNpbXBsZSBjb3B5IHdpbGwgc3VmZmVyIGZy
b20gdGhlIHNhbWUgaXNzdWUuCj4gCj4gU28gaWYgd2UgY2FuJ3QgYWRkcmVzcyB0aGlzIEkgZ3Vl
c3MgdGhpcyBhdHRlbXB0IHdpbGwgZmFpbCwgdG9vLgoKSSBoYXZlIGJlZW4gZG9pbmcgcXVpdGUg
YSBsb3Qgb2Ygd29yayBhbmQgdGVzdGluZyBpbiBteSBzZyBkcml2ZXIgcmV3cml0ZQppbiB0aGUg
Y29weSBhbmQgY29tcGFyZSBhcmVhLiBUaGUgYmFzZWxpbmVzIGZvciBwZXJmb3JtYW5jZSBhcmUg
ZGQgYW5kCmlvX3VyaW5nLWNwIChpbiBsaWJ1cmluZykuIFRoZXJlIGFyZSBsb3RzIG9mIHdheXMg
dG8gaW1wcm92ZSBvbiB0aGVtLiBIZXJlCmFyZSBzb21lOgogICAgLSB0aGUgdXNlciBkYXRhIG5l
ZWQgbmV2ZXIgcGFzcyB0aHJvdWdoIHRoZSB1c2VyIHNwYWNlIChjb3VsZAogICAgICBtbWFwIGl0
IG91dCBkdXJpbmcgdGhlIFJFQUQgaWYgdGhlcmUgaXMgYSBnb29kIHJlYXNvbikuIE9ubHkgdGhl
CiAgICAgIG1ldGFkYXRhIChlLmcuIE5WTWUgb3IgU0NTSSBjb21tYW5kcykgbmVlZHMgdG8gY29t
ZSBmcm9tIHRoZSB1c2VyCiAgICAgIHNwYWNlIGFuZCBlcnJvcnMsIGlmIGFueSwgcmVwb3J0ZWQg
YmFjayB0byB0aGUgdXNlciBzcGFjZS4KICAgIC0gYnJlYWsgYSBsYXJnZSBjb3B5IChvciBjb21w
YXJlKSBpbnRvIHNlZ21lbnRzLCB3aXRoIGVhY2ggc2VnbWVudAogICAgICBhICJjb21mb3J0YWJs
ZSIgc2l6ZSBmb3IgdGhlIE9TIHRvIGhhbmRsZSwgc2F5IDI1NiBLQgogICAgLSB0aGVyZSBpcyBv
bmUgY29uc3RyYWludDogdGhlIFJFQUQgaW4gZWFjaCBzZWdtZW50IG11c3QgY29tcGxldGUKICAg
ICAgYmVmb3JlIGl0cyBwYWlyZWQgV1JJVEUgY2FuIGNvbW1lbmNlCiAgICAgIC0gZXh0cmEgY29u
c3RyYWludCBmb3Igc29tZSB6b25lZCBkaXNrczogV1JJVEVzIG11c3QgYmUKICAgICAgICBpc3N1
ZWQgaW4gb3JkZXIgKGFzc3VtaW5nIHRoZXkgYXJlIGFwcGxpZWQgaW4gdGhhdCBvcmRlciwgaWYK
ICAgICAgICBub3QsIG5lZWQgdG8gd2FpdCB1bnRpbCBlYWNoIFdSSVRFIGNvbXBsZXRlcykKICAg
IC0gYXJyYW5nZSBmb3IgUkVBRCBXUklURSBwYWlyIGluIGVhY2ggc2VnbWVudCB0byBzaGFyZSB0
aGUgc2FtZSBiaW8KICAgIC0gaGF2ZSBtdWx0aXBsZSBzbG90cyBlYWNoIGhvbGRpbmcgYSBzZWdt
ZW50IChpLmUuIGEgYmlvIGFuZAogICAgICBtZXRhZGF0YSB0byBwcm9jZXNzIGEgUkVBRC1XUklU
RSBwYWlyKQogICAgLSByZS11c2UgZWFjaCBzbG90J3MgYmlvIGZvciB0aGUgZm9sbG93aW5nIFJF
QUQtV1JJVEUgcGFpcgogICAgLSBpc3N1ZSB0aGUgUkVBRHMgaW4gZWFjaCBzbG90IGFzeW5jaHJv
bm91c2x5IGFuZCBkbyBhbiBpbnRlcmxlYXZlZAogICAgICAoaW8pcG9sbCBmb3IgY29tcGxldGlv
bi4gVGhlbiBpc3N1ZSB0aGUgcGFpcmVkIFdSSVRFCiAgICAgIGFzeW5jaHJvbm91c2x5CiAgICAt
IHRoZSBhYm92ZSAic2xvdCIgYWxnb3JpdGhtIHJ1bnMgaW4gb25lIHRocmVhZCwgc28gdGhlcmUg
Y2FuIGJlCiAgICAgIG11bHRpcGxlIHRocmVhZHMgZG9pbmcgdGhlIHNhbWUgYWxnb3JpdGhtLiBT
ZWdtZW50IG1hbmFnZXIgbmVlZHMKICAgICAgdG8gYmUgbG9ja2VkIChvciB1c2UgYW4gYXRvbWlj
cykgc28gdGhhdCBlYWNoIHNlZ21lbnQgKGlkZW50aWZpZWQKICAgICAgYnkgaXRzIHN0YXJ0aW5n
IExCQXMpIGlzIGlzc3VlZCBvbmNlIGFuZCBvbmx5IG9uY2Ugd2hlbiB0aGUKICAgICAgbmV4dCB0
aHJlYWQgd2FudHMgYSBzZWdtZW50IHRvIGNvcHkKClJ1bm5pbmcgbXVsdGlwbGUgdGhyZWFkcyBn
aXZlcyBkaW1pbmlzaGluZyBvciBldmVuIHdvcnNlbmluZyByZXR1cm5zLgpSdW50aW1lIG1ldHJp
Y3Mgb24gbG9jayBjb250ZW50aW9uIGFuZCBzdG9yYWdlIGJ1cyBjYXBhY2l0eSBtYXkgaGVscApj
aG9vc2luZyB0aGUgbnVtYmVyIG9mIHRocmVhZHMuIEEgc2ltcGxlciBhcHByb2FjaCBtaWdodCBi
ZSBhZGQgbW9yZQp0aHJlYWRzIHVudGlsIHRoZSBjb21iaW5lZCB0aHJvdWdocHV0IGluY3JlYXNl
IGlzIGxlc3MgdGhhbiAxMCUgc2F5LgoKClRoZSAnY29tcGFyZScgdGhhdCBJIG1lbnRpb24gaXMg
YmFzZWQgb24gdGhlIFNDU0kgVkVSSUZZKEJZVENISz0xKSBjb21tYW5kCihvciBOVk1lIE5WTSBD
b21wYXJlIGNvbW1hbmQpLiBVc2luZyBkZCBsb2dpYywgYSBkaXNrIHRvIGRpc2sgY29tcGFyZSBj
YW4KYmUgaW1wbGVtZW50ZWQgd2l0aCBub3QgbXVjaCBtb3JlIHdvcmsgdGhhbiBjaGFuZ2luZyB0
aGUgV1JJVEUgdG8gYSBWRVJJRlkKY29tbWFuZC4gVGhpcyBpcyBhIGRpZmZlcmVudCBhcHByb2Fj
aCB0byB0aGUgTGludXggY21wIHV0aWxpdHkgd2hpY2gKUkVBRHMgaW4gYm90aCBzaWRlcyBhbmQg
ZG9lcyBhIG1lbWNtcCgpIHR5cGUgb3BlcmF0aW9uLiBVc2luZyByYW1kaXNrcwooZnJvbSB0aGUg
c2NzaV9kZWJ1ZyBkcml2ZXIpIHRoZSBjb21wYXJlIG9wZXJhdGlvbiAobWF4IH4gMTAgR0Ivcykg
d2FzCmFjdHVhbGx5IGZhc3RlciB0aGFuIHRoZSBjb3B5IChtYXggfiA3IEdCL3MpLiBJIHB1dCB0
aGlzIGRvd24gdG8gV1JJVEUKb3BlcmF0aW9ucyB0YWtpbmcgYSB3cml0ZSBsb2NrIG92ZXIgdGhl
IHN0b3JlIHdoaWxlIHRoZSBWRVJJRlkgb25seQpuZWVkcyBhIHJlYWQgbG9jayBzbyBtYW55IFZF
UklGWSBvcGVyYXRpb25zIGNhbiBjby1leGlzdCBvbiB0aGUgc2FtZQpzdG9yZS4gVW5mb3J0dW5h
dGVseSBvbiByZWFsIFNBUyBhbmQgTlZNZSBTU0RzIHRoYXQgSSB0ZXN0ZWQgdGhlCnBlcmZvcm1h
bmNlIG9mIHRoZSBWRVJJRlkgYW5kIE5WTSBDb21wYXJlIGNvbW1hbmRzIGlzIHVuZGVyd2hlbG1p
bmcuCkZvciBjb21wYXJpc29uLCB1c2luZyBzY3NpX2RlYnVnIHJhbWRpc2tzLCBkZCBjb3B5IHRo
cm91Z2hwdXQgd2FzCjwgMSBHQi9zIGFuZCBpb191cmluZy1jcCB3YXMgYXJvdW5kIDItMyBHQi9z
LiBUaGUgc3lzdGVtIHdhcyBSeXplbgozNjAwIGJhc2VkLgoKRG91ZyBHaWxiZXJ0CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxp
bmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
