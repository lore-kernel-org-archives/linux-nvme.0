Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E79B3C00144
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Aug 2022 18:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RNFxrFFsIsolZagPkpJ2+iu9V452XPt9p9g+RVlEKqc=; b=c0cbz4JD1SS2WDR0CnQVICwIOL
	7nH4to41o8DpXKtFL+2f1meCZB1ZZJmRDil9BHUAgrnwhXrlkvcAq276d9CTbtA1xnhpz/g96OqK6
	WptkbquUJnS9OYf4ZZCcnTzZmnpxHAskg6UxiUmosUIwD2oEsuE8afsCa5X3GSE9yQOYYy3K/VdHz
	ELtEj1oSEDKoqc2szRnaN0RvgNCuVsotk0LNm0YasMmdnGJbmW40SkWVk411xZ/+E5OA/d31y7tp1
	Sa+02Wg/v57adDAEUwXLQ/8gJ810eRJwwaX1GraptvynbEk0/iPc+/y2VL76BEqccVNHxnWoblY/G
	4+qm+1eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIaMC-009E18-Qp; Mon, 01 Aug 2022 18:41:36 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIaM8-009DuL-BW; Mon, 01 Aug 2022 18:41:33 +0000
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271E3DQ7006456;
	Mon, 1 Aug 2022 14:41:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=RNFxrFFsIsolZagPkpJ2+iu9V452XPt9p9g+RVlEKqc=;
 b=WV5qWnKF88NOANYJXXybs/de2tZeLj64oEpsj3dFAlqjJ1pHyM/5cu5vkMJZLlisVoCC
 xjzA4C8tYOQHGK9cL80ghTZlYOrzdsLwPTB3e6wsaJXN8q83BhAE8yFVMU92zbf/Jv6u
 SHyEudUfy5t4cxJiIV/uM962CcKpFrY2/dZ3lAztaDo14Z75foRTXYsOaT0etipG0PZ0
 3R4cB+FIUInogj0MC7KhlFegM+HG1UUsUKBHiay5fEbKW7nb8txfzoZAC9I6hjwkFbxD
 /dxrdrHUPFGoshZ0IjifbJXv2LNQ30FXdLtAfAOmz3MKbChxtXnxI+C/7+cPL2LH3TH9 tw== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 3hn0g0erpb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Aug 2022 14:41:25 -0400
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271IenwL006610;
	Mon, 1 Aug 2022 14:41:24 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 3hnj6be1qj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Aug 2022 14:41:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRdRwi2/0I4L5c4tne50Yy9vMGBQGIkGzeC4h7fOo5FHMUA2BGS2mkKaHsaOVXTloatbtvc8mfU0ddtQxG2r/e82ODsphvoJMsXzTCRkUTNy+JAfoCKS01npKl0ELkir7S7j6hwHA8eatMd1cvgBFHahizMADRPBCN4UjL3rn/JAhi/IsOzBqA6ZRFJu7+uzfoL3pGk+AvioQ8x6FeeIaEhMIgAKMZbzVPV93ZbsOCJ5QvDoz1XGkvRzirarm9xQhH+ikCib+82N8LUwXpIvx+ibevXVblNt0B7XevPUgBF00RavU+S7qX8A0HvBeoDnVLP3oZiRGqUpOO/SLu87aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNFxrFFsIsolZagPkpJ2+iu9V452XPt9p9g+RVlEKqc=;
 b=fqZJWTTa/qCk0cMzDu+B33I9Fbo6VTTx/Hnq9sYLYrF9LjqZ8h8VuInWnMFkN7jSGmNgrgGi4QozUPFEpIrPwvqE01MPAyNSd5CyyOAxBSjORI8lCW0lFRJdwU4LnJmsUb8+VhEODSvszy83ze9MIOIngAVJhj7N7IsjJiTK6PRHBXbKCwGPKvJq7/bKFoNkrXVuShLbuHxTnCdI2oUG0/cMh6IXJD0mQW0oEF7CF3ir4NuYCOlN45ft/CjR/mGy/CBurPiAeW6+VFOO1/oGTraNTEKJGjRuMAQPGsxZqnleFvLFfwtKftnBYZotrTPLyyn6SW+EjdWC2C8kub+uhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from CO1PR19MB4885.namprd19.prod.outlook.com (2603:10b6:303:f5::17)
 by MW3PR19MB4313.namprd19.prod.outlook.com (2603:10b6:303:4c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Mon, 1 Aug
 2022 18:41:22 +0000
Received: from CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::a98f:3e77:243b:d1b9]) by CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::a98f:3e77:243b:d1b9%6]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 18:41:22 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: Christoph Hellwig <hch@infradead.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Sagi
 Grimberg <sagi@grimberg.me>
