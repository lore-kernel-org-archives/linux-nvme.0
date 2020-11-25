Return-Path: <SRS0=cokh=E7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E6CC63777
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2020 03:48:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C643920663
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2020 03:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nzqYkQlH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C643920663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mnyO3/e26Ax3w3J/oIcyG2vXs0p9rxyDy1uoF2+0N9s=; b=nzqYkQlHlRvdR8lXrhCBuTTxK
	fXM9BnVDUoxg8BBuGfQxzhnIO8b6GhVJffX6F3WsZr2yxEdoHNkp4uq8i6M7RxpKdYlR8qo332Etc
	iyzs7kZvdng9BSChACq4d8ieXb8maUpwZxrO1ctXLCcqxsJ+60/53hmYh6PmgnJVMNqWFQSeUiW8V
	i+2gDm3jVAebotnkipG9DipueJGK1VdypesZUs6imMf3Y9gn6czcUhKPWOJyJrsB0OcGtzsV35ZOB
	d46WDOAuI2neqr79SkJu1xcSqS7ha3Wjbi5ixNLx5Wc2NPxUbdxNW/OyWPkd9ZF6gusDoirrmC1qh
	yVlco2ZAQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1khlme-0001L4-GT; Wed, 25 Nov 2020 03:47:56 +0000
Received: from mail-pf1-f194.google.com ([209.85.210.194])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khlma-0001K4-2p
 for linux-nvme@lists.infradead.org; Wed, 25 Nov 2020 03:47:53 +0000
Received: by mail-pf1-f194.google.com with SMTP id 131so1046671pfb.9
 for <linux-nvme@lists.infradead.org>; Tue, 24 Nov 2020 19:47:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tuEEqFff68LxNg8K0WH7k+TFM+Y5XoKUY/E9VMvpbCo=;
 b=JvvI6On6ICCVLeShvDEdpWqymgaTDKK1JdLI4VBm6LVpexpZakGO+R4gbjrH/qWSbP
 jLklTieHbhOZMlNQqXgSc3Mgtk488NuufXLUiZNgEQKdWfk41vaI7CKpxOOB8j1GBrlL
 7o1Q6sZQvqbi6OpBFmZKZtInUh4dQrLszejW8S1jooEa9FZppHBnllFRNdCabuBTC5vS
 4hKEqb7Itrm4QLU+/FBCnIecZ/6XAvdJYmN82ZkrWwxoS9cuAmR0zAaXMxT5umt6xaST
 1hj7L6JNxnJaWprQGQGMazSTI6Qb2N53WzBp3Q5uk7N+cYYau6G7Q+IrNM16TXzquFat
 nZcg==
X-Gm-Message-State: AOAM532Ivgdmu3GhYnXWP6ZkBBnS9sXSyhCu3ecB3rur66OPlE1LQH0p
 gkOFHrdwmU6exEaRw9s8Nl3lkCovW/4=
X-Google-Smtp-Source: ABdhPJxbIEVGkqtmvJmgWbEOxfGOOx9WtJksQYRH7406bfb+juGv8KUzqLAXgG0kK5kVQmGaCxSHqQ==
X-Received: by 2002:a17:90a:178b:: with SMTP id
 q11mr1713671pja.132.1606276068628; 
 Tue, 24 Nov 2020 19:47:48 -0800 (PST)
Received: from [192.168.3.218] (c-73-241-217-19.hsd1.ca.comcast.net.
 [73.241.217.19])
 by smtp.gmail.com with ESMTPSA id j11sm516794pgp.82.2020.11.24.19.47.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2020 19:47:47 -0800 (PST)
Subject: Re: [PATCH blktests 1/5] tests/srp/rc: update the ib_srpt module name
To: Yi Zhang <yi.zhang@redhat.com>, osandov@osandov.com
References: <20201124010427.18595-1-yi.zhang@redhat.com>
 <20201124010427.18595-2-yi.zhang@redhat.com>
 <7b6d00d7-2cf8-5a4b-f861-a7efe152843f@acm.org>
 <54f41dc8-41a5-e782-e135-dc7dc81209c0@redhat.com>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <3e4208ef-3508-0db2-3b1d-96f055e1a37f@acm.org>
