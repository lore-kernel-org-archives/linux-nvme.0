Return-Path: <SRS0=NjBy=W6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84392C3A5A5
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Sep 2019 06:00:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5547021897
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Sep 2019 06:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aOju+X4N";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W+I4BGQS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5547021897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3HNh7ILxXbnPwbJCXstEKUejqCWY/VdGa3Vv8unC+XQ=; b=aOju+X4N0ABxr4
	Va3IsK/wqc3npvDeRSj0Fl+/gAEJ+OOzwwDpQPf8gjYaFdNzC3nd8MJB6GYrr5tlFYkbYLKfKjH5v
	6pHcAN+LX1GTZTkwWB6qiGpiWSdCK/AydTTKdGVbpi/fCMxki3JA0P4G2fLyvw2PflNisVu24JToh
	qMt52RJhwVDkiXSLLrdVcyu+Ao7z4J7ptTyQ5U0YTn0uYKFVcUnfDfKSZwwQMsxTYtAyunXarV9ks
	+07wbIDiKetRCQVOfi1NUUZLboxaEEMRWaRSbfAl50jvYToSWvOlxI37XV0G5PNC8r5tw9mwtJsix
	bST++bpl094M9Zgz+EmA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i51r9-0001J8-19; Tue, 03 Sep 2019 05:59:55 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i51qy-0001Ho-QB
 for linux-nvme@lists.infradead.org; Tue, 03 Sep 2019 05:59:52 +0000
Received: by mail-wm1-x343.google.com with SMTP id n10so5951919wmj.0
 for <linux-nvme@lists.infradead.org>; Mon, 02 Sep 2019 22:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5OaqEB+Ql5gF4IT+t4x18K2e31MSKyU+TcrDfGB2XmY=;
 b=W+I4BGQSPl5zJd8nLqAWtZJFxym6GP+U5i95DBK9RFxuUZor9clqPGN7K7jQInRkTJ
 DvVypeAsNtK+irkB82NXHTgGFIumu90tJxX5PRSpiGCELE0Aj5y3Bdm6rPdwEBc9mOHl
 sDWbZ029VAoUgBLZlOBBeGzPBY1zfq7h5YYb6r23OKmD+uMOsAhnHVTsUZ0gF9DqKcYm
 tE1ImxXxtwRfVZ12Ts+p8KzIyGDA02yxwAXgDzALBcLbc5JKFSFJyMhnEmgZZ/ygdlK0
 P1OqnG5e5UwmtXaZiWSLsrRQKaqJT8kcFR9AL6W7cadXKYqK9i8LUnIYSPdEmSO7D7EL
 Spiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=5OaqEB+Ql5gF4IT+t4x18K2e31MSKyU+TcrDfGB2XmY=;
 b=I2gzWp51wjJzGYb+u2LLAbT2s9G1dzlWyxqhObB6aUNqUi3a+vUbb4/7cvTi0e1bYW
 Eeg2H48d7MUaCWGp+g6ZGa/wGYkk6Z0CMgjhUd5XDsyPO8JLYLfgph0ldWrzHDaA52BK
 ZXkNcATZngCSYIgVh+cd1T2hyMrTl3ZCzEVSg9cJ3xlHki1Ho0685Rz/v9ngX4finmeB
 7aKiD0DxolZ3twABjwDpgacuuCXzgcSEPXg8yX5YStx4AHQmQln7YNtyCgML+gc8L8qg
 E0jIanZHgrbsID5GDGJG4nT8V7bwbG7ukUGcTKRogz5ku8tD39iqI1axta845mHX6jpS
 BIBA==
X-Gm-Message-State: APjAAAWRtfOQDcfCJhzajinHjdKKHAs7UqOvkQESvPXP9VM4qnaLmznA
 rssXikFQvNmxD7lMp8iZow9qAg==
X-Google-Smtp-Source: APXvYqzmHtMSLrXJLm19YRdAq9C1sPS1+c7xFg7DkLhF67LJAujDKvYA1mBgb6+2sA3zkSeZABOulg==
X-Received: by 2002:a1c:a90b:: with SMTP id s11mr18413215wme.92.1567490382139; 
 Mon, 02 Sep 2019 22:59:42 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:ca2:9689:fa5d:1fea?
 ([2a01:e34:ed2f:f020:ca2:9689:fa5d:1fea])
 by smtp.googlemail.com with ESMTPSA id f143sm8745177wme.40.2019.09.02.22.59.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 02 Sep 2019 22:59:40 -0700 (PDT)
Subject: Re: [PATCH 1/4] softirq: implement IRQ flood detection mechanism
To: Ming Lei <ming.lei@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
References: <20190827085344.30799-1-ming.lei@redhat.com>
 <20190827085344.30799-2-ming.lei@redhat.com>
 <alpine.DEB.2.21.1908271633450.1939@nanos.tec.linutronix.de>
 <20190827225827.GA5263@ming.t460p>
 <alpine.DEB.2.21.1908280104330.1939@nanos.tec.linutronix.de>
 <20190828110633.GC15524@ming.t460p>
 <alpine.DEB.2.21.1908281316230.1869@nanos.tec.linutronix.de>
 <20190828135054.GA23861@ming.t460p>
 <alpine.DEB.2.21.1908281605190.23149@nanos.tec.linutronix.de>
 <20190903033001.GB23861@ming.t460p>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <299fb6b5-d414-2e71-1dd2-9d6e34ee1c79@linaro.org>
