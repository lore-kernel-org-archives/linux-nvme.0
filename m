Return-Path: <SRS0=wRjJ=FE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083A1C63777
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Nov 2020 19:20:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 725A42076E
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Nov 2020 19:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Wr8KtFOr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 725A42076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=W7wbpZtw7pAoZdvBxDLZiNOLzGQ8sxEVnrI9na47wCY=; b=Wr8KtFOr2ydWsEK6/ZZjIugvn
	rDPcf7vMKSRc+70yvl+Gav3pS49seju+Mh1x5AzTb65K4kv9tTDI6MrohmK9QwEACtpnPxsx1ifQm
	mwb9bpYcRZQY91a47K0Ou2yhibgGHx8JTDQDcKW7H0r9woSvow89Tb7QHrMWEwWC83uKaA2qPzddO
	+KxiFxGnycJtA/8mE/z42uXD1WLvzBu60smOGR2FnwFqQc8IjQT/uO3G1Jxbgm7SIVj8VQ3gBWcuT
	ATtvWbQkLXZMWZMPLsVKT68uICwaM1nUM1GDg0Yt4av9C5yquqmUcJunU4g7+awm86G+UL75GWJQm
	2hiT+anPw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kjoj3-0002OD-Ed; Mon, 30 Nov 2020 19:20:41 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kjoj1-0002Nm-52
 for linux-nvme@lists.infradead.org; Mon, 30 Nov 2020 19:20:40 +0000
Received: by mail-wm1-f47.google.com with SMTP id k10so454773wmi.3
 for <linux-nvme@lists.infradead.org>; Mon, 30 Nov 2020 11:20:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mukpp6Mq76LOTsdZgqPYBiMElAO+nckYaXg+oNK1qDc=;
 b=PMREQGpUZstNG0qWEQWI+fa8DUE5B0NBRgHpqiZTerZC+maf00zwF8uphKVxMtahcx
 joW1KylV4+J2YaXokPFH60a2ee4D5agkxX17RQ5TKxhv7BXVnW+PwA0syjW644jp0Fzx
 InQ+vKWP1KFrWJNL0xMYT4bxMnSGKCIQBC94erQQ3mprRNiBGCraAeq+QjxdZ01/cf7q
 Dbh0xEaTub1EDadynyuFJMuNGipHk+THgRHG4SJ7k/BurFN7eklYeQhgZ/TAT1VTz+xv
 /w0chI2XPgskmFpXJhPt8Dic5v0IST7Suv8OzXebGqMvdoSvhj94H/9BPagrFyRIPave
 AseQ==
X-Gm-Message-State: AOAM532OOl8f93omItqhU9aIKvzY6/GOna7OvTcmPHI6epB+M1R2WTmi
 UPlRfmdm5ClTkXd4cw+ZgXA=
X-Google-Smtp-Source: ABdhPJzpAIM4wte2jLpvG6ah5G90aGtc/tPBXKn0F1OXOYAXgdaLbRYyOpvfvP1GZY/CMGC2i0wGXg==
X-Received: by 2002:a1c:208f:: with SMTP id g137mr330289wmg.67.1606764035732; 
 Mon, 30 Nov 2020 11:20:35 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:9a41:a6e2:c4ef:e7b8?
 ([2601:647:4802:9070:9a41:a6e2:c4ef:e7b8])
 by smtp.gmail.com with ESMTPSA id z11sm346453wmc.39.2020.11.30.11.20.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Nov 2020 11:20:35 -0800 (PST)
Subject: Re: [PATCH] iosched: Add i10 I/O Scheduler
To: Rachit Agarwal <rach4x0r@gmail.com>
References: <20201112140752.1554-1-rach4x0r@gmail.com>
 <5a954c4e-aa84-834d-7d04-0ce3545d45c9@kernel.dk>
 <da0c7aea-d917-4f3a-5136-89c30d12ba1f@grimberg.me>
 <fd12993a-bcb7-7b45-5406-61da1979d49d@kernel.dk>
 <10993ce4-7048-a369-ea44-adf445acfca7@grimberg.me>
 <c4cb66f6-8a66-7973-dc03-0f4f61d0a1e4@kernel.dk>
 <cbe18a3d-8a6b-e775-81bb-3b3f11045183@grimberg.me>
 <26a1cd20-6b25-eaa6-7ab6-ba7f5afaf6dd@kernel.dk>
 <81cdcb58-9a23-8192-6213-7f2408a3b8ee@grimberg.me>
 <CAKeUqKKHg1wD19pnwJEd8whubnuGVic_ZhDjebaq3kKmY9TtsQ@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0cce60db-5a41-2e1b-ba5d-7905966bec25@grimberg.me>
