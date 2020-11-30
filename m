Return-Path: <SRS0=wRjJ=FE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07099C63777
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Nov 2020 07:56:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CB2A20679
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Nov 2020 07:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e1Mwtm7E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CB2A20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PwwCNUmRA3dEBxquPEZpPdS8pgV7c2jqjTCYo+ZToxs=; b=e1Mwtm7EGuo4BVLIxnGyZ+40m
	6ZCgJuc587w0GmSSAjzjtEdjC/oqSAJ0eUF52qjyil/9y/w5UYCC6ncCnVR2Ror7YtndcZ1Dw/nVJ
	CKsbNoWTeExb556+3PLruvRkarYxj+JInOlr+gkGRq8RuV/weOLgrad5YWgMuyOgEFs/eLdbL6lYk
	aqD5VjY/4G1Gr5ViWqMQ5YNVARJ5/zsawQTWSIrKdyaYh4rklhOEMq44K7MpaWpwPuHeHxERy5TrQ
	iSRnjaJ9ayqSlvfvp8rOyTvY2kXLUDyHiZxlZmOEmAgTNFSScgYqUattZNfbpfrGNsWJXzXuY9jj4
	ZG+fKErdw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kje2e-0005lx-HH; Mon, 30 Nov 2020 07:56:12 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kje2O-0005fT-SN
 for linux-nvme@lists.infradead.org; Mon, 30 Nov 2020 07:56:10 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id CF14DAD09;
 Mon, 30 Nov 2020 07:55:55 +0000 (UTC)
Subject: Re: [PATCH 1/4] block: add a hard-readonly flag to struct gendisk
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
References: <20201129181926.897775-1-hch@lst.de>
 <20201129181926.897775-2-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <d28dc6f5-bae1-ddfa-8874-9c22235a69f3@suse.de>
