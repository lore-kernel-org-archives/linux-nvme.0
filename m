Return-Path: <SRS0=5twQ=XA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BA1C43331
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2019 16:01:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A5872053B
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2019 16:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eId07fPZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="b8ADuien"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A5872053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=q6aSeJS+RsLPO+erQzCYw004eUklQet66qi3FxsYHdk=; b=eId07fPZ9zf2aNWMa505jT2lQ
	X9HHcvQKCRvZvFZ0APwr2sr2cyVP6J6uK3WzS3AAVTVLWs2VVmhj/hLp5SPwQP/np7HDyAIOOQkU5
	+0FBp37KLUcW+Fk/aZWGz14psZOCHFHR4TRjST+zb8T4qHQhTskk0Dx4NJdmZHuhcSE9ZbU9KMonV
	Qx+BvgKWP3C65MNQicrpLT47p8cePRR0wDt4zRhkPRQG5DI0tWlqeCtlcngkGtGlFFjw6YlSxof3a
	6hGOmUYfUy0mu04z+8L2LLYweJyuGlEKoD9re+rtiaSPsP9AYFCPT85Cwl84woXSb8RCbtdxW4kxn
	frJckjNuw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5uBw-0003Ve-3P; Thu, 05 Sep 2019 16:01:00 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5uBt-0003VC-Jr
 for linux-nvme@lists.infradead.org; Thu, 05 Sep 2019 16:00:58 +0000
Received: by mail-pf1-x444.google.com with SMTP id w22so2030720pfi.9
 for <linux-nvme@lists.infradead.org>; Thu, 05 Sep 2019 09:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=MBBfvDGPyIu6Ij9B0xA/ziK4t6rhTQbj5rbn+KZHqk8=;
 b=b8ADuien1/+o6c7gdvZ5eHWB9rkyHFZeDJrnUQyVGHGP1Yb1pRWArXTP4yk6Ybezgu
 QRc9L98AW/v5TtbNG0noca2BLjy01EpCJi/mUqkJxQeUcDpk5McoBR4xp7x3RAZODcIV
 0XQj3DtzJ8HwpSztCplDNNHkuIBTNPq3QQx0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=MBBfvDGPyIu6Ij9B0xA/ziK4t6rhTQbj5rbn+KZHqk8=;
 b=RKdP8j7DTwU2Tgyp14yQNcEz8yMDIKTkIPalwH0BxXL68rqa348NIH9sXpkRfp3xg/
 pQnINNpieXeUpZ8AcFR9g46hIO8Zbd+Q+jXMV7RhkiRQUlQh5JFDoEx6X3jgKi/lqZbp
 fujiL86kKGwIloXav1rEx2juv3Tmr8t2Tmr/k82cUnLPN5CmtFhacuPRWv6kjbGvWbi6
 IUxpzGfAHy7KBKqW+LuzkXFqrjDFmSqa839FKWBnK2Djsfon9705CgZEVZ9+cbueDsk8
 goi31+FpyoZ06mznpewUgLSGC2U30JToscWni43ASbsfi5KFpgqsxf3O3AmSE48+HjCn
 xnHw==
X-Gm-Message-State: APjAAAWqK+b2IqrXTXw76uBNu1UcuCCxd7IDyxwgljjtaQ9haW6efG0C
 hvwoTrrNLbHEPH/Ywi9BeE5Mbg==
X-Google-Smtp-Source: APXvYqwhoIM/2/AC8r4+O7jqQvnBYT7qQrZUYPtnQQUfOR2gkzvc5T7QiZaGF9NYYi/OGV8etsA4lQ==
X-Received: by 2002:a62:1b0c:: with SMTP id b12mr4687760pfb.17.1567699257192; 
 Thu, 05 Sep 2019 09:00:57 -0700 (PDT)
Received: from [10.69.45.46] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id 15sm4329666pfh.188.2019.09.05.09.00.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 05 Sep 2019 09:00:56 -0700 (PDT)
Subject: Re: [PATCH v4 3/4] nvme: add uevent variables for controller devices
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20190904215954.15423-1-sagi@grimberg.me>
 <20190904215954.15423-4-sagi@grimberg.me>
 <b0e3f456-4071-abb8-5af9-26354c1a5356@broadcom.com>
 <1c073c6f-468f-a3d5-8990-99774779011f@grimberg.me>
From: James Smart <james.smart@broadcom.com>
Message-ID: <9edbf220-d9b1-0431-d22f-9909ebde187a@broadcom.com>
Date: Thu, 5 Sep 2019 09:00:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1c073c6f-468f-a3d5-8990-99774779011f@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190905_090057_654093_B1373435 
X-CRM114-Status: GOOD (  12.56  )
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
Cc: Keith Busch <keith.busch@intel.com>, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@suse.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gOS80LzIwMTkgNToxOCBQTSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPgo+Pj4gwqAgc3RhdGlj
IHZvaWQgbnZtZV9hZW5fdWV2ZW50KHN0cnVjdCBudm1lX2N0cmwgKmN0cmwpCj4+PiDCoCB7Cj4+
PiDCoMKgwqDCoMKgIGNoYXIgKmVudnBbMl0gPSB7IE5VTEwsIE5VTEwgfTsKPj4+IEBAIC00MDYz
LDYgKzQwOTAsNyBAQCBzdGF0aWMgaW50IF9faW5pdCBudm1lX2NvcmVfaW5pdCh2b2lkKQo+Pj4g
wqDCoMKgwqDCoMKgwqDCoMKgIHJlc3VsdCA9IFBUUl9FUlIobnZtZV9jbGFzcyk7Cj4+PiDCoMKg
wqDCoMKgwqDCoMKgwqAgZ290byB1bnJlZ2lzdGVyX2NocmRldjsKPj4+IMKgwqDCoMKgwqAgfQo+
Pj4gK8KgwqDCoCBudm1lX2NsYXNzLT5kZXZfdWV2ZW50ID0gbnZtZV9jbGFzc191ZXZlbnQsCj4+
Cj4+IENvbW1hIGF0IGVuZCBvZiBsaW5lID8KPgo+IEhtbSwgc3RpbGwgdmFsaWQgSSBndWVzcy4K
Pgo+IEkgY2FuIGZpeCBpdCB1cCwgSSdsbCB3YWl0IGZvciBzb21lIG1vcmUgZmVlZGJhY2sgZmly
c3QuLi4KCk92ZXJhbGwsIGl0IGxvb2tlZCBnb29kIHRvIG1lLgoKUmV2aWV3ZWQtYnk6IEphbWVz
IFNtYXJ0IDxqYW1lcy5zbWFydEBicm9hZGNvbS5jb20+CgotLSBqYW1lcwoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxp
c3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