Date: Tue, 24 Nov 2020 19:47:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <54f41dc8-41a5-e782-e135-dc7dc81209c0@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201124_224752_143905_48DAA05A 
X-CRM114-Status: GOOD (  16.89  )
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
Cc: linux-block@vger.kernel.org, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTEvMjQvMjAgNjowMSBBTSwgWWkgWmhhbmcgd3JvdGU6Cj4gT24gMTEvMjQvMjAgMTE6MjMg
QU0sIEJhcnQgVmFuIEFzc2NoZSB3cm90ZToKPj4gT24gMTEvMjMvMjAgNTowNCBQTSwgWWkgWmhh
bmcgd3JvdGU6Cj4+PiAtwqDCoMKgIGluc21vZCAiL2xpYi9tb2R1bGVzLyQodW5hbWUKPj4+IC1y
KS9rZXJuZWwvZHJpdmVycy9pbmZpbmliYW5kL3VscC9zcnB0L2liX3NycHQua28iICIke29wdHNb
QF19IiB8fAo+Pj4gcmV0dXJuICQ/Cj4+PiArwqDCoMKgIGluc21vZCAiJChscyAvbGliL21vZHVs
ZXMvIiQodW5hbWUKPj4+IC1yKSIva2VybmVsL2RyaXZlcnMvaW5maW5pYmFuZC91bHAvc3JwdC9p
Yl9zcnB0LiopIiAiJHtvcHRzW0BdfSIgfHwKPj4+IHJldHVybiAkPwo+PiBJcyAnbHMnIG5lZWRl
ZCBoZXJlIG9yIGlzICdlY2hvJyBzdWZmaWNpZW50Pwo+IEFjdHVhbGx5IGl0IGRvZXNuJ3Qgd29y
ayB3aXRob3V0IGxzCj4gJCBpbnNtb2QgIi9saWIvbW9kdWxlcy8iJCh1bmFtZQo+IC1yKSIva2Vy
bmVsL2RyaXZlcnMvaW5maW5pYmFuZC91bHAvc3JwdC9pYl9zcnB0LioiCj4gaW5zbW9kOiBFUlJP
UjogY291bGQgbm90IGxvYWQgbW9kdWxlCj4gL2xpYi9tb2R1bGVzLzUuMTAuMC1yYzUva2VybmVs
L2RyaXZlcnMvaW5maW5pYmFuZC91bHAvc3JwdC9pYl9zcnB0Lio6IE5vCj4gc3VjaCBmaWxlIG9y
IGRpcmVjdG9yeQo+IAo+IGFuZCBpdCB3b3JrcyB3aXRoIGVjaG8sIEkgY2FuIGNoYW5nZSB0byBl
Y2hvIGlmIHlvdSBwcmVmZXIKPiAkIGluc21vZCAiJChlY2hvIC9saWIvbW9kdWxlcy8iJCh1bmFt
ZQo+IC1yKSIva2VybmVsL2RyaXZlcnMvaW5maW5pYmFuZC91bHAvc3JwdC9pYl9zcnB0LiopIiAi
JHtvcHRzW0BdfSIgfHwKPiByZXR1cm4gJD8KCidlY2hvJyBpcyBhIHNoZWxsIGJ1aWx0LWluIHdo
aWxlIGxzIGlzIG5vdCBidWlsdC1pbiBpbnRvIGJhc2gsIHNvIGVjaG8KaXMgZmFzdGVyLgoKSG93
IGFib3V0IGluc21vZCAiL2xpYi9tb2R1bGVzLyQodW5hbWUKLXIpL2tlcm5lbC9kcml2ZXJzL2lu
ZmluaWJhbmQvdWxwL3NycHQvaWJfc3JwdC4iKiAobm8gZWNobywgbm8gbHMsCmFzdGVyaXNrIG91
dHNpZGUgZG91YmxlIHF1b3Rlcyk/CgpUaGFua3MsCgpCYXJ0LgoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0Ckxp
bnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
