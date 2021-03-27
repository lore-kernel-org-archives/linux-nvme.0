Return-Path: <SRS0=f1t1=IZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92467C433C1
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Mar 2021 07:52:05 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27B97619C9
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Mar 2021 07:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27B97619C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=aNzLiEKBBDdWFZ/ePauWhyHZd1N9cS1jfXK+gdJbA0U=; b=SW1fVvnW8XVGsff7ltJ9Abwwu
	o3tw4sZOt1cMtUISKoUsFKYmSbtv6lkLMeQ8+LpCBsCEEyZwHfK3C20+iltScP6D/X6s4CC4e64Jc
	7zB/Qiv5pyzZo2JXge/ioD4dAC2fvmcjbmYWErWYlx4b+KLzrRnXBLnW9f3xe3/CwDKDZX0/lcM8s
	Ukzu+IPJyBvPGzIAerlUbDyQc8BQnz+s/dzPN2X+Xwq7EUWRffEVAgJDbQg9ooabQGKWEzWi74dNd
	hdwzz06zeRPhbPUURJDe9KfU7UDhrbQz4gASY2OqTZSl1t0yt3uEPeZ+sz6sg5Y0nxswYkbp8eFMh
	ij1qGUwng==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lQ3je-004t4p-KF; Sat, 27 Mar 2021 07:51:54 +0000
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lQ3ja-004t4C-0h
 for linux-nvme@lists.infradead.org; Sat, 27 Mar 2021 07:51:51 +0000
Received: by mail-ej1-x630.google.com with SMTP id r12so11783723ejr.5
 for <linux-nvme@lists.infradead.org>; Sat, 27 Mar 2021 00:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=Xsip9CSoJsuDo1J1wjfyLqKOAiGEpLyyYQJBNxTGRlE=;
 b=tGdqc3yWSNHNSmSBytobf1q2yGCF1aPdGvc+tf54sIHWW2+yRXT7nkOLzPmJ4fm8AK
 JwkC0fJ8OrTc+59xiIaeMmfIhtMSDqmOXKYeD0Mnfx7C/yELSTHUtNXppzQpU7qsSf3/
 MiPig6fWb/lW6N6SqcBD85K5bGCwuoja9iVvjrNkDbS6xwruTP4Fh+f3QcgAgqjqwNcR
 JiL4C2WdetgQEuVF8reZffKTSAovIFEZ/Mz+3fJOvvcazS2tWhn8Hy2I3Xn1P5qRfQx8
 vGiZLqWnas5RRZiOPXLZiClkuiXpqAp8VXbY5S2ViEetb8CFuHuw2Rztvx29hEm4OI52
 Pkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=Xsip9CSoJsuDo1J1wjfyLqKOAiGEpLyyYQJBNxTGRlE=;
 b=ADc5sgpdPd1DJ9bydc6NRlf6IG4wHXpM7MGwtamZHGY8VMa7k0Hz9EKtvWcC1eI1cf
 wtJCG33AaclmlRdiv+FaesqDGfO0IoaHpt5qGVEXYDilwq5N4hHJHIhy+kbvviYlIOGS
 9njbJLcb03RfjJOMhLrCyhjh+RMbUoI+p8MvaSvyTpTfHVmP8KBiQPe4itW2MliSqU9a
 tYOuiYMxKcPL5DybN5KjG3XHNl3OEr0+vPZyBQNQvzx1hThHGk84tDuBiPLZYYEMtcyD
 TXQBDxTNWX7cXSW8SWppTZ2jo2KtdyG42dyxrnRrSkOsxtwQE17GQL02uIqiLR/WdPxS
 uoTg==
X-Gm-Message-State: AOAM533YloQmPWngQxILdHd9RJG0FBBGiXREysjzUtjq//LprIedg7Rb
 4+qZ0QEleuVN+w2YbMYD17E5sg==
X-Google-Smtp-Source: ABdhPJySG+XVg0zU1mtv4oLycVhADK4Th0rCc42g7M1yPT66xibCkx+pwuPMRB2mxRPMSlb5bNaLDg==
X-Received: by 2002:a17:906:cb18:: with SMTP id
 lk24mr18512026ejb.70.1616831506265; 
 Sat, 27 Mar 2021 00:51:46 -0700 (PDT)
