Return-Path: <SRS0=zNYX=IX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B7EC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Mar 2021 12:33:54 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FE1D619F7
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Mar 2021 12:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE1D619F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=oUVgepcorkBdZp8zotCHZDsb+0iOvaLmMlysQgKyX2U=; b=IxTwffoJmIAYmzM2mnA7Lpanj
	yCtEGnPJHA1q6nyzRw8uIhd0QbdGt19Bzpsl2GmqD/59/G3k+iANdtbl+NKGBhIITL2g/TKKxSWjL
	ysv7QDZ/sJ8G9ZKquHQ0s2FBE0BEIgFJKh1TjqtV8MWi/6FVqE0G7ZoXxTGxlpsPA+Dm/KHxnnoiz
	pl6HQQLrSnRRqqXnyl891KCZMq75A+wnRTMhBFWejGLo8UpLpqQ8mxyNmRYe2CilMbms3zAomSLnc
	Qb4VJGwjeEDBgruElr++5Ctg+mA4qeEkDA2qlvxFN94TahJAJqsSe5Ml9YMs1XL6/RYryeGFLUmen
	XVSvCb6lA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lPPBB-001OWN-Ox; Thu, 25 Mar 2021 12:33:38 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lPPB6-001OV5-Ji
 for linux-nvme@lists.infradead.org; Thu, 25 Mar 2021 12:33:34 +0000
Received: by mail-pf1-x429.google.com with SMTP id m11so1889462pfc.11
 for <linux-nvme@lists.infradead.org>; Thu, 25 Mar 2021 05:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=KktxKyKGelQgcFPIDO5e1S/J3rfhBJ49hV8MaJBU4dk=;
 b=rWEIbq+++v1UuZrd75mrg1rmM+nvqDsfDOn2UKyVzY0XZGG7oRPKUQjiD8KOh3nw3z
 P1Gr1L/K7L7sk4ESPJ5XW5OYXJfXLNRe6vpw00a8HKpEkHLnU1q1LEAdkMrSJw+IYo3h
 NFLVq4bC5rigCjyE8+k1Z5/vBG8k9065Nb6qAF9FiL7ftor8PWuySMUgyPOTDG6z+fD1
 KlmdKEGPu8IHpVXOUKZXxT7JUD6K6IDDwmvhO/kghTvBjArl2UAeTEj+sPMGmUk8jZgM
 qqtQatiE8ZFE3FWcUpxqFetkxziDMWVAak9gcUtYUIG0rn5f8b73F+bMc/piG3/4ZBc1
 Rl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=KktxKyKGelQgcFPIDO5e1S/J3rfhBJ49hV8MaJBU4dk=;
 b=giyj3rU8xhN+GoJfJi6IwLZic3buIj1lCtI2QTsXdvyDvQa4TX7b9cF/NKO8FkDbUf
 1zYeVLGMlSXOSI2uBtwr2wYAsUL6IsMHkriKe4Sh3v0yr+mJ2qJv+TJafEeh+R7aK7fA
 26Q4/5WbIOwMkKxYVqz5UcVNEC70+kOJBr5+FQtB0hSuoEkP5cvk1ixAbJs80GO1K4dS
 7zZGCL5I2aK/LMSbCxI/PuG36h2X0O/1MPKfWBSY+3ff9AoDXxt5hAiFoWlRTQFn/qBE
 0YGAMHkP1/HrekG4JvZXVv9sWk603ZMCSw5+nTdkt9HGoF45yL67g8tfsbQqzarH8fVa
 Bz8g==
X-Gm-Message-State: AOAM5317X7e/yNcqAn/DuOaWvA9aI61tGbb5Wgvvp+IlIBs4H+4dLGF7
 2Q8qmN/sfn6J9m/CTZ8gfjQ=
X-Google-Smtp-Source: ABdhPJyc15D3EFn6gprEFDfqD/4hhRaU92zL/wilIwXfEsQZ+kkBiBNoig6lvtUuPDqyFUmm7roqYQ==
X-Received: by 2002:a17:902:8685:b029:e6:5ff6:f7df with SMTP id
 g5-20020a1709028685b02900e65ff6f7dfmr9426404plo.40.1616675611172; 
 Thu, 25 Mar 2021 05:33:31 -0700 (PDT)
Received: from localhost ([58.127.46.74])
 by smtp.gmail.com with ESMTPSA id d11sm6388387pfd.43.2021.03.25.05.33.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Mar 2021 05:33:30 -0700 (PDT)
Date: Thu, 25 Mar 2021 21:33:29 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: "javier@javigon.com" <javier@javigon.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>,
 "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH V6 1/2] nvme: enable char device per namespace
