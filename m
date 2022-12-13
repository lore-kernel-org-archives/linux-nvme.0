Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DBD9C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Dec 2022 15:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uWpmfU1vwiyB9RzYctKJa2fjXyNTqUDorNo92G/hOyw=; b=b7Br6vxm6IVALhie2HM1ZYE+NM
	XfPlXwX1yHIntqW4aO3Gwlky3BKwITB6zmhlkl+0m5vBQ/T29U0XOlhvcGgkKwS9bf2gtCY/UqUBK
	1gr23S+QqKzXzBbDhsLQ77kM5Bg6DlVDJWY6mCxbl9P7xJIy3qBTZpYPOCiGHkdvCuMNAwwXf8N89
	YJwIeEnogunZWUO/sBJuKTQVugcCTZQn7Wi9LSZBol0W16145N4VMM4IilGUIw1d2LnGGVuGf2Nh7
	J+VoryYgSoHD6fsh4h+yLph4D+0AyzTUqsNy0zyUoeke4nwRrU5AJqRWYjc27ewb2Q2uis0vyGcRR
	10PJqP7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p57LQ-001qng-Au; Tue, 13 Dec 2022 15:37:24 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p57LL-001qVW-9O
	for linux-nvme@lists.infradead.org; Tue, 13 Dec 2022 15:37:22 +0000
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDE6UGG032694;
	Tue, 13 Dec 2022 10:37:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=uWpmfU1vwiyB9RzYctKJa2fjXyNTqUDorNo92G/hOyw=;
 b=xGhwDMmo3/RaiyGrSBWQtDwbYyklaLgMtJ01x08DFMkobeOdMHq92AUdFU6oQpBO4jY4
 RfvvPpidEQPXVTVU6wA5HaAjGZNwHOplKqk3/HBdxq/R98UcphB4R4K1K1Vr8qZhkkea
 xTkKKE7ZoPob23qrmo2TGiY5rPeMo2b/gxNJH6Gnph0DABmlCAZZ/BA4pfyTZsOa+nBo
 mB7mrzfp/uIoOQx+oC6k9/VIZmdmB0YPBaH7VoMgh4EiNDuWb/pQ1SVSwHbJ7pu0i6cM
 H0lsGU32toAUFrsxy9vvw5W84LVfu685CPsBTOQC0xWIBcPR1XU5uVtWedEDwI50De9X jA== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 3mcpu417b8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Dec 2022 10:37:08 -0500
Received: from pps.filterd (m0134318.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDFYPoa022395;
	Tue, 13 Dec 2022 10:37:08 -0500
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 3md87wu0q8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Dec 2022 10:37:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IqZDW+5rba5hYkRkFAMsjSitwcB7oP8U3xX36pMej632zcm0reKRWCL8K0P2n76GbuCn8oPaMd8VGtAvKYl75voYCZbbU+dApAgE1bS1+lR8MFqD1NtVim4cYfr4DBUdr+QzQIeZvKY7RJ9xPlgImzVEqz/GF+bfMzYiuReNaYVEwQRkoLPZZkYYYZRmKzTl5P3e+Zs8zg2Lnivsl50kv9ikAzKvohQxMSVEBU9vJBlL8pZ0i6Kg68gbHcpYRlh4sE/s3+YIyRBAt0XZHqDbFj8fAsIOsLr9+ZBZi/Q1nXMP/8IpmTMHLbkJRxxrSIBNPzw0IyLea/Sz+3m7XoC9LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWpmfU1vwiyB9RzYctKJa2fjXyNTqUDorNo92G/hOyw=;
 b=RItOBvAba1BePBPOuqQL8NCMawByN4UHub1F6x9e4L0Itny1/v8+a5XiGNey7BSIZccARLod73HFWspJw5z3x8h89ugTIek3T2x2LtP47wI0s+HCjpDXEl7MhHOfbJbuhGsHceVA8EIBj6Y6rg+dS0Or9GvtCoYRWyNZZLfj9ZaSgZjcgs7Iws7uY4+LzzAh9vcw1sGZd30G562YLr5k/KUiNsE919/wCpvtawXP+YUv60AMwUOVmSL663AYaP1WuYBNF8D4tpmT9oasuYtBfbdcsz9LebPM2XnS18nX0kbF3V4vP35IU5Gw7fpXRtTfxJuGbWP+hxx1qv8cIgTKLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from CO1PR19MB4885.namprd19.prod.outlook.com (2603:10b6:303:f5::17)
 by PH8PR19MB6593.namprd19.prod.outlook.com (2603:10b6:510:1cc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 13 Dec
 2022 15:37:05 +0000
Received: from CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::404:85:b6d7:86fd]) by CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::404:85:b6d7:86fd%3]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 15:37:05 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "sagi@grimberg.me"
	<sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: RE: [PATCH 1/2] nvme: add nvme_opcode_str function for all nvme cmd
 types
