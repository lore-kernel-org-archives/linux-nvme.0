Return-Path: <SRS0=yzsN=CB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219ABC433E1
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Aug 2020 15:20:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D970A20706
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Aug 2020 15:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CjOJI5Iu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FrIhxIjF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D970A20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=08goTsbXnWMoz8LNMwC88llMAZ9xDM5gouq8ZDK5P0M=; b=CjOJI5Iu9+1PjyIQBcVCyYEY6
	woWjwiIy9DdyV5VRs8fmGB5crs9qNr2FOcEmeAQC7qZ51Y63gjqL2pY/yJEx+EAru/LwtfxFpZv8J
	Kfud+iMyjMAPvydutimjAhWCWGwTTNOB94K6zFgc3FgHDYeaZpagWfH+L3zV9x4+dBuBShC0M2CyJ
	EDKcTJHcPvkYn2v5abZOOknQnjq2441MP6wW1RpV0XJCv8uoP8TWbjKxcY5/vpEfLkeIH1A0W4ATl
	/UEguymtB6lBMQoX8Ot2vhqYqBYnkJhCzFOErO9H9T1jix8ursbAZBPjfweCKZ+YldZlFuAtf9NAF
	3YjlWU1cg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k9rmr-0001HV-HF; Sun, 23 Aug 2020 15:20:01 +0000
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k9rmn-0001H2-CZ
 for linux-nvme@lists.infradead.org; Sun, 23 Aug 2020 15:19:59 +0000
Received: by mail-pj1-x1041.google.com with SMTP id nv17so2911910pjb.3
 for <linux-nvme@lists.infradead.org>; Sun, 23 Aug 2020 08:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=h44O92V5ZTwKyXoQSch7YSQFa9Zg+E8PzaRUuNBM3aU=;
 b=FrIhxIjFGMRPvHKTWN+M9/RqkqeTCIe3iu63aCcXqQ282EODfpRGPEGotHAORpInv2
 JAmXyKyJdpF8PSVnY67PRPVeBZJaBawVDhQi6gLKIXWafGoI4+cCgxiMwN/E47ZuJNxD
 yNA1R4G5uKOTRTKXTZRH7Zl1LK++UUsmQeh5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=h44O92V5ZTwKyXoQSch7YSQFa9Zg+E8PzaRUuNBM3aU=;
 b=Uisv51Bvg98140YtPieJ2/afjc2H3SoMX+muiN/mk5+rEjS/SrtgWpsRCT5wRmHNAR
 V0X/pDtcNamufBcQQ7SLwzMzpYkiehJYrdxCXfM7PpY3OP0AStiZDsGKn40T9YnrIjx4
 zdspZtch5a2dlOcyuEMWvdtPhpQjdeEKCCOGhW7JcqfY6Qf1+XU5TUuncqqV8xm29zoe
 fr8YVDz0S3t/Jafk2Jv+QF/A5ilbWxH5TDtHGvn9iPdf8fXO6XzVKf30QHulvgHi+NQB
 cGK2HSoe4Owu7tmm2J8OtWM3+GpBRXto9Y2r2Egp0/QBkLf5JgYeP7kr/BzuM7FXnZmY
 1eqQ==
X-Gm-Message-State: AOAM532ab/DrelfayK2cB1grHkixYbHF4Srbuknz7UHQbMA120WioYdu
 nx89zQ4wTyKO6GY/xy8WnGshmTyq9FfzA6RAbo5YUH+s6hgoKrN47xHhpHUu9ppLm5j5TNi2TxM
 7vopMNFEEi7xfAK78W0qonE8WMdKdkyiiUnW84O/dFzrpmRNJPUtZ0mB/fycL8TJUdelgutHN3y
 O4D8SPVWZg
X-Google-Smtp-Source: ABdhPJy5yLYKVpUNtDW5bAPhQAQxtXEG8z/R2kA8vsSDKKp3ugx55kRS7+zzVlUTjNFxIrROVCmRVQ==
X-Received: by 2002:a17:90a:9c3:: with SMTP id
 61mr1390798pjo.191.1598195991632; 
 Sun, 23 Aug 2020 08:19:51 -0700 (PDT)
Received: from [192.168.1.42] (ip68-5-85-189.oc.oc.cox.net. [68.5.85.189])
 by smtp.gmail.com with ESMTPSA id c20sm6931590pjv.31.2020.08.23.08.19.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Aug 2020 08:19:50 -0700 (PDT)
Subject: Re: [PATCH v3 2/9] nvme-fabrics: allow to queue requests for live
 queues
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
References: <20200820053651.197057-1-sagi@grimberg.me>
 <20200820053651.197057-3-sagi@grimberg.me> <20200820060941.GB6188@lst.de>
 <813bbd6c-3353-2c40-da48-bdbbdf89690c@grimberg.me>
 <bdd4f4b8-be68-2edc-5378-32c97eb3f1ae@broadcom.com>
 <20200821062217.GC28559@lst.de>
 <43d6ca66-0a42-0aff-ef22-8b3c08cf3bde@grimberg.me>
