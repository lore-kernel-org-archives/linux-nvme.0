Return-Path: <SRS0=qSsZ=6M=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA86AC83006
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Apr 2020 05:23:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7A6D2051A
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Apr 2020 05:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a5QDXtdk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=draconx-ca.20150623.gappssmtp.com header.i=@draconx-ca.20150623.gappssmtp.com header.b="mJpP6O5P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7A6D2051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	References:In-Reply-To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Z5AeJc3/2rV0e974iidMilReEE+0ArID2ACy2XZiV+4=; b=a5QDXtdkZErV+F
	Obu0ryQuo+jpyZNmlmp1wSB6XJKTDvMKkUT8IQ+JdIoqtOtZLmR3ipazcYFApZjVS55B+K4JcvnMZ
	lLvocfKvtYB8vk2cHu5z/3Jr+ck1X7XjwDcybJnjxQNAUOxoZJBOIGKbTAImQi9JuLGQBlIz3GUzi
	XIX5Gxp7ai2fY/h5Oi7n/TYiGKVuCmvwgupsaY2TCRQLOPjHRq1YuYW718++Tka+6QXCuZVzmInbd
	rKj8C2YhKUJNS+thD6U6sAuO8TsAwVGaIrBvJgErDDJJ2UUg78kfTR9l2jc/8eZEe59LARdogyuZq
	E8m3cyDoXW0+RPh02Wsw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jTIio-0007bo-39; Tue, 28 Apr 2020 05:23:54 +0000
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jTIil-0007bC-3S
 for linux-nvme@lists.infradead.org; Tue, 28 Apr 2020 05:23:52 +0000
Received: by mail-yb1-xb44.google.com with SMTP id t9so3232552ybo.8
 for <linux-nvme@lists.infradead.org>; Mon, 27 Apr 2020 22:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=draconx-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=soKXOGTdHIofr3Yf+54NHNG9tiLfeyhq6J/nrePKJX4=;
 b=mJpP6O5PXac54J0K+dRqMwRctOq1kyiNf5Rflc9J5ziICtKvPVvnVShRSIzCq3BSuH
 Pd7+KKoUUkdSgBwnOKkq1NevWCaFLNbhut7RF7n9e6rbcKnfCYkqW3xjPfJcZsuvHjqX
 vXjnZHhym4PYvc3SVxmFDq9xQdVrNamtkrCWGa5Qwl6i1a8H28BS9Ht59J3UJeH4jHQC
 wB4sdIIQRqTprEvDyausggtLo4G4CUnh5lCeCZfur+AEG2cQNnzdmnrZpMQG72adqDZ9
 Yny6YR1Ci2ap+Ek6/nmP1FANSuEF2aTMpfdQ40tAsDQ7skn+eTJU60arnDD+V2mtsJIq
 7/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=soKXOGTdHIofr3Yf+54NHNG9tiLfeyhq6J/nrePKJX4=;
 b=IiwmYf6wKHtOCi9xpAVYwhyO85zt6Uz3nqbCJd2xkqFQb54kmnrFlNVXoUHFghdkth
 kxjqigiHGHY6TgJN2jGmA1/iqHaUjw3Qe3FFHVhLzCMdsaaS28wT9PzPUQ0/EwodDJ09
 LT1g59QKGnl38+ttUiOGVdK2F/SNnsPWphikYAs6u9BBaT74cJoWf3XDXn4i2KSR05Ci
 L2cAtG8pXQIJsE24wY2sCEUBBNcYRes6wwtAAVTUKeKaQqbGJigc5UBjK5VRXchlypJv
 Z/6MobzFC6/dXVG0JAVLGJict+3OzjV57YnT4n1cbNeu1nqtq1I3cebbknKJq6r7ay+F
 TMYQ==
X-Gm-Message-State: AGi0PuYMQdlJbPS3ivFHhn4znXiLLmNtsi7KkE38FtomFB9hZwAs2E6u
 5Yndidlhnz363+f4All3rQ1cuut7qShouNRacTXs8A==
