Return-Path: <SRS0=G7yG=I2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9251C433DB
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Mar 2021 05:14:04 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 200BD6196D
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Mar 2021 05:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 200BD6196D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZvXoshUBgm+FohLmRLc/mcqxVP8U3LyyNWFK7VgaAQQ=; b=LEgqY+tTQGImvckBWM4sy1DTc
	BDqy5WLLpPlIPSfB+BQR4EFWHEmqI4wExR2ansr/j7nO5IbB5xHIsi56FPTxDtyH7d7QZFcgC/kLI
	Dta43BLLPfIf0GwV96gBy9PTayvG6ltjQglj0FqvDv2npRFbpCxa54G17wFT0QZad1GITfiHiTt5v
	jY88I4xfZTrocvfzDDpgVYiTitfvt3GsYTm26gc2VET9+d2kMSmKjlvC27i1qFA+L3tSblr+vAmvS
	4BmVfE8uDk/GBDOkKiT8gztuZay0ZDZMCQ1720wcgD17TgK7+tR7sMurVOVrrW25MlPNz7r3Mshae
	dZ0Sm0WRg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lQNkG-005rca-V1; Sun, 28 Mar 2021 05:13:53 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lQNkA-005rbd-U4
 for linux-nvme@lists.infradead.org; Sun, 28 Mar 2021 05:13:50 +0000
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12S5BVgr015158; Sun, 28 Mar 2021 01:13:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=lhJW3W/7Gfdr/awRsJfv38YRBzkCKiUdOixsYDGDP98=;
 b=moSfcMeJQAjVwesA9pjRFsEEssvY1RJwSpTcSFbO+VpBUkNkIlyIvqOMu/h2m6dzleYz
 wNUKZfhabBpDT7fMEZww+nt0oqZsqICRwoU+V3Mzg6WXfmEAcNt5ttl+PbRoydKTfLqH
 sNKuQiUTnRige4RWRH9woNRLEmnK5A2+0C2EzMqVP+9yLpJVYmmn/5FL21r5n6jNtz1h
 BZz/bM8K53CaQ7C5EA7hah+1oXN8+fKb8G7mnOuhEez/atRG+ROv9+DH4oceI8bPjSAW
 XfvYEVJiemzIlWnPC5gsv0nzL96GsyVBCiifhCUYd0e4Nu7w+7tJdK4MXTZojLrngkkd 2w== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com with ESMTP id 37hyve1cyb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 28 Mar 2021 01:13:31 -0400
