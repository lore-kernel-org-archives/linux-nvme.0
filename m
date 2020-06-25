Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85639C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 10:53:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D936206DD
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 10:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qDDyDprJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="Mj0lNO+T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D936206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fGjmbBgg2a33tsiI/Vsmydzc9yr0gaBHld9SC0qNOb8=; b=qDDyDprJA+GwxdDfd0qdwWQ0I
	Q+ases57nBWODXdehwJRLXhLtJlLAf6jlYUMqjOCchGxXivRUDQA4QyiVg27VomV1uWHQe7yv/1A9
	gw0b+sxkDhahE2Q/8RTC9Ow087CRbir39wIe+0oduqnVpmDSQ2ZnRlja43O5T/jxHFYSjk2eYwK5v
	wJE/e8mvoCUj15D2HFKaTbLMIAKdluMZ08W5uEfjZPtT0pIovZamuIFJn8wy15l9F9vaToV0n2dIu
	wpd1Ww9TMB1cnKR3LQApVR7e57An0aRoF5Q5NVELFTU8zOsDAiC5D/TRPmum9yGA+zOYnoxSZsmFa
	o2rYIX5rA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jolzP-00075K-5Y; Fri, 26 Jun 2020 10:53:47 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jolx0-00061g-Fw
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 10:51:23 +0000
Received: by mail-ed1-x541.google.com with SMTP id g20so6340566edm.4
 for <linux-nvme@lists.infradead.org>; Fri, 26 Jun 2020 03:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=1RYVP7RsPWbvdNK3+/gxv8Vszb2G2vp2B65jcRHPcHM=;
 b=Mj0lNO+TBXyy8gRb54xE6p95SnVUuIN4PGdFiF0HLOlmQkpyHX69Ejdz6tG5yOrdia
 TMwPoimwxKBcwBxPQFVXVlibf3bt4awKJ4c2ZUeAecD8xVHh0mYBxCHo0ifvY6lDigtS
 umg64gWooHv7DoJiyPctoVfTEvEGaJpTVd7PApQF0sKq1X8Tb/eu/q3Vl1yy7/Kcvq/J
 UCycQ0wpz8QUaGB6+uzdpneSFKTUEptyjAmG13I2M37YJsdWuWaIadGfW9L6jfDr0zLa
 3lQ2sb5EuTZ0oeeL3GOtEefEpbaCQEL3b/BGDIm25zhOFqELBSGr1QC+duubcElPD4xv
 TxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=1RYVP7RsPWbvdNK3+/gxv8Vszb2G2vp2B65jcRHPcHM=;
 b=KPneJpU3oO4lrD8XrMXRV3dJ1+NTcu4ue5ea1pgbD3jwq2YKquNlJdWbL6tlYUJnQy
 eEbX3Bk/ZHE90DV2Ul0UKueXfr1QazESbKaLaAEwUplnuo/12fHo2I0a6jwlKHU8MzpN
 JYWqtBbXtfvWZUVxS4y2x1jaHVFpcNGh7lrx4hkYUHEZZc6/BqZ/AVZZiG1+LPv2yRY1
 SNk9KU2ET2xY+nPkRKkuTVmzSW0vxesxOnGTvur60tskFn+nBAv5ymalWIzwgHHqb8vr
 dtAX1lUZE2CcKOIC4z1QjE8vqWlEi88k3l3vV5X6MrPD+DJVyzx891NswXZ5AF4f2ITj
 FvCQ==
X-Gm-Message-State: AOAM533G9lLlNLin1FJM3QAnOlgru+iw9/MQo6UBSMwGij3p7CVQQ3y3
 5QayqQjG/GeZWiDY/1/gFQYoPJv9OgKhgn6I
X-Google-Smtp-Source: ABdhPJy+Vvf8Olu9/gOJVvG04T6uxdaPwVGYi17GeoA2MKCxGZ7K66mt2Yn0E/w4muwetPUDUPdB/w==
X-Received: by 2002:a50:fa8d:: with SMTP id w13mr34100776edr.324.1593113971205; 
 Thu, 25 Jun 2020 12:39:31 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
 by smtp.gmail.com with ESMTPSA id a2sm7919011ejg.76.2020.06.25.12.39.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 12:39:30 -0700 (PDT)
