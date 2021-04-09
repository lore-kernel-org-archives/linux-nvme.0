Return-Path: <SRS0=kA4j=JG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39C1C433ED
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 02:41:46 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 580BE610F7
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 02:41:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 580BE610F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=XmOLJuvhdLft4kUmdZ7b09UIxzGoJy+gvGhqlV/9qOw=; b=lDkvibwMUn6xs7ujcU+WTIs2r
	xl2tmroKlBKbEA96gwYQOyHGLf1ludL4B6h/xNK/ZRA9FEfM93W/5k5oTHlLkchl/Ovnx+GL31s9+
	ySnPOrTQLoXTDsAft//Hm8UdLTbssoURLhb073SdhUP72V+PRiIDmYk+y0Y52Ju6Q861TsHWfVTPL
	owWK75clBeRZ8ptjx0CxEXBNlyzaaBZyPv0+AeUQPCt55qB0a/uUdlZPSdJJRsRFo184hI8TCARpq
	KIM0QparvkjSC89DhbYwV2+UQuvibugdtlU7nTb4+cT7LUeV4b1QqOrA/NiSInOTR9WLlJsILFk4B
	PgACKwL2Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUh5S-009k5i-EC; Fri, 09 Apr 2021 02:41:34 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUh5M-009k4d-Qd
 for linux-nvme@lists.infradead.org; Fri, 09 Apr 2021 02:41:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1617936090; x=1649472090;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=F4DkXUVV0Qoc8lHoNCgNYkJF5jXt4DysrIOPBi+wRu4=;
 b=Y1osVosrbZYDC8dUYcu1Y/I646pAemkKa4bxj+tzQo00Z4erFW0vUquH
 eRjycQ2LmJAgvVe13miRQktAWPmIUXApslHEELeCIA8v0I0+Ndpg24FP7
 U6+179IIcsQvoXYAu5eRtqFKF797vrISRVJE9fNDJmIXak90dOwo9ccWY
 erBDX6yCX3lkLos5ulHeziNUZQfaOAJpCQsY+Ehfs3znNYScSp55SjkBF
 LwZwbbKpA7JuCi0+Fy282w3tHLb5dO6U2T7+CQ0rpKDL3Cm07shcOgcGq
 D0QUT7WERwgy0WNfk0/wM2ov9kx42iZ69bTZvQt/lZepV4WD24ZEDaHEA A==;
IronPort-SDR: DZeyWqwcUvihApaVExCu3IKXm9hOvW4Y6KHkoTlSwStW0RbZPKsrdP8gC3YAIRXYx8VOKYQ0pR
 fjB2BxhA4D8R38PZ+8lX1oc6apvTTvm7HSy+B1WUTEgPRUHamwcIgug0VfuKN5iysq9JhZk8YJ
 16KH6FGblIMpP8Y958Q90bpYU0CWB5D6MC1VwvFrFXvsEGkaGHdPT/1tuUtQd0BmuVZWqesF9o
 SelD4tuc0R47pXcrWC8pTT5VvV5InidGDh1WOOwiTKHq+fv1MhhsW5f3dR6R4gzi5+sVNXPypi
 1sc=
