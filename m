Return-Path: <SRS0=Gozd=AY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5979BC433EA
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2020 17:24:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29D4A206F5
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2020 17:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s6u0S4M5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTmeCPcn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29D4A206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+vDk5SJqi2vzkUkjzLJcL6suDF87clhPlCaAQQgaTfY=; b=s6u0S4M5iRUbt9GD5uaJ1zSA2
	KlnUu/QrQswkVYTrRK5guASQQ5v4e1A3QiXf1epZymxJS5hjdA2MPbdynYC/hEAn9gvNpNOO6DfM6
	4KGGAwnBK7dtiiuwfXZ/KivunQGz2T3ngMCzC/bgrh0OH/kYLg4l6ny2ieITu+PaCSvZosam0C7ac
	ZLK6RBFVSOdDqNPVcSj1Xjt3yo78KsW8ddniDhaJYe18nHbbAhl/jOW+88aKufy2SZWPyTFZh9xLT
	MY4XLVLA0pXmMzNKNcTRCRLvVg/B3j/Xn3/WWtWULtAFPGXyU+s1+zRjZ4v+JCsz3Ebxe6cjQaZ54
	PhLiKyGpw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jv2BW-000815-G4; Mon, 13 Jul 2020 17:24:10 +0000
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jv2BT-0007zj-SN
 for linux-nvme@lists.infradead.org; Mon, 13 Jul 2020 17:24:08 +0000
Received: by mail-ed1-x542.google.com with SMTP id d18so14368701edv.6
 for <linux-nvme@lists.infradead.org>; Mon, 13 Jul 2020 10:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=e0LSuR+yshIoYGz+eEEY3hbB8A+14sBty8Ug4yMkgfM=;
 b=nTmeCPcn+ozK+Ag5RxEELeJLLx9ti8jrlnkSeGn+v7o9o0VF9oqTW9mzAjEAFJQnWc
 qy5WrcnWfHjIf32n1rZMIh7sjY+87PmkNyonBFjkMmm/slYoFKySiIDO6+eFTW7DyjhV
 dcAIkLxDSgKq8n2k3M6w/g/AfcEEasZ0+ubo5y3FP86jcAmIC3Bp4bSbEpCr+H2fGieA
 cWR5TAwnj5PuzxwIQ+aw+2sXxWXcbl3OLOr7p1EQo/nTFJ+CtkPPFFCWRh9nn7Mgar9C
 QL2BtaG9MVgA1PHr+APD1CbIGDru+t9rECcfdiYNqx3sePEn6oCyMM3NaVw/Kh7k8nKA
 G6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=e0LSuR+yshIoYGz+eEEY3hbB8A+14sBty8Ug4yMkgfM=;
 b=Yi7pOEZUBDNXS/Q0pHauCYeAUPRCqUPqomnyLV/JiZ15V2adeRKi2TwV57qzY5VU7B
 AR/3k9D+gEbvvnM/nFTzL0dhSivnI4Y2cD2awIgsFsy/jb2TKYGiSKDxO7WtZu37IEMq
 FHK40FfZPflH1S0oH960N0wB3WteCDWADrYaCMMg8ZUbSKXHpuQKEOgKQcqhV5TzqxyF
 fjUrlIiFLtyzlvnRSYuz/vvEGPVAKnfDlri1I9KvRFV231Kv1OACSwFcxuNrUYtYvW1H
 APRydvyCcmQ4sDC3M1+CDry3nnXU8BEqcVrXQfLfcYCJHq5O8okBQK9F/QLNQHa6Yav1
 A2Jw==
X-Gm-Message-State: AOAM533ag8Wjf9N9cuFZ78+iav9o9t4DItVHmlG9tJn+ixiu8DrhHMzR
 2u5pPM/Z2uUk+Fzyq1uFW/E=
X-Google-Smtp-Source: ABdhPJwU6CC1g8gnvm6vkaI0vzF7ML92p+FtcVVEx2//52B6Q3pLKNShFOHB6NyG1tBi9qTBjIHGwg==
X-Received: by 2002:a05:6402:c82:: with SMTP id
 cm2mr441209edb.293.1594661046520; 
 Mon, 13 Jul 2020 10:24:06 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
 by smtp.gmail.com with ESMTPSA id t25sm10192694ejc.34.2020.07.13.10.24.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2020 10:24:05 -0700 (PDT)
