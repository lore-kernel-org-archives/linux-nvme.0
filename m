Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF641C61DA4
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Feb 2023 06:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=u8ADuaV+2ucAeKsQtekgOp9l2AIDc60D529wqPdQd6Y=; b=DhDa2CU9WHGx2k
	xkMgreakXTzcrwTyKfyTKWRNO30UhGtG3xYeAe/fKiqfc0MdEF28NLubFzIco3evrZktMfxx3FqWu
	ZxG0+PEqmZlatm5gzc7dUtOSEW8znvQdxViUuD6zRLnofCHNaB9RKY02uDfYxC+y10J3VV6aZbmHz
	TGn0F/p+qhUvaxhxG2Cq9jXJDRYlgNyFjzRX1tul5xuOGd7mpUSdHqNiXcYbxBaGOwcs2OV6MW81d
	x2Pcx90Wo6thYHiTvfcZ1mRwEWQ9BlBUH6obKRgP7x535+lptemLldkiXXmagsLRGkoxYK0IP7Jwf
	msZkhf1emNfb571e5KIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNSq0-00EW7y-7f; Thu, 02 Feb 2023 06:12:48 +0000
Received: from mail-dm6nam11on2070d.outbound.protection.outlook.com ([2a01:111:f400:7eaa::70d] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNSpx-00EW6u-W7
	for linux-nvme@lists.infradead.org; Thu, 02 Feb 2023 06:12:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDfaugdr3uksveIXrXFjZIDP396oZu8Bg1Mwb0pL6FAaREhhX8qXjpRmUPZdXK/6aamSeQD+KsLZ5KTdS4sDdP4zxrZGtyBpc09LpaI2i5hMJqP/ymo5ERpLdo+9pTeP2xS0icKkXTn3war76oL3u7i5rcmaux/kguvbWTus+bVf81SxzhGRvztcAOig4pQXre1L6dJx8pEQ/YKfdkypRv3punQ89PZaFhBtPWAk3d5qGlTYGuPpRuLZ84lFFK1d59yhQwRm3AChjJqedn8XiIl4yjyrG/kZuhkpH3rEJGMbswYEPo/r4VSbdWlm6twOT8OSIiEd0YcJrvY3LGSZTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8ADuaV+2ucAeKsQtekgOp9l2AIDc60D529wqPdQd6Y=;
 b=XRhjYdsvN6Pon06vRbTtrcyii+Mof8AstJ+m/vROEd+AIq18v6JNsh/U0Jh+02nrnkUn8bCGiBlWCxtolU7aXcrWqicTUH0qwUgg+2oAz+IvvKeH+0x3KuXc++CRzCxPj4GhWsenpgjTZL0HY2dhbTfMgLL4LgZv+CUxR2i4NnRCTAedmsTbYzk2GjgeE6IlfeILP3uAYrz+WsXjoZwotSJ1F6dwjKs4qLBMAFe1rPN2Ij6T7GqB/LO/Un/TmNhfaIJnP6PTQjEtbEsCAY8AZ36hwu/fbUfDLY3CP8NehtZWoDdw6IXRzlmJrM+LWDp144SqKtiLRRFHzuF57o08qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hcdatainc.com; dmarc=pass action=none
 header.from=hcdatainc.com; dkim=pass header.d=hcdatainc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG220063.onmicrosoft.com; s=selector2-NETORG220063-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8ADuaV+2ucAeKsQtekgOp9l2AIDc60D529wqPdQd6Y=;
 b=nMs7nT+zWaw2ifs6kxhXLu8xzSb+m2y9hSWf4aTcQJGzFW1mO4jyjEyg3QsFm/vyxQiG5Z5/YS9JkbxFy1dGKVnV4u/m8LcEuWjsKrKU4/XDHSfmRR5HnjO3PCWxHcUiJ6/fkXAr0/Jj9BejExFFVAE/WL463rNcbIriDz0t6nU=
Received: from MN2PR10MB3469.namprd10.prod.outlook.com (2603:10b6:208:10e::13)
 by SJ0PR10MB5741.namprd10.prod.outlook.com (2603:10b6:a03:3ec::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Thu, 2 Feb
 2023 06:12:36 +0000
Received: from MN2PR10MB3469.namprd10.prod.outlook.com
 ([fe80::6642:7fb5:8591:ec70]) by MN2PR10MB3469.namprd10.prod.outlook.com
 ([fe80::6642:7fb5:8591:ec70%3]) with mapi id 15.20.6064.019; Thu, 2 Feb 2023
 06:12:36 +0000
From: Haibo Wu <haibowu@hcdatainc.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: CMB hotplug
Thread-Topic: CMB hotplug
Thread-Index: AQHZNraNB3rgsa5XoUGYQAxKqEcjvg==
Date: Thu, 2 Feb 2023 06:12:35 +0000
Message-ID:  <MN2PR10MB3469953AA0F599D67D593AC2A5D69@MN2PR10MB3469.namprd10.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hcdatainc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR10MB3469:EE_|SJ0PR10MB5741:EE_
x-ms-office365-filtering-correlation-id: 2469cba9-ab10-4f9f-e361-08db04e47aa7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  GQIcPctVyeOXpletE2AZiOLEToYcZI/hBz8APBiBuZD/BFepGfnrjy7jDWiVmXI+iUZKSaVQCKHkHguaMWNgKICEdiruzhGfTId2XWF5cVSki6AQbeMHJ7rivCPJ/dVTqH4J8lKzpJV4X63Uouq3o9Vt0NrTLYIrQxUZXoNffgKiyerRF2HK4XQ/5DaETtJgd2KPS8K0Pt7CL0Q8My4ng6jukJSCdQNH7fjDcuCFAysJfVSlc3C27X2I+pbsA0H868WB0Ere48ktD4I01+pNx2bb3KV6b4RY4gwvXeThBewzIpGPIuFULxdjkphO7CI7f4/7nDkSTIJ8sV0+TwfBV7ws/FnWXAST3L0nQfVOG/OmZNT6aCoXp/ZzlMiM2B+sWFaGCP2EO8uW3OM9JcW0e1ZD/n1V2oiCzSg4/yZn10XBxym3Em6T5bpL0EeYz3BMbVVoFqm8L0VOzcwroPUamWPUdDJItipTH7OX+fdzTTQmfceYnkZsiMvatPQkxMWcGxBDSSSSi0Jd3TBfRuDh8XnBwhOsGEcvKsk51zqHuTeSB19nEJEvcTpRkHQPVTHKuSAXCyDvnEzXj7FU0JaaSMUJdIDIlkI+rWtrIrDkWcZrFhdMdnt7ByIXHIaiINhXTWTLxXtXJsOTaQBN05Cb9ZPTw32uJaUVL98xxRja9nBXIqOQNzCYTyJAzfGyUeRoECZgudynUwDe4GlC8IhwX7AVR7nxXTnvWTNEKfLfmzyvI7duUUIYzi+vMXWJNk9m
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3469.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39830400003)(346002)(376002)(366004)(396003)(136003)(451199018)(41300700001)(55016003)(86362001)(6916009)(91956017)(38070700005)(38100700002)(122000001)(316002)(64756008)(66556008)(66476007)(33656002)(478600001)(8676002)(76116006)(66446008)(7696005)(3480700007)(6506007)(66946007)(186003)(9686003)(71200400001)(4744005)(7116003)(52536014)(2906002)(8936002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?iso-8859-1?Q?NcPdL+MIP6gXTRaEZypVwW18Pcud2L3TkQoQ4BvIZlcReliesJ+/vl9nHu?=
 =?iso-8859-1?Q?b4HkmnwKvkUl2GjdOfZGQAilbt9BWa1fsubQx5aBB1Gh2+7nV19dkPhPip?=
 =?iso-8859-1?Q?kZ80Tv8gabJ9hVxN3z8ZxEtSfAINE1ZNGQTMV/K5eR7Q1jvhu7KpLEk9l0?=
 =?iso-8859-1?Q?aZJN+X3J+gpnr2rKCPmu7jdGhNsilhTO2xLeyVUxxCKL8gYtJj1xTFgw3a?=
 =?iso-8859-1?Q?UqTRUIhaSUB/3P88YQu6+SSM9y5R9Q9tx11MTrq0sA7w0B9bgJrZ4TrbOo?=
 =?iso-8859-1?Q?ZU1zQv5xVCYLcncXcwtsiwROlREApEy8sf6ltaWo2/Y/ciTrkfMFEWTNev?=
 =?iso-8859-1?Q?L2c39L4oUKpaMvMzhMJuhbpxGey7e0U/4CBHpiabntdlxD9wtooASFHSBX?=
 =?iso-8859-1?Q?M34Pkd44SQ5l2P2EAAyOcdmkLpNI6hBZGUO2eaVpHhtqexoUNP6jyFgo7V?=
 =?iso-8859-1?Q?UHsjhAomR5YNcRHDza3NiD3XyosSj+QT4SVd+A/JUR5nYuciXLEIH3cnHT?=
 =?iso-8859-1?Q?jKLEJB9YljQ3lv7hLU/SZTEydpmN1CTkQ67xL5qFy6mlkOtpuTdXs/h3Bh?=
 =?iso-8859-1?Q?WBLrES/5ow6WuEF2I+/0izCThvIX43pmIbiqiOaVXRGBrWaTnPB7V0+JWr?=
 =?iso-8859-1?Q?WKFWGyHgfjXxrFMBcmq0CreHKSjq95KRMpuZ/t0oiwBkoQglOXrmzyoIiL?=
 =?iso-8859-1?Q?JGcCZUjWHr1uXIiBDAuDqK9AtvFHi7fLG0q64mTYExjIo0f2woSQiV05wq?=
 =?iso-8859-1?Q?prSVaWpi7v6oLQU+5jK9H13VD/NqG37bKKFDJNYQsPgJhT7vR9an3KdqSW?=
 =?iso-8859-1?Q?H5R7fI2jTKCxx2YyyTSDUNSmyRSSBD4uVdvIVndYxUxct7F9mSvtVWuJjo?=
 =?iso-8859-1?Q?t7v50k20DNKH/2kq2S48wNyYaYfxSS2TR1I80LWZR3BRxeSD5Y7GXpBYMm?=
 =?iso-8859-1?Q?2zS1RXthUZU4qMMY8k170f2hrrpa2zeIz2Ay80yk+4nKEti0NNuz+a6/e4?=
 =?iso-8859-1?Q?0nWoJAsG1YsTTe/zl8jcM2RV7rwWmP07vwEMzMEqJul8FDs0ckOnrXI+Bl?=
 =?iso-8859-1?Q?htKp/mUoHZPhs75N6BgPESpLG87r8Jr6FzvGz6MCUOSAbqy2PgMB+BgyHO?=
 =?iso-8859-1?Q?C4G7+B3sMkKwfZNeuWZYg855gpesRpZ4YlLxa6Y3IyYCZgOUMBjmweYerW?=
 =?iso-8859-1?Q?Rc5hFZExCw/U/lu01HXAaNBfRrilwztp12TGxuK2HYz/vzMxTaX5XIk2XC?=
 =?iso-8859-1?Q?KClo18Vm/a+8wptwSC5E20h6Hc67wz9LCT/+HzEiu6jF9ifASkjMKamQRW?=
 =?iso-8859-1?Q?+v/8Fr+4TmLUKkgZmIhwy1JEc0pYFYIwwRz6mi/1M2PDNJSdkqcK6ICGNd?=
 =?iso-8859-1?Q?TPhsWy/k7zikeaG9C9evcInr7Kh6AVpCDxFOwUxdpumNaN+lYLjHXoRvKO?=
 =?iso-8859-1?Q?FgWg2jveCFbhBFupKh8yqQ3GPhJeBrcbgoKBmZP80b/k+r2+uVb6yBxQNf?=
 =?iso-8859-1?Q?pBvQwaHD/nL6zVeE9EfPtMP46bhMj6Kb6FvnszyvpqRhk4BmPgRSOUeLxO?=
 =?iso-8859-1?Q?24CjmRpqftXtqch9ltgvu+R/k8br/xkWXyHvEcomn/FbzPtvW8w9X7RVgf?=
 =?iso-8859-1?Q?gqGstNq4ZKWL7HHaX+rma2KypyORP2ZLA/6vW54SANDu+zdeC2XwE+7Q6e?=
 =?iso-8859-1?Q?BQp8K40hysekfw/KRrcCB2Oy/Gr9oYRFhrTG9Bjf?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: hcdatainc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3469.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2469cba9-ab10-4f9f-e361-08db04e47aa7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2023 06:12:35.9778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d8368637-8933-4f2c-a6d2-c0d726d49c7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g2BvmNoqwjvl53LqKNL64pomy3PPcLKEcrcH62d/LD5BX4d2j9MqlYgV2tzYbCcV64pgdKKm3vQREa2grSsBjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5741
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230201_221246_258787_C1AFAF3B 
X-CRM114-Status: UNSURE (   7.13  )
X-CRM114-Notice: Please train this message.
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

Hi all,=0A=
=0A=
I mapped cmb resource file and wrote data to it. When I unplugged the ssd, =
I thought that a SIGBUG should be generated but the program was still runni=
ng. So was this a normal behavior?=0A=
=0A=
kernel version: 5.15.88=0A=
OS: centos 7.4=0A=
=0A=
My code like this:=0A=
size_t resource_size=3D 268435456;=0A=
size_t remain =3D resource_size;=0A=
size_t offset =3D 0;=0A=
size_t range =3D 128;=0A=
char tmp;=0A=
int fd =3D open("/sys/bus/pci/devices/0000:5e:00.0/resource4_wc", O_RDWR);=
=0A=
void * map_addr =3D mmap(NULL, resource_size, PROT_READ | PROT_WRITE, MAP_S=
HARED, fd, 0);=0A=
while (remain > 0) {=0A=
  memcpy(map_addr + offset, buf + offset, range);=0A=
  memcpy(&tmp, map_addr + offset, 0);=0A=
  remain -=3D range;=0A=
  offset +=3D range;=0A=
  if (remain =3D=3D 0) {=0A=
    remain =3D resource_size;=0A=
    offset =3D 0;=0A=
}=0A=
=0A=
Thanks,=0A=
Haibo=0A=