Thread-Topic: [PATCH 1/2] nvme: add nvme_opcode_str function for all nvme cmd
 types
Thread-Index: AQHZDjW1GXOjLfG15ESK+Cpp6Jy2Cq5qrHOAgAFIaxA=
Date: Tue, 13 Dec 2022 15:37:05 +0000
Message-ID:  <CO1PR19MB4885F8CECFF94ED8F4128A92EEE39@CO1PR19MB4885.namprd19.prod.outlook.com>
References: <1670855159-3182917-1-git-send-email-amit.engel@dell.com>
 <1670855159-3182917-2-git-send-email-amit.engel@dell.com>
 <82451f44-56f6-4c30-ab93-aec446f02777@nvidia.com>
In-Reply-To: <82451f44-56f6-4c30-ab93-aec446f02777@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Enabled=true;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SetDate=2022-12-13T15:36:58Z;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Method=Privileged;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Name=Public No Visual Label;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ActionId=6a8954ce-136d-4abd-9cc6-63b31e49085f;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ContentBits=0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR19MB4885:EE_|PH8PR19MB6593:EE_
x-ms-office365-filtering-correlation-id: ce3a5880-2bf2-4d84-c7ab-08dadd1fe36a
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  gRa19gQ9RhIiZywlX3TjxS/54F4t/ztiAzoEzK+OnS3/M7FsEBrqQEVKEsA2VlmsQgmM/QXIGVPgM+10A6el/VTPLMb47cavjtjXm6bpKXX4cKi32MqRhK28qlysA/BVi+37RKULEWMnmOoX9UJtweqRWaFost/ghEfk0SsDJO/7/O9vsnpW1F3g8ucoI7kxWhJHUj9P1DNdI4WSKRuYnPiYgAbrNwUZCe1Jp/qe1+mJKl+wlOmEG1L1g/zeIiWB3g0tG41T8jhZnnPK/OAoE9lmm+Pm7+qawMBHgCKJHWSANomCjbBtP/2Y2Ke/MILiYfpkEMKatNgT7zweThYInlHTm/VC+GwxraBnDNsv+jjdIo8ojQ0pH1+7cMh72skk/e9nRIqJMSGh63oAvKGOl85worw+DkcUKjqm8ptf0pLBVnB7QfU2FH0I8GWXPbCfkA61uwxRToMSrkmMK2Ml6UPQh7JaJ8cU8dpccnFxhWNoM0xIqmGvfQQPgRZCrIDGI2/e/UmmA3K83RQZF0vZ7UU5DYhJWnptT+mih6hkB+Nm3iIxthw1+m42OW5juvTJhzBsiPreDqMCLP/4vTJrIq6ADIuIZ4cAHIQt/j/2CSF+uUc2Xr7GGaU57XP3Fg+hZiKJ208gxu0LcEmrFoBl3Al/T8e5BWvcCPrQ8I1vel+n3QB9EFc8VeeRTTRwfCrUmtzTQ5cHp4RrirFrxLaLkg==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR19MB4885.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(451199015)(66556008)(41300700001)(5660300002)(66476007)(64756008)(4744005)(8936002)(52536014)(76116006)(8676002)(66446008)(66946007)(110136005)(33656002)(2906002)(478600001)(786003)(316002)(53546011)(7696005)(9686003)(71200400001)(55016003)(82960400001)(38070700005)(6506007)(86362001)(26005)(122000001)(186003)(83380400001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?ZTFHMVZjTUdyME53T1pGb3pSY0VzMFJvREtkeEdsMEhva2dVZVFqdGtGN05B?=
 =?utf-8?B?cEVROCttWENoVlFlbU5vWGZhVUQxcG1qYWtZa3hubDYzTlpHZlhlVUZHWGZL?=
 =?utf-8?B?d0hZNGZLNWxJb0RoQWx6WTlSV3pkTElrNndXaVhOZ0pPbGlpSmdtTkZnak5h?=
 =?utf-8?B?ZVFkV1NBckQ3TW51MkRTMzFGRWhHTGhFeUUwTk9TYTRTaWw0WDJza0t0c2FC?=
 =?utf-8?B?eDJqc0tnbldkZnJYZXNjeVo1N2RvQk9hZWtPTDJxRllTRXg1dWhUWERVK2tl?=
 =?utf-8?B?a2RWdjFaUVZvR2Z0elV5dUVUQ3E3VHFQejZXRGVQTUVaODFxa2ZvKzN3QkV6?=
 =?utf-8?B?MElRSkJBSi9ISWo2bGN6UlUrSlVwK3hCVFBnd1VpTStsRVRwKy9MYVhOajdC?=
 =?utf-8?B?T3hYNXdsT09zTG84cnlDeDNKQWRTUzFwcXF0YUdheE9oWTFLa0hnYk9BdzdG?=
 =?utf-8?B?NUhHeW9oV1dtNTlUZVIxcmJKYUhFMUxYZnZnOXFxVmdUSmxyakdhZWFkK0ZD?=
 =?utf-8?B?TU56K1NOcXRVNWtZcW8xTnN2Y2srakdzVFdaUmZGNUxMYTBaTGVsSnU4TmVz?=
 =?utf-8?B?UlhGNlpBQXN5enN6bGVMOTdDam9POUZMVEZvaDAyWi9WcW9BWTY2aWJibkI3?=
 =?utf-8?B?VW5oclJRT3VrbmlhVVY1eGlvTEluRjVGeXZUejZGNzVtZGZ6MGs0M2hseHdp?=
 =?utf-8?B?a3NVaEMwbnRmdWl3YjRLbUx0d0lxRDhjallma2J1bU9mSDVjblpVL0tzWlRV?=
 =?utf-8?B?elJTWDdtdFZmNVZranJYUG9ENzQwS2xOWlZpTUxoTm1wYkNrNXdDa0MxeEF1?=
 =?utf-8?B?aU8zdm01R1pvTE5rYnZYaVd3R3pWM0NQelBMUERjaWo0WHNmWTMwbkExcUdB?=
 =?utf-8?B?M0xPbHRud3pvWXdMVGtnbzB3Mk5tQlF2VHp3N0k1R1B6RWg2MFRSalgxSXJj?=
 =?utf-8?B?eDl1L3lKVHRYRHg4aHpTRU1lUDZJT05HV2hybTNENmI5TlI0NXcxRFJhb1pD?=
 =?utf-8?B?ZS9semFmOVJqeUllQUFWOCs3SjR3Tm4zc3AwaU9kUzBKY3VMbkl3VTVOcWsr?=
 =?utf-8?B?eFArbGxmdHlEVFgrWjZYdWFNT0hBL0Rsd1c3VmU2amhrUmJHMjNPVE9zdTJn?=
 =?utf-8?B?QlRyNVZNTzhXQUZZRkt0SDJyYksrMmNpT1FxaExMOENMUWNqZU5Dc3EyNnds?=
 =?utf-8?B?aFBWcnVpcXVFSi91S0Fwa1d4eWF3Z25MUjlOejlZM2wxTDgxMjB2QUw4L3E2?=
 =?utf-8?B?UHo2OEtGeDEycGtyc0t6NEN4ZTYzT1VXVDZ0S0ovVUtwU0lNb0pOQ3dncjNy?=
 =?utf-8?B?WTRCMjNMT2grdkhnUXVVNVE3UmFqYWM0UUt4d1dKc3k5U2xxSHhwZzZkZzY2?=
 =?utf-8?B?WmdiQS9FQ2xQZkdaUlQvSmZUNVZXN1hPbzZhbGx6WCt6TkNBSHg2U0duTk82?=
 =?utf-8?B?aHZtTHNZR3BWS0VaaHVFcXd6bjUxdGptbWNBbmNlQUx4cFJTTkxTUFRyc2VX?=
 =?utf-8?B?K3ZqTGd0VFBudDJRdGtUNktJWS9yNXpCa3FwaG04VFJ3bWY1RDR2SDZZYjRo?=
 =?utf-8?B?YXVRNlJGNStqa3NuOStQc1hVdTQ4S2U0R25DWHJRNUpUYklmWlUybmRsZVNN?=
 =?utf-8?B?eFNOMVRCNVdaUWdPVTRVY1dyQ0N4bE53SktNRjRVR0c1a3doS0Z1eUhnVzg3?=
 =?utf-8?B?bTFtUm4yWWFuQ1Y0SW1ad1ZuQ21xUC9pb2J1RGxVNS9pdi9RQzZmYi85Syto?=
 =?utf-8?B?SEJyYnhxc25aZ2dSRmthb1pZMlEwMXhqMmczSE1WWDJ5YjRBd1cxZFpDdzBm?=
 =?utf-8?B?WEhWUDRBN09pZThvZnBsUjBRYjJsTk9tOUZjZGZIMnJkU28yWW9MSFVYVXZJ?=
 =?utf-8?B?M1BEeEdNYWNJK3VQR2YySnpJZkdUcWhKdHp6TVF5dDB2a0l0YnRXWXBVOGlH?=
 =?utf-8?B?dkRDVGtkSmhjaXMwZWJzYmlDY0dwRXluY2lLSU1mRDZPODNDNHhOUlpVY1VV?=
 =?utf-8?B?UnJqcVpJOVJmWE9ROWV0SGxzYndzaEdSY2prZTROOG9mcUNuT01qcmc5UEVZ?=
 =?utf-8?B?a1l0OE5YUzBzRnowZ3JWcUFiQmx0R0M0SFJoUVVwTkJ1SlZ2eGtxREJPZFE0?=
 =?utf-8?Q?nP+HC5ZsOYF6CH2JlA/ICDKLt?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR19MB4885.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce3a5880-2bf2-4d84-c7ab-08dadd1fe36a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2022 15:37:05.5184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8zekNBKKsnSc76hzJA4XnNpgRJmryfcUHVA3BMqg0wG+vqYWUBmFeuBSD8Z/iWrkMT920JfQnvB6ARjeiYF5qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR19MB6593
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=686 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212130137
X-Proofpoint-GUID: itTLgo0szoJiRuXhyExcJlvb3OD-3AYl
X-Proofpoint-ORIG-GUID: itTLgo0szoJiRuXhyExcJlvb3OD-3AYl
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=799 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212130137
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221213_073719_596762_4B30D4A4 
X-CRM114-Status: GOOD (  15.53  )
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

SGkgY2ssDQp0aGFuayB5b3UgZm9yIHRoZSByZXZpZXcuDQp3aGF0J3Mgd3Jvbmcgd2l0aCB0aGUg
Y29tbWl0IGxvZyBmb3IgW1BBVENIIDEvMl0/DQoNCiINCiAgICBudm1lOiBhZGQgbnZtZV9vcGNv
ZGVfc3RyIGZ1bmN0aW9uIGZvciBhbGwgbnZtZSBjbWQgdHlwZXMNCiAgICANCiAgICBudm1lX29w
Y29kZV9zdHIgd2lsbCBoYW5kbGUgaW8vYWRtaW4vZmFicmljcyBvcHMNCiAgICANCiAgICBUaGlz
IGltcHJvdmVzIE5WTWUgZXJyb3JzIGxvZ2dpbmcNCiAgICANCiAgICBTaWduZWQtb2ZmLWJ5OiBB
bWl0IEVuZ2VsIDxBbWl0LkVuZ2VsQGRlbGwuY29tPiAiDQoNClRoYW5rcw0KQW1pdA0KDQotLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQ2hhaXRhbnlhIEt1bGthcm5pIDxjaGFpdGFu
eWFrQG52aWRpYS5jb20+IA0KU2VudDogTW9uZGF5LCAxMiBEZWNlbWJlciAyMDIyIDIyOjAxDQpU
bzogRW5nZWwsIEFtaXQgPEFtaXQuRW5nZWxARGVsbC5jb20+OyBzYWdpQGdyaW1iZXJnLm1lOyBs
aW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSBu
dm1lOiBhZGQgbnZtZV9vcGNvZGVfc3RyIGZ1bmN0aW9uIGZvciBhbGwgbnZtZSBjbWQgdHlwZXMN
Cg0KDQpbRVhURVJOQUwgRU1BSUxdIA0KDQpPbiAxMi8xMi8yMiAwNjoyNSwgYW1pdC5lbmdlbEBk
ZWxsLmNvbSB3cm90ZToNCj4gRnJvbTogQW1pdCBFbmdlbCA8QW1pdC5FbmdlbEBkZWxsLmNvbT4N
Cj4gDQo+IG52bWVfb3Bjb2RlX3N0ciB3aWxsIGhhbmRsZSBpby9hZG1pbi9mYWJyaWNzIG9wcw0K
PiANCj4gVGhpcyBpbXByb3ZlcyBOVk1lIGVycm9ycyBsb2dnaW5nDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBBbWl0IEVuZ2VsIDxBbWl0LkVuZ2VsQGRlbGwuY29tPg0KDQpmaXggdGhlIGNvbW1pdCBs
b2cuLi4NCg0KLWNrDQoNCg0K

