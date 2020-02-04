Return-Path: <SRS0=ej39=3Y=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C24C3524A
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Feb 2020 03:27:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DD112084E
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Feb 2020 03:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="B9PyfQcZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="d1YrfiWq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RqlBI9AW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DD112084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=28zQtHgUui5tGCuxkEJDGc2xhMJ6M9PCGMqIt7gzQz0=; b=B9PyfQcZGfrtrx
	Ulnek9TiklNdBsyiOVOmGr4XGDsHj8pUpK+xiHCdHVIcF7hwrlwvN2DX4t9iHJbGiCzYc0r753Fo8
	Qwm0KmeRG14E0EX4bMc3HkLo99hfoK0husZMHeqg7GoQlsMWR8uwEcVz0h0Ant0MRAqV2rwvuFULh
	60Ndtli3c0vd5ORL1i/VAfRGq48SKyc+ITOn7SyPkn8m1C5db49ixb0QVZvZgh7JmF8WJrgTNtmVu
	ZrjNtAd0cHEFew0054WW58KVapfiv6I16bfT5LqLOPSNIm48Ny7aQ7gqTJ+y/VeFC/amRrpEFTeWn
	wCW59p42+gpXyhSBJwXQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iyoro-0001N7-AH; Tue, 04 Feb 2020 03:27:12 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iyorl-0001Mi-0d
 for linux-nvme@lists.infradead.org; Tue, 04 Feb 2020 03:27:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1580786829; x=1612322829;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=m0fjmDGymbmYPcCeW6JEyOpBx9q+DfRqaIFy3RKQym4=;
 b=d1YrfiWqSRI0fiklafzVyINmoH83S12KICj/GNZepwRIW3lZAUZ8Inn/
 snPwU2wXiWHBhoLU/ZhIWkQBtWzAyy7XNP9b8y5yAOlDVNYBAz7LD0fL5
 lVYt+ySw5egi8RYE4yc4NbgDZMSmt/JCaAgmhourvodNGaa/b5RDHcVfS
 3uAMji/lbxAg5u3J+0OPFCwOR2TxTPoAx3+0z65elSFHKL/mxW4qSjWay
 VJtK/SB2ILcThB4XvxXX6Sy/yUPmedtAPmJ/KozXZBu4E2/s2ZCcvBXJJ
 mAPv3d5yUiaXuyeJ8AO8nn8rS1JJHKGtm/pseXeIzzELtaCTimLfoZrOn w==;
IronPort-SDR: WyE9c+WXbBgxAAG4m9OB4TJOrcr8/pZKDLKcp96vbRI/cYoL86kdWtQgN5WWbSn1w9/WVAGeH1
 XCQZVRmqpfuREFcYqA0CqR6Nbu/oEA/EBExn40tLLF5MJf/Y4ATAMOwnDHKPerzbzzMsEKtVNf
 IUJlQROUF0hapnPhOFnT/91+DTGT4DD1lBzQR/THR4KAJttFNsBF81jGzlTm+xhQ7FGA1PtRjZ
 2C5/ZJ1ZdABcP17CwUgjypJ2mcPJwVsyHiwG9Z7tAXRUrh6EvPkV21eDSzqLzGMFEE0l1/GPWd
 S8E=
X-IronPort-AV: E=Sophos;i="5.70,398,1574092800"; d="scan'208";a="129575505"
Received: from mail-bn3nam04lp2054.outbound.protection.outlook.com (HELO
 NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.54])
 by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2020 11:27:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7Gh/xOSlKHPQ4Opjf9kLg8VUP0FE1XpNPXd2YMM4cCkOd/NdpEJJNu0CNQn1UAW+PupH6ufq+EMflEtFbHOcoPTq5f/dgGHIracIBl+C/vPB0gkJcG4Mf+JLyzRnlYqiU1PtTVKGvUHXt6zvdCUnrcTyuasYyukrAObQhJ/2C/+tv6pbaL4MFr4aoTVfoOb/jntJmLhTJWNKu+WN/yAW0M8ModplIQaCfzP1gyVxA0lOQlv4HwMpO39T6LBHDszpDttudVGc1OZbDL0ovNifULbmbx2/ipNBEUISryfqMjMmjsBDIXr2VwYW5DuA2jQVWcX3CRrqejoPn2OTvUBfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvO6vvvsun84GV25R/aj95tLL6LJpiiy/HCte4tjChE=;
 b=HGD4tMZptTkGY/MJ5LAkT7ntORojL3e56v175wQOEljdm6WfBBcTK5wsLOMnf84AIeck/JronQuoL92PMMAJdSs5RTxnwVFvo3vuPzr/98i3eX9c1w3GpTDKGUPkNaVt9tDZiGNAH5Qjv+1ggaEKTnR6M+rds74TG4ACr0fhpsyptSxu1yFGehgS0XshWPREEI2Du/XZ5Qyxru/qJUMDXNkF2al6XDPB+GDg/qglNG/rIYTgpiCi6EYXV4iSkOQK7OZKp1vT/ot+3TnBK5Q0dWIyQ027gl78afwjP8XE0lBhhIvg4nnh2IP8Xxauhlb34QSjZrhlY1/EkeMyp3qfRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvO6vvvsun84GV25R/aj95tLL6LJpiiy/HCte4tjChE=;
 b=RqlBI9AWTY8SxKUotyVIGtyvC28n76Rd8SpiGOxPOSLl3uC2fnDHmHiXJFMlUjgvQrIXMZtyBt7Dy4I1lJJZqQadTnYlfULXARxt180pfKeLR5oHZ5z7d1llq6n2pivSPe54B+2eZOt1FP7qXaZcdV5LSUDFb5SUmc2f7YqnQ2I=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB5557.namprd04.prod.outlook.com (20.178.232.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Tue, 4 Feb 2020 03:27:05 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f%5]) with mapi id 15.20.2686.028; Tue, 4 Feb 2020
 03:27:05 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH RESEND 0/2] nvmetcli: make model and ctrl-id configurable
