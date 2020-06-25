Return-Path: <SRS0=w+e8=AG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DD0C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jun 2020 14:48:54 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AB82206C0
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jun 2020 14:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jiu5tpWW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="XvJ4hl3w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AB82206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5BCX8CD93XJgRrZQkzHUcgA8gWYdEPUY5pRQqPtSq3s=; b=jiu5tpWWoLqREtH16K8cGnks6
	YqVVD+KlfAoTchaz7Fx+9tJ8lEaMx0yyqvtahoPtBDbIHIYk+AnSbfqUsvty8PFjJAs4WQukshLkT
	jaLu9sqdF0uG51D54o6l2cldzUBkE+uP7ucmZZFcjD/t+PnQzFIZhySK+g/qarXLe/8D0tlF0OpY4
	KJ6/NDdIGOr0UA3goL6ROD6cTE4/5HHt22qhHS1mTRf6fJa9mS8f3PGNdCp7FFsPn+Tmj6H6MdAOi
	g5p59FoBb+/OGbeOZzEbd5ZmyAcAEA7VfJsf5vd2IstvUbpU/lk/pNJQCNka9bmPAHBWyNCfoWzhu
	8L/kvKQOA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1joTBJ-0007Gc-04; Thu, 25 Jun 2020 14:48:49 +0000
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joTBF-0007Fs-Rl
 for linux-nvme@lists.infradead.org; Thu, 25 Jun 2020 14:48:46 +0000
Received: by mail-ej1-x644.google.com with SMTP id dp18so6217157ejc.8
 for <linux-nvme@lists.infradead.org>; Thu, 25 Jun 2020 07:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=GMY9x/C2jjwza6jdaPO0YKBVYFxcc9e+Li/ACoK6FL4=;
 b=XvJ4hl3wv5/RLzG5VsmH0eDsMbvTCl+U/dU2EYUWl6Cf/Lq2L6Kie/dHLfTGMrVPjJ
 L0BFVnc8QvmHmADYs65nI7jE9Hu2ITX9DluCNdCGMNX8eU6+eed9nqEBrxQ2c3dX5tyV
 J7KaVEjOts1wfbDOQInyKusN3V5SLRac4sr+QHyZaAyhKbpBQLGaVgJvlVqji1vsep+N
 oS1nULGkuqVVwcogJwmX45kV6SiRNnA7Cum6j97ARQOrNW30Wcq13v6JNkA/xLN5EHSD
 Z1ukQN78qZFGcEpWvKCv4NrgNZw3KLqNTBFnOAbKtHZm+Ts0BUcqBiZSXwc0YE4HSOWK
 8D7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=GMY9x/C2jjwza6jdaPO0YKBVYFxcc9e+Li/ACoK6FL4=;
 b=nWYH6BjMFDGdRVgvcK8cWrqBvidjGyv4aVz4gXdGg9OLQ8ytL+AwGYjLcYQTUAyjuo
 qoQXLLr3Wo6N6ZmPpKowAWyTNzjbSprp4j1poxNRiiOj8yWX9/oWAL6mDJH0jw2yQzJY
 ZaOISXOqwgu280pG3R1f5mv4Qvl0b/m+A+YdXLBHhciCXrdpvf6fArkOlXM1mhHSWexk
 W5hlnb0SONnNuoKDly36GDJnCioW+zIitK+T0QtNeHYqNk5EXC4gmriHLFVbnocIvDbB
 hNPTe9My2GI985b5q+8vd22L+TesrNMg9yLXjNPxUjRLn5Xmro9DZ36db9EaKIkwYEKP
 nHNA==
X-Gm-Message-State: AOAM532GsPxyw7PnTkFi7py39deB9OAY1IuRg2qgfyo/vLCU/mIyXjgG
 hgKK/F3+w4F6c0gR53ptmX5M4QJoz3Q=
X-Google-Smtp-Source: ABdhPJz/4DDwtuKtzRE/yvutiwlnjG9lON75Dx1PBLPhgyFFJYVcmAeqTuyDIX9oCC65Ck9WxTcGCQ==
X-Received: by 2002:a17:907:1002:: with SMTP id
 ox2mr16141549ejb.358.1593096524553; 
 Thu, 25 Jun 2020 07:48:44 -0700 (PDT)
Received: from [10.0.0.6] (xb932c246.cust.hiper.dk. [185.50.194.70])
 by smtp.gmail.com with ESMTPSA id z20sm507300edq.97.2020.06.25.07.48.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2020 07:48:43 -0700 (PDT)
Subject: Re: [PATCH 0/6] ZNS: Extra features for current patches
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
 linux-nvme@lists.infradead.org
References: <20200625122152.17359-1-javier@javigon.com>
 <2067b6ce-fea0-99cd-39c7-56cf219f56d5@lightnvm.io>
