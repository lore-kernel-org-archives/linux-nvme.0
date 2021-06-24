Return-Path: <SRS0=KdjD=LS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABC7C48BDF
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Jun 2021 05:51:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA08A613E2
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Jun 2021 05:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA08A613E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gi/U3TIYVrCG+Gf8hvOO9FmjDME9BbJ/ahuJX9l9CZc=; b=3Ldp7BKSrwehvaBdOXY5PXfK+H
	jmjwNKPnoyOcffZFj+XcznKCedvy/yfQrniOgr3r8GBrU+GzEsb/K1E41q73IdgZlyw0egdKcQoXg
	6Ki+i9WBVhCM44Fbl8eI6rZbXtliVV+uTC8R3URlRzzdObjZPQLdiiImLbSKWREfO7gIaEQe6bIA0
	iiu9puwY7YB3SPiegUE+37hTYdCyLZKdMegtylJ2dIpa9LUtQFKhw+C6AWfNLJxKwidls/yRRO2sJ
	vBwZ9DtRpjqI/vcAnfFKy7p1NTFi/w2qeheB9dQQfoErL2IKdqRlCcDBuXKScwWJdLoMT/2u6L5Il
	+ZAnrKAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lwIGm-00Cs9C-Pq; Thu, 24 Jun 2021 05:51:20 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lwIGk-00Cs8c-5B
 for linux-nvme@lists.infradead.org; Thu, 24 Jun 2021 05:51:19 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5A0931FD66;
 Thu, 24 Jun 2021 05:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1624513876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vXIZhwONYl6RSLoWQiqemMXOreZQcjiYnE/gdfrhutg=;
 b=KT8F+xiETDXfwt4+Yl3Fc0Aowd+V/cJV0EpOILhJSToZnMm+vI6f1ar62MFTozOMRRGG49
 y82Bo/WVxaILjzhl1Qr14ltAl6iDeDv1fPofFPCDGhYXvnuXtvAypVHBnXyP9fmSUTCi8F
 iXET/qtK7BZBvHKgYxU0FoC55Qqxs8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1624513876;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vXIZhwONYl6RSLoWQiqemMXOreZQcjiYnE/gdfrhutg=;
 b=8cBcmtbZbV1C6cFAzOqmqhet+4e99Eqx3EYP5z2+u7D5IAFukFYl8u0zgHGMXcvKBv0T0i
 Y0jB6D4+0ptTpnBA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id 34E8211A97;
 Thu, 24 Jun 2021 05:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1624513876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vXIZhwONYl6RSLoWQiqemMXOreZQcjiYnE/gdfrhutg=;
 b=KT8F+xiETDXfwt4+Yl3Fc0Aowd+V/cJV0EpOILhJSToZnMm+vI6f1ar62MFTozOMRRGG49
 y82Bo/WVxaILjzhl1Qr14ltAl6iDeDv1fPofFPCDGhYXvnuXtvAypVHBnXyP9fmSUTCi8F
 iXET/qtK7BZBvHKgYxU0FoC55Qqxs8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1624513876;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vXIZhwONYl6RSLoWQiqemMXOreZQcjiYnE/gdfrhutg=;
 b=8cBcmtbZbV1C6cFAzOqmqhet+4e99Eqx3EYP5z2+u7D5IAFukFYl8u0zgHGMXcvKBv0T0i
 Y0jB6D4+0ptTpnBA==
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id lYsGDFQd1GCWVQAALh3uQQ
 (envelope-from <hare@suse.de>); Thu, 24 Jun 2021 05:51:16 +0000
Subject: Re: [PATCH 0/2] nvme-fabrics: short-circuit connect retries
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20210623143250.82445-1-hare@suse.de>
 <8d7c79d9-0928-8c71-74fd-7185d67e7895@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <204a6656-ef83-b688-4979-26fe17f57974@suse.de>
Date: Thu, 24 Jun 2021 07:51:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <8d7c79d9-0928-8c71-74fd-7185d67e7895@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210623_225118_396265_86F2B5B7 
X-CRM114-Status: GOOD (  12.97  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gNi8yMy8yMSAxMTozOCBQTSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPiAKPj4gSGkgYWxsLAo+
Pgo+PiBjb21taXQgZjI1ZjhlZjcwY2UyICgibnZtZS1mYzogc2hvcnQtY2lyY3VpdCByZWNvbm5l
Y3QgcmV0cmllcyIpCj4+IGFsbG93ZWQgdGhlIGZjIHRyYW5zcG9ydCB0byBob25vdXIgdGhlIERO
UiBiaXQgZHVyaW5nIHJlY29ubmVjdAo+PiByZXRyaWVzLCBhbGxvd2luZyB0byBzcGVlZCB1cCBl
cnJvciByZWNvdmVyeS4KPiAKPiBIb3cgZG9lcyB0aGlzIHNwZWVkIHVwIGVycm9yIHJlY292ZXJ5
PwoKV2VsbCwgbm90IGV4YWN0bHkgZXJyb3IgcmVjb3ZlcnkgKGFzIHRoZXJlIGlzIG5vdGhpbmcg
dG8gcmVjb3ZlcikuCkJ1dCB3ZSB3b24ndCBhdHRlbXB0IHBvaW50bGVzcyByZXRyaWVzLCB0aGVy
ZWJ5IHJlZHVjaW5nIHRoZSBub2lzZSBpbiAKdGhlIG1lc3NhZ2UgbG9nLgoKQ2hlZXJzLAoKSGFu
bmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdl
IEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArNDkg
OTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1
LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8
aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1udm1lCg==
