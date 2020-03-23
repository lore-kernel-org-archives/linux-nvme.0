Return-Path: <SRS0=QV8n=5I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9C3C4332B
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2020 22:02:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E05820753
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2020 22:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KrHdFPFi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E05820753
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=uiWB9zun2CSTvBEw2tMxH6bfbDWcEwZiwDQyfPjfVik=; b=KrHdFPFif1U5oUXIZciTDp/rv
	Sgn312n3ixb9DhPQ2MBs0kq/glDN9f7mZTikSBp5Vo2wAINtNut+gpVzHBBQgP7/7pSeUcq2Haf+D
	QhkVO5tIZCIXqMoOHPHAu8syCGX4hLupyKSYZqNfgZA1ofI09OtSoBCCDi7xpbUIATIPgRoVj3TKy
	sYgVjTBxpZYb0M5VO4Sk7A6vuLIJqeClpUhWNwzw1cpVrT2xi70xdS+AFssh0Q2JnF0aoYgQ+sNSz
	K8SIV3O3vFlMZaDIWoOARcxVVzi0FxcvfVULa/lzivNai6/Tpx7rq+t4H7iE3x+zXzOozrEO4//qA
	o2QeUF/2w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jGV9Y-00081O-Ie; Mon, 23 Mar 2020 22:02:36 +0000
Received: from mail-wm1-f68.google.com ([209.85.128.68])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jGV9W-00080t-2j
 for linux-nvme@lists.infradead.org; Mon, 23 Mar 2020 22:02:35 +0000
Received: by mail-wm1-f68.google.com with SMTP id r7so1076955wmg.0
 for <linux-nvme@lists.infradead.org>; Mon, 23 Mar 2020 15:02:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1vMxRqZzWOZUeK8eaSvZKHiFZXl/5oJY+d2RTXZxaPI=;
 b=kkwFF3/sX/UNZZ6geLOeFS12LnQiytvwvtO0ilCIWaycStHq/Sm4HKUE3yZMljv7nx
 JV3dXIEwFWGj1RM2YEcHxs3pTZb/eIsVHoU2sUwSi2ZorNgtrqwraC4Yq0PIrF1mEYpD
 p2BhUDxsPLgj9WUREEKsk4ZsPj6N771RzLckXE8tNn6Db/i4+9rF9OY6kqVmFNNMtAfD
 ydAWXpdrxtajLM1O1ejEb47NKzxTpdNvzJxar376zxqbhIw/FadBwVia3gyAP3Vanx1r
 Lwrm8HKhbOhvuYPdyFnm3IU1XjfjX/jTnhECRqMGvYTmmaSJlLDfVuFrYuBRULpdSnxG
 mTSg==
X-Gm-Message-State: ANhLgQ2o+YwxVQ8uT2kKoVIPI4u+JnXTSonEvRjpUq1kDv8X6fEkBAcu
 I7vtM7Oa3u08oI3J3MhxDOJ7Du7S
X-Google-Smtp-Source: ADFU+vu3EPwoVWwdAR06Ztg+hXige2K5h0KH2sKpeOcZZ7g804qVAuFA8/dn1drk7g71Cph0Z3AE0w==
X-Received: by 2002:a1c:8097:: with SMTP id b145mr1633391wmd.159.1585000952370; 
 Mon, 23 Mar 2020 15:02:32 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:45a4:15de:f2dc:1149?
 ([2601:647:4802:9070:45a4:15de:f2dc:1149])
 by smtp.gmail.com with ESMTPSA id i1sm24799953wrq.89.2020.03.23.15.02.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 23 Mar 2020 15:02:31 -0700 (PDT)
Subject: Re: nvmet: Kernel oops when doing mkfs on nvme-tcp device
From: Sagi Grimberg <sagi@grimberg.me>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "tasleson@redhat.com" <tasleson@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <17c25d8d-0dc2-9dc8-2b65-954034c23646@redhat.com>
 <507887d2-96dd-b0ee-bb05-519039d98359@grimberg.me>
 <e16baf6a-c9e0-2249-6d7a-4e8d58f8e9b6@redhat.com>
 <f390f5a1-a80f-44d7-5d69-642119eef9b8@grimberg.me>
 <c8fce5f3-a01b-da38-820f-cf6caaa377ab@redhat.com>
 <d5e056ca-05b5-c91b-6ed7-668d28b1fe62@grimberg.me>
 <BYAPR04MB496517B2AF9555819C4A684086F00@BYAPR04MB4965.namprd04.prod.outlook.com>
 <1d6fd91f-8442-515f-fe20-5a7a6157ab2e@grimberg.me>
