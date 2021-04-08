Return-Path: <SRS0=WFi/=JF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DD6C433B4
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 08:35:32 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D036061004
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 08:35:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D036061004
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=NDYT/q8651a6fJuKDZg55FP1bqt0slfiZSBTMSVcrUA=; b=NiFzWi2mic4S0puzAaPjLTugw
	kGlUuqAa4BqE1STnPnBoOy4i9hVfBng6jGa8+JWkAHAe3pG+SNQXtTTgKOhzrM1fHTovslSxdr9vS
	QabKmBTJNwjH29WAZfz2XB9cO/ozuT+diAsG+P/GuIl9BO057kWeghylmF0P/QKU5h8QMHVoz5iSs
	vbAfXhEXrMtGAo9Fx/mQmReaPPI+wi0MZFbeXREiyMf0OerBpAuDL0T6GBdeOc+gZwXWZ0GxDUDdk
	4JnUwOpfv5MYlQXI/mGt/x7QoqOmj/UWlA37H0jpkfTsw3A+nE50dildxURkATIliPWj3iW0Qvmpn
	1a39XxYrw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUQ8H-007LfX-Nr; Thu, 08 Apr 2021 08:35:21 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUQ7m-007LXR-DD
 for linux-nvme@lists.infradead.org; Thu, 08 Apr 2021 08:34:54 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id C37FCB0E6;
 Thu,  8 Apr 2021 08:34:49 +0000 (UTC)
Subject: Re: [PATCH v9 02/13] blkcg: Added a app identifier support for blkcg
To: Muneendra <muneendra.kumar@broadcom.com>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, tj@kernel.org, linux-nvme@lists.infradead.org
Cc: jsmart2021@gmail.com, emilne@redhat.com, mkumar@redhat.com
References: <1617750397-26466-1-git-send-email-muneendra.kumar@broadcom.com>
 <1617750397-26466-3-git-send-email-muneendra.kumar@broadcom.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <db9da780-56f8-b33a-eb4c-49380297f8a8@suse.de>
Date: Thu, 8 Apr 2021 10:26:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1617750397-26466-3-git-send-email-muneendra.kumar@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210408_093450_540819_FBCE092B 
X-CRM114-Status: GOOD (  19.52  )
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

