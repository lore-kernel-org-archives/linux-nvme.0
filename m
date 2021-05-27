Return-Path: <SRS0=/NUg=KW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E726C47089
	for <linux-nvme@archiver.kernel.org>; Thu, 27 May 2021 02:20:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44234613C3
	for <linux-nvme@archiver.kernel.org>; Thu, 27 May 2021 02:20:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44234613C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rUA0Pg49HNVCAazYzBhfyGtmYxHQ1AC9JnnH5U7SGEA=; b=xECsf5+5Kx8fvd
	Vgu1o31D2VQHr00BQRN8THTBnonG0rbAsxTwkHjaQDLLF64FNcSyUqUe5ZHirQ2HCBw4L/rDYwH0n
	2Up6IjsJnu+sBQJIhPIwlFWxWfOShZ8bFaaFIDOGlXoecycryu4Qrj/Y0sr4aVqbIXa6cS6qbOhhl
	/zNvxzpGpiqKO4eLfgNvkkhVQSNdcu+LQjPeY97eQW2xj9D8c9MWGkduOE3zw/6xepjXVKCh4VX3h
	C6VnlNt9PT/F4ojkEvbLfaZQAfFkaUCHGDJrb0Eh79Mly2IHCMxqjQ2cwFpfQojGNzNVuKVUW7BeH
	mZ2WGqNymb1YHVqW5nhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lm5dI-001kVv-3z; Thu, 27 May 2021 02:20:24 +0000
Received: from mga11.intel.com ([192.55.52.93])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lm5dF-001kUd-Du
 for linux-nvme@lists.infradead.org; Thu, 27 May 2021 02:20:23 +0000
IronPort-SDR: /FB3DWNBDnSbuie1fnUbGoHsjZt+/kFrZxV8CBgp/9qj8QtBtk7AR1wYrd2jCF9Bw0B1tjlM69
 CDEVLmKKPnWA==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="199586119"
X-IronPort-AV: E=Sophos;i="5.82,333,1613462400"; d="scan'208";a="199586119"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2021 19:20:19 -0700
IronPort-SDR: X5tiL5bGbeMSUCGwUzj1NUtL3LRhKOW0imPkCZWEere0YkfhPBcvR1C371yd66lw7ZZsPESvaH
 gD+fCBxUTNmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,333,1613462400"; d="scan'208";a="480359159"
Received: from linux.intel.com ([10.54.29.200])
 by fmsmga002.fm.intel.com with ESMTP; 26 May 2021 19:20:19 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com
 [10.54.75.174])
 by linux.intel.com (Postfix) with ESMTP id 729D5580514;
 Wed, 26 May 2021 19:20:19 -0700 (PDT)
Message-ID: <e0e8825cfc564a4b4bb9858b0d02f5d710cbe101.camel@linux.intel.com>
Subject: Re: [PATCH V5] drivers/nvme: Add support for ACPI StorageD3Enable
 property
From: "David E. Box" <david.e.box@linux.intel.com>
To: Raul Rangel <rrangel@chromium.org>, michael.a.bottini@intel.com
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, 
 kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me, 
 dan.j.williams@intel.com, shyjumon.n@intel.com, linux-acpi@vger.kernel.org,
 linux-kernel <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org
