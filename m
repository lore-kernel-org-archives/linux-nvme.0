Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C935C54EBE
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Jan 2023 18:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lj45XIYdyWfMOyQ++T0IApXQjA+Yd2f7bWytbsjKAqo=; b=aPEG3si6DaCqeePJ6X7gqJ27HQ
	+No0v9C1J/wGJ9r5TPbMpWG03TVAx52wfOuuuCpC9lQE/ejALDcPJgucQmu8qVwg4SE9TFuwe7n8D
	eOfrywC4eiKjavSnWRkyFqHZSjlLSWvUKQIg11QE+uGUHZNCQuUNzaeVkuZ0hPPL1Ic1mY1me42t7
	30Aum7ORspb+pBeRFjgEF+FZ46IDq+rG6eNoQzSSE5uoU4EuO01+OqS3m0Wqm9yXco/hKKbOsgI1W
	HCvjLbNcqnLD5dfTJqVuoIrl8136/QvneQ8Xg/Sq5QEELURMhXzN8es4m7rr8rWY5cRsJtQkYN8B1
	0r4gw2hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEass-00FNZx-P0; Sun, 08 Jan 2023 18:59:07 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEasq-00FNYw-1n
	for linux-nvme@lists.infradead.org; Sun, 08 Jan 2023 18:59:05 +0000
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 308H3NtP020995;
	Sun, 8 Jan 2023 13:58:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=Lj45XIYdyWfMOyQ++T0IApXQjA+Yd2f7bWytbsjKAqo=;
 b=v7yYSeFAnFOJm7wL4iV/qKXGlMJEaY6rHffo3j2nM8I0FRjlih58gDyqbREOAQuN9055
 evqpFGW9fnl3+LFBVukmxatmnh/wlkSz42kjdyTzhUSBdIgDc3xY6XRMQyxXerlECgM2
 EZw09WN3S+mvMzeqj2EhseKQP08rs54A/T8A5wiqEYPPRUKadnAEwbVKjNHGlj07BFpo
 sLuA0CnczbDi7eexqEMiPAJZH9kYYM2cZ7iaWZjOkLMlvx2Ww0pGRLbn4HGhO57RuMp9
 UKLUOvn3dqrz9/FXo6WP0tNCjN0Tcroo1r/mpBjKbaioDZIh0SZOB3aZzshRMU3a/qWI aw== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 3my69wt6k5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 08 Jan 2023 13:58:43 -0500
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 308IVjgK031503;
	Sun, 8 Jan 2023 13:58:42 -0500
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 3my3g0p1ju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 08 Jan 2023 13:58:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mCJ81k6jaATnO9820pkHGvcJUEbCR/n9w1dBsihm6bEaGZOYtBFuDLKH/+SeNBX8Z3G3BZnVgVDhfjENUoLu8SKWiZTgoe3Oz/kWSYngGnLt62DBH7ECAzh84afWt5WCNcP83nYaH3qYYQtoj4iQptE0/PK/T5bmJDivjfCsmM8RA9LuqJLfDxjpEZYN7WajV3fB9iWHs6+jPE1tNFe/YKppA/gRn0uALnwlEPEgr7E+W2Ua4SzYkuyyioZKKGCTMIFRZ+29qAH9V4S6SMP0RRSGXjC2HjCuFk03E6UwoxzsB6jxLpL9u9Ap3z3u8OO3KiIsykoSCR6mzyxNrKjGVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lj45XIYdyWfMOyQ++T0IApXQjA+Yd2f7bWytbsjKAqo=;
 b=Dumfn93kKXwmchaJnvHJEq9Ojk0+1X8kzLbX4zv8y8ZByytHcWwYdwm1u28j4DupF+vxXu54BqEeldDkE2jCpXk0JgKNEXyCgIRkEveGRZLxSG7Y8GkPpfhBnrb5j01H6gsVhVTjyf29Ykba5tkYCpER8AVPDxwMJRJD71xHT9izPm0Q0W8sQ21vK5Yuj93P0IWsezow549jqm/RI+51YJHcE58k7EqIDMfOtgMRAzuryYm+ZGg3pbfaycD7+KaG43WfpvIC3Esgney3Nvfsy9tUiqKE1Uqn2ese61Cuj0aE4oVfybK4IH9kgI+hz8TzqaQfB9+McrGBzuB/csf96A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from CO1PR19MB4885.namprd19.prod.outlook.com (2603:10b6:303:f5::17)
 by MN2PR19MB4078.namprd19.prod.outlook.com (2603:10b6:208:1e4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Sun, 8 Jan
 2023 18:58:39 +0000
Received: from CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::71ae:4884:8c52:6169]) by CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::71ae:4884:8c52:6169%9]) with mapi id 15.20.5986.018; Sun, 8 Jan 2023
 18:58:39 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "Grupi,
 Elad" <Elad.Grupi@dell.com>,
        "Zinger, Eldad" <Eldad.Zinger@dell.com>
