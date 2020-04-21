Return-Path: <SRS0=BHyj=6F=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01C3C54FCC
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Apr 2020 15:53:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C129B2064C
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Apr 2020 15:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LbEjO8CR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FW5h68Sv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C129B2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Kpw3VGGPwuDM07nXVDdzJWJm/iuN/1ly3Krt2TDG2g4=; b=LbEjO8CRi2nICs18/ei1ZMBdc
	a+R9k0SR/MVdk04is58lCcQwUPO8HstRx6SM3wFwjdDIuQaseIhSk6d9Vl60dR3+rk278WUbW9wTd
	n13rkhAJ0QoZhcAZj/qlpAJmEtVvZoIt06jOTsZ7rqI0iqXLzq+X0xD7tuYX3+7ASuhdTJkhNEtLb
	IPy2KevwXjQzPY7AzdQa6wGtLpF/3IozXO910NvN4VlGbhe1LHNxAJvg9mwyNOPqhNFzgQryhNhYu
	ypQYVIt660PWNUnsh0zvgBXmejXG2pvpUpdE2LKm1rxeh81tj/czdGyA/OL3d4Ry6ab6XSXHcYxs0
	0WXJ4+GQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jQvDA-0007hV-SY; Tue, 21 Apr 2020 15:53:24 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jQvD7-0007fr-VR
 for linux-nvme@lists.infradead.org; Tue, 21 Apr 2020 15:53:23 +0000
Received: by mail-pf1-x443.google.com with SMTP id y25so6759879pfn.5
 for <linux-nvme@lists.infradead.org>; Tue, 21 Apr 2020 08:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=mZBPY1fpy9btZ9cr9GZUKUH9M5h2ZIyQ7J4HV3xTWCw=;
 b=FW5h68Svi9Ufjpxyf3s3/7ona7add8+nQd0A3NBa97f4w8EnOEnfVPOdVbD5KDQ8Vk
 hwONtmV5SURT1kW23Nl8io0wpFT3d7XubNF9FPyLa+X2eICDG6hjvsckZlR4O/IRmHdF
 Wfu0MAg1g1OMrc+NQmT8EYJNy1aiXd3ghNGPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=mZBPY1fpy9btZ9cr9GZUKUH9M5h2ZIyQ7J4HV3xTWCw=;
 b=dBixMysWVZSAt51B5lwhwtsX030n3UF51l8a9D181dQdb3lIyo2cgvgoWpxrpwMmDK
 SlPDlckJsgnWOoafuSd8NoW63Qwa93gs186L18AAayYWmzJw5NKP3X5Ux7K85j7nCtcm
 KMdxuUxPQ5qBPcFrpLcZoGfIQB3HPVh668Hz3FTJShBtngpb18eaBCvOwfbgjUFqJa8O
 4booabQUSO6yDMjg9aWeUHwDvYhHGP1mRnrc01LUHJHxNF3TvGvAK8sdZ1tdbULOd0sW
 IcfsWwMCGggtSpVZHAJ9WsSdhJZ8eSGKGFftxQiq3IXEWnvZvptqUuwCnp142soFBT4q
 TDFA==
X-Gm-Message-State: AGi0PuZ0s/7ZwyGyRtr77HXowm/RHrz/mPY5WXO6vpro45viyMrxkM7U
 gy3bi7nDVDa8rSRDfFqOGp6P4A==
X-Google-Smtp-Source: APiQypLWDAdreOGwS/27Ss480aYwHAHQjOkV4IZCra7nzmwsx4VJBYQT2i9Rd5F5OBuOY5GVKL77fA==
X-Received: by 2002:a63:f843:: with SMTP id v3mr22778575pgj.421.1587484401053; 
 Tue, 21 Apr 2020 08:53:21 -0700 (PDT)
Received: from [10.230.185.141] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id i18sm2784894pjx.33.2020.04.21.08.53.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2020 08:53:20 -0700 (PDT)
Subject: Re: [PATCH 01/17] nvme: introduce namespace features flag
To: Christoph Hellwig <hch@lst.de>, Max Gurtovoy <maxg@mellanox.com>
References: <20200327171545.98970-1-maxg@mellanox.com>
 <20200327171545.98970-3-maxg@mellanox.com> <20200421115912.GB26432@lst.de>
