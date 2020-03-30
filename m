Return-Path: <SRS0=mOBO=5P=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E74BC43331
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Mar 2020 11:45:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B78DB2072E
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Mar 2020 11:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UiB+skas";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="E9A4cXpM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B78DB2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:Subject:
	From:To:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=nqsfTxMI5DIIeZkINep2/Lo8alViRhYeDz7TO7O1jNY=; b=UiB+skas8vCBbc
	HL6iS4sjQkkFDchUYjfR+/lbxcF9lAlFm7F4dWehwsF76eGi2cF5JgZfvNrTeN62rdMLwA+HAqqUz
	l63oHUv/J8UVDK8ZqHvdU7MreHvfa02YPOQHpj3NcNPpEqJCdyvTLU8FnHJWkG++i6glPcIQspN4S
	Y1aZUjDo+eNZuKzGmUFVIyTGYCmE1orFMX5hyF5CgOnHe4j4+WDvtA+LeV2IpmK/xFjen7/u+0ilS
	mTTSKohe+UJ+YPHmWLU5EIWG02OIFRwYAoAk6k9UsFlLRg7882UY1uaUADPnkO8TDHSvHv02v6osP
	bkRuwTxEMk44WbVNal/Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jIsrH-0006jM-BD; Mon, 30 Mar 2020 11:45:35 +0000
Received: from forward100j.mail.yandex.net ([2a02:6b8:0:801:2::100])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jIsrD-0006il-6B
 for linux-nvme@lists.infradead.org; Mon, 30 Mar 2020 11:45:34 +0000
Received: from forward103q.mail.yandex.net (forward103q.mail.yandex.net
 [IPv6:2a02:6b8:c0e:50:0:640:b21c:d009])
 by forward100j.mail.yandex.net (Yandex) with ESMTP id 6F37350E0CFD
 for <linux-nvme@lists.infradead.org>; Mon, 30 Mar 2020 14:45:27 +0300 (MSK)
Received: from mxback3q.mail.yandex.net (mxback3q.mail.yandex.net
 [IPv6:2a02:6b8:c0e:39:0:640:4545:437c])
 by forward103q.mail.yandex.net (Yandex) with ESMTP id 6CD5361E0005
 for <linux-nvme@lists.infradead.org>; Mon, 30 Mar 2020 14:45:27 +0300 (MSK)
Received: from vla5-445dc1c4c112.qloud-c.yandex.net
 (vla5-445dc1c4c112.qloud-c.yandex.net [2a02:6b8:c18:3609:0:640:445d:c1c4])
 by mxback3q.mail.yandex.net (mxback/Yandex) with ESMTP id hz4OyP3yOP-jRaKxdcj; 
 Mon, 30 Mar 2020 14:45:27 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1585568727; bh=RJu6mIqJQmBDRZSp7ioFZ4srcWNgqL5/YnWBV/8MasU=;
 h=Subject:From:To:Date:Message-ID;
 b=E9A4cXpMzP8O6I8XZih9AU5H+7XWB+0dP8nFQAlCXPuUj5y6YWSuMSXnmEITJBYHj
 z08T7VBdufmpIeegEt7F6NQMdj4jRnRMQi1yXtsWeemvPnQm/BarvrI4nwlZeBehET
 ge8UUPvfoN7VZMpvi6cY3oKINOGoaH688j5s2Yho=
Authentication-Results: mxback3q.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by vla5-445dc1c4c112.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA
 id uM7hSNYssb-jQX8tiEi; Mon, 30 Mar 2020 14:45:26 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
To: linux-nvme <linux-nvme@lists.infradead.org>
From: Alex Talker <alextalker@yandex.ru>
Subject: nvme: Duplicate cntlid error
Autocrypt: addr=alextalker@yandex.ru; keydata=
 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
 yQTUMqxFHn/a+cp+b7wLpLIJSg==
Message-ID: <3cfc539a-07ba-3757-073e-dc81f9c0c824@yandex.ru>
Date: Mon, 30 Mar 2020 14:44:52 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200330_044531_724619_3F38DD63 
X-CRM114-Status: UNSURE (   6.00  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

VXNpbmcgRmVkb3JhIDMxIGFzIGEgaG9zdCBJJ20gdHJ5aW5nIHRvIGNvbm5lY3QgdG8gMiBub2Rl
cyB0aGF0IGhvc3QKc3Vic3lzdGVtIHdpdGggb25lIGFuZCB0aGUgc2FtZSBOUU4uClNvIHdoZW4g
SSBjYWxsOgrCoApudm1lIGNvbm5lY3QgLXQgcmRtYSAtYSAxMC4yMS4wLjEgLW4gbnFuLjIwMjAt
MDMuY29tLmV4YW1wbGU6c3Vic3lzdGVtMArCoApkZXZpY2UgbnZtZTAgc3VjY2Vzc2Z1bGx5IGFs
bG9jYXRlZCBidXQgd2hlbiB0aGVuIEkgY2FsbDoKwqAKbnZtZSBjb25uZWN0IC10IHJkbWEgLWEg
MTAuMjAuMC4xIC1uIG5xbi4yMDIwLTAzLmNvbS5leGFtcGxlOnN1YnN5c3RlbTAKwqAKSSBnZXQg
YW4gZXJyb3I6CsKgClsyMzkzNTUuNjYxNTI3XSBudm1lIG52bWUxOiBEdXBsaWNhdGUgY250bGlk
IDEgd2l0aCBudm1lMCwgcmVqZWN0aW5nCsKgCndoYXQgY291bGQgYmUgdGhlIHByb2JsZW0/CkZl
dyBtb250aHMgYmVmb3JlIEkgY2hlY2tlZCBjb25uZWN0aW9uIHRvIGEgc2luZ2xlIG5vZGUgdmlh
IGZldyBwb3J0cwphbmQgaXQgd29ya2VkIG91dCBqdXN0IGZpbmUKYnV0IGF0dGVtcHQgb2YgSC5B
LiBzZXR1cCBmYWlscyBoZXJlLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbGludXgtbnZtZSBtYWlsaW5nIGxpc3QKbGludXgtbnZtZUBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtbnZtZQo=
