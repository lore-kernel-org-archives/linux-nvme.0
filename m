Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B69C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 23:19:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFF8920768
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 23:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZULQmoQi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AwioA4ra"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFF8920768
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jWh7lAoyKbAiDh5BJUkkwaMC9vJZgbaWMRj5rVKsPlQ=; b=ZULQmoQitSfgC47Vo7lmU6+Vl
	1I4W/Im3Jviz+VWfMUDJ26wIxJf9kiZwKs/MA9+TyQ5gJXFOmEpAWxFp1djowKszDElBnnLgQCKZA
	u50hB3tC3Ax30KWAIzEileicpoUzuNsYBh64fKM6yQ9nrZpwNeXyXyRknfcWRJGjBHPYO4zMUCMTD
	u3qBsnF2u9NN7fWhRuiB2Pjdzmp0oJmJBu8/XDGYn9x4GQSYsLOdlV8kJXSzURK3U3XJC3vfCtMpP
	bU+3EEmOyoDxziaS4M5v6d2ghhuDsd23PvH6ec2Rr+1Sl5pF1NQ/ThcWuuXT3dgz5JCtfp0kxcbtr
	oJXMJbSZw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6iz9-0005kI-9Y; Fri, 14 Aug 2020 23:19:43 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6iz4-0005jq-TY
 for linux-nvme@lists.infradead.org; Fri, 14 Aug 2020 23:19:41 +0000
Received: by mail-pf1-x444.google.com with SMTP id m71so5286043pfd.1
 for <linux-nvme@lists.infradead.org>; Fri, 14 Aug 2020 16:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=XoSzx2tnSFwlkvdIekLGWyW9nPc6xbkPg4qF1BKEQoU=;
 b=AwioA4raOOG9BAQkX8G5wU1VvpvzC1xI3vYs+tBXAunIEnSVk8VzSKbDYN8wVJ8fFs
 qpaEGlnFVT3Ii18FTf+RzOUQs37xyXwG+WqHEE4NKiPU+2FktKmknRceWmqgZHpLJEjf
 i4rS5iwPd76WvS9rmzYuDGnOOmXjOkyZY/4S8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=XoSzx2tnSFwlkvdIekLGWyW9nPc6xbkPg4qF1BKEQoU=;
 b=IQh3PBrCRgdTHIGKMvd8l/dRUJohHjDTPYCTfoztrPksq+HbAY243JoaDeS9hxK4fb
 TP+WTWWuvSpGkY/Z/zvmN6uBPeiuAG1sdjootQcArNzUw6EFCVbQ0KQeiwBTU5i+AHnB
 GOgyEijCv6EHtLt8uXqpn3MH8uPUhbGCRTBXwhzJqzABEuvaA96EZ6WNqRYKId/yt9tX
 g4Ynyv68zCcy41jQb63yRQm2hzeIy8iPAdVFUgt+4WsqIpzf12eYwkEtcMn8BWsp0fQ8
 m8c7Ro/+bZHdpTW+cop/EsKOYQMF9rDYbMws7TTErFTTi2NwBCJuTaCfDa7Gd5LxvcAn
 FurA==
X-Gm-Message-State: AOAM531h57BVCKaqGNucxXXomGCjVgCsMttfplivsw4Fno7KDaEfk9RO
 kHqR6WbwIHQXX7eC/KPwBUQc2w==
X-Google-Smtp-Source: ABdhPJxT8NaZa9WRHcYgnYJazRmxTav22ZnkfnlmQ0YAO4PO1Ug4E761XXb5GnUK8slrzCuL8lkm0w==
X-Received: by 2002:a63:1962:: with SMTP id 34mr3133508pgz.411.1597447175013; 
 Fri, 14 Aug 2020 16:19:35 -0700 (PDT)
Received: from [10.230.26.209] ([192.19.224.250])
 by smtp.gmail.com with ESMTPSA id v10sm10326866pff.192.2020.08.14.16.19.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 16:19:34 -0700 (PDT)
Subject: Re: [PATCH v2 7/8] nvme-rdma: fix timeout handler
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
References: <20200806191127.592062-1-sagi@grimberg.me>
 <20200806191127.592062-8-sagi@grimberg.me> <20200814065230.GD1719@lst.de>
 <b42e1454-838b-6bd3-0448-97f45ee02ea5@grimberg.me>
From: James Smart <james.smart@broadcom.com>
Message-ID: <88d4cda8-798a-15bb-9c72-9a382291adfb@broadcom.com>
Date: Fri, 14 Aug 2020 16:19:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <b42e1454-838b-6bd3-0448-97f45ee02ea5@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200814_191939_147702_7CBE417E 
X-CRM114-Status: GOOD (  13.67  )
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

CgpPbiA4LzE0LzIwMjAgMTI6MTQgQU0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4KPj4+ICsrKyBi
L2RyaXZlcnMvbnZtZS9ob3N0L3JkbWEuYwo+Pj4gQEAgLTExODUsNiArMTE4NSw3IEBAIHN0YXRp
YyB2b2lkIG52bWVfcmRtYV9lcnJvcl9yZWNvdmVyeShzdHJ1Y3QgCj4+PiBudm1lX3JkbWFfY3Ry
bCAqY3RybCkKPj4+IMKgwqDCoMKgwqAgaWYgKCFudm1lX2NoYW5nZV9jdHJsX3N0YXRlKCZjdHJs
LT5jdHJsLCBOVk1FX0NUUkxfUkVTRVRUSU5HKSkKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1
cm47Cj4+PiDCoCArwqDCoMKgIGRldl93YXJuKGN0cmwtPmN0cmwuZGV2aWNlLCAic3RhcnRpbmcg
ZXJyb3IgcmVjb3ZlcnlcbiIpOwo+Pgo+PiBTaG91bGQgdGhpcyByZWFsbHkgYmUgYSB3YXJuaW5n
P8KgIEknZCB0dXJuIHRoaXMgZG93biB0byBfaW5mby4KPgo+IEkgY2FuIGRvIHRoYXQuIGJ1dCBn
aXZlbiB0aGF0IHRoaXMgaXMgYSBmaXgsIEknbGwgdG8gZG8gdGhhdAo+IGFzIGEgc2VwYXJhdGUg
cGF0Y2guCgpJJ3ZlIGZvdW5kIHRoZSBpbXBhY3RzIG9mIHRoZSBlcnJvcl9yZWNvdmVyeS9jdHJs
IHJlc2V0IG9uIGFib3J0aW5nIGlvcyAKdG8gYmUgYSBzaWduaWZpY2FudCBldmVudCwgYW5kIGFz
IGl0IHNob3VsZCBiZSBoYXBwZW5pbmcgcmFyZWx5LCBpdCB3YXMgCm11Y2ggYmV0dGVyIHRvIHB1
dCBpdCBhcyBhIHdhcm5pbmcgdGhhbiBhcyBhbiBpbmZvLgoKLS0gamFtZXMKCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcg
bGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