Message-ID: <d7b3dc5f-a10c-bcf2-8d13-26301d7736df@lightnvm.io>
Date: Thu, 25 Jun 2020 16:48:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <2067b6ce-fea0-99cd-39c7-56cf219f56d5@lightnvm.io>
Content-Language: en-US
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
Cc: axboe@kernel.dk, sagi@grimberg.me, linux-block@vger.kernel.org,
 kbusch@kernel.org, =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
 hch@lst.de
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMjUvMDYvMjAyMCAxNS4wNCwgTWF0aWFzIEJqw7hybGluZyB3cm90ZToKPiBPbiAyNS8wNi8y
MDIwIDE0LjIxLCBKYXZpZXIgR29uesOhbGV6IHdyb3RlOgo+PiBGcm9tOiBKYXZpZXIgR29uesOh
bGV6IDxqYXZpZXIuZ29uekBzYW1zdW5nLmNvbT4KPj4KPj4gVGhpcyBwYXRjaHNldCBleHRlbmRz
IHpvbmVkIGRldmljZSBmdW5jdGlvbmFsaXR5IG9uIHRvcCBvZiB0aGUgZXhpc3RpbmcKPj4gdjMg
Wk5TIHBhdGNoc2V0IHRoYXQgS2VpdGggc2VudCBsYXN0IHdlZWsuCj4+Cj4+IFBhdGNoZXMgMS01
IGFyZSB6b25lZCBibG9jayBpbnRlcmZhY2UgYW5kIElPQ1RMIGFkZGl0aW9ucyB0byBleHBvc2Ug
Wk5TCj4+IHZhbHVlcyB0byB1c2VyLXNwYWNlLiBPbmUgbWFqb3IgY2hhbmdlIGlzIHRoZSBhZGRp
dGlvbiBvZiBhIG5ldyB6b25lCj4+IG1hbmFnZW1lbnQgSU9DVEwgdGhhdCBhbGxvd3MgdG8gZXh0
ZW5kIHpvbmUgbWFuYWdlbWVudCBjb21tYW5kcyB3aXRoCj4+IGZsYWdzLiBJIHJlY2FsbCBhIGNv
bnZlcnNhdGlvbiBpbiB0aGUgbWFpbGluZyBsaXN0IGZyb20gZWFybHkgdGhpcyB5ZWFyCj4+IHdo
ZXJlIGEgc2ltaWxhciBhcHByb2FjaCB3YXMgcHJvcG9zZWQgYnkgTWF0aWFzLCBidXQgbmV2ZXIg
bWFkZSBpdAo+PiB1cHN0cmVhbS4gV2UgZXh0ZW5kZWQgdGhlIElPQ1RMIGhlcmUgdG8gYWxpZ24g
d2l0aCB0aGUgY29tbWVudHMgaW4gdGhhdAo+PiB0aHJlYWQuIEhlcmUsIHdlIGFyZSBoYXBweSB0
byBnZXQgc2lnbi1vZmZzIGJ5IGFueW9uZSB0aGF0IGNvbnRyaWJ1dGVkCj4+IHRvIHRoZSB0aHJl
YWQgLSBqdXN0IGNvbW1lbnQgaGVyZSBvciBvbiB0aGUgcGF0Y2guCj4KPiBUaGUgb3JpZ2luYWwg
cGF0Y2hzZXQgaXMgYXZhaWxhYmxlIGhlcmU6IAo+IGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE5
LzYvMjEvNDE5Cj4KPiBXZSB3YW50ZWQgdG8gd2FpdCBwb3N0aW5nIG91ciB1cGRhdGVkIHBhdGNo
ZXMgdW50aWwgdGhlIGJhc2UgcGF0Y2hlcyAKPiB3ZXJlIHVwc3RyZWFtLiBJIGd1ZXNzIHRoZSBj
YXQgaXMgb3V0IG9mIHRoZSBiYWcuIDopCj4KPiBGb3IgdGhlIG9wZW4vZmluaXNoL3Jlc2V0IHBh
dGNoLCB5b3UnbGwgd2FudCB0byB0YWtlIGEgbG9vayBhdCB0aGUgCj4gb3JpZ2luYWwgcGF0Y2hz
ZXQsIGFuZCBhcHBseSB0aGUgZmVlZGJhY2sgZnJvbSB0aGF0IHRocmVhZCB0byB5b3VyIAo+IHBh
dGNoLiBQbGVhc2UgYWxzbyBjb25zaWRlciB0aGUgdXNlcnMgb2YgdGhlc2Ugb3BlcmF0aW9ucywg
ZS5nLiwgZG0sIAo+IHNjc2ksIG51bGxfYmxrLCBldGMuIFRoZSBvcmlnaW5hbCBwYXRjaHNldCBo
YXMgcGF0Y2hlcyBmb3IgdGhhdC4KPgpQbGVhc2UgZGlzcmVnYXJkIHRoZSBhYm92ZSAtIEkgZm9y
Z290IHRoYXQgdGhlIG9yaWdpbmFsIHBhdGNoc2V0IAphY3R1YWxseSB3ZW50IHVwc3RyZWFtLgoK
WW91J3JlIHJpZ2h0IHRoYXQgd2UgZGlzY3Vzc2VkIChJIGF0IGxlYXN0IGRpc2N1c3NlZCBpdCBp
bnRlcm5hbGx5IHdpdGggCkRhbWllbiwgYnV0IEkgY2FuJ3QgZmluZCB0aGUgbWFpbCkgaGF2aW5n
IG9uZSBtZ210IGlzc3VpbmcgdGhlIGNvbW1hbmRzLiAKV2UgZGlkbid0IGdvIGFoZWFkIGFuZCBh
ZGRlZCBpdCBhdCB0aGF0IHBvaW50IGR1ZSB0byBaTlMgc3RpbGwgYmVpbmcgaW4gCmEgZmx1ZmZ5
IHN0YXRlLgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
