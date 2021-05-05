Return-Path: <SRS0=YFbx=KA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D186C433B4
	for <linux-nvme@archiver.kernel.org>; Wed,  5 May 2021 18:06:53 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB8B061182
	for <linux-nvme@archiver.kernel.org>; Wed,  5 May 2021 18:06:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB8B061182
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0hJjyA9s9lahvOVOFeAAVhZ6enkXUrG2/YmQwTByoY4=; b=ddauKZA9ZZkDVKouHGEAtrpKK
	td3QLd9XZZyOzleZNA3/a3HDidaVzLOlysCPpJ3rFGuq3QPT3GgSvnHx41MYK7rAY8UY03Qb7+uKd
	9CWBS3L3BUtVdf17u9GXEimdweH/urphJg9tpSg4JZ0aHX3wLRUAXGGxRyjjyxT0OlGdYJkEJIqgK
	tcsVGvzEoEGllQ59JwiBwuPO/dt8Wswgy5ISkFuC25acKTa3OWb0PJQKAZvAufyx83CFbr/aBxtTn
	XfrL1BiDC3KJeE81uX+1MDSEx2sd2sDTbWr5+EPVCDhn4joqOeQTsw9cZLjA90NRbdsUoU/MsT38Z
	nmpQQhUfw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1leLv5-001yvI-V0; Wed, 05 May 2021 18:06:48 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leLv4-001yus-Cv
 for linux-nvme@desiato.infradead.org; Wed, 05 May 2021 18:06:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-ID:Content-Description;
 bh=6epz3P+nTKg7PGMJTEsKPXBtOf+Ja81Rjg0mXQ3TlRc=; b=TUt9eRtqxpfJWfnSlftSjSQPXy
 wA8SDucQEknUKwL1g5tU+03t9NzQkAWKilmtPmyX9O7wXr5qJg9V883HYSmvUJSgO6c6SW98AOPMw
 XqGw8RfA6SOShkDCCcFjMo4i3s/upxUtaD/YWD9IhP/Ov26HVHoNVxDoyZsAzVNtljqlkVNm5tKJf
 8V4RT916ROwCAUfwaPPGEaR11kDuEVem9P9JcqLcyeYEh7XmpDQ3ZPZ7ERwBhYE+jp2y8H1VHN15k
 3z4ONlH1DhTHOg5xP9oQOD1dWn1dWnk3dFia3OvRzLlAbgJ39DsjssnltwsbsyYaJ+V1t2VwkxZ/H
 k0NuWa/g==;
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leLv1-0057rJ-M2
 for linux-nvme@lists.infradead.org; Wed, 05 May 2021 18:06:44 +0000
Received: by mail-ej1-x636.google.com with SMTP id b25so4262637eju.5
 for <linux-nvme@lists.infradead.org>; Wed, 05 May 2021 11:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=6epz3P+nTKg7PGMJTEsKPXBtOf+Ja81Rjg0mXQ3TlRc=;
 b=clqFxRqZjIIweBhdHhX3Wcftn/TGbaVdBLItUnVanmqKcg93+jVS4Lr2CRCMMIODsa
 HbatwDaZquVOIuCu64bQX3AaOluFydimbQQ9OrFwUrOx5kvPYyTtjPoENjadgJRmhB30
 QmoS83GfoPDAYMhxB5JxYuUO9fIgessBRcZctUBU/66Jrsr456HGgYxpLm3rOK84Wa2n
 1oVjt1fEw5OoLfCuQNTmeGL2ZILevqedw7lqdmadQFszVK5oXOtOrpI0vlHcaN3soLwP
 gk/ZdEYbvbzOVwK8DQt/ZLANZd8PFAdicXtTpwoM5jLU7DTKvLYFY1yqlQyUkcS0FqOq
 Y3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6epz3P+nTKg7PGMJTEsKPXBtOf+Ja81Rjg0mXQ3TlRc=;
 b=JSZNFOeh/S4/RdpUXivmImJOnIXxWDcxNg2/ebidbXpKCLqqHikUcfQHqQzdhsWRMh
 Kx0D93t+Teh3loPA/XKFMuG1OlUXhv82n6OO8N3cAUWi/KmdJxFZLHoG12HnWGgWt5pS
 W2SXGc+eb4n6kQ4ohIRX/zIIE00BjgQmnog3KTr5zLBi8oNgZVcxswKGHCs9fqugf1kO
 XPl6D6GDumlSC8y5E0mA9NB+k19WsVHGymc5h8vPY4HG3YOxN+a46E9jEZTU9SloibR4
 A/Cmtm2iXDFNLQTdaTBnCoM/NnkE6gqXgFacb8n5G8ZquHa+k+zZKAaEHBP/Wg39ZCxJ
 gSDg==
X-Gm-Message-State: AOAM531yr6UVG3lWYcGT24TyqBw5MJBl4o4v+5WKAjKnu30fbQhPEC8o
 Y4+M793FspJM6D8zjf76wRv3CZbrodfOtuAb690=
