Return-Path: <SRS0=VOor=J3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E053C433ED
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Apr 2021 23:43:06 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8172E61208
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Apr 2021 23:43:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8172E61208
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	Cc:To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nM1ClhPqJh25fNwsJPeF99aqJG3Nhd4VKP8kEQsRG34=; b=oMPJL6jjeLm4X17dmYeU61ZkC
	K9hLMSMjty4o80ncpJsCeIZ+czGYrb3n6387oe8ydJqe7u7QtaT04By5RCfWa6MnxInhmJDXmY81x
	eGN/ZsxdJU60OafDyiPMD5SzscvoObvmbsSJwicNJuKWuMmiGqB2bDFPmfkjMrrc8/puz+ycsrbEX
	9KBPJOa+zWRxoqrsbxY8DcVqzsfuGJVSZGl1DPzEqCsrswIrm57GY8ysWWdFxvAORL0ijTjd3Pa0j
	mrV8/VtKywUm00ciBhHuzbUvMRuFk8mevDPoqp2b4LfSaZEeFE5ra9x2BRcVwzyDdemZK9+jQFBow
	vwi9Z+irw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lccmF-008y6e-BK; Fri, 30 Apr 2021 23:42:31 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lccm4-008y5f-CQ
 for linux-nvme@desiato.infradead.org; Fri, 30 Apr 2021 23:42:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=V/GDeCw9IUTBUKYZd5ts6DYhKwoFM0SgLs2Og3ekF8M=; b=jWYtoVtCanXfPCPqEgAcvJ9gX1
 gCRO32+nvdxIZr+RAaLCA4tqQ0PuskWA/zVSJDyaj+n/c/Ppr32JzgadkUne3AcN9eEAFeemUg4fu
 /PXbKnk5VktJ6jPQ8Vf9SB3KPap8W2WV26TGSnNcwBeFaCFC0u31FkC9JeF5WwEGgbHqrr1K4e2WO
 sjTJZ87DhxCwGGB2WImV/WIxHTLmZvYonHQdJ9L/Nlc6CQN6xUjclcReNWWGxIw1bPLho+FdPHWIQ
 lhofIxVzZ0AkcuAMNsifxX3GM6L51n485P4tGXRFoabLlfRaRkFPY3nJTkf2XGzcqU14nmoRMFPyr
 oZATTkNQ==;
Received: from mail-pl1-f174.google.com ([209.85.214.174])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lccm1-001kIg-8f
 for linux-nvme@lists.infradead.org; Fri, 30 Apr 2021 23:42:18 +0000
Received: by mail-pl1-f174.google.com with SMTP id v20so10158316plo.10
 for <linux-nvme@lists.infradead.org>; Fri, 30 Apr 2021 16:42:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=V/GDeCw9IUTBUKYZd5ts6DYhKwoFM0SgLs2Og3ekF8M=;
 b=bUAE16TuOdx4yZ35WcZT56MF75UuvRmShqMeEmjkYU5Va4rGIIYCv4AqLe5hhRmtyn
 zt+t8gWO2b/X+V322f3p5RUt1oNoDTrGWWDHGR8jcN1kEDIzU20OPtdzML5i9NdFqHYZ
 AYadvaW+sFvJp1Z5a7Af+eYzCSLCuvcqnZIor30xk0yVbS8cLQPJLUAEiOn1Pl5Htpfc
 11x0Fy9Yln4ATCIF1vJ2/fAmT+nIKuSHMSIwFZ3+WZGuVqAcT6m9CVi1rUkZwpD6lA66
 Z6CDE5/wFIMKaDo+y+nl1JOQzGfIND/My63HrZ3BgsADcYmawY2FS/tA2m+A1z5X7Th/
 Iclw==
X-Gm-Message-State: AOAM530sn7JdGN2Q4hOwp5f5ztOhcZlqn4ziUJeDWlLWSBjKD5QeYYGq
 yHML9sgYrBXcEmwG3Ltn15w=
X-Google-Smtp-Source: ABdhPJykacy4meIfsb4sDVpbFJZ5N8TZycp0cKbeK8OBJQtbOSOrX914a49ki8c964aRMoQmswPFsQ==
X-Received: by 2002:a17:90a:d347:: with SMTP id
 i7mr8016318pjx.231.1619826135735; 
 Fri, 30 Apr 2021 16:42:15 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5d05:c199:96bf:2f58?
 ([2601:647:4802:9070:5d05:c199:96bf:2f58])
 by smtp.gmail.com with ESMTPSA id s184sm4130786pgc.29.2021.04.30.16.42.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Apr 2021 16:42:15 -0700 (PDT)
Subject: Re: nvme tcp receive errors
From: Sagi Grimberg <sagi@grimberg.me>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
References: <0976ff40-751e-cb95-429a-04ffa229ebf0@grimberg.me>
 <20210331204958.GD23886@redsun51.ssa.fujisawa.hgst.com>
 <20210402171141.GA1944994@dhcp-10-100-145-180.wdc.com>
 <53a11feb-bc49-d384-3b7b-481a0dfc70e6@grimberg.me>
 <20210405143702.GA20598@redsun51.ssa.fujisawa.hgst.com>
 <300c9e90-9bd6-abc8-c67a-fa92e119e4a7@grimberg.me>
 <20210414002946.GA2448507@dhcp-10-100-145-180.wdc.com>
 <5bc917c8-4e4c-7bfa-7cfa-24858993a042@grimberg.me>
 <20210426153137.GD12593@redsun51.ssa.fujisawa.hgst.com>
 <f247f9e2-6724-0feb-b40c-08ada848d290@grimberg.me>
 <20210427181236.GA631001@dhcp-10-100-145-180.wdc.com>
 <686a7cdc-a9a8-3700-3805-90d07db39707@grimberg.me>
