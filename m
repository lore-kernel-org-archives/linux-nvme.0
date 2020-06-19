Return-Path: <SRS0=ohfr=AA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEBAC433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jun 2020 17:10:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06A5120771
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jun 2020 17:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EGAkfKlZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dcyTH23B";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ONBKT3eb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06A5120771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=+9DF9iFL/L2U6MzohNev/boeoRUgGvbcInocBzKKj/s=; b=EGAkfKlZTTfGYN
	Xt8+hPl3lvRftP/wNx4UU6c9flI8jTxVjLct++T6iFy7b4HnjsshSdG5Yu+YHOiuewTQMhrEnAOob
	fLlkXzbIe2CaHlK6n2MCcIavIVdRVABk1j0UTa/KIIrY+nyOqC+waRTyoTUIKMpX/V7RhBKq0raTE
	N153Ce1A+gtDklJU3JEQt4YtWnxcnvrcZfLcHQ4sg9McKigXxoDtA9vPtjQA2fb72WVJdyi0fhoWj
	OisVfNWLT28mTa7ffwlDkLREvAMrGA1OXA2OFGL9tO35ETOWf697oX/raWlsyMKTO5qdAePr3EXyy
	mxM77MrO6LH8GarbJLtQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jmKWj-0000Li-Ky; Fri, 19 Jun 2020 17:10:05 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jmKWg-0007zh-2Z
 for linux-nvme@lists.infradead.org; Fri, 19 Jun 2020 17:10:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592586601; x=1624122601;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=jJUvG4X+iVSM/sx3WUyoT7gry63YOv/6+nGppmyZXCk=;
 b=dcyTH23BGAhcdJPCt2g3ZtQ+xaGxNusUAfwTaRNQ3oS0WPEsJx+9Ng3v
 YJP7XMw4lOE5rbLjNauBR6+5gX3Jp4FwgjRIitbHeangOrnYyadjQeswR
 NhsqQ5eU2IbrLccun+L05YhaJMS0dqgVHJIsi5Rgf/IUFOfagTLU9NGLu
 oiehpwm+bRdA+wY+iBcpez1P28QZeoBrl/1rM6Rs3+2AfRFxe2aCwrbrB
 7htpMF0+2doB4uvYSExGmAixc3tvqLDFDWM6t/AIVDnnfCKz6a+vbImBZ
 uJRAeRaXHxTJ3fHNwDJ2YTCkPEZivW+iw2nbQvGhjjJKmRKlLfbbaUk/j w==;
IronPort-SDR: xpAV8j1Z5gJrfQtdk6BTa4ybhb7nWY9Dng7hqtqnYZpIJrD1TPbws+bR1HyV2x0lo9MCW8ZqJv
 x0uUuEvJ0eUcwBHIiQk5dLu3k2nP0wv1Nx9684u8dV8DiVnsdqHQYdJUbT2yEXFPxhKs8BWG6B
 PbPS68s9B2+8eKtdY1pvGhm35le54ThGzT9cOUxYTHHStPi2aWRuUinwpyq994vDWv9C7CaTdY
 cD7+ulNlw6IsyYSt8iQfBHpCRziGXPkHDRgQ/NbmOPEzt9eyMhLhnqunbPL+qm0N6DkD68T4SR
 iuo=
