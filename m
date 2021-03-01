Return-Path: <SRS0=Uoxm=H7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F88C433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Mar 2021 19:08:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EDB364DE7
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Mar 2021 19:08:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EDB364DE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0YdFDC35d8vhTT44EqmatsD2MOYbX9d+2VihBpu328s=; b=iGOCYZWbMmWyJtRLz4CXwDUV0
	zXIkfDjsd9fOyVxSQHgXOF+oNjXfznrpa3YVyITG5xLQUdsZWp47lNEaxy/BDLUUoIf6Fn7k5V6oy
	dO11xHHOrrIEQXoCoO6y3lddqfMzRRFyT9eLrtA2idH+sz8Uk8ujrYB1uo/Dp+CL9Rnq5iSTFGE/o
	s73eaJCl8s1nUaUZdkUDmy8sras5pQNW4fU/EnlxhzAEXsMuiddEYGWSOIrBM339zWC4WM94jgzlp
	mb9YQQcCArePT4EfubGRn0uGtOMaQ4XRA7U8SSCtbS4on/Hb8g4dMLvOd8n3EetUrH9klSHqAOp+p
	8jZH/AaLg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lGntX-000266-HG; Mon, 01 Mar 2021 19:07:51 +0000
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lGntV-00024x-4a
 for linux-nvme@lists.infradead.org; Mon, 01 Mar 2021 19:07:49 +0000
Received: by mail-pg1-x534.google.com with SMTP id o38so12195338pgm.9
 for <linux-nvme@lists.infradead.org>; Mon, 01 Mar 2021 11:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=TAWEGg7bIMJDflNWL0w3yf0qKrDge1TeIH2F4MT40uQ=;
 b=jVSXONdSGw2NBb0UDwt+xScmCDKol0NmQAyp4Ibx1a/6eXZpez2zN9XOHFD9ucySB5
 HrnWL3p0+1a2S1aGMXfsVeDyLCApRvz0B9mr6CAMAtW6wjxtCPQ3kCgy1JYDXdXDok+h
 RXVhx2/f8Z6IQBMvkkitz+gOXsGbioDoN7xvDR35utgW/wQIYARq0LejRGNCH8QLmloO
 RsCvoI9oB1JctkH1rCDiJj1MewyeoZRcAcRxn7OjTCmCJwGmKJvLnhwYQoM/3ddKec/d
 U/0iSd/j/eMA+rTUkrCsseXwEh0lvaG0G9m9UomYElOIJ8i84v4MFhYq0NAjU9U97m5Z
 5mKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=TAWEGg7bIMJDflNWL0w3yf0qKrDge1TeIH2F4MT40uQ=;
 b=XmwNQpSAn9qh1VYbDn039sM3VMzlZMLUN8nzEvr/aCsCqO0cugJat66bXQj/xftFxp
 lnNwfwnW6ou7xvsArk8QyQDl72CML5NPQNzsBOPVsdC7MtPFn0KNS1WyXkNjC1lCKBsA
 Z5Yae1C6OSzH/Cl+hdGeconr/h+mWlX4wQixmx9eYrPGYoM8v9+oyC/z68MjeGyy9dVY
 4yicsyQjFrGknHFpFjJEesGqqXarUL1JK40651zKOekl+f27wslBfKEk8Em5B00Ps7XC
 40kf6plDkDbuMufmNjWtVAgCObZXDIbWI7J+S9oxUgnJ5XMs7SSnSvUqZSZ7gucPQsr4
 UEJg==
X-Gm-Message-State: AOAM530zuU4almYNirKDlcvQ72UGn8+9PDTCwuGMQ9Kp+P+tysBfLUNm
 V4FyZIMOOTCsfytchXYfB50=
X-Google-Smtp-Source: ABdhPJz7x4wF/88CcBvPvA00+RjowU1MPgY+08uycZY2kO8dUARRaNj84VgbG+DlX1uZYpZ+unuFXg==
X-Received: by 2002:a05:6a00:148c:b029:1eb:aa7d:b1b4 with SMTP id
 v12-20020a056a00148cb02901ebaa7db1b4mr13893pfu.8.1614625665032; 
 Mon, 01 Mar 2021 11:07:45 -0800 (PST)
