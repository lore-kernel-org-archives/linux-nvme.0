Return-Path: <SRS0=LUST=DN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B85FC4363D
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Oct 2020 13:30:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A580C207EA
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Oct 2020 13:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Bt1arcPj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A580C207EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KeC1V4mdz698wi6LA5z515w2oUMmdF05B1+PRB+/1x0=; b=Bt1arcPjDI0nnDm4I7KkkXvsC
	EjMhGhaL6k0GB0xjmJiec3J7CaoF+gGILt4HwK0fUY7gHnWMXtOmF3b2mBCNxLO6R9xJcVNMbSrWd
	p9ORCqYfBQs5U5T7mcTae7FuQHQA25EW3ir5ZUc6Hi3xeQSTsY9sxYd0u/9WKIm14BKzbygK7o7d4
	N5SkvB42j7mU/mBMqN2fZAFiKzqBg7i69cUa7aQK7Fr91PIQ7u+J5FNqzDz/yDtLy4J/YuYxt58Km
	Fa9CEZ3+T/Ko4IWfbYrknfSdBj3EYHQMYosPrWjqK28KbtzqB4EkP7D6tZGYxg5EFLVVk8vowu4r1
	b1obCk2QA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kPn2r-0000ZR-7C; Tue, 06 Oct 2020 13:30:21 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPn2p-0000Z1-2K
 for linux-nvme@lists.infradead.org; Tue, 06 Oct 2020 13:30:20 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id D4331AB54;
 Tue,  6 Oct 2020 13:30:15 +0000 (UTC)
Subject: Re: [PATCH 2/2] nvme: add 'queue_if_no_path' semantics
To: Christoph Hellwig <hch@lst.de>
References: <20201005124500.6015-1-hare@suse.de>
 <20201005124500.6015-3-hare@suse.de> <20201005125201.GB1125@lst.de>
 <8d7d4803-5808-0839-ee4f-e36a12756497@suse.de>
 <20201006075153.GA10041@lst.de>
 <b720433b-5849-2e7f-d359-53247976bad5@suse.de>
 <20201006082727.GC10243@lst.de>
 <a848297e-3243-6366-86ee-0800d51198e1@suse.de>
 <20201006083926.GA13568@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <00e75643-d422-ca12-1648-02ca89044182@suse.de>
