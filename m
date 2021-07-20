Return-Path: <SRS0=Lfpf=MM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1499C07E95
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jul 2021 17:54:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AECD60FF2
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jul 2021 17:54:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AECD60FF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gGNu0bNcQNSUqLyoj7xPwoSC2CKOTzZ8u/OR/3+Vt7k=; b=vo74Z7SyIvXa7amXT3FHk/wcFU
	F8f7S+MG/ymFNiBswBGB+1kRXvquH1Zyk77NWUQUY9CtGF34OyZ83EIIIXEeEOWku5Hx71++ILiqW
	NwpFZLe9LsHEzwDn1UayouOg9M0nRKQTNPBOBPFxURZmhX48OntJTEbIXn8iibh1Rj0aGZfZ/r1Ua
	C7BImyzkanyOphsomrisxA1outhTxaovG32/3lwUVs5jBACVI4LZYZ7VcO3ycbZvrWCMgh5jCWh/+
	Pq50yfJE77gpEumI0s+DfF9EELFcHpW/OoadRKGmaEjrmruRD/vkYWVPWMQnuSDkJyeALV12hKnBj
	JhsUGp0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m5twh-00DgoD-HS; Tue, 20 Jul 2021 17:54:19 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m5twY-00Dgnt-JE
 for linux-nvme@lists.infradead.org; Tue, 20 Jul 2021 17:54:11 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9603E2248A;
 Tue, 20 Jul 2021 17:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1626803648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DnDWskgkWQt/GvciTz2020D0iW0F1STVTtgzDGjV76w=;
 b=qM7j4R+w8XO/HOCrVombPH/1omsfOH1ctONU31B7qXF3vsHvIUQBEJ38997Ulajhrwtbzp
 qEqHJ+Z2zUdl4OzweECKCwS0PuoQSVPLF0eo9LO7KyJQo4HB1pI3CXitpVF7ygc75OFmbS
 BCV4l9QabcZlc6Tf5TBP94e81GX/Nog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1626803648;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DnDWskgkWQt/GvciTz2020D0iW0F1STVTtgzDGjV76w=;
 b=jmrm3pM49HfPncdYFKTQtJEgC7Sc3p8azACh8dqpix2yIHAADLdn4W141NYiezfuP/OjHC
 cJf4lVepSMTNsWCQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 5507F13B9D;
 Tue, 20 Jul 2021 17:54:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id jgDDE8AN92DkUQAAGKfGzw
 (envelope-from <hare@suse.de>); Tue, 20 Jul 2021 17:54:08 +0000
Subject: Re: [PATCH v3 1/6] nvme-fc: Update hardware queues before using them
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, James Smart <jsmart2021@gmail.com>
References: <20210720124353.127959-1-dwagner@suse.de>
 <20210720124353.127959-2-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <4480bd40-fb5d-7fba-ce1e-78c6fe393d43@suse.de>
Date: Tue, 20 Jul 2021 19:54:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210720124353.127959-2-dwagner@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210720_105410_831672_DF90DC33 
X-CRM114-Status: GOOD (  14.98  )
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

T24gNy8yMC8yMSAyOjQzIFBNLCBEYW5pZWwgV2FnbmVyIHdyb3RlOgo+IEluIGNhc2UgdGhlIG51
bWJlciBvZiBoYXJkd2FyZSBxdWV1ZXMgY2hhbmdlcywgZG8gdGhlIHVwZGF0ZSB0aGUKPiB0YWdz
ZXQgYW5kIGN0eCB0byBoY3R4IGZpcnN0IGJlZm9yZSB1c2luZyB0aGUgbWFwcGluZyB0byByZWNy
ZWF0ZSBhbmQKPiBjb25ubmVjdCB0aGUgSU8gcXVldWVzLgo+IAo+IFJldmlld2VkLWJ5OiBKYW1l
cyBTbWFydCA8anNtYXJ0MjAyMUBnbWFpbC5jb20+Cj4gUmV2aWV3ZWQtYnk6IE1pbmcgTGVpIDxt
aW5nLmxlaUByZWRoYXQuY29tPgo+IFNpZ25lZC1vZmYtYnk6IERhbmllbCBXYWduZXIgPGR3YWdu
ZXJAc3VzZS5kZT4KPiAtLS0KPiAgIGRyaXZlcnMvbnZtZS9ob3N0L2ZjLmMgfCAxNiArKysrKysr
Ky0tLS0tLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9u
cygtKQo+IApSZXZpZXdlZC1ieTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+CgpDaGVl
cnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgS2VybmVs
IFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZl
bGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2No
w6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52
bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LW52bWUK
