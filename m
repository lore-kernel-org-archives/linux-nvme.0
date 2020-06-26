Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B04CC433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 12:06:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03CB8206A1
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 12:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DoOGHBBD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="v8dW+IFT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="tT7nV1Te"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03CB8206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RXNYlk8W7JE2vUAGcB+o9InOh0QcVmy+r3A4I1rCriM=; b=DoOGHBBD4LeoImqQ3eUpTZQkg
	FnzD5Qju0EeD7kZOCeFJry90T5pXHBE7gXxxz/lTyKedu72ddr3hAurd/ql91gtx4mR9GmOT4BZUz
	g50eWrOzJpR+NdlkJ2++0wRTXx9oKjE0jWFRhG/1gsiL+CHtUSmvNVaCe2v5YthHoGlVy2+UyKnQh
	M3V1c98YXVhzF4WKkXtFGZfdTwJL7+rYfLA2FdrbCEkKGufPFcXlssWweE5fyCcVLol73qyHp62Kr
	zymUd+KcrZuNMAt6ai8JmCzNveSmOo3sZppLF7/sN1YguiohFyr2E0Ysexn1+R73qiafiwjZeLF7N
	bZLFlriwg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jon7l-0004Qo-Ng; Fri, 26 Jun 2020 12:06:29 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jolgp-0006nd-4L
 for linux-nvme@merlin.infradead.org; Fri, 26 Jun 2020 10:34:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=AzDDRheHUhY185mnHnU6umoSLP34BhkSmEM5f6A4LJg=; b=v8dW+IFT3O0Z3abaIw7FMxwQU3
 bdRcWNzf/Estffd8mg5nQb4+ZBFl8lD6yGqrqN6C0g95Ay3Cyah4UQq1YiDLjpiB3yzJ40eftxFU4
 aS02IRUNmfRWpY2mW4QCQ8P/Oc6TzUgp51P/6QVOiBlYkEEVgBG2+YyWBT0YCg52i5R1FSPpCb4m9
 udKButGu4YtWafxgavljlE28/8MK3BvvG51nuY1KKlymIt2k4aGZLRrGVDDgTExx+zzEBietBvqkv
 y6j5yStUtDQUxK/PA1E/IyE1hHz5tQF1aTfHnLVY7qwnk9YQ88KrE7h49eRE3P3gYA8SJ/kDrCYvy
 2n3vR6Nw==;
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jold0-0001iE-8E
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 10:30:42 +0000
Received: by mail-lj1-x243.google.com with SMTP id s9so9740502ljm.11
 for <linux-nvme@lists.infradead.org>; Fri, 26 Jun 2020 03:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=AzDDRheHUhY185mnHnU6umoSLP34BhkSmEM5f6A4LJg=;
 b=tT7nV1TeVyZmOIRwWW8pXIvN+bE2pCzlrSuPn/QfwVR89JBCT/6SKOncr3PfXxfZra
 N9qPJJ+hlXjdObv7AIC9tqSE1wnZ4c/+Egoxy9AerrV97nm71wPm0dmmJ41KHDaQwwqG
 wmGxBaO7Fs6enkeLGBQD7/p+C6NgX5YzkzLz7Z+8pa15DYjcEWR8WDrsWEWtPUA5qwDN
 qZaCE3qdGDspdz5fDXZWL/A6T2SaINEy5agaG9J+jBeWHz92F3DVChRW7Q42d9hHGsZB
 lVWlW6KFrigE4tqsTBz/AYZdXrzLVqPq0PBDlSajv3kSCN+gnXMjufrtoptTL4pTDGnu
 LVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=AzDDRheHUhY185mnHnU6umoSLP34BhkSmEM5f6A4LJg=;
 b=Q3ITSubu9RqyaMRJkzapR286B72YxlK8zxtE21U//ZqUiyaqSGuc3rsfqPo3A9jr1r
 rZSc77+fFd+2Zo/qIudqh8X4s0cUzwwjPGtzLO0AkEWpU4Y++DhLqjg9EnfhDMxoqBHW
 ShSr7y/NX/jpT/a7YYfALAGJnsYRXCmW6UkZj5Y1fzrIi8yq0LQNK9RhbnOMQLn92kuP
 cL+jpQ8CpXnts+S2MhK9kZVCCHuaZ6b1+IVaKL03dYipD8y2E4+qbYSS7k6LxDvDOMD0
 cz+gjZT0nephoJjKUivZDP2qrU191Gu3kVD5QG2Xv1OoU5d7gNXJywRJgh4ADAinTNaz
 dcDg==