X-Google-Smtp-Source: ABdhPJw1Q+wj6QwfSlxgePQPlcdmcsKrVxtscN2eKBkdYxrGireWc9VLf5giOR/w8rUblUrltu9KpAjOCPMptVNSMAY=
X-Received: by 2002:a17:906:600b:: with SMTP id
 o11mr28742823ejj.345.1620238002262; 
 Wed, 05 May 2021 11:06:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210429190926.5086-1-smalin@marvell.com>
 <20210429190926.5086-27-smalin@marvell.com>
 <daa07a1c-add4-9f27-5f55-05b1191e85c1@suse.de>
In-Reply-To: <daa07a1c-add4-9f27-5f55-05b1191e85c1@suse.de>
From: Shai Malin <malin1024@gmail.com>
Date: Wed, 5 May 2021 21:06:31 +0300
Message-ID: <CAKKgK4yrkON+Nmfj7DNgiTzkujrsnxtbxqQ_oZhcs9jeR_bEaA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 26/27] qedn: Add Connection and IO level recovery
 flows
To: Hannes Reinecke <hare@suse.de>
Cc: Shai Malin <smalin@marvell.com>, netdev@vger.kernel.org,
 davem@davemloft.net, 
 kuba@kernel.org, linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de, 
 axboe@fb.com, kbusch@kernel.org, Ariel Elior <aelior@marvell.com>, 
 Michal Kalderon <mkalderon@marvell.com>, okulkarni@marvell.com,
 pkushwaha@marvell.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210505_110643_740353_F2499AC3 
X-CRM114-Status: GOOD (  13.61  )
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

T24gNS8yLzIxIDI6NTdQTSwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOgo+IE9uIDQvMjkvMjEgOTow
OSBQTSwgU2hhaSBNYWxpbiB3cm90ZToKPiA+IFRoaXMgcGF0Y2ggd2lsbCBwcmVzZW50IHRoZSBj
b25uZWN0aW9uIGxldmVsIGZ1bmN0aW9uYWxpdGllczoKPiA+ICAgLSBjb25uIGNsZWFyLXNxOiB3
aWxsIHJlbGVhc2UgdGhlIEZXIHJlc3RyaWN0aW9ucyBpbiBvcmRlciB0byBmbHVzaCBhbGwKPiA+
ICAgICB0aGUgcGVuZGluZyBJT3MuCj4gPiAgIC0gZHJhaW46IGluIGNhc2UgY2xlYXItc3EgaXMg
c3R1Y2ssIHdpbGwgcmVsZWFzZSBhbGwgdGhlIGRldmljZSBGVwo+ID4gICAgIHJlc3RyaWN0aW9u
cyBpbiBvcmRlciB0byBmbHVzaCBhbGwgdGhlIHBlbmRpbmcgSU9zLgo+ID4gICAtIHRhc2sgY2xl
YW51cCAtIHdpbGwgZmx1c2ggdGhlIElPIGxldmVsIHJlc291cmNlcy4KPiA+Cj4gPiBBY2tlZC1i
eTogSWdvciBSdXNza2lraCA8aXJ1c3NraWtoQG1hcnZlbGwuY29tPgo+ID4gU2lnbmVkLW9mZi1i
eTogUHJhYmhha2FyIEt1c2h3YWhhIDxwa3VzaHdhaGFAbWFydmVsbC5jb20+Cj4gPiBTaWduZWQt
b2ZmLWJ5OiBPbWthciBLdWxrYXJuaSA8b2t1bGthcm5pQG1hcnZlbGwuY29tPgo+ID4gU2lnbmVk
LW9mZi1ieTogTWljaGFsIEthbGRlcm9uIDxta2FsZGVyb25AbWFydmVsbC5jb20+Cj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBBcmllbCBFbGlvciA8YWVsaW9yQG1hcnZlbGwuY29tPgo+ID4gU2lnbmVkLW9m
Zi1ieTogU2hhaSBNYWxpbiA8c21hbGluQG1hcnZlbGwuY29tPgo+ID4gLS0tCj4gPiAgIGRyaXZl
cnMvbnZtZS9ody9xZWRuL3FlZG4uaCAgICAgIHwgICA4ICsrCj4gPiAgIGRyaXZlcnMvbnZtZS9o
dy9xZWRuL3FlZG5fY29ubi5jIHwgMTMzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0K
PiA+ICAgZHJpdmVycy9udm1lL2h3L3FlZG4vcWVkbl9tYWluLmMgfCAgIDEgKwo+ID4gICBkcml2
ZXJzL252bWUvaHcvcWVkbi9xZWRuX3Rhc2suYyB8ICAyNyArKysrKystCj4gPiAgIDQgZmlsZXMg
Y2hhbmdlZCwgMTY2IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4gPgo+IFJldmlld2Vk
LWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4KClRoYW5rcy4KCj4KPiBDaGVlcnMs
Cj4KPiBIYW5uZXMKPiAtLQo+IERyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgS2Vy
bmVsIFN0b3JhZ2UgQXJjaGl0ZWN0Cj4gaGFyZUBzdXNlLmRlICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKPiBTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJI
LCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKPiBIUkIgMzY4MDkgKEFHIE7DvHJuYmVy
ZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0
CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
