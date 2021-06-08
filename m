Return-Path: <SRS0=UQCu=LC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D7AC47082
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 16:21:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F7F361059
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 16:21:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F7F361059
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pmHBMZnes/7jkCl7xgW1frQJI4yCvlSGzLcBBDFoQq8=; b=YK600hOwf2EhgGudxEjvaY3myV
	9fCSaHne5+lLDFwiG0QwsZQfGcAA2yeQ60kUGnE9YvM0VrJZnTsSeGP7RSDVAgeu6sy2Fg1kd6w6w
	lRC56eZXrFEDE85xdES+/u+vi2JqtCCDx+oQvwW4FsYK/1GRMMLf7aZFzmLL5IbQp37yvYwwJH8SZ
	Y+Y1IiuUBCsIWMBITr7zj5LJijcVHg3i6en2OXVBvQWHYy1kF+W9HQq+FAuPRPFzVmH9Sm2tQf5Pf
	y6k/spMMKA9FY/gFK7/TjPbvGTxo64I4n88TL2hrCjRspOtpztSDZb29twU0przTR/M6rhErMUuDO
	3KkJV9Sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqeTp-009TfP-GD; Tue, 08 Jun 2021 16:21:29 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqeTm-009TeR-5P
 for linux-nvme@lists.infradead.org; Tue, 08 Jun 2021 16:21:27 +0000
Received: by mail-wr1-f53.google.com with SMTP id e11so12032660wrg.3
 for <linux-nvme@lists.infradead.org>; Tue, 08 Jun 2021 09:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=T00FNpH7loMoqEtu1eWkUwRL9Kx0HIFZ6Q16qohE+J4=;
 b=HRZtPkdQMgKsoj0cPRM68ogG0mMmoH7ag19wxbhzjdW5YKTZEzrIk4akAiv8oS9QDS
 iHwHC9YruyRIKFthp5KNROuavoBGpuhJv7OkiaTg8t5ZcVK4dNC5Os5hgffWYEDId5Hx
 EtUDio58Sr+cKs0CBMf79P0wIvBmREi5fhp6SkaV/zyw/3tAHcQwYCIWW9NRbZdMkO6r
 cy2QNVX6lWOZXd82Zh+xQyfKInh4LQaY2zxWXnhB9jqfmB9v2Hfo7DbgMCqz8ohURgOx
 9oTKXkpOPLnPfp52Vbtl8Vr6Ffgmbm1aR9uO96IoFGzzGa1DKxehsE+75ZnfKCsH/Pp0
 9Ksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=T00FNpH7loMoqEtu1eWkUwRL9Kx0HIFZ6Q16qohE+J4=;
 b=soaimZDVqKxvQRvyBSse4HzRBgLX+hXK21waLC66ZqVca3+kxk7Pc3287R8HBJW4Lb
 Pr5UF7aOaj5Pw91HeomjZlq80PH7KfQrWyafpSd9VzAV9K9u5TixEYvyUfVYEn5wm6Gv
 wZ0N3FwcmtvJkbl4Tk/4kSRN3Tl/HCTmKgHwR6YnXSYAirYUcp/vlT8kTjvil0Vsxw3u
 dQ83mlzf5BxB+yKWoAIL6XFjPXvM1OoYtBstKIsJCInMp0PdbuZXPQXFCJjb2uHgXlM0
 tTFfD8Tmju/26S8QZOoL2aQwNsk2BnntZeZqb8ixayW80chCNu56K2/fVM0daKj4qghZ
 6zhg==
X-Gm-Message-State: AOAM530ZLWQOxNTBATEjhEkVqDcdfR1Dgm+DNv0Pc+HcDi+URFInZ413
 EcU1FEoAumxyu9uyyncbWa4=
X-Google-Smtp-Source: ABdhPJyIdlws1mfTZDVOyk7oQVbCvi9swbRfOVqsI9H4/EQPATyt1/mTBwmS6f3gPjcBQlUffcOIfw==
X-Received: by 2002:adf:e404:: with SMTP id g4mr23226889wrm.414.1623169225059; 
 Tue, 08 Jun 2021 09:20:25 -0700 (PDT)