Received: from localhost (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
 by smtp.gmail.com with ESMTPSA id j7sm5335055edv.40.2021.03.27.00.51.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Mar 2021 00:51:45 -0700 (PDT)
Date: Sat, 27 Mar 2021 08:51:45 +0100
From: "javier@javigon.com" <javier@javigon.com>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 "minwoo.im.dev@gmail.com" <minwoo.im.dev@gmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: nvme: disallow passthru cmd from targeting a nsid != nsid of the
 block dev
Message-ID: <20210327075145.ecbjov5prhq2vjh7@mpHalley.local>
References: <20210326194749.396599-1-Niklas.Cassel@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210326194749.396599-1-Niklas.Cassel@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210327_075150_178116_D1D109DE 
X-CRM114-Status: GOOD (  12.25  )
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

T24gMjYuMDMuMjAyMSAxOTo0OCwgTmlrbGFzIENhc3NlbCB3cm90ZToKPkZyb206IE5pa2xhcyBD
YXNzZWwgPG5pa2xhcy5jYXNzZWxAd2RjLmNvbT4KPgo+V2hlbiBhIHBhc3N0aHJ1IGNvbW1hbmQg
dGFyZ2V0cyBhIHNwZWNpZmljIG5hbWVzcGFjZSwgdGhlIG5zIHBhcmFtZXRlciB0bwo+bnZtZV91
c2VyX2NtZCgpL252bWVfdXNlcl9jbWQ2NCgpIGlzIHNldC4gSG93ZXZlciwgdGhlcmUgaXMgY3Vy
cmVudGx5IG5vCj52YWxpZGF0aW9uIHRoYXQgdGhlIG5zaWQgc3BlY2lmaWVkIGluIHRoZSBwYXNz
dGhydSBjb21tYW5kIHRhcmdldHMgdGhlCj5uYW1lc3BhY2UvbnNpZCByZXByZXNlbnRlZCBieSB0
aGUgYmxvY2sgZGV2aWNlIHRoYXQgdGhlIGlvY3RsIHdhcwo+cGVyZm9ybWVkIG9uLgo+Cj5BZGQg
YSBjaGVjayB0aGF0IHZhbGlkYXRlcyB0aGF0IHRoZSBuc2lkIGluIHRoZSBwYXNzdGhydSBjb21t
YW5kIG1hdGNoZXMKPnRoYXQgb2YgdGhlIHN1cHBsaWVkIG5hbWVzcGFjZS4KPgo+U2lnbmVkLW9m
Zi1ieTogTmlrbGFzIENhc3NlbCA8bmlrbGFzLmNhc3NlbEB3ZGMuY29tPgo+LS0tCj5DaGFuZ2Vz
IHNpbmNlIHYxOgo+LUFkZGVkIGVycm9yIHByaW50Lgo+Cj4gZHJpdmVycy9udm1lL2hvc3QvY29y
ZS5jIHwgMTIgKysrKysrKysrKysrCj4gMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKykK
Pgo+ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyBiL2RyaXZlcnMvbnZtZS9o
b3N0L2NvcmUuYwo+aW5kZXggZjEzZWI0ZGVkOTVmLi5hNTAzNTJlYTNmN2IgMTAwNjQ0Cj4tLS0g
YS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPisrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUu
Ywo+QEAgLTE1OTksNiArMTU5OSwxMiBAQCBzdGF0aWMgaW50IG52bWVfdXNlcl9jbWQoc3RydWN0
IG52bWVfY3RybCAqY3RybCwgc3RydWN0IG52bWVfbnMgKm5zLAo+IAkJcmV0dXJuIC1FRkFVTFQ7
Cj4gCWlmIChjbWQuZmxhZ3MpCj4gCQlyZXR1cm4gLUVJTlZBTDsKPisJaWYgKG5zICYmIGNtZC5u
c2lkICE9IG5zLT5oZWFkLT5uc19pZCkgewo+KwkJZGV2X2VycihjdHJsLT5kZXZpY2UsCj4rCQkJ
IiVzOiBuc2lkICgldSkgaW4gY21kIGRvZXMgbm90IG1hdGNoIG5zaWQgKCV1KSBvZiBuYW1lc3Bh
Y2VcbiIsCj4rCQkJY3VycmVudC0+Y29tbSwgY21kLm5zaWQsIG5zLT5oZWFkLT5uc19pZCk7Cj4r
CQlyZXR1cm4gLUVJTlZBTDsKPisJfQo+Cj4gCW1lbXNldCgmYywgMCwgc2l6ZW9mKGMpKTsKPiAJ
Yy5jb21tb24ub3Bjb2RlID0gY21kLm9wY29kZTsKPkBAIC0xNjQzLDYgKzE2NDksMTIgQEAgc3Rh
dGljIGludCBudm1lX3VzZXJfY21kNjQoc3RydWN0IG52bWVfY3RybCAqY3RybCwgc3RydWN0IG52
bWVfbnMgKm5zLAo+IAkJcmV0dXJuIC1FRkFVTFQ7Cj4gCWlmIChjbWQuZmxhZ3MpCj4gCQlyZXR1
cm4gLUVJTlZBTDsKPisJaWYgKG5zICYmIGNtZC5uc2lkICE9IG5zLT5oZWFkLT5uc19pZCkgewo+
KwkJZGV2X2VycihjdHJsLT5kZXZpY2UsCj4rCQkJIiVzOiBuc2lkICgldSkgaW4gY21kIGRvZXMg
bm90IG1hdGNoIG5zaWQgKCV1KSBvZiBuYW1lc3BhY2VcbiIsCj4rCQkJY3VycmVudC0+Y29tbSwg
Y21kLm5zaWQsIG5zLT5oZWFkLT5uc19pZCk7Cj4rCQlyZXR1cm4gLUVJTlZBTDsKPisJfQo+Cj4g
CW1lbXNldCgmYywgMCwgc2l6ZW9mKGMpKTsKPiAJYy5jb21tb24ub3Bjb2RlID0gY21kLm9wY29k
ZTsKPi0tIAo+Mi4zMC4yCgpMb29rcyBnb29kIHRvIG1lCgpSZXZpZXdlZC1ieTogSmF2aWVyIEdv
bnrDoWxleiA8amF2aWVyQGphdmlnb24uY29tPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtbnZtZQo=
