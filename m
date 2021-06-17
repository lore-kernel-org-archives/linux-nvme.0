Return-Path: <SRS0=fYEw=LL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC18C2B9F4
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Jun 2021 05:46:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2150760C3E
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Jun 2021 05:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2150760C3E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mjkV1kOxUGiKXIJW3BCTAdReF32kiIuVPZthm1CyGMU=; b=IFtpLYuaikLvYdYBb77FmFURHg
	DB47QApOjcarfYucNLkvwUbuoUCtcwD6cLDeTCRjD4mK3XN1RcTx3HTkl7c9JrQcj5pl9fhYbpsm6
	pyXtMEih3BiNFMfIy/apE0qKGrLbVJ+SGhktm73y6VtRgvjkjvdCk2a0CjQfZQoH3kZR0RN7xuIo3
	qdy5HPhejWfhkIXjRaLITm4IpeBW8CMmrMLvqzgn97seK0y7W5B1/blcyxn+r4Srty0KVo4OoyX8o
	LVSdxztpaY6NXq8+qtueEK9lCm7Mbelj8vpLWReCIo2tUOgAwWfSkvSmdwKtjC8G9kK4LMZI/zkcj
	ndXT4zDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltkqZ-008yEX-BB; Thu, 17 Jun 2021 05:45:47 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ltkqW-008yE6-9O
 for linux-nvme@lists.infradead.org; Thu, 17 Jun 2021 05:45:45 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 230351FDAE;
 Thu, 17 Jun 2021 05:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623908740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ef5ePcwKML10qdcboaUheybnwRKQQAyIx9pm/RRTLcI=;
 b=P3u/7pSvRTDTuUWCYN1vU05Rr36SF+jGp/yr/vSe1jXFYIy6nXgdEEzOjHVcgR5/bJRW0m
 mk2mlBo0XmVW8Wfh9FGvbaGYPJXRoB1Phy6ZMf2VSUAMgrJskRSMDghv1PXphEoCjcLMn7
 uiSy/IFuyLY3COslhXCT0RIvicEE1G4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623908740;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ef5ePcwKML10qdcboaUheybnwRKQQAyIx9pm/RRTLcI=;
 b=jmGgj2xcZHREmhtT3fextSHAYWYr6mDE2+aQYUmSD8dC5CllYn7PIDQFvNVQwjQZFtae2r
 w+o1hgQi+vAs+eAQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id EB646118DD;
 Thu, 17 Jun 2021 05:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623908740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ef5ePcwKML10qdcboaUheybnwRKQQAyIx9pm/RRTLcI=;
 b=P3u/7pSvRTDTuUWCYN1vU05Rr36SF+jGp/yr/vSe1jXFYIy6nXgdEEzOjHVcgR5/bJRW0m
 mk2mlBo0XmVW8Wfh9FGvbaGYPJXRoB1Phy6ZMf2VSUAMgrJskRSMDghv1PXphEoCjcLMn7
 uiSy/IFuyLY3COslhXCT0RIvicEE1G4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623908740;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ef5ePcwKML10qdcboaUheybnwRKQQAyIx9pm/RRTLcI=;
 b=jmGgj2xcZHREmhtT3fextSHAYWYr6mDE2+aQYUmSD8dC5CllYn7PIDQFvNVQwjQZFtae2r
 w+o1hgQi+vAs+eAQ==
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id Wms/OIPhymDzVQAALh3uQQ
 (envelope-from <hare@suse.de>); Thu, 17 Jun 2021 05:45:39 +0000
Subject: Re: [PATCH v3 1/4] params: lift param_set_uint_minmax to common code
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20210616211936.451128-1-sagi@grimberg.me>
 <20210616211936.451128-2-sagi@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <9855eaf9-52c0-05d7-bc04-d777cdfca262@suse.de>
Date: Thu, 17 Jun 2021 07:45:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210616211936.451128-2-sagi@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210616_224544_521916_18E232F3 
X-CRM114-Status: GOOD (  14.42  )
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

T24gNi8xNi8yMSAxMToxOSBQTSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPiBJdCBpcyBhIHVzZWZ1
bCBoZWxwZXIgaGVuY2UgbW92ZSBpdCB0byBjb21tb24gY29kZSBzbyBvdGhlcnMgY2FuIGVuam95
Cj4gaXQuCj4gCj4gU3VnZ2VzdGVkLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4K
PiBSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxjaGFpdGFueWEua3Vsa2FybmlAd2Rj
LmNvbT4KPiBDYzogbGludXgtbmZzQHZnZXIua2VybmVsLm9yZwo+IENjOiBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnCj4gU2lnbmVkLW9mZi1ieTogU2FnaSBHcmltYmVyZyA8c2FnaUBncmlt
YmVyZy5tZT4KPiAtLS0KPiAgIGluY2x1ZGUvbGludXgvbW9kdWxlcGFyYW0uaCB8ICAzICsrKwo+
ICAga2VybmVsL3BhcmFtcy5jICAgICAgICAgICAgIHwgMTkgKysrKysrKysrKysrKysrKysrKwo+
ICAgbmV0L3N1bnJwYy94cHJ0c29jay5jICAgICAgIHwgMTggLS0tLS0tLS0tLS0tLS0tLS0tCj4g
ICAzIGZpbGVzIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKyksIDE4IGRlbGV0aW9ucygtKQo+IApS
ZXZpZXdlZC1ieTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuY29tPgoKQ2hlZXJzLAoKSGFu
bmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdl
IEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArNDkg
OTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1
LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8
aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1udm1lCg==