X-IronPort-AV: E=Sophos;i="5.82,208,1613404800"; d="scan'208";a="165132471"
Received: from mail-co1nam11lp2170.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.170])
 by ob1.hgst.iphmx.com with ESMTP; 09 Apr 2021 10:40:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4Cbg9/vQ9ETPHPG/a9VImgYkVcJEC/FxqzMDbqcSkx9qEJgzKvzvR2JACzklYTT/2B5R/2lvPVBSF9LblBhnw7sy1rzKkY2nW5MsB+owf4btI4C87ZVFBA5RqkY4yRojaeZO9zS5cA683hlJPV6S3XGZijxuuF/sd2cYMMM2jltLBL+f87V5Yn+rNh2JBuAwkEN5ZqvdEz5thAgQAhOvMNbtEKvbNB4j8Sh0WVk7a8x+NdqDNqscAUIHtYwyjPj+pUYdAxgsugIl5g0/lrSAKpkyg8icskAKZIGjpJ2XAmTGrzGSO4DWpkh78pSKADRb4NLql1mMXIqD0dQY8rNdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4DkXUVV0Qoc8lHoNCgNYkJF5jXt4DysrIOPBi+wRu4=;
 b=TzgeYxAfTgZrzWPcaLDrdF0nYIvkhlQBtvN/nUvuwXAiMh9TyIr1jKBlboxXHzC6BhGxOyq7MqWmFtwulOgdfGa72shN5U1X7zDzbzX39TCwCeP5yBfpWqd3CM+sGcEQ1ORpymmsSdcoRE7IF2hqgB7NyaLgCugFhx2JEa7+IGFxA9fwKRqocusH3mvtCqSruwjz74l1pgy2i42WL3XoQk6xLOxnWjtoE4xjnsYOu+wWHF64EK3ahlq3TRhNmhfrDU8fL6lg19hR4xfR33ug01whF7df27AKtwB4ogQUE+PphI/8ktEnvwLewWetmZtbJ5wbanXiXdzxkZjFnWl50A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4DkXUVV0Qoc8lHoNCgNYkJF5jXt4DysrIOPBi+wRu4=;
 b=e3SWM4h7JURC7kZwCtNFe1Fz2WZ/TS8j7n26a/7D1tmsyAZY7Y99Cid3Coil+VNl1nT0JHPc29yXTBum/WNVFcPkJRUk6F4g5YXRq7NjLLjByCfjBLlIOXTlGQs1BgQx/mLaD64oYRgms0f03T0u+ZieC/oIb+6rwbFh5XX5KVM=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB7025.namprd04.prod.outlook.com (2603:10b6:a03:22f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Fri, 9 Apr
 2021 02:40:03 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4020.018; Fri, 9 Apr 2021
 02:40:03 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>, Minwoo Im <minwoo.im.dev@gmail.com>, Keith
 Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
CC: Kanchan Joshi <joshiiitr@gmail.com>, Javier Gonz??lez
 <javier.gonz@samsung.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 04/13] nvme: factor out a nvme_ns_ioctl helper
Thread-Topic: [PATCH 04/13] nvme: factor out a nvme_ns_ioctl helper
Thread-Index: AQHXLHMjubs+FBVUzEi/L7beXiorww==
Date: Fri, 9 Apr 2021 02:40:02 +0000
Message-ID: <BYAPR04MB49659651A0D02FBEA7FBEDF786739@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210408120842.1450092-1-hch@lst.de>
 <20210408120842.1450092-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2373be96-7e61-4d73-56ae-08d8fb00c70d
