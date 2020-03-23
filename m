Return-Path: <SRS0=QV8n=5I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C75AC4332B
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2020 21:18:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 041C52070A
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2020 21:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dlnTYM63"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 041C52070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lGHyCEQr+CWhc2DvI4Q8LeVuNjWzpU867n4kaWW2PBQ=; b=dlnTYM63a8qq7UNo3K5DFBnvN
	gQi4tYQyaVfbuPtUleRHrcs+qNGip8V/Hb19ZOIoJNEdclvKyZjLfmDwKr1V6nkWpbgJ1F0EGKAky
	sYAcatjlIAeDFcuwDBs7dQ5RumFeEt1ptzZ5/jsWtKAcb9JtRsoLuuluWS1+QkonE0i0+DUac1BfP
	7J+gqaQZnCRCXSJuW2STYFBpTmlycVMBzNwxp8KAYKwkt7898C3ehQGjRKKbwXKPQScunwZrmKuR3
	WqNTmbTBZFHei3x9z5g2WcUyuKuxEpIgoUCKtqO8+USbsJikShjVhhb0q1JpcREEEJDdxwjLBdzyc
	kksvNUfNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jGUT3-0008Lh-9O; Mon, 23 Mar 2020 21:18:41 +0000
Received: from mail-wm1-f65.google.com ([209.85.128.65])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jGUT0-0008LH-GQ
 for linux-nvme@lists.infradead.org; Mon, 23 Mar 2020 21:18:39 +0000
Received: by mail-wm1-f65.google.com with SMTP id b12so1037452wmj.3
 for <linux-nvme@lists.infradead.org>; Mon, 23 Mar 2020 14:18:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=byMept1zmQPJNqlYF8DbmJBd63vSTk1r2Wd3C9oqJhQ=;
 b=tx8kp0OzwPLKchj0dLxnrNAWNuhwgGypfBw3wUyKXXD7vJh+RKUXa3sPDeH2ZqaBAS
 oJqgm9jPdA4UPAcTMgopGyZSf32z8H4VAVEO1vOFfc9JLps08XSWGSWmBO6H98Fn5IJL
 N63bRTxLcOTZS6Fth3+hx49C3Ah7Io40jEzvMox/Iam07n7iCckTGltnDUV1m34T33/L
 +6zhf+wt/hoNQLngcSYvIbOD54HCJvAPmRxdVzxeq0zKZlCGsIjgMbxTP4atWmi5LZWg
 PVGSCeTMQAmDpi9p9F8D0miUlEfHB3058fWOrvEE5xH8rUW311xMvxujFT6I6/wfdsog
 YVpA==
X-Gm-Message-State: ANhLgQ2Q7Tv0c5ZDNyN+6VuE2aRC9e1PIXHNZHRMuzZJXH4KaJPbWdj0
 LpihFZZSPt2ViUurRJJtSkg8g3+F
X-Google-Smtp-Source: ADFU+vudWaboeMOBeObmuqNP12kf+gf6Lpy+pTw3Eh2LXjySkxuH6e1zrAa6SNNg6DQnQNCxnymIzQ==
X-Received: by 2002:a7b:caaa:: with SMTP id r10mr1418608wml.96.1584998316551; 
 Mon, 23 Mar 2020 14:18:36 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:45a4:15de:f2dc:1149?
 ([2601:647:4802:9070:45a4:15de:f2dc:1149])
 by smtp.gmail.com with ESMTPSA id o26sm1074662wmc.33.2020.03.23.14.18.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 23 Mar 2020 14:18:35 -0700 (PDT)
Subject: Re: Sighting: Kernel fault with large write (512k) and io_uring
From: Sagi Grimberg <sagi@grimberg.me>
To: "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <MW3PR11MB4684AEE8587BFCC0A9F41DE4E5F70@MW3PR11MB4684.namprd11.prod.outlook.com>
 <4eaa3e21-833d-f6ec-3b14-58dd2022a381@grimberg.me>
 <MW3PR11MB4684AC746EE60B9E5D0D46E1E5F00@MW3PR11MB4684.namprd11.prod.outlook.com>
 <82255be7-fb89-c66c-442e-6fe04239768c@grimberg.me>