Thread-Topic: [PATCH RESEND 0/2] nvmetcli: make model and ctrl-id configurable
Thread-Index: AQHVxqpUXzd8VxYIIEalrO1b4yEvMg==
Date: Tue, 4 Feb 2020 03:27:04 +0000
Message-ID: <BYAPR04MB5749D99EE2CD10AFB322988486030@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200109050448.5758-1-chaitanya.kulkarni@wdc.com>
 <DM6PR04MB57540A44AA6DC1E2DC67180686350@DM6PR04MB5754.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eedfcdfd-5fa4-47ed-d59b-08d7a9221b68
x-ms-traffictypediagnostic: BYAPR04MB5557:
x-microsoft-antispam-prvs: <BYAPR04MB555762C8E51ABF422EF910DF86030@BYAPR04MB5557.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 03030B9493
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(366004)(39860400002)(376002)(136003)(396003)(189003)(199004)(4744005)(6916009)(4326008)(86362001)(6506007)(9686003)(55016002)(53546011)(316002)(186003)(5660300002)(7696005)(26005)(8936002)(33656002)(81156014)(81166006)(478600001)(8676002)(71200400001)(54906003)(66946007)(52536014)(64756008)(66556008)(2906002)(76116006)(66476007)(66446008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5557;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +CLNO+K4uw3WGBMLkntDYPynl+OB4feDVD+uTRjDz5zBxUGy+AecZPnx82KchpR9iYqS5Ax5myN/smAm3X1rfdWh7wv+rBnJa129QmpuyJOzQ2FRKQVH/FjCLjHha3WsHrK7tsGLZ4iYcrd59qywPpIvNVsQdsMl0Aok+d6aMYlVAebQr87rZqRdo5FlUYsWE/sktGqRUx8D3XYyFUXr3w8Dgg9ANpdAUe6h27w7zSmu47gVzfHhd4IbZ+3qfrjZuS9oWt1U1E7/lTZoLigdU+Fm4SG7vAIugNkGhHzHQd5WOCp0ZDm+HZsJJJ809+l+1nXPVQQX0SYkkgaQn0/H/z27ZaaWlntiMXLOUDkg7DsDsIgtOfFWyxu/6D9FYDWCCPtWHXLkZ0z/X0E9YaK618hj38GYLjaoDaa0licH7aNlgghc48FIIbaBnqWHX9XM
x-ms-exchange-antispam-messagedata: bwcmHexfYY+EUCfkStZHk6IMGLeabNp28ShDg2NNqOb6liQta7gQMrFkxPIPpKCGWpaBQ1GiXINz2p+v9QIVMnhAtNctrQaTk7QZtjYwVWOVi0RPWKm8HOBiLQ2oHpBs2a2/v8FR1ZC1lEeo5aFSsg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eedfcdfd-5fa4-47ed-d59b-08d7a9221b68
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2020 03:27:04.7793 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0PNdtjDWU3IW03GXJ//VNDvZjWeFVPi+l/voVUVtHEqJ9IT2PZ+HfyoAYAfD/XbaDSywMCRFq5Tw8xYzIemhgw0hiXyDDVa7oCHz2z2kCCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5557
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200203_192709_153689_B1D9D109 
X-CRM114-Status: UNSURE (   9.40  )
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
Cc: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ping ?

On 01/13/2020 03:53 PM, Chaitanya Kulkarni wrote:
> Ping?
>
> On 01/08/2020 09:04 PM, Chaitanya Kulkarni wrote:
>> Hi,
>>
>> This patch series allows users to set the subsys model and ctrl-id
>> fields.
>>
>> Chaitanya Kulkarni (2):
>>     nvmetcli: allow setting of the cntlid[min|max]
>>     nvmetcli: allow setting of the subsystem model
>>
>>    nvmetcli | 25 +++++++++++++++++++++++++
>>    1 file changed, 25 insertions(+)
>>
>
>


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
