Return-Path: <SRS0=tyWw=HF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E74C433DB
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 22:19:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4346964E0F
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 22:19:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4346964E0F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lgFg0DR+EOeSEWqWyH9qdI65EBWLa4LlYQ4p4nOpGWo=; b=v7bc4NM4+WBdEaOyydpawMGrj
	t7xnfEZQpcnaFMj2SSTbfTD2ucG+vHUoTLDKJHRPcpHwCCfGjCxnFfwt6I3N9fo6egs0Qs0iyTP4T
	gPabnYjYq9Wd2sfdmg8Gk7O2d1XKe0nsex3AqxB+qcFrrBonGlg5iaB/t7ptdZ68OEV+CzVc9jAUr
	C9cfEmS3LTLYvX0NrTKizX1dKRfzbzlNvcT0iOt9w5sScdnlNTCs4WDT28q6ZDRPF/o7/u6wi7QRn
	oyo1lEiNPQKyLHoLcX8gVfcIciCwSuqv6UyAlMPtcnGv0yco99XGY+U0rxBYw6DAL/VsIKCFRbYur
	7NNAJMxWg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7QV4-0002xQ-Px; Wed, 03 Feb 2021 22:19:50 +0000
Received: from mail-pl1-f174.google.com ([209.85.214.174])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7QV1-0002x4-V5
 for linux-nvme@lists.infradead.org; Wed, 03 Feb 2021 22:19:48 +0000
Received: by mail-pl1-f174.google.com with SMTP id x9so644533plb.5
 for <linux-nvme@lists.infradead.org>; Wed, 03 Feb 2021 14:19:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OAuWW75jZ3qiUYLn74vm1WDi4hyIDrf9X4Y9DsESe6k=;
 b=KkVDJtVgIxT51459O1e9h9/YAHOd7EjifkE/MTGxKK0owmY5ADaNxKt1UifE/BQzGR
 ouckl2v6S+EKo3EP81ZvX98deV2upejsEP4qezbMrzrwFeC0oSD2AwvkHf+Al2W2T5JX
 a5GxFeOGjgpsTw8to3v472Rvq+xf/Sacy8sw6yntUqZcMcRslhKslquOBGXs9L/8V29q
 Rz1NclgJRqORjxljGNTrHaphGBrr+cv9nygvWsClw2SEumPybdEbZu+7fXHNnNW714kS
 05dceSUY2VtBVdmuGqz6vN6YP8SBvuphZZjocLNvLJ/UkE/Hh7DUECPYihaCrtkYqzmp
 fxxw==
X-Gm-Message-State: AOAM533Ov9orclJ8vm+lTCIT1KDLldyUoJOZK4ck9A2QVt73+6InCZcG
 NGVlKzXR/L39fuSq1oOR8/htamjyjoY=
X-Google-Smtp-Source: ABdhPJzYHgqx7UdoJrNpNFPxDBiySg9Ph/okE/L4bHlnv69h8PCS5V2ziz8f1bZm5FUNsnx4Zh1sqQ==
X-Received: by 2002:a17:902:c284:b029:e1:8863:b3d6 with SMTP id
 i4-20020a170902c284b02900e18863b3d6mr4978229pld.64.1612390786645; 
 Wed, 03 Feb 2021 14:19:46 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:cd99:e813:1dae:a15a?
 ([2601:647:4802:9070:cd99:e813:1dae:a15a])
 by smtp.gmail.com with ESMTPSA id m81sm878930pfd.188.2021.02.03.14.19.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Feb 2021 14:19:45 -0800 (PST)
Subject: Re: [PATCH v2] nvme: avoid "(efault)" from nvme_sysfs_show_subsysnqn()
To: Keith Busch <kbusch@kernel.org>, Martin Wilck <mwilck@suse.com>
References: <20210202005951.26614-1-mwilck@suse.com>
 <20210202075828.GA12160@lst.de>
 <a7f3114e22a07e60abfd98155df91dea3a83b386.camel@suse.com>
 <20210203165203.GA2182779@dhcp-10-100-145-180.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8b1fc5ef-4c6b-4fa3-7cb1-b42ed71e7413@grimberg.me>
