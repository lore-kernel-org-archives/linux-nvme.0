Return-Path: <SRS0=Qd/I=47=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED3AC0044D
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Mar 2020 14:46:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE1EF2076A
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Mar 2020 14:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Obg+eZKT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE1EF2076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BYvKaqRSlk7F0Pd7X3rW7HGzEwf291wPgNP70XpVUdg=; b=Obg+eZKTcHQIT/NevrAeNxUow
	w8NcCkYYD5u+8Na0twjqF/iPFRdidcb3hyn9xaYfDcDPoQBnk9zSL1U2fIZCGzBxvrbovdQasJ7/l
	lcAV5GurnubwfUoqrT17qv3YSJxno1V/C8nJMOk65B2Iave5k4aOwDpT1VnJ+WOSDxms4AoCkFfe6
	3vujNEFtZ7NVVPZrqb39fix4LtsG2W3d2O3HueGq5afFDvQmxshpy88aURhDiAAB0OeiiuGWMwISY
	e93mqApVV4COiL7Y+nNOEECcYMaAQPqi3c/LQmLZlYzQBtVXBYstN6HwlQ+JCEhUWYdAiKyF3lTMM
	STkxvgFSQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jD835-0006v2-Vv; Sat, 14 Mar 2020 14:45:59 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jD832-0006tg-Se
 for linux-nvme@lists.infradead.org; Sat, 14 Mar 2020 14:45:58 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 44722AD05;
 Sat, 14 Mar 2020 14:45:51 +0000 (UTC)
Subject: Re: [PATCH] nvme/fc: use real sqsize as argument when connecting
 queues
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
References: <20200313124808.39320-1-hare@suse.de>
 <7454340a-1cf1-d661-d1b8-e0181f755619@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <6ec99699-4fd2-e06d-6a70-cdfb1940112d@suse.de>
Date: Sat, 14 Mar 2020 15:45:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <7454340a-1cf1-d661-d1b8-e0181f755619@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200314_074557_073149_138D97D9 
X-CRM114-Status: GOOD (  17.87  )
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
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 James Smart <james.smart@broadcom.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMy8xMy8yMCA5OjI0IFBNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+IAo+IE9uIDMvMTMvMjAg
NTo0OCBBTSwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOgo+PiBXaGVuIGNyZWF0aW5nIHF1ZXVlcyB3
ZSBzaG91bGQgYmUgcGFzc2luZyBpbiB0aGUgcmVhbCBzcXNpemUgbnVtYmVyLAo+PiBhbmQgbm90
IGluY3JlYXNpbmcgaXQgYnkgb25lIGp1c3Qgc28gdGhhdCB0aGUgZnVuY3Rpb24gaGFzIHRvCj4+
IHN1YnN0cmFjdCBpdCBhZ2Fpbi4KPiAKPiBLaW5kYSBtYWtlcyBtb3JlIHNlbnNlIHRvIHBhc3Mg
YXJvdW5kIGFjdHVhbCBxdWV1ZSBzaXplIGFuZAo+IG5vdCB0aGUgemVyby1iYXNlZCB2ZXJzaW9u
IG9mIGl0LCBpc24ndCBpdD8KPiAKT2gsIGl0IHdvdWxkLgpCdXQgdGhlbiBJIHdvdWxkIGhhdmUg
ZXhwZWN0ZWQgY3RybC0+c3FzaXplIGNhcnJ5aW5nIHRoZSAncmVhbCcgcXVldWUgCnNpemUuIFdo
aWNoIHdlIGN1cnJlbnRseSBkb24ndCAoVGhhdCB3aHkgSSd2ZSBzZW50IHRoZSBvdGhlciBwYXRj
aCkuCgpCdXQgY2FsbGluZyBhIGZ1bmN0aW9uIHdpdGggKGFyZyArIDEpLCBqdXN0IHNvIHRoYXQg
dGhlIGZ1bmN0aW9uIGJvZHkgCmRvZXMgYW4gJ2FyZyAtIDEnIGludGVybmFsbHkgaXMgdG90YWxs
eSBwb2ludGxlc3MuCgpXaGF0IEknbSBhaW1pbmcgYXQgd2l0aCB0aGVzZSBwYXRjaGVzIGlzIHRv
IGtlZXAgY3RybC0+c3FzaXplIGFzIHRoZSAKcmVhbCAoMS1iYXNlZCkgIHNpemUsIHRvIGJlIGNv
bnZlcnRlZCB0byB0aGUgd2lyZSBmb3JtYXQgKDAtYmFzZWQpIHdoZW4gCmFjdHVhbGx5IHB1dCBv
biB0aGUgd2lyZS4KQW5kIGFsbG9jYXRpbmcgdGhlIHRhZ3NldCB3aXRoIChjdHJsLXNxc2l6ZSAt
IDEpIHRvIGNvdmVyIHRoZSBxdWV1ZSBmdWxsIApkZXRlY3RlZCBhcyBtYW5kYXRlZCBieSB0aGUg
c3BlYy4KCkknbGwgYmUgcmV2aWV3aW5nIHRoZSBwYXRjaGVzIHdpdGggdGhhdCBpbiBtaW5kIGFu
ZCB3aWxsIGJlIHJlc2VuZGluZyBhIApuZXcgdmVyc2lvbi4KCkNoZWVycywKCkhhbm5lcwotLSAK
RHIuIEhhbm5lcyBSZWluZWNrZSAgICAgICAgICAgIFRlYW1sZWFkIFN0b3JhZ2UgJiBOZXR3b3Jr
aW5nCmhhcmVAc3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArNDkgOTExIDc0
MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQw
OSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJlcjog
RmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsaW51eC1udm1lIG1haWxpbmcgbGlzdApsaW51eC1udm1lQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1udm1lCg==
