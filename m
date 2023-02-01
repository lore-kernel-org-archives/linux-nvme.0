Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42EC6C636D3
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Feb 2023 22:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GNb8BfVfe+f8kuaaqm7HjluDtfZI/LcbzWH9gcdIJ2w=; b=k+OujOMJ6b/tZcOLRikvmvlgsg
	r9GjREt2iCUZiljPmNuHHpWESA/niKgUbwCSlX+g89IxTjjeIFPvILOza7pWw2wXo8dNAjuO++uwO
	3T+FgnzNcJg4+UuslI3DhzxnDEd4uUpz0XDLfzcp6/v85Hs301vD+oWYbdOOkpeh4Ic2XGOpGrygZ
	z9W8jGz4SRRKmi1AIkgaGNk0SWH69dHc5JZS8E6icWyXnp70VrRMcvR7Ehn5jk+lN8ws9j4PItlxC
	+sOxJvbqGoWhM1t00lK3TLT7HDSp4glhEXoJxTT29ZKvIPkhlIfEsKpSgA8IJPZ8NcCNA5ayWrBdK
	MIEdCHNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNM4R-00DpGv-C0; Wed, 01 Feb 2023 22:59:15 +0000
Received: from mx07-001d1705.pphosted.com ([185.132.183.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNM4M-00DpFx-N9
	for linux-nvme@lists.infradead.org; Wed, 01 Feb 2023 22:59:12 +0000
Received: from pps.filterd (m0209325.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 311Mnau7005020;
	Wed, 1 Feb 2023 22:58:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=GNb8BfVfe+f8kuaaqm7HjluDtfZI/LcbzWH9gcdIJ2w=;
 b=KeoSe531Rf27ZR/k8jOq+T/c2916s8kDN8uR51HaKAhfSLVTZD77mqGYcS5M8kg5LorH
 GYmiPPPRB1cssKVsivjEf0sTSSiNIfITzI3hG851M0naURlLPpbCV5qYjFmrDr6Votgc
 iS7kIqAdl1pWXhDAoTq5q1ibcAQPF1BOqNkJmkJ5y/RgPdEnDoLipckMYYwp3Bd2Mi4U
 w2mOJCPSdfWvERcbj1BPupGSqkYqrr6gSNFoyg83Fon8UgZNV69JoFZPXdL6dZoz43wg
 CmqOBYAPRNU7RkN24zhAlPk4I/4QrZPMOa2qY2xA9Dj/ZlZi8VW+S3ivQCGY8YixNwA9 8w== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3nfnnurk2g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Feb 2023 22:58:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2ZxrP2Ylska3ilNs0GVEs33/+K9VsztlkmE98TNZN208jtLzAxrUznj8fgiALMCpxZ/5LQdgPipyeQPGQc66c3FVpZoTZ35cZleFljH9Kpi9sOB2u78lzanvDaV7QQ4GzGTSsbLSINi2pd5CvDVAt5Hv0iWE3dl3/QJGbVcrPaTxAtHuVPFBbIKzubzmUwlUSD+rTjM09X8NDBnkbyld0lrGtf8kv5rejya6LAWRE+TFLFrmFRv+J9QZDeTBn+F0p+dtHhT9hXKEHBKN2AJczdL+iOLK51OlO/TurSKWTUMfAvTCU23VSBHy4Wg7a5xNsoPF+I7FMp33twiNIAb2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNb8BfVfe+f8kuaaqm7HjluDtfZI/LcbzWH9gcdIJ2w=;
 b=AZsqdSLRP2iDuQQ0/j9TjDrIWLYiO9VMylNpEB+rBrfX3LNRXDOk1538qz+Cjd5kNG1Dc4O+lfIn83OLjMlpKdwTMwbMwXTOec6s0hMTnBBUq0aNKqdN5vh+acL7xOOKWgT1DTSxywB42hIcS29aYgDkW9scWfchnoRdyv7AbjhhxKbb8KPg/T8HnH9i46LHE1qWtmS9h8xgpL0bW7PYGkcVtq+ck6q9y3kahWE3BClALVpXutT5ru4zj0Vzb/dlfa9zb6DwH1AF/9w6gLFnatERkh4XGvpjmDMLucE60NXK/6oNbjlxJP2ynBs7LXaBGYwHXwfXCSJbF9ogbUlNsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from BYAPR13MB2486.namprd13.prod.outlook.com (2603:10b6:a02:c6::14)
 by BN0PR13MB5152.namprd13.prod.outlook.com (2603:10b6:408:153::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25; Wed, 1 Feb
 2023 22:58:41 +0000
Received: from BYAPR13MB2486.namprd13.prod.outlook.com
 ([fe80::6785:c6cd:c4e3:d0af]) by BYAPR13MB2486.namprd13.prod.outlook.com
 ([fe80::6785:c6cd:c4e3:d0af%6]) with mapi id 15.20.6043.038; Wed, 1 Feb 2023
 22:58:40 +0000
From: "Grochowski, Maciej" <Maciej.Grochowski@sony.com>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
CC: "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: RE: [PATCH] nvme-pci: fix resume after AER recovery
Thread-Topic: [PATCH] nvme-pci: fix resume after AER recovery
Thread-Index: AQHZNJO7eIWmvXplpUaRY+6lb5hHeK63SiEAgAACMwCAAO7iAIAAazaAgAIPGOA=
Date: Wed, 1 Feb 2023 22:58:40 +0000
Message-ID:  <BYAPR13MB2486C8E796FC7EA0A8C6EAC981D19@BYAPR13MB2486.namprd13.prod.outlook.com>
References: <20230130101449.1772800-1-hch@lst.de>
 <Y9gN+FsDZQBcKJvk@kbusch-mbp.dhcp.thefacebook.com>
 <Y9gP0MvNpC/dgxQn@kbusch-mbp.dhcp.thefacebook.com>
 <20230131085828.GB3139@lst.de>
 <Y9kyIzTi6/7hsDsm@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <Y9kyIzTi6/7hsDsm@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR13MB2486:EE_|BN0PR13MB5152:EE_
x-ms-office365-filtering-correlation-id: c9c7060a-34b2-4939-cff4-08db04a7dc30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  TmGrBd6v/nIQkQ09XXQgqHv3XLa1o6A5TFrYAQiSO8aGD3REc3T6Dab+x2jMm2AWNe8jXdmhilkOpq7a400jf4xbx0DesjStzvY3/UA85GnyS753rgCwORmHCPBObss6rsGy40+YmtZSTZyAJs00BjKzWy7rZWBSmEmGpsZP7agAw4ZMItYLO+LLu2pr4O5MLDNB0iEcYUrLGLQEzLMFbXBJq6n/3ViEQ2IJe/d8beadIB9ARPC8K29kkpe+QGvzexyo5XfVIzC2kayCAW02RS8oQXlSmeJjiSxg3Fo/tP9jGI6dQQhr71IQunog3uJzytxGuiYyzWw1zVKvkUN10o16dSIAD1IVlrs9BTHZ7KYiQMRWhqQxjA4qQFWbJh1Bt5y+eIuokwBc+XF4WA8MhkN4ID5JtptYewrID7uKWOU01/lKVJe0D6V9chz5xoZSWPSDyk4X+kW3VebqESOlAB9Li14z6wJNM+XiV+HSe3Mo7bcivFBth+UZfERBbWFJjaV9oLzMxA8MLLMcxJXmHh2TXlWUjguzeMBd5+EAv8uhlmnz7Q7GsHlZLpzjOow3OEJHHv8D5zyoRh0yzz9epUdmji5EKlssDpISh6DZ3ZMFXulb3snQXbEKY+UsLl9w/Am9Leu1CoVFBlY3EIEoI5x1+2BHKMPOUy5GBQ+8riO9RLbEC0JVrEQJXJeVZKjaZVi9daRgKCWGrHIZmJequikEeRyXG/EIem+2h4/k3fqF1dauTZEYWPWZLxmkCu+x0riYV3i9GBPzrwijXYuIiQ==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR13MB2486.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(451199018)(38070700005)(122000001)(38100700002)(86362001)(55016003)(33656002)(82960400001)(76116006)(4326008)(7696005)(71200400001)(8676002)(2906002)(41300700001)(52536014)(8936002)(110136005)(54906003)(5660300002)(316002)(83380400001)(66446008)(478600001)(26005)(66946007)(66476007)(64756008)(9686003)(186003)(53546011)(66556008)(966005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?v4qq4oME/CtIrxKyvn+0G8vy5goSr2pXVDt/4tkLtwblsEXOQSHkQPhQObd9?=
 =?us-ascii?Q?trpHdQhcLrx9MnC5e2Au1WuWP68lRySkiSEsohDgOTX2uAbbQTTIcwB5K6KI?=
 =?us-ascii?Q?9FP6prU/seTCPvUrqqItdte3wcutGL+8G1EWkjirs6R9XS/PkG+3QFh0CsQf?=
 =?us-ascii?Q?Lk8psVx6OFymcTgBJNSTbJf1cNFQ2KARu8+j2VKjNVS3YzrA0Oa0BF2yhhNe?=
 =?us-ascii?Q?x9cdWsLmXpm+1I6KHERfbErz4bWtYDeAAgi38479u4OLrWkAYg02lS3e2gOT?=
 =?us-ascii?Q?8eC6gqQiAKx8JnkxvzIuVKuhOzEscfmqF68mv1IvSmga1X34Rs27ndwVDhnx?=
 =?us-ascii?Q?LBjMABSrB6qXATeFHnIfC9l2tcYQozdhzEcsH3YsOzqbF3GqRYQXtXotYmj1?=
 =?us-ascii?Q?oGpf56iic4r+DjosAeXQfRSI1xFPI053bB35b4MFRmizcA0PBVi2TVxsiE0G?=
 =?us-ascii?Q?YxfMjlHn17Grjxq94r3ZXYaxYcyf1k6Ov5WxqDMd02Zxn65odUWU2lHpfQOp?=
 =?us-ascii?Q?fZEnD8EjbgZjCE/x6Q9ttQk9k7yiJtFHnakobI+rMbWtkolPivtp/ageMw7X?=
 =?us-ascii?Q?1oNXWUtVJpWCsk5lVpTSmBx2PdjPM1UsHJUElvzrloe76eV9if7LEcRZ5XXv?=
 =?us-ascii?Q?N8l7jh2xHy9ZmcGJx4k8ENfdWkhgD9tJiNRL14mK9v8uAIfahSkKjo2V2dsa?=
 =?us-ascii?Q?tTCznvxZujGZxX4NwOqEqioTILzw3eZuuvxmRxio1bIUwEQZhjNfVoOYDdql?=
 =?us-ascii?Q?uM18lKM0+OVyAkd3wB62JXn76iYh6imNiEsoiLERETG3shXqrL23+BFdE9Ru?=
 =?us-ascii?Q?hVfGXV/Z/2aAA7kpmAdyxpoER2aUEHGpdlfLOt/PUVi8CBg3ZYCDiEqfYi4d?=
 =?us-ascii?Q?2LREzM0lM1xxRkDcIjok7Hnu5XzkiJSFvZ7oYXwJ6SUz6+NglJhW0Ht8fwc+?=
 =?us-ascii?Q?rAEyJ0/R88vnXH/qqsWlsLmI/0lAEPcxetvb/P1dmjX39uKN3r9Fy9HL6S5T?=
 =?us-ascii?Q?JqcLJO0697Y51Hne7jq7wUudb6+GO1upNfD5dM3labxFitJefi9IoyN3mjjS?=
 =?us-ascii?Q?8y/v7o7AZ6XKgOyrQdi/aciCcIFotTgRJ7hnlBhLBqoofsuQXLBDCuUKjFR0?=
 =?us-ascii?Q?UjkUJiMOXY8CxX5fV0DDN9yIli2ODnyJ+ExBhQlcJU+2jSjEcNyideRCBiuk?=
 =?us-ascii?Q?LqCrgvY6Bv6e8MzCImEO9R6r6kqU112I7JQW7Nc970Fv0q1dOB9SoidsApOR?=
 =?us-ascii?Q?AF8JI08jABCoPZacHE2QpVjhVqtDGu8Zr9j50E788KVq1f3dDNF41OpOiZfw?=
 =?us-ascii?Q?j8mANmv9hOOobVNr8DbqDPu2iiD/Rf8NGeAgiQx4UhymNe4OJNYyXW1gJAmF?=
 =?us-ascii?Q?PNgAL96rr1MJ8Sfivc27HqjPKPPCCsZ+HwZgNh0Vy44iUrCTljl6ZMcIwswe?=
 =?us-ascii?Q?aFoq+Bg4yMK7btoGtph5FOY5QDp54oN+J5qJF4ZP7ylhnLKw0sNYeHF36WJq?=
 =?us-ascii?Q?H3D5mZmKm7kOyhixgVkzFo5UbxEoLk6m1tZxtb/Zf0GmGr7NwRNoSCdaAa2/?=
 =?us-ascii?Q?xRXJ/4Rkw4FiKxphOOOOpx1+HMgIl0h9mCBnb5zy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	YGW+eyTMPii8TyTVNPDtKQyXDO8DeLjv5MA0BRz1gwTD0IP/ZgONKSH142RW0oNoF3xpceU6afA4PSuRsywC0jic6IlmqABNPJEgvbVEXwizh4ww5lXLl+fIXOHI3DLVXbPhqKvYtWsvkHX7AgQj/zUAdnveAnRgaA55bsGZrvlqH9/pBAAoL9Awd6zRPE3LeUtENhXZuIU9+WpmrKM9V+z6t8rpZ3dPji6mPUleVw8Nwe4lqVaXl6pXN0AkH+r5pv36xTRrEp0vfKrIvo0200olBS7GzUHVYaFKcqWdlWrV1mbcp1e0hs8wBlknejLy7JHi/GynGrPP6a2mIFcJrq38uvGVTxJ3F/0v+Zpk2L3HPRwkGO4DZEFhXQbpJgunH0JC44fb2IPctUZlTYsOx4GteDMwYPnqSyrB0ae1/1yprwzOqMFWIphvleODtamkT5ypKjOOCBrYRRUmclSqBSnWS8P0RO/KarItbWdLkaN4TxtSABm8Mo8fQ83huA3jiHxzk1kGeX9p7SGcGsf/GWVfULBTT8alWLWBZ3V8xmcE/2tk2SUsyu6opcj/Af5McXFD0DfYZCwpbkFkoVqMY5wvWUz6V/cMsOQK8X2Vwbh2iV5J1gpAZMfyMR87NLAFXh5rzPyTfdvh/XBh8iTkME7GnAZCKeKfqkEvQghKt9bASAwln8mWbXVDS6xG8Nutea/lmGi+Re3odRUXvLDPy60wqQ3Q7se1WsBjiyC4fP0uRfaMp4ueWCAIJszqX7+b2bgvcDx75QlC+y4zukAxhswxCTpaXTDic7YHPL25OceWoLn+ULi7uAjdK1JDX6aD4IHVEiLfmJvehg8i043STd2iRUxuzhUsdwaLDpOpt1kWeWnlEEoYCVpL5H0W+bby
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR13MB2486.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c7060a-34b2-4939-cff4-08db04a7dc30
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2023 22:58:40.2668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FswZZhtzmfG3aNZJlHlpbBgxqvq9JKA/httliNaIfHZwNmX6apScNBVHAfFLTXJLAmzxj2Xvqt1VjZz9X/AHIENN5V0iBGNKdPB4f1whZpM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR13MB5152
X-Proofpoint-ORIG-GUID: VA23wQ4rAkeaPue76VNJuLd6gyXswF68
X-Proofpoint-GUID: VA23wQ4rAkeaPue76VNJuLd6gyXswF68
X-Sony-Outbound-GUID: VA23wQ4rAkeaPue76VNJuLd6gyXswF68
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_04,2023-01-31_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230201_145911_091969_8A64CCAC 
X-CRM114-Status: GOOD (  25.55  )
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

Hi Keith!

I updated kernel on my machine into 5.15.87 sources and I run same experime=
nt with aer_inject tool.
As a result I got followed error and nvme disappeared:

nvme 0000:02:00.0: can't change power state from D3cold to D0 (config space=
 inaccessible)

full log
```
[  679.061060] pcieport 0000:00:03.2: aer_inject: Injecting errors 00000000=
/00004000 into device 0000:02:00.0
[  679.061100] pcieport 0000:00:03.2: AER: Uncorrected (Fatal) error receiv=
ed: 0000:02:00.0
[  679.061111] nvme 0000:02:00.0: AER: PCIe Bus Error: severity=3DUncorrect=
ed (Fatal), type=3DInaccessible, (Unregistered Agent ID)
[  679.061115] pcieport 0000:00:03.2: AER: broadcast error_detected message
[  679.061120] nvme nvme15: frozen state error detected, reset controller
[  679.076520] pcieport 0000:00:03.2: pciehp: pending interrupts 0x0010 fro=
m Slot Status
[  679.076528] pcieport 0000:00:03.2: pciehp: pciehp_reset_slot: SLOTCTRL 7=
0 write cmd 0
[  680.103638] pcieport 0000:00:03.2: pciehp: pciehp_reset_slot: SLOTCTRL 7=
0 write cmd 1008
[  680.103660] pcieport 0000:00:03.2: pciehp: pending interrupts 0x0010 fro=
m Slot Status
[  680.103670] pcieport 0000:00:03.2: AER: Root Port link has been reset (0=
)
[  680.103674] pcieport 0000:00:03.2: AER: broadcast slot_reset message
[  680.103677] nvme nvme15: restart after slot reset
[  680.106193] nvme 0000:02:00.0: restoring config space at offset 0x3c (wa=
s 0xffffffff, writing 0x1ff)
...
[  680.166532] pcieport 0000:00:03.2: AER: broadcast resume message
[  680.171640] nvme 0000:02:00.0: can't change power state from D3cold to D=
0 (config space inaccessible)
[  680.171825] nvme nvme15: Removing after probe failure status: -19
[  680.177638] nvme15n1: detected capacity change from 3750748848 to 0
```
After that device /dev/nvme15 disappears /
Are there any quirks that needs to be performed for certain NVMe devices?
In my case I use "Samsung Electronics Co Ltd NVMe SSD Controller PM9A1/PM9A=
3/980PRO"

I tried the same experiment on different AMD platform with  "Samsung Electr=
onics Co Ltd Device a824" it give me same result,=20
but when I did this test on KIOXIA NVME "1e0f:0007" it worked fine and was =
able to recover.


-----Original Message-----
From: Keith Busch <kbusch@kernel.org>=20
Sent: Tuesday, January 31, 2023 7:22 AM
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me; linux-nvme@lists.infradead.org; Grochowski, Maciej <M=
aciej.Grochowski@sony.com>
Subject: Re: [PATCH] nvme-pci: fix resume after AER recovery

On Tue, Jan 31, 2023 at 09:58:28AM +0100, Christoph Hellwig wrote:
> On Mon, Jan 30, 2023 at 11:43:28AM -0700, Keith Busch wrote:
> > > Why isn't slot_reset being called after error_detected? Driver=20
> > > should be returning "RESULT_NEEDS_RESET", which should have the=20
> > > pcie error handling always invoke the slot_reset callback.
> >=20
> > Are you using an older kernel that doesn't have
> >=20
> >  =20
> > https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/ker
> > nel/git/torvalds/linux.git/commit?id=3D387c72cdd7fb6bef650fb078d0f6ae9
> > 682abf631__;!!JmoZiZGBv3RvKRSx!5wLCu5dVEfcVCU88GB-KhvnD4nWEP2QiJPMbe
> > oDDQSvL03dI7O_wXoRKBzAEF9o23C0usSRp8QqIloxstMc8$
>=20
> Oh, that does looks like the real fix.  That being said, what is the=20
> point of flushing the reset_wor in nvme_error_resume?

It's so we don't try to handle a new error or remove before finishing recov=
ery from the first one.

