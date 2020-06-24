Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593A8C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 16:49:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27CA62073E
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 16:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uqJUvewk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27CA62073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QobR92RWlcwP68JfRU1iItmYb3U+AlGosaz/ApfraSI=; b=uqJUvewkiCoC9lgRV7o/txGze
	bAYZV9OrxZNYlziL2uFzpKhnEHc5us0uWDNgRTtOE2xi4hefPzXfTxbJPXNN29YyWSVK+epkt2htC
	/vYBhB43cZGm8fqOmoUyeZMlLPYrPgcvvPcM/a3Ko4QHETWeAzMcC2JhHK/hAyFKm8uQIAKjj5KzW
	W+BFWE1R031YGpdOiSeBqMK9E6XLr4w5sAkF/cCYjPB7B2kdBXUOU9+WYaXlSJ7PrpLnzlsBVGbMZ
	/0DL92qmflyQpsATUf8LpeDYW1eH1oWxAry9bbYIgsPgWMuHEkK0B7CmHaMbBRyLlEwvq4LyqxngH
	UMl99P+zA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jo8a6-0001BR-3Q; Wed, 24 Jun 2020 16:49:02 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jo8a3-00019p-TP
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 16:49:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 79BA968B02; Wed, 24 Jun 2020 18:48:57 +0200 (CEST)
Date: Wed, 24 Jun 2020 18:48:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 1/3] nvme-tcp: have queue prod/cons send list become a
 llist
Message-ID: <20200624164857.GA24963@lst.de>
References: <20200619003024.153517-1-sagi@grimberg.me>
 <20200619003024.153517-2-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200619003024.153517-2-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
Cc: Keith Busch <kbusch@kernel.org>, Anil Vasudevan <anil.vasudevan@intel.com>,
 Mark Wunderlich <mark.wunderlich@intel.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gVGh1LCBKdW4gMTgsIDIwMjAgYXQgMDU6MzA6MjJQTSAtMDcwMCwgU2FnaSBHcmltYmVyZyB3
cm90ZToKPiArc3RhdGljIHZvaWQgbnZtZV90Y3BfcHJvY2Vzc19yZXFfbGlzdChzdHJ1Y3QgbnZt
ZV90Y3BfcXVldWUgKnF1ZXVlKQo+ICt7Cj4gKwlzdHJ1Y3QgbnZtZV90Y3BfcmVxdWVzdCAqcmVx
Owo+ICsJc3RydWN0IGxsaXN0X25vZGUgKm5vZGU7Cj4gKwo+ICsJbm9kZSA9IGxsaXN0X2RlbF9h
bGwoJnF1ZXVlLT5yZXFfbGlzdCk7Cj4gKwlpZiAoIW5vZGUpCj4gKwkJcmV0dXJuOwo+ICsKPiAr
CXdoaWxlIChub2RlKSB7Cj4gKwkJcmVxID0gbGxpc3RfZW50cnkobm9kZSwgc3RydWN0IG52bWVf
dGNwX3JlcXVlc3QsIGxlbnRyeSk7Cj4gKwkJbGlzdF9hZGQoJnJlcS0+ZW50cnksICZxdWV1ZS0+
c2VuZF9saXN0KTsKPiArCQlub2RlID0gbm9kZS0+bmV4dDsKPiArCX0KClRoZSBpZiBpcyBub3Qg
bmVlZGVkIGFzIHRoZSB3aGlsZSBjb3ZlcnMgdGhpcy4KCk90aGVyd2lzZSB0aGlzIGxvb2tzIGdv
b2QsIEknxLpsIGZpeCBpdCB1cCB3aGVuIGFwcGx5aW5nLgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgt
bnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtbnZtZQo=
