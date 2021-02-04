Return-Path: <SRS0=YrQE=HG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9146DC433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 07:13:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3203460295
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 07:13:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3203460295
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+ywfWy/erNOibBKGbQcnIGuS/gf7pb0JgFEtnV2NR4k=; b=iqbcF8OPPDWSzqfdUsNU4s/Fq
	9oHWE8f/5kdHpT+trfDSxSOlzygwGvRZaEeM+1ynZFUvYcZpPTimPvB8U2gCvZnlLNkUjJTOV1bTc
	oqYt2h+Dgl6J7MZmNKiAkj9NQp5tD2AI/256wXSQS9GkLIUyoLbmweCpQwjk+V9BIkkQdqA5D1dNh
	nz+uLYaIDTfCMIB9V/BRJBdsSFaB+0pfFxuN9HNKpXrpGVyNMLHVt+rh+lWAD5zthwUaOoPxBg5+r
	LB4TGQJ+YPmzLHBXFQap1wyPnrcAFc2GRDUo08NRdPrNRqIMYI5JDAv+4lZUGsH46fu4ve4hLgOJy
	AFQd3NSZQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7YpF-0005JY-1s; Thu, 04 Feb 2021 07:13:13 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7YpC-0005Iv-Cp
 for linux-nvme@lists.infradead.org; Thu, 04 Feb 2021 07:13:11 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 308A9ABD5;
 Thu,  4 Feb 2021 07:13:09 +0000 (UTC)
Subject: Re: [PATCH 11/35] monitor: add option -A / --autoconnect
To: mwilck@suse.com, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20210126203324.23610-1-mwilck@suse.com>
 <20210126203324.23610-12-mwilck@suse.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <819efd43-0216-7836-9367-ca5bca131efa@suse.de>
Date: Thu, 4 Feb 2021 08:13:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210126203324.23610-12-mwilck@suse.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210204_021310_555819_8D16DA9E 
X-CRM114-Status: GOOD (  23.12  )
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
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMS8yNi8yMSA5OjMzIFBNLCBtd2lsY2tAc3VzZS5jb20gd3JvdGU6Cj4gRnJvbTogTWFydGlu
IFdpbGNrIDxtd2lsY2tAc3VzZS5jb20+Cj4gCj4gV2l0aCB0aGlzIG9wdGlvbiwgdGhlIG1vbml0
b3Igd2lsbCB0cnkgdG8gY29ubmVjdCB0byBuZXdseSBkaXNjb3ZlcmVkCj4gY29udHJvbGxlcnMu
Cj4gCj4gU2lnbmVkLW9mZi1ieTogTWFydGluIFdpbGNrIDxtd2lsY2tAc3VzZS5jb20+Cj4gLS0t
Cj4gICBtb25pdG9yLmMgfCA1ICsrKysrCj4gICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25z
KCspCj4gCj4gZGlmZiAtLWdpdCBhL21vbml0b3IuYyBiL21vbml0b3IuYwo+IGluZGV4IGE3YWZh
MWMuLmVjZjNiZTIgMTAwNjQ0Cj4gLS0tIGEvbW9uaXRvci5jCj4gKysrIGIvbW9uaXRvci5jCj4g
QEAgLTMxLDYgKzMxLDEwIEBACj4gICAjZGVmaW5lIExPR19GVU5DTkFNRSAxCj4gICAjaW5jbHVk
ZSAibG9nLmgiCj4gICAKPiArc3RhdGljIHN0cnVjdCBtb25pdG9yX2NvbmZpZyB7Cj4gKwlib29s
IGF1dG9jb25uZWN0Owo+ICt9IG1vbl9jZmc7Cj4gKwo+ICAgc3RhdGljIHN0cnVjdCB1ZGV2ICp1
ZGV2Owo+ICAgCj4gICBzdGF0aWMgdm9pZCBjbG9zZV9wdHIoaW50ICpwKQo+IEBAIC0xNzcsNiAr
MTgxLDcgQEAgc3RhdGljIGludCBtb25pdG9yX3BhcnNlX29wdHMoY29uc3QgY2hhciAqZGVzYywg
aW50IGFyZ2MsIGNoYXIgKiphcmd2KQo+ICAgCWJvb2wgZGVidWcgPSBmYWxzZTsKPiAgIAlpbnQg
cmV0Owo+ICAgCU9QVF9BUkdTKG9wdHMpID0gewo+ICsJCU9QVF9GTEFHKCJhdXRvY29ubmVjdCIs
ICAgICdBJywgJm1vbl9jZmcuYXV0b2Nvbm5lY3QsICJhdXRvbWF0aWNhbGx5IGNvbm5lY3QgbmV3
bHkgZGlzY292ZXJlZCBjb250cm9sbGVycyIpLAo+ICAgCQlPUFRfRkxBRygic2lsZW50IiwgICAg
ICAgICAnUycsICZxdWlldCwgICAgICAgICAgICAgICAibG9nIGxldmVsOiBzaWxlbnQiKSwKPiAg
IAkJT1BUX0ZMQUcoInZlcmJvc2UiLCAgICAgICAgJ3YnLCAmdmVyYm9zZSwgICAgICAgICAgICAg
ImxvZyBsZXZlbDogdmVyYm9zZSIpLAo+ICAgCQlPUFRfRkxBRygiZGVidWciLCAgICAgICAgICAn
RCcsICZkZWJ1ZywgICAgICAgICAgICAgICAibG9nIGxldmVsOiBkZWJ1ZyIpLAo+IApUaGlzIHBh
dGNoIGlzIHNsaWdodGx5IGNvbmZ1c2luZy4KCkl0IGp1c3QgYWRkcyBhbiBvcHRpb24sIGJ1dCB0
aGVyZSBpcyBub3QgY29kZSBldmFsdWF0aW5nIHRoaXMgb3B0aW9uLiBTbyAKd2hlcmUgZG9lcyBp
dCBob29rIGluPwoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAg
ICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0
aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBO
w7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxp
bmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
