Return-Path: <SRS0=s2cI=ZF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0C2C43331
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2019 14:12:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 504CB222CA
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2019 14:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EOV52656";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hp+AmBlc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 504CB222CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VVkowNMsI54WTD2xOs07Tzdl+UUU+pqN/2F/+znYbXM=; b=EOV52656glW1f1krwRFSwE+jl
	KF67NC0bO8c0xWlgqESEz9RTF+2IAcVPI5SlLpjc3gql5k0UpA6uJ9KGKbCtu+RN0DLOMefxLiJU9
	VuN+hAJDxocmZkfze2J8zYPzBw91o7D+H7sbkDZlNyKUF8FmW0l3b7w1PgIx/G6Bv9cqtoo6Rkige
	bv6Bwc+X7MO/sBykm4yJ590ZQ8DN5ORH+VdOLXYSRWT3eSvn+RQM/e1WUzHSIC1ppCs4SiFQiLOda
	TAvnj0LJZz/d7hFRmSDDPtGVkoDrwDnYXUOqpxDxLqytERD5sLU2vEJyyzFRFsC2EyQ9TEwPdjewB
	1QEsb00XQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iUtNJ-0007Ch-7I; Wed, 13 Nov 2019 14:12:01 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iUtNG-0007CM-H7
 for linux-nvme@lists.infradead.org; Wed, 13 Nov 2019 14:11:59 +0000
Received: by mail-pg1-x543.google.com with SMTP id l24so1448438pgh.10
 for <linux-nvme@lists.infradead.org>; Wed, 13 Nov 2019 06:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=cllW061uLnQ3yGRXQ8vFaWpkjCm54Cf/kHX13p/6JP8=;
 b=Hp+AmBlcHjyM+cfBICrWPYck25TYpei7yLtSnzkWB+fPxyuU77P2F+8EUpHh1aqU7K
 eyDEoOrag5+tEY1aymFc5P4Npek4YKYGclHj8TkbQFXNsi40a4g3KhdIwUEd9QKE6lQ2
 qg0qoVJIcOfwYMzdU8itMbkYtjGWuLF6Jh7gGs+MQ9rbHFkUOgDc78Q3tM7Rm+dPtlBX
 gU4zTE78Yg6pipFsFc48mJGGnzMC1fU4rqNwZvc5E5QDLnwKjfFE+uzv+EyEs4Yjbtdg
 nw1kBet0gMxXOnGwhFW2nzIuHUvW1c+hBlhVy/CtkiqsMuxUItwKm9ww9TbXWxG86a9i
 4mcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cllW061uLnQ3yGRXQ8vFaWpkjCm54Cf/kHX13p/6JP8=;
 b=nt0+Yg5Ywg5fkAvJ+Z1fs54w/hdS1B+j2VwwXLEVFFe9kYwlM/FnvA7hSLbAvJdxji
 lju8PDeDanwfajDyBRm2kaP9jUK1Nyc4n0neC2EUsrZct4J89DvaVQbFwda8kJZxZsco
 ojFMnxJJS2C+JsqLiFAnAqfqCtIUpSnH3E96ElAYN3/okhROhmJLzuLuyUj+/CnsVUuD
 HXPjd2FDnL/9jtGKqDbbMQkR4bLf8ozREFUquK1CwSfGerlGSPzwphgMICGnQygDpYIB
 txeOmbSFCIFQMwY6FzqaAk4DQLTcW8sO9QK1iXY2Fq0io0ZjKy1v03ahZvK4cmHIzKKm
 pgCg==
X-Gm-Message-State: APjAAAX/EBtFJY8UYMUG62AIMt9t2whinFm/tyNe0L2mZrZGW5ew6wzW
 TsGYPyv1L1u6QMf3G99UBR8=
X-Google-Smtp-Source: APXvYqxAA9KymD8OZV2CDoPacXUjHZ0IHedbjy2IcFVhhdR+shBYM2klWoMucHeY8Klcmeabmtjg4w==
X-Received: by 2002:a63:e647:: with SMTP id p7mr4010461pgj.47.1573654317261;
 Wed, 13 Nov 2019 06:11:57 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 r10sm2634179pgn.68.2019.11.13.06.11.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Nov 2019 06:11:56 -0800 (PST)
Subject: Re: [PATCH] nvme: hwmon: provide temperature min and max values for
 each sensor
To: Akinobu Mita <akinobu.mita@gmail.com>
References: <1573395466-19526-1-git-send-email-akinobu.mita@gmail.com>
 <20191111165306.GA19814@lst.de>
 <CAC5umyi97UJZzk+4soD+th0BZ71WfnOqnTWWuTYKyo6aWTdLXA@mail.gmail.com>
 <20191112142127.GA11580@lst.de>
 <CAC5umygX=uBQsWV8O=9NL3HeVNo_iMcq7BE-vA-wpQtyU5iV3Q@mail.gmail.com>
 <20191112163807.GB26911@roeck-us.net>
 <CAC5umyjVFRK+CfO=4FpzKUGyAaRVigj9NBoSazA6RV8AvhTbCw@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <234811dd-feb0-2bef-4240-d4d89d17b607@roeck-us.net>
Date: Wed, 13 Nov 2019 06:11:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAC5umyjVFRK+CfO=4FpzKUGyAaRVigj9NBoSazA6RV8AvhTbCw@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191113_061158_591474_40D60062 
X-CRM114-Status: GOOD (  11.08  )
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
Cc: linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTEvMTMvMTkgNDo1OCBBTSwgQWtpbm9idSBNaXRhIHdyb3RlOgo+IDIwMTnlubQxMeaciDEz
5pelKOawtCkgMTozOCBHdWVudGVyIFJvZWNrIDxsaW51eEByb2Vjay11cy5uZXQ+Ogo+Pgo+PiBP
biBXZWQsIE5vdiAxMywgMjAxOSBhdCAxMjowMDoyMkFNICswOTAwLCBBa2lub2J1IE1pdGEgd3Jv
dGU6Cj4+PiAyMDE55bm0MTHmnIgxMuaXpSjngaspIDIzOjIxIENocmlzdG9waCBIZWxsd2lnIDxo
Y2hAbHN0LmRlPjoKPj4+Pgo+Pj4+IE9uIFR1ZSwgTm92IDEyLCAyMDE5IGF0IDExOjE5OjQ2UE0g
KzA5MDAsIEFraW5vYnUgTWl0YSB3cm90ZToKPj4+Pj4gT0suIEknbGwgYWRkIHR3byBtYWNyb3Mu
Cj4+Pj4+Cj4+Pj4+ICNkZWZpbmUgTUlMTElDRUxTSVVTX1RPX0tFTFZJTih0KSAoKHQpIC8gMTAw
MCArIDI3MykKPj4KPj4gRElWX1JPVU5EX0NMT1NFU1QoKSA/Cj4gCj4gSG93IGFib3V0IHRoZXNl
IGRlZmluaXRpb25zPwo+IAo+ICNkZWZpbmUgTUlMTElDRUxTSVVTX1RPX0tFTFZJTih0KSBESVZf
Uk9VTkRfQ0xPU0VTVCgodCkgKyAyNzMxNTAsIDEwMDApCj4gI2RlZmluZSBLRUxWSU5fVE9fTUlM
TElDRUxTSVVTKHQpICgodCkgKiAxMDAwTCAtIDI3MzE1MCkKPiAKTEdUTQoKR3VlbnRlcgoKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUg
bWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
