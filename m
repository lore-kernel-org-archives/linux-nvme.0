Return-Path: <SRS0=U7R3=J6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2688FC433ED
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 15:29:40 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7192E60C3E
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 15:29:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7192E60C3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=n2eWAXZFyfArGa3RmAHiKtOuPwMu1DTTWzFQQvG+EBw=; b=dIvR5Yz5hztMq4bHJmo8USub8
	X7XstBJxb7Ho+cNuPlJ8slr94SAbsNU0nA5bN/TmaToGxxcfCI7XwPm92DARBhHY4XQ90/epDH3eI
	jLdXhmSA8Z9aTX+y5vGCt8PHHgABbJLkNnZ670OI0gBeqtKXH+EBjHpLr22ykuiaj549TMwJYbu9l
	ieUcXMxBE6cauvL+QFCgSvjYxmVNQS6ySb/8mYjdhkWvoXtSrwjVPhZmi5Q7tmVpnZ9dFj3nE4PuI
	tdQwHBEQJ70IqkKfa5g7KTlJewUVil27+Nfk8/SuKvuPTOJ/b4E7h3Fcin9uyS5NMVgxTYcloPqDa
	B9oZ9Ny5Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldaVQ-00EEdm-4P; Mon, 03 May 2021 15:29:08 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldaUY-00EEPj-Ba
 for linux-nvme@desiato.infradead.org; Mon, 03 May 2021 15:28:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-ID:Content-Description;
 bh=s/OGxKTRhjN8cMwpa1nCfVPRRvIUlqY8n6JRtgjGsPk=; b=FAg44nSgDDnIqjh1bbCcalKCcN
 Tg7s5YP8BeC0B04c687P4QF/7wLfbYntztRSPJqnrlFk4lPLB0riY/TP1gLz4wZPYo/pOcLPK2ly5
 YhQFe6jCDlIxUwaZ8I1wIpnNgiT4Tfw6X5a59fMXn99f88PWieCZaApzj+sNEMat7PixiFt57lBG2
 eXTw0uFf5EjAWS0ggXcjqDf1RZJn6dDIP+Zd02aUXpYjJt+rchkOYc4yxV7QXdhmmVaMymuGkoRNX
 uHHHB/JzTbWBjS9D6Lt0GLgOcBlTqxdkI8I/CeMZEk07Gvee0YHavaYwWL4OUoSk4gIs4lmhs3fUL
 GCRAl1hg==;
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldaUV-003B6Y-Tf
 for linux-nvme@lists.infradead.org; Mon, 03 May 2021 15:28:13 +0000
Received: by mail-ed1-x52f.google.com with SMTP id y26so6761095eds.4
 for <linux-nvme@lists.infradead.org>; Mon, 03 May 2021 08:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=s/OGxKTRhjN8cMwpa1nCfVPRRvIUlqY8n6JRtgjGsPk=;
 b=e7djG/yChudtUnxkAM1M0m3O/btXlqSvEIZaGKDH0MRJCUzNcbgP1Iz+eLNrjRH/2Q
 jooMwp0sCEXKk/nO6gaN8QBDkMNpUSyGf0Ev6R/zr9dtn1sNwpmbZjH9gdQ2s579bbhX
 iYyKccmsZqHBb8A90XdwGf9FTeKUz8bwnsscH7ENhDzrxuc6ZG5MSjWKelfnA+7TMcyw
 D2holJ3W1/vEoRar9yu158Aq56VbZO4K5ZYqqJMLB+vhrUvt7ZPEoFZlbA/1gGfA2Vvi
 BvXX3KjgbaErFyEyp5K+aT1m1sU0Wcaus5ePHvtBmv02Oppw7rLo9rhIW8DrxvA1RjyH
 ZRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=s/OGxKTRhjN8cMwpa1nCfVPRRvIUlqY8n6JRtgjGsPk=;
 b=hVbYuVFY3gGIsO191a7GHlVvmGBRJ+qB2Dw31jZeD9sywFOKe8ZM3+jFQKEsPYTQb7
 bS8Xz0i7fuxxPpnkdbPjJNgBiIh6cq9d++pSv0flqgkOehzNnhceCQQSVj3b86uBuD2L
 SyIEfyitcaPipPEqEXg1PxHYQCbupzthBcqDi/dSHR0MW2FZUqhr8Ht1g1A4/Jg7h6d2
 Cg8d6aRP0O5IdW/PqvHohDw1ZKuVrigGqK5Q1R6bUhd/H8fONCTSNbB/lTH98KdtZBsv
 NgNUxkZ2wrEourbEAWeKXSwGDDzugIc31tocJs8CP6Q/ooUxerecT8YYq8uTbXk+M+CL
 /4Yw==
X-Gm-Message-State: AOAM532GCyLnCTBXIttffecWplE9VdbBEsGJm8FT86mpf4S0EOb4ynTI
 RqMd+jthyXbIq5RT459fYtdQnB/WvpDZgEKoWY0=
