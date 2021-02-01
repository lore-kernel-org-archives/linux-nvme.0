Return-Path: <SRS0=DeHG=HD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDB1C433E6
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 02:17:02 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7577964E09
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 02:17:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7577964E09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=NjQnI+ruJhaHcC9IT+05r9FY283m928dfNkR/j+hcpk=; b=3V6NnowtQtjDJ9BxgYY3efXl+
	6+/s65JrFxslcypv/6Mfm7JxTFQDWdLhksERWqmP6kJqLN+MiZMblkLc65gcKB54TUZrVuWA7Ip1v
	1Kj+/wAVqagZ6C8HpiA6VWYKnQP0kKmK9gtZsX+fgz4pdzfAhwXdBYkTp4phvKE1dZrWA7Wi0r3Dj
	JHSxve1dtHJRByOnnTv9ivWqgWDVm3Agwx0Ewn/T1Y1AlazjYZZAkoLjGpc87s02+T8a3CbbbF8mK
	S1IcOZ3vO31ExjnAKb0dvCwD9d22DLbLd7OhKM1ueA5NnjPI+6LD1A4exJFHHgF3clNuZJ3U5Uu85
	LRoAwNNIw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6Olp-00061e-CF; Mon, 01 Feb 2021 02:16:53 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6Olj-00060E-N7
 for linux-nvme@lists.infradead.org; Mon, 01 Feb 2021 02:16:50 +0000
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.57])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4DTWjN2ZnJzW62Q;
 Mon,  1 Feb 2021 10:14:32 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Mon, 1 Feb 2021 10:16:36 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Mon, 1 Feb
 2021 10:16:35 +0800
Subject: Re: [PATCH v2] nvme-multipath: Early exit if no path is available
To: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>, "Daniel
 Wagner" <dwagner@suse.de>
References: <20210127103033.15318-1-dwagner@suse.de>
 <db9baae0-547c-7ff4-8b2c-0b95f14be67c@huawei.com>
 <20210128075837.u5u56t23fq5gu6ou@beryllium.lan>
 <69575290-200e-b4a1-4269-c71e4c2cc37b@huawei.com>
 <20210128094004.erwnszjqcxlsi2kd@beryllium.lan>
 <ebb1d098-3ded-e592-4419-e905aabe824f@huawei.com>
 <675d3cf7-1ae8-adc5-b6d0-359fe10f6b23@grimberg.me>
 <59cd053e-46cb-0235-141f-4ce919c93f48@huawei.com>
 <65392653-6b03-9195-f686-5fe4b3290bd2@suse.de>
 <81b22bbf-4dd3-6161-e63a-9699690a4e4f@huawei.com>
 <715dd943-0587-be08-2840-e0948cf0bc62@suse.de>
 <eb131d8f-f009-42e7-105d-58b84060f0dd@huawei.com>
 <ac019690-7f02-d28c-ed58-bfc8c1d48879@suse.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <6ceff3cb-c9e9-7e74-92f0-dd745987c943@huawei.com>
