Return-Path: <SRS0=Lfpf=MM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975AAC07E9B
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jul 2021 17:55:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4415760FF2
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jul 2021 17:55:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4415760FF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gM4vknzwRNboHfwC6SRftJ7ll77A6TYfYJt4wumQVvw=; b=xp3JVeNFqVVXtar+b0Lle9gyfD
	mnclctLb0faJxrsgS37zm5gkddPFyygdSs+Unpe1dPMLsuQSnRwTTHevLlTofl8AIlhmFOZRfv9tf
	1th7VfSakc/uN90T0/16q9jr9Q1CJmi5BFMZca6LBe+vqO3QMyXDBGeaERxA4L61fpQeyHkWUvobO
	EbudyMJDrCoO8r5RvRo7o+V4ox4ZGLJUuXHSJG5MMwUbc3on9KYppe5OBYOePV4RBL4gXI0sVzm2q
	64TmW0MlbUk0LCcTaFoQ2Jv7v7dGH2BKOfw6+cKAxYTVbQ9XZz5JLm6RRkDJHEXYHhNeqg+/lyz7T
	GgeBVmhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m5txh-00Dgwk-Mr; Tue, 20 Jul 2021 17:55:21 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m5txf-00Dgvk-6F
 for linux-nvme@lists.infradead.org; Tue, 20 Jul 2021 17:55:20 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EB2CC202F0;
 Tue, 20 Jul 2021 17:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1626803717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UW6Wh76rfui5RdRw4XByjdKkVulRdJ5gp0kIN3vfFok=;
 b=QfBERNNHGOVtHBDuitwto5/zpmphDCbcvCiuA6jIx5HbOQJa+nGEkWur6kUugEvXZIViHH
 EKkL5UFHaqHAtOKXBQVF2/Wguwq2wUSi/AAG2i2sZVOFxEd3O09pI+sLVUiGJziIvwRist
 yftqk2oi1NfPr5DFJJNjRo4ljbQw9YY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1626803717;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UW6Wh76rfui5RdRw4XByjdKkVulRdJ5gp0kIN3vfFok=;
 b=mdpYsCVfcyd47lfG7WbHaB5Gr2NUgt+xcDp+5nE3+ufe2qqPOvVGSarhklO00zvteP4x5x
 YnYJnXl5veZgfLDg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id CDB7513B9D;
 Tue, 20 Jul 2021 17:55:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id HXulMQUO92AzUgAAGKfGzw
 (envelope-from <hare@suse.de>); Tue, 20 Jul 2021 17:55:17 +0000
Subject: Re: [PATCH v3 4/6] nvme-fc: Wait with a timeout for queue to freeze
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, James Smart <jsmart2021@gmail.com>
References: <20210720124353.127959-1-dwagner@suse.de>
 <20210720124353.127959-5-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <1eff7f17-e347-54bf-b946-151737a69ac0@suse.de>
Date: Tue, 20 Jul 2021 19:55:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210720124353.127959-5-dwagner@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210720_105519_435092_1921C9A9 
X-CRM114-Status: GOOD (  14.49  )
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

T24gNy8yMC8yMSAyOjQzIFBNLCBEYW5pZWwgV2FnbmVyIHdyb3RlOgo+IERvIG5vdCB3YWl0IGlu
ZGlmaW5pdGx5IGZvciBhbGwgcXVldWVzIHRvIGZyZWV6ZS4gSW5zdGVhZCB1c2UgYQo+IHRpbWVv
dXQgYW5kIGFib3J0IHRoZSBvcGVyYXRpb24gaWYgd2UgZ2V0IHN0dWNrLgo+IAo+IFJldmlld2Vk
LWJ5OiBKYW1lcyBTbWFydCA8anNtYXJ0MjAyMUBnbWFpbC5jb20+Cj4gU2lnbmVkLW9mZi1ieTog
RGFuaWVsIFdhZ25lciA8ZHdhZ25lckBzdXNlLmRlPgo+IC0tLQo+ICAgZHJpdmVycy9udm1lL2hv
c3QvZmMuYyB8IDkgKysrKysrKystCj4gICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pCj4gClJldmlld2VkLWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3Vz
ZS5kZT4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZSAgICAgICAgICAg
ICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMg
R21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5i
ZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxp
c3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