Message-ID: <52ce2f94-e11b-c537-63d2-e9b72cf1b00c@grimberg.me>
Date: Mon, 23 Mar 2020 14:18:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <82255be7-fb89-c66c-442e-6fe04239768c@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200323_141838_550132_7F0296B5 
X-CRM114-Status: GOOD (  11.29  )
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
Cc: Jens Axboe <axboe@kernel.dk>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4+PiBDYW4geW91IHJ1bjoKPj4+IGdkYiBkcml2ZXJzL252bWUvaG9zdC9udm1lLXRjcC5rbwo+
Pj4gLi4uCj4+PiAkIGwgKihudm1lX3RjcF90cnlfcmVjdisweDU5KQo+Pgo+PiAoZ2RiKSBMICoo
bnZtZV90Y3BfdHJ5X3JlY3YrMHg1OSkKPj4gMHhmZmZmZmZmZmMwM2QwNGQ5IGlzIGluIG52bWVf
dGNwX3RyeV9yZWN2IAo+PiAoZHJpdmVycy9udm1lL2hvc3QvdGNwLmM6MTA0NikuCj4+IDEwNDEK
Pj4gMTA0MsKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmRfZGVzYy5hcmcuZGF0YSA9IHF1ZXVlOwo+
PiAxMDQzwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZF9kZXNjLmNvdW50ID0gMTsKPj4gMTA0NMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgbG9ja19zb2NrKHNrKTsKPj4gMTA0NcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcXVldWUtPm5yX2NxZSA9IDA7Cj4+IDEwNDbCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGNvbnN1bWVkID0gc29jay0+b3BzLT5yZWFkX3NvY2soc2ssICZyZF9kZXNjLCAKPj4gbnZtZV90
Y3BfcmVjdl9za2IpOwo+PiAxMDQ3wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZWxlYXNlX3NvY2so
c2spOwo+PiAxMDQ4wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gY29uc3VtZWQ7Cj4+IDEw
NDnCoMKgwqAgfQo+PiAxMDUwCj4+IFJlcHJvZHVjZWQgdGhpcyBmYXVsdCBvbiBicmFuY2ggbnZt
ZS01LjYtcmM2LgoKTWFyaywgZG9lcyB0aGlzIHBhdGNoIG1ha2UgdGhlIGlzc3VlIGdvIGF3YXk/
Ci0tCkBAIC0yMzI2LDYgKzIzMjgsOSBAQCBzdGF0aWMgaW50IG52bWVfdGNwX3BvbGwoc3RydWN0
IGJsa19tcV9od19jdHggKmhjdHgpCiAgICAgICAgIHN0cnVjdCBudm1lX3RjcF9xdWV1ZSAqcXVl
dWUgPSBoY3R4LT5kcml2ZXJfZGF0YTsKICAgICAgICAgc3RydWN0IHNvY2sgKnNrID0gcXVldWUt
PnNvY2stPnNrOwoKKyAgICAgICBpZiAoIXRlc3RfYml0KE5WTUVfVENQX1FfTElWRSwgJnF1ZXVl
LT5mbGFncykpCisgICAgICAgICAgICAgICByZXR1cm4gMDsKKwogICAgICAgICBzZXRfYml0KE5W
TUVfVENQX1FfUE9MTElORywgJnF1ZXVlLT5mbGFncyk7CiAgICAgICAgIGlmIChza19jYW5fYnVz
eV9sb29wKHNrKSAmJiAKc2tiX3F1ZXVlX2VtcHR5X2xvY2tsZXNzKCZzay0+c2tfcmVjZWl2ZV9x
dWV1ZSkpCiAgICAgICAgICAgICAgICAgc2tfYnVzeV9sb29wKHNrLCB0cnVlKTsKLS0KCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LW52bWUgbWFp
bGluZyBsaXN0CmxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
