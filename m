Return-Path: <SRS0=nBdQ=IC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAD5C433DB
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 12:26:23 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4AA66023B
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 12:26:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4AA66023B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=oAkczd+fNW08cX8c2s6pQL+ZiVmyG4rSBzfRNbmUpQw=; b=aLp2wp8UzsvP7w71GhGrgZDIm
	VTxTvvGNb24X3V5ooCOCBSDMQ/LdISS+PZmg98o860hyIqBM5XuMB6N36OonKPHFpiZDH4kMS4XuS
	Sp+zS52VM4Hsxae1xdXL8SUhc840JBqtdQ//J/rHbMkw/ASWmyncPXTaUAGGvFz5rKKBP9To/uK7F
	BJd0MdpmC98dc/KkrAycEjZLE5EqWVe9wIP+kQwbDuMA1NVDKgJ0YFTcXZtZz0cXet6Rnc0ASgX8f
	mQn4WWY3f5KsAGF8agVgOQGzDtKKZikLBxDOOVFs2FovNFIejL1ivlolWOIvbLdak4AnpZPaPj3t9
	UJVDgJmiA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHn3Q-008bID-G8; Thu, 04 Mar 2021 12:26:08 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHn3E-008bFt-UB
 for linux-nvme@lists.infradead.org; Thu, 04 Mar 2021 12:25:59 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 6D175AFB4;
 Thu,  4 Mar 2021 12:25:56 +0000 (UTC)
Subject: Re: [PATCH v8 02/16] blkcg: Added a app identifier support for blkcg
To: Muneendra <muneendra.kumar@broadcom.com>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, tj@kernel.org, linux-nvme@lists.infradead.org
Cc: jsmart2021@gmail.com, emilne@redhat.com, mkumar@redhat.com
References: <1614835646-16217-1-git-send-email-muneendra.kumar@broadcom.com>
 <1614835646-16217-3-git-send-email-muneendra.kumar@broadcom.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <21d35185-705f-4baa-0f43-f9d71103c7b7@suse.de>
Date: Thu, 4 Mar 2021 13:25:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1614835646-16217-3-git-send-email-muneendra.kumar@broadcom.com>
Content-Language: en-US
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

T24gMy80LzIxIDY6MjcgQU0sIE11bmVlbmRyYSB3cm90ZToKPiBUaGlzIFBhdGNoIGFkZGVkIGEg
dW5pcXVlIGFwcGxpY2F0aW9uIGlkZW50aWZpZXIgaS5lCj4gZmNfYXBwX2lkICBtZW1iZXIgaW4g
YmxrY2cgd2hpY2ggYWxsb3dzIGlkZW50aWZpY2F0aW9uIG9mIHRyYWZmaWMKPiBzb3VyY2VzIGF0
IGFuIGluZGl2aWR1YWwgY2dyb3VwIGJhc2VkIEFwcGxpY2F0aW9ucwo+IChleDp2aXJ0dWFsIG1h
Y2hpbmUgKFZNKSlsZXZlbCBpbiBib3RoIGhvc3QgYW5kCj4gZmFicmljIGluZnJhc3RydWN0dXJl
Lgo+IAo+IEFkZGVkIGEgbmV3IGZ1bmN0aW9uIGJsa2NnX2dldF9mY19hcHBpZCB0bwo+IGdyYWIg
dGhlIGFwcCBpZGVudGlmaWVyIGFzc29jaWF0ZWQgd2l0aCBhIGJpby4KPiAKPiBBZGRlZCBhIG5l
dyBmdW5jdGlvbiBibGtjZ19zZXRfZmNfYXBwaWQgdG8KPiBzZXQgdGhlIGFwcCBpZGVudGlmaWVy
IGluIGEgYmxrY2dycCBhc3NvY2lhdGVkIHdpdGggY2dyb3VwIGlkCj4gCj4gQWRkZWQgYSBuZXcg
Y29uZmlnIEJMS19DR1JPVVBfRkNfQVBQSUQgYW5kIG1vdmVkIHRoZSBjaGFuZ2VzCj4gdW5kZXIg
dGhpcyBjb25maWcKPiAKPiBTaWduZWQtb2ZmLWJ5OiBNdW5lZW5kcmEgPG11bmVlbmRyYS5rdW1h
ckBicm9hZGNvbS5jb20+Cj4gCj4gLS0tCj4gdjg6Cj4gTm8gY2hhbmdlCj4gCj4gdjc6Cj4gTW9k
aWZpZWQgdGhlIEtjb25maWcgZmlsZQo+IAo+IHY2Ogo+IE1vZGlmaWVkIHRoZSBLY29uZmlnIGZp
bGUgYXMgcGVyIHN0YW5kYXJkIHNwZWNpZmllZAo+IGluIERvY3VtZW50YXRpb24vcHJvY2Vzcy9j
b2Rpbmctc3R5bGUucnN0Cj4gCj4gdjU6Cj4gUmVuYW1lZCB0aGUgYXJndW1lbnRzIGFwcHJvcHJp
YXRsZXkKPiBSZW5hbWVkIEFQUElEX0xFTiAgdG8gRkNfQVBQSURfTEVOCj4gTW92ZWQgdGhlIGlu
cHV0IHZhbGlkYXRpb24gYXQgdGhlIGJlZ2luaW5nIG9mIHRoZSBmdW5jdGlvbgo+IE1vZGlmaWVk
IHRoZSBjb21tZW50cwo+IAo+IHY0Ogo+IE5vIGNoYW5nZQo+IAo+IHYzOgo+IFJlbmFtZWQgdGhl
IGZ1bmN0aW9ucyBhbmQgYXBwX2lkIHRvIG1vcmUgc3BlY2lmaWMKPiAKPiBBZGRyZXNzZWQgdGhl
IHJlZmVyZW5jZSBsZWFrcyBpbiBibGtjZ19zZXRfYXBwX2lkZW50aWZpZXIKPiAKPiBBZGRlZCBh
IG5ldyBjb25maWcgQkxLX0NHUk9VUF9GQ19BUFBJRCBhbmQgbW92ZWQgdGhlIGNoYW5nZXMKPiB1
bmRlciB0aGlzIGNvbmZpZwo+IAo+IEFkZGVkIGJsa2NnX2dldF9mY19hcHBpZCxibGtjZ19zZXRf
ZmNfYXBwaWQgYXMgaW5saW5lIGZ1bmN0aW9ucwo+IAo+IHYyOgo+IHJlbmFtZWQgYXBwX2lkZW50
aWZpZXIgdG8gYXBwX2lkCj4gcmVtb3ZlZCB0aGUgIHN5c2ZzIGludGVyZmFjZSBibGtpby5hcHBf
aWRlbnRpZmllIHVuZGVyCj4gLS0tCj4gICBibG9jay9LY29uZmlnICAgICAgICAgICAgICB8ICA5
ICsrKysrKwo+ICAgaW5jbHVkZS9saW51eC9ibGstY2dyb3VwLmggfCA1NiArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKwo+ICAgMiBmaWxlcyBjaGFuZ2VkLCA2NSBpbnNlcnRp
b25zKCspCj4KUmV2aWV3ZWQtYnk6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPgoKQ2hl
ZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtlcm5l
bCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhm
ZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNj
aMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1u
dm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1udm1lCg==
