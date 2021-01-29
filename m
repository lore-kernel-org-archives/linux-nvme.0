Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F434C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 03:30:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCC2464DE7
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 03:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCC2464DE7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/4ZMCZabPifIlub10C2o+JsDWPGBE2Ni426c+cTPJ2Y=; b=lsaoT5at+XwhbFk0YNOUFv3cp
	ZkeT/Q86RYLzr/CICE/lWF42SMVfiti66yejyxR7EMWdsVM3mtB2Mh1YuGVgcLL3OhjZoZ8ls2zL+
	7ysRJuHFF/wkXSu5ib/jgjngip0nfV+GNl22BP4obWfEunPBunFSDqBKNBXXvyOI9Qbx7+I96uFrp
	VmqZPgnZdz4sK5R4qtI7LgcEhzCDash43qLNa/myndbc0tlHr87VHGLuu4gN+T7ueuGxpmDSYI84R
	LRAi0FS7k9jI4o50X+k2KgXpAe47fwJss9jupeGa9QL2QdzXDnoDYrFYxNDEB2eQLTT3X5BhKpUqn
	kaOd1mlww==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5KUC-0001GB-7N; Fri, 29 Jan 2021 03:30:16 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5KU9-0001FX-6o
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 03:30:14 +0000
Received: by mail-wr1-f43.google.com with SMTP id d16so7403653wro.11
 for <linux-nvme@lists.infradead.org>; Thu, 28 Jan 2021 19:30:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7JvZqZgmo4qIPwsjj069cmI/74kxVP4SSY95ky0J7hY=;
 b=GR/dnZINwWZHO/6iWO66LxAPiSTKznSBOTQgad2sOBG95hKSJ4j1TuZppDTK+kIJPw
 Qp36A5REInXdlt5/uaco68wyEyzuKR+GLnFcfMTPhBHl4T+hPirStmbn+FFAk5QoUG6L
 3TQMmWfdSyEEJGntzZuobU3YNL5p0yXMxN60MTvNoARidrGbtVm3UwuV3ERmChjqUzkP
 Zowg4pPqfKSwyBwtMS3gsuFGq9nSIGEpijz5to193qOTGUGUzatFkim3Bro/mOHSdDYy
 RdAQeAInoG9wCL3jXr2XpwPb9Ajqw0YO8x5BdaUPg6SwsdIGwsNjsfLx6c4BlVqG+a+s
 uvKg==
X-Gm-Message-State: AOAM530ikjy5eAxIN/motQ4M5epGHp/EZ0pOcos8Wr+n/Z34VKaswNC5
 Asq3OUmiTPNanMb1eoY7MGY=
X-Google-Smtp-Source: ABdhPJzqHQHtS4BkI4+Mr8moj9jMrAyizE5539Amfj5VtzBG9cnBzaCDYL3kyzlFCT2lRWq+/3X84Q==
X-Received: by 2002:a5d:5283:: with SMTP id c3mr2038048wrv.319.1611891011977; 
 Thu, 28 Jan 2021 19:30:11 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:3d48:4849:d506:e578?
 ([2601:647:4802:9070:3d48:4849:d506:e578])
 by smtp.gmail.com with ESMTPSA id u14sm7730793wml.19.2021.01.28.19.30.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Jan 2021 19:30:11 -0800 (PST)
Subject: Re: [PATCH v2] nvme-multipath: Early exit if no path is available
To: Chao Leng <lengchao@huawei.com>, Daniel Wagner <dwagner@suse.de>
References: <20210127103033.15318-1-dwagner@suse.de>
 <db9baae0-547c-7ff4-8b2c-0b95f14be67c@huawei.com>
 <20210128075837.u5u56t23fq5gu6ou@beryllium.lan>
 <69575290-200e-b4a1-4269-c71e4c2cc37b@huawei.com>
 <20210128094004.erwnszjqcxlsi2kd@beryllium.lan>
 <ebb1d098-3ded-e592-4419-e905aabe824f@huawei.com>
 <675d3cf7-1ae8-adc5-b6d0-359fe10f6b23@grimberg.me>
 <59cd053e-46cb-0235-141f-4ce919c93f48@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <dbc39e56-b2bd-a82e-499a-5032c9716855@grimberg.me>