Date: Tue, 6 Oct 2020 15:30:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201006083926.GA13568@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201006_093019_338166_02F9651E 
X-CRM114-Status: GOOD (  26.10  )
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
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTAvNi8yMCAxMDozOSBBTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gT24gVHVlLCBP
Y3QgMDYsIDIwMjAgYXQgMTA6Mjk6NDlBTSArMDIwMCwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOgo+
Pj4gQWxsIG11bHRpcGF0aCBkZXZpY2VzIHNob3VsZCBiZWhhdmUgdGhlIHNhbWUuICBObyBzcGVj
aWFsIGNhc2luZyBmb3IKPj4+IFBDSWUsIHBsZWFzZS4KPj4+Cj4+IEV2ZW4gaWYgdGhlIGRlZmF1
bHQgYmVoYXZpb3VyIGJyZWFrcyBQQ0kgaG90cGx1Zz8KPiAKPiBXaHkgd291bGQgaXQgImJyZWFr
IiBQQ0kgaG90cGx1Zz8KPiAKV2hlbiBydW5uaW5nIHVuZGVyIE1EIFJBSUQ6CkJlZm9yZSBob3Rw
bHVnOgojIG52bWUgbGlzdApOb2RlICAgICAgICAgICAgIFNOICAgICAgICAgICAgICAgICAgIE1v
ZGVsIAogICAgICAgTmFtZXNwYWNlIFVzYWdlICAgICAgICAgICAgICAgICAgICAgIEZvcm1hdCAg
ICAgICAgICAgRlcgUmV2Ci0tLS0tLS0tLS0tLS0tLS0gLS0tLS0tLS0tLS0tLS0tLS0tLS0gCi0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0gLS0tLS0tLS0tIAotLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLSAtLS0tLS0tLS0tLS0tLS0tIC0tLS0tLS0tCi9kZXYvbnZtZTBu
MSAgICAgU0xFU05WTUUxICAgICAgICAgICAgUUVNVSBOVk1lIEN0cmwgCiAgICAgICAxICAgICAg
ICAgIDE3LjE4ICBHQiAvICAxNy4xOCAgR0IgICAgNTEyICAgQiArICAwIEIgICAxLjAKL2Rldi9u
dm1lMW4xICAgICBTTEVTTlZNRTIgICAgICAgICAgICBRRU1VIE5WTWUgQ3RybCAKICAgICAgIDEg
ICAgICAgICAgIDQuMjkgIEdCIC8gICA0LjI5ICBHQiAgICA1MTIgICBCICsgIDAgQiAgIDEuMAov
ZGV2L252bWUybjEgICAgIFNMRVNOVk1FMyAgICAgICAgICAgIFFFTVUgTlZNZSBDdHJsIAogICAg
ICAgMSAgICAgICAgICAgNC4yOSAgR0IgLyAgIDQuMjkgIEdCICAgIDUxMiAgIEIgKyAgMCBCICAg
MS4wCkFmdGVyIGhvdHBsdWc6CgojIG52bWUgbGlzdApOb2RlICAgICAgICAgICAgIFNOICAgICAg
ICAgICAgICAgICAgIE1vZGVsIAogICAgICAgTmFtZXNwYWNlIFVzYWdlICAgICAgICAgICAgICAg
ICAgICAgIEZvcm1hdCAgICAgICAgICAgRlcgUmV2Ci0tLS0tLS0tLS0tLS0tLS0gLS0tLS0tLS0t
LS0tLS0tLS0tLS0gCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0gLS0t
LS0tLS0tIAotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSAtLS0tLS0tLS0tLS0tLS0tIC0tLS0t
LS0tCi9kZXYvbnZtZTBuMSAgICAgU0xFU05WTUUxICAgICAgICAgICAgUUVNVSBOVk1lIEN0cmwg
CiAgICAgICAxICAgICAgICAgIDE3LjE4ICBHQiAvICAxNy4xOCAgR0IgICAgNTEyICAgQiArICAw
IEIgICAxLjAKL2Rldi9udm1lMW4xICAgICBTTEVTTlZNRTIgICAgICAgICAgICBRRU1VIE5WTWUg
Q3RybCAKICAgICAgIC0xICAgICAgICAgIDAuMDAgICBCIC8gICAwLjAwICAgQiAgICAgIDEgICBC
ICsgIDAgQiAgIDEuMAovZGV2L252bWUxbjIgICAgIFNMRVNOVk1FMiAgICAgICAgICAgIFFFTVUg
TlZNZSBDdHJsIAogICAgICAgMSAgICAgICAgICAgNC4yOSAgR0IgLyAgIDQuMjkgIEdCICAgIDUx
MiAgIEIgKyAgMCBCICAgMS4wCi9kZXYvbnZtZTJuMSAgICAgU0xFU05WTUUzICAgICAgICAgICAg
UUVNVSBOVk1lIEN0cmwgCiAgICAgICAxICAgICAgICAgICA0LjI5ICBHQiAvICAgNC4yOSAgR0Ig
ICAgNTEyICAgQiArICAwIEIgICAxLjAKCkFuZCBNRCBoYXNuJ3QgYmVlbiBub3RpZmllZCB0aGF0
IHRoZSBkZXZpY2UgaXMgZ29uZToKIyBjYXQgL3Byb2MvbWRzdGF0ClBlcnNvbmFsaXRpZXMgOiBb
cmFpZDEwXQptZDAgOiBhY3RpdmUgcmFpZDEwIG52bWUybjFbMV0gbnZtZTFuMVswXQogICAgICAg
NDE4OTE4NCBibG9ja3Mgc3VwZXIgMS4yIDIgbmVhci1jb3BpZXMgWzIvMl0gW1VVXQogICAgICAg
Yml0bWFwOiAwLzEgcGFnZXMgWzBLQl0sIDY1NTM2S0IgY2h1bmsKCnVudXNlZCBkZXZpY2VzOiA8
bm9uZT4KCk9uY2UgSSBkbyBzb21lIEkvTyB0byBpdCBNRCByZWNvZ25pemVkIGEgZmF1bHR5IGRl
dmljZToKCiMgY2F0IC9wcm9jL21kc3RhdApQZXJzb25hbGl0aWVzIDogW3JhaWQxMF0KbWQwIDog
YWN0aXZlIHJhaWQxMCBudm1lMm4xWzFdIG52bWUxbjFbMF0oRikKICAgICAgIDQxODkxODQgYmxv
Y2tzIHN1cGVyIDEuMiAyIG5lYXItY29waWVzIFsyLzFdIFtfVV0KICAgICAgIGJpdG1hcDogMC8x
IHBhZ2VzIFswS0JdLCA2NTUzNktCIGNodW5rCgp1bnVzZWQgZGV2aWNlczogPG5vbmU+CgpidXQg
dGhlIHJlLWFkZGVkIGRldmljZSBpc24ndCBhZGRlZCB0byB0aGUgTUQgUkFJRC4KSW4gZmFjdCwg
aXQgaGFzIGJlZW4gYXNzaWduZWQgYSBfZGlmZmVyZW50XyBuYW1lc3BhY2UgSUQ6CgpbICA5MDQu
Mjk5MDY1XSBwY2llcG9ydCAwMDAwOjAwOjA4LjA6IHBjaWVocDogU2xvdCgwLTEpOiBDYXJkIHBy
ZXNlbnQKWyAgOTA0LjI5OTA2N10gcGNpZXBvcnQgMDAwMDowMDowOC4wOiBwY2llaHA6IFNsb3Qo
MC0xKTogTGluayBVcApbICA5MDQuNDM1MzE0XSBwY2kgMDAwMDowMjowMC4wOiBbODA4Njo1ODQ1
XSB0eXBlIDAwIGNsYXNzIDB4MDEwODAyClsgIDkwNC40MzU1MjNdIHBjaSAwMDAwOjAyOjAwLjA6
IHJlZyAweDEwOiBbbWVtIDB4MDAwMDAwMDAtMHgwMDAwMWZmZiA2NGJpdF0KWyAgOTA0LjQzNTY3
Nl0gcGNpIDAwMDA6MDI6MDAuMDogcmVnIDB4MjA6IFttZW0gMHgwMDAwMDAwMC0weDAwMDAwZmZm
XQpbICA5MDQuNDM2OTgyXSBwY2kgMDAwMDowMjowMC4wOiBCQVIgMDogYXNzaWduZWQgW21lbSAK
MHhjMTIwMDAwMC0weGMxMjAxZmZmIDY0Yml0XQpbICA5MDQuNDM3MDg2XSBwY2kgMDAwMDowMjow
MC4wOiBCQVIgNDogYXNzaWduZWQgW21lbSAweGMxMjAyMDAwLTB4YzEyMDJmZmZdClsgIDkwNC40
MzcxMThdIHBjaWVwb3J0IDAwMDA6MDA6MDguMDogUENJIGJyaWRnZSB0byBbYnVzIDAyXQpbICA5
MDQuNDM3MTM3XSBwY2llcG9ydCAwMDAwOjAwOjA4LjA6ICAgYnJpZGdlIHdpbmRvdyBbaW8gIDB4
NzAwMC0weDdmZmZdClsgIDkwNC40MzkwMjRdIHBjaWVwb3J0IDAwMDA6MDA6MDguMDogICBicmlk
Z2Ugd2luZG93IFttZW0gCjB4YzEyMDAwMDAtMHhjMTNmZmZmZl0KWyAgOTA0LjQ0MDIyOV0gcGNp
ZXBvcnQgMDAwMDowMDowOC4wOiAgIGJyaWRnZSB3aW5kb3cgW21lbSAKMHg4MDIwMDAwMDAtMHg4
MDNmZmZmZmYgNjRiaXQgcHJlZl0KWyAgOTA0LjQ0NzE1MF0gbnZtZSBudm1lMzogcGNpIGZ1bmN0
aW9uIDAwMDA6MDI6MDAuMApbICA5MDQuNDQ3NDg3XSBudm1lIDAwMDA6MDI6MDAuMDogZW5hYmxp
bmcgZGV2aWNlICgwMDAwIC0+IDAwMDIpClsgIDkwNC40NTg4ODBdIG52bWUgbnZtZTM6IDEvMC8w
IGRlZmF1bHQvcmVhZC9wb2xsIHF1ZXVlcwpbICA5MDQuNDYxMjk2XSBudm1lMW4yOiBkZXRlY3Rl
ZCBjYXBhY2l0eSBjaGFuZ2UgZnJvbSAwIHRvIDQyOTQ5NjcyOTYKCmFuZCB0aGUgJ29sZCcsIHBy
ZS1ob3RwbHVnIGRldmljZSBzdGlsbCBsaW5nZXJzIG9uIGluIHRoZSAnbnZtZSBsaXN0JyAKb3V0
cHV0LgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAg
ICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBH
bWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJl
cmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlz
dApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