X-Gm-Message-State: AOAM5329pONuPn7dzcgrB8F3JrbD1By+SsRdks7yWTbXI310AnfayRy4
 wyg6jQeKSMcdznDnK9JjMEcivTqXyAsjKdVI
X-Google-Smtp-Source: ABdhPJyYGx/O8hAK6UqSEG3yplNXNzReJQLm+jwjU8n0LvASNpJ9MetUicOYf+so3pzi5jhHS9OCXQ==
X-Received: by 2002:a17:906:f752:: with SMTP id
 jp18mr1213481ejb.538.1593152910112; 
 Thu, 25 Jun 2020 23:28:30 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
 by smtp.gmail.com with ESMTPSA id i33sm2204590edi.21.2020.06.25.23.28.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 23:28:29 -0700 (PDT)
Date: Fri, 26 Jun 2020 08:28:28 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 4/6] block: introduce IOCTL to report dev properties
Message-ID: <20200626062828.cmt3ccowzifxn42g@mpHalley.localdomain>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-5-javier@javigon.com>
 <6333b2f1-a4f1-166f-5e0d-03f47389458a@lightnvm.io>
 <20200625194248.44rwwestffgz4jks@MacBook-Pro.localdomain>
 <20200625202534.GA28784@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200625202534.GA28784@redsun51.ssa.fujisawa.hgst.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200626_113038_805080_A46EB79A 
X-CRM114-Status: UNSURE (   9.48  )
X-CRM114-Notice: Please train this message.
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
Cc: axboe@kernel.dk, SelvaKumar S <selvakuma.s1@samsung.com>, sagi@grimberg.me,
 Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org,
 Nitesh Shetty <nj.shetty@samsung.com>, linux-block@vger.kernel.org,
 Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>, hch@lst.de
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMjYuMDYuMjAyMCAwNToyNSwgS2VpdGggQnVzY2ggd3JvdGU6Cj5PbiBUaHUsIEp1biAyNSwg
MjAyMCBhdCAwOTo0Mjo0OFBNICswMjAwLCBKYXZpZXIgR29uesOhbGV6IHdyb3RlOgo+PiBXZSBj
YW4gdXNlIG52bWUgcGFzc3RocnUsIGJ1dCB0aGlzIGJ5cGFzc2VzIHRoZSB6b25lZCBibG9jayBh
YnN0cmFjdGlvbi4KPj4gV2h5IG5vdCByZXByZXNlbnRpbmcgWk5TIGZlYXR1cmVzIGluIHRoZSBz
dGFuZGFyZCB6b25lZCBibG9jayBBUEk/Cj4KPlRoaXMgbG9va3MgdG9vIG52bWUgem5zIHNwZWNp
ZmljIHRvIHdhbnQgdGhlIGJsb2NrIGxheWVyIGluIHRoZSBtaWRkbGUuCj5KdXN0IHVzZSB0aGUg
ZHJpdmVyJ3MgcGFzc3Rocm91Z2ggaW50ZXJmYWNlLgoKT2suIElzIGl0IE9LIHdpdGggeW91IHRv
IGV4cG9zZSB0aGVtIGluIHN5c2ZzIGFzIERhbWllbiBzdWdnZXN0ZWQ/CgpKYXZpZXIKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFp
bGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
