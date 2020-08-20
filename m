Return-Path: <SRS0=ANWg=B6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E942C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 22:13:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58E2B207DA
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 22:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LcwMoslt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58E2B207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=oR3IGj7LoUw//qvVhEiOeJYzZAJrpommxhwHAazmQb0=; b=LcwMosltTls+IexLMlAUOmMW/
	lDKeXrObeHUkcTE36oREkLWYmcEVP7jEMgpTX/lvpHsG5j7qC8VVal9Y9fKlHT7xRiceveJEuhRTs
	KDZO4/C5c19Lfttwcmi2t3OMmekW/LWY5ARFEp8o7J55M/nsWaTXJgRGMGcq0S1LICYQRPUIwQijV
	SAjWClh0Wn4/fsVoGPx6tx69o5nra14wIld3WRGMWsTijWQEGuvb1WqEK5TcX+WVUZAL6pXK6D4/R
	wg/6zxoTBmYrArt5qbFcfEv973nHtd064f3gpnCScV05/v6Uj0EiAuTmGXXBolppI1PVBjjPjn1BF
	cCIKFOlkg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8soY-0003ob-9L; Thu, 20 Aug 2020 22:13:42 +0000
Received: from mail-wr1-f68.google.com ([209.85.221.68])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8soV-0003oG-8j
 for linux-nvme@lists.infradead.org; Thu, 20 Aug 2020 22:13:40 +0000
Received: by mail-wr1-f68.google.com with SMTP id z18so85290wrm.12
 for <linux-nvme@lists.infradead.org>; Thu, 20 Aug 2020 15:13:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mvYb9zhFqEpsYlBSIys8vgqx9KFJi+STEDd0UCfQP2w=;
 b=LdlpJcdFDVAxDFFQJU+JcCSYAS737nmWGa8SWCN/8dEyFAOhaFavdK6LwIGbWCcFm6
 QalJ9b59pYNOxqvvOTiZ4eHgG96dGxd9OGSPHuK3njAsgaYnovjWUdnry4bSsW5PRPou
 cOBuD8KadkjlyCRUyfTOKhtQP/JrUbtU+ZJmKfVGQh15QU2WMe3pwh4hs1k91c7oRZCd
 /XdJEJTMzHYqL1HZ4xq4/kbOL3hJzUu471qDw0Wv/248YzkcwNPxEDlNY3KDfKY8Alwl
 3OtHtevALMcGpUJUsuhy8baD9Jp9rTABUVDY7SQlwuTa6qL8q72O9H6spV0FoesX61uf
 FEpw==
X-Gm-Message-State: AOAM530sYSaFvX304iAbNlfA7xBDiJOTR5HIKZ610IVSDUGFSjDY3buP
 aLlzNo3LFVm4M1+yj2cDQCLzBuCULurnTA==
X-Google-Smtp-Source: ABdhPJyJ+PG29i5eWsuQUoc7PlfZPkg7WH/8YX2fndM8WO+VoSM0fyaQoF1s9ztgbJYH0nTOphCDug==
X-Received: by 2002:adf:e704:: with SMTP id c4mr727062wrm.81.1597961617582;
 Thu, 20 Aug 2020 15:13:37 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:7ced:8569:4373:1bd3?
 ([2601:647:4802:9070:7ced:8569:4373:1bd3])
 by smtp.gmail.com with ESMTPSA id d21sm66565wmd.41.2020.08.20.15.13.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2020 15:13:36 -0700 (PDT)
Subject: Re: [PATCH v3 2/9] nvme-fabrics: allow to queue requests for live
 queues
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>
References: <20200820053651.197057-1-sagi@grimberg.me>
 <20200820053651.197057-3-sagi@grimberg.me> <20200820060941.GB6188@lst.de>
 <813bbd6c-3353-2c40-da48-bdbbdf89690c@grimberg.me>
 <bdd4f4b8-be68-2edc-5378-32c97eb3f1ae@broadcom.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a867e0e9-c4ee-26fd-cd09-ee323d23def2@grimberg.me>
Date: Thu, 20 Aug 2020 15:13:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <bdd4f4b8-be68-2edc-5378-32c97eb3f1ae@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200820_181339_350399_F3A3CF53 
X-CRM114-Status: GOOD (  23.40  )
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