From: James Smart <james.smart@broadcom.com>
Message-ID: <1ffeee50-9c96-495f-b82b-bf3873e95183@broadcom.com>
Date: Tue, 21 Apr 2020 08:53:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200421115912.GB26432@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200421_085322_015139_F8BF1612 
X-CRM114-Status: GOOD (  11.59  )
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
Cc: axboe@kernel.dk, jsmart2021@gmail.com, sagi@grimberg.me,
 martin.petersen@oracle.com, idanb@mellanox.com, linux-rdma@vger.kernel.org,
 israelr@mellanox.com, vladimirk@mellanox.com, linux-nvme@lists.infradead.org,
 shlomin@mellanox.com, jgg@mellanox.com, oren@mellanox.com, kbusch@kernel.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gNC8yMS8yMDIwIDQ6NTkgQU0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+IE9uIEZyaSwg
TWFyIDI3LCAyMDIwIGF0IDA4OjE1OjI5UE0gKzAzMDAsIE1heCBHdXJ0b3ZveSB3cm90ZToKPj4g
RnJvbTogSXNyYWVsIFJ1a3NoaW4gPGlzcmFlbHJAbWVsbGFub3guY29tPgo+Pgo+PiBDZW50cmFs
aXplIGFsbCB0aGUgbWV0YWRhdGEgY2hlY2tzIHRvIG9uZSBwbGFjZSBhbmQgbWFrZSB0aGUgY29k
ZSBtb3JlCj4+IHJlYWRhYmxlLiBJbnRyb2R1Y2UgYSBuZXcgZW51bSBudm1lX25zX2ZlYXR1cmVz
IGZvciB0aGF0IG1hdHRlci4KPj4gVGhlIGZlYXR1cmVzIGZsYWcgZGVzY3JpcHRpb246Cj4+ICAg
LSBOVk1FX05TX0VYVF9MQkFTIC0gTlZNZSBuYW1lc3BhY2Ugc3VwcG9ydHMgZXh0ZW5kZWQgTEJB
IGZvcm1hdC4KPj4gICAtIE5WTUVfTlNfTURfSE9TVF9TVVBQT1JURUQgLSBOVk1lIG5hbWVzcGFj
ZSBzdXBwb3J0cyBnZXR0aW5nIG1ldGFkYXRhCj4+ICAgICBmcm9tIGhvc3QncyBibG9jayBsYXll
ci4KPj4gICAtIE5WTUVfTlNfTURfQ1RSTF9TVVBQT1JURUQgLSBOVk1lIG5hbWVzcGFjZSBzdXBw
b3J0cyBtZXRhZGF0YSBhY3Rpb25zCj4+ICAgICBieSB0aGUgY29udHJvbGxlciAoZ2VuZXJhdGUv
c3RyaXApLgo+IFNvIHdob2xlIEkgbGlrZSB0aGUgLT5mZWF0dXJlcyBmbGFnLCB0aGUgZGVmaW50
aW9uIG9mIHRoZXNlIHR3bwo+IG1ldGFkYXRhIHJlbGF0ZWQgZmVhdHVyZXMgcmVhbGx5IGNvbmZ1
c2VzIG1lLgo+Cj4gSGVyZSBhcmUgbXkgdmFndWUgaWRlYXMgdG8gaW1wcm92ZSB0aGUgc2l0dWF0
aW9uOgo+CgpDYXJlIHRvIGxvb2sgYXQgYW55IG9mIHRoZSBSRkMgaXRlbXMgSSBwb3N0ZWQgb24g
Mi8yNCAtIHdoaWNoIGRvZXMgCnRoaW5ncyBhIGxpdHRsZSBkaWZmZXJlbnRseSA/wqDCoCBQZXJo
YXBzIGZpbmQgYSBjb21tb24gZ3JvdW5kIHdpdGggTWF4J3MgCnBhdGNoZXMuCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL3BpcGVybWFpbC9saW51eC1udm1lLzIwMjAtRmVicnVhcnkvMDI5MDY2
Lmh0bWwKCkdyYW50ZWQgSSd2ZSB0d2Vha2VkIHdoYXQgSSBzZW50IGEgbGl0dGxlIGFzIHRoZXJl
IHdhcyBubyBuZWVkIHRvIG1ha2UgCm52bWVfbnNfaGFzX3BpIGFjY2Vzc2libGUgdG8gdGhlIHRy
YW5zcG9ydC4KCi0tIGphbWVzCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbGludXgtbnZtZSBtYWlsaW5nIGxpc3QKbGludXgtbnZtZUBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtbnZtZQo=
