Return-Path: <SRS0=jrCY=IV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA73C433C1
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Mar 2021 07:05:19 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6DA16198C
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Mar 2021 07:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6DA16198C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qM1ovTvwsIbHhCRo+GnREzMRi3ARBW76mLaDBPKt51k=; b=X5biLPGwxQcBUwyIXbhLh2QgP
	Sxa+1HxRcuSk/UFyAVPbYMQz7/Fr2fsawqoT/3DrCthiXL5fHnxpnnAbm7vffYkS60Mgqyagrzj+E
	rfjok3Ds2PW5DpVyPqK3RQYDfRcjhaCISbA49YtgAylu5YLYXn+ZRJuoMYiTnvoAAno1z7SWG926q
	pTxnj5CHj+XqiHech7lgEmUGdjS4VcDnRvHw3ZSrE5aJPMAY1Qpb0YDAP4uzoGs2nPbdBkD+JArVW
	3hzWLCQ3LLyJ/D4qD8gryJdK5Xi1cgb7W7gILu5atrtCJT1kLqILJL8mvqNYjQ6N5JH0jwE1d4FXb
	AI6VoDiNQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lOb6C-00E3QH-Uf; Tue, 23 Mar 2021 07:05:09 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lOb5e-00E33N-V0
 for linux-nvme@lists.infradead.org; Tue, 23 Mar 2021 07:04:38 +0000
Received: from dggeml405-hub.china.huawei.com (unknown [172.30.72.54])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4F4Mkh1kXgzYNHw;
 Tue, 23 Mar 2021 15:02:36 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 dggeml405-hub.china.huawei.com (10.3.17.49) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Tue, 23 Mar 2021 15:04:24 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Tue, 23
 Mar 2021 15:04:24 +0800
Subject: Re: [PATCH 2/2] nvme-multipath: don't block on blk_queue_enter of the
 underlying device
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>, "Keith
 Busch" <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
References: <20210322073726.788347-1-hch@lst.de>
 <20210322073726.788347-3-hch@lst.de>
 <34e574dc-5e80-4afe-b858-71e6ff5014d6@grimberg.me>
 <33ec8b12-0b2b-e934-acb1-aae8d0259e2e@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <31e7f7f4-55fa-6b0c-426d-7f7e7638ab4b@huawei.com>
Date: Tue, 23 Mar 2021 15:04:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <33ec8b12-0b2b-e934-acb1-aae8d0259e2e@grimberg.me>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme719-chm.china.huawei.com (10.1.199.115) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210323_070436_502958_762BD5A8 
X-CRM114-Status: GOOD (  22.65  )
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

