Return-Path: <SRS0=YrQE=HG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051FFC433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 07:05:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F9FC64D99
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 07:05:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F9FC64D99
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=loIDABDhIZA9ll0P3FDvM0WSNB0FehnU0fzlksns2IQ=; b=z55F6F3OqCa0yCuUjkodaIvJR
	2SR23pHjFXGCVlijcWwsS48geupq4gtvXwr5G5Mn9lWgX6Belorm6rmuUkl65LWIRoVgJajCUhqMV
	h/7PcOsE1cfTgYp4Q3EAUeKi3PYMQDrsUVQzkmTiPxF3prHpmGAMaIfEuDLTbTY+AEOMADl+Bk5Cn
	EBqAcOOStIQsWeXkbdt/lyio1EVBmLAYY1A2Q7eZjHeKRdqzED9AmU+an7WC3XBdADE3UgpGbqXKR
	b6qejqeBVpRm/qdKlXI0C1NSPw5/DPRlKmrEpDnZ36mpODnQ7J9PK4V/ecomwsaDkOBx0vJ5Cw9x+
	XF1ow+IMg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7YhF-00042D-Eu; Thu, 04 Feb 2021 07:04:57 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7YhD-000415-5y
 for linux-nvme@lists.infradead.org; Thu, 04 Feb 2021 07:04:55 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 5631DAC97;
 Thu,  4 Feb 2021 07:04:53 +0000 (UTC)
Subject: Re: [PATCH 08/35] monitor: add command line options to control logging
To: mwilck@suse.com, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20210126203324.23610-1-mwilck@suse.com>
 <20210126203324.23610-9-mwilck@suse.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <37259dc3-16f3-ef0c-fafa-d6a4749c5126@suse.de>
Date: Thu, 4 Feb 2021 08:04:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210126203324.23610-9-mwilck@suse.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210204_020455_347197_78C89D07 
X-CRM114-Status: GOOD (  20.44  )
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

T24gMS8yNi8yMSA5OjMyIFBNLCBtd2lsY2tAc3VzZS5jb20gd3JvdGU6Cj4gRnJvbTogTWFydGlu
IFdpbGNrIDxtd2lsY2tAc3VzZS5jb20+Cj4gCj4gU3RhbmRhcmQgc3lzbG9nIGxvZ2xldmVscyBh
cmUgdXNlZC4KPiBPcHRpb25zOgo+IAo+ICAgLVMvLS1zaWxlbnQgICB0byBzdXBwcmVzcyBMT0df
Tk9USUNFCj4gICAtdi8tLXZlcmJvc2UgIHRvIGVuYWJsZSBMT0dfSU5GTyAob3ZlcnJpZGVzIC1T
KQo+ICAgLUQvLS1kZWJ1ZyAgICB0byBlbmFibGUgTE9HX0RFQlVHIChvdmVycmlkZXMgLVMsIC12
KQo+ICAgLUMvLS1jbG9ja3N0YW1wcyB0byBlbmFibGUgdGltZSBzdGFtcHMgb24gbG9nIG1lc3Nh
Z2VzLgo+IAo+IEkgdHJpZWQgdG8gdXNlIHNob3J0IG9wdGlvbnMgdGhhdCBkb24ndCBjb25mbGlj
dCB3aXRoIG9wdGlvbnMKPiBmcm9tIG52bWUgY29ubmVjdC1hbGwsIGJlY2F1c2UgbWFueSBvZiB0
aG9zZSBvcHRpb25zIG1pZ2h0IGJlCj4gdXNlZnVsIGZvciB0aGUgbW9uaXRvciwgdG9vLgo+IAo+
IFNpZ25lZC1vZmYtYnk6IE1hcnRpbiBXaWxjayA8bXdpbGNrQHN1c2UuY29tPgo+IC0tLQo+ICAg
bW9uaXRvci5jIHwgNDcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKyst
LS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA0MSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygt
KQo+IC4uLiBhbmQgaWYgeW91IGhhZCBtb3ZlZCB0aGUgbG9nZ2luZyBmdW5jdGlvbmFsaXR5IHBy
aW9yIHRvIHRoZSBtb25pdG9yIApjb2RlLCB0aGlzIHBhdGNoIGNvdWxkIGJlIG1lcmdlZCB3aXRo
IHRoZSBtYWluIG1vbml0b3IgZnVuY3Rpb25hbGl0eSwgdG9vLgoKQ2hlZXJzLAoKSGFubmVzCi0t
IApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hp
dGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArNDkgOTExIDc0
MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQw
OSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJlcjog
RmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1udm1lCg==
