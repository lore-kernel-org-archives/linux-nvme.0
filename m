Return-Path: <SRS0=q3TM=63=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C39C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2020 19:54:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E75C205ED
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2020 19:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="seuzNsJ7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gaeM4bgK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E75C205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2+ph3QJS5rUBoKQdA67IZooebJg5wq8SB/qPMVbOnSE=; b=seuzNsJ77GUECfNeEcdKNLyPh
	73ZfQ7u61mtnkyORHd927rAbd3p3CE3DNNoGKdrz6HJ7bll3u80Itxyu5hV7QhA7+qk7TCGQzIMJw
	h8w4i7sK0r+Z08ksiy04gaFAiKVKuzUDjFTDFQhgydpFrAl6RPY3Jf9PaaC2gulOGCAZzwXZB1UEy
	+kQ5bxmoU6nWJOFPk7KMx7ZgZdJGLrYrN07wc2m8cnATpypX9tcl3+KB6p1EsU8rBKFhqJj1SHwXX
	8ZgQBnUv2Ixprq/DBVx1iWh1azFeVkUQ/rR4AHJd+JJlj4pNJwmFtoRuSFhUAy6ytFEOADyz8JiBH
	97RwCjwiQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jYxS7-0004iv-TE; Wed, 13 May 2020 19:54:03 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jYxS5-0004iR-6b
 for linux-nvme@lists.infradead.org; Wed, 13 May 2020 19:54:02 +0000
Received: by mail-pl1-x643.google.com with SMTP id g11so252135plp.1
 for <linux-nvme@lists.infradead.org>; Wed, 13 May 2020 12:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=bA9sJQu5D8GxavI1B3EV6D+WGCmjWa5x+kbGuqht7ZM=;
 b=gaeM4bgKGmuYxrDWzVuaKHc6VxsDfxyF8+dSLHJWpsQz9rwG3qgrlSasTQvXdNzwQJ
 LklFX4i5kV3ntfm45XAlxi0cN/5qRfOivTNvF+qy8xHJ1R+HJPICHvvFWSFlrhOaqJF+
 9RDh8e9fJ59z8/KnsOD/T7cxMAve755AyWyCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=bA9sJQu5D8GxavI1B3EV6D+WGCmjWa5x+kbGuqht7ZM=;
 b=LA15tlLcKtiddnP23m7g+RHKUkZ5HaDScukep5QgwaAH+Y1Fw0gW9J3ob/yMB89DKj
 TnjsmnqN48q9K1lfar5hwx7q1NsShpzWOl7I8va19U6ZAaS8YkdP2A/OtVpWwjjiukUT
 tm4SnB4JJo7Jg0z7lSV8/tBBp343yKM6k2JjKS1nJUwkOemSXj30TrvScnxvcT3hnMg/
 PRzB8R1Q47j6Oa8MaGYfiKd2Vl45bmKqon6hiK+BBw/0i3xb9gHNPjzDAEWY/dFABQAK
 htYjQ6agHBxN76YatVFHocgmYpQAtJdo+sXQNrXanSBladk2IXKdVbj9yloApB+eOPZ7
 i5rA==
X-Gm-Message-State: AGi0Pub5s2/j6p1/U3h+qhg5gzSbpGHJ3vjHcyUq4p7smYo6KMXZmzGs
 e5Ws2DUAj7UAoumqomFPeedNHw==
X-Google-Smtp-Source: APiQypKuf71Soa8OvobF0mFfrvbci9UpTlQAy0TW7sRP39GWwYaI9zQyIRilAvK0rS+xIvodE0ajsw==
X-Received: by 2002:a17:90a:68cb:: with SMTP id
 q11mr35867603pjj.15.1589399640559; 
 Wed, 13 May 2020 12:54:00 -0700 (PDT)
Received: from [10.230.185.151] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id a16sm428700pgg.23.2020.05.13.12.53.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2020 12:53:59 -0700 (PDT)
Subject: Re: [PATCH 03/16] nvme: introduce NVME_NS_METADATA_SUPPORTED flag
To: Christoph Hellwig <hch@lst.de>
References: <20200504155755.221125-1-maxg@mellanox.com>
 <20200504155755.221125-4-maxg@mellanox.com>
 <e21354ca-a7bb-cf2d-d427-c8410c797a49@broadcom.com>
 <71c7458e-81cd-7200-2e1b-3563cdddd5ad@mellanox.com>
 <62322680-afeb-142e-c10b-b4f2d4c419a3@broadcom.com>
 <1b03c314-2e57-5135-6875-a2d37ecf5e20@mellanox.com>
 <cca0ab45-7dde-c461-b20f-d44f58a8a117@broadcom.com>
 <20200513181859.GA29596@lst.de>
From: James Smart <james.smart@broadcom.com>
Message-ID: <04237a04-a18e-f5b6-84c6-5d258b9509a9@broadcom.com>
Date: Wed, 13 May 2020 12:53:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200513181859.GA29596@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200513_125401_245061_62964770 
X-CRM114-Status: GOOD (  10.32  )
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
 martin.petersen@oracle.com, idanb@mellanox.com, israelr@mellanox.com,
 vladimirk@mellanox.com, linux-nvme@lists.infradead.org, shlomin@mellanox.com,
 oren@mellanox.com, kbusch@kernel.org, Max Gurtovoy <maxg@mellanox.com>,
 nitzanc@mellanox.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gNS8xMy8yMDIwIDExOjE4IEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBPbiBNb24s
IE1heSAxMSwgMjAyMCBhdCAwNDo1MDowOVBNIC0wNzAwLCBKYW1lcyBTbWFydCB3cm90ZToKPj4g
TGV0cyBtb3ZlIG9uLiBJJ3ZlIGJlZW4gYSBsaXR0bGUgc2hvcnQgb2YgdGltZS4gSSBzaG91bGQg
cmV2aWV3IHRoZSBtZWF0aWVyCj4+IHBhdGNoLCBwYXRjaCA2LCB0b21vcnJvdyBzb21ldGltZS4K
PiBDYW4geW91IGdldCB0byBpdD8gIEknZCBsaWtlIHRvIHBpY2sgdGhpcyBzZXJpZXMgdXAgaW4g
dGhlIG5leHQgZGF5cy4KCmNvbW1lbnRzIHBvc3RlZC7CoCBBIGZldyBxdWVzdGlvbnMsIGJ1dCBv
bmx5IHBhdGNoIDE0IHNpZ25pZmljYW50LgoKLS0gamFtZXMKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LW52bWUgbWFpbGluZyBsaXN0CmxpbnV4
LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
