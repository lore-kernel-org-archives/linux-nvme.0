Return-Path: <SRS0=ZvdC=KH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825BAC433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 05:29:13 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37B4D6117A
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 05:29:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37B4D6117A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BsfFlUQ8sUKIqqg66k/07yxEBG0LqPX1EgOQkVxMPsU=; b=kLxwusXTk4gg+68z1NwG/VX9o
	2wVUEAiOn6QRrmlFk9b2jwfSxRMhWxmZSQe4YtrooSpnvkqmZ66gBvuWr2cv6ii+oGiYNLYEKd0N4
	6b5czeq9vd/jaecwNKbvfYBi6PGPxCVyF0Bgzi5dHM1TqpZYcMNKHM64vM74ABZfo1Z95pd4wDKUL
	VaNUXYYsv2LX8VyM/aDV5d+DMNX70gNXJtXQfjn3tHvjcU2khSsCRCpnLLFbGipNElQyXPwg0ZDR6
	dR9YH0NBM2KibXchpzYPCM3GIvP/vAnp240CbcDL4sT2LGHJLWEGcOAycSpHky73wW8jSCyRqe7k1
	LZvuRb8rw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lghPv-0024QN-Il; Wed, 12 May 2021 05:28:19 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lghPt-0024QF-Eb
 for linux-nvme@desiato.infradead.org; Wed, 12 May 2021 05:28:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=neHWCZq5Gri9Yjna3mjrlxZkzPF63AWHZW0Io28iooE=; b=f5anW9MNVSnF05xUAXKw/Gg2TW
 QjwCDDu2sY4dJ6GuiRUTzNctAR8IpsmwvD6+jiOogACz9mx7GSi+XBMplv6i+G1Ddrnss1IHnQ9Hj
 gz0pug9T/rdkL4dz46raeTF4pZeXlRzMAJHEjkyrjM3WA1gj+T5Kes+Q64Yj7ghDT52EHh2QFlLwV
 jESvpYE+Ta/tVX1cwmVnC9DSjQzxnsM49l4rG9P7oa1XQg38a7iZCht0J6aKZ9Y47RWWlXZjUcrK8
 0tlzTur8ps/KIkyr4IfyWYAH667Vu3fR5M0gsMDoVkyzSJXWk1Y7u2ARdE/ORhbTHRTZEOfT2IH+a
 O//yy4qg==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lghPq-00A7S5-TW
 for linux-nvme@lists.infradead.org; Wed, 12 May 2021 05:28:16 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 9A36EB0BE;
 Wed, 12 May 2021 05:28:13 +0000 (UTC)
Subject: Re: [PATCHv3] nvme: allow to re-attach namespaces after all paths are
 down
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20210511075919.139624-1-hare@suse.de>
 <20210511162611.GA17617@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <45ac2c89-7812-a2a2-07dc-46abd6fd555a@suse.de>
Date: Wed, 12 May 2021 07:28:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210511162611.GA17617@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210511_222815_120567_07FAF59F 
X-CRM114-Status: GOOD (  16.58  )
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

T24gNS8xMS8yMSA2OjI2IFBNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPj4gICAJfSBlbHNl
IHsKPj4gICAJCXJldCA9IC1FSU5WQUw7Cj4+ICsJCS8qCj4+ICsJCSAqIElmIG11bHRpcGF0aCBp
cyBlbmFibGVkIHdlIG1pZ2h0IGhpdCBhbiBucyBoZWFkIHdpdGggbm8KPj4gKwkJICogcGF0aHMs
IGJ1dCB0aGF0IGRvZXNuJ3QgaW5kaWNhdGUgaXQncyBhIHNoYXJlZCBuYW1lc3BhY2UuCj4+ICsJ
CSAqLwo+PiArCQlpZiAobnZtZV9uc19oZWFkX211bHRpcGF0aChoZWFkKSAmJgo+PiArCQkgICAg
bGlzdF9lbXB0eSgmaGVhZC0+bGlzdCkpCj4+ICsJCQlnb3RvIGNoZWNrX2lkczsKPj4gICAJCWlm
ICghaXNfc2hhcmVkIHx8ICFoZWFkLT5zaGFyZWQpIHsKPj4gICAJCQlkZXZfZXJyKGN0cmwtPmRl
dmljZSwKPj4gICAJCQkJIkR1cGxpY2F0ZSB1bnNoYXJlZCBuYW1lc3BhY2UgJWRcbiIsIG5zaWQp
Owo+PiAgIAkJCWdvdG8gb3V0X3B1dF9uc19oZWFkOwo+PiAgIAkJfQo+PiArY2hlY2tfaWRzOgo+
IAo+IEkgdGhpbmsgdGhpcyBzaG91bGQgc2ltcGx5IGJlOgo+IAo+IAkJaWYgKCFsaXN0X2VtcHR5
KCZoZWFkLT5saXN0KSAmJiAoIWlzX3NoYXJlZCB8fCAhaGVhZC0+c2hhcmVkKSkgewo+ICAgCQkJ
ZGV2X2VycihjdHJsLT5kZXZpY2UsCj4gICAgCQkJCSJEdXBsaWNhdGUgdW5zaGFyZWQgbmFtZXNw
YWNlICVkXG4iLCBuc2lkKTsKPiAgICAJCQlnb3RvIG91dF9wdXRfbnNfaGVhZDsKPiAgICAJCX0K
PiAKSSB3YXNuJ3Qgc3VyZSBpZiB0aGlzIGlzbid0IGp1c3QgZm9yIG11bHRpcGF0aGluZzsgb3Ro
ZXIgc2V0dXBzIGNhbid0IApxdWV1ZSBJL08sIHNvIHdlJ2xsIGJlIGhpdHRpbmcgdGhpcyBzY2Vu
YXJpbyBvbmx5IGluIHRoZSB1bmxpa2VseSBjYXNlIAp0aGF0IHRoZSBkZXZpY2UgaXMgcmVtb3Zl
ZCBfYW5kIHJlLWF0dGFjaGVkXyB3aXRob3V0IGFueSBJL08gcGVuZGluZy4KSGVuY2UgdGhlIGNo
ZWNrLgpCdXQgc3VyZSwgSSBjYW4gbW9kaWZ5IGl0LgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4g
SGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApo
YXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4
OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xy
bmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXgg
SW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1l
Cg==
