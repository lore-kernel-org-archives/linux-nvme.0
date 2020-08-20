Return-Path: <SRS0=ANWg=B6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A137BC433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 22:17:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C35C2075E
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 22:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mRdHNF8T";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KAZDS8Rf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C35C2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Pb+XvrGxOCEFG6gDtpPeyhwiqLCcmRH2rmatqFD4IoM=; b=mRdHNF8TXwIWvEM18+D3a5P5/
	4eVKr60ZSY23ISo7qie9mKRzkG9ogd6YHp7R4YRa9rES6JkCuChG5dyMZTHoAhOshwcZreIrmI3Hu
	RfmozBl5Px+Q6Rr+OzAVu6Y/oQJHIcC5GXZg1OdSWp17jHIZDMJHPtke7ZLKMP4M7VaqD1HxrmNi7
	0lFrhnqWcy59mJNO9xcgE59kUo/j1BE7n2OWdTiFyNJ0QXmnwis2K29SP4Am3P/IG3t4Wl8I5VG9z
	DdOGM9lQXWn5kDdX4xcdulNDnZGkmBYHvOoc7EgYxedo2DtsKq3c3oLrAGyHvTkORbazecujQyri9
	h2ewHRSkg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8ssH-00048f-IV; Thu, 20 Aug 2020 22:17:33 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8ssF-000488-1b
 for linux-nvme@lists.infradead.org; Thu, 20 Aug 2020 22:17:32 +0000
Received: by mail-pf1-x441.google.com with SMTP id 74so41126pfx.13
 for <linux-nvme@lists.infradead.org>; Thu, 20 Aug 2020 15:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=J4jJTNaXWu7vqcUQ4IxIEEoZKzvJchzM4NNOdGkRefI=;
 b=KAZDS8Rfj7icZjJjlIQ0roDLCyliyAJ0U0b4ZYNOgLgH1ObyqwgS4BOBWLEVQmFOmH
 LMjjJcg15XbLOeavkHKCNZulfPsuZYTLwjEY4di8aUA9zkxC2e+2Ypv+DUeExH45GT5d
 1tbWdEMy/WYKaogNcmUR0fYtCJndBbUjcUds8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=J4jJTNaXWu7vqcUQ4IxIEEoZKzvJchzM4NNOdGkRefI=;
 b=XP6NOfMFnCM9bijkdruexvgTIznexVDgsslRQjCez4BWJuaiYNlU+0+dH6BBuBftuN
 lgZk3pUGkoulG0ySxRlgy3GnRiHdMHEe+w8VrIdE+DESIA388gVqqK9nEJwtcR6Wnggq
 owv5nVV05L1bV8J6Tf62CY7Hg6pAXK1fU4APmrQv5JO4V2kDcSCiExVm/8oCVO0Llpdo
 gtRHL9tEJ2zL3GTrJl+Qr7SadI9plCLaHcNgYK/Zxi7ZlFMAHqPXSgcaHxIclPv22lyP
 qwJqViH2jVViqvxSHEN2RlKZc3ILaFIv8XnPcm1buyrQLZHKJJLAh5rT1PYcToOdBJMP
 r6SA==
X-Gm-Message-State: AOAM530W1Y0wDxpJmEECbwOrJ98i3N5t/wRdaQiuWrMkKdHncs5JIdS9
 AJne+ZeRVRrD/fGBhgbq+ekjnVvpM9Vrkvm8dOhxKpRxMrb+BSe/Z5rEy57ZiYVGwQkbskzVFKf
 nSCADic2lZObO+9ZTWtbkeP2x6z3LeisYofDCBwd+ezXZcyTr78S4Y1xR9Oim+jqNVF+5XP92Rj
 chMmAkkBsb
X-Google-Smtp-Source: ABdhPJy2gzmDMU4iPfuKVEph4QIYvrvOOBgLcZOFyz/NUN0TcoD0L4Ld4TaSY3wQUEsniix33cafxg==
X-Received: by 2002:a05:6a00:847:: with SMTP id
 q7mr673052pfk.172.1597961848156; 
 Thu, 20 Aug 2020 15:17:28 -0700 (PDT)
