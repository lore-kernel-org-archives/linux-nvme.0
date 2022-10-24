Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38894C67871
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Oct 2022 19:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9cpoJX88eFd+patGq11XULHoV7KaCvWhAbVMH4K++R8=; b=Y5HTZ8IFN5EJ28DytjmZcdmegk
	7R3pW0r55GXvmreN0dLB+iCR2riBvIRVZwKU5F/ClM4MTuLoDQ8uC4E0nQwJMz0mRaHD9TgCPRFQV
	38qFQ4POzGPhRwOQzC4ZsO8aHmz1UcR2vZvf9LSohaJRrT+7c37XBJVi0LiT71ukyygUtTbD3wJpd
	xK+69ElLash420OQh7LM9dnq3RXFBLBrnSCQY5aKaHpeeXrxewV7H35TAhSWzgxu1QRyA7hXrZfsm
	s47/UIbqqGW31R1FDx0pEWDcregS/691sOOGm8U/7vUBBeBG0ZLeiFutjecAAFOnrIIhfS++aeQno
	OzsgaXVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1on3Gp-002ncP-Po; Mon, 24 Oct 2022 19:37:59 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1on3Gn-002nbV-AE
	for linux-nvme@lists.infradead.org; Mon, 24 Oct 2022 19:37:58 +0000
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29OJbBTf002311;
	Mon, 24 Oct 2022 15:37:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=smtpout1; bh=9cpoJX88eFd+patGq11XULHoV7KaCvWhAbVMH4K++R8=;
 b=s5H8neavmxFxsCKA/L3mbCDHRDMb9rqKxQeF31oOz+nw2ijD1mVHrCt/lP0XMkasmUfY
 nEAram1nCrcE6kDuCq7qEWJP4oEEnekWPiR19LmfA+ga98m4zsKRspN59WqHdYYnYbqU
 EGomzTabybVyu/z9SNuJ6AexyvXfiKHjgsSQ+tWmbHfkXPVjwexV+KufYVaFPrXjAlD2
 mXtYZsu12RljN2oeUpkakZmG+3e64L9s11S4RhW+hu3eDRNPBsq18/hkq8PojIusM4Hd
 aizWViyUu8sDXuHIoNupPwsRiHezQysbk8R0AHCmNVku1qHE5NA3RR2RR1lbcdlafZ2Z nw== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 3kcbpgfqs6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Oct 2022 15:37:49 -0400
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29OJaJUs039818;
	Mon, 24 Oct 2022 15:37:48 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 3kdq67ru2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Oct 2022 15:37:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBL+wZsxHvvPtI3Rmro/qEnHZQLBJwijv1w2Sm2K0xtro/pbRCpXP8WZxpnPRwqiuko6Wxg2f5BpRB8S43OdmRfXtNVOG+LebP2mQOgOV83EgUfp7iVZ89sqw6LjgljJNJJSQZhmenNT6T15Td2isofpNBLgwWD//cMIgxFdFFD9Q6q2O8kQNBAEQ/xr6X90QViANG3CXUWlSJ4uvATDhHID/LqzlgUKOLI8n94XOSjSLoJuoGw/R6patECYzxva68eqz3RL3igm4Qvttl/j6IYS3ENp1MhoQYShK7EFxs/CLtN82Jo5WN9DRzOuofKXkD+xuQM2/aDxXyTscqPDsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9cpoJX88eFd+patGq11XULHoV7KaCvWhAbVMH4K++R8=;
 b=Ui7LwEosLsdJFhXYagcHR38DK5QOMhMBgWzBcOuPm7ZFmAIQTJ3IRiXtzm9/YpMuDWjdRwZkmcaQAI6jIxh3RnLHUOTmPiNxk5Y7BNBb32wrUQUZoa652Ml8YsrEkfJecfpsEZNQ1+OBU+R/qxyEficH707XJtEjA1NqUJwjiAX5xofMZUzvXxsk5n8ujZcK2Cnd/PGcA5bhcJUA68Dqi8ox85unbpa9NWGBq6gISRMKPydIWmSG1ZSWAfUgQhg295lTejZ62sTiDwLaA779HzBRVtSN1xyjA7HDNxQG0D+9QD9mXpn8/C/owposANkb/XMSvj4aX5lBGjLZAfkXYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from PH0PR19MB4889.namprd19.prod.outlook.com (2603:10b6:510:91::13)
 by DS7PR19MB4600.namprd19.prod.outlook.com (2603:10b6:5:2c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Mon, 24 Oct
 2022 19:37:45 +0000
Received: from PH0PR19MB4889.namprd19.prod.outlook.com
 ([fe80::ac:679b:5005:b40f]) by PH0PR19MB4889.namprd19.prod.outlook.com
 ([fe80::ac:679b:5005:b40f%7]) with mapi id 15.20.5746.023; Mon, 24 Oct 2022
 19:37:45 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>
CC: "Engel, Amit" <Amit.Engel@Dell.com>
Subject: nvmet-tcp timeout issue
Thread-Topic: nvmet-tcp timeout issue
Thread-Index: Adjn3+5ZwudpUDdiTfOVdsW9oso4Gg==
Date: Mon, 24 Oct 2022 19:37:45 +0000
Message-ID:  <PH0PR19MB4889C64F4182B0CE6357B0EFEE2E9@PH0PR19MB4889.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Enabled=true;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SetDate=2022-10-24T19:37:02Z;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Method=Privileged;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Name=Public No Visual Label;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ActionId=61a1aa95-d0c8-4ef8-802c-284e3233fb2c;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ContentBits=0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR19MB4889:EE_|DS7PR19MB4600:EE_
x-ms-office365-filtering-correlation-id: ac961730-b4bb-4d0c-970f-08dab5f739bf
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  2/OjKQjQGfCYA8ULZRou8455Asbyv7Tu5csUQYItfL7a6Gf8MA5a8qBiK+EZZ2u+d/b6X583I195uXO0RoBugOc0COFwrkGzdzSgZcxAjdrDHO7CNXnmzrA3FVH8NKPJoWT+I1esSd8O4bsIxrJ5fZciS1Od1VnXd8eTfZmgKKzJPyU2otgpjMvXfehAm4As8EEZw54s6pUrKBJUGy3lUtHK6P2o28Ka93l7QvkZBp1ZAQTlpYoH/fQgLxRnTISDe5r2tIQFlsJ7DQnRFpqn4+gLXWQP1ze2BQHy5FXrEQubXIgSSP45CJNe6wwegb9geQ4wfQUO6daeTWqI0jJi0u+7FX3jygds++3PcyVOrWDp16pSZVNdyVOGeRPSGMdvANwdne+DKmBgp+H3c7X2SoK335ojrAjy31FAVGCUr2IB9Xfiq3NquZ8rt7h9lrCQ210D67Rp7gFOxXvwJB5/IHNSUWoyA/7SBrEniL6VL6jl5SPQXa3VYwxEBXPjcVUG8ONc0H41BR9sgjGGFYjADPqvrXxK72NtQlQKxfbdoBpELmooRkvUuIs7ZUy9tiTMKMSZZRccl23v9Wma4Ng1TDCOPwn4CHaEtbTDVkk9rhegWoqTTJRgxE5otFN41B6pfrIrXsjija71dGelR9ayeWGamoSSVWp5HUTXl3GRQo3/mkqViU2RSgEDlTX4Dnk7tZ5v4lkVmwq9+G283X/wl4PVtJFLgaZcY3cMR7j+TaFA9ZTkMimrFWqbB6G29grNr8XOhWtyMkCuT3Njm56xOQ==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR19MB4889.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(39860400002)(136003)(396003)(376002)(451199015)(6506007)(26005)(9686003)(5660300002)(52536014)(8936002)(7696005)(107886003)(2906002)(83380400001)(8676002)(4326008)(66476007)(38100700002)(3480700007)(82960400001)(122000001)(38070700005)(41300700001)(66556008)(66446008)(33656002)(64756008)(66946007)(76116006)(186003)(478600001)(55016003)(71200400001)(316002)(110136005)(786003)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?nxEgTRmd6TWqCXYP0FHzbL6PIdAVme7euVCkUDzSbamjZT2sNBkunmQG87AB?=
 =?us-ascii?Q?LG2ENixdU7YqYaw2faR7ywqr1hx38nn7SW4fl6tSroEq64mJ9Dg8yc6jScZp?=
 =?us-ascii?Q?dW4KzZUQEtZuj6jG+x+TdkTL4V4cvIIMzQK/Cr1PUgYEk2Ot2fDSKyvh/2fp?=
 =?us-ascii?Q?4I9eVnO0IbdbCbFq+hih/JpddGteKmswKqnzWF/xK2/STGnJFb2LXG1DFGbJ?=
 =?us-ascii?Q?hid6AcVABrhaTrVN09nflJg7tvQuf4rSozC/7g1FpiBcobkvaABUwXpsZjvm?=
 =?us-ascii?Q?msg0QhtX31VWpCXRGw8ryWwC3+Gv2RJN6QPMZJIusJiKqiUlJlkrllM9Y+9Z?=
 =?us-ascii?Q?4VcVH63Bwqm0/wY5X8F3OCTYUPF+Ha39INuGzNju2MqRjf0L+EB754+Csdbx?=
 =?us-ascii?Q?XIgi4vqanpTDoUEpd/82BEF/DN+/MplkHt/HY/Qf5QXOMlPObbnEz0g9gyWm?=
 =?us-ascii?Q?6Zy39fk8CJjjgrUpW4QPeqmfnndnkY0hMNUl+Cqtlf64A6swqvr+hvkttgc2?=
 =?us-ascii?Q?p8/AKDve5YFk5O9UBDh3PJ16MmUGixfLQsRlTyaHETHzI2vjFTCgrO/PRFaY?=
 =?us-ascii?Q?/EyZw1HXkGdxzd0I50VhFXhuAaeMivu/WTFnM7j3DalLyVazzmdoiOcVsfEC?=
 =?us-ascii?Q?hqJsO8ioG8SA4McE0T1j36IRzvI3N4wr5VvuvWcdTZ9QN8RbOb9teKN/OCap?=
 =?us-ascii?Q?zrxnEWcjID6rMnoNwM3Csi255zciB0gxV/UGeZ51W8RyvYedXq31lpYHNj8j?=
 =?us-ascii?Q?1MFN0Nz4xOaqvhNOEw6IdCcZONcj0UJevzwUumvy/4ixdfmXCWFZjN3fCuoF?=
 =?us-ascii?Q?HjGHeE000viQK3QNrBit0ZGDH4G5vnkKw0XjUBlRSC4irYjA3V95R0NYKaxa?=
 =?us-ascii?Q?EeRF3rVLhEu7I0KPzBu9spt95gUEQxLu3TjRHVTZR0+AWtiX4iyo9O2ice17?=
 =?us-ascii?Q?V8UxntkgoltBzI1y2J46VDTLvJqqpIfxaO/EVqJPS+Et8SvikuURi0Nqq/2j?=
 =?us-ascii?Q?LwhMf+atDQrK7CVyj9gw2GP897mSWwWshcyqnvkZ6Tkgi5QcrMzEOlEn/bt8?=
 =?us-ascii?Q?wb+uGsrAsR6lt+Ak5BDV5V522W6sNBeh+OZrZMsRVwRAFgEfmYS9K/AGJK7O?=
 =?us-ascii?Q?H4hXLV3LlepvAE4y97At+NTEmClt4Ug/AghUOXkfACtWGtN4mg5sMdxT4V3V?=
 =?us-ascii?Q?Zm8UHgIvMomLNDAcwusyBl/6E9Sy+yDPq4IswM1mQAW5Uta7i0r92XfT+466?=
 =?us-ascii?Q?opoBbjzrLp+gQWlFrbkNn/rrMgLZBKJUms19SGE2Z2TSjid21KvpXzk/9XVR?=
 =?us-ascii?Q?hveOnpjw/ar7pt8emWfwX8fJa5s4VvVComfSl2PMJ+45wGDOXRg4aFlShV0U?=
 =?us-ascii?Q?gEHxkFZlaOSb0Z7u6Wmw9CaaNu7Ufd75fRIj58LAlb40e/x4tbJmZqfYzya1?=
 =?us-ascii?Q?UZ14cM7aQoOX32pemQFmQNT3Z7WB7pYyHVwqBJllA9gDzlFq1t3afmyGTjdA?=
 =?us-ascii?Q?FKSWfC1NBPeBiB7pFUnmNYoG54fTKlyqtuVLMESasNxPGE+QV8YRBpsesw7O?=
 =?us-ascii?Q?P98MJ6ooBY0zkXmvJ9ynKTAWgp8oGPnfw6jah7rx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB4889.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac961730-b4bb-4d0c-970f-08dab5f739bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2022 19:37:45.6128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zkooKj5H+R5i7BnKaANLz0v65tDthebzU4LHh3cCVXBtadya9EEzaEROcPwpl/ldxNZO63hxDKUr0jiepdemiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB4600
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-24_07,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0
 clxscore=1011 priorityscore=1501 adultscore=0 impostorscore=0 mlxscore=0
 mlxlogscore=597 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210240117
X-Proofpoint-ORIG-GUID: 8oLI5VopBIc3YU7q_x90rDrkjf-bLTMs
X-Proofpoint-GUID: 8oLI5VopBIc3YU7q_x90rDrkjf-bLTMs
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=692 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210240117
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221024_123757_453498_6E9A95C9 
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello Sagi et al.

We see a potential bug that leads to nvmet-tcp timeout in some cases

It appears that there are cases where kernel_sendpage() fails and nvmet_tcp=
_write_space() is never called
This leads to a timeout due to a 'stuck' IO

Based on the code, as long as SOCK_NOSPACE is set, upon kernel_sendpage() f=
ailure, nvmet_tcp_write_space callback is being called
And the io_work will be scheduled (queue_work_on) - NO issue
But we found a case where kernel_sendpage() fails and SOCK_NOSPACE bit is n=
ot being set.
In this case, we believe that nvmet_tcp_write_space() is never called. This=
 will lead to a IO timeout.

In addition, it appears that some scenarios will lead to unnecessary cpu st=
ress:
In case that nvmet_try_send_response() returns with 0
nvmet_tcp_try_send_one() will return 1 as well as nvmet_tcp_try_send()
it means that 'pending' flag in nvmet_tcp_io_work is set to 'true' and will=
 cause unnecessary cpu stress

Will be glad to hear your feedback for both of the above issues

Thanks
Amit Engel


