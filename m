Return-Path: <SRS0=iWk4=J7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33ED2C433B4
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 13:26:06 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A686C611AE
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 13:26:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A686C611AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2gf3ES3mI5mX900kpqIn4EAIMHh39n4ERyF2FsbmGsw=; b=KvfmFjkuQgKd/PWh/OTsTXZ4e
	OsYOGyfxIw/PHwdIop1oAt5Y4/CREvrw6OaQsMxcQfZ2+YVZxKzhIqdJY/YRTvX8iI9O25niZzWSA
	R6XyeChe4lHHQrE/jNxm5LNJWNd/WyNvry5YzMR1rgdK1RxLzEfzwZPv5bQY10RoV2rQ+EoMqJ836
	BdlVDILJeF4NLEricqN5P8LX4eBqHY1nW4LOJ1xnGaBNjuS+V3fky3MjTtRdJ+9yeUpxPLdAoeGKJ
	rrdMtum8ltsQIpFH9ZsUz64Zv4EvD4taOVtYyAcNVaJGH7s+TcbIrYvvg8r55e/5lineaYuZB2dI9
	JhDejRhWg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldv3d-00GGWV-6m; Tue, 04 May 2021 13:25:49 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldv3b-00GGWA-Eq
 for linux-nvme@desiato.infradead.org; Tue, 04 May 2021 13:25:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=ZJPNQ7F73kqaLMMMqDNm7KTsWzFZDkfl1RBBb3GNjzU=; b=vqEzj+Ouyh0XfPebX5pnTpcOkP
 ik3mk49C5AEdHsM8sG82YT+cVSRDmcvNU9O9pLt98VtGk6yUjvsuAaMEH/TUutlmZHjMIATLM3WMP
 6M1G9kx2kGh+KqgBTTLAdWExr1bV4UQpy8hPsQ/PY1eomZ5hrq9j56tqA9dUVbT4ZakIJjJVz8YtB
 Zyf4Yt23+W1G6kJbnACZ8N67l7B3mcqHfPYbhsnMb9lO/cU/PMzkfuXZ9CNj4Q+orSfzJv2C9wFMj
 5kX2JGm5hrepjrlrlES9zHuTMEeTJOj0+9s3s6PS00+cDYIiyn9v/LK9S4vEJm32I8qYCo/70cSo5
 2v2a9wFA==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldv3Y-003zrI-RA
 for linux-nvme@lists.infradead.org; Tue, 04 May 2021 13:25:46 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id C14C0AC38;
 Tue,  4 May 2021 13:25:42 +0000 (UTC)
Subject: Re: [PATCH 1/1] Add 'Transport Interface' (triface) option. This can
 be used to specify the IP interface to use for the connection. The
 driver
 uses that to set SO_BINDTODEVICE on the socket before connecting.
To: "Belanger, Martin" <Martin.Belanger@dell.com>,
 Martin Belanger <nitram_67@hotmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
References: <20210415192848.962891-1-nitram_67@hotmail.com>
 <BL0PR13MB42917AC33BFFC7DB2440D1149C4D9@BL0PR13MB4291.namprd13.prod.outlook.com>
 <11e71590-de9b-7eca-7d10-bbd3600d650c@suse.de>
 <SJ0PR19MB454486D08CA07BCE274966E6F25B9@SJ0PR19MB4544.namprd19.prod.outlook.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <cc8805b2-63eb-93ac-6505-66305a73cb3c@suse.de>
Date: Tue, 4 May 2021 15:25:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <SJ0PR19MB454486D08CA07BCE274966E6F25B9@SJ0PR19MB4544.namprd19.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210504_062545_055718_5609D3F3 
X-CRM114-Status: GOOD (  23.13  )
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