Date: Wed, 26 May 2021 19:20:19 -0700
In-Reply-To: <CALRirFRy9ijyc2Du+z3589WtPD3xaOXeMHVdgUWSTDij-gq0=g@mail.gmail.com>
References: <CALRirFRy9ijyc2Du+z3589WtPD3xaOXeMHVdgUWSTDij-gq0=g@mail.gmail.com>
Organization: David E. Box
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210526_192021_500150_64215590 
X-CRM114-Status: GOOD (  36.21  )
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
Reply-To: david.e.box@linux.intel.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SGkgUmF1bCwKCk9uIFdlZCwgMjAyMS0wNS0yNiBhdCAxMTo1MyAtMDYwMCwgUmF1bCBSYW5nZWwg
d3JvdGU6Cj4gT24gVGh1LCBKdWwgMDksIDIwMjAgYXQgMTE6NDM6MzNBTSAtMDcwMCwgRGF2aWQg
RS4gQm94IHdyb3RlOgo+ID4gKyNpZmRlZiBDT05GSUdfQUNQSQo+ID4gK3N0YXRpYyBib29sIG52
bWVfYWNwaV9zdG9yYWdlX2QzKHN0cnVjdCBwY2lfZGV2ICpkZXYpCj4gPiArewo+ID4gK8KgwqDC
oMKgIGNvbnN0IHN0cnVjdCBmd25vZGVfaGFuZGxlICpmd25vZGU7Cj4gPiArwqDCoMKgwqAgc3Ry
dWN0IGFjcGlfZGV2aWNlICphZGV2Owo+ID4gK8KgwqDCoMKgIHN0cnVjdCBwY2lfZGV2ICpyb290
Owo+ID4gK8KgwqDCoMKgIGFjcGlfaGFuZGxlIGhhbmRsZTsKPiA+ICvCoMKgwqDCoCBhY3BpX3N0
YXR1cyBzdGF0dXM7Cj4gPiArwqDCoMKgwqAgdTggdmFsOwo+ID4gKwo+ID4gK8KgwqDCoMKgIC8q
Cj4gPiArwqDCoMKgwqDCoCAqIExvb2sgZm9yIF9EU0QgcHJvcGVydHkgc3BlY2lmeWluZyB0aGF0
IHRoZSBzdG9yYWdlIGRldmljZQo+ID4gb24KPiA+ICvCoMKgwqDCoMKgICogdGhlIHBvcnQgbXVz
dCB1c2UgRDMgdG8gc3VwcG9ydCBkZWVwIHBsYXRmb3JtIHBvd2VyCj4gPiBzYXZpbmdzIGR1cmlu
Zwo+ID4gK8KgwqDCoMKgwqAgKiBzdXNwZW5kLXRvLWlkbGUKPiA+ICvCoMKgwqDCoMKgICovCj4g
PiArwqDCoMKgwqAgcm9vdCA9IHBjaWVfZmluZF9yb290X3BvcnQoZGV2KTsKPiA+ICvCoMKgwqDC
oCBpZiAoIXJvb3QpCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBmYWxzZTsK
PiA+ICsKPiA+ICvCoMKgwqDCoCBhZGV2ID0gQUNQSV9DT01QQU5JT04oJnJvb3QtPmRldik7Cj4g
PiArwqDCoMKgwqAgaWYgKCFhZGV2KQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1
cm4gZmFsc2U7Cj4gPiArCj4gPiArwqDCoMKgwqAgLyoKPiA+ICvCoMKgwqDCoMKgICogVGhlIHBy
b3BlcnR5IGlzIGRlZmluZWQgaW4gdGhlIFBYU1ggZGV2aWNlIGZvciBTb3V0aAo+ID4gY29tcGxl
eCBwb3J0cwo+ID4gK8KgwqDCoMKgwqAgKiBhbmQgaW4gdGhlIFBFR1AgZGV2aWNlIGZvciBOb3J0
aCBjb21wbGV4IHBvcnRzLgo+ID4gK8KgwqDCoMKgwqAgKi8KPiA+ICvCoMKgwqDCoCBzdGF0dXMg
PSBhY3BpX2dldF9oYW5kbGUoYWRldi0+aGFuZGxlLCAiUFhTWCIsICZoYW5kbGUpOwo+IFNvIEkn
bSBjdXJpb3VzIHdoeSB3ZSBuZWVkIHRvIGRpcmVjdGx5IGxvb2sgYXQgdGhlIFBYU1ggYW5kIFBF
R1AKPiBkZXZpY2VzIGluc3RlYWQgb2YgdGhlIEFDUElfQ09NUEFOSU9OIG5vZGUgYXR0YWNoZWQg
dG8gdGhlIHBjaQo+IGRldmljZT8KPiAKPiBJJ3ZlIGxvb2tlZCBhcm91bmQgYW5kIEkgY2FuJ3Qg
ZmluZCBhbnkgZG9jdW1lbnRhdGlvbiB0aGF0IGRlZmluZXMKPiB0aGUgUFhTWCBhbmQgUEVHUCBk
ZXZpY2UgbmFtZXMuCj4gCj4gSSd2ZSBkdW1wZWQgc29tZSBBQ1BJIGZyb20gYSBzeXN0ZW0gdGhh
dCB1c2VzIHRoZSBQWFNYIG5hbWUgYW5kCj4gU3RvcmFnZUQzQ29sZCBhdHRyaWJ1dGU6Cj4gCj4g
wqDCoMKgIFNjb3BlIChcX1NCLlBDSTAuR1AxNCkKPiDCoMKgwqAgewo+IMKgwqDCoMKgwqDCoMKg
IERldmljZSAoUFhTWCkKPiDCoMKgwqDCoMKgwqDCoCB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBOYW1lIChfQURSLCAweDAwMDAwMDAwMDAwMDAwMDApwqAgLy8gX0FEUjogQWRkcmVzcwo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgTWV0aG9kIChfU1RBLCAwLCBOb3RTZXJpYWxpemVkKcKgIC8v
IF9TVEE6IFN0YXR1cwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgewo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBSZXR1cm4gKDB4MEYpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9
Cj4gCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBOYW1lIChfRFNELCBQYWNrYWdlICgweDAyKcKg
IC8vIF9EU0Q6IERldmljZS1TcGVjaWZpYyBEYXRhCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB7
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFRvVVVJRCAoIjUwMjUwMzBmLTg0MmYt
NGFiNC1hNTYxLTk5YTUxODk3NjJkMCIpLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBQYWNrYWdlICgweDAxKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB7Cj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgUGFja2FnZSAoMHgwMikKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiU3RvcmFnZUQzRW5hYmxlIiwKPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE9uZQo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfSkKPiDCoMKgwqDCoMKgwqDCoCB9Cj4g
wqDCoMKgIH0KPiAKPiBJdCBsb29rcyB0byBtZSBsaWtlIGl0J3MganVzdCB0aGUgZmlybXdhcmUg
bm9kZSBmb3IgdGhlIE5WTWUgZGV2aWNlCj4gYXR0YWNoZWQgdG8gdGhlIHJvb3QgcG9ydC4gSXMg
dGhhdCB0aGUgY29ycmVjdCBhc3N1bXB0aW9uPwo+IAo+IEknbSB3b25kZXJpbmcgaWYgd2UgY2Fu
IHNpbXBsaWZ5IHRoZSBsb29rIHVwIGxvZ2ljIHRvIGxvb2sgYXQgdGhlCj4gQUNQSV9DT01QQU5J
T04gb2YgdGhlIHBjaSBkZXZpY2U/CgpJIGJlbGlldmUgc28sIGJ1dCBJJ2QgbmVlZCB0byBjb25m
aXJtIG9uIG91ciBzeXN0ZW1zIHRoYXQgaXQgd2lsbCB3b3JrLgpJIHJlY2FsbCB0cnlpbmcgdG8g
dXNlIHRoZSBjb21wYW5pb24gZGV2aWNlIGFuZCBub3QgYmVpbmcgYWJsZSB0bwpsb2NhdGUgdGhl
IF9EU0QuIEJ1dCB0aGF0IHdhcyBvbiBhIHByZXByb2R1Y3Rpb24gcGxhdGZvcm0gYXQgdGhlIHRp
bWUuCgo+IAo+IFRoZSByZWFzb24gSSBhc2sgaXMgdGhhdCBJJ20gd29ya2luZyBvbiBlbmFibGlu
ZyBTMGkzIG9uIGFuIEFNRAo+IGRldmljZS4KPiBUaGlzIGRldmljZSBhbHNvIGRlZmluZXMgdGhl
IFN0b3JhZ2VEM0VuYWJsZSBwcm9wZXJ0eSwgYnV0IGl0IGRvbid0Cj4gdXNlCj4gdGhlIFBYU1gg
bmFtZToKPiAKPiDCoMKgwqAgU2NvcGUgKEdQUDYpIHsKPiDCoMKgwqDCoMKgwqDCoCBEZXZpY2Ug
KE5WTUUpCj4gwqDCoMKgwqDCoMKgwqAgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTmFtZSAo
X0FEUiwgWmVybynCoCAvLyBfQURSOiBBZGRyZXNzCj4gCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBOYW1lIChfRFNELCBQYWNrYWdlICgweDAyKcKgIC8vIF9EU0Q6IERldmljZS1TcGVjaWZpYyBE
YXRhCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIFRvVVVJRCAoIjUwMjUwMzBmLTg0MmYtNGFiNC1hNTYxLTk5YTUxODk3NjJkMCIpLAo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBQYWNrYWdlICgweDAxKQo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgUGFja2FnZSAoMHgwMikKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAiU3RvcmFnZUQzRW5hYmxlIiwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIE9uZQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IH0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfSkKPiDCoMKgwqDCoMKgwqDCoCB9Cj4gwqDCoMKgIH0KPiAKPiBUaGUgV2luZG93cwo+
IFtkb2N1bWVudGF0aW9uXSggCj4gaHR0cHM6Ly9kb2NzLm1pY3Jvc29mdC5jb20vZW4tdXMvd2lu
ZG93cy1oYXJkd2FyZS9kZXNpZ24vY29tcG9uZW50LWd1aWRlbGluZXMvcG93ZXItbWFuYWdlbWVu
dC1mb3Itc3RvcmFnZS1oYXJkd2FyZS1kZXZpY2VzLWludHJvI2QzLXN1cHBvcnQKPiApCj4gbWFr
ZXMgaXQgc291bmQgbGlrZSB0aGUgX0RTRCBzaG91bGQgYmUgZGVmaW5lZCBvbiB0aGUgUENJIGRl
dmljZS4KPiAKPiBJIGNhbiBzZW5kIG9uZSBvZiB0aGUgZm9sbG93aW5nIHBhdGNoZXMgZGVwZW5k
aW5nIG9uIHRoZSBmZWVkYmFjazoKPiAxKSBBZGRpdGlvbmFsbHkgY2hlY2sgdGhlIHBjaSBkZXZp
Y2UncyBBQ1BJX0NPTVBBTklPTiBmb3IgdGhlIF9EU0QuCj4gMikgRGVsZXRlIHRoZSBQWFNYIGFu
ZCBQRUdQIGxvb2t1cHMgYW5kIG9ubHkgbG9vayBhdCB0aGUgcGNpIGRldmljZSdzCj4gwqDCoCBB
Q1BJX0NPTVBBTklPTi4KPiAKPiA+ICvCoMKgwqDCoCBpZiAoQUNQSV9GQUlMVVJFKHN0YXR1cykp
IHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RhdHVzID0gYWNwaV9nZXRfaGFuZGxl
KGFkZXYtPmhhbmRsZSwgIlBFR1AiLAo+ID4gJmhhbmRsZSk7Cj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGlmIChBQ1BJX0ZBSUxVUkUoc3RhdHVzKSkKPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBmYWxzZTsKPiA+ICvCoMKgwqDCoCB9Cj4g
PiArCj4gPiArwqDCoMKgwqAgaWYgKGFjcGlfYnVzX2dldF9kZXZpY2UoaGFuZGxlLCAmYWRldikp
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBmYWxzZTsKPiA+ICsKPiA+ICvC
oMKgwqDCoCBmd25vZGUgPSBhY3BpX2Z3bm9kZV9oYW5kbGUoYWRldik7Cj4gPiArCj4gPiArwqDC
oMKgwqAgcmV0dXJuIGZ3bm9kZV9wcm9wZXJ0eV9yZWFkX3U4KGZ3bm9kZSwgIlN0b3JhZ2VEM0Vu
YWJsZSIsCj4gPiAmdmFsKSA/Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZhbHNlIDog
dmFsID09IDE7Cj4gPiArfQoKR28gZm9yIDIgZmlyc3QuIEkgd2lsbCBjaGVjayBvbiB0aG9zZSBz
eXN0ZW1zIGFnYWluIHdpdGggb3VyIGxhdGVzdApCSU9TIHRvIGVuc3VyZSBpdCB3b3Jrcy4KCkRh
dmlkCgo+IAo+IFRoYW5rcywKPiBSYXVsCgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LW52bWUK
