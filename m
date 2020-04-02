Return-Path: <SRS0=DaKL=5S=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E46EC43331
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2020 17:22:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7C7420757
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2020 17:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ANz8l72t";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZgTVQiWi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C7420757
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=r/kf4MWx5H29rfBaM1me509A9t7okiE2t0cymN6KpQQ=; b=ANz8l72taKSa4NJBrXBur/OEM
	KqKEYidKIvX8YVrgioNN6pBeomYNfNlq03LYfCw1HYEIR3rn2zKBzDcz7aFcpjOM8vtroRyit+T0X
	7eBh+dOBo6ZKq6A2TL8UdlqMtm+EH7AHQa++fGNlAXva5s1wMdiGXFQN4+xAUAH1DjhnI5/6xyseG
	J9J4aWwm2T8KyBKE6z4jTu1NJraAZlW6/Rc/0lo9ykkrZT+15y6oLUYjIFN6yS8xQGtwq86u7D88m
	v2Eiq1fWllGpPPI0HOJy3ceGCKqtmZdIYIofSpwo+xJLnY/evsgvwarlQLaAEzMynKWzDvc3oOcg5
	uRmrF1+2Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jK3Y2-0008W7-HA; Thu, 02 Apr 2020 17:22:34 +0000
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jK3Y0-0008Ve-6K
 for linux-nvme@lists.infradead.org; Thu, 02 Apr 2020 17:22:33 +0000
Received: by mail-wr1-x434.google.com with SMTP id h9so5184663wrc.8
 for <linux-nvme@lists.infradead.org>; Thu, 02 Apr 2020 10:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=7E5BJPv3CYhT6wT/k0eZxgdAWLSmcqSuMuIJTg/s6ak=;
 b=ZgTVQiWiVsEncpRnvMgcAUgPJCWz9lGxHHFUEH5zjfpb2Ob/odpNtiwqyCmaLupEys
 w3CwX5zQEpalKZi9T/7DkMPB9YdkQxSISjrnsr4mHzWomat/7VwE6FU1B0h6qy1vvtph
 Kbax+Ehh3xLo1l/ytQ4sROL/jocpANsOkIiYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=7E5BJPv3CYhT6wT/k0eZxgdAWLSmcqSuMuIJTg/s6ak=;
 b=bnFYS77dVDIS7LE5jSfuhsokg8436hI1zV/tfA5sqCsq75XG9I5rsRHBElQL1vRMHF
 /NJs2WqNNB7DgxnIftT3EgykG6r6Ktv/44tv+oCGFfMBybvk+bxGY9bEqUryMw4iORQQ
 ESea10coUNopMIGrhlXfuowxmDXzuU6ZbWZfYQeaVHaF8OJkJHeQTARCtIPIwZupT5hD
 vxVQN4AhhyTxnurhShsMHeQmGinhjg5HpRFau0kecYt0fu0vgQRf9lf2Ipeze4LG2QHl
 MV/NyjL592SIUZoPtYYNcnMA/74MPi017hjBMHF0BLLQL8dvKdwKM4EbSNRVSfIb6zEw
 NmlA==
X-Gm-Message-State: AGi0PubBe9QW944L9KY6W9cz3qtdgM8jUSR2O9D95LP9PzUTbyxwfl9S
 oYe0pD+U4NnMmRB6mOB3qlbzECQKOHH0r4NfOAqd+wRMQ+4IxPwsXUYmqs1WWwp2P+b1C/ZSCzI
 qheDyf3jUl/eRQY0MTwHWxrYDSwyeg09tK1dpwG2nt9G/acwGjz6+ptVyoWk0wI1piLmsOMi8y+
 I4XMIKlw==
X-Google-Smtp-Source: APiQypKk+yONKXuDXw2NOXUTvTGLonw+Jhg1tgGR1RMp3G3xwxg7LcQ1P688j3UQDF+bynndFZ8dEw==
X-Received: by 2002:a5d:4a84:: with SMTP id o4mr3664074wrq.57.1585848148055;
 Thu, 02 Apr 2020 10:22:28 -0700 (PDT)
Received: from [10.230.185.141] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id s15sm8113558wrt.16.2020.04.02.10.22.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Apr 2020 10:22:27 -0700 (PDT)
Subject: Re: nvme deadlock with ANA
To: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
 Christoph Hellwig <hch@lst.de>
References: <5e38c566-3f26-288d-1004-161d1084b468@grimberg.me>
 <20200402151854.GA11784@lst.de>
 <7fce512e-deb6-2357-d627-d1a698a8269b@grimberg.me>
 <4ec0c3ba-398d-0922-87f4-4b0a99a79abb@suse.de>
From: James Smart <james.smart@broadcom.com>
Message-ID: <78da8d72-c8b5-7afd-659c-5bc17d6b101b@broadcom.com>
Date: Thu, 2 Apr 2020 10:22:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <4ec0c3ba-398d-0922-87f4-4b0a99a79abb@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200402_102232_234138_AE9E8EFD 
X-CRM114-Status: GOOD (  13.61  )
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
Cc: Keith Busch <kbusch@kernel.org>, Anton Eidelman <anton@lightbitslabs.com>,
 linux-nvme <linux-nvme@lists.infradead.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gNC8yLzIwMjAgODozMCBBTSwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOgo+IE9uIDQvMi8yMCA1