T24gNS8zLzIxIDY6NTkgUE0sIEJlbGFuZ2VyLCBNYXJ0aW4gd3JvdGU6Cj4gSGkgSGFubmVzLAo+
IAo+IEkganVzdCBub3RpY2VkIHRoZXJlIHdlcmUgaW4tbGluZSBjb21tZW50cy4gdG8gYW5zd2Vy
IHlvdSBxdWVzdGlvbnM6Cj4gCgpUaGlzIGlzIHRoZSByZWNvbW1lbmRlZCBzdHlsZSB3aGVuIHdv
cmtpbmcgd2l0aCBsaW51eCBwYXRjaGVzOyBwbGVhc2UgZG8gCm5vdCB0b3AtcG9zdC4KCj4gUTEp
IFdoeSBub3Qgc2ltcGx5ICdob3N0X2lmYWNlJyA/ICd0cmlmYWNlJyBpcyBhIGJpdCBhd2t3YXJk
Lgo+IEExKSBJIHVzZWQgVFJJRkFDRSB0byBrZWVwIGNvbnNpc3RlbmN5IHdpdGggYWxsIG90aGVy
IHRyYW5zcG9ydCBvcHRpb25zOiB0cmFkZHIsIHRyc3ZjaWQsIGhvc3RfdHJhZGRyLgo+IEkgd2ls
bCByZW5hbWUgdG8gaG9zdF9pZmFjZSBhdCB5b3VyIHN1Z2dlc3Rpb24uCj4gCj4gUTIpIElzIHRo
aXMgdmFsaWQgZm9yIGFsbCB0cmFuc3BvcnRzPyBJIGd1ZXNzIGl0IHdvdWxkIG9ubHkgd29yayBm
b3IgJ3RjcCcsIGFuZCBtYXliZSAncmRtYScgaWYgb25lCj4gd291bGQgYmUgcnVubmluZyBST0NF
LiBTaG91bGRuJ3Qgd2UgZXJyb3Igb3V0IG9uIG90aGVyIHRyYW5zcG9ydHMgbGlrZSAnZmMnIG9y
ICdsb29wJz8KPiBBMikgVGhpcyBpcyBvbmx5IGZvciBUQ1AsIGFuZCB3ZSBkbyBjaGVjayB0aGF0
IHRoaXMgb3B0aW9uIGlzIG9ubHkgYWxsb3dlZCBmb3IgVENQIGJ5IHNwZWNpZnlpbmcgaXQKPiBp
biB0aGUgImFsbG93ZWRfb3B0cyIgYXMgZm9sbG93cyAoc2VlIGZpbGUgdGNwLmMpOgo+IAo+IHN0
YXRpYyBzdHJ1Y3QgbnZtZl90cmFuc3BvcnRfb3BzIG52bWVfdGNwX3RyYW5zcG9ydCA9IHsKPiAg
ICAgICAgICAubmFtZSAgICAgICAgICAgPSAidGNwIiwKPiAgICAgICAgICAubW9kdWxlICAgICAg
ICAgPSBUSElTX01PRFVMRSwKPiAgICAgICAgICAucmVxdWlyZWRfb3B0cyAgPSBOVk1GX09QVF9U
UkFERFIsCj4gICAgICAgICAgLmFsbG93ZWRfb3B0cyAgID0gTlZNRl9PUFRfVFJTVkNJRCB8IE5W
TUZfT1BUX1JFQ09OTkVDVF9ERUxBWSB8Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgTlZN
Rl9PUFRfSE9TVF9UUkFERFIgfCBOVk1GX09QVF9DVFJMX0xPU1NfVE1PIHwKPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBOVk1GX09QVF9IRFJfRElHRVNUIHwgTlZNRl9PUFRfREFUQV9ESUdF
U1QgfAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5WTUZfT1BUX05SX1dSSVRFX1FVRVVF
UyB8IE5WTUZfT1BUX05SX1BPTExfUVVFVUVTIHwKPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBOVk1GX09QVF9UT1MgfCBOVk1GX09QVF9IT1NUX1RSSUZBQ0UsCj4gICAgICAgICAgLmNyZWF0
ZV9jdHJsICAgID0gbnZtZV90Y3BfY3JlYXRlX2N0cmwsCj4gfTsKPgpSaWdodCwgb2theS4KCj4g
UTMpIE5vcm1hbGx5IHRoZSBvcHRpb25zIGFyZSBqdXN0IHBhcnRzIG9mIHRoZSAnYWRkcmVzcycg
c3RyaW5nOyB3aHkgZGlkbid0Cj4geW91IHVzZSB0aGF0IGFwcHJvYWNoIGhlcmU/Cj4gQTMpIEkg
ZG9uJ3QgdW5kZXJzdGFuZCB3aGF0IHlvdSBtZWFuPwo+IApUaGUgJ2FkZHJlc3MnIHN0cmluZyBj
b250YWlucyBhbGwgdHJhbnNwb3J0IGFyZ3VtZW50cyAod2l0aG91dCB0aGUgCnRyYW5zcG9ydCB0
eXBlKSwgY29uY2F0ZW5hdGVkIGJ5IGEgJywnLgpTbyB0aGUgJ2hvc3RfaWZhY2UnIHZhbHVlIHNo
b3VsZCBqdXN0IGJlIGFkZGVkIHRvIHRoZSBhZGRyZXNzIHN0cmluZyAKaXRzZWxmLCBhbmQgbm90
IGFkZGVkIGFzIHNlcGFyYXRlIGFyZ3VtZW50IHRvIHRoZSBzeXNmcyBwcmludGYoKSBjYWxsLgoK
Q2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtl
cm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBN
YXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBH
ZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51
eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
