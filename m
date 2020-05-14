Return-Path: <SRS0=zrHs=64=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52408C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 06:11:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29F2D206D4
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 06:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fv1U0TCO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29F2D206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EpuRwKCIBaSZCdTH9sPrkB2wApvwGljHoQxTvcDWa1Q=; b=fv1U0TCOZ4Sa96qP9jKg34s38
	n9+P85Niayn0531HEs3eraekJfb94S3IiRkSP71+1x+w9V5v9OA9oiJuKYNOH1kqrk7/y6o2u6RiO
	tak0s8pz2h2fv7ixZSAGkzxUSHDkzZLPzgXe4yyjXKwKP/RvuF0fWIGRn7zoOFHC4B1/f5J0a4n+P
	/mGCkkrDLB3UHNYKB0nTVg5bsZEgIXi6hK2FlNwAAl4rbOlGc7cbm/zbXXDxmCZ0KrpC3ny3jVD1d
	CoGZsgPXkSLzgJuuO6/x6wQfhVpqYOW0zJ6a3rY5mmr+HcKEiNwSv8JqwC9hUoZOKMCaYpHbgnu6T
	2oVwzCQHw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jZ75S-0007IY-83; Thu, 14 May 2020 06:11:18 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jZ75P-0007Hb-Em
 for linux-nvme@lists.infradead.org; Thu, 14 May 2020 06:11:16 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 72628AD18;
 Thu, 14 May 2020 06:11:16 +0000 (UTC)
Subject: Re: [PATCH] nvme: Fix io_opt limit setting
To: Damien Le Moal <damien.lemoal@wdc.com>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>
References: <20200514015452.1055278-1-damien.lemoal@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <6feea03c-4c17-8f56-e0a4-3f1e3d81d76e@suse.de>
Date: Thu, 14 May 2020 08:11:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200514015452.1055278-1-damien.lemoal@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200513_231115_641165_0995ABDA 
X-CRM114-Status: GOOD (  20.91  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gNS8xNC8yMCAzOjU0IEFNLCBEYW1pZW4gTGUgTW9hbCB3cm90ZToKPiBDdXJyZW50bHksIGEg
bmFtZXNwYWNlIGlvX29wdCBxdWV1ZSBsaW1pdCBpcyBzZXQgYnkgZGVmYXVsdCB0byB0aGUKPiBw
aHlzaWNhbCBzZWN0b3Igc2l6ZSBvZiB0aGUgbmFtZXNwYWNlIGFuZCB0byB0aGUgdGhlIHdyaXRl
IG9wdGltYWwKPiBzaXplIChOT1dTKSB3aGVuIHRoZSBuYW1lc3BhY2UgcmVwb3J0cyB0aGlzIHZh
bHVlLiBUaGlzIGNhdXNlcyBwcm9ibGVtcwo+IHdpdGggYmxvY2sgbGltaXRzIHN0YWNraW5nIGlu
IGJsa19zdGFja19saW1pdHMoKSB3aGVuIGEgbmFtZXNwYWNlIGJsb2NrCj4gZGV2aWNlIGlzIGNv
bWJpbmVkIHdpdGggYW4gSEREIHdoaWNoIGdlbmVyYWxseSBkbyBub3QgcmVwb3J0IGFueSBvcHRp
bWFsCj4gdHJhbnNmZXIgc2l6ZSAoaW9fb3B0IGxpbWl0IGlzIDApLiBUaGUgY29kZToKPiAKPiAv
KiBPcHRpbWFsIEkvTyBhIG11bHRpcGxlIG9mIHRoZSBwaHlzaWNhbCBibG9jayBzaXplPyAqLwo+
IGlmICh0LT5pb19vcHQgJiAodC0+cGh5c2ljYWxfYmxvY2tfc2l6ZSAtIDEpKSB7Cj4gCXQtPmlv
X29wdCA9IDA7Cj4gCXQtPm1pc2FsaWduZWQgPSAxOwo+IAlyZXQgPSAtMTsKPiB9Cj4gCj4gcmVz
dWx0cyBpbiBibGtfc3RhY2tfbGltaXRzKCkgdG8gcmV0dXJuIGFuIGVycm9yIHdoZW4gdGhlIGNv
bWJpbmVkCj4gZGV2aWNlcyBoYXZlIGRpZmZlcmVudCBidXQgY29tcGF0aWJsZSBwaHlzaWNhbCBz
ZWN0b3Igc2l6ZXMgKGUuZy4gNTEyQgo+IHNlY3RvciBTU0Qgd2l0aCA0S0Igc2VjdG9yIGRpc2tz
KS4KPiAKPiBGaXggdGhpcyBieSBub3Qgc2V0dGluZyB0aGUgb3B0aW9tYWwgSU8gc2l6ZSBsaW1p
dCBpZiB0aGUgbmFtZXNwYWNlIGRvZXMKPiBub3QgcmVwb3J0IGFuIG9wdGltYWwgd3JpdGUgc2l6
ZSB2YWx1ZS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBEYW1pZW4gTGUgTW9hbCA8ZGFtaWVuLmxlbW9h
bEB3ZGMuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIHwgOCArKysrLS0t
LQo+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPiAK
QWgsIHNvIHlvdSBiZWF0IG1lIHRvIGl0IDotKQoKUmV2aWV3ZWQtYnk6IEhhbm5lcyBSZWluZWNr
ZSA8aGFyZUBzdXNlLmRlPgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tl
ICAgICAgICAgICAgVGVhbWxlYWQgU3RvcmFnZSAmIE5ldHdvcmtpbmcKaGFyZUBzdXNlLmRlICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdh
cmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4
MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LW52
bWUgbWFpbGluZyBsaXN0CmxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
