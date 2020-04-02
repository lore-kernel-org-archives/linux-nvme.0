Return-Path: <SRS0=DaKL=5S=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C84BC43331
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2020 16:18:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1C7620719
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2020 16:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LUApnfqD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1C7620719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wFReQxtrW/9zcu91X3NUGYxbV3bFg88OfgxT2+hTZ+Q=; b=LUApnfqD01wnqjiz21x2soD0P
	3o4C7Rm4Kx67PdeQ22cv+FzrhBXxTBsxX52EvIOTx8T+oUhwmg+Xg1OARrkPXf9aK8+7BOGZqH+te
	SKTh1mNtJr2KsdK6zvJeS5Gkki46q/TX1zhIoTfRUc7hjnuTVbFJdyAz2H7rOT+mrBWeqW/e9zXfY
	NtI4ow58ZlThWo/8ULqBKFCyB8+bQGeVOodbc7r/L6VWpDxt0YsPGBsX0n0ksqam8lGOkncprUJY5
	GPO2Wk4U/mvBP6CEJ/662yC150X2eWFAvqyNlm9aCx+CGWNHJgtPWYIaT7IripvQWUNsdV6r57kd5
	YFoo2L2xA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jK2Xk-0002Ry-6Q; Thu, 02 Apr 2020 16:18:12 +0000
Received: from mail-pj1-f49.google.com ([209.85.216.49])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jK2Xi-0002RX-0x
 for linux-nvme@lists.infradead.org; Thu, 02 Apr 2020 16:18:11 +0000
Received: by mail-pj1-f49.google.com with SMTP id l36so1726114pjb.3
 for <linux-nvme@lists.infradead.org>; Thu, 02 Apr 2020 09:18:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fwYYsBrvWZiwRV4myawUyuxImMUE1zWwpUsu+jOqqvA=;
 b=iwbkWIPmt5PYmmopCmCI4Imo6hUYgby1IRMoSZWF5Zq/wp/32f6roywAf4TD5sSSwP
 cbtCsGo5NXKvmpRpb9SH87RfkEwVJ88fEcSzU57l9L+e91eqn1KnFV0x93BYYP0epK7V
 arndGst2AqBHkfyNSX/0x+8SE2nbwJ2GJl5BunzfRWhjdBGWdzcotxjeI0rvqnaYIS4n
 zPuUoxvCKlsI72iICYjoOG+7+LLKUj4W5tIMXx5KLvoQzr+d+s0AGttA1+PC0bfxWeXx
 r9turbtqD3NfQo7pFvyqFCDAyFe6LkvUsRlNJDqkHWdKZivUQm+M01WdmtzWFJxLGt92
 dXkg==
X-Gm-Message-State: AGi0PuaTHl54RMgvyd5JcKxXBxGtKYgsIkzKWLnwlx3D2ZHLT7DF4YVA
 4lCIKDU9Gfb+HVehJjDqAAyzmGh/
X-Google-Smtp-Source: APiQypL1tUP6A+Gz5kmhl3arkAMLgACdA8WfotZsEEsiAYr6R4q1PPuZbGBokG1j8pwK1C3jGb2ssA==
X-Received: by 2002:a17:90a:315:: with SMTP id 21mr4274439pje.96.1585844289069; 
 Thu, 02 Apr 2020 09:18:09 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:a836:db4c:a7ac:3d7c?
 ([2601:647:4802:9070:a836:db4c:a7ac:3d7c])
 by smtp.gmail.com with ESMTPSA id u186sm4011960pfu.205.2020.04.02.09.18.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 02 Apr 2020 09:18:08 -0700 (PDT)
Subject: Re: nvme deadlock with ANA
To: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
References: <5e38c566-3f26-288d-1004-161d1084b468@grimberg.me>
 <20200402160003.GA3901@redsun51.ssa.fujisawa.hgst.com>
 <9d8c4bed-1b90-41c0-9cf3-2907bb21889d@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <40571fce-24eb-44a3-2663-dcd6937a4ad0@grimberg.me>