Date: Mon, 1 Feb 2021 10:16:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <ac019690-7f02-d28c-ed58-bfc8c1d48879@suse.de>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme718-chm.china.huawei.com (10.1.199.114) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210131_211649_410756_490EBAF1 
X-CRM114-Status: GOOD (  23.56  )
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
Cc: Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAyMDIxLzEvMjkgMTc6MjAsIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPiBPbiAxLzI5LzIx
IDk6NDYgQU0sIENoYW8gTGVuZyB3cm90ZToKPj4KPj4KPj4gT24gMjAyMS8xLzI5IDE2OjMzLCBI
YW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+PiBPbiAxLzI5LzIxIDg6NDUgQU0sIENoYW8gTGVuZyB3
cm90ZToKPj4+Pgo+Pj4+Cj4+Pj4gT24gMjAyMS8xLzI5IDE1OjA2LCBIYW5uZXMgUmVpbmVja2Ug
d3JvdGU6Cj4+Pj4+IE9uIDEvMjkvMjEgNDowNyBBTSwgQ2hhbyBMZW5nIHdyb3RlOgo+Pj4+Pj4K
Pj4+Pj4+Cj4+Pj4+PiBPbiAyMDIxLzEvMjkgOTo0MiwgU2FnaSBHcmltYmVyZyB3cm90ZToKPj4+
Pj4+Pgo+Pj4+Pj4+Pj4gWW91IGNhbid0IHNlZSBleGFjdGx5IHdoZXJlIGl0IGRpZXMgYnV0IEkg
Zm9sbG93ZWQgdGhlIGFzc2VtYmx5IHRvCj4+Pj4+Pj4+PiBudm1lX3JvdW5kX3JvYmluX3BhdGgo
KS4gTWF5YmUgaXQncyBub3QgdGhlIGluaXRpYWwgbnZtZV9uZXh0X25zKGhlYWQsCj4+Pj4+Pj4+
PiBvbGQpIHdoaWNoIHJldHVybnMgTlVMTCBidXQgbnZtZV9uZXh0X25zKCkgaXMgcmV0dXJuaW5n
IE5VTEwgZXZlbnR1YWxseQo+Pj4+Pj4+Pj4gKGxpc3RfbmV4dF9vcl9udWxsX3JjdSgpKS4KPj4+
Pj4+Pj4gU28gdGhlcmUgaXMgb3RoZXIgYnVnIGNhdXNlIG52bWVfbmV4dF9ucyBhYm9ybWFsLgo+
Pj4+Pj4+PiBJIHJldmlldyB0aGUgY29kZSBhYm91dCBoZWFkLT5saXN0IGFuZCBoZWFkLT5jdXJy
ZW50X3BhdGgsIEkgZmluZCAyIGJ1Z3MKPj4+Pj4+Pj4gbWF5IGNhdXNlIHRoZSBidWc6Cj4+Pj4+
Pj4+IEZpcnN0LCBJIGFscmVhZHkgc2VuZCB0aGUgcGF0Y2guIHNlZToKPj4+Pj4+Pj4gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtbnZtZS8yMDIxMDEyODAzMzM1MS4yMjExNi0xLWxlbmdj
aGFvQGh1YXdlaS5jb20vCj4+Pj4+Pj4+IFNlY29uZCwgaW4gbnZtZV9uc19yZW1vdmUsIGxpc3Rf
ZGVsX3JjdSBpcyBiZWZvcmUKPj4+Pj4+Pj4gbnZtZV9tcGF0aF9jbGVhcl9jdXJyZW50X3BhdGgu
IFRoaXMgbWF5IGNhdXNlICJvbGQiIGlzIGRlbGV0ZWQgZnJvbSB0aGUKPj4+Pj4+Pj4gImhlYWQi
LCBidXQgc3RpbGwgdXNlICJvbGQiLiBJJ20gbm90IHN1cmUgdGhlcmUncyBhbnkgb3RoZXIKPj4+
Pj4+Pj4gY29uc2lkZXJhdGlvbiBoZXJlLCBJIHdpbGwgY2hlY2sgaXQgYW5kIHRyeSB0byBmaXgg
aXQuCj4+Pj4+Pj4KPj4+Pj4+PiBUaGUgcmVhc29uIHdoeSB3ZSBmaXJzdCByZW1vdmUgZnJvbSBo
ZWFkLT5saXN0IGFuZCBvbmx5IHRoZW4gY2xlYXIKPj4+Pj4+PiBjdXJyZW50X3BhdGggaXMgYmVj
YXVzZSB0aGUgb3RoZXIgd2F5IGFyb3VuZCB0aGVyZSBpcyBubyB3YXkKPj4+Pj4+PiB0byBndWFy
YW50ZWUgdGhhdCB0aGF0IHRoZSBucyB3b24ndCBiZSBhc3NpZ25lZCBhcyBjdXJyZW50X3BhdGgK
Pj4+Pj4+PiBhZ2FpbiAoYmVjYXVzZSBpdCBpcyBpbiBoZWFkLT5saXN0KS4KPj4+Pj4+IG9rLCBJ
IHNlZS4KPj4+Pj4+Pgo+Pj4+Pj4+IG52bWVfbnNfcmVtb3ZlIGZlbmNlcyBjb250aW51ZSBvZiBk
ZWxldGlvbiBvZiB0aGUgbnMgYnkgc3luY2hyb25pemluZwo+Pj4+Pj4+IHRoZSBzcmN1IHN1Y2gg
dGhhdCBmb3Igc3VyZSB0aGUgY3VycmVudF9wYXRoIGNsZWFyYW5jZSBpcyB2aXNpYmxlLgo+Pj4+
Pj4gVGhlIGxpc3Qgd2lsbCBiZSBsaWtlIHRoaXM6Cj4+Pj4+PiBoZWFkLT5uZXh0ID0gbnMxOwo+
Pj4+Pj4gbnMxLT5uZXh0ID0gaGVhZDsKPj4+Pj4+IG9sZC0+bmV4dCA9IG5zMTsKPj4+Pj4KPj4+
Pj4gV2hlcmUgZG9lcyAnb2xkJyBwb2ludGluZyB0bz8KPj4+Pj4KPj4+Pj4+IFRoaXMgbWF5IGNh
dXNlIGluZmluaXRlIGxvb3AgaW4gbnZtZV9yb3VuZF9yb2Jpbl9wYXRoLgo+Pj4+Pj4gZm9yIChu
cyA9IG52bWVfbmV4dF9ucyhoZWFkLCBvbGQpOwo+Pj4+Pj4gwqDCoMKgwqDCoG5zICE9IG9sZDsK
Pj4+Pj4+IMKgwqDCoMKgwqBucyA9IG52bWVfbmV4dF9ucyhoZWFkLCBucykpCj4+Pj4+PiBUaGUg
bnMgd2lsbCBhbHdheXMgYmUgbnMxLCBhbmQgdGhlbiBpbmZpbml0ZSBsb29wLgo+Pj4+Pgo+Pj4+
PiBOby4gbnZtZV9uZXh0X25zKCkgd2lsbCByZXR1cm4gTlVMTC4KPj4+PiBJZiB0aGVyZSBpcyBq
dXN0IG9uZSBwYXRoKHRoZSAib2xkIikgYW5kIHRoZSAib2xkIiBpcyBkZWxldGVkLAo+Pj4+IG52
bWVfbmV4dF9ucygpIHdpbGwgcmV0dXJuIE5VTEwuCj4+Pj4gVGhlIGxpc3QgbGlrZSB0aGlzOgo+
Pj4+IGhlYWQtPm5leHQgPSBoZWFkOwo+Pj4+IG9sZC0+bmV4dCA9IGhlYWQ7Cj4+Pj4gSWYgdGhl
cmUgaXMgdHdvIG9yIG1vcmUgcGF0aCBhbmQgdGhlICJvbGQiIGlzIGRlbGV0ZWQsCj4+Pj4gImZv
ciIgd2lsbCBiZSBpbmZpbml0ZSBsb29wLiBiZWNhdXNlIG52bWVfbmV4dF9ucygpIHdpbGwgcmV0
dXJuCj4+Pj4gdGhlIHBhdGggd2hpY2ggaW4gdGhlIGxpc3QgZXhjZXB0IHRoZSAib2xkIiwgY2hl
Y2sgY29uZGl0aW9uIHdpbGwKPj4+PiBiZSB0cnVlIGZvciBldmVyLgo+Pj4KPj4+IEJ1dCB0aGF0
IHdpbGwgYmUgY2F1Z2h0IGJ5IHRoZSBzdGF0ZW1lbnQgYWJvdmU6Cj4+Pgo+Pj4gaWYgKGxpc3Rf
aXNfc2luZ3VsYXIoJmhlYWQtPmxpc3QpKQo+Pj4KPj4+IG5vPwo+PiBUd28gcGF0aCBqdXN0IGEg
c2FtcGxlIGV4YW1wbGUuCj4+IElmIHRoZXJlIGlzIGp1c3QgdHdvIHBhdGgsIHdpbGwgZW50ZXIg
aXQsIG1heSBjYXVzZSBubyBwYXRoIGJ1dCB0aGVyZSBpcwo+PiBhY3R1YWxseSBvbmUgcGF0aC4g
SXQgaXMgZmFsc2VseSBhc3N1bWVkIHRoYXQgdGhlICJvbGQiIG11c3QgYmUgbm90IGRlbGV0ZWQu
Cj4+IElmIHRoZXJlIGlzIG1vcmUgdGhhbiB0d28gcGF0aCwgd2lsbCBjYXVzZSBpbmZpbml0ZSBs
b29wLgo+IFNvIHlvdSBtZWFuIHdlJ2xsIG5lZWQgc29tZXRoaW5nIGxpa2UgdGhpcz8KPiAKPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvbXVsdGlwYXRoLmMgYi9kcml2ZXJzL252bWUv
aG9zdC9tdWx0aXBhdGguYwo+IGluZGV4IDcxNjk2ODE5YzIyOC4uOGZmY2NhZjljMTlhIDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L211bHRpcGF0aC5jCj4gKysrIGIvZHJpdmVycy9u
dm1lL2hvc3QvbXVsdGlwYXRoLmMKPiBAQCAtMjAyLDEwICsyMDIsMTIgQEAgc3RhdGljIHN0cnVj
dCBudm1lX25zICpfX252bWVfZmluZF9wYXRoKHN0cnVjdCBudm1lX25zX2hlYWQgKmhlYWQsIGlu
dCBub2RlKQo+ICDCoHN0YXRpYyBzdHJ1Y3QgbnZtZV9ucyAqbnZtZV9uZXh0X25zKHN0cnVjdCBu
dm1lX25zX2hlYWQgKmhlYWQsCj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1
Y3QgbnZtZV9ucyAqbnMpCj4gIMKgewo+IC3CoMKgwqDCoMKgwqAgbnMgPSBsaXN0X25leHRfb3Jf
bnVsbF9yY3UoJmhlYWQtPmxpc3QsICZucy0+c2libGluZ3MsIHN0cnVjdCBudm1lX25zLAo+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzaWJsaW5ncyk7Cj4g
LcKgwqDCoMKgwqDCoCBpZiAobnMpCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0
dXJuIG5zOwo+ICvCoMKgwqDCoMKgwqAgaWYgKG5zKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgbnMgPSBsaXN0X25leHRfb3JfbnVsbF9yY3UoJmhlYWQtPmxpc3QsICZucy0+c2li
bGluZ3MsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IG52bWVfbnMsIHNpYmxp
bmdzKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAobnMpCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBuczsKPiArwqDCoMKg
wqDCoMKgIH0KTm8sIGluIHRoZSBzY2VuYXJpbywgbnMgc2hvdWxkIG5vdCBiZSBOVUxMLgpNYXkg
YmUgd2UgY2FuIGRvIGxpa2UgdGhpczoKCmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9t
dWx0aXBhdGguYyBiL2RyaXZlcnMvbnZtZS9ob3N0L211bHRpcGF0aC5jCmluZGV4IDI4MmI3YTRl
YTlhOS4uYjg5NTAxMWEyY2JkIDEwMDY0NAotLS0gYS9kcml2ZXJzL252bWUvaG9zdC9tdWx0aXBh
dGguYworKysgYi9kcml2ZXJzL252bWUvaG9zdC9tdWx0aXBhdGguYwpAQCAtMTk5LDMwICsxOTks
MjQgQEAgc3RhdGljIHN0cnVjdCBudm1lX25zICpfX252bWVfZmluZF9wYXRoKHN0cnVjdCBudm1l
X25zX2hlYWQgKmhlYWQsIGludCBub2RlKQogICAgICAgICByZXR1cm4gZm91bmQ7CiAgfQoKLXN0
YXRpYyBzdHJ1Y3QgbnZtZV9ucyAqbnZtZV9uZXh0X25zKHN0cnVjdCBudm1lX25zX2hlYWQgKmhl
YWQsCi0gICAgICAgICAgICAgICBzdHJ1Y3QgbnZtZV9ucyAqbnMpCi17Ci0gICAgICAgbnMgPSBs
aXN0X25leHRfb3JfbnVsbF9yY3UoJmhlYWQtPmxpc3QsICZucy0+c2libGluZ3MsIHN0cnVjdCBu
dm1lX25zLAotICAgICAgICAgICAgICAgICAgICAgICBzaWJsaW5ncyk7Ci0gICAgICAgaWYgKG5z
KQotICAgICAgICAgICAgICAgcmV0dXJuIG5zOwotICAgICAgIHJldHVybiBsaXN0X2ZpcnN0X29y
X251bGxfcmN1KCZoZWFkLT5saXN0LCBzdHJ1Y3QgbnZtZV9ucywgc2libGluZ3MpOwotfQorI2Rl
ZmluZSBudm1lX25leHRfbnNfY29uZGl0aW9uKGhlYWQsIGN1cnJlbnQsIGNvbmRpdGlvbikgXAor
KHsgXAorICAgICAgIHN0cnVjdCBudm1lX25zICpfX3B0ciA9IGxpc3RfbmV4dF9vcl9udWxsX3Jj
dSgmKGhlYWQpLT5saXN0LCBcCisgICAgICAgICAgICAgICAmKGN1cnJlbnQpLT5zaWJsaW5ncywg
c3RydWN0IG52bWVfbnMsIHNpYmxpbmdzKTsgXAorICAgICAgIF9fcHRyID8gX19wdHIgOiAoY29u
ZGl0aW9uKSA/IChjb25kaXRpb24pID0gZmFsc2UsIFwKKyAgICAgICAgICAgICAgIGxpc3RfZmly
c3Rfb3JfbnVsbF9yY3UoJihoZWFkKS0+bGlzdCwgc3RydWN0IG52bWVfbnMsIFwKKyAgICAgICAg
ICAgICAgICAgICAgICAgc2libGluZ3MpIDogTlVMTDsgXAorfSkKCiAgc3RhdGljIHN0cnVjdCBu
dm1lX25zICpudm1lX3JvdW5kX3JvYmluX3BhdGgoc3RydWN0IG52bWVfbnNfaGVhZCAqaGVhZCwK
ICAgICAgICAgICAgICAgICBpbnQgbm9kZSwgc3RydWN0IG52bWVfbnMgKm9sZCkKICB7CiAgICAg
ICAgIHN0cnVjdCBudm1lX25zICpucywgKmZvdW5kID0gTlVMTDsKKyAgICAgICBib29sIGZpcnN0
X2hhbGYgPSB0cnVlOwoKLSAgICAgICBpZiAobGlzdF9pc19zaW5ndWxhcigmaGVhZC0+bGlzdCkp
IHsKLSAgICAgICAgICAgICAgIGlmIChudm1lX3BhdGhfaXNfZGlzYWJsZWQob2xkKSkKLSAgICAg
ICAgICAgICAgICAgICAgICAgcmV0dXJuIE5VTEw7Ci0gICAgICAgICAgICAgICByZXR1cm4gb2xk
OwotICAgICAgIH0KLQotICAgICAgIGZvciAobnMgPSBudm1lX25leHRfbnMoaGVhZCwgb2xkKTsK
KyAgICAgICBmb3IgKG5zID0gbnZtZV9uZXh0X25zX2NvbmRpdGlvbihoZWFkLCBvbGQsIGZpcnN0
X2hhbGYpOwogICAgICAgICAgICAgIG5zICYmIG5zICE9IG9sZDsKLSAgICAgICAgICAgIG5zID0g
bnZtZV9uZXh0X25zKGhlYWQsIG5zKSkgeworICAgICAgICAgICAgbnMgPSBudm1lX25leHRfbnNf
Y29uZGl0aW9uKGhlYWQsIG5zLCBmaXJzdF9oYWxmKSkgewogICAgICAgICAgICAgICAgIGlmIChu
dm1lX3BhdGhfaXNfZGlzYWJsZWQobnMpKQogICAgICAgICAgICAgICAgICAgICAgICAgY29udGlu
dWU7Cgo+ICDCoMKgwqDCoMKgwqDCoCByZXR1cm4gbGlzdF9maXJzdF9vcl9udWxsX3JjdSgmaGVh
ZC0+bGlzdCwgc3RydWN0IG52bWVfbnMsIHNpYmxpbmdzKTsKPiAgwqB9Cj4gCj4gQ2hlZXJzLAo+
IAo+IEhhbm5lcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