From: James Smart <james.smart@broadcom.com>
Message-ID: <6540c183-9b93-1635-a3dd-c925bb94c47a@broadcom.com>
Date: Sun, 23 Aug 2020 08:19:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <43d6ca66-0a42-0aff-ef22-8b3c08cf3bde@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200823_111957_834537_05A83708 
X-CRM114-Status: GOOD (  17.81  )
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

CgpPbiA4LzIxLzIwMjAgMTI6NDQgUE0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4KPj4+IEkgc3Rp
bGwgZGlzbGlrZSBhbnkgcmFuZG9tIGlvY3RscyBjb21pbmcgaW4gd2hpbGUgd2UncmUgc3RpbGwg
Cj4+PiBpbml0aWFsaXppbmcKPj4+IHRoZSBjb250cm9sbGVyLgo+Pgo+PiBBZ3JlZWQuCj4+Cj4+
PiDCoMKgIExvb2tpbmcgYXQgdGhlIGZsb3cgLSBJIHdvdWxkbid0IHdhbnQgdGhlbSB0byBiZSBh
bGxvd2VkCj4+PiB1bnRpbCBhZnRlciBudm1lX2luaXRfaWRlbnRpZnkoKSBpcyBjb21wbGV0ZS4g
RXNwZWNpYWxseSBpZiB0aGUgCj4+PiBpb2N0bHMgYXJlCj4+PiBkb2luZyBzdWJzeXN0ZW0gb3Ig
Y29udHJvbGxlciBkdW1waW5nIG9yIHVzaW5nIGNvbW1hbmRzIHRoYXQgc2hvdWxkIGJlCj4+PiBj
YXBwZWQgYnkgdmFsdWVzIHNldCBieSBudm1lX3F1ZXVlX2xpbWl0cygpLsKgwqAgQnV0LCBpZiB3
ZSdyZSBnb2luZyB0bwo+Pj4gYWxsb3cgbnZtZV9pbml0X2lkZW50aWZ5IHRoZSBhZG1pbl9xIG5l
ZWRzIHRvIGJlIHVucXVpZXNjZWQuCj4+Pgo+Pj4gU28gSSdtIHN0aWxsIHZvdGluZyBmb3IgdGhl
IGFkbWluIHF1ZXVlIGV4Y2VwdGlvbi4KPj4KPj4gQW5kIEkgcmVhbGx5IGRvbid0IGxpa2UgdGhl
IGFkbWluIHF1ZXVlIHNwZWNpYWwgY2FzZS7CoCBXaGF0IGlzIHRoZQo+PiBhZHZhbnRhZ2Ugb2Yg
bGV0dGluZyB1c2VyIHNwYWNlIHBhc3N0aHJvdWdoIEkvTyBjb21tYW5kcyBpbiBhdCB0aGlzCj4+
IHBvaW50IGluIHRpbWU/Cj4KPiBXZSBuZWVkIHRvIHBhc3MgaW4gbm9ybWFsIEkvTyBjb21tYW5k
cyBmb3Igc3VyZSBpbiBvcmRlciB0byBoYXZlIGEKPiByb2J1c3QgcmVzZXQgYW5kIGVycm9yIHJl
Y292ZXJ5ICh3aGF0IGluIGdlbmVyYWwgdGhlIHBhdGNoc2V0Cj4gYWRkcmVzc2VzKS4gV2hhdCBp
cyB0aGUgZGlmZmVyZW5jZSBiZXR3ZWVuIEZTIEkvTyBjb21tYW5kcyBhbmQKPiBwYXNzdGhydSBJ
L08gY29tbWFuZHM/IEluIGZhY3QsIHVzZXIgcGFzc3RocnUgSS9PIGNvbW1hbmRzIHdpbGwgbmV2
ZXIKPiBleGVjdXRlIGJlZm9yZSBudm1lX2luaXRfaWRlbnRpZnkoKSBiZWNhdXNlIHdlIGFsd2F5
cyBzdGFydAo+IHRoZSBJL08gcXVldWVzIGFmdGVyIHRoYXQuCj4KPiBMZXQncyBsb29rIGF0IHBj
aSwgZG8gd2UgaGF2ZSB0aGUgc2FtZSBlbmZvcmNlbWVudCBmb3IgcGFzc3RocnUKPiBjb21tYW5k
cz8gV2hhdCdzIHNwZWNpYWwgYWJvdXQgZmFicmljcyB0aGF0IHdlIG5lZWQgdG8gZGVueQo+IHRo
ZXNlIGNvbW1hbmRzIGZyb20gZ29pbmcgdGhyb3VnaD8KCnNob3J0IGFuc3dlciAtIHRpbWluZy9s
YXRlbmN5IGFuZCBtdWNoIG11Y2ggbG93ZXIgY2hhbmNlIG9mIGZhaWx1cmUuCgpJIGFsc28gZG9u
J3QgdGhpbmsgcGVvcGxlIGFyZSBxdWVyeWluZyBwY2kgKGxvY2FsIGF0dGFjaGVkIGRyaXZlcnMp
IGxpa2UgCnRoZXkgYXJlIGZhYnJpYyBhdHRhY2htZW50cy4KCi0tIGphbWVzCgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5n
IGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
