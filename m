Return-Path: <SRS0=rw3x=BR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45EAC433DF
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 17:37:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD4A4204EA
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 17:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NSwMUtb/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD4A4204EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9p0O2IttIbjKa7wrbhfYW5wZM0CIZweiAsJpD5yIp8I=; b=NSwMUtb/rmJaUK/RDwijRPsu+
	zCEuUd8Wwx0U+cI9/tixyxneMSn7EU1h8f6S70QelxmwG9wA5dI+JwqB/6ts5XNrqDxgt7T5Dnuag
	5E7nZiDoLYHEI7iVwye+3y57LCz96TDgoMd4nw7ipIXLOnvoPNoLzgPm94hlWzdOnlqAGhB+zBahi
	Tq2SBjlc6/rGGIunDqy5SjDWbRK+XpZ9ZZsfok9dGHpNWAVgDhKAFIhaM0ZHu7EaN05P5soJMQX66
	C5NiFNT0O7lv8eE6U/fcNA/Q4n7to5NQWgtJjjEcxhzhcZWR7isLCGjsqZ3ArEN/COussAEZu1eCX
	0kx6Ry9RA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k46Ip-0003b9-BN; Fri, 07 Aug 2020 17:37:11 +0000
Received: from mail-pj1-f52.google.com ([209.85.216.52])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k46In-0003ad-KT
 for linux-nvme@lists.infradead.org; Fri, 07 Aug 2020 17:37:10 +0000
Received: by mail-pj1-f52.google.com with SMTP id ep8so1254194pjb.3
 for <linux-nvme@lists.infradead.org>; Fri, 07 Aug 2020 10:37:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fcAGVOZoFmGPclfa+0EIWXcQfiDTOUuugl4iB5jj/uM=;
 b=fPiAweoodd9eXcXwoKiYvOn8kwKJYI1td+se3XA5rQxxd/8aYJ0WKYhbEDEBdkYywA
 YM7hBqlpHeqnHo/xUkkbHxvx0z5IulS2wexgykn6XUuKIrD07dzuYN4219j84Jw0eiU2
 c0SyzoYFQA0jPPavU9s7PyJoDxeniev9TbUDKeEs1mrVu9n4jHVaTKhUOxXw0sVbfD1p
 FVwAeu68gvae22tNtzRw369tS+tqzGL8iqCFIR0qzVNpzSCHY11XzcWIUoaRD3xRa9yP
 5Nee4XHGp0cZ7N5M9hjjLH2w5FQjL5FBM3dwOO4kZrUvgr6ktzjlgUUB/nk+rUX/2Rdm
 EsQg==
X-Gm-Message-State: AOAM532rhmOz53yholNTYRkcQwOM1g8OMDrG1sNTaG4CSETv0Y10wkVw
 fl5VWtGlnVEs0JDl0Fs/GSM=
X-Google-Smtp-Source: ABdhPJyNylbIrs7q+gcUpFAhlN6fwui/I0hYpxhThhEv2q0MOWLzD8yFi7x4Nly+3943DFcD1o0ohQ==
X-Received: by 2002:a17:90a:498b:: with SMTP id
 d11mr14417906pjh.179.1596821828556; 
 Fri, 07 Aug 2020 10:37:08 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:3dec:a6f0:8cde:ad1c?
 ([2601:647:4802:9070:3dec:a6f0:8cde:ad1c])
 by smtp.gmail.com with ESMTPSA id t11sm11478530pjo.41.2020.08.07.10.37.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2020 10:37:07 -0700 (PDT)
Subject: Re: [PATVH V2 1/3] nvmet: add ns tear down label for pt-cmd handling
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20200807022032.48873-1-chaitanya.kulkarni@wdc.com>
 <20200807022032.48873-2-chaitanya.kulkarni@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <cbf389f7-b437-e866-21a7-792fcaf405ad@grimberg.me>
Date: Fri, 7 Aug 2020 10:37:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200807022032.48873-2-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200807_133709_713386_1676B1B4 
X-CRM114-Status: GOOD (  15.22  )
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
Cc: logang@deltatee.com, hch@lst.de
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4gSW4gdGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gYmVmb3JlIHN1Ym1pdHRpbmcgdGhlIHBh
c3N0aHJ1IGNtZMKgd2UKPiBtYXkgY29tZSBhY3Jvc3PCoGVycm9yIGUuZy4gZ2V0dGluZyBucyBm
cm9tIHBhc3N0aHJ1IGNvbnRyb2xsZXIsCj4gYWxsb2NhdGluZyBhIHJlcXVlc3QgZnJvbSBwYXNz
dGhydSBjb250cm9sbGVyLCBldGMuIEZvciBhbGwgdGhlIGZhaWx1cmUKPiBjYXNlcyBpdCBvbmx5
IHVzZXMgc2luZ2xlIGdvdG8gbGFiZWwgZmFpbF9vdXQuCj4gCj4gSW4gdGhlIHRhcmdldCBjb2Rl
LCB3ZSBmb2xsb3cgdGhlIHBhdHRlcm4gdG8gaGF2ZSBhIHNlcGFyYXRlIGxhYmVsIGZvcgo+IGVh
Y2ggZXJyb3Igb3V0IHRoZSBjYXNlIHdoZW4gc2V0dGluZyB1cCBtdWx0aXBsZSB0aGluZ3MgYmVm
b3JlIHRoZSBhY3R1YWwKPiBhY3Rpb24uCj4gCj4gVGhpcyBwYXRjaCBmb2xsb3dzIHRoZSBzYW1l
IHBhdHRlcm4gYW5kIHJlbmFtZXMgZ2VuZXJpYyBmYWlsX291dCBsYWJlbAo+IHRvIG91dF9wdXRf
bnMgYW5kIHVwZGF0ZXMgdGhlIGVycm9yIG91dCBjYXNlcyBpbiB0aGUKPiBudm1ldF9wYXNzdGhy
dV9leGVjdXRlX2NtZCgpIHdoZXJlIGl0IGlzIG5lZWRlZC4KClRoaXMgcGF0Y2ggc2VlbXMgZmFp
bCB3aGVuIGFwcGx5aW5nOgoKJCBnaXQgYW0gLXMgbWFpbC9jaGFpdGFueWEtcHQtZml4ZXMvMQpl
cnJvcjogY2Fubm90IGNvbnZlcnQgZnJvbSB5IHRvIFVURi04CmZhdGFsOiBjb3VsZCBub3QgcGFy
c2UgcGF0Y2gKCkdvb2dsZSBzZWFyY2ggc3VnZ2VzdCB0aGF0IG1heWJlIHRoZSBmaWxlIGlzIGNv
cnJ1cHRlZCwgYnV0IG5vdCBzdXJlLgoKRGlkIHlvdSBkbyBzb21ldGhpbmcgc3BlY2lhbCB3aXRo
IHlvdXIgZW52aXJvbm1lbnQ/CgpQYXRjaGVzIDIrMyBkbyBub3QgaGF2ZSB0aGlzIGlzc3VlLgoK
U3RyYW5nZS4uLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
