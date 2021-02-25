Return-Path: <SRS0=GtbF=H3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A48C433E6
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 08:11:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1100D64E4D
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 08:11:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1100D64E4D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0xuxISRw9cU5khQt9l7hB7xZhzLto+n3Aob5JNJ/hGw=; b=D85qqMLUls4IJhC0SQvH8CsRs
	3pqJXWoj3QTt0qqH+TDkoMyXdINiWFBBG8iMYMigZcACqWJ2M04v7nIx6h+US5rI9Cpg17MBtMYjp
	PzMB7dqjBtDEw5Q3TIqld+f4ODvlzGqkzMPpaX0dv60fBUY0HF3IXh+EyOXxgG0+Nl0q0Js0FHT13
	/+AMOaBNl/cYoDYEVLaDuLw0Y2iSxvCO2+gbKklI8XZHJBx5QIKDa6q6rsqbzvMmw25N15ACMsbwg
	VYZSKcaPw0LdENljRoGbbwaTGSAeVMJ/N5fednKfUk/G+PCBaVIU5TxNjTH8F0w35RncTiec3Pn5X
	OkXq0z1BA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lFBjV-0007vZ-T1; Thu, 25 Feb 2021 08:10:49 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lFBjT-0007ur-Qd
 for linux-nvme@lists.infradead.org; Thu, 25 Feb 2021 08:10:48 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 20A38ACF6;
 Thu, 25 Feb 2021 08:10:46 +0000 (UTC)
Subject: Re: [PATCH 1/2] nvme: add 'fail_if_no_path' sysfs attribute
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
References: <20210223115922.104369-1-hare@suse.de>
 <20210223115922.104369-2-hare@suse.de>
 <303e7252-cb51-d6e2-eb4c-ad70fb3528a3@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <fdf478ae-3784-869d-5512-55c7907a65a8@suse.de>
Date: Thu, 25 Feb 2021 09:10:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <303e7252-cb51-d6e2-eb4c-ad70fb3528a3@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210225_031048_016304_752241A9 
X-CRM114-Status: GOOD (  23.14  )
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
Cc: linux-nvme@lists.infradead.org, Keith Busch <keith.busch@wdc.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMi8yNC8yMSAxMTo0NyBQTSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPiAKPiAKPiBPbiAyLzIz
LzIxIDM6NTkgQU0sIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPj4gSW4gc29tZSBzZXR1cHMgbGlr
ZSBSQUlEIG9yIGNsdXN0ZXIgd2UgbmVlZCB0byByZXR1cm4gYW4gSS9PIGVycm9yCj4+IG9uY2Ug
YWxsIHBhdGhzIGFyZSB1bmF2YWlsYWJsZSB0byBhbGxvdyB0aGUgdXBwZXIgbGF5ZXJzIHRvIHN0
YXJ0Cj4+IHRoZWlyIG93biBlcnJvciByZWNvdmVyeSAobGlrZSByZWRpcmVjdGluZyBJL08gdG8g
b3RoZXIgbWlycm9ycykuCj4+IFRoaXMgcGF0Y2ggYWRkcyBhIHN5c2ZzIGF0dHJpYnV0ZSAnZmFp
bF9pZl9ub19wYXRoJyB0byBhbGxvdyB0aGUKPj4gYWRtaW4gdG8gZW5hYmxlIHRoYXQgYmVoYXZp
b3VyIGluc3RlYWQgb2YgdGhlIGN1cnJlbnQgJ3F1ZXVlIHVudGlsCj4+IGEgcGF0aCBiZWNvbWVz
IGF2YWlsYWJsZScgcG9saWN5Lgo+IAo+IERvZXNuJ3QgdGhlIHNhbWUgaGFwcGVuIHRvZGF5IGlm
IGFsbCB0aGUgY29udHJvbGxlcnMgYXJlIHNldCB3aXRoCj4gZmFpbF9pb19mYXN0X3Rtbz0wPyBu
dm1lX2F2YWlsYWJsZV9wYXRoIHdpbGwgcmV0dXJuIGZhbHNlIGlmIGFsbAo+IHRoZSBwYXRocyBo
YXZlIE5WTUVfQ1RSTF9GQUlMRkFTVF9FWFBJUkVEIHNldC4KPiAKPiBJIHRoaW5rIHRoYXQgZmFp
bF9pb19mYXN0X3RtbyBzaG91bGQgYmUgc2V0dGFibGUgdmlhIHN5c2ZzIGFuZCBJCj4gdGhpbmsg
SSByZXF1ZXN0ZWQgdGhhdCBkdXJpbmcgdGhlIHZhcmlvdXMgc3VibWlzc2lvbiBpdGVyYXRpb25z
Li4uCj4gCj4gSSdtIG5vdCBzdXJlIHRoaXMgc2hvdWxkIGJlIGNvbnRyb2xsZWQgb24gdGhlIGlu
ZGl2aWR1YWwgbmFtZXNwYWNlIGxldmVsLi4uCgpJbmRlZWQsIHlvdSBhcmUgcmlnaHQ7IHVzaW5n
ICdmYXN0X2lvX2ZhaWxfdG1vJyB3b3JrcyBhcyB3ZWxsIGhlcmUuClNvIEknbGwgYmUgcmVkb2lu
ZyB0aGUgcGF0Y2ggc2VyaWVzIGFuZCB3aWxsIGJlIHJlcGxhY2luZyB0aGlzIHBhdGNoIAp3aXRo
IGFub3RoZXIgb25lIGFkZGluZyBhIHBlci1jb250cm9sbGVyICdmYXN0X2lvX2ZhaWxfdG1vJyBz
eXNmcyBhdHRyaWJ1dGUuCgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2Ug
ICAgICAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUg
U29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkg
KEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUg
bWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