Cj4+PiBJJ20gc3RpbGwgcmF0aGVyIGJvdGhlcmVkIHdpdGggdGhlIGFkbWluIHF1ZXVlIGV4Y2Vw
dGlvbi7CoCBBbmQgZ2l2ZW4gCj4+PiB0aGF0Cj4+PiB0aGUgcV91c2FnZV9jb3VudGVyIHByb2Js
ZW0gc2hvdWxkIG9ubHkgcmVhbGx5IGJlIGFuIGlzc3VlIGZvciBmaWxlIAo+Pj4gc3lzdGVtCj4+
PiByZXF1ZXN0cywgYXMgcGFzc3Rocm91Z2ggcmVxdWVzdHMgZG8gbm90IGF1dG9tYXRpY2FsbHkg
Z2V0IHJldHJpZWQgd2h5Cj4+PiBjYW4ndCB3ZSBqdXN0IHJlamVjdCBhbGwgdXNlciBjb21tYW5k
IHRvIGJlIHN5bWV0cmljIGFuZCBzdHJhaWdodCAKPj4+IGZvcndhcmQ/Cj4+PiBUaGUgY2FsbGVy
cyBpbiB1c2Vyc3BhY2UgbmVlZCB0byBiZSBhYmxlIHRvIGNvcGUgd2l0aCByZXRyeWFibGUgZXJy
b3JzCj4+PiBhbnl3YXkuCj4+Cj4+IExvb2tpbmcgYXQgdGhlIGNvZGUgYWdhaW4sIEkgdGhpbmsg
d2UgY2FuIGtpbGwgaXQgYXMgd2VsbC4KPj4KPj4gVGhlIGNvbmNlcm4gaXMgd2UgbWF5IGlzc3Vl
IHVzZXIgZ2VuZXJhdGVkIGFkbWluIGNvbW1hbmRzIGJlZm9yZQo+PiB0aGUgY29udHJvbGxlciBp
cyBlbmFibGVkIChnZW5lcmF0aW5nIGFuIHVuZm9yY2VkIGVycm9yIGp1c3QgYmVjYXVzZQo+PiB3
ZSBxdWV1ZWQgdG8gZWFybHkpLiBUaGF0IHVzZWQgdG8gYmUgdGhlIGNhc2Ugd2hlbiB0aGUgYWRt
aW4gY29ubmVjdAo+PiB1c2VkIHRoZSBhZG1pbl9xIHdoaWNoIG1lYW50IHdlIG5lZWRlZCB0byB1
bnF1aWVzY2UgYmVmb3JlLCBidXQKPj4gbm93IHRoYXQgdGhlIGFkbWluIGNvbm5lY3QgdXNlcyB0
aGUgZmFicmljc19xLCB0aGF0IHNob3VsZCBubwo+PiBsb25nZXIgYmUgYW4gaXNzdWUuCj4+Cj4+
IGluIG52bWUtdGNwIHdlIHVucXVpZXNjZSBhZnRlciB3ZSBlbmFibGUgdGhlIGN0cmw6Cj4+IC4u
Lgo+Pgo+PiBKYW1lcywgY2FuIHlvdSBwbGVhc2UgaGF2ZSBhIGxvb2sgaWYgdGhpcyBpcyBzdGls
bCBhbiBpc3N1ZT8KPiAKPiBJIHN0aWxsIGRpc2xpa2UgYW55IHJhbmRvbSBpb2N0bHMgY29taW5n
IGluIHdoaWxlIHdlJ3JlIHN0aWxsIAo+IGluaXRpYWxpemluZyB0aGUgY29udHJvbGxlci7CoCBM
b29raW5nIGF0IHRoZSBmbG93IC0gSSB3b3VsZG4ndCB3YW50IHRoZW0gCj4gdG8gYmUgYWxsb3dl
ZCB1bnRpbCBhZnRlciBudm1lX2luaXRfaWRlbnRpZnkoKSBpcyBjb21wbGV0ZS4gRXNwZWNpYWxs
eSAKPiBpZiB0aGUgaW9jdGxzIGFyZSBkb2luZyBzdWJzeXN0ZW0gb3IgY29udHJvbGxlciBkdW1w
aW5nIG9yIHVzaW5nIAo+IGNvbW1hbmRzIHRoYXQgc2hvdWxkIGJlIGNhcHBlZCBieSB2YWx1ZXMg
c2V0IGJ5IG52bWVfcXVldWVfbGltaXRzKCkuIAo+IEJ1dCwgaWYgd2UncmUgZ29pbmcgdG8gYWxs
b3cgbnZtZV9pbml0X2lkZW50aWZ5IHRoZSBhZG1pbl9xIG5lZWRzIHRvIGJlIAo+IHVucXVpZXNj
ZWQuCj4gCj4gU28gSSdtIHN0aWxsIHZvdGluZyBmb3IgdGhlIGFkbWluIHF1ZXVlIGV4Y2VwdGlv
bi4KCkkgdGhpbmsgdGhhdCBpZiB0aGUgY29udHJvbGxlciBpcyBlbmFibGVkLCBpdCBzaG91bGQg
YmUgYWJsZSB0byBhY2NlcHQKY29tbWFuZHMuIEZvciB5b3VyIHNwZWNpZmljIGNvbmNlcm4sIEkg
ZG9uJ3QgdGhpbmsgdGhhdCB0aGUgcmlnaHQgcGxhY2UKdG8gcHJvdGVjdCBhZ2FpbnN0IGl0IGlz
IF9fbnZtZl9jaGVja19yZWFkeSwgYmVjYXVzZSBmcm9tIHRoYXQKc3RhbmRwb2ludCB0aGUgY29u
dHJvbGxlciBfaXNfIHJlYWR5LgoKUGVyaGFwcyBpZiB0aGlzIGlzIGEgcmVhbCBjb25jZXJuIHdl
IHNob3VsZCBoYXZlIHBhc3N0aHJ1IGNvbW1hbmRzCnRvIGNoZWNrIHRoZSBjb250cm9sbGVyIHN0
YXRlIGJlZm9yZSBleGVjdXRpbmc/CgpDaHJpc3RvcGgsIEtlaXRoLCBXRFlUPwoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5n
IGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