OjI0IFBNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+Pgo+Pj4+IEkgd2FudCB0byBjb25zdWx0IHdp
dGggeW91IGd1eXMgb24gYSBkZWFkbG9jayBjb25kaXRpb24gSSdtIGFibGUgdG8KPj4+PiBoaXQg
d2l0aCBhIHRlc3QgdGhhdCBpbmNvcnBvcmF0ZSBjb250cm9sbGVyIHJlY29ubmVjdCwgYW5hIHVw
ZGF0ZXMKPj4+PiBhbmQgbGl2ZSBJL08gd2l0aCB0aW1lb3V0cy4KPj4+Pgo+Pj4+IFRoaXMgaXMg
dHJ1ZSBmb3IgTlZNZS9UQ1AsIGJ1dCBjYW4gYWxzbyBoYXBwZW4gaW4gcmRtYSBvciBwY2kgCj4+
Pj4gZHJpdmVycyBhcwo+Pj4+IHdlbGwuCj4+Pj4KPj4+PiBUaGUgZGVhZGxvY2sgY29tYmluZXMg
NCBmbG93cyBpbiBwYXJhbGxlbDoKPj4+PiAtIG5zIHNjYW5uaW5nICh0cmlnZ2VyZWQgZnJvbSBy
ZWNvbm5lY3QpCj4+Pj4gLSByZXF1ZXN0IHRpbWVvdXQKPj4+PiAtIEFOQSB1cGRhdGUgKHRyaWdn
ZXJlZCBmcm9tIHJlY29ubmVjdCkKPj4+PiAtIEZTIEkvTyBjb21pbmcgaW50byB0aGUgbXBhdGgg
ZGV2aWNlCj4+Pj4KPj4+PiAoMSkgbnMgc2Nhbm5pbmcgdHJpZ2dlcnMgZGlzayByZXZhbGlkYXRp
b24gLT4gdXBkYXRlIGRpc2sgaW5mbyAtPgo+Pj4+IMKgwqDCoMKgIGZyZWV6ZSBxdWV1ZSAtPiBi
dXQgYmxvY2tlZCwgd2h5Pwo+Pj4KPj4+IFdoYXQgZG9lcyAtPiBidXQgYmxvY2tlZCBtZWFuPwo+
Pgo+PiBJdCBpcyBibG9ja2VkIGFuZCBjYW5ub3QgY29tcGxldGUsIGJlY2F1c2Ugb2YgKDIpCj4+
Cj4+Pj4gKDIpIHRpbWVvdXQgaGFuZGxlciByZWZlcmVuY2UgdGhlIGdfdXNhZ2VfY291bnRlciAt
ID4gYnV0IGJsb2NrcyBpbgo+Pj4+IMKgwqDCoMKgIHRoZSB0aW1lb3V0IGhhbmRsZXIsIHdoeT8K
Pj4+Cj4+PiBUaGUgdGltZW91dCBoYW5kbGVyIG9idmlvdXNseSBuZWVkcyB0byBrZWVwIHRoZSBx
dWV1ZSBhbGl2ZSB3aGlsZQo+Pj4gcnVubmluZy7CoCBXZSBjb3VsZCB0aGluayBvZiBkb2luZyBh
IHRyeV9nZXQsIHRob3VnaD8KPj4KPj4gSXQgaXMga2VlcGluZyB0aGUgcXVldWUgYWxpdmUsIHRo
YXQgaXMgbm90IHRoZSBpc3N1ZS4gaXQgaXMgYmxvY2tlZCBpbgo+PiB0aGUgZHJpdmVyIC50aW1l
b3V0KCkgaGFuZGxlciAoaS5lLiBudm1lX3RjcF90aW1lb3V0KS4KPj4KPj4gVGhlIHJlYXNvbiB0
aGF0IGl0IGJsb2NrZWQgYW5kIGNhbm5vdCBtYWtlIGZvcndhcmQgcHJvZ3Jlc3MgaXMgYmVjYXVz
ZQo+PiB0aGUgZHJpdmVyIHRpbWVvdXQgaGFuZGxlciB3aWxsIGNhbGwgbnZtZV9zdG9wX3F1ZXVl
cygpLCB3aGljaCBpcwo+PiBibG9ja2VkIGFzIHRoaXMgdGFrZXMgbmFtZXNwYWNlc19yd3NlbS4u
Lgo+Pgo+PiBUaGVyZSBpcyBhIGNoYWluIG9mIGRlcGVuZGVuY3kgdGhhdCBpcyBkZWFkbG9ja2lu
ZyB3aXRoIGNpcmN1bGFyCj4+IGRlcGVuZGVuY3kuCj4KPiBDYW4ndCB5b3Ugc2ltcGx5IGNhbGwg
J252bWVfcmVzZXRfY3RybCgpJyA/Cj4gU2VlbXMgdG8gd29yayByZWFzb25hYmx5IHdlbGwgb24g
dGhlIGZjIHNpZGUsIHNvIEkgd29uZGVyIHdoYXQncyAKPiBkaWZmZXJlbnQgZm9yIHRjcCAuLi4K
Cml0J3Mgbm8gZGlmZmVyZW50IHdpdGggRkMuIFdlIGRvIGxpa2VseSBzdGF5IGluIHJlc2V0dGlu
ZyBzdGF0ZSBsb25nZXIgCmFzIHdlIGhhdmUgdG8gd2FpdCBmb3IgYWNrbm93bGVkZ2VtZW50IG9m
IGlvIGFib3J0LiBCdXQgdGhlIGZsb3dzIGluIApnZW5lcmFsIGFyZW4ndCBkaWZmZXJlbnQuCgot
LSBqYW1lcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtbnZtZSBtYWlsaW5nIGxpc3QKbGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
