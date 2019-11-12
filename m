Return-Path: <SRS0=/X2o=ZE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58ABC43331
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 15:04:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85A7121872
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 15:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lG7rRjW+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JP9v4Gze"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85A7121872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZZ+HuoZbiw0eOtXZa2DDY9Uy3vlEUaOPxpSWl3Qnpic=; b=lG7rRjW+dZ4JrgHTk3BvsNdS+
	AKhNWW9jHKDm7KZsYVmxhRhPmYvuTYM36mVI1/JegWPfPoK2ak6md+pd6IKmA1GDmU+7MeZnzGjX+
	iIrFwNNN3uOerwFE9NHDqQ77mYqS/fpqsLK00WY+OLwFyQGtsaPmOHddjO6pL7OhtISrQVMgtgB/4
	Gv7RCEaqO3NtzWGohmopGaFIjW0BkRJKq+vLqJEqJjw1rOFYuiRRgPjcoxsuPXUf0j9oaI8+88aVd
	RSnp9Kdj61MNHC+uiCOMH9yPsG5lou+oc4ML9qAsUD0fbM7am4+G6CLpsVSpyXFTcqOnmEFKnoWWb
	Aoyypp6Tw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iUXin-0005h8-En; Tue, 12 Nov 2019 15:04:45 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iUXik-0005ga-RY
 for linux-nvme@lists.infradead.org; Tue, 12 Nov 2019 15:04:44 +0000
Received: by mail-pl1-x644.google.com with SMTP id d7so7621908pls.3
 for <linux-nvme@lists.infradead.org>; Tue, 12 Nov 2019 07:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=tCoEPoQn/IVtnGjFo4U/Qk8LODjSGOJgasNa0i9XMFQ=;
 b=JP9v4GzeWOTBAOJDS73oZmUmLetL/nwxLIf0eel8gIHMHeDAIr9rWpeXuiH/4biPvg
 bCARep6kj8T5it7Nu/f1kJH3MAWf8LCrotngUsvWXNaPF4RTU5bE31XM2q69LSO56TbE
 ymE45oXmQGthVBCtfgcV9hAMfCaidN3E63vpf03Dg/E6/yOtcntMrSvNLEtt0M8irGz2
 BlKPDc55SUUMnaFbBmipLGEJUebzDExF7BRj3g+aZNjU2jKrVwRKV4xVDrPCF0LBfV+a
 FVcsRBk/jAGeFL13xwaupLO2NjgHnh1Km0ST2KQLQ0+BP3UADyjeY0Tk+QbxegZbA5Px
 6snA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tCoEPoQn/IVtnGjFo4U/Qk8LODjSGOJgasNa0i9XMFQ=;
 b=Vt8LD76FrUJT8lyuBItixxGU7ypkjauOOXBLJ7rUi96DpB3KNdjIV3RW4Jsqt3QYeH
 AhMe09A+oWwHme0ndI4R0Y9lZtSvxdEcR2uV1G7NTO/bbCFoJHEG65J9mmwRu+jAqDnW
 eJKVpedYaOB4Caw011158qYfSHod5D3CJ+OYKIiKavgs3EsfzqOlvw6HfQbpbx+5rRzK
 CPECG3RJIjy3lBUMNyshm09U47GoSjhlhCUzylw1bFCIg8mT+46Z7P6re2+XmX9UvzZ2
 SDgfr8+mD8Ck6hke3NjYY6oTwC/nadRjiqLk9bT0ADY/Su3QBGrsTE+u7TrxCvr00e7n
 ER+Q==
X-Gm-Message-State: APjAAAVUMfU2jlJr+spQn/G4sfWY3HeBiThfhlN8W1H/wN+68np3qW+g
 zw//mB+YYfo3+qUJdW70irs=