Subject: RE: parse nvme connect Linux error codes properly
Thread-Topic: parse nvme connect Linux error codes properly
Thread-Index: AdilwqEduD2z73XkS3+NnDqA0RR8BwAEumEAAAAuKVA=
Date: Mon, 1 Aug 2022 18:41:22 +0000
Message-ID:  <CO1PR19MB4885ADF9ACFDC0C848DD63D0EE9A9@CO1PR19MB4885.namprd19.prod.outlook.com>
References:  <CO1PR19MB488539073167D496A9A7D991EE9A9@CO1PR19MB4885.namprd19.prod.outlook.com>
 <YugdDtiK59xT4K90@infradead.org>
In-Reply-To: <YugdDtiK59xT4K90@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2022-08-01T18:41:18Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No Protection (Label
 Only) - Internal Use;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=dee7c0db-66ff-41b0-8378-fe20489aef6c;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42d0d2b6-d347-4071-2880-08da73ed6e73
x-ms-traffictypediagnostic: MW3PR19MB4313:EE_
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  xet5ZSvdyQBTRjz8Q9zXGBlEgpM3DLuk5vzc7ObYAHsJKkL9CnY93VvFXnnAMob2yU6u9LC0604zsYQq24mf8iaDXdPf6iFVMP+MwXvsaO9MGXeHNZQTpxps2ceH5dkzPqV98wuwFU2jPz/5FNf+moDdqO2fLZe7XzaBynnmCjcYjsAH7LHgzEW1dPzV+3FiMxD48beydJhcNuiSwACNx9VCfIdRLyhfBbj9pTZz9HRjOGAogfRGx3Dw7eSl4HuV5ELKvy4k8hf+JFfOZCjzyFe1ErT3duU65klp548B1RO1TrKNP+ZYXDMKauFEVqI831z3eSVZ1ThhAthOu+UvJs4wWd/O5SIq9KxC805dkanb+8OZSG1JWTAEK7LfjuI/nzhBll7RCBL+KxCbr7dGnho1abK6DOrWtA6XX3Jzws6Ff5Wk8852lTXk5LYMj8CaR4VuIMiFYB3JU0BnLimKi12MwYpE0uiC7kn8fE4Li3bBlNuPX+7IhzvV2oGhUF2CHZW8HbU3VNkmbQ0C67iXydTmcIXEmbK1bZPFweCW2nI0bRxpIXJ3T5b5hXDh/Cee9l6PgUU+V6nvICzvILKvUFssJbnptGqxXUVQU4C32kvfKNiWnGf0Wj6gSBN5o5H1oyEohh5dTFwsukgx8Ea24Zbo3EOgGAxhv7OiNznFB51Z7OQlRx1NvR+RjOj1BnaYVH1PWLEj74LGYHz9e0KvXzlnPD6naxx8w5PEE3MlX+dFRrSgcg9Uy3CYRNgeeHy2qVG/oLsUpZO/JK3p8ZzVX6lafirOrAAWZWrxE1/22AM=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR19MB4885.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(6916009)(54906003)(786003)(316002)(41300700001)(53546011)(6506007)(7696005)(2906002)(478600001)(71200400001)(55016003)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(4744005)(52536014)(5660300002)(8936002)(8676002)(4326008)(82960400001)(38100700002)(122000001)(86362001)(33656002)(38070700005)(83380400001)(186003)(26005)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?tCKLtzeUS7d+LfDOLQvXO8aOemXIgdr+19OJzcp4NsocYsCaJuF3mKowB3L4?=
 =?us-ascii?Q?T/f0CTd4SPO+y98ZGd4OFktSwjNPB65QO3kpk1WJAx3IMzU4lDX6rznMFmTU?=
 =?us-ascii?Q?+sszAyjsj3Gxa/jRV0my6nCay2X+QTvDA3AAJH+xMiRic163OVFRGBnMVU5Z?=
 =?us-ascii?Q?rgY4sQO2l7UuKgkG+IjYZpV3tO5qDU4CABQWjt7By8kJnS5S7vW3de0TuPit?=
 =?us-ascii?Q?jFemag3ykBKPDYgOkstwwDO4Efdz3BRMauUviGNC56JHRb6ZVmbcT/vUJTy8?=
 =?us-ascii?Q?GZr0JdB688GB+RtYExx7aaIjfluktBezH4M5KDPy50BQahJbfaygl7A5L2Jk?=
 =?us-ascii?Q?yTHtKllwB8dRbPk35b+f8NU/52EaLeqmYhS8j1jmky0iqE7GMh6NMbUrbdze?=
 =?us-ascii?Q?pXx3y/k5I4/L7ZuscT8b2wrcp06QPnRHoQRsoesjiqq6Hlt1vJOe640bsCmb?=
 =?us-ascii?Q?/6QUQtrTAOtq9w7tTyIektkXTM00OjkufWqHObjCL9FWEXsboq6mQSH2PpOi?=
 =?us-ascii?Q?TkIhbpXkPsvGg3qLK5rsYypCY9a5/PSzdNgJ5BHkipY9ztdIPNmr2HuA/tWv?=
 =?us-ascii?Q?JDQ/eA6Hwdw+G0vKtayt3F+pPqQEyEVMxvHJ03hctAOQp0Q9g6vxdewRLZ/Z?=
 =?us-ascii?Q?G3PXF2uCpzYCpZf0f/NqFobbvEphVtw5T/4rnFkKn99AFESva1nsUNrcXAny?=
 =?us-ascii?Q?cOqSKkS8ZLwUTKN8DQqoKUWSzBkvmwDd+wgMa3lgtBTzrtDalGO4QD+zoFHN?=
 =?us-ascii?Q?9kc0HAZ2coVOQFQncrjnBEu8YWjr8/FXcfyNWtIwheAsU7wjNXeyGStNK1Uu?=
 =?us-ascii?Q?5sSG8nNb96qX6wCkz4Hy2M0ezZBLaP5Cc+tw5vaBr1YCb2+OXqfD83t3Nlce?=
 =?us-ascii?Q?87AnCug78CsbUY4KlByj6P76p6nk8n2d2zmX/X+cd3ijP1SRH7pzDnymvPW4?=
 =?us-ascii?Q?VHrGm0MXXR2LF6m10xLNY2uMW72/2Z2ou/HBcyEMHUIqJanGKFtfVAh7g7dz?=
 =?us-ascii?Q?9q04tFPtyPWDqUZFj28X5H4s5UON+r+s4UWujKI3m+B0erPvpB3kgQGBA92B?=
 =?us-ascii?Q?3ZlTJCbH+93bZPh8GBvNwKn4YFLpbaqQ8o7NP3iOQAxfdSJ5O3YicSbmTtWl?=
 =?us-ascii?Q?/cCiKu6ecxMl5fqDRPJMFnX4uXyhYDf/NcNW+VKsz49arZz4SG0wVxqXdy+j?=
 =?us-ascii?Q?V49KDuhGOWT2TVxhEj54wRmWv93H4peodqag69AIGYK9EwLHZuQoiGsIT4hj?=
 =?us-ascii?Q?j1nPmrSp0NwdR23Gw+KZtjjajLH0OJsc8pUs/F5BeYfIYVXLQN0cPcNrqLoK?=
 =?us-ascii?Q?+KIOqrifNOPIl4xF7cYU1A6mFjHmRxXJCC+lfjzXyaPHOOWFT6JGPropQMhR?=
 =?us-ascii?Q?gLDz46wH6V5b22oYu7RhygbkEpUruH092fRXcyOAxw5ZFq3p13PONe55O8pu?=
 =?us-ascii?Q?Zh2kqjk/TRCnVx+/D4eudjRklQH3Em0YntHKjcqNCgB6gSe3J9HpvqJyhzYT?=
 =?us-ascii?Q?8F37hPIHG0hH14EQb4YIWf+BbO3g+j/M1kUp02mY+ABBPXVBZ5dHFsfWNi9Q?=
 =?us-ascii?Q?HDqyI/KXcV2tAQaFYVE4Sr9x1VutfeojdaPDX6uf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR19MB4885.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d0d2b6-d347-4071-2880-08da73ed6e73
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2022 18:41:22.3361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4hJRkcLI3kAzFjMyzgZZptqct85CWGhJ+V6QzENoo5yB6ExjPTn/LQ52I+nhrjkVQ3n64OgzX/xIT5Gw6PL2Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR19MB4313
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_08,2022-08-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 mlxlogscore=973 lowpriorityscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208010093
X-Proofpoint-GUID: 7qTgZ-VnmXqwACAuvimrF19qg93UATJo
X-Proofpoint-ORIG-GUID: 7qTgZ-VnmXqwACAuvimrF19qg93UATJo
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208010093
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220801_114132_598586_0BC87DE4 
X-CRM114-Status: GOOD (  15.47  )
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

Just applied the patch

Thanks,
Amit


Internal Use - Confidential

-----Original Message-----
From: Christoph Hellwig <hch@infradead.org>=20
Sent: Monday, August 1, 2022 9:36 PM
To: Engel, Amit
Cc: linux-nvme@lists.infradead.org; Sagi Grimberg
Subject: Re: parse nvme connect Linux error codes properly


[EXTERNAL EMAIL]=20

On Mon, Aug 01, 2022 at 04:20:44PM +0000, Engel, Amit wrote:
> I can provide a simple fix for your review if you have no comments to the=
 above analysis=20

Yes, please send the fix.