X-Google-Smtp-Source: ABdhPJyPH6OfRnqPDHbnscuBMP7D0B6z5vhOsjxfVWu9M+MvN8J9zm9A+X/zAUdgcT+m3x00n3v4/FaSCjvj6/zjhzI=
X-Received: by 2002:a05:6402:35c4:: with SMTP id
 z4mr4371665edc.362.1620055690674; 
 Mon, 03 May 2021 08:28:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210429190926.5086-1-smalin@marvell.com>
 <20210429190926.5086-5-smalin@marvell.com>
 <761a58da-2933-4750-510e-c12dfe8f919c@suse.de>
In-Reply-To: <761a58da-2933-4750-510e-c12dfe8f919c@suse.de>
From: Shai Malin <malin1024@gmail.com>
Date: Mon, 3 May 2021 18:27:59 +0300
Message-ID: <CAKKgK4xr4E129jtTPK00PbW_FSzm-VDeui0B0fAUvxvvWS+H7g@mail.gmail.com>
Subject: Re: [RFC PATCH v4 04/27] qed: Add support of HW filter block
To: Hannes Reinecke <hare@suse.de>
Cc: Shai Malin <smalin@marvell.com>, netdev@vger.kernel.org, 
 linux-nvme@lists.infradead.org, davem@davemloft.net, kuba@kernel.org, 
 sagi@grimberg.me, hch@lst.de, axboe@fb.com, kbusch@kernel.org, 
 Ariel Elior <aelior@marvell.com>, Michal Kalderon <mkalderon@marvell.com>,
 okulkarni@marvell.com, pkushwaha@marvell.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210503_082811_975432_DE32C7C6 
X-CRM114-Status: GOOD (  14.10  )
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

T24gNS8xLzIxIDI6MTMgUE0sIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPiBPbiA0LzI5LzIxIDk6
MDkgUE0sIFNoYWkgTWFsaW4gd3JvdGU6Cj4gPiBGcm9tOiBQcmFiaGFrYXIgS3VzaHdhaGEgPHBr
dXNod2FoYUBtYXJ2ZWxsLmNvbT4KPiA+Cj4gPiBUaGlzIHBhdGNoIGludHJvZHVjZXMgdGhlIGZ1
bmN0aW9uYWxpdHkgb2YgSFcgZmlsdGVyIGJsb2NrLgo+ID4gSXQgYWRkcyBhbmQgcmVtb3ZlcyBm
aWx0ZXJzIGJhc2VkIG9uIHNvdXJjZSBhbmQgdGFyZ2V0IFRDUCBwb3J0Lgo+ID4KPiA+IEl0IGFs
c28gYWRkIGZ1bmN0aW9uYWxpdHkgdG8gY2xlYXIgYWxsIGZpbHRlcnMgYXQgb25jZS4KPiA+Cj4g
PiBBY2tlZC1ieTogSWdvciBSdXNza2lraCA8aXJ1c3NraWtoQG1hcnZlbGwuY29tPgo+ID4gU2ln
bmVkLW9mZi1ieTogUHJhYmhha2FyIEt1c2h3YWhhIDxwa3VzaHdhaGFAbWFydmVsbC5jb20+Cj4g
PiBTaWduZWQtb2ZmLWJ5OiBPbWthciBLdWxrYXJuaSA8b2t1bGthcm5pQG1hcnZlbGwuY29tPgo+
ID4gU2lnbmVkLW9mZi1ieTogU2hhaSBNYWxpbiA8c21hbGluQG1hcnZlbGwuY29tPgo+ID4gU2ln
bmVkLW9mZi1ieTogTWljaGFsIEthbGRlcm9uIDxta2FsZGVyb25AbWFydmVsbC5jb20+Cj4gPiBT
aWduZWQtb2ZmLWJ5OiBBcmllbCBFbGlvciA8YWVsaW9yQG1hcnZlbGwuY29tPgo+ID4gLS0tCj4g
PiAgIGRyaXZlcnMvbmV0L2V0aGVybmV0L3Fsb2dpYy9xZWQvcWVkLmggICAgICAgICB8ICAxMCAr
Kwo+ID4gICBkcml2ZXJzL25ldC9ldGhlcm5ldC9xbG9naWMvcWVkL3FlZF9kZXYuYyAgICAgfCAx
MDcgKysrKysrKysrKysrKysrKysrCj4gPiAgIGRyaXZlcnMvbmV0L2V0aGVybmV0L3Fsb2dpYy9x
ZWQvcWVkX252bWV0Y3AuYyB8ICAgNSArCj4gPiAgIGluY2x1ZGUvbGludXgvcWVkL3FlZF9udm1l
dGNwX2lmLmggICAgICAgICAgICB8ICAyNCArKysrCj4gPiAgIDQgZmlsZXMgY2hhbmdlZCwgMTQ2
IGluc2VydGlvbnMoKykKPiA+Cj4gUmV2aWV3ZWQtYnk6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBz
dXNlLmRlPgoKVGhhbmtzLgoKPgo+IENoZWVycywKPgo+IEhhbm5lcwo+IC0tCj4gRHIuIEhhbm5l
cyBSZWluZWNrZSAgICAgICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKPiBoYXJl
QHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OAo+
IFNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJu
YmVyZwo+IEhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4
IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZt
ZQo=