x-ms-traffictypediagnostic: BY5PR04MB7025:
x-microsoft-antispam-prvs: <BY5PR04MB70257902FEA72A3CA653417986739@BY5PR04MB7025.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YQ5YgjJLKWP+dtlCaEzOHrNMDMtw7vAyKyM0uW/qHFlROEg1uDttasLWpQRnxrI6fe/zXcNP0OdCTHN1kcf3PKq3W2vOkZ1kzrTK+PWDCYhneZz0QWrcQrgCPxEaJhpgQ6B8ISPMVO53fK97q9YxhcxBPcRnUQhUz8/bZKxr7K/12JPQFf3LA6KLAYNWdJY+a5yRpqrmUIXqq+VK9PsJsm6ePR0VF5QmhDJm1fd6KSACL4AysbOmi40OnpITEyEsf/ctxNpIE7UKZLDAMyWZKTybLg20lpjIlqm6IBrOfWTVal8POFSpUKxuhX6RRBGN0cDJf9okLo2nZovSp53IFZ0QrNE3NDHZToBEolvH1FYKqnsLqTb0SYbEGPJBq+9QcnF0NXnnNBNmDtK2+V3cw+Xi4cKM6Kq9/EFvoHKFDZbAJpn4P4kczI3Y/422YtVGqJknv24e8jXBf2fWqTR84EGhxDv/h5q/jZRnteWBWUwcnGK92sbQJ/hObPtLGqNXaH10HRWQSMXh/H3n1bqE3+ewaUrcC0PDu9xAhaEbYcwYrgXfA/rLP4cuKxJ3Y27tE+ZLh8Xnaa7Jf3P5q6oVw58zYX8dRdUSUmUv0Hah8R10zOUR5MmO+YvOMqpUxscf87SXh7TYkIGTUEXrYvuk/+RSXxu9vD37k61mefGV5nA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(8676002)(7696005)(66476007)(4326008)(71200400001)(26005)(38100700001)(8936002)(66556008)(52536014)(54906003)(76116006)(66446008)(64756008)(6506007)(66946007)(186003)(478600001)(86362001)(2906002)(558084003)(316002)(53546011)(5660300002)(9686003)(55016002)(33656002)(110136005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?DCuSEjIOWRWAHH+7sTdsYZ8PwEy45Z3i4NZEY/rdWyU7IocQ7VJ05hhKcPLD?=
 =?us-ascii?Q?+fXuGD7+RASL4+wzqplfyGozdBuCTvaivFvAVHheAbys0XEgvpKwJs0FBVY+?=
 =?us-ascii?Q?A0+RsOjVmBC5eCh7Sj7M+yb9j736x3OqMaixr4rJT3LP2zwMw4Q4YEBPjZ6d?=
 =?us-ascii?Q?Y99VJAtu3GI2fOpP9HYLyom84ZmYE21eqypZvi5JCVy1CWam203Tf7QM/Avk?=
 =?us-ascii?Q?oFgV+0SMBV/Z4bJg90kRiIvwVNgzFjbDu7i2PPVMeAwamEtrlBEYRWkqhIP9?=
 =?us-ascii?Q?fnj6Navl4b8t1fYCJ6dttjgENmIkcXkQsbJj/cFw0KXkgGwYuiBnWNPmbNb6?=
 =?us-ascii?Q?PAW504WcLUWALGhsaDEmziEAvr2SglpEB9a3fR8UDggR/NDwg4ppeMbS4l8i?=
 =?us-ascii?Q?G6a+zIV4QbvjChRsapqmeo2SUGvqK5BtJu7WoVE9MOSKZyAkrs/O89kCp024?=
 =?us-ascii?Q?t4ItyW5j3zfAixwF1xTvJl/cffxX2VGhhD+xcw9kDmqbGzhVIRwOBPCHPoll?=
 =?us-ascii?Q?J7rQtv8e/RfElUuccMYWprA5ioC05hOzFt39hJXxkb8mi33sA8xJclwi4hoU?=
 =?us-ascii?Q?iyAFGv21mwKGQ6KkGEZL8CU7UCiMBOqMtM9xSkL5ViGo7CxcrQ21wP51CZML?=
 =?us-ascii?Q?w/eUCzGBdaz8pXyGZwa3U+YsQ5ciB7ndyqzuKidJeXhul67Gkl1nX3KcFu6A?=
 =?us-ascii?Q?zPZNAKInPoaWP1Q+O2LmOAwovjjBAE6DBU5FunDxN2fE1wqi714yuYf+LQty?=
 =?us-ascii?Q?tVISDggsRsSZAiGo28IUgoeTEDPiqpzUZu6L8MYJvxjNKhdwVeIbAs6CwBgY?=
 =?us-ascii?Q?6TblLeBgMxyEjg4GVm+rUo+JhoHY6otpR+4BuGZMhQfAqJTvGU3Ju/BR394s?=
 =?us-ascii?Q?uNFTOP3XMg52G/Vc9/DpulR9LCJ6QmXGHQUizrykIeRyUYjldc/vQaQzRhbm?=
 =?us-ascii?Q?SHnx4NBEgkGpo8slYxHbfGOlJxn5Olmy8onVt/z7Huj8rbhI1NhpUoyODKro?=
 =?us-ascii?Q?ACIiYhyn/imHNOrqP9FAGh2VvMI5309yk0LOAalKoyhGazn70ESUzn4kPscx?=
 =?us-ascii?Q?Fc21cknT6GVP4pbGWkUeJWfHQWuEVFMwzsz5+WR864vStO9CYK3Uo+nT4PAF?=
 =?us-ascii?Q?6aCMCllCj6ZMIzxcdcn1N3RNKeuydnn10WcJBt/YlF/eJ0SSqlj5YjVClJ8D?=
 =?us-ascii?Q?Pb5fhzdVClxvvOspfvMBlrDVW+waeu6+LEHBKIzAyMc6ub5afnxG+d5+0ly5?=
 =?us-ascii?Q?BXC7e2/eQO2r0Ab6RlWvy8a6JBzQ8v9Eu1hPBjkqhwtAfgWtw6D3YbiSvvpL?=
 =?us-ascii?Q?9wi6YRKohL6qQnWX/uqgdIJXIKLfZBxbcDbTK4Z9K7s1Jg=3D=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2373be96-7e61-4d73-56ae-08d8fb00c70d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2021 02:40:02.8428 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G1XEttLIRDaPa9iPNa3/z6L9TzujBPu7Pzm7SnTC5ictxFL8I5V5TbQV/LbokOrimIcrCRCQrfnqleV4m03oWV1ykc4RXkaFhGMj7EiwDd4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7025
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210409_034129_297293_0B736683 
X-CRM114-Status: GOOD (  10.79  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 4/8/21 05:31, Christoph Hellwig wrote:
> Factor out a helper for the namespace based ioctls.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