Received: from [10.69.69.102] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id l74sm17807299pga.86.2021.03.01.11.07.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Mar 2021 11:07:44 -0800 (PST)
Subject: Re: [PATCH 4/4] nvme-fc: return NVME_SC_HOST_ABORTED_CMD when a
 command has been aborted
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
References: <20210226071728.106923-1-hare@suse.de>
 <20210226071728.106923-5-hare@suse.de>
From: James Smart <jsmart2021@gmail.com>
Message-ID: <0611f10e-fb76-faad-caa8-a069ae415ffa@gmail.com>
Date: Mon, 1 Mar 2021 11:07:43 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210226071728.106923-5-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210301_140749_232883_AAB49269 
X-CRM114-Status: GOOD (  19.37  )
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
Cc: linux-nvme@lists.infradead.org, Daniel Wagner <dwagner@suse.de>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMi8yNS8yMDIxIDExOjE3IFBNLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4gV2hlbiBhIGNv
bW1hbmQgaGFzIGJlZW4gYWJvcnRlZCB3ZSBzaG91bGQgcmV0dXJuIE5WTUVfU0NfSE9TVF9BQk9S
VEVEX0NNRAo+IHRvIGJlIGNvbnNpc3RlbnQgd2l0aCB0aGUgb3RoZXIgdHJhbnNwb3J0cy4KPgo+
IENjOiBKYW1lcyBTbWFydCA8amFtZXMuc21hcnRAYnJvYWRjb20uY29tPgo+IFNpZ25lZC1vZmYt
Ynk6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPgo+IFJldmlld2VkLWJ5OiBEYW5pZWwg
V2FnbmVyIDxkd2FnbmVyQHN1c2UuZGU+Cj4gLS0tCj4gICBkcml2ZXJzL252bWUvaG9zdC9mYy5j
IHwgMiArLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
Cj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvZmMuYyBiL2RyaXZlcnMvbnZtZS9o
b3N0L2ZjLmMKPiBpbmRleCBlZjEyYTYxOWRhZWMuLjk3ZTM0MjRjN2IwMyAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL252bWUvaG9zdC9mYy5jCj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvZmMuYwo+
IEBAIC0xOTU2LDcgKzE5NTYsNyBAQCBudm1lX2ZjX2ZjcGlvX2RvbmUoc3RydWN0IG52bWVmY19m
Y3BfcmVxICpyZXEpCj4gICAJCQkJc2l6ZW9mKG9wLT5yc3BfaXUpLCBETUFfRlJPTV9ERVZJQ0Up
Owo+ICAgCj4gICAJaWYgKG9wc3RhdGUgPT0gRkNQT1BfU1RBVEVfQUJPUlRFRCkKPiAtCQlzdGF0
dXMgPSBjcHVfdG9fbGUxNihOVk1FX1NDX0hPU1RfUEFUSF9FUlJPUiA8PCAxKTsKPiArCQlzdGF0
dXMgPSBjcHVfdG9fbGUxNihOVk1FX1NDX0hPU1RfQUJPUlRFRF9DTUQgPDwgMSk7Cj4gICAJZWxz
ZSBpZiAoZnJlcS0+c3RhdHVzKSB7Cj4gICAJCXN0YXR1cyA9IGNwdV90b19sZTE2KE5WTUVfU0Nf
SE9TVF9QQVRIX0VSUk9SIDw8IDEpOwo+ICAgCQlkZXZfaW5mbyhjdHJsLT5jdHJsLmRldmljZSwK
CklzIHRoZXJlIGEgZGlmZmVyZW5jZSBiZXR3ZWVuIGFuIEkvTyBhYm9ydGVkIGJ5IGEgTlZNRSBB
Qk9SVCBjbWQgdnMgYSAKdHJhbnNwb3J0LWNhbmNlbGxlZCBpbyA/wqDCoCBUaGlzIGxpbmUgaXMg
bW9yZSB0aGUgdHJhbnNwb3J0LWNhbmNlbGxlZCBpby4KCi0tIGphbWVzCgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxp
c3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
