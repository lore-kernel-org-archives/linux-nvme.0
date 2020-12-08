Return-Path: <SRS0=lokR=FM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E396CC4361B
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 17:40:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2FCB23B23
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 17:40:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2FCB23B23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7WUFBhYMsnkYzWeLRBHByuv2GGdSoPwQXcyG6WJ3rs8=; b=b40pzHRGu4hjvCmKvI44dNmbi
	Src9Gu9NMhEDln9S9GpEFrFtFQb2gtFwAnXShjbq2Ea1haUJJaLfISAy7q1WgfydyRfS6bwgoVZZq
	eY2yPkThw5yMXXjXU5xS9521tuygcRPQ7r+MtY8ZenbSj3RlN84FLPEC7jeEKHt9O0lNE2VAFU/Ss
	lW4Rs5TBqyTEkvLok8l1CfqhhJmSb80tGSTrwFv0IwGPN22iRLuGJgC8yGEuUynAX/WF4krNQoyNQ
	OJBs0fJNLKZGj0/jdwnnRCoYhENRXJb6CXzVC89/5H6+WAWJQ+5CXzgCu6/G+S57ZPe7FmIs56qu1
	qZ9Ic+VJA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmgyi-0005SF-SM; Tue, 08 Dec 2020 17:40:44 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmgyf-0005Rc-QG
 for linux-nvme@lists.infradead.org; Tue, 08 Dec 2020 17:40:42 +0000
Date: Wed, 9 Dec 2020 02:40:33 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607449240;
 bh=Pthv0drr/BdV4nawVTypKSskep3cEpiVfIvYOKn1O3c=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=TP8PrZqHt7YlzmcokNc+4IrleziuZ/uDzLY65dp1y8XnNm7Dc9weYj56zweWk74B0
 JTzj1omAjfk+HKRi5LJplLrzI8mNKlf5oWq8uP3wyLyiOsYLlTSMR8as6mIb3jyTzx
 AG7xtSkcRGVd3d3trId414nNaxxQ0kuXW/gJrvkGYa35Jwv1E+2Gj8wAgwkGyLOjwV
 1mDuUc9zRS/NNSB9TJiplxCVUwdfjYyuNQJAG7j5wuS4uKfjhDsd4y7uMaqDbS+wE7
 7e+8yV8sW1umUNzWaSMT983FAj/B5bAM6Rf0gA04MX3zFhn5ZOlJTxp+Mc/Mon+xds
 cgku/H0yNJJ4A==
From: Keith Busch <kbusch@kernel.org>
To: "Knight, Frederick" <Frederick.Knight@netapp.com>
Subject: Re: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
Message-ID: <20201208174033.GA27155@redsun51.ssa.fujisawa.hgst.com>
References: <20201118114859.7985-1-marting@netapp.com>
 <20201118162415.GA16753@lst.de>
 <7fd0b51f3b7bc73abf7132aaa5ee7c493a93aef0.camel@netapp.com>
 <20201120094432.GA25846@lst.de>
 <185CE0F5-617A-4446-A5C6-86A832D5A188@netapp.com>
 <DM5PR0601MB362496D2C29A18B3B1B77A61F1FC0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201207152532.GA4527@lst.de>
 <DM5PR0601MB362473E145AC665C0DE96286F1CD0@DM5PR0601MB3624.namprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DM5PR0601MB362473E145AC665C0DE96286F1CD0@DM5PR0601MB3624.namprd06.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201208_124041_990098_2E025C0D 
X-CRM114-Status: GOOD (  17.65  )
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
Cc: "George, Martin" <Martin.George@netapp.com>,
 Hannes Reinecke <hare@suse.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "Meneghini, John" <John.Meneghini@netapp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gVHVlLCBEZWMgMDgsIDIwMjAgYXQgMDM6MjE6MTZQTSArMDAwMCwgS25pZ2h0LCBGcmVkZXJp