X-Google-Smtp-Source: APXvYqwWqlJZzlUJsC/KoWSFOpjTy3lx7BNBIPaPn+ViHSqLgmL2jF2n26mVnPCA6vxQUZHUbAtwAg==
X-Received: by 2002:a17:902:24b:: with SMTP id
 69mr29945761plc.203.1573571081569; 
 Tue, 12 Nov 2019 07:04:41 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 u8sm7913821pga.47.2019.11.12.07.04.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Nov 2019 07:04:40 -0800 (PST)
Subject: Re: [PATCH] nvme: hwmon: provide temperature min and max values for
 each sensor
To: Akinobu Mita <akinobu.mita@gmail.com>
References: <1573395466-19526-1-git-send-email-akinobu.mita@gmail.com>
 <d3c0c9a7-00b9-0465-16e1-6fd7ba97dfd0@roeck-us.net>
 <CAC5umyiju2Q2fdfVaFyX+Q=sMKr5Gsc_GDVYmSa0vB+w8acvAw@mail.gmail.com>
 <20191111173505.GB5826@roeck-us.net>
 <CAC5umyjviR1J5HojE6WBhYQCzu=CFPPoNxXY=T9KRw2yTpO=VQ@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <e2699eee-8ca2-fcf4-d6b2-624cbddd4c6d@roeck-us.net>
Date: Tue, 12 Nov 2019 07:04:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAC5umyjviR1J5HojE6WBhYQCzu=CFPPoNxXY=T9KRw2yTpO=VQ@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191112_070442_896874_D8C1142E 
X-CRM114-Status: GOOD (  11.14  )
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

T24gMTEvMTIvMTkgNjo0MCBBTSwgQWtpbm9idSBNaXRhIHdyb3RlOgpbIC4uLiBdCj4+IEknbGwg
c2VlIGlmIEkgY2FuIHRlc3QgdGhpcyB0b25pZ2h0IG9uIG15IG90aGVyIE5WTUVzLiBJIGFsc28g
ZHVnIHVwIGFuIG9sZAo+PiBOVk1lIGRyaXZlIGZyb20gVG9zaGliYTsgSSdsbCBzZWUgaWYgSSBj
YW4gY29ubmVjdCBhbmQgdGVzdCBpdCBhcyB3ZWxsLgo+IAo+IFRoYXQncyBuaWNlLgo+IApJdCB3
b3JrcyBvbiBhbGwgZGV2aWNlcyBJIGhhdmUsIGluY2x1ZGluZyB0aGUgVG9zaGliYSwgd2l0aCB0
aGUgZXhjZXB0aW9uCm9mIHRoZSBJbnRlbC4gSW50ZXJlc3RpbmdseSwgdGhlIFRvc2hpYmEgTlZN
ZSByZXBvcnRzOgoKbnZtZS1wY2ktMDYwMApBZGFwdGVyOiBQQ0kgYWRhcHRlcgpDb21wb3NpdGU6
ICAgICs1Ni4wwrBDICAobG93ICA9IC0yMC4wwrBDLCBoaWdoID0gKzg1LjDCsEMpCiAgICAgICAg
ICAgICAgICAgICAgICAgIChjcml0ID0gKzgyLjDCsEMpClNlbnNvciAxOiAgICAgKzU2LjDCsEMg
IChsb3cgID0gLTIwLjDCsEMsIGhpZ2ggPSArODUuMMKwQykKCmllIHRoZSBjcml0aWNhbCB0ZW1w
ZXJhdHVyZSBpcyBsb3dlciB0aGFuIHRoZSBoaWdoIHRlbXBlcmF0dXJlLiBHbyBmaWd1cmUuCgpU
aGUgVG9zaGliYSBtb2RlbCBpcwoJVEhOU041MjU2R1BVNyBOVk1lIFRPU0hJQkEgMjU2R0IKClRo
ZSBJbnRlbCBOVk1lIGhhcyB0aGUgbGF0ZXN0IGZpcm13YXJlIHZlcnNpb24gaW5zdGFsbGVkLCBz
byB0aGlzIGlzbid0CmEgcHJvYmxlbSB0aGF0IHdhcyBldmVyIGZpeGVkLgoKR3VlbnRlcgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBt
YWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
