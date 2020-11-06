Return-Path: <SRS0=7aSL=EM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D13C2D0A3
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 12:50:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EA82206B7
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 12:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QYKtkw7l";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="kO1sPY28"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EA82206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7+ehY4g+cZGghWtdkReqqqiqCON/xe/TDawMpcCo2JU=; b=QYKtkw7lX/IZGDgaWc5Fr2Sqx
	qpApUTTH7NIBstqyyh95UULiKRKxDO/gWRmE8NzQ4UCNTQQ8UQz8bpCtOKjcEy+1bMWHG/nd+EMF4
	iyvucqR2c9xZqxeovvEcgI7+O1GOwdBiXNOK0GuQd6XfFaRlFt+XWHkpdpApsYRkVo0QK2bgaREEF
	GoDQln+RchZkrFf9aXfzH08C6BSTCdQTPZxcs/aec/VzwgJGFVE11kd0lhv+iKVZyY2kX6LmVTpEb
	GTZ0JJW2TEBpsPJO1QpVo9v4PJXANsT2LNGF081dx7LFlDSjAZ4TB3UZ19tIC6UMwh/JMNC3lnP5b
	GTJINk7Yw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kb1Cc-0007Mi-N9; Fri, 06 Nov 2020 12:50:50 +0000
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kb1Ca-0007M0-Fg
 for linux-nvme@lists.infradead.org; Fri, 06 Nov 2020 12:50:49 +0000
Received: by mail-ej1-x62f.google.com with SMTP id gn41so1750618ejc.4
 for <linux-nvme@lists.infradead.org>; Fri, 06 Nov 2020 04:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=strmtWdm+k5ptLChAJrbO+TpgPoGYSR2cDidwW3Mcwo=;
 b=kO1sPY28ptiE0GLfJnTzYt5cPKS6DjFTKbVqFnrRFdjonYUSifbjUml/UM/G1u2LzF
 OajKZnXVsoplRTQzhpMF4m6g/R9o8LBDAAjDIYPKLJ/Dxyx0gCn2fqRoc8u9nOXNbxcG
 WiAsqxt6KFswN3XSnTRZkEkFEi2L4Cb7WKTsEy7R/qTDotse4kweciTxYEwslA0T3fBn
 NUS8+RCVumEDFKQcBX9Zw/Uu3s/DSp3gkEI/J3J7x+g0a+Nbs91+fUsTK3DAGkVKkEWp
 tLBYQhqEt3XtjaZqTtl+FU024poSnPLOfpxHKBkyNpHuz3PVxDOSau9zyL3qSgViW+nK
 E5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=strmtWdm+k5ptLChAJrbO+TpgPoGYSR2cDidwW3Mcwo=;
 b=MJA2sU+RS4ql+azs+2T04T0W93Xye3lwB4/vYDAVU7WQnHDakP4KDLhsT7TRhVrKQD
 f9HCY/TwGDKwQpgdUZWRURDczNZB/Wb8UbnHMaqZZEgHdZ84BuydOIkDpFDQkK7yZ7xn
 tkYG3ujgxX+y2rE2cYtGFR63MDUJTiWDwDVX7q0AelV5KqWzec5aHM+C/RJDtyXPJCYA
 EML+SfdXOs6HzuCgseZztCGem2U3e7ag4AMyT58E1EwGEJNYe7HZke8POjMX0xuG3gZ9
 8X89QoWtdv5HL2/CTa4UJYfFCIx9mzFuipBpkRPhw0Pt0kBDvENorPiuoyvSHU7i33s6
 ciKQ==
X-Gm-Message-State: AOAM533sjjOB60vGoHJAd0a5OOfCRf7b4Rz31fiMLSkL0fkvdmRNCoeK
 QhH4SUClvlcKuIJRr7RyaaC/wA==
X-Google-Smtp-Source: ABdhPJyS7MZE0GYEpEl+9QKyt7iJViEqm5q2luGNK5LxlM08aB7EV6UBMuaNGPj4b+YRMTk6cKHLuQ==
X-Received: by 2002:a17:906:3a59:: with SMTP id
 a25mr1928443ejf.546.1604667046957; 
 Fri, 06 Nov 2020 04:50:46 -0800 (PST)