Message-ID: <20210325123329.GA3850@localhost>
References: <20210301192452.16770-1-javier.gonz@samsung.com>
 <20210301192452.16770-2-javier.gonz@samsung.com>
 <YFyBM1qq+AmYQvdl@x1-carbon.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YFyBM1qq+AmYQvdl@x1-carbon.lan>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210325_123332_975104_22757DFE 
X-CRM114-Status: GOOD (  19.09  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMjEtMDMtMjUgMTI6MjU6MjQsIE5pa2xhcyBDYXNzZWwgd3JvdGU6Cj4gT24gTW9uLCBNYXIg
MDEsIDIwMjEgYXQgMDg6MjQ6NTFQTSArMDEwMCwgamF2aWVyQGphdmlnb24uY29tIHdyb3RlOgo+
ID4gRnJvbTogSmF2aWVyIEdvbnrDoWxleiA8amF2aWVyLmdvbnpAc2Ftc3VuZy5jb20+Cj4gPiAK
PiA+IENyZWF0ZSBhIGNoYXIgZGV2aWNlIHBlciBOVk1lIG5hbWVzcGFjZS4gVGhpcyBjaGFyIGRl
dmljZSBpcyBhbHdheXMKPiA+IGluaXRpYWxpemVkLCBpbmRlcGVuZGVudGx5IG9mIHdoZXRoZXIg
dGhlIGZlYXR1cmVzIGltcGxlbWVudGVkIGJ5IHRoZQo+ID4gZGV2aWNlIGFyZSBzdXBwb3J0ZWQg
YnkgdGhlIGtlcm5lbC4gVXNlci1zcGFjZSBjYW4gdGhlcmVmb3JlIGFsd2F5cwo+ID4gaXNzdWUg
SU9DVExzIHRvIHRoZSBOVk1lIGRyaXZlciB1c2luZyB0aGUgY2hhciBkZXZpY2UuCj4gPiAKPiA+
IFRoZSBjaGFyIGRldmljZSBpcyBwcmVzZW50ZWQgYXMgL2Rldi9udm1lLWdlbmVyaWMtWGNZblou
IFRoaXMgbmFtaW5nCj4gPiBzY2hlbWUgZm9sbG93cyB0aGUgY29udmVudGlvbiBvZiB0aGUgaGlk
ZGVuIGRldmljZSAobnZtZVhjWW5aKS4gU3VwcG9ydAo+ID4gZm9yIG11bHRpcGF0aCB3aWxsIGZv
bGxvdy4KPiAKPiBEbyB3ZSBwZXJoYXBzIHdhbnQgdG8gcHV0IHRoZXNlIG5ldyBjaGFyYWN0ZXIg
ZGV2aWNlcyBpbnNpZGUgYSBzdWJkaXI/Cj4gZS5nLiAvZGV2L252bWUvbnZtZS1nZW5lcmljLVhj
WW5aID8KPiAKPiBPdGhlcndpc2UgaXQgZmVlbHMgbGlrZSBkb2luZyBzdWNoIGEgc2ltcGxlIHRo
aW5nIGFzIGxzIC1hbCAvZGV2L252bWUqCj4gd2lsbCBzaG93IGEgbG90IG9mIGRldmljZXMgYmVj
YXVzZSBvZiB0aGVzZSBuZXcgc3BlY2lhbGl6ZWQgY2hhciBkZXZpY2VzLgoKR29vZCBwb2ludC4g
IElmIHdlIGhhdmUgdGhvdXNhbmRzIG9mIG5hbWVzcGFjZXMsIGl0IHdpbGwgY3JlYXRlIDIgdGlt
ZXMKb2YgdGhlIGJsa2RldnMuICBJIHdvdWxkIGhlYXIgd2hhdCBtYWludGFpbmVycyBzYXkgYWJv
dXQgdGhpcyA6KQoKRllJOiBuZXcgdmVyc2lvbiBoYXMgYmVlbiBwb3N0ZWQgd2l0aCBWMSBieSBy
ZS1jcmVhdGUgdGhpcyBzZXJpZXMgd2l0aApKYXZpZXIuICBQbGVhc2UgaGF2ZSBhIGRpc2N1c3Mg
dGhlcmU6CgogICAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtbnZtZS8yMDIxMDMyNTEy
MzA0OC45NDc4NC0xLW1pbndvby5pbS5kZXZAZ21haWwuY29tL1QvI3UKClRoYW5rcyEKCj4gCj4g
Cj4gS2luZCByZWdhcmRzLAo+IE5pa2xhcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtbnZtZQo=
