Return-Path: <SRS0=ND0+=JJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF63C433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Apr 2021 09:50:19 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D86456120B
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Apr 2021 09:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D86456120B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zVehhA3LlnTOwzDBWnthc/WoSgd+Cvz1fske8PZdX8Q=; b=JYRFuIb/1ItkXyqmpMe5VfIke
	PxJHz4qOvB4mVCFlOeJFvjnsXn67FQM5ZHkIXKUK8uDDF4i/pMAVjgF5sJGH73+plXcGk8AjiSSo8
	pouKQaQa+bXazR7ub4Dy0AogBZaY/0hl4+wp3wRdYbhWHyEOCkZNPUdIwbGoMKJ+lJ8n6xHOANBr7
	6EKOJLF0hA26KLTHZQmeyyp8nr7ZxaTo1m9EJNPkGVbnkyYZzqVZ8SGqNZ6E6szoxi3ixCyLWofOy
	amPZuuVLupS/sXJv5Y6/b1X84/3I3z080Mi8cHEDSTtkLCI55uEBGh/LhkHBNRMMh83XuC0EeY2Wc
	Bi7lzNIBA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lVtCk-006M5F-IC; Mon, 12 Apr 2021 09:50:02 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVtCS-006M0L-5U
 for linux-nvme@desiato.infradead.org; Mon, 12 Apr 2021 09:49:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
 :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=kQK0baVBgNretjSwkLpVZKpaqdJdCMUf64CNx2owv/M=; b=4htXAz7PLPFnL+h6iaiJx991kS
 JXE6HPCI4vJ1mEuvAuy5pUAEF/oaFiLPTQ8MpybhGAzSOJt/6+LlCcT6H1tUzSqmXcN3LV7cOQ3oi
 IWPnXjKiIvuAqw77vqtGHhmJXufn9+XamR5a4VcpgdZUKSGWEXonP3DId3xu4bjr6gXTM4WtVk863
 0p/EWu3zPn0/3x2UBVJo8tWuJhbpmKX/t0ixEziqUPG/d2VqzInYOAYiS3+EI3oZuIqK3SHm9YrVJ
 CU7i48r37xAANPNlKA7RiuQvflqxv2jJL3yiFL0J1/VXTa/ckeuqDK7jRt6G+z5CqJp/nuoksWkrX
 5RWzpDBg==;
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVtCO-00666r-WF
 for linux-nvme@lists.infradead.org; Mon, 12 Apr 2021 09:49:42 +0000
Received: by mail-wr1-x435.google.com with SMTP id r7so233634wrm.1
 for <linux-nvme@lists.infradead.org>; Mon, 12 Apr 2021 02:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=kQK0baVBgNretjSwkLpVZKpaqdJdCMUf64CNx2owv/M=;
 b=1K175StvQ2dsc09TGV7qCabFabezM+A8UMKpejehs9LuVRCP6hI4ytFo1BKY4JX3MA
 oMYsaozVSv7gvSO33cHEigut/dzK3ihjDl3ySUCjrJFB7vBvUYG+TCAT7FHCRWKw5iix
 vRccXjWUeVAl4DJcYhi7rtJ45cwm6LMFU/uNc6tBWssPOubhhhNAiGhMSiJPtqzOxr1o
 vZXmfY8D+lbGODkfu3+j6YM5O12V2CeE5+l5chK3d2oaQFhGeoxI5Nsnpr+ydDI0wgbH
 cYT3E8K73zfXhQRR68qAc9ZZtQiDPrCxATkuLPV1Yehpu6d9dd7Ykrx3yA1QX8gjpTvg
 n6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=kQK0baVBgNretjSwkLpVZKpaqdJdCMUf64CNx2owv/M=;
 b=GNw4uTyJvz5W1ANHz6wI1a5jSSTzxCnAGYEx/7XE2/s1/Gb4U35BylUMARvgc8IGtI
 OqGqyE/Qd0fF6DXinYQ9rkjPcdFBYPY9ORb7MuUbXmtafMf6TEeOknP71FMCMP0jf10H
 shSmj+EMc/2IFdkj83HRfBoBKJBGdBkRJINKuIb3MEt8uYW8lyPY4MWkGzN7YRDzrRpa
 /xiS0t3ZMr4dUiFbZH8IdSYSMUv5H76vZ+hI5WOLCobbM7rBePqylQZOeJLnga/F7rFV
 Trod18iSV4mqTp5oyVe1if/e1/p6L3Aht00sUd0ZeS1/vtXOM0ZGs0Pjs3l/c0SpGF3a
 y76Q==
