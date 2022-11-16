Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 638C9C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Nov 2022 11:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PLrIz+yObc/Klqb+9uGQSjHLTg7oKIoYpoDyeTPULSg=; b=L/4WqVWV1JLmKzTFtoQm3MK8UY
	jbZ0dEgaWbmfbWwnsSr5wVLO4aOegY6Vv96Gq7iiS3eSRPkX1Qz6Qi2z0sACsxmeXJRdaTRsRZDS4
	2hml4kTkcyy8HpZP6G9TZxvKj5h9GRje6xxAJTuBkT8HgFK5+qD9qlzTIWKM/2tVV22IV+vimwJKy
	089Vn/U93BJGcM35o22uYMFmedP1AfOMIAuKjdqrAHXdyEs/B5AjMDRLdDpEuSE3RVSg9RhhbQQlw
	opACkvxlgp/KZH4yjcIkixI9Ob2ClNxm4TOPsKmKB8OgooI5M6f8eooaY4MQDbRP6OxGjvVZmKgkA
	1bNtKpIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovH3Z-003Bpx-MG; Wed, 16 Nov 2022 11:58:17 +0000
Received: from mta-02.yadro.com ([89.207.88.252] helo=mta-01.yadro.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovH3U-003Bn4-Dx
	for linux-nvme@lists.infradead.org; Wed, 16 Nov 2022 11:58:15 +0000
Received: from localhost (unknown [127.0.0.1])
	by mta-01.yadro.com (Postfix) with ESMTP id 1FE4240886;
	Wed, 16 Nov 2022 11:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
	mime-version:content-transfer-encoding:content-id:content-type
	:content-type:content-language:accept-language:in-reply-to
	:references:message-id:date:date:subject:subject:from:from
	:received:received:received:received:received; s=mta-01; t=
	1668599886; x=1670414287; bh=PLrIz+yObc/Klqb+9uGQSjHLTg7oKIoYpoD
	yeTPULSg=; b=eY5sA3yswu0dpMnqTqoxpSETG0nOK0QEMDm0NdNESK/wkPZcpTr
	v9a/7Cm0xMDnLNJ0HPpdrgaMKtMynSQu+aO5OoWvmclIuT1fWy9PZ8nDoAXyG6E+
	6ISfUSfk7b4Uys6a2r2zeZcheB3XmJe8cyqKifOAD2F78DI8ooPPKE2I=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
	by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KOTBqt75Yx6l; Wed, 16 Nov 2022 14:58:06 +0300 (MSK)
Received: from T-EXCH-01.corp.yadro.com (T-EXCH-01.corp.yadro.com [172.17.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by mta-01.yadro.com (Postfix) with ESMTPS id 02782404AC;
	Wed, 16 Nov 2022 14:58:04 +0300 (MSK)
Received: from T-EXCH-10.corp.yadro.com (172.17.11.60) by
 T-EXCH-01.corp.yadro.com (172.17.10.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Wed, 16 Nov 2022 14:58:04 +0300
Received: from T-Exch-05.corp.yadro.com (172.17.10.109) by
 T-EXCH-10.corp.yadro.com (172.17.11.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Wed, 16 Nov 2022 14:58:04 +0300
Received: from T-Exch-05.corp.yadro.com ([172.17.10.109]) by
 T-Exch-05.corp.yadro.com ([172.17.10.109]) with mapi id 15.02.1118.009; Wed,
 16 Nov 2022 14:58:04 +0300
From: Aleksandr Miloserdov <a.miloserdov@yadro.com>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
CC: Chaitanya Kulkarni <kch@nvidia.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux@yadro.com" <linux@yadro.com>,
	Konstantin Shelekhin <k.shelekhin@yadro.com>, Dmitriy Bogdanov
	<d.bogdanov@yadro.com>
Subject: Re: [PATCH v2 1/2] nvmet: expose IEEE OUI to configfs
Thread-Topic: [PATCH v2 1/2] nvmet: expose IEEE OUI to configfs
Thread-Index: AQHY+OmQSLUB1LWV/UmOpumOO7H1Pa4/0nIAgAEbJACAAIXyAA==
Date: Wed, 16 Nov 2022 11:58:04 +0000
Message-ID: <626CFF30-AC50-46A5-B8CD-1387E2D459E4@yadro.com>
References: <20221115115810.75848-1-a.miloserdov@yadro.com>
 <20221115115810.75848-2-a.miloserdov@yadro.com>
 <1243d214-e399-237f-e70d-bb4541a66b28@grimberg.me>
 <20221116065838.GA19952@lst.de>
In-Reply-To: <20221116065838.GA19952@lst.de>
Accept-Language: ru-RU, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.178.113.226]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A56DA7A452FE1540B3C6F6DED9A6D4E9@yadro.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221116_035813_156102_329203B7 
X-CRM114-Status: GOOD (  13.98  )
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

DQoNCu+7v09uIDE2LjExLjIwMjIsIDA5OjU4LCAiQ2hyaXN0b3BoIEhlbGx3aWciIDxoY2hAbHN0
LmRlPiB3cm90ZToNCj4gICAgT24gVHVlLCBOb3YgMTUsIDIwMjIgYXQgMDQ6MDU6MTRQTSArMDIw
MCwgU2FnaSBHcmltYmVyZyB3cm90ZToNCj4gICAgPj4gaW5kZXggYzhhMDYxY2UzZWU1Li40OGEy
ZjU4N2YzOGEgMTAwNjQ0DQo+ICAgID4+IC0tLSBhL2RyaXZlcnMvbnZtZS90YXJnZXQvYWRtaW4t
Y21kLmMNCj4gICAgPj4gKysrIGIvZHJpdmVycy9udm1lL3RhcmdldC9hZG1pbi1jbWQuYw0KPiAg
ICA+PiBAQCAtMzcyLDYgKzM3Miw4IEBAIHN0YXRpYyB2b2lkIG52bWV0X2V4ZWN1dGVfaWRlbnRp
ZnlfY3RybChzdHJ1Y3QgbnZtZXRfcmVxICpyZXEpDQo+ICAgID4+ICAgICAgbWVtY3B5X2FuZF9w
YWQoaWQtPmZyLCBzaXplb2YoaWQtPmZyKSwNCj4gICAgPj4gICAgICAgICAgICAgICAgICAgICBV
VFNfUkVMRUFTRSwgc3RybGVuKFVUU19SRUxFQVNFKSwgJyAnKTsNCj4gICAgPj4gICArICBwdXRf
dW5hbGlnbmVkX2xlMjQoc3Vic3lzLT5pZWVlX291aSwgaWQtPmllZWUpOw0KPiAgICA+PiArDQo+
ICAgID4NCj4gICAgPiBBbnkgcGFydGljdWxhciByZWFzb24gd2h5IGl0IGlzIHBsYWNlZCBoZXJl
IGFuZCBub3Qgd2hlcmUgdGhlIGNvbW1lbnQNCj4gICAgPiB3YXM/DQo+DQo+ICAgIEtlZXBpbmcg
dGhlIElEIGFzc2lnbm1lbnQgdG9nZXRoZXIgc2VlbXMgcHJldHR5IHJlYXNvbmFibGUgdG8gbWUu
DQoNCkFsc28gYXNzaWduaW5nIGFkamFjZW50IHN0cnVjdCBtZW1iZXJzIGluIG9uZSBjaHVuayBs
b29rcyBuZWF0IHRvIG1lLg0KDQo=

