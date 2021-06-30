Return-Path: <SRS0=p1db=LY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6C9C11F65
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Jun 2021 08:16:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79BD161D05
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Jun 2021 08:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79BD161D05
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KWclxmQX1l/oxifkzZW997h87kK+ovIuwP6QdYykK/I=; b=yq53osUsIlSWbkkvvafklwtL+4
	1hWurtWF+SdtAU2XAvSkiDw+kvQaePDO6RH077O1chCk8vfmVPRKQcFwuc3TnDof7YDUE4ciZjtqq
	tfkGj8fjTruDYXOp4TqzDoXgbq9R2qZIZ6mO2QiNmBteR28cBAn2MJyBtf54tag3Gscla3+OmHvjm
	ehg3I8s/bgFYno7vIUWZrO9sVHiQm+JHxCuTb3pD3cKq8i740AZC1TeLwKJivHAkIk8nQ2WbXKIh/
	h4AegcG0nLPfLHfo3liwnIebJLP1u/4gTdOVHCd/VFG7gV34o3XmYQv4Vg8jnK+btYpJIZNOFq102
	+nJshfYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lyVO6-00DEso-2s; Wed, 30 Jun 2021 08:16:02 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lyVNt-00DErx-9x
 for linux-nvme@lists.infradead.org; Wed, 30 Jun 2021 08:15:50 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 30E321FE3B;
 Wed, 30 Jun 2021 08:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1625040947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LN6+hSCnnQVV1lBAadscEQCEm2I2cFMswDtuEyY5AQM=;
 b=sqdBm/S1Jp4iQ5rKuwORax/+6LsKR6Mz82+GFHyXqPNErX8hTv0w9tx2Hsycc5Ta2QprYu
 s1Jgqw372Ax5Ryoe82aq5/gIn6gysXiJSSj9wd8rGmTAFMYRppBxLAyQkgbtrb+xyyu/Ie
 ujrnT9B+PcJgSv/LNQUNCzSxB9G8Xeg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1625040947;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LN6+hSCnnQVV1lBAadscEQCEm2I2cFMswDtuEyY5AQM=;
 b=sdq2BggLE1xlv6d2Q78YwVNhSUSDlsqWM6fC4V29RxO68iURFseYXxgMSavoVNDdOUCu5e
 IvOOd63+1YbqkpDQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id 105B111906;
 Wed, 30 Jun 2021 08:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1625040947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LN6+hSCnnQVV1lBAadscEQCEm2I2cFMswDtuEyY5AQM=;
 b=sqdBm/S1Jp4iQ5rKuwORax/+6LsKR6Mz82+GFHyXqPNErX8hTv0w9tx2Hsycc5Ta2QprYu
 s1Jgqw372Ax5Ryoe82aq5/gIn6gysXiJSSj9wd8rGmTAFMYRppBxLAyQkgbtrb+xyyu/Ie
 ujrnT9B+PcJgSv/LNQUNCzSxB9G8Xeg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1625040947;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LN6+hSCnnQVV1lBAadscEQCEm2I2cFMswDtuEyY5AQM=;
 b=sdq2BggLE1xlv6d2Q78YwVNhSUSDlsqWM6fC4V29RxO68iURFseYXxgMSavoVNDdOUCu5e
 IvOOd63+1YbqkpDQ==
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id arNxAzMo3GAiOQAALh3uQQ
 (envelope-from <hare@suse.de>); Wed, 30 Jun 2021 08:15:47 +0000
Subject: Re: [PATCH 2/2] nvme: pass BLK_MQ_F_NOT_USE_MANAGED_IRQ for
 fc/rdma/tcp/loop
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
 Wen Xiong <wenxiong@us.ibm.com>, John Garry <john.garry@huawei.com>
References: <20210629074951.1981284-1-ming.lei@redhat.com>
 <20210629074951.1981284-3-ming.lei@redhat.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <46fdb02d-8d71-d465-072d-5e8d6ec3601f@suse.de>
Date: Wed, 30 Jun 2021 10:15:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210629074951.1981284-3-ming.lei@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210630_011549_541285_096512B9 
X-CRM114-Status: GOOD (  14.66  )
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

T24gNi8yOS8yMSA5OjQ5IEFNLCBNaW5nIExlaSB3cm90ZToKPiBBbGwgdGhlIDQgaG9zdCBkcml2
ZXJzIGRvbid0IHVzZSBtYW5hZ2VkIGlycSBmb3IgY29tcGxldGluZyByZXF1ZXN0LCBzbwo+IGl0
IGlzIGNvcnJlY3QgdG8gcGFzcyB0aGUgZmxhZyB0byBibGstbXEuCj4gCj4gU2Vjb25kbHkgd2l0
aCB0aGlzIGZsYWcsIGJsay1tcSB3aWxsIGhlbHAgdXMgZGlzcGF0Y2ggY29ubmVjdCByZXF1ZXN0
Cj4gYWxsb2NhdGVkIHZpYSBibGtfbXFfYWxsb2NfcmVxdWVzdF9oY3R4KCkgdG8gZHJpdmVyIGV2
ZW4gdGhvdWdoIGFsbAo+IENQVSBpbiB0aGUgc3BlY2lmaWVkIGhjdHgncyBjcHVtYXNrIGFyZSBv
ZmZsaW5lLgo+IApIb3cgaXMgdGhpcyBzdXBwb3NlZCB0byB3b3JrPwpUbyBteSB1bmRlcnN0YW5k
aW5nLCBvbmx5IGNwdXMgaW4gdGhlIGhjdHggY3B1bWFzayBhcmUgZWxpZ2libGUgdG8gc2VuZCAK
SS9PLiBTbyBpZiBhbGwgb2YgdGhlc2UgQ1BVcyBhcmUgb2ZmbGluZSwgd2hvIGV4YWN0bHkgaXMg
c3VibWl0dGluZyBJL08/Ck1vcmUgdG8gdGhlIHBvaW50LCB3aGljaCBDUFUgd2lsbCBiZSBzdWJt
aXR0aW5nIHRoZSBjb25uZWN0IHJlcXVlc3Q/CgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5u
ZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVA
c3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNV
U0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVy
ZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVu
ZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