Date: Thu, 2 Apr 2020 09:18:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <9d8c4bed-1b90-41c0-9cf3-2907bb21889d@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200402_091810_068921_6C436F91 
X-CRM114-Status: GOOD (  16.21  )
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
Cc: Anton Eidelman <anton@lightbitslabs.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme <linux-nvme@lists.infradead.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4+PiBIZXksCj4+Pgo+Pj4gSSB3YW50IHRvIGNvbnN1bHQgd2l0aCB5b3UgZ3V5cyBvbiBhIGRl
YWRsb2NrIGNvbmRpdGlvbiBJJ20gYWJsZSB0bwo+Pj4gaGl0IHdpdGggYSB0ZXN0IHRoYXQgaW5j
b3Jwb3JhdGUgY29udHJvbGxlciByZWNvbm5lY3QsIGFuYSB1cGRhdGVzCj4+PiBhbmQgbGl2ZSBJ
L08gd2l0aCB0aW1lb3V0cy4KPj4+Cj4+PiBUaGlzIGlzIHRydWUgZm9yIE5WTWUvVENQLCBidXQg
Y2FuIGFsc28gaGFwcGVuIGluIHJkbWEgb3IgcGNpIGRyaXZlcnMgYXMKPj4+IHdlbGwuCj4+Pgo+
Pj4gVGhlIGRlYWRsb2NrIGNvbWJpbmVzIDQgZmxvd3MgaW4gcGFyYWxsZWw6Cj4+PiAtIG5zIHNj
YW5uaW5nICh0cmlnZ2VyZWQgZnJvbSByZWNvbm5lY3QpCj4+PiAtIHJlcXVlc3QgdGltZW91dAo+
Pj4gLSBBTkEgdXBkYXRlICh0cmlnZ2VyZWQgZnJvbSByZWNvbm5lY3QpCj4+PiAtIEZTIEkvTyBj
b21pbmcgaW50byB0aGUgbXBhdGggZGV2aWNlCj4+Pgo+Pj4gKDEpIG5zIHNjYW5uaW5nIHRyaWdn
ZXJzIGRpc2sgcmV2YWxpZGF0aW9uIC0+IHVwZGF0ZSBkaXNrIGluZm8gLT4KPj4+IMKgwqDCoMKg
IGZyZWV6ZSBxdWV1ZSAtPiBidXQgYmxvY2tlZCwgd2h5Pwo+Pj4KPj4+ICgyKSB0aW1lb3V0IGhh
bmRsZXIgcmVmZXJlbmNlIHRoZSBnX3VzYWdlX2NvdW50ZXIgLSA+IGJ1dCBibG9ja3MgaW4KPj4+
IMKgwqDCoMKgIHRoZSB0aW1lb3V0IGhhbmRsZXIsIHdoeT8KPj4+Cj4+PiAoMykgdGhlIHRpbWVv
dXQgaGFuZGxlciAoaW5kaXJlY3RseSkgY2FsbHMgbnZtZV9zdG9wX3F1ZXVlKCkgLT4gd2hpY2gK
Pj4+IMKgwqDCoMKgIHRha2VzIHRoZSBuYW1lc3BhY2VzX3J3c2VtIC0gPiBidXQgYmxvY2tzLCB3
aHk/Cj4+Pgo+Pj4gKDQpIEFOQSB1cGRhdGUgdGFrZXMgdGhlIG5hbWVzcGFjZXNfcndzZW0gLT4g
Y2FsbHMgbnZtZV9tcGF0aF9zZXRfbGl2ZSgpCj4+PiDCoMKgwqDCoCAtPiB3aGljaCBzeW5jaHJv
bml6ZSB0aGUgbnNfaGVhZCBzcmN1IChzZWUgY29tbWl0IDUwNGRiMDg3YWFjYykgLT4KPj4+IMKg
wqDCoMKgIGJ1dCBpdCBibG9ja3MsIHdoeT8KPj4KPj4KPj4gV2h5IGlzIGFuYSB1cGRhdGluZyBv
Y2N1cmluZyB1bmRlciBhIHdyaXRlIGxvY2s/IEFGQUlLLCB0aGF0IHNob3VsZCBiZQo+PiBuZWNl
c3Nhcnkgb25seSBpZiBpdCdzIG1hbmlwdWxhdGluZyB0aGUgY3RybC0+bmFtZXNwYWNlcyBsaXN0
LCBidXQgdGhpcwo+PiBpcyBqdXN0IGl0ZXJhdGluZyBpdC4gV2hhdCdzIHRoZSBoYXJtIGluIHVz
aW5nIHRoZSByZWFkIGxvY2sgaGVyZT8KPiAKPiBXaGlsZSB3ZSBkbyBsb2NrIG5zLT5oZWFkIHdo
ZW4gdXBkYXRpbmcgdGhlIGFuYSBzdGF0ZSwgd2UgZG8gbm90IHByb3RlY3QgCj4gdGhlIG5zLT5o
ZWFkIHBvaW50ZXIgaXRzZWxmLgo+IFNvIEkgZ3Vlc3MgdGhlIGludGVudGlvbiB3YXMgdG8gYXZv
aWQgYW55b25lIG1lc3Npbmcgd2l0aCB0aGUgbnMtPmhlYWQgCj4gcG9pbnRlciB3aGlsZSB0cmF2
ZXJzaW5nOyBidXQgbG9va2luZyBjbG9zZXIgSSB0aGluayB3ZSBzaG91bGQgYmUgZ29vZCAKPiB3
aXRoIGp1c3QgdGFraW5nIHRoZSByZWFkIGxvY2suCj4gQ2FuIHlvdSB0cnkgaWYgaXQgbWFrZXMg
YSBkaWZmZXJlbmNlPwoKSSB3aWxsLCBidXQgdGhpcyBjaGFuZ2UgaXMgbmVlZGVkIGFueXdheXMg
QUZBSUNULgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtbnZtZSBtYWlsaW5nIGxpc3QKbGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