X-Gm-Message-State: AOAM532G3WOiHrh3NDKhcscBlLUTDvtW+F1s2OXXS1wbuiCE+nba0X6k
 uu08cBo0qTXH7ZggnufWkcRozg==
X-Google-Smtp-Source: ABdhPJyREUOmY0oopxpqVsWNoQT7nWbdfr1Vdy9iBbfBmMZLheiuwxMRQWwkpUmDO9OPfVIeDPIYkA==
X-Received: by 2002:adf:a3d3:: with SMTP id m19mr30895774wrb.24.1618220979600; 
 Mon, 12 Apr 2021 02:49:39 -0700 (PDT)
Received: from localhost (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
 by smtp.gmail.com with ESMTPSA id l24sm14798836wmc.4.2021.04.12.02.49.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Apr 2021 02:49:39 -0700 (PDT)
Date: Mon, 12 Apr 2021 11:49:38 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] lightnvm: deprecated OCSSD support and schedule it for
 removal in Linux 5.15
Message-ID: <20210412094938.afyxzspcohw63zup@mpHalley.localdomain>
References: <20210412081257.2585860-1-hch@lst.de>
 <52ecf402-1361-e5a5-8c58-30d846d33541@lightnvm.io>
 <766257ca-4dd7-e20b-aa79-6ac3984567d4@lightnvm.io>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <766257ca-4dd7-e20b-aa79-6ac3984567d4@lightnvm.io>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210412_024941_099289_57BC8E5C 
X-CRM114-Status: GOOD (  14.87  )
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

