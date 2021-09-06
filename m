Return-Path: <SRS0=/f9n=N4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8323AC433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Sep 2021 06:19:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42657600CC
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Sep 2021 06:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 42657600CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RRbJ0WvakytCXtTCPS20MEdn89Sf+BSStbBO3afgamg=; b=siQpYvggTQjNxCkdD9kYjMawQp
	gYk7ievYNKVRVCEzZPdR1LDwxSMfEeQc8tGF0AGaLldPvTXFq7Jmz1dxl42WMZahUPo+kT/X3qO0C
	FLe+epSZBXjsn4n+R45gapeJ822Az7Y7WPcoo4qQJuSNDUZrce+x7juq/+2LO3D9Q+K/0H4lXHSWK
	vsATDgvvmLMZ1GcKzxHMSrRRtQUXMxq3qDu5YI2WOzqkzx+LTizsYzxlLZ0l+LX7YN5VTuThZpRWw
	9Ndcong06q6Gza91NfpzGUMvoiEH5jFBK+jp48ZtAzHXYaoRifgIQoks72TvUHJ1/fkfBnnytggaV
	SslRwBsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mN7yD-00HONp-Hd; Mon, 06 Sep 2021 06:19:05 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mN7y9-00HOLo-Jt
 for linux-nvme@lists.infradead.org; Mon, 06 Sep 2021 06:19:03 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4976A20082;
 Mon,  6 Sep 2021 06:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1630909140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P4Gr5gu+/Hse23+X+v7ckIdKYFVr0+SFB6GIXh/7mKA=;
 b=1AQ4JXfpJTOydyUnkkWeEWJ1L0c1SKUxn74xKexN3zLxC76NDAbcdoViZvXVAE3LnrZlE3
 GEIgr8FCCBi7iV+Xk7muCIFVaq0uOJHcJysEKY0S4xdZX9flCLOT+H7xwBN5bKL00xrZF4
 53AXpKPe4VpfEKwAEHwFvLbnP3QgQIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1630909140;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P4Gr5gu+/Hse23+X+v7ckIdKYFVr0+SFB6GIXh/7mKA=;
 b=OsfXzNCeSbKV+bfZcJsxsoRyih/kOMopVWOIq4Pvdob1ZD7+RFgFvkYZ9rh05kyr2wiRVU
 whZEdVtyvoqcAjDQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id C5FF213299;
 Mon,  6 Sep 2021 06:18:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id lmSWLtKyNWGeTwAAGKfGzw
 (envelope-from <hare@suse.de>); Mon, 06 Sep 2021 06:18:58 +0000
Subject: Re: [PATCH v3 6/8] dm: add add_disk() error handling
To: Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk,
 martin.petersen@oracle.com, jejb@linux.ibm.com, kbusch@kernel.org,
 sagi@grimberg.me, adrian.hunter@intel.com, beanhuo@micron.com,
 ulf.hansson@linaro.org, avri.altman@wdc.com, swboyd@chromium.org,
 agk@redhat.com, snitzer@redhat.com, josef@toxicpanda.com
Cc: hch@infradead.org, bvanassche@acm.org, ming.lei@redhat.com,
 linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-mmc@vger.kernel.org, dm-devel@redhat.com, nbd@other.debian.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210830212538.148729-1-mcgrof@kernel.org>
 <20210830212538.148729-7-mcgrof@kernel.org>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <067651b9-f530-2613-a419-6b8c3b11ef88@suse.de>
Date: Mon, 6 Sep 2021 08:19:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210830212538.148729-7-mcgrof@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210905_231901_917248_20D693F4 
X-CRM114-Status: GOOD (  18.11  )
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

T24gOC8zMC8yMSAxMToyNSBQTSwgTHVpcyBDaGFtYmVybGFpbiB3cm90ZToKPiBXZSBuZXZlciBj
aGVja2VkIGZvciBlcnJvcnMgb24gYWRkX2Rpc2soKSBhcyB0aGlzIGZ1bmN0aW9uCj4gcmV0dXJu
ZWQgdm9pZC4gTm93IHRoYXQgdGhpcyBpcyBmaXhlZCwgdXNlIHRoZSBzaGlueSBuZXcKPiBlcnJv
ciBoYW5kbGluZy4KPiAKPiBUaGVyZSBhcmUgdHdvIGNhbGxzIHRvIGRtX3NldHVwX21kX3F1ZXVl
KCkgd2hpY2ggY2FuIGZhaWwgdGhlbiwKPiBvbmUgb24gZG1fZWFybHlfY3JlYXRlKCkgYW5kIHdl
IGNhbiBlYXNpbHkgc2VlIHRoYXQgdGhlIGVycm9yIHBhdGgKPiB0aGVyZSBjYWxscyBkbV9kZXN0
cm95IGluIHRoZSBlcnJvciBwYXRoLiBUaGUgb3RoZXIgdXNlIGNhc2UgaXMgb24KPiB0aGUgaW9j
dGwgdGFibGVfbG9hZCBjYXNlLiBJZiB0aGF0IGZhaWxzIHVzZXJzcGFjZSBuZWVkcyB0byBjYWxs
Cj4gdGhlIERNX0RFVl9SRU1PVkVfQ01EIHRvIGNsZWFudXAgdGhlIHN0YXRlIC0gc2ltaWxhciB0
byBhbnkgb3RoZXIKPiBmYWlsdXJlLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEx1aXMgQ2hhbWJlcmxh
aW4gPG1jZ3JvZkBrZXJuZWwub3JnPgo+IC0tLQo+ICAgZHJpdmVycy9tZC9kbS5jIHwgNCArKyst
Cj4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4gClJl
dmlld2VkLWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4KCkNoZWVycywKCkhhbm5l
cwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZSAgICAgICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBB
cmNoaXRlY3QKaGFyZUBzdXNlLmRlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKzQ5IDkx
MSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR21iSCwgTWF4ZmVsZHN0ci4gNSwg
OTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhy
ZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtbnZtZQo=