Received: from pps.filterd (m0134318.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12S5AFeC026624; Sun, 28 Mar 2021 01:13:30 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
 by mx0a-00154901.pphosted.com with ESMTP id 37jj9hgehy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 28 Mar 2021 01:13:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSFIiNFZr+sQgfYs2Z+w+JdmNlNaNSXK2JmVA0bkINRAHCQ9fT1TX/aKo5XAw5ijglPnRjlx6LLk3xVnYDGXLAszf4O8xHBs6eh7ndIQ9O0QhCFodi259tBaKMZIO+viDZjx+sChsqrXrEmxwjQdLQb+Z0SAv71G+bcV8yXVrmgle0BjL/YykBtzrfIM9y/lZjbA7/JXL4ezvyIAEsEjX6nvo3F0DBoupAUVrrUrpomrbVmBYg2WLL4yuEfMhcw0zUN50fB8EIJzfzWHrenOLC+17bwhCmirO5vbBVEg3vXP0m/BlUOEt72EfM47EIdW2n+qFy6DHglkoZnF9Rp6aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lhJW3W/7Gfdr/awRsJfv38YRBzkCKiUdOixsYDGDP98=;
 b=QDVOPxoHGtBjDd6FzykiwSSe2K5/fH757TcVg89uPlpV2Sv7kkfZHFtTStMdG93/IlEUmOzMUILgFOJRLtkQ0fEnUncarwTW+LNXHdz74vSum4Ii6Oi4MUpE5q57tr+dGIjouo4pIqhoLsf3pzaXdgKwxeRq42dX5odrjJ6GbxesZosWgfnVPLHXKLWUxkjGQ+ggt4wIEG/QCFRLWwAYHlkdcf+Xc++qLBLFaQhonS1kSKnxk/7wsIrHLgt1qw2pcH+jpJ40qjx2lHWv0iobIBmktDoNBxymGAw3ckXlK2t5l1l47Vr0Qi26VxKCdTUEuBQh6B04qloWoVisHk3SfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from BY5PR19MB4004.namprd19.prod.outlook.com (2603:10b6:a03:225::8)
 by BY3PR19MB4833.namprd19.prod.outlook.com (2603:10b6:a03:364::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Sun, 28 Mar
 2021 05:13:28 +0000
Received: from BY5PR19MB4004.namprd19.prod.outlook.com
 ([fe80::1d2:58f6:105c:918d]) by BY5PR19MB4004.namprd19.prod.outlook.com
 ([fe80::1d2:58f6:105c:918d%9]) with mapi id 15.20.3977.033; Sun, 28 Mar 2021
 05:13:27 +0000
From: "Grupi, Elad" <Elad.Grupi@dell.com>
To: Hou Pu <houpu.main@gmail.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: RE: [PATCH v2] nvmet-tcp: fix a segmentation fault during io parsing
 error
Thread-Topic: [PATCH v2] nvmet-tcp: fix a segmentation fault during io parsing
 error
Thread-Index: AQHXImnP12JJHSExREmbK5ZJuH7cCaqYyhCAgAANpSA=
Date: Sun, 28 Mar 2021 05:13:27 +0000
Message-ID: <BY5PR19MB400413D837B52BA22628A888EF7F9@BY5PR19MB4004.namprd19.prod.outlook.com>
References: <20210326175941.22734-1-elad.grupi@dell.com>
 <20210328040427.20895-1-houpu.main@gmail.com>
In-Reply-To: <20210328040427.20895-1-houpu.main@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Elad.Grupi@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-03-28T05:13:24.7601620Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=53ec6100-33d1-4d01-85f2-3b27cb4a9d5e;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=dell.com;
x-originating-ip: [77.126.55.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d2e9686-93cd-42d3-c394-08d8f1a8389b
x-ms-traffictypediagnostic: BY3PR19MB4833:
x-microsoft-antispam-prvs: <BY3PR19MB4833CF87BC11A306810749C9EF7F9@BY3PR19MB4833.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AZcH6y7nCyqKpztKaQA+1tYicn/woqoAberZK3fXixJqVlS1UNNYkSSsBtd5uxOHg6IF4OlZQzAczy19PZ7TBddbwBx/+VsFCuPep9LP+8kunVoG/+MW3KH4mw5vNnFZ/JKmitCUCeTu6gnZ62ZbEmfaeoMP5AMF7sjDbIvJYhZ3mJGWaj1XDHkFWYyT8LRfKsyXbt42lRWU5+sq11GQ5eSvgS1E2rduxyW3L5zkoaWxiFo1GJJ+q4ufARrSn+wwDac9WA4lzt02U4U3cOAo3cnpoPwEy7UWycufYsTAn//nvZjn+eYouyztF7ltjSmh+HW7Ke5gyU7p87AwOOIvU6/GWOgvs9k3k68YKMIE9hdCcWlSFFqo7JEKiHJ6TkXH9Pzq5lp+WXoEhNhlgY8eQeXgMEMCnLa6iW2MQWEz7Q4nj4ElH+aNtRsR/DJBrwgY4JqVh5QYg19lFd+tlEqKoh4zX+CgLkLtOXQLnxfSJW0+lujZWi8I8DIdJ1+5ZEPgO3/nItXF7SUTx4gdEdGUFJDF1WveOKwXMSWAE2Mab4lsuu7VXDP2gno1yOAi7TXv2IaK1CONWcajhhRt4erM8AtEgfkEJ+H0DsBp+Ti78FV7Ycrt3bkYETB5i9egnx4dxdJFLqpptLvzqSmswnmOjvYYZB5Zqrne8HW4cHphMno=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR19MB4004.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(64756008)(5660300002)(66446008)(71200400001)(66556008)(66946007)(66476007)(76116006)(2906002)(52536014)(33656002)(6916009)(316002)(83380400001)(786003)(9686003)(4326008)(55016002)(38100700001)(26005)(54906003)(186003)(8936002)(7696005)(86362001)(8676002)(6506007)(478600001)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?WituQ1IyNytFSmtkUllhNU8xWGJlOUY0b1JIekJZRjhneDJUdWorRG1DR1Y3?=
 =?utf-8?B?TkxDbXNjMDMrL2R2QlE4SU9iN0xlenNzMFU3Q21pUk80TXF2UGQva28zUzRr?=
 =?utf-8?B?UzZRTGp6UlYzNlE0UWkrWlZvd3ZvdDY2VzdJZUtsMkFoaFcrQ3ZNTkRTZUdV?=
 =?utf-8?B?L08zS2JUeG40bGRIRjFBWkc5elU3TVAyUGxVd21WOVBSN2RRQXVVZFNTYnk0?=
 =?utf-8?B?OU9RNXJudnRFTllpeDBFRmhzZGMyNnN3Vi9hVDBYVlhtTVRUOVVGeW5lTk1p?=
 =?utf-8?B?bVdPRHRnN0ZnSmdtSTY5cEYyNDlCQlRQZFpFN2pDYUZWRUR6UkN2M2J5UVZT?=
 =?utf-8?B?VnZmUmNCRmZhV000bDdMRTgxUmxmcy9aallKMllzcjI4dGhSTW55YTdnZTZP?=
 =?utf-8?B?bEhGdTdzZGdpZXBra0hwYWxyd3J1bXU4WVFkN3J3Q0Y0WUc3eW1wU2FPNDRG?=
 =?utf-8?B?Q3NRK2hhbFBSZTZIVnhVWHQ1dTZxM3VzeXlJQkNJVlBZeE05ZVlUdmpzd3M3?=
 =?utf-8?B?UkpVVG9Ic0U3Um5QdEZlS0kvdCtQaGtjc3pxMXZYSWNqa1FlRUxkTnh0TE40?=
 =?utf-8?B?N3FqWUFwcklDK3hVN2J1d0dySEJvVTFZYk5mblE2UFZRZU5WYVgvWU1Xdmlh?=
 =?utf-8?B?OXZXSXVrZjBpbmVoc2ZWakpHbk5hY256TVRETHdZKzBINXZZemZOWTFrU0N2?=
 =?utf-8?B?TWFVY2tBbk5ucmJEc1Jmd2FZSTAzYUJjeHdoUG8yTDJtTHhDV0tOTGdYMitY?=
 =?utf-8?B?TlBuVmFtYUJBREIvUkllQkgwRVlMRHpnUDNGMk1YN2FTV0NCMjdydUdHaWFR?=
 =?utf-8?B?K0dMYmJhTFptNHBKNkl5d21ZRXBtUjZRR3Y5UXhUTkJBbjVBRkF6K1huTFNG?=
 =?utf-8?B?WDRXU3oyUk5ROS92Z28vY09ONzRyTzByRGJJZCtZZWZNTmJGUFZwZjhHTlhJ?=
 =?utf-8?B?WWI1WHRFeit6NGNiQWFiWWNlR0ZsR2ZEcEIzZ0VIM1NIRXNrNVdCcTR5dUlR?=
 =?utf-8?B?VmNad3p5SWVLdnlMeEZ6YXNhZ1ZQRERZUE1qN3lCSHNuc3JJVEFQKzVUdEIv?=
 =?utf-8?B?RnRSNFFkOXBhNU1uZDZtTzduN1ZRKzUxMXZmK0Ewc3FlMXlxeTh4cjlFR0hw?=
 =?utf-8?B?NUZGVDlxZHZvYlp2V0VwazFYMlhDS1dUV3JlNHpOSHNVYmlZOFNVang3dHhi?=
 =?utf-8?B?eXhSS0t2cXBtbFJsdTR0TGY3WWlwU25pR05xUXpuaklTM1VhdEVKNEgvSTBX?=
 =?utf-8?B?cjJHNVlNN211cmFKc1dHM0dMaVF6RVdkN3FjTHhwa3V4NThxTUh0UlRWY3JZ?=
 =?utf-8?B?ZEc1SSt3aFdPdUlMamt3RFJCWnJ5cXFJRnF2ODhjYjBzSlRsVEszaU5UQk92?=
 =?utf-8?B?R1FSTGcrRzBjWXNINlRGRjFNRCtPWmNZWDdtNkhCMER4QjlZbU80ZDQxaFdW?=
 =?utf-8?B?YnFDckF0VjcvV25qNkFmd1paSXFWYTRMMUd5eEkxSGY2ZUpPUXQvMWNlazgy?=
 =?utf-8?B?TkhEVThkYnZIdjhlL2RPUWRFNlZ4dEptSXpPQTRxcFFpaXRYMVhxblQ3bXRy?=
 =?utf-8?B?MUR1K2YrNk5WZ0YxUXdoWWJjeDVMSHFDb1lxNGZpOWFNNkdEam9FcGVQRVNw?=
 =?utf-8?B?dHVqa2hXZnBTeFhOUWYxc3gyMHdSMEtTT2hGN3I3TGZQYkZsQlFUS0JWaEVj?=
 =?utf-8?B?U3JxZ3ZlSDRndlF5WnJZcVZNT1hUV0RNME8vYVpyYlJUb2JVa1dPbzB5eXBT?=
 =?utf-8?Q?8pe59E1rmL5vnhJCRqf6ciGgQQT2lQCQV7+DZQh?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR19MB4004.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d2e9686-93cd-42d3-c394-08d8f1a8389b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2021 05:13:27.6878 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uAsOKL7cwbKJ3ectpaIGigRwvzYUQPYlQuz/LTRT8wcIQCB37csbDblCSaoFr4TXFRrzeFPlX3d8YCTxjcNcsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR19MB4833
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.761
 definitions=2021-03-28_04:2021-03-26,
 2021-03-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103280038
X-Proofpoint-GUID: bVoLDHIHgoE6y35OAmH7zed8Ojx01HSk
X-Proofpoint-ORIG-GUID: bVoLDHIHgoE6y35OAmH7zed8Ojx01HSk
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 spamscore=0 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103280038
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210328_061347_572477_9E8A1BC6 
X-CRM114-Status: GOOD (  34.48  )
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

Hi Hou

Even with the code below we will still queue the failed REQ for the first time.

Please mind the code in nvmet_tcp_done_recv_pdu:
1. nvmet_req_init will call __nvmet_req_complete with an error status
1.1. __nvmet_req_complete will call nvmet_tcp_queue_response
2. nvmet_tcp_handle_req_failure will set the flag NVMET_TCP_F_INIT_FAILED

In step 1.1, the failed REQ will be added to the queue anyway because the flag wasn't set yet.

In the previous patch I was adding the REQ back to the queue on nvmet_tcp_fetch_cmd, so it was useful to prevent queueing the REQ over and over again.
Now I removed that part from the patch, so it means that the REQ will be added only once.

Elad

-----Original Message-----
From: Hou Pu <houpu.main@gmail.com> 
Sent: Sunday, 28 March 2021 7:04
To: Grupi, Elad
Cc: linux-nvme@lists.infradead.org; sagi@grimberg.me; houpu.main@gmail.com
Subject: RE: [PATCH v2] nvmet-tcp: fix a segmentation fault during io parsing error


[EXTERNAL EMAIL] 

On Date: Fri, 26 Mar 2021 20:59:41 +0300, Elad Grupi wrote:
> In case there is an io that contains inline data and it goes to 
> parsing error flow, command response will free command and iov before 
> clearing the data on the socket buffer.
> This will delay the command response until receive flow is completed.
> 
> Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
> Signed-off-by: Elad Grupi <elad.grupi@dell.com>
> ---
>  drivers/nvme/target/tcp.c | 29 +++++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)

Hi Elad,
Just noticed that we still queue the failed REQ to the response queue in this version. Am I missing something?

Is this still needed? (I think it is).
@@ -526,6 +527,12 @@ static void nvmet_tcp_queue_response(struct nvmet_req *req)
 		container_of(req, struct nvmet_tcp_cmd, req);
 	struct nvmet_tcp_queue	*queue = cmd->queue;
 
+	if (unlikely((cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
+			nvmet_tcp_has_inline_data(cmd))) {
+		/* fail the cmd when we finish processing the inline data */
+		return;
+	}
+


Thanks,
Hou

> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c 
> index 70cc507d1565..3bc0caa47873 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -702,6 +702,17 @@ static int nvmet_tcp_try_send_one(struct nvmet_tcp_queue *queue,
>  			return 0;
>  	}
> 
> +	if (unlikely((cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
> +			nvmet_tcp_has_data_in(cmd) &&
> +			nvmet_tcp_has_inline_data(cmd))) {
> +		/*
> +		 * wait for inline data before processing the response
> +		 * so the iov will not be freed
> +		 */
> +		queue->snd_cmd = NULL;
> +		goto done_send;
> +	}
> +
>  	if (cmd->state == NVMET_TCP_SEND_DATA_PDU) {
>  		ret = nvmet_try_send_data_pdu(cmd);
>  		if (ret <= 0)
> @@ -1103,9 +1114,11 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
>  		return 0;
>  	}
> 
> -	if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
> -	    cmd->rbytes_done == cmd->req.transfer_len) {
> -		cmd->req.execute(&cmd->req);
> +	if (cmd->rbytes_done == cmd->req.transfer_len) {
> +		if (unlikely(cmd->flags & NVMET_TCP_F_INIT_FAILED))
> +			nvmet_tcp_queue_response(&cmd->req);
> +		else
> +			cmd->req.execute(&cmd->req);
>  	}
> 
>  	nvmet_prepare_receive_pdu(queue);
> @@ -1143,9 +1156,13 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
>  		goto out;
>  	}
> 
> -	if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
> -	    cmd->rbytes_done == cmd->req.transfer_len)
> -		cmd->req.execute(&cmd->req);
> +	if (cmd->rbytes_done == cmd->req.transfer_len) {
> +		if (unlikely(cmd->flags & NVMET_TCP_F_INIT_FAILED))
> +			nvmet_tcp_queue_response(&cmd->req);
> +		else
> +			cmd->req.execute(&cmd->req);
> +	}
> +
>  	ret = 0;
>  out:
>  	nvmet_prepare_receive_pdu(queue);

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
