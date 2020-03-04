Return-Path: <SRS0=Ayoq=4V=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37518C3F2CD
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2020 07:17:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A667214D8
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2020 07:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ndBh6mp2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A667214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:Subject:
	From:To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Jh0+DKA9ukVzV1CyNoo5dkq0rOdkwNdHhVXIrY5N+uc=; b=ndBh6mp2lTh33e
	ScXie+oKUXvUTuZ3RmB8yRN/BhMmrKqNMqVUDqufGRbFAT+EjfJ/4rdvjbP4qsB7RK56sfk8rP9Yn
	x6qe13Yb4E5AfW6CvLyFg7fTqRfhpbp/mXa1K3gbIi6MZnjSrDQm1+5nMkGn+3tAe8ijBvGjQgfKt
	YZnnk/z8fBWmi0pKF96aAUh4TqGTeY5ZqNB7+34qG2LDgW0MUZkUC6+t7I3ZCzLnGlCn/5onteTMM
	/ORvYy+e9IIwMTK6Xd/3MCXPc0WXARXvbzTiyUQEX7Awp6s9iY7bBs9bO1+xXbikU5X87EylnXdfK
	aLwn5WN+mfR2MRRd165w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j9OHM-0003CF-6O; Wed, 04 Mar 2020 07:17:16 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j9OHI-0003BZ-2I
 for linux-nvme@lists.infradead.org; Wed, 04 Mar 2020 07:17:14 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id BC252AB64;
 Wed,  4 Mar 2020 07:17:08 +0000 (UTC)
To: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
From: Hannes Reinecke <hare@suse.de>
Subject: [LSF/MM/BPF TOPIC] Storage: generic completion polling
Openpgp: preference=signencrypt
Autocrypt: addr=hare@suse.de; prefer-encrypt=mutual; keydata=
 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
 azzYF4VRJsdl+d0MCaSy8mUh
Message-ID: <6a263bd4-8989-b766-1d33-7b57f4de0c7d@suse.de>
Date: Wed, 4 Mar 2020 08:17:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200303_231712_401842_6B86025D 
X-CRM114-Status: GOOD (  14.54  )
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
Cc: Jens Axboe <axboe@kernel.dk>,
 "linux-scsi@vger.kernel.org" <Linux-scsi@vger.kernel.org>,
 Keith Busch <keith.busch@wdc.com>, James Smart <james.smart@broadcom.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Kashyap Desai <Kashyap.Desai@broadcom.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Himanshu Madhani <hmadhani@marvell.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SGkgYWxsLAoKdGhlcmUgaGFkIGJlZW4gcXVpdGUgc29tZSBkaXNjdXNzaW9uIGFyb3VuZCBjb21w