Received: from ?IPv6:2a02:908:1984:a6c0::f8b0? ([2a02:908:1984:a6c0::f8b0])
 by smtp.gmail.com with ESMTPSA id v7sm23989440wrf.82.2021.06.08.09.20.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jun 2021 09:20:24 -0700 (PDT)
Subject: Re: [PATCH v7 2/2] ACPI: Add quirks for AMD Renoir/Lucienne CPUs to
 force the D3 hint
To: Mario Limonciello <mario.limonciello@amd.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 linux-acpi@vger.kernel.org, rrangel@chromium.org,
 david.e.box@linux.intel.com, Shyam-sundar.S-k@amd.com,
 Nehal-bakulchandra.Shah@amd.com, Alexander.Deucher@amd.com,
 prike.liang@amd.com
References: <20210608154255.8693-1-mario.limonciello@amd.com>
 <20210608154255.8693-2-mario.limonciello@amd.com>
From: Julian Sikorski <belegdol@gmail.com>
Message-ID: <0825a2d6-be28-3a4d-54b3-c45cc18fbab9@gmail.com>
Date: Tue, 8 Jun 2021 18:20:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210608154255.8693-2-mario.limonciello@amd.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210608_092126_237943_37BC8B4A 
X-CRM114-Status: GOOD (  36.33  )
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

