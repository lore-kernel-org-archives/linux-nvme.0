Return-Path: <SRS0=7k1C=KV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B836CC2B9F7
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 09:12:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C33B61408
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 09:12:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C33B61408
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=+jcd/Ujy+RIy3rn1l6mC8S58B2keTJE2G5aa+HdGqh4=; b=eazU1qq1VjyepS5TytEViXCn7O
	YDfoBGA3zbH64ECILexaOUpBgEV1mcivmj2XC5A3cVO0/vvAWFb0eX+9vQ4omkBGZ8BsI1+ldfVAc
	Gs7TmZgrQcZeNbwcDMQNd1EkOjU3U410B9basqwbBA4jBidyEzpy1PAaWonaz7T8Pbj6y4ZERMbm2
	hePmMV+itQVkCSNBjzH71/CNXyCYsR/Vn2kI9Q2AEJGGhr6fH6UmZ0v7ItdgBitLtydMMmQ5xqYGv
	IjNOW3QbJomcCt35os6KAXEwwCk1+I4mvrrxVJ2vI5WCXWwowTpkFj76avQkFDC5OYsK2D0cPIZKn
	EIiQN+/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llpaC-00Clf1-24; Wed, 26 May 2021 09:12:08 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llpKj-00Cf3E-Cz
 for linux-nvme@lists.infradead.org; Wed, 26 May 2021 08:56:10 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by smtp-out2.suse.de (Postfix) with ESMTP id 6AF7C1FD2A;
 Wed, 26 May 2021 08:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1622019367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BprkZPaltazcckI4Nd4vbDsN3y4m92O9bNPoj9W59pg=;
 b=IjXNg5kllYTgxP3C/He5JXHBPoSeuHlGu5X4QcU2Dh0taY/sfGVYREcbvZ31z/iA8ljUhA
 8F1NWeWz9L3i9Y2vkHEFAXWkJVk4mICVnNjdghs0LVH4GIEc4dIQS0CsPQZvHwwgcXpld1
 hqilID6tWvAaXJurUF1skcpQugL7Xng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1622019367;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BprkZPaltazcckI4Nd4vbDsN3y4m92O9bNPoj9W59pg=;
 b=4Kw6Fwky/rScvOXH+SK8bB5ctY/59uzj/LTGA/dhtmPiCygPHEPQDZjKW0Se3L5I5T87/G
 qzmV1B82FnP/7QCA==
Received: from director2.suse.de (director2.suse-dmz.suse.de [192.168.254.72])
 by imap.suse.de (Postfix) with ESMTPSA id 48D8411A98;
 Wed, 26 May 2021 08:56:07 +0000 (UTC)
Subject: Re: [PATCH v2 3/4] nvme-tcp: don't check blk_mq_tag_to_rq when
 receiving pdu data
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Daniel Wagner <dwagner@suse.de>
References: <20210519174340.1144806-1-sagi@grimberg.me>
 <20210519174340.1144806-4-sagi@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <389a4fd0-1591-a97d-8576-4d8a1fb5e962@suse.de>
Date: Wed, 26 May 2021 10:56:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210519174340.1144806-4-sagi@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210526_015609_624542_5538DB51 
X-CRM114-Status: GOOD (  13.12  )
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

T24gNS8xOS8yMSA3OjQzIFBNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+IFdlIGFscmVhZHkgdmFs
aWRhdGUgaXQgd2hlbiByZWNlaXZpbmcgdGhlIGMyaGRhdGEgcGR1IGhlYWRlcgo+IGFuZCB0aGlz
IGlzIG5vdCBjaGFuZ2luZyBzbyB0aGlzIGlzIGEgcmVkdW5kYW50IGNoZWNrLgo+IAo+IFNpZ25l
ZC1vZmYtYnk6IFNhZ2kgR3JpbWJlcmcgPHNhZ2lAZ3JpbWJlcmcubWU+Cj4gLS0tCj4gIGRyaXZl
cnMvbnZtZS9ob3N0L3RjcC5jIHwgMTQgKysrLS0tLS0tLS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQs
IDMgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pCj4gClJldmlld2VkLWJ5OiBIYW5uZXMg
UmVpbmVja2UgPGhhcmVAc3VzZS5kZT4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBS
ZWluZWNrZQkJICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlCQkJ
ICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMg
R2VybWFueSBHbWJILCA5MDQwOSBOw7xybmJlcmcKR0Y6IEYuIEltZW5kw7ZyZmZlciwgSFJCIDM2
ODA5IChBRyBOw7xybmJlcmcpCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1udm1lCg==