CgpPbiAyMDIxLzMvMjMgMTE6MjMsIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4gCj4gCj4gT24gMy8y
Mi8yMSA3OjU3IFBNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+Pgo+Pj4gV2hlbiB3ZSByZXNldC90
ZWFyZG93biBhIGNvbnRyb2xsZXIsIHdlIG11c3QgZnJlZXplIGFuZCBxdWllc2NlIHRoZQo+Pj4g
bmFtZXNwYWNlcyByZXF1ZXN0IHF1ZXVlcyB0byBtYWtlIHN1cmUgdGhhdCB3ZSBzYWZlbHkgc3Rv
cCBpbmZsaWdodCBJL08KPj4+IHN1Ym1pc3Npb25zLiBGcmVlemUgaXMgbWFuZGF0b3J5IGJlY2F1
c2UgaWYgb3VyIGhjdHggbWFwIGNoYW5nZWQgYmV0d2Vlbgo+Pj4gcmVjb25uZWN0cywgYmxrX21x
X3VwZGF0ZV9ucl9od19xdWV1ZXMgd2lsbCBpbW1lZGlhdGVseSBhdHRlbXB0IHRvIGZyZWV6ZQo+
Pj4gdGhlIHF1ZXVlLCBhbmQgaWYgaXQgc3RpbGwgaGFzIHBlbmRpbmcgc3VibWlzc2lvbnMgKHRo
YXQgYXJlIHN0aWxsCj4+PiBxdWllc2NlZCkgaXQgd2lsbCBoYW5nLgo+Pj4KPj4+IEhvd2V2ZXIs
IGJ5IGZyZWV6aW5nIHRoZSBuYW1lc3BhY2VzIHJlcXVlc3QgcXVldWVzLCBhbmQgb25seSB1bmZy
ZWV6aW5nCj4+PiB0aGVtIHdoZW4gd2Ugc3VjY2Vzc2Z1bGx5IHJlY29ubmVjdCwgaW5mbGlnaHQg
c3VibWlzc2lvbnMgdGhhdCBhcmUKPj4+IHJ1bm5pbmcgY29uY3VycmVudGx5IGNhbiBub3cgYmxv
Y2sgZ3JhYmJpbmcgdGhlIG5zaGVhZCBzcmN1IHVudGlsIGVpdGhlcgo+Pj4gd2Ugc3VjY2Vzc2Z1
bGx5IHJlY29ubmVjdCBvciBjdHJsX2xvc3NfdG1vIGV4cGlyZWQgKG9yIHRoZSB1c2VyCj4+PiBl
eHBsaWNpdGx5IGRpc2Nvbm5lY3RlZCkuCj4+Pgo+Pj4gVGhpcyBjYXVzZWQgYSBkZWFkbG9jayB3
aGVuIGEgZGlmZmVyZW50IGNvbnRyb2xsZXIgKGRpZmZlcmVudCBwYXRoIG9uIHRoZQo+Pj4gc2Ft
ZSBzdWJzeXN0ZW0pIGJlY2FtZSBsaXZlIChpLmUuIG9wdGltaXplZC9ub24tb3B0aW1pemVkKS4g
VGhpcyBpcwo+Pj4gYmVjYXVzZSBudm1lX21wYXRoX3NldF9saXZlIG5lZWRzIHRvIHN5bmNocm9u
aXplIHRoZSBuc2hlYWQgc3JjdSBiZWZvcmUKPj4+IHJlcXVldWVpbmcgSS9PIGluIG9yZGVyIHRv
IG1ha2Ugc3VyZSB0aGF0IGN1cnJlbnRfcGF0aCBpcyB2aXNpYmxlIHRvCj4+PiBmdXR1cmUgKHJl
LSlzdWJtaXNpb25zLiBIb3dldmVyIHRoZSBzcmN1IGxvY2sgaXMgdGFrZW4gYnkgYSBibG9ja2Vk
Cj4+PiBzdWJtaXNzaW9uIG9uIGEgZnJvemVuIHJlcXVlc3QgcXVldWUsIGFuZCB3ZSBoYXZlIGEg
ZGVhZGxvY2suCj4+Pgo+Pj4gSW4gb3JkZXIgdG8gZml4IHRoaXMgdXNlIHRoZSBibGtfbXFfc3Vi
bWl0X2Jpb19kaXJlY3QgQVBJIHRvIHN1Ym1pdCB0aGUKPj4+IGJpbyB0byB0aGUgbG93LWxldmVs
IGRyaXZlciwgd2hpY2ggZG9lcyBub3QgYmxvY2sgb24gdGhlIHF1ZXVlIGZyZWUKPj4+IGJ1dCBp
bnN0ZWFkIGFsbG93cyBudm1lLW11bHRpcGF0aCB0byBwaWNrIGFub3RoZXIgcGF0aCBvciBxdWV1
ZSB1cCB0aGUKPj4+IGJpby4KPj4KPj4gQWxtb3N0Li4uCj4+Cj4+IFRoaXMgc3RpbGwgaGFzIHRo
ZSBzYW1lIGlzc3VlIGJ1dCBpbnN0ZWFkIG9mIGJsb2NraW5nIG9uCj4+IGJsa19xdWV1ZV9lbnRl
cigpIGl0IGlzIGJsb2NrZWQgb24gYmxrX21xX2dldF90YWcoKToKPj4gLS0gCj4+IMKgwqBfX3Nj
aGVkdWxlKzB4MjJiLzB4NmUwCj4+IMKgwqBzY2hlZHVsZSsweDQ2LzB4YjAKPj4gwqDCoGlvX3Nj
aGVkdWxlKzB4NDIvMHg3MAo+PiDCoMKgYmxrX21xX2dldF90YWcrMHgxMWQvMHgyNzAKPj4gwqDC
oD8gYmxrX2Jpb19zZWdtZW50X3NwbGl0KzB4MjM1LzB4MmEwCj4+IMKgwqA/IGZpbmlzaF93YWl0
KzB4ODAvMHg4MAo+PiDCoMKgX19ibGtfbXFfYWxsb2NfcmVxdWVzdCsweDY1LzB4ZTAKPj4gwqDC
oGJsa19tcV9zdWJtaXRfYmlvKzB4MTQ0LzB4NTAwCj4+IMKgwqBibGtfbXFfc3VibWl0X2Jpb19k
aXJlY3QrMHg3OC8weGEwCj4+IMKgwqBudm1lX25zX2hlYWRfc3VibWl0X2JpbysweGMzLzB4MmYw
IFtudm1lX2NvcmVdCj4+IMKgwqBfX3N1Ym1pdF9iaW9fbm9hY2N0KzB4Y2YvMHgyZTAKPj4gwqDC
oF9fYmxrZGV2X2RpcmVjdF9JTysweDQxMy8weDQ0MAo+PiDCoMKgPyBfX2lvX2NvbXBsZXRlX3J3
LmNvbnN0cHJvcC4wKzB4MTUwLzB4MTUwCj4+IMKgwqBnZW5lcmljX2ZpbGVfcmVhZF9pdGVyKzB4
OTIvMHgxNjAKPj4gwqDCoGlvX2l0ZXJfZG9fcmVhZCsweDFhLzB4NDAKPj4gwqDCoGlvX3JlYWQr
MHhjNS8weDM1MAo+PiDCoMKgPyBjb21tb25faW50ZXJydXB0KzB4MTQvMHhhMAo+PiDCoMKgPyB1
cGRhdGVfbG9hZF9hdmcrMHg3YS8weDVlMAo+PiDCoMKgaW9faXNzdWVfc3FlKzB4YTI4LzB4MTAy
MAo+PiDCoMKgPyBsb2NrX3RpbWVyX2Jhc2UrMHg2MS8weDgwCj4+IMKgwqBpb193cV9zdWJtaXRf
d29yaysweGFhLzB4MTIwCj4+IMKgwqBpb193b3JrZXJfaGFuZGxlX3dvcmsrMHgxMjEvMHgzMzAK
Pj4gwqDCoGlvX3dxZV93b3JrZXIrMHhiNi8weDE5MAo+PiDCoMKgPyBpb193b3JrZXJfaGFuZGxl
X3dvcmsrMHgzMzAvMHgzMzAKPj4gwqDCoHJldF9mcm9tX2ZvcmsrMHgyMi8weDMwCj4+IC0tIAo+
Pgo+PiAtLSAKPj4gwqDCoD8gdXNsZWVwX3JhbmdlKzB4ODAvMHg4MAo+PiDCoMKgX19zY2hlZHVs
ZSsweDIyYi8weDZlMAo+PiDCoMKgPyB1c2xlZXBfcmFuZ2UrMHg4MC8weDgwCj4+IMKgwqBzY2hl
ZHVsZSsweDQ2LzB4YjAKPj4gwqDCoHNjaGVkdWxlX3RpbWVvdXQrMHhmZi8weDE0MAo+PiDCoMKg
PyBkZWxfdGltZXJfc3luYysweDY3LzB4YjAKPj4gwqDCoD8gX19wcmVwYXJlX3RvX3N3YWl0KzB4
NGIvMHg3MAo+PiDCoMKgX193YWl0X2Zvcl9jb21tb24rMHhiMy8weDE2MAo+PiDCoMKgX19zeW5j
aHJvbml6ZV9zcmN1LnBhcnQuMCsweDc1LzB4ZTAKPj4gwqDCoD8gX19icGZfdHJhY2VfcmN1X3V0
aWxpemF0aW9uKzB4MTAvMHgxMAo+PiDCoMKgbnZtZV9tcGF0aF9zZXRfbGl2ZSsweDYxLzB4MTMw
IFtudm1lX2NvcmVdCj4+IMKgwqBudm1lX3VwZGF0ZV9hbmFfc3RhdGUrMHhkNy8weDEwMCBbbnZt
ZV9jb3JlXQo+PiDCoMKgbnZtZV9wYXJzZV9hbmFfbG9nKzB4YTUvMHgxNjAgW252bWVfY29yZV0K
Pj4gwqDCoD8gbnZtZV9tcGF0aF9zZXRfbGl2ZSsweDEzMC8weDEzMCBbbnZtZV9jb3JlXQo+PiDC
oMKgbnZtZV9yZWFkX2FuYV9sb2crMHg3Yi8weGUwIFtudm1lX2NvcmVdCj4+IMKgwqBwcm9jZXNz
X29uZV93b3JrKzB4MWU2LzB4MzgwCj4+IMKgwqB3b3JrZXJfdGhyZWFkKzB4NDkvMHgzMDAKPj4g
LS0gCj4+Cj4+Cj4+Cj4+IElmIEkgd2VyZSB0byBhbHdheXMgc3RhcnQgdGhlIHF1ZXVlcyBpbiBu
dm1lX3RjcF90ZWFyZG93bl9jdHJsCj4+IHJpZ2h0IGFmdGVyIEkgY2FuY2VsIHRoZSB0YWdzZXQg
aW5mbGlnaHRzIGxpa2U6Cj4+IC0tIAo+PiBAQCAtMTkzNCw4ICsxOTM0LDcgQEAgc3RhdGljIHZv
aWQgbnZtZV90Y3BfdGVhcmRvd25faW9fcXVldWVzKHN0cnVjdCBudm1lX2N0cmwgKmN0cmwsCj4+
IMKgwqDCoMKgwqDCoMKgwqAgbnZtZV9zeW5jX2lvX3F1ZXVlcyhjdHJsKTsKPj4gwqDCoMKgwqDC
oMKgwqDCoCBudm1lX3RjcF9zdG9wX2lvX3F1ZXVlcyhjdHJsKTsKPj4gwqDCoMKgwqDCoMKgwqDC
oCBudm1lX2NhbmNlbF90YWdzZXQoY3RybCk7Cj4+IC3CoMKgwqDCoMKgwqAgaWYgKHJlbW92ZSkK
Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbnZtZV9zdGFydF9xdWV1ZXMoY3RybCk7
Cj4+ICvCoMKgwqDCoMKgwqAgbnZtZV9zdGFydF9xdWV1ZXMoY3RybCk7Cj4+IMKgwqDCoMKgwqDC
oMKgwqAgbnZtZV90Y3BfZGVzdHJveV9pb19xdWV1ZXMoY3RybCwgcmVtb3ZlKTsKPj4gLS0gCj4+
Cj4+IHRoZW4gYSBzaW1wbGUgcmVzZXQgZHVyaW5nIHRyYWZmaWMgYnJpY2tzIHRoZSBob3N0IG9u
IGluZmluaXRlIGxvb3AKPj4gYmVjYXVzZSBpbiB0aGUgc2V0dXAgc2VxdWVuY2Ugd2UgZnJlZXpl
IHRoZSBxdWV1ZSBpbgo+PiBudm1lX3VwZGF0ZV9uc19pbmZvLCBzbyB0aGUgcXVldWUgaXMgZnJv
emVuIGJ1dCB3ZSBzdGlsbCBoYXZlIGFuCj4+IGF2YWlsYWJsZSBwYXRoIChiZWNhdXNlIHRoZSBj
b250cm9sbGVyIGlzIGJhY2sgdG8gbGl2ZSEpIHNvIG52bWUtbXBhdGgKPj4ga2VlcHMgY2FsbGlu
ZyBibGtfbXFfc3VibWl0X2Jpb19kaXJlY3QgYW5kIGZhaWxzLCBhbmQKPj4gbnZtZV91cGRhdGVf
bnNfaW5mbyBjYW5ub3QgcHJvcGVybHkgZnJlZXplIHRoZSBxdWV1ZS4uCj4+IC0+IGRlYWRsb2Nr
Lgo+Pgo+PiBTbyB0aGlzIGlzIG9idmlvdXNseSBpbmNvcnJlY3QuCj4+Cj4+IEFsc28sIGlmIHdl
IG1ha2UgbnZtZS1tcGF0aCBzdWJtaXQgYSBSRVFfTk9XQUlUIHdlIGJhc2ljYWxseQo+PiB3aWxs
IGZhaWwgYXMgc29vbiBhcyB3ZSBydW4gb3V0IG9mIHRhZ3MsIGV2ZW4gaW4gdGhlIG5vcm1hbCBw
YXRoLi4uCj4+Cj4+IFNvIEknbSBub3QgZXhhY3RseSBzdXJlIHdoYXQgd2Ugc2hvdWxkIGRvIHRv
IGZpeCB0aGlzLi4uCj4gCj4gSXQncyBzdGlsbCBub3QgdG9vIGxhdGUgdG8gZ28gd2l0aCBteSBv
cmlnaW5hbCBhcHByb2FjaC4uLiA7KQpJIGNoZWNrIGl0IGFnYWluLiBJIHN0aWxsIHRoaW5rIHRo
ZSBiZWxvdyBwYXRjaCBjYW4gYXZvaWQgdGhlIGJ1Zy4KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9w
dWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L2NvbW1pdC8/aWQ9NWE2
YzM1ZjlhZjQxNjExNDU4ODI5OGFhN2E5MGIxNWJiZWQxNWE0MQpUaGUgcHJvY2VzczoKMS5udm1l
X25zX2hlYWRfc3VibWl0X2JpbyBjYWxsIHNyY3VfcmVhZF9sb2NrKCZoZWFkLT5zcmN1KS4KMi5u
dm1lX25zX2hlYWRfc3VibWl0X2JpbyB3aWxsIGFkZCB0aGUgYmlvIHRvIGN1cnJlbnQtPmJpb19s
aXN0IGluc3RlYWQgb2Ygd2FpdGluZyBmb3IgdGhlIGZyb3plbiBxdWV1ZS4KMy5udm1lX25zX2hl
YWRfc3VibWl0X2JpbyBjYWxsIHNyY3VfcmVhZF91bmxvY2soJmhlYWQtPnNyY3UsIHNyY3VfaWR4
KS4KU28gbnZtZV9uc19oZWFkX3N1Ym1pdF9iaW8gZG8gbm90IGhvbGQgaGVhZC0+c3JjdSBsb25n
IHdoZW4gdGhlIHF1ZXVlIGlzIGZyb3plbiwgY2FuIGF2b2lkIGRlYWRsb2NrLgoKU2FnaSwgc3Vn
Z2VzdCB0cnlpbmcgdGhpcyBwYXRjaC4KCj4gLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtbnZtZQo=