Subject: RE: nvmet_check_data_len() wrong behavior for nvme admin set features
 cmd
Thread-Topic: nvmet_check_data_len() wrong behavior for nvme admin set
 features cmd
Thread-Index: AQHZH3Qek1Bkt4f4YkGpY8Ga9cAU0a6MrPtwgAFdySCABqJ3AIAAOcOw
Date: Sun, 8 Jan 2023 18:58:39 +0000
Message-ID:  <CO1PR19MB48851F01CCD7D5A803179D27EEF99@CO1PR19MB4885.namprd19.prod.outlook.com>
References:  <CO1PR19MB48850262EAB600869034D420EEF49@CO1PR19MB4885.namprd19.prod.outlook.com>
 <b8154d21-d009-1077-e07d-980b249a56c3@grimberg.me>
 <CO1PR19MB4885EF6A9AE5135487F853BAEEF49@CO1PR19MB4885.namprd19.prod.outlook.com>
 <CO1PR19MB4885CDE3B335B9EAC0B7192DEEF59@CO1PR19MB4885.namprd19.prod.outlook.com>
 <ee184cf2-991a-1f78-9adf-c56cdd610e01@grimberg.me>
In-Reply-To: <ee184cf2-991a-1f78-9adf-c56cdd610e01@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Enabled=true;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SetDate=2023-01-08T18:58:21Z;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Method=Privileged;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Name=Public No Visual Label;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ActionId=ee7b72c2-09fb-4f77-8ca5-8d75529e3c77;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ContentBits=0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR19MB4885:EE_|MN2PR19MB4078:EE_
x-ms-office365-filtering-correlation-id: 34cc7280-daba-4fa2-76db-08daf1aa5a84
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  gpwNbDqOdqMKT2K5ROj+MibhiXP4IuzFQHKcf9TrUgHBUkRmc+IZvsfoZAjpCeCNKi0A8qGtHrefV13Dmj60tZ6b/O2AmNTJPsRshdVGvPvoojfYNAqAbc/RqhEEnCmGIjRtomHFLmsTybElgeGB/XNbJEYkA0ICru+HSnxI2wnl26afD1o6tDtC15gu7Sj3D/k93tNEbpHFfctKmCPuhuw/G+C3vW/0XXXSw222QVbMRGf9VYQDxV8siFo1AbqYu3wV0l0eeN7kvDoludCL+3wV6C4UT5z+YlwBimjhPDgAzEb5IDFG+4nznVcGl4CpOTK7bCIuZDJj+wypEmUdAV+nyOgPVs9aTjpq+n+kqg7p7dd5OC8kEGyCl2f84MkoCi/lmYqmnj6QNA3fm1EXz0rnNA6pB/bLOzMfz+PyStrG+V7mbs9jR6LjuNstepVg/gAlezIN+XtfGjyUPg9jFRU6+NqO4TrfUn1h4z1985cE9tSoKDhcGNBVc+sXkvT27WLjvx0MrUzn1Wvcx8uLee3M9Hk+KbCowxNLVSDxOl2mf1HV3jppTlYUaYz/M95bBI5rOh9NxaL0Xl/YdV6kiPDqbLthzgYzZheAC/0uMnbUSazhuh80wTMPp80NwcWlGwj6HtSeKJGJs28zlXWtcLRSI2TPwDsi13Gq1Q0xUJ4L9umUQvdwKlJvao3uKaPiGjcQKLkgzlDgbKKUBagobA==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR19MB4885.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(39860400002)(366004)(136003)(451199015)(2906002)(786003)(107886003)(4744005)(8936002)(5660300002)(66446008)(52536014)(41300700001)(33656002)(66946007)(64756008)(4326008)(76116006)(38100700002)(66476007)(66556008)(8676002)(83380400001)(86362001)(82960400001)(316002)(6916009)(55016003)(9686003)(54906003)(186003)(26005)(38070700005)(478600001)(7696005)(71200400001)(53546011)(6506007)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?N0g3bGtiRVJrODBTWmlzNlVTS25qNmdla0dzVEpmbGNrcm9uY3hkeGQ0a1M0?=
 =?utf-8?B?cndTYjJQTjEvZFB2YWF5T1c4a1R4Tm1rM3Z2WTdqWEI0U1U1d2FWZGNFL1lK?=
 =?utf-8?B?NlFTTG8rUDdOR1NZWkNBenNHRkZzM2txcjh5T2UyWk9nU1A5M0hKQXl2VTJW?=
 =?utf-8?B?eGszQ1B6aFp5NHNMRTUrOFZ1UzdLbDJYSWcvQTFwQlB0azI1UVBsSEk3Vlk5?=
 =?utf-8?B?YUt5QXVtWkFyNEVpUitTaXFKZ01qN0VQdXlrLzlZMS9zN0NCZktwdVRXcTU3?=
 =?utf-8?B?ZVBuNUFRcWtEVldodUVHeW1la2RhbnVzZnVLK3ZVM3JMeXZBakRKSTFRRm5B?=
 =?utf-8?B?Q0NDdTFZRXh4dUkxamFsVEg3ckFtditwQ1FSU1MyOGlTWVJjYlZQbjZVeERJ?=
 =?utf-8?B?MEdnVUcyQXdPdUFHMjhzQk13UTRkdTdVa0FRK3lqS2R1Y2Q1aUNtenBDMHc4?=
 =?utf-8?B?ZHBsRWoyUEJsU3lSaVBIcy9yMEFkUGhtbkUvdGNxSE42cm1PN0p2bk5ZdWxJ?=
 =?utf-8?B?SGtrczVYbDh2N3N1QzhsaDdBOXkxWmtzYnhZMXc3Q0kvM3NZa0c0eEtkMUMz?=
 =?utf-8?B?eWlURzUycHByOVc1bjQxVjJqRUdaVGczZWJyMXFKdFBudkdSYjNOTUhnajZG?=
 =?utf-8?B?NEo1UHpDZkZGSjNUeVo4UnRBdEFULzRrUjdhV0dlNGJNNWs1NDIxSCtVT0ly?=
 =?utf-8?B?ZFErMXpRMFJyU0VheEZJdGpNUXVsTk5KQTFJUSs1LzIyRTBPdHYyaEdNRUdu?=
 =?utf-8?B?V1ZObzVPd3ZwektubXYvZDF5WmxxRDY4cENXNDl5Wi8yMnFFQ3c3OVFhWnVu?=
 =?utf-8?B?YWwvQUFMMnBMVFdJMDZEZnlheWJNaEFWazIwVDRoMVJTV09nQ2FQb1NiU0RU?=
 =?utf-8?B?MTF5STNGMTZGWXUydWZTakN6K0p0OFlSNkE2VkxwNWhUa0x5NnprTG1hdlVy?=
 =?utf-8?B?SkRBWitVRm15Z05CanJqNDJ5WXZtTzh4d3lvRGY4dVIrSmE3TEkvZUVMOXZ5?=
 =?utf-8?B?VXZKY0g3SUplTHdPSWhCakpDTElwSFY2MjZaYUhEZnRWZkltc0FGZzFMZkFZ?=
 =?utf-8?B?SXdkcm9XUkVoaUZEYUUvQWtlV2NvdHdoeTlhTXBJMGg0emNMSENWbEFCcXRR?=
 =?utf-8?B?eHJ5N3lqeGFXZ0VGTzNqZXlUVWlIL3VPaWFUWFV0RmY1cHFBTXFHZ1lyY0F3?=
 =?utf-8?B?ZjdnL1YwMzVJKzZJMUJOazdhWExYdEtmc0FkUzRucjM5cDI5UUNLeFJUcU5j?=
 =?utf-8?B?a1d2bktndnpHdy9mdFNuMERhOVppZ0t4dHNIUE42S3MwdkgxbHlhSFovVitl?=
 =?utf-8?B?T1pPUWtCMm5KSkc1UmR3WTZ2SWhjTVNvNkJ6ZGxZRW5xTlp6eGsrMThRUlJh?=
 =?utf-8?B?MU93ZnY4NHlESWFGQzFjYjRidFh2Wjd0V3QzcjhTdGVNK25sYjBaOTNtcFNn?=
 =?utf-8?B?NFNvVUZXUDJScXpSVzJwRHNKMkpaYjZ1UE9nekVNNzBDRGJ0dWRYZWNnVFBk?=
 =?utf-8?B?WlRCNWlydU1vZGVGYzhGSDEvd0YxdUtERlo1ZzY0SkRIaktUT0wwQzgyVk0v?=
 =?utf-8?B?SEZVdlVDYy82UW1hbm1ORFRHZEMvcDlpdExTZjByTVFsOWhKY3ViZkU2Tm95?=
 =?utf-8?B?MDl5aDdlZ1ordmF1aHNIRC8zaG1EbDZ2V3RhMHZycVAxSURVanVLVXRnM2RV?=
 =?utf-8?B?bklnUDRGakl0NVg3dEUxR1pCSDBqUWVnTFBxaVkzYlRDZlRpZ3l0V0dyNnU3?=
 =?utf-8?B?aTlQbzA1WkdKNGdOSi9qUTRab2drTnpmVUNkbXJYOUp6TjVkNExkODhiOUdz?=
 =?utf-8?B?ci83UERCVXQveURwQ3d6aG8vZHRwb0Y1UXZ3eHh6b1paTTlmQlkwV3RFUXdT?=
 =?utf-8?B?UFVoaUtsQ09lUyt4V0Qza1F3YmUrZEFRZGpWMEg2SDRtUWFjaTNad3ZmWVFx?=
 =?utf-8?B?bE9VZjhqSmpyY1hWQ0Fpb2ZWQU5xbGg5VkxMZGRDZWtNeGVzcjVXd244UElw?=
 =?utf-8?B?dE9aN25NUWgwbHJDR3AyUjZWV2F4Wm9tVmw1VDZMNVhWYkVYT2F6a2hTa3h5?=
 =?utf-8?B?QW94VVVvMktROEg4K3pWWlRQT0JsVThOOWptM2NWRVllNk5ENGQwZWtyTC9O?=
 =?utf-8?Q?IaYoCMjYNFB/HNf7k6hc/3IjU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR19MB4885.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34cc7280-daba-4fa2-76db-08daf1aa5a84
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2023 18:58:39.1242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8RtOlQQuWIYPRNaGKiDwUAS6X4WKfYnpNCG8h+FhwyBbmwiSzQnVPprb9PAD1MYyujA6W7hOegxKVNI+eB7OwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB4078
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-08_15,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 mlxlogscore=807 adultscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301080141
X-Proofpoint-GUID: 54nzIe20UUM6oOkrpQZvi0P17P2ENz8e
X-Proofpoint-ORIG-GUID: 54nzIe20UUM6oOkrpQZvi0P17P2ENz8e
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=907 bulkscore=0
 suspectscore=0 phishscore=0 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301080141
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230108_105904_330163_15B04E3C 
X-CRM114-Status: GOOD (  13.80  )
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