Message-ID: <ad18c611-33bd-3dd8-989a-0e4b950db20c@grimberg.me>
Date: Mon, 23 Mar 2020 15:02:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1d6fd91f-8442-515f-fe20-5a7a6157ab2e@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200323_150234_125600_7CE67DD3 
X-CRM114-Status: GOOD (  18.87  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4+IEkgY2FuIHNlZSB0aGF0IDotCj4+IG52bWVfdGNwX3F1ZXVlX3JxKCkKPj4gwqDCoCBudm1l
X3RjcF9zZXR1cF9jbWRfcGR1KCkKPj4KPj4gwqDCoMKgIHJlcS0+ZGF0YV9sZW4gPSBibGtfcnFf
cGF5bG9hZF9ieXRlcyhycSk7IDwtLQo+IAo+IFRoZSBhbmFseXNpcyBsb29rcyBjb3JyZWN0LCB0
aGUgb25seSBwcm9ibGVtIGlzIHdoeSBJIGNhbm5vdCByZXByb2R1Y2UKPiB0aGlzLiBJZiB0aGlz
IGlzIHRoZSBjYXNlLCBJIG5lZWQgdG8gdW5kZXJzdGFuZCB3aHkgdGhpcyBkb2VzIG5vdAo+IHJl
cHJvZHVjZS4KPiAKPj4gQmFzZWQgb24gdGhlIGFib3ZlIGZpeCBtYXliZSBzb21ldGhpbmcgbGlr
ZSBmb2xsb3dpbmcgZml4IHRoZSBwcm9ibGVtID8KPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bnZtZS9ob3N0L3RjcC5jIGIvZHJpdmVycy9udm1lL2hvc3QvdGNwLmMKPj4gaW5kZXggODE0ZWEy
MzE3ZjRlLi5mOWFhYzM0Yzg3YWMgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L3Rj
cC5jCj4+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L3RjcC5jCj4+IEBAIC0yMTg3LDcgKzIxODcs
NyBAQCBzdGF0aWMgYmxrX3N0YXR1c190IG52bWVfdGNwX3NldHVwX2NtZF9wZHUoc3RydWN0Cj4+
IG52bWVfbnMgKm5zLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmVxLT5kYXRhX3NlbnQgPSAwOwo+
PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmVxLT5wZHVfbGVuID0gMDsKPj4gwqDCoMKgwqDCoMKgwqDC
oMKgIHJlcS0+cGR1X3NlbnQgPSAwOwo+PiAtwqDCoMKgwqDCoMKgIHJlcS0+ZGF0YV9sZW4gPSBi
bGtfcnFfcGF5bG9hZF9ieXRlcyhycSk7Cj4+ICvCoMKgwqDCoMKgwqAgcmVxLT5kYXRhX2xlbiA9
IGJsa19ycV9ucl9waHlzX3NlZ21lbnRzKHJxKTsKPiAKPiBkYXRhX2xlbiBpcyBsZW5ndGggaW4g
Ynl0ZXMsIGJ1dCB0aGUgaW5saW5lX2RhdGEgY2FsbCBzaG91bGQKPiBwZXJoYXBzIHRha2UgaXQg
aW50byBhY2NvdW50LgoKTWFuYWdlZCB0byByZXByb2R1Y2UsIHRoZSBpc3N1ZSB3YXMgdGhhdCB0
aGUgd3JpdGVfemVyb2VzIHdlcmUgaW4Kc2l6ZSB0aGF0IGlzIGxhcmdlciB0aGFuIHRoZSBpbi1j
YXBzdWxlIGRhdGEgc2l6ZS4gT25jZSBJIGluY3JlYXNlZAp0aGF0IEkgd2FzIGFibGUgdG8gcmVw
cm9kdWNlIHRoZSBpc3N1ZSAoYXQgbW91bnQgdGltZSwgbm90IG1rZnMgdGltZSkuCgpDaGFpdGFu
eWEsIHlvdSB3ZXJlIGNvcnJlY3QsIHRoYXQgd2FzIHRoZSByb290IGNhdXNlLgpUb255LCBkb2Vz
IHRoaXMgcGF0Y2ggd29yayBmb3IgeW91PyBJdCBtYWtlcyB0aGUgaXNzdWUgZGlzYXBwZWFyCm9u
IG15IGVuZC4KCi0tCmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC90Y3AuYyBiL2RyaXZl
cnMvbnZtZS9ob3N0L3RjcC5jCmluZGV4IDExZTEwZmUxNzYwZi4uYjU0NWE5ZTk2MzI3IDEwMDY0
NAotLS0gYS9kcml2ZXJzL252bWUvaG9zdC90Y3AuYworKysgYi9kcml2ZXJzL252bWUvaG9zdC90
Y3AuYwpAQCAtMTc3LDE2ICsxNzcsMTQgQEAgc3RhdGljIGlubGluZSBib29sIG52bWVfdGNwX2Fz
eW5jX3JlcShzdHJ1Y3QgCm52bWVfdGNwX3JlcXVlc3QgKnJlcSkKICBzdGF0aWMgaW5saW5lIGJv
b2wgbnZtZV90Y3BfaGFzX2lubGluZV9kYXRhKHN0cnVjdCBudm1lX3RjcF9yZXF1ZXN0ICpyZXEp
CiAgewogICAgICAgICBzdHJ1Y3QgcmVxdWVzdCAqcnE7Ci0gICAgICAgdW5zaWduZWQgaW50IGJ5
dGVzOwoKICAgICAgICAgaWYgKHVubGlrZWx5KG52bWVfdGNwX2FzeW5jX3JlcShyZXEpKSkKICAg
ICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7IC8qIGFzeW5jIGV2ZW50cyBkb24ndCBoYXZlIGEg
cmVxdWVzdCAqLwoKICAgICAgICAgcnEgPSBibGtfbXFfcnFfZnJvbV9wZHUocmVxKTsKLSAgICAg
ICBieXRlcyA9IGJsa19ycV9wYXlsb2FkX2J5dGVzKHJxKTsKCi0gICAgICAgcmV0dXJuIHJxX2Rh
dGFfZGlyKHJxKSA9PSBXUklURSAmJiBieXRlcyAmJgotICAgICAgICAgICAgICAgYnl0ZXMgPD0g
bnZtZV90Y3BfaW5saW5lX2RhdGFfc2l6ZShyZXEtPnF1ZXVlKTsKKyAgICAgICByZXR1cm4gcnFf
ZGF0YV9kaXIocnEpID09IFdSSVRFICYmIHJlcS0+ZGF0YV9sZW4gJiYKKyAgICAgICAgICAgICAg
IHJlcS0+ZGF0YV9sZW4gPD0gbnZtZV90Y3BfaW5saW5lX2RhdGFfc2l6ZShyZXEtPnF1ZXVlKTsK
ICB9CgogIHN0YXRpYyBpbmxpbmUgc3RydWN0IHBhZ2UgKm52bWVfdGNwX3JlcV9jdXJfcGFnZShz
dHJ1Y3QgCm52bWVfdGNwX3JlcXVlc3QgKnJlcSkKQEAgLTIxODIsNyArMjE4MCw5IEBAIHN0YXRp
YyBibGtfc3RhdHVzX3QgbnZtZV90Y3BfbWFwX2RhdGEoc3RydWN0IApudm1lX3RjcF9xdWV1ZSAq
cXVldWUsCgogICAgICAgICBjLT5jb21tb24uZmxhZ3MgfD0gTlZNRV9DTURfU0dMX01FVEFCVUY7
CgotICAgICAgIGlmIChycV9kYXRhX2RpcihycSkgPT0gV1JJVEUgJiYgcmVxLT5kYXRhX2xlbiAm
JgorICAgICAgIGlmICghYmxrX3JxX25yX3BoeXNfc2VnbWVudHMocnEpKQorICAgICAgICAgICAg
ICAgbnZtZV90Y3Bfc2V0X3NnX251bGwoYyk7CisgICAgICAgZWxzZSBpZiAocnFfZGF0YV9kaXIo
cnEpID09IFdSSVRFICYmCiAgICAgICAgICAgICByZXEtPmRhdGFfbGVuIDw9IG52bWVfdGNwX2lu
bGluZV9kYXRhX3NpemUocXVldWUpKQogICAgICAgICAgICAgICAgIG52bWVfdGNwX3NldF9zZ19p
bmxpbmUocXVldWUsIGMsIHJlcS0+ZGF0YV9sZW4pOwogICAgICAgICBlbHNlCkBAIC0yMjA5LDcg
KzIyMDksOCBAQCBzdGF0aWMgYmxrX3N0YXR1c190IG52bWVfdGNwX3NldHVwX2NtZF9wZHUoc3Ry
dWN0IApudm1lX25zICpucywKICAgICAgICAgcmVxLT5kYXRhX3NlbnQgPSAwOwotICAgICAgIHJl
cS0+ZGF0YV9sZW4gPSBibGtfcnFfcGF5bG9hZF9ieXRlcyhycSk7CisgICAgICAgcmVxLT5kYXRh
X2xlbiA9IGJsa19ycV9ucl9waHlzX3NlZ21lbnRzKHJxKSA/CisgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgYmxrX3JxX3BheWxvYWRfYnl0ZXMocnEpIDogMDsKICAgICAgICAgcmVxLT5j
dXJyX2JpbyA9IHJxLT5iaW87CgogICAgICAgICBpZiAocnFfZGF0YV9kaXIocnEpID09IFdSSVRF
ICYmCi0tCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
aW51eC1udm1lIG1haWxpbmcgbGlzdApsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