Date: Wed, 3 Feb 2021 14:19:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210203165203.GA2182779@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210203_171948_038007_24AB7FDF 
X-CRM114-Status: GOOD (  26.07  )
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
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAyLzMvMjEgODo1MiBBTSwgS2VpdGggQnVzY2ggd3JvdGU6Cj4gT24gV2VkLCBGZWIgMDMs
IDIwMjEgYXQgMDE6MzE6MTNQTSArMDEwMCwgTWFydGluIFdpbGNrIHdyb3RlOgo+PiBPbiBUdWUs
IDIwMjEtMDItMDIgYXQgMDg6NTggKzAxMDAsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+Pj4g
T24gVHVlLCBGZWIgMDIsIDIwMjEgYXQgMDE6NTk6NTFBTSArMDEwMCwgbXdpbGNrQHN1c2UuY29t
wqB3cm90ZToKPj4+PiBGcm9tOiBNYXJ0aW4gV2lsY2sgPG13aWxja0BzdXNlLmNvbT4KPj4+Pgo+
Pj4+IFdoaWxlIGEgY29udHJvbGxlciBpcyBzdGlsbCBjb25uZWN0aW5nLCBjdHJsLT5zdWJzeXMg
aXMgTlVMTCBhbmQKPj4+PiB0aHVzIHJlYWRpbmcgdGhlIGNvbnRyb2xsZXIncyAic3Vic3lzbnFu
IiBzeXNmcyBhdHRyaWJ1dGUgcmV0dXJucwo+Pj4+ICIoZWZhdWx0KSIuIFRoaXMgaGFwcGVucyBh
bGwgdGhlIHRpbWUgd2hlbiB1c2VyIHNwYWNlIHByb2Nlc3Nlcwo+Pj4+ICJhZGQiIGV2ZW50cyBm
b3IgTlZNZSBjb250cm9sbGVyIGRldmljZXMuCj4+Pj4KPj4+PiBGaXggaXQgYnkgcmV0dXJuaW5n
IHRoZSBudm1mX2N0cmxfb3B0aW9ucycgc3Vic3lzbnFuIGF0dHJpYnV0ZQo+Pj4+IGlmIGN0cmwt
PnN1YnN5cyBpc24ndCBpbml0aWFsaXplZCB5ZXQuCj4+Pgo+Pj4gVGhpcyBpcyBqdXN0IHBhcGVy
aW5nIG92ZXIgc3ltcHRvbXMuwqAgV2Ugc2hvdWxkIG5vdCBiZSBzZW5kaW5nCj4+PiBldmVudHMg
b3IgZGlzcGxheSBzeXNmcyBmaWxlcyB1bnRpbCB0aGUgY29udHJvbGxlIGlzIGxpdmUuCj4+Cj4+
IEkgZG9uJ3QgZm9sbG93LsKgV2hhdCdzIHdyb25nIHdpdGggYSAiY29ubmVjdGluZyIgY29udHJv
bGxlciBkZXZpY2UgaW4KPj4gc3lzZnM/Cj4+Cj4+IENvbnRyb2xsZXJzIGNhbiBsb29zZSBjb25u
ZWN0aXZpdHkgYW55IHRpbWUuIFdoYXQncyB0aGUgZGlmZmVyZW5jZQo+PiBiZXR3ZWVuIGEgY29u
dHJvbGxlciB0aGF0IGlzIHJlY29ubmVjdGluZyBhZnRlciBhIGNvbm5lY3Rpb24gbG9zcyBhbmQg
YQo+PiBmcmVzaGx5IGNyZWF0ZWQgY29udHJvbGxlciB0aGF0J3MganVzdCBub3QgbGl2ZSB5ZXQ/
wqBZb3Ugd291bGRuJ3QKPj4gZGVsZXRlIHRoZSBmb3JtZXIgZnJvbSBzeXNmcywgSSBzdXBwb3Nl
Lgo+Pgo+PiAgRnJvbSB0aGUgdXNlciBzcGFjZSBwb2ludCBvZiB2aWV3LCBpdCdzIHRoZSBzYW1l
LCBhIGNvbnRyb2xsZXIgZGV2aWNlCj4+IHRoYXQgaXMgbm90IGluIHVzYWJsZSBzdGF0ZS4gSSBk
b24ndCBzZWUgYSBnZW5lcmFsIHByb2JsZW0gd2l0aCB0aGF0Lgo+PiBTZWVpbmcgYSBjb250cm9s
bGVyIGFwcGVhciBpbiBjb25uZWN0aW5nIHN0YXRlIG1pZ2h0IGFjdHVhbGx5IGJlIHVzZWZ1bAo+
PiBmb3IgdXNlciBzcGFjZS4KPj4KPj4gVGhlIHN1YnN5c25xbiBhdHRyaWJ1dGUgaXMgY29ycmVj
dCBmb3IgY29udHJvbGxlcnMgdGhhdCB3ZXJlIG9uY2UKPj4gY29ubmVjdGVkIGFuZCBsb3N0IGNv
bm5lY3Rpdml0eS4gTXkgcGF0Y2ggd2FzIG9ubHkgaW50ZW5kZWQgdG8gZml4IHRoZQo+PiAianVz
dCBjcmVhdGVkIGFuZCBuZXZlciBjb25uZWN0ZWQiIGNhc2UsIHdoZXJlIGl0IGlzIG5vdCwgbm90
aGluZyBtb3JlLgo+IAo+IEkgdGhpbmsgQ2hyaXN0b3BoIGlzIHN1Z2dlc3RpbmcganVzdCB3YWl0
IHVudGlsIHdlIGhhdmUgYWxsIHRoZQo+IHByb3BlcnRpZXMgdGhlIGRyaXZlciBleHBvcnRzIHJh
dGhlciB0aGFuIHNwZWNpZmljYWxseSBleHBvcnRpbmcgb25seQo+IGR1cmluZyBhICdsaXZlJyBz
dGF0ZS4gU29tZXRoaW5nIGxpa2UgdGhpcyAodW50ZXN0ZWQpIHNob3VsZCBkbyB0aGUKPiB0cmlj
azoKPiAKPiAtLS0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIGIvZHJp
dmVycy9udm1lL2hvc3QvY29yZS5jCj4gaW5kZXggMWEzY2RjNmIxMDM2Li40YzAyNThkN2ViOTEg
MTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCj4gKysrIGIvZHJpdmVycy9u
dm1lL2hvc3QvY29yZS5jCj4gQEAgLTMwNjksNiArMzA2OSw5IEBAIGludCBudm1lX2luaXRfaWRl
bnRpZnkoc3RydWN0IG52bWVfY3RybCAqY3RybCkKPiAgIAkJaWYgKHJldCkKPiAgIAkJCWdvdG8g
b3V0X2ZyZWU7Cj4gICAKPiArCQlyZXQgPSBjZGV2X2RldmljZV9hZGQoJmN0cmwtPmNkZXYsIGN0
cmwtPmRldmljZSk7Cj4gKwkJaWYgKHJldCkKPiArCQkJZ290byBvdXRfZnJlZTsKClRoaXMgaGFw
cGVucyBvbiBldmVyeSByZXNldCwgd2Ugc2hvdWxkIHByb2JhYmx5IGp1c3QgZG8gdGhpcyBvbmNl
PwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgt
bnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