T24gNC83LzIxIDE6MDYgQU0sIE11bmVlbmRyYSB3cm90ZToKPiBUaGlzIFBhdGNoIGFkZGVkIGEg
dW5pcXVlIGFwcGxpY2F0aW9uIGlkZW50aWZpZXIgaS5lCj4gZmNfYXBwX2lkICBtZW1iZXIgaW4g
YmxrY2cgd2hpY2ggYWxsb3dzIGlkZW50aWZpY2F0aW9uIG9mIHRyYWZmaWMKPiBzb3VyY2VzIGF0
IGFuIGluZGl2aWR1YWwgY2dyb3VwIGJhc2VkIEFwcGxpY2F0aW9ucwo+IChleDp2aXJ0dWFsIG1h
Y2hpbmUgKFZNKSlsZXZlbCBpbiBib3RoIGhvc3QgYW5kCj4gZmFicmljIGluZnJhc3RydWN0dXJl
Lgo+IAo+IEFkZGVkIGEgbmV3IGZ1bmN0aW9uIGJsa2NnX2dldF9mY19hcHBpZCB0bwo+IGdyYWIg
dGhlIGFwcCBpZGVudGlmaWVyIGFzc29jaWF0ZWQgd2l0aCBhIGJpby4KPiAKPiBBZGRlZCBhIG5l
dyBmdW5jdGlvbiBibGtjZ19zZXRfZmNfYXBwaWQgdG8KPiBzZXQgdGhlIGFwcCBpZGVudGlmaWVy
IGluIGEgYmxrY2dycCBhc3NvY2lhdGVkIHdpdGggY2dyb3VwIGlkCj4gCj4gQWRkZWQgYSBuZXcg
Y29uZmlnIEJMS19DR1JPVVBfRkNfQVBQSUQgYW5kIG1vdmVkIHRoZSBjaGFuZ2VzCj4gdW5kZXIg
dGhpcyBjb25maWcKPiAKPiBNZXJnZWQgdGhlIHBhdGNoIDE2IG9mIHByZXZpb3VzIHZlcnNpb24g
aW4gd2hpY2ggd2UKPiBhZGRlZCBhIG5ldyBjb25maWcgRkNfQVBQSUQgdG8gc2VsZWN0IEJMS19D
R1JPVVBfRkNfQVBQSUQgd2hpY2ggRW5hYmxlCj4gc3VwcG9ydCB0byB0cmFjayBGQyBpbyBUcmFm
ZmljLgo+IAo+IFNpZ25lZC1vZmYtYnk6IE11bmVlbmRyYSA8bXVuZWVuZHJhLmt1bWFyQGJyb2Fk
Y29tLmNvbT4KPiAKPiAtLS0KPiB2OToKPiBNZXJnZWQgcGF0Y2gxNiBvZiBwcmV2aW9zdSB2ZXJz
aW9uIHRvIHRoaXMgcGF0Y2gKPiB3aGVyZSB3ZSBhcmUgdXNpbmcgS2NvbmZpZyBzZXR0aW5ncwo+
IAo+IHY4Ogo+IE5vIGNoYW5nZQo+IAo+IHY3Ogo+IE1vZGlmaWVkIHRoZSBLY29uZmlnIGZpbGUK
PiAKPiB2NjoKPiBNb2RpZmllZCB0aGUgS2NvbmZpZyBmaWxlIGFzIHBlciBzdGFuZGFyZCBzcGVj
aWZpZWQKPiBpbiBEb2N1bWVudGF0aW9uL3Byb2Nlc3MvY29kaW5nLXN0eWxlLnJzdAo+IAo+IHY1
Ogo+IFJlbmFtZWQgdGhlIGFyZ3VtZW50cyBhcHByb3ByaWF0bGV5Cj4gUmVuYW1lZCBBUFBJRF9M
RU4gIHRvIEZDX0FQUElEX0xFTgo+IE1vdmVkIHRoZSBpbnB1dCB2YWxpZGF0aW9uIGF0IHRoZSBi
ZWdpbmluZyBvZiB0aGUgZnVuY3Rpb24KPiBNb2RpZmllZCB0aGUgY29tbWVudHMKPiAKPiB2NDoK
PiBObyBjaGFuZ2UKPiAKPiB2MzoKPiBSZW5hbWVkIHRoZSBmdW5jdGlvbnMgYW5kIGFwcF9pZCB0
byBtb3JlIHNwZWNpZmljCj4gCj4gQWRkcmVzc2VkIHRoZSByZWZlcmVuY2UgbGVha3MgaW4gYmxr
Y2dfc2V0X2FwcF9pZGVudGlmaWVyCj4gCj4gQWRkZWQgYSBuZXcgY29uZmlnIEJMS19DR1JPVVBf
RkNfQVBQSUQgYW5kIG1vdmVkIHRoZSBjaGFuZ2VzCj4gdW5kZXIgdGhpcyBjb25maWcKPiAKPiBB
ZGRlZCBibGtjZ19nZXRfZmNfYXBwaWQsYmxrY2dfc2V0X2ZjX2FwcGlkIGFzIGlubGluZSBmdW5j
dGlvbnMKPiAKPiB2MjoKPiByZW5hbWVkIGFwcF9pZGVudGlmaWVyIHRvIGFwcF9pZAo+IHJlbW92
ZWQgdGhlICBzeXNmcyBpbnRlcmZhY2UgYmxraW8uYXBwX2lkZW50aWZpZSB1bmRlcgo+IC0tLQo+
ICAgYmxvY2svS2NvbmZpZyAgICAgICAgICAgICAgfCAgOSArKysrKysKPiAgIGRyaXZlcnMvc2Nz
aS9LY29uZmlnICAgICAgIHwgMTMgKysrKysrKysrCj4gICBpbmNsdWRlL2xpbnV4L2Jsay1jZ3Jv
dXAuaCB8IDU2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gICAzIGZp
bGVzIGNoYW5nZWQsIDc4IGluc2VydGlvbnMoKykKPiAKUmV2aWV3ZWQtYnk6IEhhbm5lcyBSZWlu
ZWNrZSA8aGFyZUBzdXNlLmRlPgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5l
Y2tlICAgICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3
YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2
ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVy
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1u
dm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