Date: Mon, 30 Nov 2020 11:20:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKeUqKKHg1wD19pnwJEd8whubnuGVic_ZhDjebaq3kKmY9TtsQ@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201130_142039_232725_54701FEA 
X-CRM114-Status: GOOD (  27.78  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Qizhe Cai <qc228@cornell.edu>,
 Rachit Agarwal <ragarwal@cornell.edu>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Ming Lei <ming.lei@redhat.com>,
 linux-block@vger.kernel.org, Midhul Vuppalapati <mvv25@cornell.edu>,
 Jaehyun Hwang <jaehyun.hwang@cornell.edu>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@lightbitslabs.com>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4gRGVhciBhbGw6Cj4gCj4gVGhhbmtzLCBhZ2FpbiwgZm9yIHRoZSB2ZXJ5IGNvbnN0cnVjdGl2
ZSBkZWNpc2lvbnMuCj4gCj4gSSBhbSB3cml0aW5nIGJhY2sgd2l0aCBxdWl0ZSBhIGZldyB1cGRh
dGVzOgo+IAo+IDEuIFdlIGhhdmUgbm93IGluY2x1ZGVkIGEgZGV0YWlsZWQgY29tcGFyaXNvbiBv
ZiBpMTAgc2NoZWR1bGVyIHdpdGggCj4gS3liZXIgd2l0aCBOVk1lLW92ZXItVENQIAo+IChodHRw
czovL2dpdGh1Yi5jb20vaTEwLWtlcm5lbC91cHN0cmVhbS1saW51eC9ibG9iL21hc3Rlci9pMTAt
ZXZhbHVhdGlvbi5wZGYpLiAKPiBJbiBhIG51dHNoZWxsLCB3aGVuIG9wZXJhdGluZyB3aXRoIE5W
TWUtb3Zlci1UQ1AsIGkxMCBkZW1vbnN0cmF0ZXMgdGhlIAo+IGNvcmUgdHJhZGVvZmY6IGhpZ2hl
ciBsYXRlbmN5LCBidXQgYWxzbyBoaWdoZXIgdGhyb3VnaHB1dC4gVGhpcyBzZWVtcyB0byAKPiBi
ZSB0aGUgY29yZSB0cmFkZW9mZiBleHBvc2VkIGJ5IGkxMC4KPiAKPiAyLiBXZSBoYXZlIG5vdyBp
bXBsZW1lbnRlZCBhbiBhZGFwdGl2ZSB2ZXJzaW9uIG9mIGkxMCBJL08gc2NoZWR1bGVyLCAKPiB0
aGF0IHVzZXMgdGhlIG51bWJlciBvZiBvdXRzdGFuZGluZyByZXF1ZXN0cyBhdCB0aGUgdGltZSBv
ZiBiYXRjaCAKPiBkaXNwYXRjaCAoYW5kIHdoZXRoZXIgdGhlIGRpc3BhdGNoIHdhcyB0cmlnZ2Vy
ZWQgYnkgdGltZW91dCBvciBub3QpIHRvIAo+IGFkYXB0aXZlbHkgc2V0IHRoZSBiYXRjaGluZyBz
aXplLiBUaGUgbmV3IHJlc3VsdHMgCj4gKGh0dHBzOi8vZ2l0aHViLmNvbS9pMTAta2VybmVsL3Vw
c3RyZWFtLWxpbnV4L2Jsb2IvbWFzdGVyL2kxMC1ldmFsdWF0aW9uLnBkZikgCj4gc2hvdyB0aGF0
IGkxMC1hZGFwdGl2ZSBmdXJ0aGVyIGltcHJvdmVzIHBlcmZvcm1hbmNlIGZvciBsb3cgbG9hZHMs
IHdoaWxlIAo+IGtlZXBpbmcgdGhlIHBlcmZvcm1hbmNlIGZvciBoaWdoIGxvYWRzLiBJTU8sIHRo
ZXJlIGlzIG11Y2ggdG8gZG8gb24gCj4gZGVzaWduaW5nIGltcHJvdmVkIGFkYXB0YXRpb24gYWxn
b3JpdGhtcy4KPiAKPiAzLiBXZSBoYXZlIG5vdyB1cGRhdGVkIHRoZSBpMTAtZXZhbHVhdGlvbiBk
b2N1bWVudCB0byBpbmNsdWRlIHJlc3VsdHMgCj4gZm9yIGxvY2FsIHN0b3JhZ2UgYWNjZXNzLiBU
aGUgY29yZSB0YWtlLWF3YXkgaGVyZSBpcyB0aGF0IGkxMC1hZGFwdGl2ZSAKPiBjYW4gYWNoaWV2
ZSBzaW1pbGFyIHRocm91Z2hwdXQgYW5kIGxhdGVuY3kgYXQgbG93IGxvYWRzIGFuZCBhdCBoaWdo
IAo+IGxvYWRzIHdoZW4gY29tcGFyZWQgdG8gbm9vcCwgYnV0IHN0aWxsIHJlcXVpcmVzIG1vcmUg
d29yayBmb3IgbG93ZXIgCj4gbG9hZHMuIEhvd2V2ZXIsIGdpdmVuIHRoYXQgdGhlIHRyYWRlb2Zm
IGV4cG9zZWQgYnkgaTEwIHNjaGVkdWxlciBpcyAKPiBwYXJ0aWN1bGFybHkgdXNlZnVsIGZvciBy
ZW1vdGUgc3RvcmFnZSBkZXZpY2VzIChhbmQgYXMgSmVucyBzdWdnZXN0ZWQsIAo+IHBlcmhhcHMg
Zm9yIHZpcnR1YWxpemVkIGxvY2FsIHN0b3JhZ2UgYWNjZXNzKSwgSSBkbyBhZ3JlZSB3aXRoIFNh
Z2kgLS0gSSAKPiB0aGluayB3ZSBzaG91bGQgY29uc2lkZXIgaW5jbHVkaW5nIGl0IGluIHRoZSBj
b3JlLMKgc2luY2UgdGhpcyBtYXkgYmUgCj4gdXNlZnVsIGZvciBhIGJyb2FkIHJhbmdlIG9mIG5l
dyB1c2UgY2FzZXMuCj4gCj4gV2UgaGF2ZSBhbHNvIGNyZWF0ZWQgYSBzZWNvbmQgdmVyc2lvbiBv
ZiB0aGUgcGF0Y2ggdGhhdCBpbmNsdWRlcyB0aGVzZSAKPiB1cGRhdGVzOiAKPiBodHRwczovL2dp
dGh1Yi5jb20vaTEwLWtlcm5lbC91cHN0cmVhbS1saW51eC9ibG9iL21hc3Rlci8wMDAyLWlvc2No
ZWQtQWRkLWkxMC1JLU8tU2NoZWR1bGVyLnBhdGNoCj4gCj4gQXMgYWx3YXlzLCB0aGFuayB5b3Ug
Zm9yIHRoZSBjb25zdHJ1Y3RpdmUgZGlzY3Vzc2lvbiBhbmQgSSBsb29rIGZvcndhcmQgCj4gdG8g
d29ya2luZyB3aXRoIHlvdSBvbiB0aGlzLgoKVGhhbmtzIFJhY2hpdCwKCldvdWxkIGJlIGdvb2Qg
aWYgeW91IGNhbiBzZW5kIGEgZm9ybWFsIHBhdGNoIGZvciB0aGUgYWRhcHRpdmUgcXVldWluZyBz
bwpwZW9wbGUgY2FuIGhhdmUgYSBsb29rLgoKT25lIHRoaW5nIHRoYXQgd2FzIGxlZnQgb24gdGhl
IHRhYmxlIGlzIHdlYXRoZXIgdGhpcyBzaG91bGQgYmUgYSBmdWxsCmJsb3duIHNjaGVkdWxlciBv
ciBhIGNvcmUgYmxvY2sgaW5mcmFzdHJ1Y3R1cmUgdGhhdCB3b3VsZCBlaXRoZXIgYmUKc2V0IG9u
LWRlbWFuZCBvciBieSBkZWZhdWx0LgoKSSB0aGluayB0aGF0IEplbnMgYW5kIE1pbmcgZXhwcmVz
c2VkIHRoYXQgdGhpcyBzaG91bGQgYmUgc29tZXRoaW5nIHRoYXQKd2Ugc2hvdWxkIHBsYWNlIHRo
aXMgaW4gdGhlIGJsb2NrIGNvcmUsIGJ1dCBJJ2QgbGlrZSB0byBoZWFyIG1heWJlCk1pbmcgY2Fu
IGVsYWJvcmF0ZSBvbiBoaXMgaWRlYXMgaG93IHRvIGRvIHRoaXMuCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApM
aW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