bGV0aW9uIHBvbGxpbmcgYW5kIHRoZQpmYWN0IHRoYXQgZm9yIGhpZ2gtcGVyZm9ybWFuY2UgZGV2
aWNlcyBpdCBtaWdodCBiZSBhIHBlcmZvcm1hbmNlIGJlbmVmaXQKWzFdWzJdLiBBbmQgZHVyaW5n
IGRpc2N1c3Npb24gd2l0aCBvdGhlciBwZW9wbGUgKGhlbGxvIHRnbHgpIHRoZQpyZWFjdGlvbiBh
bHdheXMgaGFkIGJlZW4gIkNhbid0IHlvdSBkbyBOQVBJPyIKClNvIHRoZSBxdWVzdGlvbiBpczog
Q2FuIHdlPwpJRSBpcyBpdCBwb3NzaWJsZSB0byBoYXZlIGEgZ2VuZXJpYyBmcmFtZXdvcmsgZm9y
IGhhbmRsaW5nIHBvbGxlZApjb21wbGV0aW9uYSBhbmQgaW50ZXJydXB0IGNvbXBsZXRpb25zLCBz
aGlmdGluZyBiZXR3ZWVuIHRoZW0gZGVwZW5kaW5nCm9uIHRoZSBsb2FkPwoKTXkgaWRlYSBpcyB0
byBoYXZlIGEgc2VxdWVuY2UgbGlrZQpjb21wbGV0aW9uIHBvbGxpbmcgLT4gaW50ZXJydXB0IGhh
bmRsaW5nIC0+IHRocmVhZGVkIGlycS9wb2xsaW5nCklFIGludm9rZSBjb21wbGV0aW9uIHBvbGxp
bmcgZGlyZWN0bHkgZnJvbSB0aGUgc3VibWlzc2lvbiBwYXRoLCBlbmFibGUKaW50ZXJydXB0cyB0
byBoYW5kbGUgY29tcGxldGlvbnMgZnJvbSB0aGUgaW50ZXJydXB0IGhhbmRsZXIsIGFuZCBmaW5h
bGx5CnNoaWZ0IHRvIGNvbXBsZXRpb24gcG9sbGluZyBhZ2FpbiBpZiB0b28gbWFueSBjb21wbGV0
aW9ucyBhcmUgcHJlc2VudC4KQ2xlYXJseSB0aGlzIGFwcHJvYWNoIGludm9sdmVzIHF1aXRlIHNv
bWUgdHVuYWJsZXMgKGxpa2UgaG93IG1hbnkKY29tcGxldGlvbnMgYmVmb3JlIGVuYWJsaW5nIHBv
bGxpbmcgZnJvbSBpbnRlcnJ1cHQgY29udGV4dCwgaG93IGxvbmcgdG8Kd2FpdCBmb3IgY29tcGxl
dGlvbnMgYmVmb3JlIGVuYWJsaW5nIGludGVycnVwdHMgZXRjKSwgYnV0IEkgdGhpbmcgaXQKd291
bGQgYmUgd29ydGh3aGlsZSBoYXZpbmcgdGhpcyBhcyBhIGdlbmVyaWMgZnJhbWV3b3JrIGFzIHRo
ZW4gb25lIGNvdWxkCnN0YXJ0IGV4cGVyaW1lbnRpbmcgd2l0aCB0aGUgdmFyaW91cyB0dW5hYmxl
cyB0byBzZWUgd2hpY2ggd29ya3MgYmVzdApmb3IgdGhlIGluZGl2aWR1YWwgaGFyZHdhcmUuCkFu
ZCBpdCB3b3VsZCBsaWZ0IHRoZSBidXJkZW4gZnJvbSB0aGUgaGFyZHdhcmUgdmVuZG9ycyB0byBp
bXBsZW1lbnQgYQpzaW1pbGFyIG1lY2hhbmlzbSBvbiB0aGVpciBvd24uCgpQcm9wb3NlZCBwYXJ0
aWNpcGFudHM6Ck1hcnRpbiBLLiBQZXRlcnNlbgpKZW5zIEF4Ym9lCkNocmlzdG9waCBIZWxsd2ln
CktlaXRoIEJ1c2NoCkthc2h5YXAgRGVzYWkKSmFtZXMgU21hcnQKSGltYW5zaHUgTWFkaGFuaQpT
YWdpIEdyaW1iZXJnCgpbMV1odHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9waXBlcm1haWwvbGlu
dXgtbnZtZS8yMDIwLUZlYnJ1YXJ5LzAyODk2MS5odG1sClsyXWh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xpbnV4LW52bWUvMjAxOTEyMDkxNzU2MjIuMTk2NC0xLWtidXNjaEBrZXJuZWwub3JnLwoK
Q2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlCQkgICAgICAgICAgIEtlcm5l
bCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUJCQkgICAgICAgICAgICAgICAgICArNDkg
OTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgsIE1heGZl
bGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdGOiBG
ZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmxpbnV4LW52bWUgbWFpbGluZyBsaXN0CmxpbnV4LW52bWVAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LW52bWUK