T2sgc3VyZQ0KDQpUaGFua3MsDQpBbWl0DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpG
cm9tOiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJnLm1lPiANClNlbnQ6IFN1bmRheSwgOCBK
YW51YXJ5IDIwMjMgMTc6MzANClRvOiBFbmdlbCwgQW1pdCA8QW1pdC5FbmdlbEBEZWxsLmNvbT4N
CkNjOiBsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmc7IEdydXBpLCBFbGFkIDxFbGFkLkdy
dXBpQGRlbGwuY29tPjsgWmluZ2VyLCBFbGRhZCA8RWxkYWQuWmluZ2VyQGRlbGwuY29tPg0KU3Vi
amVjdDogUmU6IG52bWV0X2NoZWNrX2RhdGFfbGVuKCkgd3JvbmcgYmVoYXZpb3IgZm9yIG52bWUg
YWRtaW4gc2V0IGZlYXR1cmVzIGNtZA0KDQoNCltFWFRFUk5BTCBFTUFJTF0gDQoNCg0KPiBCeSB0
aGUgd2F5LCB3aHkgbm90IGFsd2F5cyBjYWxsIG52bWV0X2NoZWNrX2RhdGFfbGVuX2x0ZSgpID8N
Cj4gDQo+IERvbuKAmXQgd2UgYWdyZWUgdGhhdCB0aGUgaG9zdCBpcyBhbGxvd2VkIHRvIHNlbmQg
c2dsIGRlc2NyaWJpbmcgYSBidWZmZXIgdGhhdCBpcyBsYXJnZXIgdGhhbiB0aGUgcGF5bG9hZCBm
b3IgYW55IG52bWUgaW8vYWRtaW4gY21kID8NCj4gKGFuZCBub3Qgb25seSBmb3IgZHNtIC8gc2V0
X2ZlYXR1cmVzIGNtZCkNCg0KSSB0aGluayB3ZSdyZSBiZXR0ZXIgb2ZmIHdpdGggYSB0aWdodGVy
IGNoZWNrLCB0byBhdm9pZCBwb3NzaWJsZSBidWdzLg0K