Y2sgd3JvdGU6Cj4gSXQgaXMgY2xlYXIgdGhhdCB0aGUgTlMgYXR0cmlidXRlIGNoYW5nZSBpcyBy
ZXF1aXJlZDoKPiBOYW1lc3BhY2UgQXR0cmlidXRlIENoYW5nZWQ6IEluZGljYXRlcyBhIGNoYW5n
ZSB0byBvbmUgb3IgYm90aCBvZiB0aGUgZm9sbG93aW5nOgo+IOKAogkuLi4gOyBvcgo+IOKAogl0
aGUgTmFtZXNwYWNlIExpc3QgcmV0dXJuZWQgd2hlbiB0aGUgSWRlbnRpZnkgY29tbWFuZCBpcyBp
c3N1ZWQgd2l0aCB0aGUgQ05TIGZpZWxkIHNldCB0byAwMmguCj4gCj4gSXQgc2VlbXMgY2xlYXIg
dG8gbWUgdGhhdCB0aGUgQU5BIGNoYW5nZSBJUyBwcm9oaWJpdGVkOgo+Cj4gQXN5bW1ldHJpYyBO
YW1lc3BhY2UgQWNjZXNzIENoYW5nZTogVGhlIEFzeW1tZXRyaWMgTmFtZXNwYWNlIEFjY2Vzcwo+
IGluZm9ybWF0aW9uIChyZWZlciB0byBzZWN0aW9uIDUuMTQuMS4xMikgcmVsYXRlZCB0byBhbiBB
TkEgR3JvdXAgdGhhdAo+IGNvbnRhaW5zIG5hbWVzcGFjZXMgYXR0YWNoZWQgdG8gdGhpcyBjb250
cm9sbGVyIGhhcyBjaGFuZ2VkIChlLmcuLCBhbgo+IEFOQSBzdGF0ZSBoYXMgY2hhbmdlZCwgYW4g
QU5BR1JQSUQgaGFzIGNoYW5nZWQpLiBUaGUgY3VycmVudAo+IEFzeW1tZXRyaWMgTmFtZXNwYWNl
IEFjY2VzcyBpbmZvcm1hdGlvbiBmb3IgYXR0YWNoZWQgbmFtZXNwYWNlcyBpcwo+IGluZGljYXRl
ZCBpbiB0aGUgQXN5bW1ldHJpYyBOYW1lc3BhY2UgQWNjZXNzIGxvZyBwYWdlIChyZWZlciB0bwo+
IHNlY3Rpb24gNS4xNC4xLjEyKS4KPiAKPiBXZSBDQU5OT1QgZGVsaXZlciB0aGlzIEFFTiB1bmxl
c3MgaXQgaXMgcmVsYXRlZCB0byBhbiBBTkEgZ3JvdXAgdGhhdAo+IGNvbnRhaW5zIG5hbWVzcGFj
ZXMgYXR0YWNoZWQgdG8gdGhpcyBjb250cm9sbGVyLiAgVGhlIGNyZWF0aW5nIG9mIGEKPiBuZXcg
QU5BIGdyb3VwICh3aGljaCB0aGVyZWZvcmUgaGFzIG5vIG5hbWVzcGFjZXMpIGRvZXMgbm90IG1l
ZXQgdGhlCj4gY3JpdGVyaWEgb2YgImNvbnRhaW5pbmcgbmFtZXNwYWNlcyBhdHRhY2hlZCB0byB0
aGlzIGNvbnRyb2xsZXIiLiAgU28KPiB0aGVyZSBhcmUgMiBwb3NzaWJsZSBvcmRlcnMgLSAxKSB0
aGUgQU5BIGdyb3VwIGlzIGNyZWF0ZWQgYmVmb3JlIHRoZQo+IG5hbWVzcGFjZSwgb3IgMikgdGhl
IG5hbWVzcGFjZSBpcyBjcmVhdGVkIGJlZm9yZSB0aGUgbmFtZXNwYWNlLiAgSWYKPiB0aGUgR3Jv
dXAgaXMgY3JlYXRlZCBiZWZvcmUgdGhlIG5hbWVzcGFjZSwgdGhlbiB0aGVyZSBhcmUgTk8gYXR0
YWNoZWQKPiBuYW1lc3BhY2VzIGluIHRoYXQgKGJyYW5kIG5ldykgQU5BIGdyb3VwLCB0aGVyZWZv
cmUsIHdlIGFyZSBwcm9oaWJpdGVkCj4gZnJvbSBzZW5kaW5nIHRoZSBBRU4uICBJZiB0aGUgbmFt
ZXNwYWNlIGlzIGNyZWF0ZWQgYmVmb3JlIHRoZSBBTkEKPiBncm91cCwgdGhlbiB3ZSBoaXQgdGhl
IG5leHQgbGFuZ3VhZ2UsIHRoYXQgcHJvaGliaXRzIHNlbmRpbmcgdGhlIEFOQQo+IGNoYW5nZWQg
QUVOIGJlY2F1c2UgaXMgaXQgImR1ZSB0byB0aGUgY3JlYXRpb24gb2YgYSBuYW1lc3BhY2UiLgoK
SXQgY2FuJ3QgYmUgIjEiLiBJZiB5b3UgbWFrZSBhIGdyb3VwIHdpdGhvdXQgYSBuYW1lc3BhY2Us
IHRoZSBob3N0CmNvdWxkbid0IHJlYWQgaXQgYW55d2F5IGJlY2F1c2UgdGhlIGxvZyBvbmx5IGNv
bnRhaW5zIGVudHJpZXMgZm9yIGdyb3Vwcwp3aXRoIG5hbWVzcGFjZXMgYXR0YWNoZWQgdG8gdGhh
dCBjb250cm9sbGVyLgoKQXMgZm9yICIyIiwgbXkgdW5kZXJzdGFuZGluZyBmcm9tIHJlYWRpbmcg
dGhpcyBpcyB0aGF0IGl0IHJlZmVycyB0bwpzdXBwcmVzc2luZyB0aGUgQU5BIGV2ZW50IHdoZW4g
YSBjaGFuZ2UgaW4gdGhlICJOdW1iZXIgb2YgTlNJRCBWYWx1ZXMiCndpdGhpbiBhIGdyb3VwIG9j
Y3VycyByYXRoZXIgdGhhbiBhIGNoYW5nZSBpbiAiTnVtYmVyIG9mIEFOQSBHcm91cApEZXNjcmlw
dG9ycyIgZmllbGQuCgpBcyBmb3IgdGV4dCBzdXBwb3J0aW5nIGl0LCB3ZSBoYXZlIDguMjAuMy42
OgoKICBhbiBBc3ltbWV0cmljIE5hbWVzcGFjZSBBY2Nlc3MgQ2hhbmdlIE5vdGljZSBzaGFsbCBi
ZSBzZW50IGJ5IHRoZQogIGNvbnRyb2xsZXJzIHdoZXJlIHRoZSBjaGFuZ2Ugb2NjdXJyZWQ6CiAg
IC4uLgogIGMpIHVwb24gZW50cnkgdG8gdGhlIGZvbGxvd2luZyBBTkEgc3RhdGVzOgoKWW91ciBz
Y2VuYXJpbyBoYXMgYW4gQU5BIGdyb3VwIHRoYXQgcHJldmlvdXNseSBkaWRuJ3QgZXhpc3QgZW50
ZXJpbmcgYQpzdGF0ZSwgc28geW91IHNoYWxsIHNlbmQgdGhlIGV2ZW50LgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxp
c3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
