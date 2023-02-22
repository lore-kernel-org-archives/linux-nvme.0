Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F4FC61DA4
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Feb 2023 10:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KsSsmfeFUDOQt22ocAiq0qFh9VwogCdTgUBzCZVgYK0=; b=W9SFxREbze+KPJBKUgPHQ8CYRc
	RdxsBCtkkqcec/ixjPXLhQKwysfSUCVJmpTTs+PnOP3OHzCaAS2xtSG6BWg51U0zQ0efyFcY5HtH3
	FJg5xm1i+LtTG6dhiZT5dlXBtbCsf5u0mEUPAXnFAS48Dj01dnYEg+s9C7BQDzUF7NCa9VcMsdrL8
	ikXwubMVC9avhqf6wP/z0vbxbr+zWQeQmmZMjqDTClfGwcjhTLFgpeHcMhtazVuShDN/OW8bIUIQx
	FUKK73ynrgxOUlPEF5nqX6sBxyub3RFHlJAtVb6Fdc8xIktTlqutAhBwYyp+lgZlkwyr6F7V4WWqh
	zInsOp4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pUmiZ-00C4w5-R2; Wed, 22 Feb 2023 10:51:23 +0000
Received: from mail-db8eur05on20707.outbound.protection.outlook.com ([2a01:111:f400:7e1a::707] helo=EUR05-DB8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pUmiW-00C4tj-M8
	for linux-nvme@lists.infradead.org; Wed, 22 Feb 2023 10:51:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MeRi9afuDO88tHVjglyU8Ulq6MA9nopzERh/bdH1TxAgBijuNI4mQYexPuWQESQXyxEJrNpuAPgfohzYWdAxlIMBVjlgtQuSfapiuWrlAY9Y4xsPp9SFIb71nJSWbqz9jhlGRVomzf/zbLcGoBWvroQOTgjl8/kB1+qzrO6xM5Hoon+ytcDt1CTiJ2faJ+j1xAjb7/O5wC497mQ1c5KIClaC7RwaNF7WoeXPLXSuDL75NNIGpKk0iRe15mrwFc/KG+dzc6uXX6ZgDIkxHe1aPzF6gNQRBJ0Q1upTYd5CJB6QSiGMN7BB+9JZTINRsFMr21nP4Su3npN4Rk6HUwo3NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KsSsmfeFUDOQt22ocAiq0qFh9VwogCdTgUBzCZVgYK0=;
 b=DBW+LYW2x4YXAVIWqpzXEy3b+wyeDVajoom96KK3DXSCUsqSopFTHBGmUNZxsNJFXwDh6clEzNiBAGUIsREDZykHYru9J2fupYOJejTr5/IQVnyYCfGhh9S36psBUOuNaN02kQ5oyhZZa7tIxYXUV5n7kW1QQoBz2wV72zBBaUOQmSMbJaJjA7Q8jFfNxH+kLUHLEU45v6T5jRQWJ/i39G+9BtBAIHFRmYWWaF4wx9gldpw0jfXNUbsai96zEMtghJmrq8BOH69zJ2k/ZEHZU8iXLnmSjmrvAnc9lVSa6D7ihoUc2rNqTVMLwpqcP4ogOAsAFoISqTxzxQsel12DQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=edgeless.systems; dmarc=pass action=none
 header.from=edgeless.systems; dkim=pass header.d=edgeless.systems; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=edgelesscompute.onmicrosoft.com;
 s=selector1-edgelesscompute-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KsSsmfeFUDOQt22ocAiq0qFh9VwogCdTgUBzCZVgYK0=;
 b=hdpOESdm8oU3rjkSFbMAguHO6dnEMsVvhzP860gj8+JRYUr8mMHJ2sTOr6C5vjlQ6KaA5vRSn24Zyio6eB4I6qTp/Yk55Yelzhkczxm9N2+fY2yccnC+fz+ei8PSL3LrEKpP7K9sL6NrFmQkN6Ap00vOWsToXTM4ms5z/tmJQ0g=
Received: from DB6PR02MB3128.eurprd02.prod.outlook.com (2603:10a6:6:1a::19) by
 GV1PR02MB8612.eurprd02.prod.outlook.com (2603:10a6:150:93::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.19; Wed, 22 Feb 2023 10:51:16 +0000
Received: from DB6PR02MB3128.eurprd02.prod.outlook.com
 ([fe80::4b7b:21bd:6058:8763]) by DB6PR02MB3128.eurprd02.prod.outlook.com
 ([fe80::4b7b:21bd:6058:8763%6]) with mapi id 15.20.6111.021; Wed, 22 Feb 2023
 10:51:16 +0000
From: Nils Hanke <nh@edgeless.systems>
To: Christoph Hellwig <hch@lst.de>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "nils.hanke@outlook.com"
	<nils.hanke@outlook.com>
Subject: Re: [PATCH] nvme: bring back auto-removal of deleted namespaces
 during sequential scan
Thread-Topic: [PATCH] nvme: bring back auto-removal of deleted namespaces
 during sequential scan
Thread-Index: AQHZRkMYu0WQZfCzfkyHvlhtPcNtC67ayQGAgAABGBE=
Date: Wed, 22 Feb 2023 10:51:16 +0000
Message-ID:  <DB6PR02MB31280710A48C19F0C0B8C822AEAA9@DB6PR02MB3128.eurprd02.prod.outlook.com>
References: <20230221222307.557935-1-hch@lst.de>
 <342BB919-6896-448A-A110-B0D248188EFB@edgeless.systems>
In-Reply-To: <342BB919-6896-448A-A110-B0D248188EFB@edgeless.systems>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=edgeless.systems;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB6PR02MB3128:EE_|GV1PR02MB8612:EE_
x-ms-office365-filtering-correlation-id: 5d41ef90-c2a1-4c67-5faf-08db14c2b924
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  XNQkkEYZNqmu4c9u6YPdQ6roIfKcs4HNq3xw5Fpw1Id2CG47JSCoidHFb3/FzI4M6ysHFdKLxo4zg/ZJoWcCUpdljdNGjDNCvnB2mSfW7s1hNE4Q9OtQlLZ3sNfuuuvJp10lJL6rEb6R+1zGe1NclybNGOnAhZpG65e+k5D8aG+Gzsu71f5bMJ8C1LP2B6fxPsmtOX6a0GDDp4kHP0cMrxfn5exBTBQ5PzUfNuv/OjnG8yJrlMX6NvjUJBsGEYe4aBFGRAc5nQKDPI98Q+p5FBF2anw/keyfCND52H4miBie9KOZgMpxVJ3hrJQ1XzoQ/fJ2x9zmqkI79W1oA31aPEOOVtmSr0KceZnXFPwV2YCRP8KaW9kWG4ucbtLLF2Ap8X3L4ykW3RTXhhPa0k832EBO9UIHdy7rGz5Robbx4/VB0aVPdhEKj5VsamD0kDdMK7E3iFjksBKDmwrcJNk4eRj4uj1ziYhNHTcg3Oop+b+Vz7miI86iiSulXpro1FXdrKKBqexTcY7bYHpyvtRoVgivlauX9NZjWzVzh6zTcXULRtmnzf+fNIMJGJMdkvTo/3IRO3Uxl7cdKmD1aSECYBsfXYFl85PgK5PTmvEmdbSpA/eLGbmR1WjVSeJNdDFxLAXUkyA3wb/8cfSCKHxbmFtQFXeVPvcPMHVj88wQZbftYaActkh9WAvqzXH9WCZMSFjOMVd2K9USR+Uut2nAT7gL/qLCrXX94BwQK5rytp4=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR02MB3128.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(366004)(346002)(136003)(39830400003)(451199018)(122000001)(4744005)(2906002)(38100700002)(53546011)(186003)(7696005)(26005)(6506007)(45080400002)(9686003)(33656002)(86362001)(55016003)(38070700005)(76116006)(64756008)(66556008)(66446008)(66946007)(316002)(71200400001)(478600001)(41300700001)(83380400001)(91956017)(54906003)(4326008)(6916009)(8676002)(8936002)(5660300002)(66476007)(52536014)(46492015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?aIFfkniPVfkQkEGB5Wz65WR5yniYfLWr85DLvx1yImMX/z7Wo8imld8gfhVE?=
 =?us-ascii?Q?IM1bs8Be1VpGhL9ZTTxO/dGf7tTXh68ryp0GuXqI/K1hiA7i6ogKiqOqrU9z?=
 =?us-ascii?Q?hVh3RWkQsstUmc1jcGz6afrxUn7XJ0x1KHdh/7VbeowNcPE1O77FyptuKTwJ?=
 =?us-ascii?Q?iowvaTBYmjiTuU5x5aD4MAvp4enas9inVc3Ng5v19CW8heMO/QeKyiUmkgwq?=
 =?us-ascii?Q?OIFUUO3JP2TitpeZgAz4h+y1bYsJ3Zf9A2lg5/DHH1Z2ZGq1l7rQ31adXhjG?=
 =?us-ascii?Q?HjEmNRG24ARtAnXTvIob3AP9bS/2VgvKYatbfF8lyfAIrfVh9bSBz424kN3e?=
 =?us-ascii?Q?F6N8n2A5BtQqCZ2QlqKpjG4RRxzKxN7wCqXo8u5Qb1DTBKTxzA+sSfth6a8+?=
 =?us-ascii?Q?U2KSaupIx77m4tdizZ6Z+wi9j24MAdRqUYSuhfAuICfYVFCXzgMh/ATOZbE8?=
 =?us-ascii?Q?3RMViT8RtfvzGsWcUebFj+za9qyLMD7mraTS7cvtF9ur2W6ARPJRw17vxmPq?=
 =?us-ascii?Q?dPbJa1VIjDaEsX4gA495KbWoYJQMZK1HEy+BIIX0FE7gl0yeMD32MmxHCmVk?=
 =?us-ascii?Q?Hpm+Piu9zdR+J/PD+E3NALuMil6v1a3P4Na5T0Vm9p5s18+gaxUZ/fBT9ube?=
 =?us-ascii?Q?jLX+Dpm5kd2pRT0Ev3O1RPiGmiEnUPlAsHKi+jL+3EtAVRPk6mtcoHByW6gs?=
 =?us-ascii?Q?lSSHjub/TbxeF1HOlk6qZCJafxzVXijBcmwYxcIJAm/5pB7VA3gxFsjgX9bb?=
 =?us-ascii?Q?3AI7JGca04FlAwsGb3KPDz1BcxDK1IJ2Gq7so42ts6tLTNlk87+aExL/VV9k?=
 =?us-ascii?Q?mY2baYvoNZ12bpXwt51RyNcNyvU2FBEo/B/rSLyfSDwfVQtF/d+Gi2AF3V11?=
 =?us-ascii?Q?O+eRlxiGZY3rOqAk2SIm/JVsO8I47ZI+63MsmNTExLnZ4VfWN6jqT2EPKK71?=
 =?us-ascii?Q?eYJp3wWHYBK6Ep93jH0cdGZ9UPiMxXNKHRTp+3Z1ozzCFcOOI1ObAEY6sc7l?=
 =?us-ascii?Q?iyQJghXae9neaoiRLX10lCqOwu0nZQqOHwLCIg8Kk42vwvbpnDaMBSk1B4qj?=
 =?us-ascii?Q?FXE2Tk3RhM6VffjkSc1uZ8Sdbr+xs5Hn7x64tE8BpYJc+ComUtIkyMJlghIi?=
 =?us-ascii?Q?QW0Iq76iQjrf/toZCecNz/MLmoOlge+QKN48Nt8BD03NXXo3vUAdejKNYgZC?=
 =?us-ascii?Q?29dzHrtKXF4ZvYIM+qUgIJyXMSifFaox1FauuD6FBiXD1asGX5tqtlGCJT7t?=
 =?us-ascii?Q?zECw3AHhD/0P11g8cxbG7ARsgFcbmvvQqYsP82tkNDazr1XTXRPYzL1CNBtn?=
 =?us-ascii?Q?8G3IrtZVelcriUdv2Fymcl1GRsN/utfXYUGcWPGaUFQcnJVR0kZVP8mDtlwI?=
 =?us-ascii?Q?/QSa4tW06HKrmkzZVAi//g4MtrJ2XQFf/c6hGI+yslCr4V8YDIslc9nzLrqt?=
 =?us-ascii?Q?o/wGY2qoqHK3rlNuvAMR3eSXuCP95KEYsytxeJC5ZhogamirO0mn9FXwjttv?=
 =?us-ascii?Q?SbgPvR79QzqVD5esj3KXsUFRutVx8xaglvPC88sski+5Ph1crhoeW37QySD8?=
 =?us-ascii?Q?sv/LnJ4knc2JGbUwh6LTBrzbYz3u0v6vLnqqcwsP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: edgeless.systems
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR02MB3128.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d41ef90-c2a1-4c67-5faf-08db14c2b924
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2023 10:51:16.5124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: adb650a8-5da3-4b15-b4b0-3daf65ff7626
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4IyBDa/8LwaDfixDAr0QrgMA+iLoR5MyJyDKmDm7m629OmSCDtO5mye/zkfShlkRk6Z6/SeMrtDntyFTeDjMhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB8612
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230222_025120_743987_0EDA940A 
X-CRM114-Status: UNSURE (   9.16  )
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

> Tested-by: Nils Hanke <nh@edgeless.systems <mailto:nh@edgeless.systems>>

My mail client messed that up.

Tested-by: Nils Hanke <nh@edgeless.systems>

________________________________________
From: Nils Hanke <nh@edgeless.systems>
Sent: Wednesday, February 22, 2023 11:45 AM
To: Christoph Hellwig
Cc: kbusch@kernel.org; sagi@grimberg.me; linux-nvme@lists.infradead.org; ni=
ls.hanke@outlook.com
Subject: Re: [PATCH] nvme: bring back auto-removal of deleted namespaces du=
ring sequential scan


> On 21. Feb 2023, at 23:23, Christoph Hellwig <hch@lst.de> wrote:
>
> Nils, this is a slightly different variant from the one you tested
> earlier, can you retest it?


Retested it, also seems to work fine on GCP.
Namespaces are cleaned up correctly.
Attaching multiple disks and detaching them again in random order also work=
s as expected.
Thanks!

Tested-by: Nils Hanke <nh@edgeless.systems <mailto:nh@edgeless.systems>>