T24gMTIuMDQuMjAyMSAxMToyNiwgTWF0aWFzIEJqw7hybGluZyB3cm90ZToKPk9uIDEyLzA0LzIw
MjEgMTEuMjEsIE1hdGlhcyBCasO4cmxpbmcgd3JvdGU6Cj4+T24gMTIvMDQvMjAyMSAxMC4xMiwg
Q2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4+PkxpZ2h0bnZtIHdhcyBhbiBpbm5vdmF0aXZlIGlk
ZWEgdG8gZXhwb3NlIG1vcmUgbG93LWxldmVsIGNvbnRyb2wgCj4+Pm92ZXIgU1NEcy4KPj4+QnV0
IGl0IGZhaWxlZCB0byBnZXQgcHJvcGVybHkgc3RhbmRhcmRpemVkIGFuZCByZW1haW5zIGEgbm9u
LXN0YW5kYXJpemVkCj4+PmV4dGVuc2lvbiB0byBOVk1lIHRoYXQgcmVxdWlyZXMgdmVuZG9yIHNw
ZWNpZmljIHF1aXJrcyBmb3IgYSBmZXcgCj4+Pm5vdyBtb3N0bHkKPj4+b2Jzb2xldGUgU1NEIGRl
dmljZXMuwqAgVGhlIHN0YW5kYXJkaXplZCBaTlMgY29tbWFuZCBzZXQgZm9yIE5WTWUgCj4+Pmhh
cyB0YWtlCj4+Pm92ZXIgYSBsb3Qgb2YgdGhlIGFwcHJvYWNoZXMgYW5kIGFsbG93cyBmb3IgZnVs
bHkgc3RhbmRhcmRpemVkIAo+Pj5vcGVyYXRpb24uCj4+Pgo+Pj5SZW1vdmUgdGhlIExpbnV4IGNv
ZGUgdG8gc3VwcG9ydCBvcGVuIGNoYW5uZWwgU1NEcyBhcyB0aGUgZmV3IHByb2R1Y3Rpb24KPj4+
ZGVwbG95bWVudHMgb2YgdGhlIGFib3ZlIG1lbnRpb25lZCBTU0RzIGFyZSB1c2luZyB1c2Vyc3Bh
Y2UgZHJpdmVyIAo+Pj5zdGFja3MKPj4+aW5zdGVhZCBvZiB0aGUgZmFpcmx5IGxpbWl0ZWQgTGlu
dXggc3VwcG9ydC4KPj4+Cj4+PlNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hA
bHN0LmRlPgo+Pj4tLS0KPj4+wqAgZHJpdmVycy9saWdodG52bS9LY29uZmlnIHwgNCArKystCj4+
PsKgIGRyaXZlcnMvbGlnaHRudm0vY29yZS5jwqAgfCAyICsrCj4+PsKgIDIgZmlsZXMgY2hhbmdl
ZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Pgo+Pj5kaWZmIC0tZ2l0IGEvZHJp
dmVycy9saWdodG52bS9LY29uZmlnIGIvZHJpdmVycy9saWdodG52bS9LY29uZmlnCj4+PmluZGV4
IDRjMmNlMjEwYzEyMzdkLi4wNGNhYTBmMmQ0NDVjNyAxMDA2NDQKPj4+LS0tIGEvZHJpdmVycy9s
aWdodG52bS9LY29uZmlnCj4+PisrKyBiL2RyaXZlcnMvbGlnaHRudm0vS2NvbmZpZwo+Pj5AQCAt
NCw3ICs0LDcgQEAKPj4+wqAgIwo+Pj7CoCDCoCBtZW51Y29uZmlnIE5WTQo+Pj4twqDCoMKgIGJv
b2wgIk9wZW4tQ2hhbm5lbCBTU0QgdGFyZ2V0IHN1cHBvcnQiCj4+PivCoMKgwqAgYm9vbCAiT3Bl
bi1DaGFubmVsIFNTRCB0YXJnZXQgc3VwcG9ydCAoREVQUkVDQVRFRCkiCj4+PsKgwqDCoMKgwqAg
ZGVwZW5kcyBvbiBCTE9DSwo+Pj7CoMKgwqDCoMKgIGhlbHAKPj4+wqDCoMKgwqDCoMKgwqAgU2F5
IFkgaGVyZSB0byBnZXQgdG8gZW5hYmxlIE9wZW4tY2hhbm5lbCBTU0RzLgo+Pj5AQCAtMTUsNiAr
MTUsOCBAQCBtZW51Y29uZmlnIE5WTQo+Pj7CoMKgwqDCoMKgwqDCoCBJZiB5b3Ugc2F5IE4sIGFs
bCBvcHRpb25zIGluIHRoaXMgc3VibWVudSB3aWxsIGJlIHNraXBwZWQgCj4+PmFuZCBkaXNhYmxl
ZAo+Pj7CoMKgwqDCoMKgwqDCoCBvbmx5IGRvIHRoaXMgaWYgeW91IGtub3cgd2hhdCB5b3UgYXJl
IGRvaW5nLgo+Pj7CoCArwqDCoMKgwqDCoCBUaGlzIGNvZGUgaXMgZGVwcmVjYXRlZCBhbmQgd2ls
bCBiZSByZW1vdmVkIGluIExpbnV4IDUuMTUuCj4+PisKPj4+wqAgaWYgTlZNCj4+PsKgIMKgIGNv
bmZpZyBOVk1fUEJMSwo+Pj5kaWZmIC0tZ2l0IGEvZHJpdmVycy9saWdodG52bS9jb3JlLmMgYi9k
cml2ZXJzL2xpZ2h0bnZtL2NvcmUuYwo+Pj5pbmRleCAyOGRkY2FhNTM1OGIxNC4uNDM5NGY0N2M4
MTI5NmEgMTAwNjQ0Cj4+Pi0tLSBhL2RyaXZlcnMvbGlnaHRudm0vY29yZS5jCj4+PisrKyBiL2Ry
aXZlcnMvbGlnaHRudm0vY29yZS5jCj4+PkBAIC0xMTc0LDYgKzExNzQsOCBAQCBpbnQgbnZtX3Jl
Z2lzdGVyKHN0cnVjdCBudm1fZGV2ICpkZXYpCj4+PsKgIHsKPj4+wqDCoMKgwqDCoCBpbnQgcmV0
LCBleHBfcG9vbF9zaXplOwo+Pj7CoCArwqDCoMKgIHByX3dhcm5fb25jZSgibGlnaHRudm0gc3Vw
cG9ydCBpcyBkZXByZWNhdGVkIGFuZCB3aWxsIGJlIAo+Pj5yZW1vdmVkIGluIExpbnV4IDUuMTUu
XG4iKTsKPj4+Kwo+Pj7CoMKgwqDCoMKgIGlmICghZGV2LT5xIHx8ICFkZXYtPm9wcykgewo+Pj7C
oMKgwqDCoMKgwqDCoMKgwqAga3JlZl9wdXQoJmRldi0+cmVmLCBudm1fZnJlZSk7Cj4+PsKgwqDC
oMKgwqDCoMKgwqDCoCByZXR1cm4gLUVJTlZBTDsKPj4KPj5UaGFua3MsIENocmlzdG9waC4KPj4K
Pj5JJ2xsIHNlbmQgaXQgdG8gSmVucyB3aXRoIHRvZGF5J3MgbGlnaHRudm0gUFIuCj4KPkphdmll
ciwgY2FuIEkgYWRkIHlvdXIgcmV2aWV3ZWQtYnk/Cj4KClllcywgcGxlYXNlLgoKSSdsbCBjcmFj
ayBhIGJlZXIgYW5kIGNoZWVyIG9uIGl0IHRvbmlnaHQuIEdvb2QgdGltZXMgOikKCkphdmllcgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZt
ZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
