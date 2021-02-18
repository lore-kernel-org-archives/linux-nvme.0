Return-Path: <SRS0=yJEp=HU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCB9C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Feb 2021 16:30:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C2EE61493
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Feb 2021 16:30:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C2EE61493
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KYfjUFDbQ8vRlQ/htZAn8bfBpCCFHXMP51m++RXx6Vc=; b=HsA9sWDxolcX4dM/mS2x0SRjf
	MreS35/MHjoTkCup+a569F0fA8nNq3k2qaG+H5QQuMVDh3Op9zYQ/cfyvMIa/m/R2PSYMMQs8Vy1I
	pbwXSCTUZrGoTBApFyLK6jwdw3EC+C2jych67fTcbV/iRCSYCgi59b8R7AR0bHXOz6iB0flF1gWuk
	4+MDug9KlWpBccTEYaaJgx+ly4z2I77NskSLCAXvYVUr+dC6cJHRCtrTaAkiTpYO9VWKNdmBcbpOZ
	usyR/z9Z/0eEH7WceW1ZWE+fvTE/4hX0i+sLIrbKWYm7aE6QibtfQ4vbX7vUopK5XtvbBpDfew7QT
	aM6y3PCIQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lCmBJ-0001Ju-A9; Thu, 18 Feb 2021 16:29:33 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lCmBG-0001JV-Dx
 for linux-nvme@lists.infradead.org; Thu, 18 Feb 2021 16:29:31 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id B6C8AACF6;
 Thu, 18 Feb 2021 16:29:27 +0000 (UTC)
Subject: Re: [PATCH] fabrics: permit kato int argument for discovery
 controllers
To: Martin George <martinus.gpy@gmail.com>, linux-nvme@lists.infradead.org
References: <20210218094642.5616-1-marting@netapp.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <9a37a05a-4af0-59d2-5b6b-874b71940de7@suse.de>
Date: Thu, 18 Feb 2021 17:29:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210218094642.5616-1-marting@netapp.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210218_112930_593198_692515C3 
X-CRM114-Status: GOOD (  20.50  )
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
Cc: Martin George <marting@netapp.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMi8xOC8yMSAxMDo0NiBBTSwgTWFydGluIEdlb3JnZSB3cm90ZToKPiBHaXZlbiBkaXNjb3Zl
cnkgY29udHJvbGxlcnMgY2FuIG5vdyBhY2NlcHQgaW50ZWdlciBhcmd1bWVudHMKPiBmb3Iga2F0
bywgcGVybWl0IHRoZSBzYW1lIGluIGJ1aWxkX29wdGlvbnMoKS4KPiAKPiBTaWduZWQtb2ZmLWJ5
OiBNYXJ0aW4gR2VvcmdlIDxtYXJ0aW5nQG5ldGFwcC5jb20+Cj4gLS0tCj4gICBmYWJyaWNzLmMg
fCA1ICsrLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9u
cygtKQo+IAo+IGRpZmYgLS1naXQgYS9mYWJyaWNzLmMgYi9mYWJyaWNzLmMKPiBpbmRleCAxODgw
YTVkLi45Y2ZlMjZhIDEwMDY0NAo+IC0tLSBhL2ZhYnJpY3MuYwo+ICsrKyBiL2ZhYnJpY3MuYwo+
IEBAIC04OTYsOSArODk2LDggQEAgc3RhdGljIGludCBidWlsZF9vcHRpb25zKGNoYXIgKmFyZ3N0
ciwgaW50IG1heF9sZW4sIGJvb2wgZGlzY292ZXIpCj4gICAJICAgICghZGlzY292ZXIgJiYKPiAg
IAkgICAgICBhZGRfaW50X2FyZ3VtZW50KCZhcmdzdHIsICZtYXhfbGVuLCAicXVldWVfc2l6ZSIs
Cj4gICAJCQkJY2ZnLnF1ZXVlX3NpemUsIGZhbHNlKSkgfHwKPiAtCSAgICAoIWRpc2NvdmVyICYm
Cj4gLQkgICAgICBhZGRfaW50X2FyZ3VtZW50KCZhcmdzdHIsICZtYXhfbGVuLCAia2VlcF9hbGl2
ZV90bW8iLAo+IC0JCQkJY2ZnLmtlZXBfYWxpdmVfdG1vLCBmYWxzZSkpIHx8Cj4gKwkgICAgYWRk
X2ludF9hcmd1bWVudCgmYXJnc3RyLCAmbWF4X2xlbiwgImtlZXBfYWxpdmVfdG1vIiwKPiArCQkJ
CWNmZy5rZWVwX2FsaXZlX3RtbywgZmFsc2UpIHx8Cj4gICAJICAgIGFkZF9pbnRfYXJndW1lbnQo
JmFyZ3N0ciwgJm1heF9sZW4sICJyZWNvbm5lY3RfZGVsYXkiLAo+ICAgCQkJCWNmZy5yZWNvbm5l
Y3RfZGVsYXksIGZhbHNlKSB8fAo+ICAgCSAgICBhZGRfaW50X2FyZ3VtZW50KCZhcmdzdHIsICZt
YXhfbGVuLCAiY3RybF9sb3NzX3RtbyIsCj4gClJldmlld2VkLWJ5OiBIYW5uZXMgUmVpbmVja2Ug
PGhhcmVAc3VzZS5kZT4KCk1hcnRpbiwgeW91IHByb2JhYmx5IGhhdmUgdG8gcmVzZW5kIGl0IHZp
YSBhIHB1bGwgcmVxdWVzdCB0byB0aGUgZ2l0aHViIApyZXBvc2l0b3J5LgoKQ2hlZXJzLAoKSGFu
bmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdl
IEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArNDkg
OTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1
LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8
aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1udm1lCg==
