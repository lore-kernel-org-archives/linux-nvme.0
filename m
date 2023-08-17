Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF46FC05052
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Aug 2023 02:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=30Beq54q7ADpDnC+tSWlstg3shUN0pO2iAl675AR83s=; b=eYA7ilJTvxMtyDhW9el73G9UQG
	RLilr15mSwHhH0ycMED3iKvMeOU5+lcd92biWoRyGqzaUeEixfFrsX/Ae2KGXWvD3fv7yPklZxLXS
	3TNvnWvo/+ouLSpXGyrC32qoCrTth7DtArfg2hE0nNY6mSZVERMZGlJ09pfgf15Q3qg0bBYnc87nv
	uGSEpMrWJVSJJTqD6zT5srw11YtU16B93FYJFk2hu+37+Hd1IWQxvjEeZAzNxARrH0efLB4EQ2ZkC
	V+OFEj2IQU9X8YacxEFu2kzaSIyAudW5UoQ+3TD/7eDbvvpSZwlcgNb4Zi+iNRe/rBWtmqUYWVAhn
	e/k15/Sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qWTAl-005P3h-0r;
	Thu, 17 Aug 2023 02:55:43 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qWTAh-005P3B-2V
	for linux-nvme@lists.infradead.org;
	Thu, 17 Aug 2023 02:55:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692240939; x=1723776939;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=30Beq54q7ADpDnC+tSWlstg3shUN0pO2iAl675AR83s=;
  b=Uk38o2DT8HXSWS5gxZkLwMjpZn6OpulYqfhxi56IdTde5FpDdWaV9bFv
   ChGp1GVHsE9ONLCFYklzaxOgxxXXfKmp1CNYo20qh8OGAX4KtB4KhCY8T
   7y8QVC8CkO5jqY9xip890mNOQp2yY14Ed4WDASVWup20y+xryOUAIPNnw
   09UdV7ZmN2+Q9Dy4qs8itsMmxbnngPE0keHqYTY+JOZBQiqUvtuzS0zDt
   tyrz3N5/sFnM7/K+m6cU0hGkPGpxbrIk8S29uSPGzlrqfiNeHqNWcg7sh
   fL3lnYdSYV7RTonVt5AD49z/aJJkg9iOSlfNMUoE44aDXnKf4j5KBwXS3
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,178,1684771200"; 
   d="scan'208";a="241218473"
Received: from mail-mw2nam12lp2049.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.49])
  by ob1.hgst.iphmx.com with ESMTP; 17 Aug 2023 10:55:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKh3vG1QROvmbBbxDo5AwbGcWoVRFl0h6Xqv6JD78gjpSoWTUNWktII/qur0J/cakwGQQgL85/1dkYbVRwxBrDPBYcSeRoXls9+nP02HpClz24vK6ZqeVDZ5VDVTj+mAmv+W16yAlgT2JmfqNah8rmlEZFGKSjpd1wk1VrR5PuGghB+UpuVUs5zvVUrTPbZothMvummMh87Gdb/Etu0CeN44D1R6Es7bMDJyzu/KT8DCiKexUFY+QOtkBkGIRsVwDnXRxVpc5EG93+jcnvojWGg7FISW+s8/TcHPp0aVU/ZJmlfNKDW6yLkGfAXoq73ZbUQTGmgXC4bP5/a1iURBsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30Beq54q7ADpDnC+tSWlstg3shUN0pO2iAl675AR83s=;
 b=OYnryRaDwXMibp1MqaCnYOOQxAiVMugmrg9fUE9lENxWYerM9KYSZh46MiRFpBDTb4xdJpV6a8YzOKiRm3A/V0CGZm+rZi8PLL8HjWuVsqa7tCF0KpE3i4R6ZoAC9eMxqmnnCplF/BwysFmz0U2sM+QjL4gpR1A27IQy3hk9Yt2HUvyveKlAo2boB1PqVD5u+7lWtopcZ4/UM3P4rE8h9MQEFl8kEaQPLW+UCEil0s7lZ7P3TQY3dDq+hocC0qAjhD0F61ZRUfheOs+2qcHR55mk5t2Ah7wFqUDTXhwiMcpZoCmhS4zcpNMLF28xjnhlvstCC03Zs8v/gp07vSK+kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30Beq54q7ADpDnC+tSWlstg3shUN0pO2iAl675AR83s=;
 b=W0yIg6evDlWjpHYPMwGRhdxwwPVW57AaVjtMMudsaRjaqfN7R6y9gwcOzWB0Tg8OS3sNaeFBVnxmaKDh+TuOc5xJxMGI6zdOstxagUFBjURXTF9yN8W7PVXnNGbrXLCeIrdvsitRSbgIMXvTEc5aBZmufQGYAyBhh3r+W/0cSEU=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH0PR04MB7429.namprd04.prod.outlook.com (2603:10b6:510:8::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.29; Thu, 17 Aug 2023 02:55:26 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9%7]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 02:55:26 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Chaitanya
 Kulkarni <kch@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, Hannes
 Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>, James Smart
	<jsmart2021@gmail.com>, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH blktests v2 00/12] Switch to allowed_host
