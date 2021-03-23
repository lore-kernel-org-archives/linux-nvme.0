Return-Path: <SRS0=jrCY=IV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56508C433C1
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Mar 2021 07:31:57 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF850619B2
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Mar 2021 07:31:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF850619B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UJRNWHO5KdIFBlBDvO1TccwSC5OKWCIo4lCElBjFlj4=; b=Ea3lZqZ5O7qd8pAD/3knGmMXq
	+F57Id901s8et42gZgmJXz7bEHJZJk4N8NSLx6iStVXWB3a++FBCyjXJgWRzNdeHg1+VXU3/AhSf0
	ukRBmLPAmhAEYFDMVEPrQbCn9Yb5kL8yz+AiYXxHKJJT4kPhL0iNjZnOAWD341cqRH6U3d2yssmGX
	AxKe1YVvjOfl/4fbzF1paJlNgxAQQAGWmOJi5JG4RBSUbkicc/r5SP4AwTbk7DBgtpwdoT9bdiXRQ
	QY/ZI7eXmKSV3kYM6VWPNxcvisrlwW9ON+uwb/wIzU+LcHJPX1Gog9APZEHn6Dw50wi/kKLs4eVsW
	hzmwcr4JA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lObVs-00E8yt-4A; Tue, 23 Mar 2021 07:31:40 +0000
Received: from mail-pg1-f173.google.com ([209.85.215.173])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lObVn-00E8xw-LW
 for linux-nvme@lists.infradead.org; Tue, 23 Mar 2021 07:31:37 +0000
Received: by mail-pg1-f173.google.com with SMTP id 32so4680869pgm.1
 for <linux-nvme@lists.infradead.org>; Tue, 23 Mar 2021 00:31:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9eHXV6zSRozwt4aPaor2MdVhMcc8OF3oYeMa61Rg2hA=;
 b=cPjXaws+D4iYBe765RbgWCdMV2Jk+AHHI0Fu3DHUdoj/XvcIHvgjJrh3khPnkh+6zE
 4PGDdsRCBf5d8f1WiqkGHVrsDoiKOlOYZdrKjZ/rEncNa0i0THukhiFHlXIhsLN+GO3j
 55WsgOdoG2EmeqZFGYe9PpS9dKFwhn65udWpL2dx+d8xVjq8OYeeg9wKNE7BlJ6thoew
 HtTyZWRUhty0AFNfXR3cLwlT8dk1INtoCkrdy1WaERay+6C0iKiXgNwjBhIkzaLGYEuV
 1+8TwmTmV2DrLTTdYtXSVFsM7mgUAyleAZIuRb4Qh8I5cjFKoCv7Z9vouFPKQffdWeHX
 6uCg==
X-Gm-Message-State: AOAM533phfhr7GHpblU4ZhYBhhYq7NvA8pZYwr9xxhCC9Iw5yJm2kNmM
 jGs1I5PTuEhdbZdMWfwWIMTKekdQnTU=
X-Google-Smtp-Source: ABdhPJzQfuWmWG6KuZHhFNNhRI6/U2y0eiUntBmspkspNqZDpazCv9k+z5S+JVvsXvV8LYhogIlfzw==
X-Received: by 2002:a62:7b83:0:b029:1f1:5ef3:b4d9 with SMTP id
 w125-20020a627b830000b02901f15ef3b4d9mr3617710pfc.65.1616484693970; 
 Tue, 23 Mar 2021 00:31:33 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:2a1:40ef:41b6:3cf0?
 ([2601:647:4802:9070:2a1:40ef:41b6:3cf0])
 by smtp.gmail.com with ESMTPSA id w203sm15819900pff.59.2021.03.23.00.31.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Mar 2021 00:31:33 -0700 (PDT)
Subject: Re: [PATCH 2/2] nvme-multipath: don't block on blk_queue_enter of the
 underlying device
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: Chao Leng <lengchao@huawei.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20210322073726.788347-1-hch@lst.de>
 <20210322073726.788347-3-hch@lst.de>
 <34e574dc-5e80-4afe-b858-71e6ff5014d6@grimberg.me>
 <c064b296-c25c-3731-cbbd-f99ab93e6bd2@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <608f8198-8c0d-b59c-180b-51666840382d@grimberg.me>
Date: Tue, 23 Mar 2021 00:31:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <c064b296-c25c-3731-cbbd-f99ab93e6bd2@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210323_073136_130692_A2BB0198 
X-CRM114-Status: GOOD (  14.57  )
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

Cj4gQWN0dWFsbHksIEkgaGFkIGJlZW4gcGxheWluZyBhcm91bmQgd2l0aCBtYXJraW5nIHRoZSBl
bnRpcmUgYmlvIGFzIAo+ICdOT1dBSVQnOyB0aGF0IHdvdWxkIGF2b2lkIHRoZSB0YWcgc3RhbGws
IHRvbzoKPiAKPiBAQCAtMzEzLDcgKzMxNiw3IEBAIGJsa19xY190IG52bWVfbnNfaGVhZF9zdWJt
aXRfYmlvKHN0cnVjdCBiaW8gKmJpbykKPiAgwqDCoMKgwqDCoMKgwqAgbnMgPSBudm1lX2ZpbmRf
cGF0aChoZWFkKTsKPiAgwqDCoMKgwqDCoMKgwqAgaWYgKGxpa2VseShucykpIHsKPiAgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJpb19zZXRfZGV2KGJpbywgbnMtPmRpc2stPnBhcnQw
KTsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBiaW8tPmJpX29wZiB8PSBSRVFfTlZN
RV9NUEFUSDsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBiaW8tPmJpX29wZiB8PSBS
RVFfTlZNRV9NUEFUSCB8IFJFUV9OT1dBSVQ7Cj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB0cmFjZV9ibG9ja19iaW9fcmVtYXAoYmlvLCBkaXNrX2RldnQobnMtPmhlYWQtPmRpc2sp
LAo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBiaW8tPmJpX2l0ZXIuYmlfc2VjdG9yKTsKPiAgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IHN1Ym1pdF9iaW9fbm9hY2N0KGJpbyk7Cj4g
Cj4gCj4gTXkgb25seSB3b3JyeSBoZXJlIGlzIHRoYXQgd2UgbWlnaHQgaW5jdXIgc3B1cmlvdXMg
ZmFpbHVyZXMgdW5kZXIgaGlnaCAKPiBsb2FkOyBidXQgdGhlbiB0aGlzIGlzIG5vdCBuZWNlc3Nh
cmlseSBhIGJhZCB0aGluZy4KCldoYXQ/IG1ha2luZyBzcHVyaW91cyBmYWlsdXJlcyBpcyBub3Qg
b2sgdW5kZXIgYW55IGxvYWQuIHdoYXQgZnMgd2lsbAp0YWtlIGludG8gYWNjb3VudCB0aGF0IHlv
dSBtYXkgaGF2ZSBydW4gb3V0IG9mIHRhZ3M/CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1udm1lCg==