X-Google-Smtp-Source: APiQypI8lc33BnS/i6tpuW4cnEXzEeQUq7XaUs2oTS8y6bUkrFrtA9hkhaQWD5JgqpSDqBkta9JkVGHW3yeCz1VLG7U=
X-Received: by 2002:a25:bcc8:: with SMTP id l8mr32743079ybm.225.1588051427543; 
 Mon, 27 Apr 2020 22:23:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5e84:0:0:0:0:0 with HTTP; Mon, 27 Apr 2020 22:23:46
 -0700 (PDT)
X-Originating-IP: [24.53.240.163]
In-Reply-To: <CA+G9fYtuzvLSyqSkG8kCPk7exz16P4f5tYf-DTqV2p+eucKOLA@mail.gmail.com>
References: <20200418144047.9013-1-sashal@kernel.org>
 <20200418144047.9013-38-sashal@kernel.org>
 <CA+G9fYtuzvLSyqSkG8kCPk7exz16P4f5tYf-DTqV2p+eucKOLA@mail.gmail.com>
From: Nick Bowler <nbowler@draconx.ca>
Date: Tue, 28 Apr 2020 01:23:46 -0400
Message-ID: <CADyTPEyHmxwskNAru-6asz-YYQZnzkMwJ1Rp1pFK+a8QHDRacQ@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.4 38/78] nvme: fix compat address handling in
 several ioctls
To: Naresh Kamboju <naresh.kamboju@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200427_222351_211872_688F0867 
X-CRM114-Status: UNSURE (   8.74  )
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
Cc: Sasha Levin <sashal@kernel.org>, open list <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org, lkft-triage@lists.linaro.org,
 Basil Eljuse <Basil.Eljuse@arm.com>, linux- stable <stable@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMjAyMC0wNC0yOCwgTmFyZXNoIEthbWJvanUgPG5hcmVzaC5rYW1ib2p1QGxpbmFyby5vcmc+
IHdyb3RlOgo+IE9uIFNhdCwgMTggQXByIDIwMjAgYXQgMjA6MjQsIFNhc2hhIExldmluIDxzYXNo
YWxAa2VybmVsLm9yZz4gd3JvdGU6Cj4+IEZyb206IE5pY2sgQm93bGVyIDxuYm93bGVyQGRyYWNv
bnguY2E+Cj4+Cj4+IFsgVXBzdHJlYW0gY29tbWl0IGM5NWI3MDhkNWZhNjViNGU1MWYwODhlZTA3
N2QxMjdmZDVhNTdiNzAgXQpbLi4uXQo+PiArc3RhdGljIHZvaWQgX191c2VyICpudm1lX3RvX3Vz
ZXJfcHRyKHVpbnRwdHJfdCBwdHJ2YWwpCj4+ICt7Cj4+ICsgICAgICAgaWYgKGluX2NvbXBhdF9z
eXNjYWxsKCkpCj4+ICsgICAgICAgICAgICAgICBwdHJ2YWwgPSAoY29tcGF0X3VwdHJfdClwdHJ2
YWw7Cj4KPiBhcm02NCBtYWtlIG1vZHVsZXMgZmFpbGVkIHdoaWxlIGJ1aWxkaW5nIHdpdGggYW4g
ZXh0cmEga2VybmVsIGNvbmZpZy4KWy4uLl0KPiA3MiAuLi9kcml2ZXJzL252bWUvaG9zdC9jb3Jl
LmM6MTI1NjoxMzogZXJyb3I6IOKAmGNvbXBhdF91cHRyX3TigJkKPiB1bmRlY2xhcmVkIChmaXJz
dCB1c2UgaW4gdGhpcyBmdW5jdGlvbik7IGRpZCB5b3UgbWVhbiDigJhjb21wYXRfdGltZV904oCZ
PwoKUHJvYmFibHkgY29tbWl0IDU1NmQ2ODdhNGNjZDUgKCJjb21wYXQ6IEFSTTY0OiBhbHdheXMg
aW5jbHVkZQphc20tZ2VuZXJpYy9jb21wYXQuaCIpIGlzIHJlcXVpcmVkIHRvIGJlIGJhY2twb3J0
ZWQgdG8gNS40IGFzIGEKcHJlcmVxdWlzaXRlIGZvciBpbmNsdWRpbmcgdGhpcyBmaXggaW4gdGhl
IDUuNCBzdGFibGUgc2VyaWVzLgoKQ2hlZXJzLAogIE5pY2sKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LW52bWUgbWFpbGluZyBsaXN0CmxpbnV4
LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