X-IronPort-AV: E=Sophos;i="5.75,256,1589212800"; d="scan'208";a="140444542"
Received: from mail-bl2nam02lp2056.outbound.protection.outlook.com (HELO
 NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.56])
 by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2020 01:10:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UdNSA/Bk9I2Fz5YbLcXEOLIZPJEELkNNUvLD3cdjoClEOr3knhWUeFujTu9B1sopeiLQ6szpzW5qTaTleFNiujm1P/Se9ql634GO0CblyQa2fLlhHQxgrROUWD0S6DdXT5qxtyJQm4VNERSpaH7aANKQL+GxKcimGTL7A0OaFpmVG4z1/j5OfnkCHLMUa1Es1Ka5O1WovXYznyoOKkAT+pPRUtEiCgJ8+MkciNYNTLaLaLe6KI0LT3L5doHT7ODR4vlLbs+5L3JYvPmgN/dT3wEhgeUtwpmBYprOwgQe+KoHH6hMT+Wo3wmGdQhGGHNOtnunijWOvj843KX+wWJnoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJUvG4X+iVSM/sx3WUyoT7gry63YOv/6+nGppmyZXCk=;
 b=PkW4AvAuwyrgeVUq+Dm/eRIWgibGexfUpSGNOTfiTWkatNSoxk++ZYUVhMS7QEd6f6LzV9o/Tn/gJ2yx7shl0jdZx8g1mCPictroOMihcRdcXKmuhL1xt/3TMKgYnLZCamWeax7gOMbMmji7zJgzDJVKUa3bTyS8J2NdiaCKNTxsm0/JmdlQtQH9J2EnFj7GlrnHgPiDP3kU1OXdoCIy9DH6VMA+qatc5+RgIrDD+KIkcJUrrMmDvEV8dZqGdS0UK6t/I0rJvW1UgnSwtHk+Ayai24T55szGX9jCnShuj5toCiVFsG8l8o4QKKAUh0HAuGsa7e6GJSUvmYO6qlatqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJUvG4X+iVSM/sx3WUyoT7gry63YOv/6+nGppmyZXCk=;
 b=ONBKT3eb9dTI/woDVFTtuvsDgbUzXQNI4gM4Xdv+DvkqJQEZyFlZEwYcCY4tpDDUKhbGNoLfXHj5a87NpqEs8aYJvmsOzfMM1a3UUuYri+G7qpZQysEkALvTWNrHVQ7OJ0sSs9o+tWlgHy+t+s/FwPo2FBIMFS9O1/8BhPPs60A=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4039.namprd04.prod.outlook.com (2603:10b6:a02:ab::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 19 Jun
 2020 17:09:59 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3109.023; Fri, 19 Jun 2020
 17:09:59 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme-core: use rcu in instead rw_sem
Thread-Topic: [PATCH] nvme-core: use rcu in instead rw_sem
Thread-Index: AQHWReqxAucGVgoOxUeCw5URjZqxLg==
Date: Fri, 19 Jun 2020 17:09:59 +0000
Message-ID: <BYAPR04MB4965688B16728E723FC5397B86980@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200619033531.27819-1-chaitanya.kulkarni@wdc.com>
 <20200619152158.GA1149998@dhcp-10-100-145-180.wdl.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7c30ceca-c039-4d1a-144d-08d814739959
x-ms-traffictypediagnostic: BYAPR04MB4039:
x-microsoft-antispam-prvs: <BYAPR04MB4039F48C114218AD437C97E586980@BYAPR04MB4039.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-forefront-prvs: 0439571D1D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oZJ3BXl3msWjcv5x4nOCNYoZhGoWa7HyW1VaSiD7kA65i/6YhKPCYGd1LFi+xFAZwwwglp5eE/kz1X9f34VpmEmCMXAHZwQ8DIZJnAVGAZol6/yS94/wGs1MFAZFhFUhDOaG9gERPF+Agq4sjmUIuslmEGaN69ZM7JGdTFAjj0ZD48z4VEX4wWFG++HbkAZrN3y4iWRyCLtTi3veWwBJwu5KcYyanWW85jdVrybvmZvIJjDqc4Rvy0hK13neMk5zvNEe8kOTy50UKpFinytzWUCFsdOk4bWlbNNwdov8whkjNdeOm94oqwHk62avnOr7nHfdBtqtuWruQ33tcmnbtA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(55016002)(53546011)(4326008)(6506007)(54906003)(186003)(7696005)(4744005)(8936002)(2906002)(316002)(33656002)(5660300002)(26005)(66476007)(64756008)(66946007)(66556008)(66446008)(71200400001)(8676002)(83380400001)(6916009)(9686003)(478600001)(86362001)(52536014)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: H6zXtd1opHkAKabpjqvnmDCdwyAnLKcVEa5Qa4XLkATIKW2GodYQaAWifD7yE4MksohFWwbq+TcPl0FfhOE9lOvhI9FpKjn5BZX2EbEuYRW/BDOlO7S00MGnME7xfn9QIW495fxyLvd2k5Iu6DnONbKEJQNUivU8S6AgoQEyq4q9ecLD8380TzAlEDUc9bNJWgDm4gsks0qSWIcYLd378i1Z5gVS998hxLSgJahDhGK86hpkmbkR6YEn+E9asyJbyX9rcASMwUa8NyFlliqZ67ly2JoQvpUmk73PFBD2PNDwR3gI6UUeVwlkP3Ml7w/ZABL8mv7CwgcZXPpan51WnA57wkI9xrGr0PjiqhmW1aQb97F9bCQeGpFbRQBpIrNOu9/9wcy2GmAqYOFCdDZL1Htcq3n5qC+3PZsCRFIuvvT2Uy8Ng7veyFgPZCv+wPuZ7O16hVfypI/SjJFuX37sd234hiMQrkRrNxV13QZyi3M=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c30ceca-c039-4d1a-144d-08d814739959
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2020 17:09:59.8452 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xsN1Jp8nssdlTZfxTGDteVLafn827wLig2Bpejxz3Q55/d3wMvkjpUDLkUwe/cekeYAP7GfZ0Gr+B7A4qXcettrB+N+8WWqWNe9KlnY4tqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4039
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200619_101002_211957_F72AD00A 
X-CRM114-Status: UNSURE (   8.39  )
X-CRM114-Notice: Please train this message.
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
Cc: "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 6/19/20 8:22 AM, Keith Busch wrote:
> I'm all for a more efficient implementations, but I'm concerned that
> we're still going to search a loop on every request. Maybe use xarray?
> 

Good idea, actually we need something which can also cache range of 
small access with minimum overhead. I'll add this in V2.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
