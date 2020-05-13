Return-Path: <SRS0=q3TM=63=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C0AC433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2020 19:27:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A810C2065C
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2020 19:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="caRlcV9A";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GtzXhLll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A810C2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bXJvIrFnMkGPtRy9+V/TusNfiSUJ9fStohl+cP75WnQ=; b=caRlcV9Aw2zXZwYHAKJfuMPCn
	OK10ZpY20DZGtuEZFV8Uwly32xpc96ut9AUHPCzIL+Ot6Tkv5nqaXnaXe1r/g3sbm9y+GNnjpR+gs
	q1bMQrVgon/9I6tUueCFUPDJPC7QHb5XS3ZTU6XdOHQvJmJdNPJ9GOROfUEXGAA4oRa2PA09kPcYk
	ySVA3jKNytEeVJowqjhbdpQqA0dlOeQkRLY0UInwIRD3eyzh58wNPtyuOG7ApLbFvMrQ9hpLnMJ/4
	qXkqiSp8bXQxZEV5amamKimhxClVkSwyUK6rwMjySpaTt8wjkfzXufvrc0NeWquXPbGl8y4PDmqd6
	9Fqz0at0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jYx2E-0003nw-Ts; Wed, 13 May 2020 19:27:18 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jYx2B-0003nA-Kj
 for linux-nvme@lists.infradead.org; Wed, 13 May 2020 19:27:16 +0000
Received: by mail-wm1-x344.google.com with SMTP id k12so27760994wmj.3
 for <linux-nvme@lists.infradead.org>; Wed, 13 May 2020 12:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=Mjx7djzRGQo9QTw3QWeaJUFtUv2ohvG54h9QSodj3ZA=;
 b=GtzXhLll98sa+T/P5rxeDMgcO3L2VpVOmoj4YBJu1T01+NTY8ReaZDXvWZOpDtORcT
 mOGeS2C1nTq/N7//B/V3+/9zqOfY1AFETyamDjJ+J4dHJ+YxKQX9H6DaKwUw8XwNLG8A
 utJLIrYD5T8EI5tA5fMYsebCwXeWBTsn41xRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Mjx7djzRGQo9QTw3QWeaJUFtUv2ohvG54h9QSodj3ZA=;
 b=oFCQCGaAoS1wAq5eaNW92pbbOdkNynz5xDRbKY1ASrTPfOfuYrcJbRokTQsPcf7dDD
 GwT/WYJaSeehbeT+ydr4VuVM9A2JhgC5eTbc+LKph+PJoEaF9v5xDk8I8g8mcjUxY7ce
 z69q63A2MqNpUujZSvHKXLuaxV+nUsU7SX/9zFkZ091k/8ZbmPEA03kshvLjQ1KcApOo
 w+XMLuoAmJOGUo11KxJkW2BDonrZZ6k1UUPBkonnapRLpDRRQhiWKyAuEYBPlBPjNMY7
 ZwTndwOgpqHhOkHWrhwdhKFkQCLqwVOSKWQLirfWvuuuedsRvHvgdEmje1xwEhOkvzta
 a1hQ==
X-Gm-Message-State: AGi0PuaQ1Ju3Kd3Vem03K39JKr6xm6YAg3NbIqnxPdQS+GbNRfbRBdaQ
 OUUllB+7AORktqj3eKZqyNV6Tg==
X-Google-Smtp-Source: APiQypJmZaOf2BWCtojkgzR1GpKb+dNMlyn9JhMdi42TQwAHHYE92MVTnYEUUyz4MlULgaIZmYFvYQ==
X-Received: by 2002:a05:600c:29a:: with SMTP id
 26mr36756178wmk.151.1589398034031; 
 Wed, 13 May 2020 12:27:14 -0700 (PDT)
Received: from [10.230.185.151] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id j16sm637524wru.13.2020.05.13.12.27.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2020 12:27:13 -0700 (PDT)
Subject: Re: [PATCH 12/16] nvmet: rename nvmet_check_data_len to
 nvmet_check_transfer_len
To: Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, martin.petersen@oracle.com,
 jsmart2021@gmail.com, axboe@kernel.dk
References: <20200504155755.221125-1-maxg@mellanox.com>
 <20200504155755.221125-13-maxg@mellanox.com>
From: James Smart <james.smart@broadcom.com>
Message-ID: <3a074d5a-e822-7cab-f5a8-bf1221ac9495@broadcom.com>
Date: Wed, 13 May 2020 12:27:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200504155755.221125-13-maxg@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200513_122715_679883_A1D5169C 
X-CRM114-Status: UNSURE (   9.81  )
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
Cc: vladimirk@mellanox.com, idanb@mellanox.com, israelr@mellanox.com,
 shlomin@mellanox.com, oren@mellanox.com, nitzanc@mellanox.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiA1LzQvMjAyMCA4OjU3IEFNLCBNYXggR3VydG92b3kgd3JvdGU6Cj4gRnJvbTogSXNyYWVs
IFJ1a3NoaW4gPGlzcmFlbHJAbWVsbGFub3guY29tPgo+Cj4gVGhlIGZ1bmN0aW9uIGRvZXNuJ3Qg
Y2hlY2sgb25seSB0aGUgZGF0YSBsZW5ndGgsIGJlY2F1c2UgdGhlIHRyYW5zZmVyCj4gbGVuZ3Ro
IGluY2x1ZGVzIGFsc28gdGhlIG1ldGFkYXRhIGxlbmd0aCBpbiBzb21lIGNhc2VzLiBUaGlzIGlz
Cj4gcHJlcGFyYXRpb24gZm9yIGFkZGluZyBtZXRhZGF0YSAoVDEwLVBJKSBzdXBwb3J0Lgo+Cj4g
U2lnbmVkLW9mZi1ieTogSXNyYWVsIFJ1a3NoaW4gPGlzcmFlbHJAbWVsbGFub3guY29tPgo+IFNp
Z25lZC1vZmYtYnk6IE1heCBHdXJ0b3ZveSA8bWF4Z0BtZWxsYW5veC5jb20+Cj4gUmV2aWV3ZWQt
Ynk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPgo+IFJldmlld2VkLWJ5OiBTYWdpIEdy
aW1iZXJnIDxzYWdpQGdyaW1iZXJnLm1lPgo+IFJldmlld2VkLWJ5OiBNYXJ0aW4gSy4gUGV0ZXJz
ZW4gPG1hcnRpbi5wZXRlcnNlbkBvcmFjbGUuY29tPgo+CgpSZXZpZXdlZC1ieTrCoCBKYW1lcyBT
bWFydCA8amFtZXMuc21hcnRAYnJvYWRjb20uY29tPgoKLS0gamFtZXMKCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1udm1lIG1haWxpbmcgbGlz
dApsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