Date: Thu, 25 Jun 2020 21:39:29 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>
Subject: Re: [PATCH 0/6] ZNS: Extra features for current patches
Message-ID: <20200625193929.eitl3th2mn2mlxu2@MacBook-Pro.localdomain>
References: <20200625122152.17359-1-javier@javigon.com>
 <2067b6ce-fea0-99cd-39c7-56cf219f56d5@lightnvm.io>
 <d7b3dc5f-a10c-bcf2-8d13-26301d7736df@lightnvm.io>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d7b3dc5f-a10c-bcf2-8d13-26301d7736df@lightnvm.io>
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
Cc: axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, kbusch@kernel.org, hch@lst.de
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMjUuMDYuMjAyMCAxNjo0OCwgTWF0aWFzIEJqw7hybGluZyB3cm90ZToKPk9uIDI1LzA2LzIw
MjAgMTUuMDQsIE1hdGlhcyBCasO4cmxpbmcgd3JvdGU6Cj4+T24gMjUvMDYvMjAyMCAxNC4yMSwg
SmF2aWVyIEdvbnrDoWxleiB3cm90ZToKPj4+RnJvbTogSmF2aWVyIEdvbnrDoWxleiA8amF2aWVy
LmdvbnpAc2Ftc3VuZy5jb20+Cj4+Pgo+Pj5UaGlzIHBhdGNoc2V0IGV4dGVuZHMgem9uZWQgZGV2
aWNlIGZ1bmN0aW9uYWxpdHkgb24gdG9wIG9mIHRoZSBleGlzdGluZwo+Pj52MyBaTlMgcGF0Y2hz
ZXQgdGhhdCBLZWl0aCBzZW50IGxhc3Qgd2Vlay4KPj4+Cj4+PlBhdGNoZXMgMS01IGFyZSB6b25l
ZCBibG9jayBpbnRlcmZhY2UgYW5kIElPQ1RMIGFkZGl0aW9ucyB0byBleHBvc2UgWk5TCj4+PnZh
bHVlcyB0byB1c2VyLXNwYWNlLiBPbmUgbWFqb3IgY2hhbmdlIGlzIHRoZSBhZGRpdGlvbiBvZiBh
IG5ldyB6b25lCj4+Pm1hbmFnZW1lbnQgSU9DVEwgdGhhdCBhbGxvd3MgdG8gZXh0ZW5kIHpvbmUg
bWFuYWdlbWVudCBjb21tYW5kcyB3aXRoCj4+PmZsYWdzLiBJIHJlY2FsbCBhIGNvbnZlcnNhdGlv
biBpbiB0aGUgbWFpbGluZyBsaXN0IGZyb20gZWFybHkgdGhpcyB5ZWFyCj4+PndoZXJlIGEgc2lt
aWxhciBhcHByb2FjaCB3YXMgcHJvcG9zZWQgYnkgTWF0aWFzLCBidXQgbmV2ZXIgbWFkZSBpdAo+
Pj51cHN0cmVhbS4gV2UgZXh0ZW5kZWQgdGhlIElPQ1RMIGhlcmUgdG8gYWxpZ24gd2l0aCB0aGUg
Y29tbWVudHMgaW4gdGhhdAo+Pj50aHJlYWQuIEhlcmUsIHdlIGFyZSBoYXBweSB0byBnZXQgc2ln
bi1vZmZzIGJ5IGFueW9uZSB0aGF0IGNvbnRyaWJ1dGVkCj4+PnRvIHRoZSB0aHJlYWQgLSBqdXN0
IGNvbW1lbnQgaGVyZSBvciBvbiB0aGUgcGF0Y2guCj4+Cj4+VGhlIG9yaWdpbmFsIHBhdGNoc2V0
IGlzIGF2YWlsYWJsZSBoZXJlOiAKPj5odHRwczovL2xrbWwub3JnL2xrbWwvMjAxOS82LzIxLzQx
OQo+Pgo+PldlIHdhbnRlZCB0byB3YWl0IHBvc3Rpbmcgb3VyIHVwZGF0ZWQgcGF0Y2hlcyB1bnRp
bCB0aGUgYmFzZSBwYXRjaGVzIAo+PndlcmUgdXBzdHJlYW0uIEkgZ3Vlc3MgdGhlIGNhdCBpcyBv
dXQgb2YgdGhlIGJhZy4gOikKPj4KPj5Gb3IgdGhlIG9wZW4vZmluaXNoL3Jlc2V0IHBhdGNoLCB5
b3UnbGwgd2FudCB0byB0YWtlIGEgbG9vayBhdCB0aGUgCj4+b3JpZ2luYWwgcGF0Y2hzZXQsIGFu
ZCBhcHBseSB0aGUgZmVlZGJhY2sgZnJvbSB0aGF0IHRocmVhZCB0byB5b3VyIAo+PnBhdGNoLiBQ
bGVhc2UgYWxzbyBjb25zaWRlciB0aGUgdXNlcnMgb2YgdGhlc2Ugb3BlcmF0aW9ucywgZS5nLiwg
ZG0sIAo+PnNjc2ksIG51bGxfYmxrLCBldGMuIFRoZSBvcmlnaW5hbCBwYXRjaHNldCBoYXMgcGF0
Y2hlcyBmb3IgdGhhdC4KPj4KPlBsZWFzZSBkaXNyZWdhcmQgdGhlIGFib3ZlIC0gSSBmb3Jnb3Qg
dGhhdCB0aGUgb3JpZ2luYWwgcGF0Y2hzZXQgCj5hY3R1YWxseSB3ZW50IHVwc3RyZWFtLgo+Cj5Z
b3UncmUgcmlnaHQgdGhhdCB3ZSBkaXNjdXNzZWQgKEkgYXQgbGVhc3QgZGlzY3Vzc2VkIGl0IGlu
dGVybmFsbHkgCj53aXRoIERhbWllbiwgYnV0IEkgY2FuJ3QgZmluZCB0aGUgbWFpbCkgaGF2aW5n
IG9uZSBtZ210IGlzc3VpbmcgdGhlIAo+Y29tbWFuZHMuIFdlIGRpZG4ndCBnbyBhaGVhZCBhbmQg
YWRkZWQgaXQgYXQgdGhhdCBwb2ludCBkdWUgdG8gWk5TIAo+c3RpbGwgYmVpbmcgaW4gYSBmbHVm
Znkgc3RhdGUuCj4KCkRvZXMgdGhlIHByb3Bvc2VkIElPQ1RMIGFsaWduIHdpdGggdGhlIHVzZSBj
YXNlcyB5b3UgaGF2ZSBpbiBtaW5kPyBJJ20KaGFwcHkgdG8gdGFrZSBpdCBpbiBhIGRpZmZlcmVu
dCBzZXJpZXMgaWYgeW91IHdhbnQgdG8gYWRkIHBhdGNoZXMgdG8gaXQKZm9yIG90aGVyIGRyaXZl
cnMgKHNjc2ksIG51bGxfYmxrLCBldGMuKS4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LW52bWUK