Date: Mon, 30 Nov 2020 08:55:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201129181926.897775-2-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201130_025557_075563_BAFC2A1C 
X-CRM114-Status: GOOD (  28.67  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Mike Snitzer <snitzer@redhat.com>,
 Oleksii Kurochko <olkuroch@cisco.com>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>, linux-block@vger.kernel.org,
 dm-devel@redhat.com, linux-nvme@lists.infradead.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTEvMjkvMjAgNzoxOSBQTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gQ29tbWl0IDIw
YmQxZDAyNmFhYyAoInNjc2k6IHNkOiBLZWVwIGRpc2sgcmVhZC1vbmx5IHdoZW4gcmUtcmVhZGlu
Zwo+IHBhcnRpdGlvbiIpIGFkZHJlc3NlZCBhIGxvbmctc3RhbmRpbmcgcHJvYmxlbSB3aXRoIHVz
ZXIgcmVhZC1vbmx5Cj4gcG9saWN5IGJlaW5nIG92ZXJyaWRkZW4gYXMgYSByZXN1bHQgb2YgYSBk
ZXZpY2UtaW5pdGlhdGVkIHJldmFsaWRhdGUuCj4gVGhlIGNvbW1pdCBoYXMgc2luY2UgYmVlbiBy
ZXZlcnRlZCBkdWUgdG8gYSByZWdyZXNzaW9uIHRoYXQgbGVmdCBzb21lCj4gVVNCIGRldmljZXMg
cmVhZC1vbmx5IGluZGVmaW5pdGVseS4KPiAKPiBUbyBmaXggdGhlIHVuZGVybHlpbmcgcHJvYmxl
bXMgd2l0aCByZXZhbGlkYXRlIHdlIG5lZWQgdG8ga2VlcCB0cmFjawo+IG9mIGhhcmR3YXJlIHN0
YXRlIGFuZCB1c2VyIHBvbGljeSBzZXBhcmF0ZWx5Lgo+IAo+IFRoZSBnZW5kaXNrIGhhcyBiZWVu
IHVwZGF0ZWQgdG8gcmVmbGVjdCB0aGUgY3VycmVudCBoYXJkd2FyZSBzdGF0ZSBzZXQKPiBieSB0
aGUgZGV2aWNlIGRyaXZlci4gVGhpcyBpcyBkb25lIHRvIGFsbG93IHJldHVybmluZyB0aGUgZGV2
aWNlIHRvCj4gdGhlIGhhcmR3YXJlIHN0YXRlIG9uY2UgdGhlIHVzZXIgY2xlYXJzIHRoZSBCTEtS
T1NFVCBmbGFnLgo+IAo+IFRoZSByZXN1bHRpbmcgc2VtYW50aWNzIGFyZSBhcyBmb2xsb3dzOgo+
IAo+ICAgLSBJZiBCTEtST1NFVCBpcyB1c2VkIHRvIHNldCBhIHdob2xlLWRpc2sgZGV2aWNlIHJl
YWQtb25seSwgYW55Cj4gICAgIHBhcnRpdGlvbnMgd2lsbCBlbmQgdXAgaW4gYSByZWFkLW9ubHkg
c3RhdGUgdW50aWwgdGhlIHVzZXIKPiAgICAgZXhwbGljaXRseSBjbGVhcnMgdGhlIGZsYWcuCj4g
Cj4gICAtIElmIEJMS1JPU0VUIHNldHMgYSBnaXZlbiBwYXJ0aXRpb24gcmVhZC1vbmx5LCB0aGF0
IHBhcnRpdGlvbiB3aWxsCj4gICAgIHJlbWFpbiByZWFkLW9ubHkgZXZlbiBpZiB0aGUgdW5kZXJs
eWluZyBzdG9yYWdlIHN0YWNrIGluaXRpYXRlcyBhCj4gICAgIHJldmFsaWRhdGUuIEhvd2V2ZXIs
IHRoZSBCTEtSUlBBUlQgaW9jdGwgd2lsbCBjYXVzZSB0aGUgcGFydGl0aW9uCj4gICAgIHRhYmxl
IHRvIGJlIGRyb3BwZWQgYW5kIGFueSB1c2VyIHBvbGljeSBvbiBwYXJ0aXRpb25zIHdpbGwgYmUg
bG9zdC4KPiAKPiAgIC0gSWYgQkxLUk9TRVQgaGFzIG5vdCBiZWVuIHNldCwgYm90aCB0aGUgd2hv
bGUgZGlzayBkZXZpY2UgYW5kIGFueQo+ICAgICBwYXJ0aXRpb25zIHdpbGwgcmVmbGVjdCB0aGUg
Y3VycmVudCB3cml0ZS1wcm90ZWN0IHN0YXRlIG9mIHRoZQo+ICAgICB1bmRlcmx5aW5nIGRldmlj
ZS4KPiAKPiBCYXNlZCBvbiBhIHBhdGNoIGZyb20gTWFydGluIEsuIFBldGVyc2VuIDxtYXJ0aW4u
cGV0ZXJzZW5Ab3JhY2xlLmNvbT4uCj4gCj4gUmVwb3J0ZWQtYnk6IE9sZWtzaWkgS3Vyb2Noa28g
PG9sa3Vyb2NoQGNpc2NvLmNvbT4KPiBCdWd6aWxsYTogaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwu
b3JnL3Nob3dfYnVnLmNnaT9pZD0yMDEyMjEKPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVs
bHdpZyA8aGNoQGxzdC5kZT4KPiAtLS0KPiAgIGJsb2NrL2Jsay1jb3JlLmMgICAgICAgIHwgIDIg
Ky0KPiAgIGJsb2NrL2dlbmhkLmMgICAgICAgICAgIHwgMzQgKysrKysrKysrKysrKysrKysrKy0t
LS0tLS0tLS0tLS0tLQo+ICAgYmxvY2svcGFydGl0aW9ucy9jb3JlLmMgfCAgMyArLS0KPiAgIGlu
Y2x1ZGUvbGludXgvZ2VuaGQuaCAgIHwgIDYgKysrKy0tCj4gICA0IGZpbGVzIGNoYW5nZWQsIDI1
IGluc2VydGlvbnMoKyksIDIwIGRlbGV0aW9ucygtKQo+IApSZXZpZXdlZC1ieTogSGFubmVzIFJl
aW5lY2tlIDxoYXJlQHN1c2UuZGU+CgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVp
bmVja2UgICAgICAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5k
ZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29m
dHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIg
MzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZm
ZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4
LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