Thread-Topic: [PATCH blktests v2 00/12] Switch to allowed_host
Thread-Index: AQHZy3uxzZvUupgtrkSugC1ZrGM0Tq/kn9aAgAAMToCACSlbAA==
Date: Thu, 17 Aug 2023 02:55:25 +0000
Message-ID: <glfjkah5e54ymq75lp46akttuqrsccigb445nchcpe4ahixzxk@5al3wjxify5d>
References: <20230810111317.25273-1-dwagner@suse.de>
 <xpoocad2nthor6naxp35h5qiz3oqxpijp5qds5qao6aguh6fp5@6fyygawm7kfq>
 <2u7xe3szftmoeicayxahqt6r44lgkwl6owvmlkjpby4mqvu6hh@pq2gfkgw6p6e>
In-Reply-To: <2u7xe3szftmoeicayxahqt6r44lgkwl6owvmlkjpby4mqvu6hh@pq2gfkgw6p6e>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH0PR04MB7429:EE_
x-ms-office365-filtering-correlation-id: 345f93c9-6547-4dd7-ba3c-08db9ecd6867
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5G+lssk7XVsiXGv8rxnkPhwFdjH+cM/i/8jn54B8eMP/4xC/UvdtitOvgtpd4V1W9/2aJG2DywvmrfGtVpqd7JDlW7G57YBCF9BNDTleDajxojjbn8PWqI56y+lHCNFoLw4iPycYHHoaum4NCwpmoW5UWYf5RY79YLWDc8R29wOKc9gzlEOwS0Op2dwi+6FlmpM9NoYNEoOVcVpVQnn2VEk754v1i+Vo873tNFcMYWCeAiVi7rTvpplZwnUOxyrBl4OZ5T3O891SotanOdTmRd+paNKTUDTzZ5EbYkxNJEZPoLLktqR+sUF73IkY4pYao6XHT9djSGP9rCclJcXmW3sYP8MMLH+VSjvsrdHAuiUQtmyBKm4EYfQ7aS5jrrAZC2OXh5Acc3KAc8ZtbD+Xr7XSbwvS2ljxGFASqSXLi4xuQ+U5C+vE//ZLslm370ADwy5BD79iLL6D+YD3XBrKgabGRGyng+wo7OBoFV6LTsIpLTleNlhx6qWjYdwKS8Lfvx74PoVzQQ9r3icpd1zwVeWUV0yj8UxgGwveL+CbtFs0nYVSqFpw1/WB4KGrv7YusLxW2j2tk+0jLFNV1Rc2Il1hJIHaNc1qr8RJiduMt5A+tiQiXeI680NsZn9xHHvS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39860400002)(346002)(136003)(366004)(376002)(451199024)(1800799009)(186009)(316002)(54906003)(6916009)(91956017)(66556008)(66946007)(66476007)(64756008)(76116006)(66446008)(122000001)(5660300002)(41300700001)(44832011)(38100700002)(38070700005)(4326008)(8936002)(8676002)(33716001)(82960400001)(26005)(2906002)(4744005)(83380400001)(478600001)(7416002)(86362001)(9686003)(6512007)(6506007)(71200400001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fs6xS+Hvd9yMqALbMGejgOXOaueLgym3hsQAuKTXJPsqPRdg+QCGhRywOURs?=
 =?us-ascii?Q?FQYtWR0RkZOnobNov3Zp8YzPIAZo0CWFLE49S31rG4uDKm6JLT9EbZYI6+w/?=
 =?us-ascii?Q?Y9IGFTTOdBMvqiY7AEgiUUw9QmhX+XJvyeuVy9MROvzxLKDgG++Iyt5wU3Gt?=
 =?us-ascii?Q?lSvMplxuT1OM4b8LlwGLk5ep3tBpMAhgoel5PcT75NMvVF5gn49ci13SJEsd?=
 =?us-ascii?Q?kX21ytK9ux78JLY/PAfAeW0I6KR0IVmSetFiqjvVzqxKvdqkAQ0DhODyCvXf?=
 =?us-ascii?Q?gavMDJvAYDgZykA313QnDk+J4o5SUX77Q3KiryDvHTiv4yK3gdnD+L0zIygo?=
 =?us-ascii?Q?LysEFCyXp+06n7gKtmD+hNg7yvEtyZOtdG9uPFruCzdt29axPT1dHS2+dJFn?=
 =?us-ascii?Q?1JkNbHnxr73TKo6zJBNb1hchZTdNPH18iS9J9X+n0JOcp4ZwTjWBrdccncgG?=
 =?us-ascii?Q?fTYrWkqru9PeHXVJMduw+jiblf0nL89UMnwV+AJF81SjZux6ZFuClAMaevss?=
 =?us-ascii?Q?hqJ5uVz+dtlAEKCO2utk4QJqjD7Ui3AurK2wdV7s8xDi0ANYySCOPtelBTfE?=
 =?us-ascii?Q?ZpGdxKmhQivHeL9Owpmw+J2iHGOt3H0OkKnAytmIotWSySnfQu8WeB+lwWw5?=
 =?us-ascii?Q?KzsG1VeI07igOJQcUVzBeCfDRqALdi1NnDonKbfwsplPUq+hNZWdIHLD0koz?=
 =?us-ascii?Q?aPUiwt2WBNzWgfCV+Vs6QaNYHo/b8C8PCss1pRfOC9k8IQGXglffRruf7l6v?=
 =?us-ascii?Q?0H8uf6D53GbDXDelXTs/7ZzI4mX9ciAsN6byu4Au9yr+WeWdmhVZPSMZaW9j?=
 =?us-ascii?Q?Hl/Ws19Mye/ux1NrpsiWQ4C7SKAllE3ftIh7QF03iht0rZbWwOjJURrBD/nd?=
 =?us-ascii?Q?7+GjgFRFjbJH3ln25c2TNgR4rgKM22k4UsFkBBCRMMP4BWHDdHncMLejSwIx?=
 =?us-ascii?Q?iKdQyAWVXbBmBb6UxOCQ3D/J1Nu5uw0N9DQYuwzrM09d0TeecJLNPDdqm7zf?=
 =?us-ascii?Q?lBPtu4feYZCqjPGy9cKUAXjUAnlz+aJXaFwyMcUk406/AJjE419xc4fWw1SQ?=
 =?us-ascii?Q?VXbNFCHYeGBJnhtciUJh8jWBvjXvSz2dDfYiRkVUcd0EvRXSS0z/jxjOb8c2?=
 =?us-ascii?Q?LviiCZ96qrlDq2hTvaKn45Y7pleHyruda3XAuKL1on/Ym0tzExaHYhRbyBpn?=
 =?us-ascii?Q?cLuGdu7rr8OTIiYwrf91f0f7w9QuM6Dqs/Hq+WdFq1ie+x4KVjc9drbeJ7Sl?=
 =?us-ascii?Q?+iZ3sFjsGnB2jkTe3GOs+9up2pXocwZ3S/yUEbmKxkOmiNBz70nzFb3NqXmj?=
 =?us-ascii?Q?hQ26VRyZT0H5i9s/n4xcuzVxb5k5mm1oW6hcAijCLlBnAhJPPOo5qKC55eMW?=
 =?us-ascii?Q?AyZsHE40gKb/GnI9wh41w7xvElxQkzDwNq4yifLOvbXuCENrhvpI7Ihgwd74?=
 =?us-ascii?Q?6Dy8mluT0DwC0Zy5MbhhjGRTtkhlSDdGggKrtT9VLVBMT3qLF+5Cy9yyesea?=
 =?us-ascii?Q?S5XlqYL6hXMCkRJMxsxpLjtCiiffYgwVA37+VngghiXnTDn3fPIRDd6nZR+P?=
 =?us-ascii?Q?g4jmwbfabRP/ZkUso6B7ydreSmtk5NMZ2Yt50Pm0YZES4aPnVrdY3msFR7XN?=
 =?us-ascii?Q?+Ujz4Lr6/cs3emuiuppj+y8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FC48C73C72C338469C59890FCAE0B430@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ilg1QekVhuiyhpzTOrpYrizydo+gwv5FafgiBg4y53v0FwzIVGNsweZVXwue?=
 =?us-ascii?Q?fB2HW7WpROVlj9ksLndqsUq3b90JL2RQqEidC15axm0iPQK14WRieE+EHvJA?=
 =?us-ascii?Q?vicWUklkwnGxY1zGMnzTI2jcVkxw3jiP670E/qB4JKQ3ey6LfXKLgYACbJcI?=
 =?us-ascii?Q?FmlAyPLiJJEsOWsolx1SqadSocxsE4rW6+zKkcLLig6hiSigHyxdofpjw6GF?=
 =?us-ascii?Q?ijUI62UAbo8Jy8ii6G4NhEvFYYSJLwyFDrfmPSR+AAkFQpRNse7rINnExJv9?=
 =?us-ascii?Q?QgKqs/XzhkY0XgFTqV5CeD4icG1wIDxc9cTqDZ/Hv/aF9i4TXU1Hjs7iV/0b?=
 =?us-ascii?Q?dIvWrxi1/aP6TmKV2d4D9hlW6DkthGT7SV7PiEFKW37KL+JcGyogo2QPPQu+?=
 =?us-ascii?Q?zY6pmOGp0badEC/qBdWb3Mk5M1JU/XGfuVmJ2lcY3gJw09nnlUDnKlfu9I16?=
 =?us-ascii?Q?CiJYEeYcd8oh2gUHIFxDVBQb/lf7TyVjPpOOZ50pYhZPA9Of2GmT2gKh1SX3?=
 =?us-ascii?Q?2S7elaglYp9+EWWOdw4uCB/Ifxuii08PYq+E2JVRvfKF7ZpD7nAT918wHZPs?=
 =?us-ascii?Q?gBhHKa9u8QKaQNqDJHaUfATk0ZfhyIwzpAt8FK9uC4jOh6jGA6qm+p7vfSg0?=
 =?us-ascii?Q?VHdQh/v1mcTza9awOnRyOjsh9lPd8ngwaz6TatQ2rvbr+yDzJibyszVo+SC/?=
 =?us-ascii?Q?T6zyuK880UENIrbgtSahazjhMtsuu7t2iX0s+3WjMYsP5Rsz0HBNLkAErKTk?=
 =?us-ascii?Q?KziRrMnrsAs7fa1n6stDJ8eRngPShOP516sHyDm//Gx7QuG8j9nTX1fano5U?=
 =?us-ascii?Q?57oD2+Zwf4YI/oWdf/kWsMJIzaScKEcen0L7cNkUwICSSKS7uiaYQqbOY7Ja?=
 =?us-ascii?Q?d23uE9JspBo7l9IT8GCbAy5IcUteqqogePTBSdD1oYcNsTHZGauOyH8sAuEe?=
 =?us-ascii?Q?/38rkXDVtL5t8Lsp8FkFVw=3D=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 345f93c9-6547-4dd7-ba3c-08db9ecd6867
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2023 02:55:25.9682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qwwezbtBxUg62uva4/CewFmf/qwVNvcC6sphbX/ntfnCWtRWAnhqgrft4DpRd9OIpq/0WDTU8JqujBBenZaLB/FHEBtf53TT/uDyIlS+r1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7429
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230816_195539_960518_769E9EE5 
X-CRM114-Status: GOOD (  12.75  )
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

On Aug 11, 2023 / 09:00, Daniel Wagner wrote:
[...]
> BTW, what do you think about removing nvme/006 and nvme/007? They are
> basically doing nothing anymore except setting up a target with either
> device or file backing. We exercise this code now in all the other
> tests. So this is bit redundant IMO.

I think the test cases are meaningful. They confirm that target set up feat=
ure
is working good. When other test cases fail, we can refer nvme/006 and nvme=
/007
results and see if the failure cause is in target set up or not.=