VyBkbml1IDA4LjA2LjIwMjEgb8KgMTc6NDIsIE1hcmlvIExpbW9uY2llbGxvIHBpc3plOgo+IEFN
RCBzeXN0ZW1zIGZyb20gUmVub2lyIGFuZCBMdWNpZW5uZSByZXF1aXJlIHRoYXQgdGhlIE5WTUUg
Y29udHJvbGxlcgo+IGlzIHB1dCBpbnRvIEQzIG92ZXIgYSBNb2Rlcm4gU3RhbmRieSAvIHN1c3Bl
bmQtdG8taWRsZQo+IGN5Y2xlLiAgVGhpcyBpcyAidHlwaWNhbGx5IiBhY2NvbXBsaXNoZWQgdXNp
bmcgdGhlIGBTdG9yYWdlRDNFbmFibGVgCj4gcHJvcGVydHkgaW4gdGhlIF9EU0QsIGJ1dCB0aGlz
IHByb3BlcnR5IHdhcyBpbnRyb2R1Y2VkIGFmdGVyIG1hbnkKPiBvZiB0aGVzZSBzeXN0ZW1zIGxh
dW5jaGVkIGFuZCBtb3N0IE9FTSBzeXN0ZW1zIGRvbid0IGhhdmUgaXQgaW4KPiB0aGVpciBCSU9T
Lgo+IAo+IE9uIEFNRCBSZW5vaXIgd2l0aG91dCB0aGVzZSBkcml2ZXMgZ29pbmcgaW50byBEMyBv
dmVyIHN1c3BlbmQtdG8taWRsZQo+IHRoZSByZXN1bWUgd2lsbCBmYWlsIHdpdGggdGhlIE5WTUUg
Y29udHJvbGxlciBiZWluZyByZXNldCBhbmQgYSB0cmFjZQo+IGxpa2UgdGhpcyBpbiB0aGUga2Vy
bmVsIGxvZ3M6Cj4gYGBgCj4gWyAgIDgzLjU1NjExOF0gbnZtZSBudm1lMDogSS9PIDE2MSBRSUQg
MiB0aW1lb3V0LCBhYm9ydGluZwo+IFsgICA4My41NTYxNzhdIG52bWUgbnZtZTA6IEkvTyAxNjIg
UUlEIDIgdGltZW91dCwgYWJvcnRpbmcKPiBbICAgODMuNTU2MTg3XSBudm1lIG52bWUwOiBJL08g
MTYzIFFJRCAyIHRpbWVvdXQsIGFib3J0aW5nCj4gWyAgIDgzLjU1NjE5Nl0gbnZtZSBudm1lMDog
SS9PIDE2NCBRSUQgMiB0aW1lb3V0LCBhYm9ydGluZwo+IFsgICA5NS4zMzIxMTRdIG52bWUgbnZt
ZTA6IEkvTyAyNSBRSUQgMCB0aW1lb3V0LCByZXNldCBjb250cm9sbGVyCj4gWyAgIDk1LjMzMjg0
M10gbnZtZSBudm1lMDogQWJvcnQgc3RhdHVzOiAweDM3MQo+IFsgICA5NS4zMzI4NTJdIG52bWUg
bnZtZTA6IEFib3J0IHN0YXR1czogMHgzNzEKPiBbICAgOTUuMzMyODU2XSBudm1lIG52bWUwOiBB
Ym9ydCBzdGF0dXM6IDB4MzcxCj4gWyAgIDk1LjMzMjg1OV0gbnZtZSBudm1lMDogQWJvcnQgc3Rh
dHVzOiAweDM3MQo+IFsgICA5NS4zMzI5MDldIFBNOiBkcG1fcnVuX2NhbGxiYWNrKCk6IHBjaV9w
bV9yZXN1bWUrMHgwLzB4ZTAgcmV0dXJucyAtMTYKPiBbICAgOTUuMzMyOTM2XSBudm1lIDAwMDA6
MDM6MDAuMDogUE06IGZhaWxlZCB0byByZXN1bWUgYXN5bmM6IGVycm9yIC0xNgo+IGBgYAo+IAo+
IFRoZSBNaWNyb3NvZnQgZG9jdW1lbnRhdGlvbiBmb3IgU3RvcmFnZUQzRW5hYmxlIG1lbnRpb25l
ZCB0aGF0IFdpbmRvd3MgaGFzCj4gYSBoYXJkY29kZWQgYWxsb3dsaXN0IGZvciBEMyBzdXBwb3J0
LCB3aGljaCB3YXMgdXNlZCBmb3IgdGhlc2UgcGxhdGZvcm1zLgo+IEludHJvZHVjZSBxdWlya3Mg
dG8gaGFyZGNvZGUgdGhlbSBmb3IgTGludXggYXMgd2VsbC4KPiAKPiBBcyB0aGlzIHByb3BlcnR5
IGlzIG5vdyAic3RhbmRhcmRpemVkIiwgT0VNIHN5c3RlbXMgdXNpbmcgQU1EIENlemFubmUgYW5k
Cj4gbmV3ZXIgQVBVJ3MgaGF2ZSBhZG9wdGVkIHRoaXMgcHJvcGVydHksIGFuZCBxdWlya3MgbGlr
ZSB0aGlzIHNob3VsZCBub3QgYmUKPiBuZWNlc3NhcnkuCj4gCj4gQ0M6IEp1bGlhbiBTaWtvcnNr
aSA8YmVsZWdkb2xAZ21haWwuY29tPgo+IENDOiBTaHlhbS1zdW5kYXIgUy1rIDxTaHlhbS1zdW5k
YXIuUy1rQGFtZC5jb20+Cj4gQ0M6IEFsZXhhbmRlciBEZXVjaGVyIDxBbGV4YW5kZXIuRGV1Y2hl
ckBhbWQuY29tPgo+IENDOiBSYWZhZWwgSi4gV3lzb2NraSA8cmp3QHJqd3lzb2NraS5uZXQ+Cj4g
Q0M6IFByaWtlIExpYW5nIDxwcmlrZS5saWFuZ0BhbWQuY29tPgo+IExpbms6IGh0dHBzOi8vZG9j
cy5taWNyb3NvZnQuY29tL2VuLXVzL3dpbmRvd3MtaGFyZHdhcmUvZGVzaWduL2NvbXBvbmVudC1n
dWlkZWxpbmVzL3Bvd2VyLW1hbmFnZW1lbnQtZm9yLXN0b3JhZ2UtaGFyZHdhcmUtZGV2aWNlcy1p
bnRybwo+IFNpZ25lZC1vZmYtYnk6IE1hcmlvIExpbW9uY2llbGxvIDxtYXJpby5saW1vbmNpZWxs
b0BhbWQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9hY3BpL2RldmljZV9wbS5jIHwgIDMgKysrCj4g
ICBkcml2ZXJzL2FjcGkvaW50ZXJuYWwuaCAgfCAgOSArKysrKysrKysKPiAgIGRyaXZlcnMvYWNw
aS94ODYvdXRpbHMuYyB8IDI1ICsrKysrKysrKysrKysrKysrKysrKysrKysKPiAgIDMgZmlsZXMg
Y2hhbmdlZCwgMzcgaW5zZXJ0aW9ucygrKQo+IAo+IENoYW5nZXMgZnJvbSB2NC0+djU6Cj4gICAq
IEFkZCB0aGlzIHBhdGNoIGJhY2sgaW4gYXMgaXQncyBiZWVuIG1hZGUgYXBwYXJlbnQgdGhhdCB0
aGUKPiAgICAgc3lzdGVtIG5lZWRzIHRvIGJlIGhhcmRjb2RlZCBmb3IgdGhlc2UuCj4gICAgIENo
YW5nZXM6Cj4gICAgIC0gRHJvcCBDZXphbm5lIC0gaXQncyBub3cgY292ZXJlZCBieSBTdG9yYWdl
RDNFbmFibGUKPiAgICAgLSBSZWJhc2Ugb250b3Agb2YgYWNwaV9zdG9yYWdlX2QzIG91dHNpZGUg
b2YgTlZNRQo+IENoYW5nZXMgZnJvbSB2NS0+djY6Cj4gICAqIE1vdmUgdGhlIHF1aXJrIGNoZWNr
IGludG8gZHJpdmVycy9hY3BpL3g4Ni8gYXMgc3VnZ2VzdGVkIGJ5Cj4gICAgIFJhZmFlbC4KPiBD
aGFuZ2VzIGZyb20gdjYtPnY3Ogo+ICAgKiBNb3ZlIGhlYWRlciBsb2NhdGlvbgo+ICAgKiBPcHRp
bWl6YXRpb24gb2YgZm9yY2UgZnVuY3Rpb24KPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3Bp
L2RldmljZV9wbS5jIGIvZHJpdmVycy9hY3BpL2RldmljZV9wbS5jCj4gaW5kZXggYzQ1ZjJkNzZi
NjdlLi4zMWUwMDI1YTkxM2UgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9hY3BpL2RldmljZV9wbS5j
Cj4gKysrIGIvZHJpdmVycy9hY3BpL2RldmljZV9wbS5jCj4gQEAgLTEzNTYsNiArMTM1Niw5IEBA
IGJvb2wgYWNwaV9zdG9yYWdlX2QzKHN0cnVjdCBkZXZpY2UgKmRldikKPiAgIAlzdHJ1Y3QgYWNw
aV9kZXZpY2UgKmFkZXYgPSBBQ1BJX0NPTVBBTklPTihkZXYpOwo+ICAgCXU4IHZhbDsKPiAgIAo+
ICsJaWYgKGZvcmNlX3N0b3JhZ2VfZDMoKSkKPiArCQlyZXR1cm4gdHJ1ZTsKPiArCj4gICAJaWYg
KCFhZGV2KQo+ICAgCQlyZXR1cm4gZmFsc2U7Cj4gICAJaWYgKGZ3bm9kZV9wcm9wZXJ0eV9yZWFk
X3U4KGFjcGlfZndub2RlX2hhbmRsZShhZGV2KSwgIlN0b3JhZ2VEM0VuYWJsZSIsCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvYWNwaS9pbnRlcm5hbC5oIGIvZHJpdmVycy9hY3BpL2ludGVybmFsLmgK
PiBpbmRleCBmOTczYmJlOTBlNWUuLmUyOWVjNDYzYmIwNyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L2FjcGkvaW50ZXJuYWwuaAo+ICsrKyBiL2RyaXZlcnMvYWNwaS9pbnRlcm5hbC5oCj4gQEAgLTIz
Niw2ICsyMzYsMTUgQEAgc3RhdGljIGlubGluZSBpbnQgc3VzcGVuZF9udnNfc2F2ZSh2b2lkKSB7
IHJldHVybiAwOyB9Cj4gICBzdGF0aWMgaW5saW5lIHZvaWQgc3VzcGVuZF9udnNfcmVzdG9yZSh2
b2lkKSB7fQo+ICAgI2VuZGlmCj4gICAKPiArI2lmZGVmIENPTkZJR19YODYKPiArYm9vbCBmb3Jj
ZV9zdG9yYWdlX2QzKHZvaWQpOwo+ICsjZWxzZQo+ICtzdGF0aWMgaW5saW5lIGJvb2wgZm9yY2Vf
c3RvcmFnZV9kMyh2b2lkKQo+ICt7Cj4gKwlyZXR1cm4gZmFsc2U7Cj4gK30KPiArI2VuZGlmCj4g
Kwo+ICAgLyotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+ICAgCQkJCURldmljZSBwcm9wZXJ0aWVzCj4gICAg
IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tICovCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS94ODYvdXRp
bHMuYyBiL2RyaXZlcnMvYWNwaS94ODYvdXRpbHMuYwo+IGluZGV4IGJkYzFiYTAwYWVlOS4uNTI5
OGJiNGQ4MWZlIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvYWNwaS94ODYvdXRpbHMuYwo+ICsrKyBi
L2RyaXZlcnMvYWNwaS94ODYvdXRpbHMuYwo+IEBAIC0xMzUsMyArMTM1LDI4IEBAIGJvb2wgYWNw
aV9kZXZpY2VfYWx3YXlzX3ByZXNlbnQoc3RydWN0IGFjcGlfZGV2aWNlICphZGV2KQo+ICAgCj4g
ICAJcmV0dXJuIHJldDsKPiAgIH0KPiArCj4gKy8qCj4gKyAqIEFNRCBzeXN0ZW1zIGZyb20gUmVu
b2lyIGFuZCBMdWNpZW5uZSAqcmVxdWlyZSogdGhhdCB0aGUgTlZNRSBjb250cm9sbGVyCj4gKyAq
IGlzIHB1dCBpbnRvIEQzIG92ZXIgYSBNb2Rlcm4gU3RhbmRieSAvIHN1c3BlbmQtdG8taWRsZSBj
eWNsZS4KPiArICoKPiArICogVGhpcyBpcyAidHlwaWNhbGx5IiBhY2NvbXBsaXNoZWQgdXNpbmcg
dGhlIGBTdG9yYWdlRDNFbmFibGVgCj4gKyAqIHByb3BlcnR5IGluIHRoZSBfRFNEIHRoYXQgaXMg
Y2hlY2tlZCB2aWEgdGhlIGBhY3BpX3N0b3JhZ2VfZDNgIGZ1bmN0aW9uCj4gKyAqIGJ1dCB0aGlz
IHByb3BlcnR5IHdhcyBpbnRyb2R1Y2VkIGFmdGVyIG1hbnkgb2YgdGhlc2Ugc3lzdGVtcyBsYXVu
Y2hlZAo+ICsgKiBhbmQgbW9zdCBPRU0gc3lzdGVtcyBkb24ndCBoYXZlIGl0IGluIHRoZWlyIEJJ
T1MuCj4gKyAqCj4gKyAqIFRoZSBNaWNyb3NvZnQgZG9jdW1lbnRhdGlvbiBmb3IgU3RvcmFnZUQz
RW5hYmxlIG1lbnRpb25lZCB0aGF0IFdpbmRvd3MgaGFzCj4gKyAqIGEgaGFyZGNvZGVkIGFsbG93
bGlzdCBmb3IgRDMgc3VwcG9ydCwgd2hpY2ggd2FzIHVzZWQgZm9yIHRoZXNlIHBsYXRmb3Jtcy4K
PiArICoKPiArICogVGhpcyBhbGxvd3MgcXVpcmtpbmcgb24gTGludXggaW4gYSBzaW1pbGFyIGZh
c2hpb24uCj4gKyAqLwo+ICtjb25zdCBzdHJ1Y3QgeDg2X2NwdV9pZCBzdG9yYWdlX2QzX2NwdV9p
ZHNbXSA9IHsKPiArCVg4Nl9NQVRDSF9WRU5ET1JfRkFNX01PREVMKEFNRCwgMjMsIDk2LCBOVUxM
KSwJLyogUmVub2lyICovCj4gKwlYODZfTUFUQ0hfVkVORE9SX0ZBTV9NT0RFTChBTUQsIDIzLCAx
MDQsIE5VTEwpLAkvKiBMdWNpZW5uZSAqLwo+ICsJe30KPiArfTsKPiArCj4gK2Jvb2wgZm9yY2Vf
c3RvcmFnZV9kMyh2b2lkKQo+ICt7Cj4gKwlyZXR1cm4geDg2X21hdGNoX2NwdShzdG9yYWdlX2Qz
X2NwdV9pZHMpOwo+ICt9Cj4gCgpUZXN0ZWQtYnk6IEp1bGlhbiBTaWtvcnNraSA8YmVsZWdkb2xA
Z21haWwuY29tPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
