Return-Path: <SRS0=q3TM=63=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1EBC433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2020 19:26:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D02682065C
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2020 19:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CvJqGqlb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZmGd07Rl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D02682065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WtN8eO7lE4JcgVZUT1To1v5uKXMHfzLS9zF2n2k19/A=; b=CvJqGqlbUCdJEjY818X/sR21H
	AHGjnU0ZdqL2asApxPa3Zipa4razA8GENbbuY0wUV5VcrP+whUiK5tLZskQFYAmIs5/mTE46jQWMh
	ApBTbLySiBkamSdP5GD7HV4Cw8LIPicfT5uOpu+QukIrddGd4qDgS46wTX/Xmblh/vMP3WO9lgloc
	/Cn06lkFKlA+FfiSlysDhsl7ewcg2mJIyp4D7qiicn5qb5P1gvjEZyTWEKPm445//pbY+7bfIAwt4
	8heWSkbGkDMewVQkQKONHDrquv3/V2dVcFC2yr2Ks0zLF720cegSsP1Nm8HQihmP2E9SgYhbrMubF
	oG/aN5OpQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jYx10-0003Ob-Tx; Wed, 13 May 2020 19:26:02 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jYx0y-0003Mx-0G
 for linux-nvme@lists.infradead.org; Wed, 13 May 2020 19:26:01 +0000
Received: by mail-pg1-x544.google.com with SMTP id t11so193442pgg.2
 for <linux-nvme@lists.infradead.org>; Wed, 13 May 2020 12:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=1ZIjcw7R6padY4x3Cj5tMVLZz4FFTyfbpena+cR04Jw=;
 b=ZmGd07Rl8z1FKoQ3Sor7o1ZH0vWz+oOX8BSSYQ/A4kGVEBNi0RUX7cb2FzwUG9foNR
 DnR0uLDfZAaoWS2tY7EK2Ic3IXxbcg+awlO5nNq71SE98YYF11fjVue7k1KKc6YcmP48
 uF7lMY82huTep7eTtDR0DD1YZy4lHhekp14zQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=1ZIjcw7R6padY4x3Cj5tMVLZz4FFTyfbpena+cR04Jw=;
 b=FXU3Tp78ct/Wt6CXBkvSHCvQFEg0fHoccMfTMy/BOSmUufQfnMWi278DIG2EMtadYu
 mniiNbYLZidgX+MWUYoy9qKuuiRiH3EvmG2Eaca9qqoX4EEk+2kAe4NFpBQE63svpHXG
 LUXgnGLm+OxM953qRYWQxP1/08yxI22WMrOP5QM2sKyinc/n+flDpofQI/kTUk6lPOjK
 uKL1BdZTFYxQOMgiwoj7FlCWbk8hGnEitW3D0E6wa0r1ct9wW1LxAPXnXq/Yvg79Vg3v
 dN99VJKZNRMN478q2IqSxHi5rzofbuzXD8Wytewi+zvmkgowGpYT0KsFDVdbBzJOfLRv
 Kjhw==
X-Gm-Message-State: AOAM532r8bgQCgVNfPShVD56gUlTnOwORWf/Nrx2+5eSaRLavdOpV7WR
 901R6YgHb6tpo8AnmuQGmGxI8g==
X-Google-Smtp-Source: ABdhPJzlltCrvY2PMt8B1zkxd/MYFZ6zJl6TDGDBefG9kLlPQoSPdQpTFeBm8Wm4DyZe2R/imWiH6Q==
X-Received: by 2002:a62:343:: with SMTP id 64mr779916pfd.47.1589397959360;
 Wed, 13 May 2020 12:25:59 -0700 (PDT)
Received: from [10.230.185.151] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id 36sm420977pgs.27.2020.05.13.12.25.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2020 12:25:58 -0700 (PDT)
Subject: Re: [PATCH 11/16] nvmet: rename nvmet_rw_len to nvmet_rw_data_len
To: Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, martin.petersen@oracle.com,
 jsmart2021@gmail.com, axboe@kernel.dk
References: <20200504155755.221125-1-maxg@mellanox.com>
 <20200504155755.221125-12-maxg@mellanox.com>
From: James Smart <james.smart@broadcom.com>
Message-ID: <3d8714bc-c0be-ce18-078b-1de5ef02e1d8@broadcom.com>
Date: Wed, 13 May 2020 12:25:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200504155755.221125-12-maxg@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200513_122600_049487_46471772 
X-CRM114-Status: GOOD (  11.69  )
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
Cc: vladimirk@mellanox.com, idanb@mellanox.com, israelr@mellanox.com,
 shlomin@mellanox.com, oren@mellanox.com, nitzanc@mellanox.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiA1LzQvMjAyMCA4OjU3IEFNLCBNYXggR3VydG92b3kgd3JvdGU6Cj4gRnJvbTogSXNyYWVs
IFJ1a3NoaW4gPGlzcmFlbHJAbWVsbGFub3guY29tPgo+Cj4gVGhlIGZ1bmN0aW9uIGRvZXNuJ3Qg
YWRkIHRoZSBtZXRhZGF0YSBsZW5ndGggKG9ubHkgZGF0YSBsZW5ndGggaXMKPiBjYWxjdWxhdGVk
KS4gVGhpcyBpcyBwcmVwYXJhdGlvbiBmb3IgYWRkaW5nIG1ldGFkYXRhIChUMTAtUEkpIHN1cHBv
cnQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBJc3JhZWwgUnVrc2hpbiA8aXNyYWVsckBtZWxsYW5veC5j
b20+Cj4gUmV2aWV3ZWQtYnk6IE1heCBHdXJ0b3ZveSA8bWF4Z0BtZWxsYW5veC5jb20+Cj4gUmV2
aWV3ZWQtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPgo+IFJldmlld2VkLWJ5OiBT
YWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJnLm1lPgo+IFJldmlld2VkLWJ5OiBNYXJ0aW4gSy4g
UGV0ZXJzZW4gPG1hcnRpbi5wZXRlcnNlbkBvcmFjbGUuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9u
dm1lL3RhcmdldC9pby1jbWQtYmRldi5jIHwgMiArLQo+ICAgZHJpdmVycy9udm1lL3RhcmdldC9p
by1jbWQtZmlsZS5jIHwgMiArLQo+ICAgZHJpdmVycy9udm1lL3RhcmdldC9udm1ldC5oICAgICAg
IHwgMiArLQo+ICAgMyBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25z
KC0pCj4KPgoKUmV2aWV3ZWQtYnk6wqAgSmFtZXMgU21hcnQgPGphbWVzLnNtYXJ0QGJyb2FkY29t
LmNvbT4KCi0tIGphbWVzCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbGludXgtbnZtZSBtYWlsaW5nIGxpc3QKbGludXgtbnZtZUBsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
bnZtZQo=
