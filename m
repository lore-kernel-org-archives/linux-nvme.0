Return-Path: <SRS0=3eeX=FV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B410C4361B
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Dec 2020 13:30:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AD0D22E02
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Dec 2020 13:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AD0D22E02
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=J3ZnUS2dpJTUiMMxYb6+Nx70VFg1C/vWQppRUuXQ8fo=; b=mCeCKqt4FFIVmLmrsYP/YR1UZ
	okRiR84AC0WwYWONY2OCGr1/RPhhpLdOEHCqTaGAI9RwljxcL3CLUpcKJA/sf3jkCo17AFmqclilO
	TeO4zKexIy8yaPZW2XGTo/7Jo8e4+3Jnqir0CMociIdksdZh3PldkzoGsk6OpIDo5IuDaQ5WLonr8
	RjHTRuvbeWz26b95RMmlk9LuUSQii7+8NvISmVVidKrdgT821DmxT9SY9d6EWZLHdYP9OkX/JNPSJ
	O44Akl5HYqiOnbMkmPt4p+KZahMmUNY8ZqUhxyojHkW87r7OeMoIy6vPXXe4TOWSiKg4any6WE1Mz
	6V2iL4kIg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kptM7-0001zQ-Oo; Thu, 17 Dec 2020 13:30:07 +0000
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kptLi-0001ym-M0
 for linux-nvme@lists.infradead.org; Thu, 17 Dec 2020 13:29:43 +0000
Received: by mail-ed1-x52f.google.com with SMTP id j16so6195876edr.0
 for <linux-nvme@lists.infradead.org>; Thu, 17 Dec 2020 05:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=1BSY6kpvRH25aR6tgxXyew31N03tNmdGM4l7dDerG+8=;
 b=Ui2GhRBdHoQLhgzq3LaQMwyNM1FnyxlYOHoIV6Cz4vUequOcYmrsbCUWk1SLbJc6wt
 qyOyT8OXH8JYRpzF82Yh98yS9xSKQzNRqUP/kDoBLwTYPqONnh6ARLxxgWYCDZxmq8DM
 gU9QWFhqWmJdGPNmSdliiukFBHxcLGiZkUkys/TJx5LLMBBITYIHIfe+E4yB6gdmniNd
 dEtr2n7gH/7Bg0cyujXy/x6BkY2l2kVJE6PlpjhPRjEUrVXkETVebRMwCGtb7ujIh67i
 c+jyc9QaQaV/l9PGEGiAJn4bKpZMtClzf32X//G3cmD9CAzfFlTB8HizIdm2P9nPwmlI
 yGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=1BSY6kpvRH25aR6tgxXyew31N03tNmdGM4l7dDerG+8=;
 b=moyED+CFg2eozy0Ylkw35ACmRhf8BhIPKSpzZTbfbdacWNjR0y571Ka/UGBv7vC9wz
 AAxHJSxlDOdPi1CAHHbDR6mgzthKoRazrXRfzR7vWjoE216K8ywy1SbTcMpmvJSiTfaQ
 M/uXawrT5NilnzVFMO3saQSBKCvDRce1ZnBDsJXLmP63ojwO1VpJif38ECwu1pRVJFZF
 5agqHQNKDuIE+99+XtJ7c9MVC7T/6kNBZGiYNJynvjZ65VG1DpGCtK7QzIWRPZR6+tNQ
 q2y8iFAB8cujr12ofwwo7lIBRAb2vV/4lpfN4sNf+CYmyw0tfQEsyZvoiUMroWKSc7SY
 Mz1Q==
X-Gm-Message-State: AOAM532Cc4qoCfFuzWh8/+CTwSIJDrg9veOflsJfB1ndRxaq0pHU/OPk
 P8MQ4yd6gbOuKKTy31T1cRaSGw==
X-Google-Smtp-Source: ABdhPJxVeHu+AlfAuTrOx4tmtzB26fWL4M/0KwddBdphatLAru+U95pCunKDgeb625eQXQDR5CTNCA==
X-Received: by 2002:a50:e719:: with SMTP id a25mr1287074edn.12.1608211777885; 
 Thu, 17 Dec 2020 05:29:37 -0800 (PST)
Received: from localhost (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
 by smtp.gmail.com with ESMTPSA id l22sm3838719ejk.14.2020.12.17.05.29.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Dec 2020 05:29:36 -0800 (PST)
Date: Thu, 17 Dec 2020 14:29:36 +0100
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: nvme: enable char device per namespace
Message-ID: <20201217132936.3wvuguclzwll5kqu@unifi>
References: <20201215224607.GB3915989@dhcp-10-100-145-180.wdc.com>
 <10318EDE-F4D0-4C89-B69D-3D5ACA4308C2@javigon.com>
 <20201216162631.GA77639@dhcp-10-100-145-180.wdc.com>
 <20201216174322.v2ahfdhvgix536gd@unifi>
 <20201216175311.GA31311@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201216175311.GA31311@redsun51.ssa.fujisawa.hgst.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201217_082942_846238_50A108B4 
X-CRM114-Status: GOOD (  11.99  )
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
Cc: linux-block@vger.kernel.org, minwoo.im.dev@gmail.com, hch@lst.de,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTcuMTIuMjAyMCAwMjo1MywgS2VpdGggQnVzY2ggd3JvdGU6Cj5PbiBXZWQsIERlYyAxNiwg
MjAyMCBhdCAwNjo0MzoyMlBNICswMTAwLCBKYXZpZXIgR29uesOhbGV6IHdyb3RlOgo+PiBUaGFu
a3MgS2VpdGguIEkgd2lsbCBzZW5kIGEgbmV3IHZlcnNpb24gdG9kYXkuCj4+Cj4+IFJlZ2FyZGlu
ZyBudm1lLWNsaTogd2hhdCBhcmUgeW91ciB0aG91Z2h0cz8KPgo+SSB3YXMgdGhpbmtpbmcgd2Ug
Y291bGQgYWRkIGEgY29sdW1uIGZvciB0aGVzZSB3aXRoIHRoZSAnLS12ZXJib3NlJwo+b3B0aW9u
IGluIHRoZSBuYW1lc3BhY2Ugc2VjdGlvbi4KCk1ha2VzIHNlbnNlLiBJIHdpbGwgbG9vayBpbnRv
IGl0IC0gcHJvYmFibHkgb24gdGhlIG90aGVyIHNpZGUgb2YKQ2hyaXN0bWFzLiBTaG91bGQgZ2l2
ZSBwbGVudHkgb2YgdGltZSBzaW5jZSB0aGlzIHRpbGwgbm90IGJlIG1lcmdlZAp1bnRpbCA1LjEy
LgoKU2hvdWxkIGdpdmUgbWUgdGltZSB0byBhZGQgbXVsdGlwYXRoIGluIGEgZm9sbG93LXVwIHBh
dGNoIHRoZW4uCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