Subject: Re: [RFC PATCH 09/35] nvme-pci: Change PCIBIOS_SUCCESSFUL to 0
To: "Rajashekar, Revanth" <revanth.rajashekar@intel.com>, helgaas@kernel.org, 
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
References: <20200713122247.10985-1-refactormyself@gmail.com>
 <20200713122247.10985-10-refactormyself@gmail.com>
 <0762f646-90a1-217c-4e4b-6168d85bb08a@intel.com>
From: Saheed Bolarinwa <refactormyself@gmail.com>
Message-ID: <f48dece5-7483-73ac-38bb-0dce323f404c@gmail.com>
Date: Mon, 13 Jul 2020 20:24:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <0762f646-90a1-217c-4e4b-6168d85bb08a@intel.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200713_132407_927481_A330417F 
X-CRM114-Status: GOOD (  18.03  )
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
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, skhan@linuxfoundation.org, bjorn@helgaas.com,
 linux-kernel-mentees@lists.linuxfoundation.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ck9uIDcvMTMvMjAgNjo0MiBQTSwgUmFqYXNoZWthciwgUmV2YW50aCB3cm90ZToKPiBIaSwKPgo+
IE9uIDcvMTMvMjAyMCA2OjIyIEFNLCBTYWhlZWQgTy4gQm9sYXJpbndhIHdyb3RlOgo+PiBJbiBy
ZWZlcmVuY2UgdG8gdGhlIFBDSSBzcGVjIChDaGFwdGVyIDIpLCBQQ0lCSU9TKiBpcyBhbiB4ODYg
Y29uY2VwdC4KPj4gVGhlaXIgc2NvcGUgc2hvdWxkIGJlIGxpbWl0ZWQgd2l0aGluIGFyY2gveDg2
Lgo+Pgo+PiBDaGFuZ2UgYWxsIFBDSUJJT1NfU1VDQ0VTU0ZVTCB0byAwCj4+Cj4+IFNpZ25lZC1v
ZmYtYnk6ICJTYWhlZWQgTy4gQm9sYXJpbndhIiA8cmVmYWN0b3JteXNlbGZAZ21haWwuY29tPgo+
PiAtLS0KPj4gICBkcml2ZXJzL252bWUvaG9zdC9wY2kuYyB8IDIgKy0KPj4gICAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbnZtZS9ob3N0L3BjaS5jIGIvZHJpdmVycy9udm1lL2hvc3QvcGNpLmMKPj4gaW5kZXgg
YjFkMThmMDYzM2M3Li5kNDI2ZWZiNTNmNDQgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvbnZtZS9o
b3N0L3BjaS5jCj4+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L3BjaS5jCj4+IEBAIC0xMTg1LDcg
KzExODUsNyBAQCBzdGF0aWMgdm9pZCBudm1lX3dhcm5fcmVzZXQoc3RydWN0IG52bWVfZGV2ICpk
ZXYsIHUzMiBjc3RzKQo+PiAgIAo+PiAgIAlyZXN1bHQgPSBwY2lfcmVhZF9jb25maWdfd29yZCh0
b19wY2lfZGV2KGRldi0+ZGV2KSwgUENJX1NUQVRVUywKPj4gICAJCQkJICAgICAgJnBjaV9zdGF0
dXMpOwo+PiAtCWlmIChyZXN1bHQgPT0gUENJQklPU19TVUNDRVNTRlVMKQo+PiArCWlmIChyZXN1
bHQgPT0gMCkKPiBIb3cgYWJvdXQgc2ltcGxpZnlpbmcgdGhlIGNoZWNrIHRvIGlmICghcmVzdWx0
KT8KClRoYW5rIHlvdSBmb3IgdGhlIHJldmlldy7CoCBJIGRpZCBpbiBQQVRDSCAxMC8zNS4gSSB3
aWxsIG1lcmdlIGJvdGguCgpJIHdhbnRlZCB0byBzZXBhcmF0ZSB0aGUgZ29hbCBmcm9tIHRoZSBm
aXggYnV0IEkgc2VlIGl0J3MgY29uZnVzaW5nLgoKLSBTYWhlZWQKCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApM
aW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
