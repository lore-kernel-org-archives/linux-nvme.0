Return-Path: <SRS0=InZj=L7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD337C07E95
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jul 2021 15:25:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7891F61CBE
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jul 2021 15:25:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7891F61CBE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XoFL8AAvpSmXWOpjdTc+Av3xMmFUaCZiRO+EzcJtfZM=; b=i4/c1uHAxmZ8kIRv1eA8TSNeSF
	Zvwnc8LFrKt4u74uEx9aEuJfiDScRmSgWDuMmcbBS0/sUkDaczQltwb4nbo78PmFKc6iDa2cIRPc2
	+CONt4FN4+/aVlNBfjd4jRRrFerCNcehnV1th/dVoXJagPVLMrCu7ooPJOhnOyLOwQUXw9pljG97e
	yoDOw/CVxWNiuFDpYuilHXCfFHcek5BnxmsrLH1WBiqpNY/4QR5OEVSkKxQF1LYsBPdR2C7QHy8XF
	7rpkdqTGCOZkiN/MAHRfKkLayEZwjtgyeftzrz6mRyOdkFM8A8WIAAWUCg4xFk8cGfZaiUECpUafP
	R+EVVrVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m19Qk-00FBd8-D7; Wed, 07 Jul 2021 15:25:42 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m19Qe-00FBc3-9Y
 for linux-nvme@lists.infradead.org; Wed, 07 Jul 2021 15:25:40 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0487A22633;
 Wed,  7 Jul 2021 15:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1625671535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0R5lPVCbbCRHz/Pip3XPc9aolAF9awtsNztV0AuTrZY=;
 b=E3pZHzY2iU7few8XH0v94/lvfZxzIV/IOmL3chvQXjT/U60mZvZNWyVfvsmgzqiQRy1pJM
 SI/UEQvp/rQiUlCxcJGIqxkfPsgQbqqnXUAOQU0BI6HCxpMtA4zUn7RJbfA/n3Y4vcbzbv
 7M2ol8zQ0QW6VB2zPOaK1EZalSyt2Q8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1625671535;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0R5lPVCbbCRHz/Pip3XPc9aolAF9awtsNztV0AuTrZY=;
 b=6MbzFAMzqpgO0M2k68LHr6YuK+C8zsVEoRN6UPoEQhXI6bE1H7XLj05nptO1g7Deyl9ql1
 JZAb9/qP272vvjCQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id AE3ED1399B;
 Wed,  7 Jul 2021 15:25:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id OtoLKW7H5WB5OQAAGKfGzw
 (envelope-from <hare@suse.de>); Wed, 07 Jul 2021 15:25:34 +0000
Subject: Re: [PATCH v4 00/20] NVMeTCP Offload ULP
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Prabhakar Kushwaha
 <pkushwaha@marvell.com>, linux-nvme@lists.infradead.org, sagi@grimberg.me,
 axboe@fb.com, davem@davemloft.net, kuba@kernel.org, smalin@marvell.com,
 aelior@marvell.com, mkalderon@marvell.com, okulkarni@marvell.com,
 prabhakar.pkin@gmail.com, malin1024@gmail.com
References: <20210629124743.6898-1-pkushwaha@marvell.com>
 <20210701132307.GA18548@lst.de>
 <c19a9d80-0d12-1ad0-8dce-169997ba5364@suse.de>
 <20210707150733.GA287883@dhcp-10-100-145-180.wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <0c75d24d-6c7a-2aff-42b0-3ae343fbf057@suse.de>
Date: Wed, 7 Jul 2021 17:25:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210707150733.GA287883@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210707_082536_527618_09B6A6D1 
X-CRM114-Status: GOOD (  16.11  )
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

T24gNy83LzIxIDU6MDcgUE0sIEtlaXRoIEJ1c2NoIHdyb3RlOgo+IE9uIFdlZCwgSnVsIDA3LCAy
MDIxIGF0IDA0OjU4OjQ0UE0gKzAyMDAsIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPj4gT24gNy8x
LzIxIDM6MjMgUE0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+Pj4gSSBsb29rZWQgb3ZlciBp
dCBhIGJpdCAoYW5kIHdpbGwgc2VuZCBzb21lIGluZGl2aWR1YWwgY29tbWVudHMpLCBhbmQgSQo+
Pj4gaGF2ZSB0byBzYXkgSSByZWFsbHkgZGlzbGlrZSBob3cgdGhpcyBsYXllciBhbmQgaG93IHRo
ZSBoYXJkd2FyZSB3b3Jrcy4KPj4+Cj4+PiBUaGUgd2hvbGUgcG9pbnQgb2YgTlZNZSBpcyB0aGF0
IHdlIGhhdmUgYSBuaWNlbHkgc3RhbmRhcmRpemVkIFBDSWUKPj4+IHJlZ2lzdGVyIGxldmVsIGlu
dGVyZmFjZS4gIE9uZSB0aGF0IHlvdSBjYW4gdHJpdmlhbGx5IGhpZGUgYSBUQ1Agb2ZmbG9hZAo+
Pj4gdW5kZXIgd2l0aCBqdXN0IGEgbGl0dGxlIGNvbnRyb2wgcGxhbmUgbG9naWMuICBCdXQgaW5z
dGVhZCB3ZSBjb21lIHVwIHdpdGgKPj4+IHRoaXMgZ2lnYW50IG1lc3MuCj4+Pgo+PiBJIGNhbid0
IHJlYWxseSBzZWUgaG93IHRoaXMgY29udHJvbCBwbGFuZSBsb2dpYyBzaG91bGQgd29yazsgaG93
IHdvdWxkIHRoZQo+PiBlbnRpcmUgTlZNZS1vRiBkaXNjb3ZlcnkgYmUgYWJzdHJhY3RlZCBhd2F5
IHRvIGhpZGUgYmVoaW5kIGFuIE5WTWUtUENJCj4+IGRldmljZT8KPiAKPiBEZXZpY2VzIGFyZSBh
bHJlYWR5IGRvaW5nIHRoaXMuIFRoZSBkaXNjb3Zlcnkgc2V0dXAgaXMgZGV2aWNlIHNwZWNpZmlj
LAo+IHRob3VnaC4KPiAKT2gsIGdyYW5kLgpJIGhvcGVkIHdlIGNvdWxkIHN0ZWVyIGF3YXkgZnJv
bSB0aGlzIGFmdGVyIHRoZSBob3JyaWJsZSBleHBlcmllbmNlIHdlIApoYWQgd2l0aCBpU0NTSSBv
ZmZsb2FkIGVuZ2luZXMuCkknZCByYXRoZXIgaGF2ZSBhIHN0YW5kYXJkaXplZCB3YXkgZm9yIHRo
aXMuCgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAgICAg
ICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdt
YkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVy
ZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0
CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
