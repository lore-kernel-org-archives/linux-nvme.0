Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 179F9FA3740
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Oct 2022 12:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LkW9eSx33sxKdOgpybfmb9QW63eDNf3n1am46Zm2k+k=; b=Zo/KhXXufD0GqJTkljottjHAmg
	B+MQmPWQuY+JZQtmsQQi/E1OziuvJzwjSONNoOgY4sdz1yAFjtOPh+HZfy3Tlrx6m5XrHW5DcuWrz
	zK0mYjAx6IcG0p0A9fd73iEEwJTmpVIaaxi8sU5JEVEjqr6bOCQ0pGSyOkcydlH2wi/17Rk+CZELJ
	GfL3I9BlocCWlDpjWemGOIYfXP630hGkQfY9ojnmgfLk1glgxKZRC6QvH+rLmd/zqXHmAn+AEpESv
	s0Q7wzextzQM6JzidgmAPvY1sMUapG4fW/KqnN+Pg3I2QXXYfDMhMiC9I0IGxoWQl84epn+/9eQb4
	RE6qPR3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oo2Jg-00DE6s-L7; Thu, 27 Oct 2022 12:49:00 +0000
Received: from mta-02.yadro.com ([89.207.88.252] helo=mta-01.yadro.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oo2Jc-00DE42-Py
	for linux-nvme@lists.infradead.org; Thu, 27 Oct 2022 12:48:59 +0000
Received: from localhost (unknown [127.0.0.1])
	by mta-01.yadro.com (Postfix) with ESMTP id 3EEDD40880;
	Thu, 27 Oct 2022 12:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
	mime-version:content-transfer-encoding:content-id:content-type
	:content-type:content-language:accept-language:in-reply-to
	:references:message-id:date:date:subject:subject:from:from
	:received:received:received:received:received; s=mta-01; t=
	1666874925; x=1668689326; bh=LkW9eSx33sxKdOgpybfmb9QW63eDNf3n1am
	46Zm2k+k=; b=juF27ZxcnFMVvEKc6nhmCbTEwO8+1T8q49lwy2GmbY020EeEebn
	3L6fPz8Zf2hbSJvvmmfC+XJdtjSC9o6kpij2OyG2GW5Zg6IqdFAlyhhb6GuTh9mr
	5DCNUdnSbbXAQFw4kI9q84VKXjNzKxkhazchMx99S8QfCaj8bdqOyc30=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
	by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VoPg6H6XkebC; Thu, 27 Oct 2022 15:48:45 +0300 (MSK)
Received: from T-EXCH-01.corp.yadro.com (T-EXCH-01.corp.yadro.com [172.17.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by mta-01.yadro.com (Postfix) with ESMTPS id 1AF4240886;
	Thu, 27 Oct 2022 15:48:39 +0300 (MSK)
Received: from T-EXCH-09.corp.yadro.com (172.17.11.59) by
 T-EXCH-01.corp.yadro.com (172.17.10.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Thu, 27 Oct 2022 15:48:39 +0300
Received: from T-Exch-05.corp.yadro.com (172.17.10.109) by
 T-EXCH-09.corp.yadro.com (172.17.11.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Thu, 27 Oct 2022 15:48:39 +0300
Received: from T-Exch-05.corp.yadro.com ([172.17.10.109]) by
 T-Exch-05.corp.yadro.com ([172.17.10.109]) with mapi id 15.02.1118.009; Thu,
 27 Oct 2022 15:48:39 +0300
From: Aleksandr Miloserdov <a.miloserdov@yadro.com>
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux@yadro.com" <linux@yadro.com>, Konstantin Shelekhin
	<k.shelekhin@yadro.com>, Dmitriy Bogdanov <d.bogdanov@yadro.com>
Subject: Re: [PATCH 2/3] nvmet: expose IEEE OUI to configfs
Thread-Topic: [PATCH 2/3] nvmet: expose IEEE OUI to configfs
Thread-Index: AQHY6RWp7PQy021dZkOacy1gA4nhda4gTLqAgAH2WgA=
Date: Thu, 27 Oct 2022 12:48:38 +0000
Message-ID: <D38AF3DC-3F8A-4EE1-8252-71A7F0971823@yadro.com>
References: <20221026083135.77125-1-a.miloserdov@yadro.com>
 <20221026083135.77125-3-a.miloserdov@yadro.com>
 <6f630727-72bc-6ae8-e23f-dece692c31e7@grimberg.me>
In-Reply-To: <6f630727-72bc-6ae8-e23f-dece692c31e7@grimberg.me>
Accept-Language: ru-RU, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.178.113.226]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B2A9DFA694D211409670EAECCAA3C94C@yadro.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221027_054857_550703_D3D208DD 
X-CRM114-Status: GOOD (  16.77  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

PiBPbiAyNi4xMC4yMDIyLCAxNDo0OSwgIlNhZ2kgR3JpbWJlcmciIDxzYWdpQGdyaW1iZXJnLm1l
PiB3cm90ZToNCj4gICAgT24gMTAvMjYvMjIgMTE6MzEsIEFsZWtzYW5kciBNaWxvc2VyZG92IHdy
b3RlOg0KPiA+IEFsbG93IHVzZXIgdG8gc2V0IE9VSSBmb3IgdGhlIGNvbnRyb2xsZXIgdmVuZG9y
Lg0KPiA+DQo+ID4gUmV2aWV3ZWQtYnk6IEtvbnN0YW50aW4gU2hlbGVraGluIDxrLnNoZWxla2hp
bkB5YWRyby5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IERtaXRyaXkgQm9nZGFub3YgPGQuYm9nZGFu
b3ZAeWFkcm8uY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFsZWtzYW5kciBNaWxvc2VyZG92IDxh
Lm1pbG9zZXJkb3ZAeWFkcm8uY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9udm1lL3Rhcmdl
dC9hZG1pbi1jbWQuYyB8ICA5ICsrKy0tLQ0KPiA+ICAgZHJpdmVycy9udm1lL3RhcmdldC9jb25m
aWdmcy5jICB8IDQ5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAgZHJp
dmVycy9udm1lL3RhcmdldC9jb3JlLmMgICAgICB8ICAyICsrDQo+ID4gICBkcml2ZXJzL252bWUv
dGFyZ2V0L252bWV0LmggICAgIHwgIDEgKw0KPiA+ICAgNCBmaWxlcyBjaGFuZ2VkLCA1NiBpbnNl
cnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bnZtZS90YXJnZXQvYWRtaW4tY21kLmMgYi9kcml2ZXJzL252bWUvdGFyZ2V0L2FkbWluLWNtZC5j
DQo+ID4gaW5kZXggYzhhMDYxY2UzZWU1Li4wYjQxNTMzNWJiNWYgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy9udm1lL3RhcmdldC9hZG1pbi1jbWQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbnZtZS90
YXJnZXQvYWRtaW4tY21kLmMNCj4gPiBAQCAtMzcyLDYgKzM3MiwxMCBAQCBzdGF0aWMgdm9pZCBu
dm1ldF9leGVjdXRlX2lkZW50aWZ5X2N0cmwoc3RydWN0IG52bWV0X3JlcSAqcmVxKQ0KPiA+ICAg
ICAgIG1lbWNweV9hbmRfcGFkKGlkLT5mciwgc2l6ZW9mKGlkLT5mciksDQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgVVRTX1JFTEVBU0UsIHN0cmxlbihVVFNfUkVMRUFTRSksICcgJyk7DQo+ID4N
Cj4gPiArICAgICBpZC0+aWVlZVswXSA9IChzdWJzeXMtPmllZWVfb3VpKSAmIDB4ZmY7DQo+ID4g
KyAgICAgaWQtPmllZWVbMV0gPSAoc3Vic3lzLT5pZWVlX291aSA+PiA4KSAmIDB4ZmY7DQo+ID4g
KyAgICAgaWQtPmllZWVbMl0gPSAoc3Vic3lzLT5pZWVlX291aSA+PiAxNikgJiAweGZmOw0KPiA+
ICsNCj4NCj4gICAgcHV0X3VuYWxpZ25lZF8yNCA/DQoNClNlZW1zIGxpa2UgYSBnb29kIGlkZWEs
IEknbGwgYWRkIGl0IGluIHRoZSBzZWNvbmQgdmVyc2lvbiBvZiB0aGUgcGF0Y2guDQpEaWQgeW91
IGhhcHBlbiB0byBjaGVjayBvdXQgdGhlIHRoaXJkIHBhdGNoIGZyb20gdGhlIHNlcmllcz8NCg0K

