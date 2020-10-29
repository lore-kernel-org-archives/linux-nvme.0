Return-Path: <SRS0=pD35=EE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3080DC2D0A3
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2020 21:00:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C32520790
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2020 21:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ndvBon5M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C32520790
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=D1zOXDZh4bxpg5r/5UHodpKifQYXbIRWQgphAjqMbms=; b=ndvBon5MFQqV7NBZein+qdqRx
	VFBy4FFiDfxN7t8kYB0Shs0lqxsW7yvSsnL/eK+b4lYLpCSP3y0vpVrB3I/4CuCvGHZmzXfELp4CF
	xM3A/7PYrOX52JCG3oEka4CbX+1bNwYojvTwe/5mNDNIniSUbYWkPeuROH57x5YOblXzM+h8X2eSg
	wpMCZkbdt5qTQXpNuoPby9tlcG0N6TpnVhgssZ0+N0Zhhu8HzrcBv3J8LgGp6ttYK0WoAxBBHb5PV
	X+PX3AfR6YHiKU8Ls5O5ri45IgJaw2aWytYAIFyciuM2jKE0aJGHnrz5YS7gZ39WZm33RNpuGCgFk
	hxn43KL+Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kYF2Q-0001jp-T7; Thu, 29 Oct 2020 21:00:51 +0000
Received: from mail-wr1-f67.google.com ([209.85.221.67])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kYF2N-0001iy-Fi
 for linux-nvme@lists.infradead.org; Thu, 29 Oct 2020 21:00:48 +0000
Received: by mail-wr1-f67.google.com with SMTP id k10so2926534wrw.13
 for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2020 14:00:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=andPyIUVMHtqMK6cXS0PJjizXZUotl+KtqGX/GOeo0g=;
 b=jcz0zeOKw5F/OOxt0d+JBlOkcJjqVKhF5MhOfijiKjbmrFBgzgDvhgVIeO4mImr7Zq
 jbVpH2oMv5fZ7IjwqTl0IK7BRp0azALp1TtErPFxZpmepeQZhCqO9h68/4SUNCew9Tr9
 fH5WsmuB3Xe2pEvUFP3lUD3y14M0QWV2Od6b3J/860t1EnifmQENE/+AWzwotaGJt31y
 hzlLioGYmePrzFfFIZjgmsXU0IgjB9QDLAomsMhEpChHAuA6diyMXBTVM2Qt94eXnoeI
 rryu2GWQMyRpQOhNvebaYbHRD1fyK2kZ+gkudd3dH9I9B7Z28Y+UpcOLjCYRcm1A9v8W
 r/Qg==
X-Gm-Message-State: AOAM531Xlvq1dIifO0s2UojAVxUK1iDCt/khcYpQT82IIZsO0Jybrhv1
 qdVV1rVZUe8yDqMAKUpfapI=
X-Google-Smtp-Source: ABdhPJyLi6qrYWIeLkCYeRiHUOnpXRt8EIIM6vMvkOm2PFJ9CQSNmf50JBrsVli/SfbdE8TXXs92JQ==
X-Received: by 2002:adf:ef92:: with SMTP id d18mr7888012wro.420.1604005246251; 
 Thu, 29 Oct 2020 14:00:46 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:d32:e3ef:ad74:6ea9?
 ([2601:647:4802:9070:d32:e3ef:ad74:6ea9])
 by smtp.gmail.com with ESMTPSA id s2sm1989544wmh.9.2020.10.29.14.00.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2020 14:00:45 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] avoid race for time out
To: Yi Zhang <yi.zhang@redhat.com>, Chao Leng <lengchao@huawei.com>,
 Ming Lei <ming.lei@redhat.com>
References: <20201022021452.10971-1-lengchao@huawei.com>
 <aba13cb9-a3d4-490b-4d1d-1deb60eafff6@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e913e433-d8ef-c04b-d9fa-3a6d71657136@grimberg.me>
Date: Thu, 29 Oct 2020 14:00:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <aba13cb9-a3d4-490b-4d1d-1deb60eafff6@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201029_170047_555611_6E0D5D62 
X-CRM114-Status: GOOD (  15.14  )
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
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4gSGVsbG8KPiAKPiBUaGlzIHNlcmllcyBmaXhlZCB0aGUgV0FSTklORyBpc3N1ZSBJIHJlcG9y
dGVkIFsxXSwgYnV0IG5vdyB0aGUgbnZtZS8wMTIgCj4gWzJdIHdpbGwgYmUgaGFuZyB0aGVyZSBh
bmQgbmV2ZXIgZmluaXNoZWQsIGhlcmUgaXMgdGhlIGxvZ1szXQo+IFsxXQo+IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2xpbnV4LW52bWUvMTkzNDMzMTYzOS4zMzE0NzMwLjE2MDIxNTIyMDI0NTQu
SmF2YU1haWwuemltYnJhQHJlZGhhdC5jb20vIAo+IAo+IAo+IFsyXQo+IFtyb290QGhwZS14dzk0
MDAtMDIgYmxrdGVzdHNdIyBudm1lX3RydHlwZT10Y3AgLi9jaGVjayBudm1lLzAxMgo+IG52bWUv
MDEyIChydW4gbWtmcyBhbmQgZGF0YSB2ZXJpZmljYXRpb24gZmlvIGpvYiBvbiBOVk1lT0YgYmxv
Y2sgCj4gZGV2aWNlLWJhY2tlZCBucykKPiAgwqDCoMKgIHJ1bnRpbWXCoCAxMTk5LjY1MXPCoCAu
Li4KCkhleSBZaSwKClRoaXMgaXMgYSBkaWZmZXJlbnQgaXNzdWUsIGFzIEkgc2FpZCwgZmlyc3Qg
b2YgYWxsIHRoZSB0ZXN0IGlzIG5vdApkZXNpZ25lZCB0byB0cmlnZ2VyIHRoaXMgc2NlbmFyaW8g
c28gaXQgaXMgd2VpcmQgd2h5IGl0IGV2ZW4gaGFwcGVucy4KCkZvciBkZWJ1ZyBwdXJwb3Nlcywg
Y2FuIHlvdSBzd2l0Y2ggdG8gcnVuIGJsa3Rlc3RzIHdpdGggc2l3IGZvcgpjb21wYXJpc29uPwoK
VGhpcyBwYXRjaCBzZXQgc2hvdWxkIG1vdmUgZm9yd2FyZCBmb3IgaW5jbHVzaW9uIHJlZ2FyZGxl
c3MuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51
eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