Date: Thu, 28 Jan 2021 19:30:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <59cd053e-46cb-0235-141f-4ce919c93f48@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_223013_271702_A67D2146 
X-CRM114-Status: GOOD (  15.95  )
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
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4+Pj4gWW91IGNhbid0IHNlZSBleGFjdGx5IHdoZXJlIGl0IGRpZXMgYnV0IEkgZm9sbG93ZWQg
dGhlIGFzc2VtYmx5IHRvCj4+Pj4gbnZtZV9yb3VuZF9yb2Jpbl9wYXRoKCkuIE1heWJlIGl0J3Mg
bm90IHRoZSBpbml0aWFsIG52bWVfbmV4dF9ucyhoZWFkLAo+Pj4+IG9sZCkgd2hpY2ggcmV0dXJu
cyBOVUxMIGJ1dCBudm1lX25leHRfbnMoKSBpcyByZXR1cm5pbmcgTlVMTCBldmVudHVhbGx5Cj4+
Pj4gKGxpc3RfbmV4dF9vcl9udWxsX3JjdSgpKS4KPj4+IFNvIHRoZXJlIGlzIG90aGVyIGJ1ZyBj
YXVzZSBudm1lX25leHRfbnMgYWJvcm1hbC4KPj4+IEkgcmV2aWV3IHRoZSBjb2RlIGFib3V0IGhl
YWQtPmxpc3QgYW5kIGhlYWQtPmN1cnJlbnRfcGF0aCwgSSBmaW5kIDIgYnVncwo+Pj4gbWF5IGNh
dXNlIHRoZSBidWc6Cj4+PiBGaXJzdCwgSSBhbHJlYWR5IHNlbmQgdGhlIHBhdGNoLiBzZWU6Cj4+
PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1udm1lLzIwMjEwMTI4MDMzMzUxLjIyMTE2
LTEtbGVuZ2NoYW9AaHVhd2VpLmNvbS8gCj4+Pgo+Pj4gU2Vjb25kLCBpbiBudm1lX25zX3JlbW92
ZSwgbGlzdF9kZWxfcmN1IGlzIGJlZm9yZQo+Pj4gbnZtZV9tcGF0aF9jbGVhcl9jdXJyZW50X3Bh
dGguIFRoaXMgbWF5IGNhdXNlICJvbGQiIGlzIGRlbGV0ZWQgZnJvbSB0aGUKPj4+ICJoZWFkIiwg
YnV0IHN0aWxsIHVzZSAib2xkIi4gSSdtIG5vdCBzdXJlIHRoZXJlJ3MgYW55IG90aGVyCj4+PiBj
b25zaWRlcmF0aW9uIGhlcmUsIEkgd2lsbCBjaGVjayBpdCBhbmQgdHJ5IHRvIGZpeCBpdC4KPj4K
Pj4gVGhlIHJlYXNvbiB3aHkgd2UgZmlyc3QgcmVtb3ZlIGZyb20gaGVhZC0+bGlzdCBhbmQgb25s
eSB0aGVuIGNsZWFyCj4+IGN1cnJlbnRfcGF0aCBpcyBiZWNhdXNlIHRoZSBvdGhlciB3YXkgYXJv
dW5kIHRoZXJlIGlzIG5vIHdheQo+PiB0byBndWFyYW50ZWUgdGhhdCB0aGF0IHRoZSBucyB3b24n
dCBiZSBhc3NpZ25lZCBhcyBjdXJyZW50X3BhdGgKPj4gYWdhaW4gKGJlY2F1c2UgaXQgaXMgaW4g
aGVhZC0+bGlzdCkuCj4gb2ssIEkgc2VlLgo+Pgo+PiBudm1lX25zX3JlbW92ZSBmZW5jZXMgY29u
dGludWUgb2YgZGVsZXRpb24gb2YgdGhlIG5zIGJ5IHN5bmNocm9uaXppbmcKPj4gdGhlIHNyY3Ug
c3VjaCB0aGF0IGZvciBzdXJlIHRoZSBjdXJyZW50X3BhdGggY2xlYXJhbmNlIGlzIHZpc2libGUu
Cj4gVGhlIGxpc3Qgd2lsbCBiZSBsaWtlIHRoaXM6Cj4gaGVhZC0+bmV4dCA9IG5zMTsKPiBuczEt
Pm5leHQgPSBoZWFkOwo+IG9sZC0+bmV4dCA9IG5zMTsKPiBUaGlzIG1heSBjYXVzZSBpbmZpbml0
ZSBsb29wIGluIG52bWVfcm91bmRfcm9iaW5fcGF0aC4KPiBmb3IgKG5zID0gbnZtZV9uZXh0X25z
KGhlYWQsIG9sZCk7Cj4gIMKgwqDCoMKgbnMgIT0gb2xkOwo+ICDCoMKgwqDCoG5zID0gbnZtZV9u
ZXh0X25zKGhlYWQsIG5zKSkKPiBUaGUgbnMgd2lsbCBhbHdheXMgYmUgbnMxLCBhbmQgdGhlbiBp
bmZpbml0ZSBsb29wLgoKV2hvIGlzIGJlaW5nIHJlbW92ZWQ/IEknbSBub3QgZm9sbG93aW5nCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1l
IG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