Date: Tue, 3 Sep 2019 07:59:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190903033001.GB23861@ming.t460p>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190902_225945_531485_DB23277A 
X-CRM114-Status: GOOD (  16.11  )
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
Cc: Jens Axboe <axboe@fb.com>, Hannes Reinecke <hare@suse.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-scsi@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Long Li <longli@microsoft.com>,
 John Garry <john.garry@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org, Keith Busch <keith.busch@intel.com>,
 Ingo Molnar <mingo@redhat.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CkhpIE1pbmcgTGVpLAoKT24gMDMvMDkvMjAxOSAwNTozMCwgTWluZyBMZWkgd3JvdGU6CgpbIC4u
LiBdCgoKPj4+IDIpIGlycS90aW1pbmcgZG9lc24ndCBjb3ZlciBzb2Z0aXJxCj4+Cj4+IFRoYXQn
cyBzb2x2YWJsZSwgcmlnaHQ/Cj4gCj4gWWVhaCwgd2UgY2FuIGV4dGVuZCBpcnEvdGltaW5nLCBi
dXQgdWdseSBmb3IgaXJxL3RpbWluZywgc2luY2UgaXJxL3RpbWluZwo+IGZvY3VzZXMgb24gaGFy
ZGlycSBwcmVkaWNhdGlvbiwgYW5kIHNvZnRpcnEgaXNuJ3QgaW52b2x2ZWQgaW4gdGhhdAo+IHB1
cnBvc2UuCj4gCj4+ICAKPj4+IERhbmllbCwgY291bGQgeW91IHRha2UgYSBsb29rIGFuZCBzZWUg
aWYgaXJxIGZsb29kIGRldGVjdGlvbiBjYW4gYmUKPj4+IGltcGxlbWVudGVkIGVhc2lseSBieSBp
cnEvdGltaW5nLmM/Cj4+Cj4+IEkgYXNzdW1lIHlvdSBjYW4gdGFrZSBhIGxvb2sgYXMgd2VsbCwg
cmlnaHQ/Cj4gCj4gWWVhaCwgSSBoYXZlIGxvb2tlZCBhdCB0aGUgY29kZSBmb3IgYSB3aGlsZSwg
YnV0IEkgdGhpbmsgdGhhdCBpcnEvdGltaW5nCj4gY291bGQgYmVjb21lIGNvbXBsaWNhdGVkIHVu
bmVjZXNzYXJpbHkgZm9yIGNvdmVyaW5nIGlycSBmbG9vZCBkZXRlY3Rpb24sCj4gbWVhbnRpbWUg
aXQgaXMgbXVjaCBsZXNzIGVmZmljaWVudCBmb3IgZGV0ZWN0aW5nIElSUSBmbG9vZC4KCkluIHRo
ZSBzZXJpZXMsIHRoZXJlIGlzIG5vdGhpbmcgZGVzY3JpYmluZyByaWdvcm91c2x5IHRoZSBwcm9i
bGVtIChJIGNhbgpvbmx5IGd1ZXNzKSBhbmQgd2h5IHRoZSBwcm9wb3NlZCBzb2x1dGlvbiBzb2x2
ZXMgaXQuCgpXaGF0IGlzIHlvdXIgZGVmaW5pdGlvbiBvZiBhbiAnaXJxIGZsb29kJz8gQSBoaWdo
IGlycSBsb2FkPyBBbiBpcnEKYXJyaXZpbmcgd2hpbGUgd2UgYXJlIHByb2Nlc3NpbmcgdGhlIHBy
ZXZpb3VzIG9uZSBpbiB0aGUgYm90dG9tIGhhbHZlcz8KClRoZSBwYXRjaCAyLzQgZGVzY3JpcHRp
b24gc2F5cyAiaG93ZXZlciBJTyBjb21wbGV0aW9uIGlzIG9ubHkgZG9uZSBvbgpvbmUgb2YgdGhl
c2Ugc3VibWlzc2lvbiBDUFUgY29yZXMiLiBUaGF0IGRlc2NyaWJlcyB0aGUgYm90dGxlbmVjayBh
bmQKdGhlbiB0aGUgcGF0Y2ggc2F5cyAiQWRkIElSUUZfUkVTQ1VFX1RIUkVBRCB0byBjcmVhdGUg
b25lIGludGVycnVwdAp0aHJlYWQgaGFuZGxlciIsIHdoYXQgaXMgdGhlIHJhdGlvbmFsIGJldHdl
ZW4gdGhlIGJvdHRsZW5lY2sgKHByb2JsZW0pCmFuZCB0aGUgaXJxZl9yZXNjdWVfdGhyZWFkIChz
b2x1dGlvbik/CgpJcyBpdCByZWFsbHkgdGhlIHNvbHV0aW9uIHRvIHRyYWNrIHRoZSBpcnEgdGlt
aW5ncyB0byBkZXRlY3QgYSBmbG9vZD8KCgoKLS0gCiA8aHR0cDovL3d3dy5saW5hcm8ub3JnLz4g
TGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBTb0NzCgpGb2xsb3cg
TGluYXJvOiAgPGh0dHA6Ly93d3cuZmFjZWJvb2suY29tL3BhZ2VzL0xpbmFybz4gRmFjZWJvb2sg
fAo8aHR0cDovL3R3aXR0ZXIuY29tLyMhL2xpbmFyb29yZz4gVHdpdHRlciB8CjxodHRwOi8vd3d3
LmxpbmFyby5vcmcvbGluYXJvLWJsb2cvPiBCbG9nCgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZt
ZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtbnZtZQo=