Received: from localhost (5.186.126.247.cgn.fibianet.dk. [5.186.126.247])
 by smtp.gmail.com with ESMTPSA id b24sm937878edt.68.2020.11.06.04.50.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 04:50:46 -0800 (PST)
Date: Fri, 6 Nov 2020 13:50:45 +0100
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>,
 "\"linux-nvme@lists.infradead.org\"" <linux-nvme@lists.infradead.org>
Subject: Re: nvme: problem with chunk_sectors and blkzone
Message-ID: <20201106125045.2f3hesbweqfovcbf@MacBook-Pro.localdomain>
References: <20201106123441.wjci7i3gij7jgpue@MacBook-Pro.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201106123441.wjci7i3gij7jgpue@MacBook-Pro.localdomain>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201106_075048_564741_A50379B8 
X-CRM114-Status: GOOD (  15.96  )
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
Cc: Klaus Jensen <its@irrelevant.dk>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T0ssIGlnbm9yZSB0aGlzLiBJIHdhcyBpbiBhIG1pZC12ZXJzaW9uIGZyb20gT2N0b2JlciB3aGVy
ZSBJIHdhcyBnZXR0aW5nCmNodW5rX3NlY3RvcnMgdG8gYmUgMC4gSnVzdCBwdWxsZWQgYW5kIGl0
IGlzIE9LLgoKU29ycnkgZm9yIHRoZSBub2lzZS4KCkphdmllcgoKT24gMDYuMTEuMjAyMCAxMzoz
NCwgSmF2aWVyIEdvbnrDoWxleiB3cm90ZToKPktlaXRoLAo+Cj5JIGhhdmUgbm90aWNlZCB0aGF0
IG9uZSBvZiB0aGUgcGF0Y2hlcyBtZXJnZWQgc29tZSB0aW1lIGFnbywgd2hlcmUgd2UKPmFyZSBh
dm9pZGluZyB0byBzZXQgY2h1bmtfc2VjdG9ycyBkdWUgdG8gdGhlIGxhY2sgb2Ygbm9pb2IgaW5k
aXJlY3RseQo+YnJlYWtzIGJsa3pvbmUKPgo+ICAgZTgzZDc3NmY5Zjk4YiBudm1lOiBvbmx5IHVz
ZSBwb3dlciBvZiB0d28gaW8gYm91bmRhcmllcwo+Cj5pZiBpZC0+bm9pb2IgaXMgbm90IHNldCwg
dGhlbiBjaHVua19zZWN0b3JzIGlzIHNldCB0byAwLCB3aGljaCB0dXJucyBvdXQKPmluIGJsa3pv
bmUgZmFpbGluZyBpbiBaTlMgU1NEcyBub3Qgc2V0dGluZyB0aGUgSU8gYm91bmRhcnkKPgo+ICAg
IGJsa3pvbmU6IC9kZXYvbnZtZTBuMTogdW5hYmxlIHRvIGRldGVybWluZSB6b25lIHNpemUKPgo+
VGhpcyBpcyBlYXN5IHJlcHJvZHVjZWFibGUgd2l0aCBRRU1VCj4KPkFtIEkgbWlzc2luZyBzb21l
dGhpbmcgaGVyZT8KPgo+SSBhbSBoYXBweSB0byBzZW5kIGEgcGF0Y2ggdG8gdXRpbHMtbGludXgg
Zml4aW5nIHRoaXMgKGhhdmUgb25lIHdpdGggbWUKPmFzIEkgbG9va2VkIGludG8gdGhlIHByb2Js
ZW0pLCBidXQgSSB0aGluayBpdCBpcyB3b3J0aCByZXBvcnRpbmcgdGhpcyBhcwo+aXQgaXMgZWZm
ZWN0aXZlbHkgYnJlYWtpbmcgdXNlci1zcGFjZS4KPgo+VGhvdWdodHM/Cj4KPkphdmllcgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBt
YWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
