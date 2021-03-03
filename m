Return-Path: <SRS0=PLgZ=IB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6EEC433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 17:24:02 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ABD564EDB
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 17:24:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ABD564EDB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/v5f6je2rwC7LDUuikQhBQWraHQsjoxsJnx06EUh38A=; b=OlVzD66NKrYGdFqWJ4PS4uFU5
	NOn5X2WteuOYzd//tw3OqIcrtLQb7hTreF9wNJvwPdMxECdbJo4ePji/HkAjBRl7zZQAVQW79Dfbo
	fi5NXEEwLOSu8vYPsFWs2bqiGqFQ9ZOZW06cBgzr0lTZfKH/DsoQM9IXfaSZFaHzTVwxUpNjvaRxn
	o2O3E6SM6xfUSjFnxHBhAxo22xzxTXq/OsQk6KwUyQaV3AioYynQDN08E3fv62iEgUcXV+lPAWVMV
	enTQ/zs0700z/+abTlrWkE97VAmrt0jseZb0eoGbd8cjW4x1VSCj9AYE5TbiCS1BlCWjLZhhOgNjC
	rD/ZqwwAw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHVDl-005msf-3w; Wed, 03 Mar 2021 17:23:37 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHSud-005FKs-IW
 for linux-nvme@desiato.infradead.org; Wed, 03 Mar 2021 14:55:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=IN4csN/tIDBWFNMljb2TQOPsrzBCa+hy7W7Ri9Ms9BA=; b=WG2uajp41qBuzJkt4EUuxxgJxU
 jDKrFArJFvh5YO1ZgQkuzdg467FRxWvsdWaqlKelCw4oNt0yKK5xz1lwRa+BbvmrxofxrkaLEWA00
 RrsI3fQrCYWdyBUz2BHaa+0+G9NbwFRoOSOIn2XrpKXaZDFS7jeZFEhNnGNAlRZg9nYgQVkZXaquD
 aE+EwrgS7IxnGQu2LKTQN2q2WJKuxPW3q04S6Doy975ltdwv9P+CbZW/Op+g6QF/Kcsx3lBm/Dnpz
 J/9xRnBPt08lLN7R3xSnmWKv2aNLPuI9NZb9bJzz+bpt2eyIeMUQhKPN/BHRwSc4wtT7WnOykgZ9c
 8oxIqkfQ==;
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHOLh-0027Dl-2D
 for linux-nvme@lists.infradead.org; Wed, 03 Mar 2021 10:03:23 +0000
Received: by mail-wr1-x42c.google.com with SMTP id d11so22969063wrj.7
 for <linux-nvme@lists.infradead.org>; Wed, 03 Mar 2021 02:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=IN4csN/tIDBWFNMljb2TQOPsrzBCa+hy7W7Ri9Ms9BA=;
 b=D06W3jcaxkyfLLWehHEA1KSZybTfutUorO7qKIi0xU4FfSetGALeqbPPyvcBmlCpBe
 ckSVhm1xMsnvIa0scm5aShh8RpUNXPXCuQC+QVsFPkcqE0Z0ih+lNjKvws/bD7P2LnFu
 FzoAQ9LD5xEf/qMI/zN979rCbBr3y5RtCwlyNm5KF/aWoCWzryXkEn5rZzAH4SdPQexz
 IPq8xDkVVoUfxkDBAOUyvRci1n6QYUtqJ0nycPRvC6bozBOVnOuvaXZl99ZsFTCI7ehv
 k2az9sfTQ5Z7Bh+KKj+iw9rg9BKYPq1MwY/WFdLiIaRn9zNwukua/MLC35ZX1w6Jt4/5
 9ljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=IN4csN/tIDBWFNMljb2TQOPsrzBCa+hy7W7Ri9Ms9BA=;
 b=P5cYlHA+DyCbsaPLi5s7Bf/my7UPyOMbg6Cbwmf7A8hSa1R6wpvOIqtVW4bVxIAkpO
 FMOAzds8kBOvtwQV7iRpFquOIZ4jdVaoR+nhiwaO2EBbmyatV8kBH7zKYRaIPb+UgDOO
 C/eyGCudwI8uSqvl95iW4vjSK3HQY013rwUmRn7+EoqM/u4R5sJvWFK7jC1osJHgjteL
 EVJ/J+sx1qWVSDN3Qdf1kfji0BdqPx/y/oa+TmMc6zZxFa/Ze81V1wMV3HgJzZWUnlNG
 3UbRfamxzceN1XAB11Oqdk1MtFE3kn0zhSqIBg8biVhBM9niG2f5QtuK8ObNy3Ix9mn2
 7gpw==