Received: from [10.69.69.102] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id x15sm56629pfr.208.2020.08.20.15.17.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2020 15:17:27 -0700 (PDT)
Subject: Re: [PATCH v3 2/9] nvme-fabrics: allow to queue requests for live
 queues
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
References: <20200820053651.197057-1-sagi@grimberg.me>
 <20200820053651.197057-3-sagi@grimberg.me> <20200820060941.GB6188@lst.de>
 <813bbd6c-3353-2c40-da48-bdbbdf89690c@grimberg.me>
 <bdd4f4b8-be68-2edc-5378-32c97eb3f1ae@broadcom.com>
 <a867e0e9-c4ee-26fd-cd09-ee323d23def2@grimberg.me>
From: James Smart <james.smart@broadcom.com>
Message-ID: <3ab115cd-3c53-4ab4-9382-c69c338afa60@broadcom.com>
Date: Thu, 20 Aug 2020 15:17:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <a867e0e9-c4ee-26fd-cd09-ee323d23def2@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200820_181731_370541_D9629B18 
X-CRM114-Status: GOOD (  23.58  )
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
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiA4LzIwLzIwMjAgMzoxMyBQTSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPgo+Pj4+IEknbSBz
dGlsbCByYXRoZXIgYm90aGVyZWQgd2l0aCB0aGUgYWRtaW4gcXVldWUgZXhjZXB0aW9uLsKgIEFu
ZCAKPj4+PiBnaXZlbiB0aGF0Cj4+Pj4gdGhlIHFfdXNhZ2VfY291bnRlciBwcm9ibGVtIHNob3Vs
ZCBvbmx5IHJlYWxseSBiZSBhbiBpc3N1ZSBmb3IgZmlsZSAKPj4+PiBzeXN0ZW0KPj4+PiByZXF1
ZXN0cywgYXMgcGFzc3Rocm91Z2ggcmVxdWVzdHMgZG8gbm90IGF1dG9tYXRpY2FsbHkgZ2V0IHJl
dHJpZWQgd2h5Cj4+Pj4gY2FuJ3Qgd2UganVzdCByZWplY3QgYWxsIHVzZXIgY29tbWFuZCB0byBi
ZSBzeW1ldHJpYyBhbmQgc3RyYWlnaHQgCj4+Pj4gZm9yd2FyZD8KPj4+PiBUaGUgY2FsbGVycyBp
biB1c2Vyc3BhY2UgbmVlZCB0byBiZSBhYmxlIHRvIGNvcGUgd2l0aCByZXRyeWFibGUgZXJyb3Jz
Cj4+Pj4gYW55d2F5Lgo+Pj4KPj4+IExvb2tpbmcgYXQgdGhlIGNvZGUgYWdhaW4sIEkgdGhpbmsg
d2UgY2FuIGtpbGwgaXQgYXMgd2VsbC4KPj4+Cj4+PiBUaGUgY29uY2VybiBpcyB3ZSBtYXkgaXNz
dWUgdXNlciBnZW5lcmF0ZWQgYWRtaW4gY29tbWFuZHMgYmVmb3JlCj4+PiB0aGUgY29udHJvbGxl
ciBpcyBlbmFibGVkIChnZW5lcmF0aW5nIGFuIHVuZm9yY2VkIGVycm9yIGp1c3QgYmVjYXVzZQo+
Pj4gd2UgcXVldWVkIHRvIGVhcmx5KS4gVGhhdCB1c2VkIHRvIGJlIHRoZSBjYXNlIHdoZW4gdGhl
IGFkbWluIGNvbm5lY3QKPj4+IHVzZWQgdGhlIGFkbWluX3Egd2hpY2ggbWVhbnQgd2UgbmVlZGVk
IHRvIHVucXVpZXNjZSBiZWZvcmUsIGJ1dAo+Pj4gbm93IHRoYXQgdGhlIGFkbWluIGNvbm5lY3Qg
dXNlcyB0aGUgZmFicmljc19xLCB0aGF0IHNob3VsZCBubwo+Pj4gbG9uZ2VyIGJlIGFuIGlzc3Vl
Lgo+Pj4KPj4+IGluIG52bWUtdGNwIHdlIHVucXVpZXNjZSBhZnRlciB3ZSBlbmFibGUgdGhlIGN0
cmw6Cj4+PiAuLi4KPj4+Cj4+PiBKYW1lcywgY2FuIHlvdSBwbGVhc2UgaGF2ZSBhIGxvb2sgaWYg
dGhpcyBpcyBzdGlsbCBhbiBpc3N1ZT8KPj4KPj4gSSBzdGlsbCBkaXNsaWtlIGFueSByYW5kb20g
aW9jdGxzIGNvbWluZyBpbiB3aGlsZSB3ZSdyZSBzdGlsbCAKPj4gaW5pdGlhbGl6aW5nIHRoZSBj
b250cm9sbGVyLsKgIExvb2tpbmcgYXQgdGhlIGZsb3cgLSBJIHdvdWxkbid0IHdhbnQgCj4+IHRo
ZW0gdG8gYmUgYWxsb3dlZCB1bnRpbCBhZnRlciBudm1lX2luaXRfaWRlbnRpZnkoKSBpcyBjb21w
bGV0ZS4gCj4+IEVzcGVjaWFsbHkgaWYgdGhlIGlvY3RscyBhcmUgZG9pbmcgc3Vic3lzdGVtIG9y
IGNvbnRyb2xsZXIgZHVtcGluZyBvciAKPj4gdXNpbmcgY29tbWFuZHMgdGhhdCBzaG91bGQgYmUg
Y2FwcGVkIGJ5IHZhbHVlcyBzZXQgYnkgCj4+IG52bWVfcXVldWVfbGltaXRzKCkuIEJ1dCwgaWYg
d2UncmUgZ29pbmcgdG8gYWxsb3cgbnZtZV9pbml0X2lkZW50aWZ5IAo+PiB0aGUgYWRtaW5fcSBu
ZWVkcyB0byBiZSB1bnF1aWVzY2VkLgo+Pgo+PiBTbyBJJ20gc3RpbGwgdm90aW5nIGZvciB0aGUg
YWRtaW4gcXVldWUgZXhjZXB0aW9uLgo+Cj4gSSB0aGluayB0aGF0IGlmIHRoZSBjb250cm9sbGVy
IGlzIGVuYWJsZWQsIGl0IHNob3VsZCBiZSBhYmxlIHRvIGFjY2VwdAo+IGNvbW1hbmRzLiBGb3Ig
eW91ciBzcGVjaWZpYyBjb25jZXJuLCBJIGRvbid0IHRoaW5rIHRoYXQgdGhlIHJpZ2h0IHBsYWNl
Cj4gdG8gcHJvdGVjdCBhZ2FpbnN0IGl0IGlzIF9fbnZtZl9jaGVja19yZWFkeSwgYmVjYXVzZSBm
cm9tIHRoYXQKPiBzdGFuZHBvaW50IHRoZSBjb250cm9sbGVyIF9pc18gcmVhZHkuCj4KPiBQZXJo
YXBzIGlmIHRoaXMgaXMgYSByZWFsIGNvbmNlcm4gd2Ugc2hvdWxkIGhhdmUgcGFzc3RocnUgY29t
bWFuZHMKPiB0byBjaGVjayB0aGUgY29udHJvbGxlciBzdGF0ZSBiZWZvcmUgZXhlY3V0aW5nPwo+
Cj4gQ2hyaXN0b3BoLCBLZWl0aCwgV0RZVD8KCnRoZXJlIGlzIGFsd2F5cyBhIHdpbmRvdyBiZXR3
ZWVuIHdoZW4gdGhlIGNtZCBpcyBzdWJtaXR0ZWQgYWZ0ZXIgcGFzc2luZyAKdGhlIGNoZWNrIHZz
IHdoZW4gaXQgY29tZXMgb2ZmIHRoZSBxIGZvciBleGVjdXRpb24gYW5kIG5vdyB0aGUgc3RhdGUg
b2YgCnRoZSBjb250cm9sbGVyIGhhcyBjaGFuZ2VkCgotLSBqYW1lcwoKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0
CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
