Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7F9C433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 20:44:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1366F206C0
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 20:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hwvWSJQk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1366F206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=T0vM7PVld3yJ82zAIfXq7IFhXfO+JUWYu9ZPcrMv2tY=; b=hwvWSJQkN3rl+AstENGrqJsYh
	hatNCuDiVm9T9r7W8dP+3LNs+NOCTHAyA9MycV9JA9MpkKFrybBWjlOwAGYQn5U72+FjxmSF58Q72
	JTSjvmV8h53TUTkUT6xbd58jcETtDy1LIRbbgpSJ0VVhCT7+PGFV0xKHRAf2K7icI191L3wYieknj
	vRK8A9JDTUSHRDNHzBXk67L92uCevFLo7FN/jhta11kQ+glXNW0LIO4FxRolv+S2MDOba5BVjyhb3
	hQtQUjKOuex19BoclT4kfEGlwZGGV2lXKZBq1aZ3Jwwhuy72+uHtR9uiJSL+VqnzRm2PJrjMzA13P
	p+i8vJx7Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6gYf-0003N0-5l; Fri, 14 Aug 2020 20:44:13 +0000
Received: from mail-pl1-f194.google.com ([209.85.214.194])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6gYb-0003MD-Vg
 for linux-nvme@lists.infradead.org; Fri, 14 Aug 2020 20:44:10 +0000
Received: by mail-pl1-f194.google.com with SMTP id g7so3570229plq.1
 for <linux-nvme@lists.infradead.org>; Fri, 14 Aug 2020 13:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=C17o7d1MIphvyM5N3VMBFo6uXfTUhSV4ALkKc9r+fkk=;
 b=L8pC0hIapS3Z5nmvVY2WoGGRkFGLyj72X5nifbRK+n9RVu3dXmnKrEfsZ+gsUSVMMD
 Db+FzuD6R0E6dABeWfE2AZur4Dx6Rb4zl51xUyOiR6TEvNyugqvkNwOyWVXU8vYTxJmQ
 Cs34SOlX51e0rrjcBrwQmx3yynsY76VbnOIHu4yORZoLs3q2+lXQuV+g2tVX34Blnlnk
 46a5CxbJp+UG716Q6nSmgMjxsONy08I3Wb02cO+92vP+JtjBBg2ZU81M5O1ERdJQXiiY
 iTm2b3CuIKNeOiztC1NjLHUAEWnFQnhTlP/MENHytRbDNS9QdFJfm3HtCeFSknwLJuLw
 ZAeQ==
X-Gm-Message-State: AOAM533Q1+HDgQkLDeIAHIjVvAV07NH8xIlIwIKJZiz0Ki1ItF5/6QDB
 yEl3yKPxpoELcvis8IYA2fw=
X-Google-Smtp-Source: ABdhPJz4y/CuF6oXQcSSklsTDE+vGzRvVl3x9562QrM80uOlygk2X3UnOssEOBhMBYr/8zyr2Xp0Rg==
X-Received: by 2002:a17:902:ff03:: with SMTP id
 f3mr3189532plj.302.1597437849189; 
 Fri, 14 Aug 2020 13:44:09 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:51f:3472:bc7:2f4f?
 ([2601:647:4802:9070:51f:3472:bc7:2f4f])
 by smtp.gmail.com with ESMTPSA id t33sm9470589pga.72.2020.08.14.13.44.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 13:44:08 -0700 (PDT)
Subject: Re: [PATCH v4 7/7] nvme: support rdma transport type
To: Yi Zhang <yi.zhang@redhat.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
References: <20200814061815.536540-1-sagi@grimberg.me>
 <20200814061815.536540-8-sagi@grimberg.me>
 <ffcaf9e2-083c-9601-16bd-054c3bd3b94c@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a0adbdf0-bdb2-00de-02b9-b47dfc57ec35@grimberg.me>
Date: Fri, 14 Aug 2020 13:44:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ffcaf9e2-083c-9601-16bd-054c3bd3b94c@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200814_164410_045855_21EC9350 
X-CRM114-Status: GOOD (  15.89  )
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
Cc: Keith Busch <kbusch@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

PiBPbiA4LzE0LzIwIDI6MTggUE0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4+IFNpZ25lZC1vZmYt
Ynk6IFNhZ2kgR3JpbWJlcmcgPHNhZ2lAZ3JpbWJlcmcubWU+Cj4+IC0tLQo+PiDCoCB0ZXN0cy9u
dm1lL3JjIHwgMTUgKysrKysrKysrKysrKysrCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNl
cnRpb25zKCspCj4+Cj4+IGRpZmYgLS1naXQgYS90ZXN0cy9udm1lL3JjIGIvdGVzdHMvbnZtZS9y
Ywo+PiBpbmRleCAzZTk3ODAxYmJiMzAuLjY3NWFjYmZhNzAxMiAxMDA2NDQKPj4gLS0tIGEvdGVz
dHMvbnZtZS9yYwo+PiArKysgYi90ZXN0cy9udm1lL3JjCj4+IEBAIC01LDYgKzUsNyBAQAo+PiDC
oCAjIFRlc3Qgc3BlY2lmaWMgdG8gTlZNZSBkZXZpY2VzCj4+IMKgIC4gY29tbW9uL3JjCj4+ICsu
IGNvbW1vbi9tdWx0aXBhdGgtb3Zlci1yZG1hCj4+IMKgIGRlZl90cmFkZHI9IjEyNy4wLjAuMSIK
Pj4gwqAgZGVmX2FkcmZhbT0iaXB2NCIKPj4gQEAgLTI1LDYgKzI2LDEyIEBAIF9udm1lX3JlcXVp
cmVzKCkgewo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgX2hhdmVfbW9kdWxlcyBudm1ldCBudm1lLWNv
cmUgbnZtZS10Y3AgbnZtZXQtdGNwCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBfaGF2ZV9jb25maWdm
cwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgOzsKPj4gK8KgwqDCoCByZG1hKQo+PiArwqDCoMKgwqDC
oMKgwqAgX2hhdmVfbW9kdWxlcyBudm1ldCBudm1lLWNvcmUgbnZtZS1yZG1hIG52bWV0LXJkbWEK
Pj4gK8KgwqDCoMKgwqDCoMKgIF9oYXZlX2NvbmZpZ2ZzCj4+ICvCoMKgwqDCoMKgwqDCoCBfaGF2
ZV9wcm9ncmFtIHJkbWEKPj4gK8KgwqDCoMKgwqDCoMKgIF9oYXZlX21vZHVsZXMgcmRtYV9yeGUg
c2l3Cj4gCj4gc3RhcnRfc29mdF9yZG1hIGNhbiB1c2Ugc2l3IG9yIHJkbWFfcnhlKGRlZmF1bHQg
b25lKSBtb2R1bGUsIGJ1dCBzb21lIAo+IG9sZCBkaXN0cm9zIG1heSBub3Qgc3VwcG9ydCBzaXcs
IGJ1dCBzdXBwb3IgcmRtYV9yeGUuCj4gaG93IGFib3V0Ogo+IF9oYXZlX21vZHVsZXMgcmRtYV9y
eGUgfHwgX2hhdmVfbW9kdWxlcyBzaXcKCk9LCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1udm1lCg==