X-Gm-Message-State: AOAM533SchnyobpM4zvuu4Ka5y39aPDljlemela+iq/CFDEUb8GsQQQC
 1Gqek/NIRtuzZ6IcPdFioWcLGw==
X-Google-Smtp-Source: ABdhPJzBZ8VRJHJo7828xeX1KUFyDAQHh9wAtm0lEBnQzY78Mj0gG5jMJBBqtkJDLPTI8tv+Opw0ug==
X-Received: by 2002:a5d:5043:: with SMTP id h3mr26038578wrt.120.1614765734353; 
 Wed, 03 Mar 2021 02:02:14 -0800 (PST)
Received: from localhost (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
 by smtp.gmail.com with ESMTPSA id z7sm3704954wrt.70.2021.03.03.02.02.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Mar 2021 02:02:13 -0800 (PST)
Date: Wed, 3 Mar 2021 11:02:12 +0100
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 kbusch@kernel.org, sagi@grimberg.me, minwoo.im.dev@gmail.com
Subject: Re: [PATCH V6 1/2] nvme: enable char device per namespace
Message-ID: <20210303100212.e43jgjvuomgybmy2@mpHalley.localdomain>
References: <20210301192452.16770-1-javier.gonz@samsung.com>
 <20210301192452.16770-2-javier.gonz@samsung.com>
 <20210303091022.GA12784@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210303091022.GA12784@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210303_100323_408604_2B5F8997 
X-CRM114-Status: GOOD (  20.13  )
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

T24gMDMuMDMuMjAyMSAxMDoxMCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj5PbiBNb24sIE1h
ciAwMSwgMjAyMSBhdCAwODoyNDo1MVBNICswMTAwLCBqYXZpZXJAamF2aWdvbi5jb20gd3JvdGU6
Cj4+IEZyb206IEphdmllciBHb256w6FsZXogPGphdmllci5nb256QHNhbXN1bmcuY29tPgo+Pgo+
PiBDcmVhdGUgYSBjaGFyIGRldmljZSBwZXIgTlZNZSBuYW1lc3BhY2UuIFRoaXMgY2hhciBkZXZp
Y2UgaXMgYWx3YXlzCj4+IGluaXRpYWxpemVkLCBpbmRlcGVuZGVudGx5IG9mIHdoZXRoZXIgdGhl
IGZlYXR1cmVzIGltcGxlbWVudGVkIGJ5IHRoZQo+PiBkZXZpY2UgYXJlIHN1cHBvcnRlZCBieSB0
aGUga2VybmVsLiBVc2VyLXNwYWNlIGNhbiB0aGVyZWZvcmUgYWx3YXlzCj4+IGlzc3VlIElPQ1RM
cyB0byB0aGUgTlZNZSBkcml2ZXIgdXNpbmcgdGhlIGNoYXIgZGV2aWNlLgo+Pgo+PiBUaGUgY2hh
ciBkZXZpY2UgaXMgcHJlc2VudGVkIGFzIC9kZXYvbnZtZS1nZW5lcmljLVhjWW5aLiBUaGlzIG5h
bWluZwo+PiBzY2hlbWUgZm9sbG93cyB0aGUgY29udmVudGlvbiBvZiB0aGUgaGlkZGVuIGRldmlj
ZSAobnZtZVhjWW5aKS4gU3VwcG9ydAo+PiBmb3IgbXVsdGlwYXRoIHdpbGwgZm9sbG93Lgo+Cj5T
byBJJ20gYSBsaXR0bGUgd29ycmllZCBhYm91dCB0aGUgInN1cHBvcnQgZm9yIG11bHRpcGF0aCB3
aWxsIGZvbGxvdyIgYXMKPnRoaXMgaGFzIGltcGxpY2F0aW9ucyBmb3IgdGhlIG5hbWluZyBzY2hl
bWUsIGFuZCBvdXIgcG9saWN5IG9mIGhvdyB3ZQo+YWxsb3cgYWNjZXNzIHRvIGEgbmFtZXNwYWNl
LgoKSSBtYWludGFpbmVkIHRoZSBtZXNzYWdlIHRvIGZvbGxvdyB0aGUgb3JpZ2luYWwgY29tbWl0
LiBJbiB0aGlzCnBhdGNoc2V0IG11bHRpcGF0aCBpcyBpbXBsZW1lbnRlZC4gSSBtYWludGFpbnMg
dGhlIHNhbWUgbmFtaW5nIHNjaGVtZS4KCldlIGNhbiByZW1vdmUgdGhpcyBjb21tZW50IGFzIG11
bHRpcGF0aCBpcyBzdXBwb3J0ZWQgaW4gdGhlIGV4aXN0aW5nCnNlcmllcy4KCj4KPklnbm9yaW5n
IHNvbWUgb2YgdGhlIGRlcHJlY2F0ZWQgaGlzdG9yaWMgbWlzdGFrZXMgSSB0aGluayB0aGUgcG9s
aWN5Cj5zaG91bGQgYmU6Cj4KPiAtIGFkbWluIGNvbW1hbmRzIHRoYXQgb2Z0ZW4gYXJlIGNvbnRy
b2xsZXIgc3BlY2lmaWMgc2hvdWxkIHVzdWFsbHkKPiAgIGdvIHRvIGEgY29udHJvbGxlci1zcGVj
aWZpYyBkZXZpY2UsIHRoZSBleGlzdGluZyAvZGV2L252bWVYCj4gICBkZXZpY2VzCj4gLSBJL08g
Y29tbWFuZHMgYW5kIGFkbWluIGNvbW1hbmQgdGhhdCBkbyBzcGVjaWZpYyBhIG5zaWQgc2hvdWxk
IGdvCj4gICB0aHJvdWdoIGEgcGVyLW5hbWVzcGFjZSBub2RlIHRoYXQgaXMgbXVsdGlwYXRoIGF3
YXJlIGFuZCBub3QKPiAgIGNvbnRyb2xsZXIgc3BlY2lmaWMKClNvdW5kcyBnb29kLgoKVGhlIGN1
cnJlbnQgaW1wbGVtZW50YXRpb24gcmUtcm91dGVzIElPQ1RMcyB0byB0aGUgY2hhciBkZXZpY2Ug
dGhyb3VnaAp0aGUgZXhpc3RpbmcgYmRldiBJT0NUTHMsIHNvIEkgYmVsaWV2ZSB3ZSBmb2xsb3cg
dGhpcyBwb2xpY3kgYWxyZWFkeS4gV2UKYmFzaWNhbGx5IGRlZmF1bHQgdG8gY3VycmVudCBiZWhh
dmlvci4KCkFuZCBJIGFzc3VtZSB0aGF0IGZvciBsZWdhY3ksIG5hbWVzcGFjZSBJT0NUTHMgdG8g
dGhlIGNvbnRyb2xsZXIgd2lsbApzdGlsbCBiZSByb3V0ZWQgdG8gdGhlIG5hbWVzcGFjZSAoYXNz
dW1pbmcgYSBzaW5nbGUgbmFtZXNwYWNlKS4KCj5XaGljaCBhbHNvIG1ha2VzIG1lIHdvbmRlciBh
Ym91dCBwYXRjaCAyIGluIHRoZSBzZXJpZXMgdGhhdCBzZWVtcwo+c29tZXdoYXQgZGFuZ2Vyb3Vz
LiAgIENhbiB3ZSBjbGVhcmx5IHN0YXRlIHRoZSBwb2xpY3kgaW1wbGVtZW50ZWQ/CgpQYXRjaCAy
IGlzIHRoZSBvbmUgdGhhdCBleHBvc2VzIHRoZSBleGlzdGluZyBsb2dpYyBmb3IgbXVsdGlwYXRo
LiBIb3cgZG8KeW91IHRoaW5rIHdlIHNob3VsZCBkbyBpdCBpbnN0ZWFkPwoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxp
c3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
