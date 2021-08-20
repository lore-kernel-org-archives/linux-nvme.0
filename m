Return-Path: <SRS0=THed=NL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082F1C4338F
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Aug 2021 10:21:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C24A0610CF
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Aug 2021 10:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C24A0610CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yuGDnIL69IAFflD5W4SzMcCc6ZGYUaBs/fRB1B5+WQc=; b=RK0bWYPKJMrgoM4Ytua+hzvloR
	VRTb4opz2H2exCpBC3sRGvavQRe8UCMQO/c4DvCqhz+/i+WLA1JbW5oTLrwF3RXnYMLncod1N0Hzo
	aSW748fiUDGOH95JaQCohNXd6UB7us7Uv+5g2TllpSAidg4mAgnB2n97Q7kM7TbJBml0OxfKS/qEF
	Z4+hiHIeOPpfs4Ak6DnOB1g6ux+5PMiMOl1LWvk9sMO9MoAmcpdtZ7BJNswTqTBKKB00JoxoOfKq4
	8tpj7JxXlFW8PRbQ6ubcD/zKbt/k7fFz2RNG91J2qkLoAdPJhLEZtiC4F4KMX26R6erpY4BU0iyqi
	nEbR+JYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mH1ds-00Ae0L-BA; Fri, 20 Aug 2021 10:20:52 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mH1dn-00AdzE-9p
 for linux-nvme@lists.infradead.org; Fri, 20 Aug 2021 10:20:51 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3A5C622171;
 Fri, 20 Aug 2021 10:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1629454844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OhCV0j00jbEuYVNYugRe7kexm9glmlR/zBJJa6VZI4U=;
 b=dYQBJhC8bvYBeWsDKdc369p8UIjCi/fJ55xj/pJKJlaJpiLVCmR646ydbbqyjJ5puNKDS5
 VwP5k2nCKb3waC8KWbMaiIzQN+na/Z1xTGn7d1nKT1KL1YyZCtwzpf6tkgwR51YAlTk7NJ
 hxjHFbNhdO4q6AL1Wc0+TE6V99xMA60=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1629454844;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OhCV0j00jbEuYVNYugRe7kexm9glmlR/zBJJa6VZI4U=;
 b=gKP2u6eo6H1Yb3VlTBkzw0e+7As9eE+uVMhucrX8nCgXPo5S7mcF+se9wkG/0M4ykwREzU
 giYrZWwh9a7QOUAw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 1BD5E13ABF;
 Fri, 20 Aug 2021 10:20:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id sGbcBfyBH2FlZwAAGKfGzw
 (envelope-from <hare@suse.de>); Fri, 20 Aug 2021 10:20:44 +0000
Subject: Re: [PATCH] nvme-tcp: Do not reset transport on data digest errors
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
 yi.he@emc.com
References: <20210805121541.77613-1-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <37e801b5-37fe-04d1-77d2-45f397e53206@suse.de>
Date: Fri, 20 Aug 2021 12:20:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210805121541.77613-1-dwagner@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210820_032047_537762_F7CBA965 
X-CRM114-Status: GOOD (  18.86  )
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

T24gOC81LzIxIDI6MTUgUE0sIERhbmllbCBXYWduZXIgd3JvdGU6Cj4gVGhlIHNwZWMgc2F5cwo+
IAo+ICAgIDcuNC42LjEgRGlnZXN0IEVycm9yIGhhbmRsaW5nCj4gCj4gICAgV2hlbiBhIGhvc3Qg
ZGV0ZWN0cyBhIGRhdGEgZGlnZXN0IGVycm9yIGluIGEgQzJIRGF0YSBQRFUsIHRoYXQgaG9zdAo+
ICAgIHNoYWxsIGNvbnRpbnVlIHByb2Nlc3NpbmcgQzJIRGF0YSBQRFVzIGFzc29jaWF0ZWQgd2l0
aCB0aGUgY29tbWFuZCBhbmQKPiAgICB3aGVuIHRoZSBjb21tYW5kIHByb2Nlc3NpbmcgaGFzIGNv
bXBsZXRlZCwgaWYgYSBzdWNjZXNzZnVsIHN0YXR1cyB3YXMKPiAgICByZXR1cm5lZCBieSB0aGUg
Y29udHJvbGxlciwgdGhlIGhvc3Qgc2hhbGwgZmFpbCB0aGUgY29tbWFuZCB3aXRoIGEKPiAgICBu
b24tZmF0YWwgdHJhbnNwb3J0IGVycm9yLgo+IAo+IEN1cnJlbnRseSB0aGUgdHJhbnNwb3J0IGlz
IHJlc2V0ZWQgd2hlbiBhIGRhdGEgZGlnZXN0IGVycm9yIGlzCj4gZGV0ZWN0ZWQuIFRvIGZpeCB0
aGlzLCBrZWVwIHRyYWNrIG9mIHRoZSBmaW5hbCBzdGF0dXMgaW4gdGhlIHF1ZXVlCj4gb2JqZWN0
IGFuZCB1c2UgaXQgd2hlbiBjb21wbGV0aW5nIHRoZSByZXF1ZXN0Lgo+IAo+IFRoZSBuZXcgbWVt
YmVyIGNhbiBiZSBwbGFjZWQgYWRqYWNlbnQgdG8gdGhlIHJlY2VpdmUgcmVsYXRlZCBtZW1iZXJz
IGFuZAo+IGZpdHMgaW4gdGhlIGNhY2hlbGluZSBhcyB0aGVyZSBpcyBhIDQgYnl0ZSBob2xlLgo+
IAo+IFNpZ25lZC1vZmYtYnk6IERhbmllbCBXYWduZXIgPGR3YWduZXJAc3VzZS5kZT4KPiAtLS0K
PiAKUmV2aWV3ZWQtYnk6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPgoKQ2hlZXJzLAoK
SGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtlcm5lbCBTdG9y
YWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAr
NDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3Ry
LiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRz
ZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1udm1lCg==