Message-ID: <d27ccec0-7b2c-790c-3192-96c6e2aeee0c@grimberg.me>
Date: Fri, 30 Apr 2021 16:42:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <686a7cdc-a9a8-3700-3805-90d07db39707@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210430_164217_330721_FDFE07AC 
X-CRM114-Status: GOOD (  16.72  )
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

Cj4gWW91IGFyZSBleGFjdGx5IHJpZ2h0LCBJIHRoaW5rIHRoaXMgc2hvdWxkIGRvIHRoZSB0cmlj
azoKCkhleSBLZWl0aCwKCkRpZCB0aGlzIHJlc29sdmUgdGhlIGlzc3Vlcz8KCj4gLS0gCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L3RjcC5jIGIvZHJpdmVycy9udm1lL2hvc3QvdGNw
LmMKPiBpbmRleCA4ZTU1ZDhiYzBjNTAuLmViMWZlYWFjZDExYSAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL252bWUvaG9zdC90Y3AuYwo+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L3RjcC5jCj4gQEAg
LTU1LDYgKzU1LDcgQEAgc3RydWN0IG52bWVfdGNwX3JlcXVlc3Qgewo+ICDCoMKgwqDCoMKgwqDC
oCAvKiBzZW5kIHN0YXRlICovCj4gIMKgwqDCoMKgwqDCoMKgIHNpemVfdMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgb2Zmc2V0Owo+ICDCoMKgwqDCoMKgwqDCoCBzaXplX3TCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRhdGFfc2VudDsKPiArwqDCoMKgwqDCoMKg
IHNpemVfdMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGF0YV9yZWNlaXZlZDsK
PiAgwqDCoMKgwqDCoMKgwqAgZW51bSBudm1lX3RjcF9zZW5kX3N0YXRlIHN0YXRlOwo+ICDCoH07
Cj4gCj4gQEAgLTc1MSw5ICs3NTIsMTIgQEAgc3RhdGljIGludCBudm1lX3RjcF9yZWN2X2RhdGEo
c3RydWN0IG52bWVfdGNwX3F1ZXVlIAo+ICpxdWV1ZSwgc3RydWN0IHNrX2J1ZmYgKnNrYiwKPiAg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICpsZW4gLT0gcmVjdl9sZW47Cj4gIMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqb2Zmc2V0ICs9IHJlY3ZfbGVuOwo+ICDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcXVldWUtPmRhdGFfcmVtYWluaW5nIC09IHJlY3ZfbGVu
Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlcS0+ZGF0YV9yZWNlaXZlZCArPSBy
ZWN2X2xlbjsKPiAgwqDCoMKgwqDCoMKgwqAgfQo+IAo+ICDCoMKgwqDCoMKgwqDCoCBpZiAoIXF1
ZXVlLT5kYXRhX3JlbWFpbmluZykgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlm
IChyZXEtPmRhdGFfcmVjZWl2ZWQgPCByZXEtPmRhdGFfbGVuKQo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsKPiAgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGlmIChxdWV1ZS0+ZGF0YV9kaWdlc3QpIHsKPiAgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBudm1lX3RjcF9kZGdzdF9maW5hbChx
dWV1ZS0+cmN2X2hhc2gsIAo+ICZxdWV1ZS0+ZXhwX2RkZ3N0KTsKPiAgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBxdWV1ZS0+ZGRnc3RfcmVtYWluaW5nID0g
TlZNRV9UQ1BfRElHRVNUX0xFTkdUSDsKPiBAQCAtMjI3NCw2ICsyMjc4LDcgQEAgc3RhdGljIGJs
a19zdGF0dXNfdCBudm1lX3RjcF9zZXR1cF9jbWRfcGR1KHN0cnVjdCAKPiBudm1lX25zICpucywK
PiAgwqDCoMKgwqDCoMKgwqAgcmVxLT5zdGF0ZSA9IE5WTUVfVENQX1NFTkRfQ01EX1BEVTsKPiAg
wqDCoMKgwqDCoMKgwqAgcmVxLT5vZmZzZXQgPSAwOwo+ICDCoMKgwqDCoMKgwqDCoCByZXEtPmRh
dGFfc2VudCA9IDA7Cj4gK8KgwqDCoMKgwqDCoCByZXEtPmRhdGFfcmVjZWl2ZWQgPSAwOwo+ICDC
oMKgwqDCoMKgwqDCoCByZXEtPnBkdV9sZW4gPSAwOwo+ICDCoMKgwqDCoMKgwqDCoCByZXEtPnBk
dV9zZW50ID0gMDsKPiAgwqDCoMKgwqDCoMKgwqAgcmVxLT5kYXRhX2xlbiA9IGJsa19ycV9ucl9w
aHlzX3NlZ21lbnRzKHJxKSA/Cj4gLS0gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1udm1lCg==
