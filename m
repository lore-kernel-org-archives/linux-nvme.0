Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E062DC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 17 May 2022 15:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/MWuiRcX3NbSK6FHK0esuJcyTAegtuX5Y3I6EpGfmjE=; b=YgqwgIPcrp3BLOwtY5sIIgvW/X
	+lFkAF9iNTayQ2qmKuoGDDvD6M8nn+mFfsci1HtQkk2jjpR6lhvcaEDqbLaCEOGiogBhopHXagjz/
	BPn/+J7UivVzN42C9HI+eSNBfmWXFGv/ZRCmvYWteJN8AYPK9rN1rUKo89ed4Oh2vN0AALQ8h/Flk
	m+uXhhVDJzTABgJ4bQO0JXjD/daPWWczOLkiw2VXqhODo1umogQhmlqPxmij1L+TbVWYMH15DLUz8
	DT2EvpttPvBOa55QsxL1k8b33WFD7G4IKUpkAygYfreVyCMHeggH/A+SElXXW4TflQbtwEPLpA9lH
	mpPp7jJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nqylU-00Eaqo-SF; Tue, 17 May 2022 15:05:36 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nqylR-00Eapg-Ef
 for linux-nvme@lists.infradead.org; Tue, 17 May 2022 15:05:35 +0000
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24HC3LD0023496;
 Tue, 17 May 2022 11:05:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=/MWuiRcX3NbSK6FHK0esuJcyTAegtuX5Y3I6EpGfmjE=;
 b=kUOdMFBYXfjclQOkKHipkI7bxkAvrhMWr69RJT4btaodkjP/FzeNjsNGAawk3OWS7OIM
 cYTTe23YBS7JKh8FMlOR6xCtmgCTRlQ1SHDvEv8nYLbgzOGgPsiMNYrEI6AzFplJMna/
 YKecUqqtnmtEd2SavZOUXHUPsN0x/071mscWdSn1p5ktyCW5d08Yys3DkgukfOCaVDo+
 UzAMXNP7Bdpec1ImvqRFBomqcxQK29lwSPAaMiB8yG+ezZip7VvnJBjyn1mViitOsmsP
 eFJyqQWD9RozMpHlgYykL0FIepPUNKCSoyIaQFhL3+PQ7cKWx8doIIB1/T4xaGdjZVdk ag== 
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 3g27k0upxb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 May 2022 11:05:26 -0400
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24HEbx9Z028004;
 Tue, 17 May 2022 11:05:25 -0400
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam08lp2170.outbound.protection.outlook.com [104.47.73.170])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 3g45r18ktj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 May 2022 11:05:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCK1PObRSt0Zjn/y2ES32f1c6O+Klb2tSZATrUkIBjEMUv60IjT5bxHYCRuodDmDZhiuMU9C1681Cqbn1rbkrxrYdEBarDi7mbrlXxZNF15FlNmWewr+bta0v3vM5JQNihhqLX2xjULUEmZgVRTY3dsxBt3ffQGYutGdlSd2NNDavEn2epdDudf88Z4h4Pu81xE/CGdwHf45mzG9LIAJOthzlxl89VVJ6ewBujNNzVb9C2fkDC+fn2/67ng1g2xsAk8fToMDLpVp0KSBnDXMz3wkqD7Emc4VXMoknzn/x/mKyUDX7F+kCb9nNJrlcM+iYqf5ebw8Tg2JKASazpl+zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/MWuiRcX3NbSK6FHK0esuJcyTAegtuX5Y3I6EpGfmjE=;
 b=JMhKgOAUTiQU1u35IxyadZ21l2X0BmwVpS5CZHgI2aMKpVxu3B59uZIs56a8azI8NaUyD0RGn1OZ0TbOyqup2tLQZFf/RlbQRUFipdY8Fts5xgh5biiAZCLeIoEZngPwCPg/smvX4kBkRW4eooAfZ6TNHlBTA61KDUvg8Qkso3wkHAJyz6VeQ4aFOAlfsnz/AdAql0s4WFU4pefxtrJEjNldoEQVlRZQFBZZ0jv/hs5i7tLYPx0pY49gtwul/7/+/treOcp+82wfV12H5aSz3N13BEKs7rJnj+vZyf9TQBM9hQB3XcdSYqNItby64oCUjvARHuFoTCucUNYKxDeCGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from CO1PR19MB4885.namprd19.prod.outlook.com (2603:10b6:303:f5::17)
 by DM6PR19MB4373.namprd19.prod.outlook.com (2603:10b6:5:2bf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 15:05:22 +0000
Received: from CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::ad61:62aa:3372:61cf]) by CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::ad61:62aa:3372:61cf%7]) with mapi id 15.20.5273.013; Tue, 17 May 2022
 15:05:22 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: "Grupi, Elad" <Elad.Grupi@dell.com>
Subject: RE: kernel panic due to a nvmet race
Thread-Topic: kernel panic due to a nvmet race
Thread-Index: Adhp21iJ9u9jG5zsSGGi8oBfAS1jxQAEZqcAAASRRyA=
Date: Tue, 17 May 2022 15:05:22 +0000
Message-ID: <CO1PR19MB48850C38576C102DF8B5D0F6EECE9@CO1PR19MB4885.namprd19.prod.outlook.com>
References: <CO1PR19MB4885A916016D38EF6CFD07B6EECE9@CO1PR19MB4885.namprd19.prod.outlook.com>
 <b5f0557f-bccc-e19f-bf66-7de1f891b6e2@grimberg.me>
In-Reply-To: <b5f0557f-bccc-e19f-bf66-7de1f891b6e2@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2022-05-17T15:05:19Z; 
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No Protection (Label
 Only) - Internal Use;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=0c582443-77bd-494e-8a79-a8f9f6fa6a0d;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23ad089e-89ba-4bc8-d223-08da3816aa8d
x-ms-traffictypediagnostic: DM6PR19MB4373:EE_
x-microsoft-antispam-prvs: <DM6PR19MB4373660674715F63F2CE1E89EECE9@DM6PR19MB4373.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UatodXUzMnRrw8vGfDdyQ1ZD5J9xTAWKbiYSeda0kTNpwLRz4nUv9EtcBhyxVrZI7+GJ+v+JROQxSpr+Ix8f87jkgeB8xPrWrK6CYQkhwd46L5V5FwTeDjQY8bIYQC9WZ8m/fZ0sw1ZBlx4Sydq5HjSq7U27BfQOBgXx9COuA95iMw4HpeZGfgElwPMdz5QjCNk6Rbpap2fC2f3vlXaDrVCqVEHPL7yvA+QASfvakUOTSaByxJ9Wg6C1bXU0zZOpzm0fzJRd3O/QT6LazEVbtkOqHVzAf+N+2NCn6YSCSbrD4igSRNI/szQhZXTFHkjfjOHhbZ0J3GZ69l55I7TSR/Vb4uLibncuXkbKukDMGEkNOf7j+O4nboBVKTFH8Bc4lrWZ17uazqTKIlcSLOPAHx/tDNk8UPzt5srz71I6m8UIArUJpNB1eQaAg7JX4H4klzYXu6CPwBbu4zTIzm/t+9AmMF9C5wdpeuF/lAVdVDMKFs5A3lWHkY+mWTwBNojQOxIWNL7e7/FaHU1J0L1cb3cofmP53cDEBBfVAu/ohTiaU/T6bkhvUb1c1iqduZQJXXmCRyR1SzAlyZ4TxS0k0xE3fYhRYHYlIGxee4yFycTYgrSYYfr3NRhJqb/tL0P4rsjuRhBGBOuPbq1u8kSnWVS+u0/R8Qa61bUV/KZJ2+g59awC6JT3vcUUER2tJHfhRm7wRTO9g9/JWYnru4zKsA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR19MB4885.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(508600001)(71200400001)(82960400001)(5660300002)(786003)(38100700002)(38070700005)(33656002)(110136005)(316002)(8676002)(64756008)(66446008)(66556008)(66946007)(52536014)(8936002)(4326008)(7696005)(83380400001)(26005)(107886003)(6506007)(9686003)(186003)(53546011)(86362001)(122000001)(76116006)(55016003)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NDFYTnpPZ0xrOUhROWZJUm9SWUtOTDd1M2txeTFqLzR4QkZGNFZibXlHcFBi?=
 =?utf-8?B?cERPWTdGSndYS2RaS0Jtcmd2cFprRGl5MDFZMVZYNlRRM2RjckVrWTZrZXQv?=
 =?utf-8?B?ZDRNcVlNVlJkRms3N214VXQrL2kvQ2RkYlllallvSHNreDg4K0xSeXRGN3V5?=
 =?utf-8?B?aXdDQUVkTHg2L0cxcTNZNWdlMzdpaWhkRkpNdUc5N1JOU3d6cDMwaWEvNUhI?=
 =?utf-8?B?WEdWcDdQY0swcEpKRDA2N3Z4TWFTdXZ6c3Badmt5Wml0bDl4RWxGcnQ4YzZp?=
 =?utf-8?B?eVBvYU5XNmNJMnlLQ0ExNnlvRVNJci9aRitGUkJoVlR3Q291R2VDNzJGd3ZW?=
 =?utf-8?B?MUF0YVI1SW9xTk9BQVZoekFDa2JQd0h5d2lhM3Q4dEc5Yit6MVlwZy8zOHY0?=
 =?utf-8?B?bjJ2NEpNNW1jdHNmUlRGSHZyL0duNElOSCtSWTdadUQ0angxU2h2cnFVOXJV?=
 =?utf-8?B?QnN1R1U0MjhrWEJ4MWxXMEpLcnBsZHpVcElwV0UxNnhWTlBLb0svR1ErRzJl?=
 =?utf-8?B?ZEdIcmNLNUltMHhtNHd4dXYvTVZpNTRFT0NuVzRXblh1T05uZE5SVEJvbnVr?=
 =?utf-8?B?T0IwUUx2M1BFQzhrZENwZkhNWW9wem5YZEE0ZXV0emo0N1pPQ3h2OXBmNXNH?=
 =?utf-8?B?d1M2bSt4ME1vdGx6K2F5SjFoQTNXTkZGTFJURXY1bU8xZzl1MjY4dnhRU2lJ?=
 =?utf-8?B?VXBPa0VyS2NYMXhtQ3J6Tlp4T3RqQmVtUmxYYkpsUGo3cWljaWRYSnRlUUt0?=
 =?utf-8?B?RURuMitRMTlEUkpER0hIamQzYUxjM1dWbzM1ck84NVd0MzhySHNOdUhuUC9P?=
 =?utf-8?B?Wkt0TWhPWFJoWXBUSmNCb2xVL2NHck4wcHB2WFdvYjNDMVF3a2xWN0xWUzBT?=
 =?utf-8?B?VzE5cmpGY2E4UTBDMkg4S043QjZoQnNBWVg1d2RYanlNMHpwZkEvMlhKdEkw?=
 =?utf-8?B?SjRpNU1OcDYvdFBGc2xERmF6bkVjR2JZWXFhSnBsQmtrcXQwQ3NsWngxQkdz?=
 =?utf-8?B?RjVvK1FMR1JEb1VZdHdpcUVYeDcwWm9oVURMZTE4emNIcy9QVk94ZUEyTnA5?=
 =?utf-8?B?M3NJblFCclFhcm9nbjJLa3ZabmhybHBsbThtUjlJd3ZYTEw2bXY4bzc3c05R?=
 =?utf-8?B?UGs0SnE4eVhpMVBOVFlBTGZaNzNHNzM1YWdlTlVSR3gxNlc2MmdZblJnM0pF?=
 =?utf-8?B?ZFhGd2oyRWNNTVpHM1Awa3VBdjJKMFBPNEYxVGpOc3ZNbGNVL24zZEVaQXNQ?=
 =?utf-8?B?ZjBNSUVRYWFNWnFLLytpQmRiS1VhZmNrRXloM1VXWThUTmNzQi9XenVwSk5J?=
 =?utf-8?B?eVJ1a2lZUmxqVkorMGhvV2EwVmJma2poQ1VXUHpxT3lHemFKMWU2amFReUtR?=
 =?utf-8?B?ODl2WndGQ1JYMEtIQ1U5aXZmbUVPQnBPc1Y4OEhEem5DbEdTUDh5Uzc1dFpu?=
 =?utf-8?B?TXQ2SE4zaWRQcXFjR2x1SEcwOVpNU2l4WFNyUFdFYnlrY2UzRnNZUFdZVWV2?=
 =?utf-8?B?VDdMcm5obE5xMnk1TFlhNXBNcitlN0hJOThScktuOE5uK3VadUtuNkNKVDly?=
 =?utf-8?B?TlZsUmxCVjBwcmdLY3FpUHF4cUxqNjFFQ3F0VjZ5aTl6cWphWVkraG42QndF?=
 =?utf-8?B?Z3NCa3dkNUsyWDIyOGZTcFQrVTRGUTZWY1AzSDhkOUMySFZYL1dVOFJHN3E4?=
 =?utf-8?B?Um1iWFhxOWlTM1dCdmExRERiMk1CTEVZdmVNOVlVdVBLVzhHTTIrRUM3TWdD?=
 =?utf-8?B?WnBNVzFlNk9aUlh2RlI1cTJWU0NQamRTY1ZBVnZsaEluenlLb05YZkNaandh?=
 =?utf-8?B?SUhQYjRCb2dXM204TU1BcjZFNFA3R01KZGhsazVnZnV1L0wyRGJQNnVJa042?=
 =?utf-8?B?emwxQ2pFUENtTW5QbjRvYkVzVnZZdXduNGsrMWdSWkg5Z0FpWUt5RHE2U3NZ?=
 =?utf-8?B?Mkt5RUNEeXNEWGNTMWNZamFGWGUyb2JXSmJ1alkxVUpWMi80NDRWMXRtYmRo?=
 =?utf-8?B?NkthV3I2RkZoUExiOWhpOVg5RmdIUmtHclpQQWpyYzd1SXpNVkUyTVlZbEhP?=
 =?utf-8?B?OEpOWmprWjZUUjlsV0lBL0tjTjVmdGFUTE5LdWFOc05QUW83OEtVT3VSRnRS?=
 =?utf-8?B?dEJSSU1HOU5EWmJxSndsc1RDT1NqS1JsdVNEaUdFWFUxMVlOR0ZnNU5SYzdR?=
 =?utf-8?B?bzhuSzQwc3NmSlJ4eVR4elZjREZXc1pjVXlkZmc4NTMvUm5JUTJQZm5hM09w?=
 =?utf-8?B?OHFYQ0JGY2tZaWc2cGhkTCt3QlliL0xpS2lxRVZoUnRmZTJRYTBYZDNPbDZi?=
 =?utf-8?B?cmlXSzdnUXBsa1hPUzVWaDJLZmg2Y1I5WHNKYTJ3dUo1TWVBUHJrZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR19MB4885.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ad089e-89ba-4bc8-d223-08da3816aa8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 15:05:22.7891 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FJl0rWOEk/i6UCDoOh26UoM9epQYQoRUOBmVykcCStTQPcl1/p7YptBbFneITyuX/mDoyj0lCEPzxvzycah10Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB4373
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-17_03,2022-05-17_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2205170092
X-Proofpoint-ORIG-GUID: Skw6tX9BIiOYTcj-tnVk5Ulxqoes7lkX
X-Proofpoint-GUID: Skw6tX9BIiOYTcj-tnVk5Ulxqoes7lkX
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205170092
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220517_080533_674549_6204BE66 
X-CRM114-Status: GOOD (  21.64  )
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

UmlnaHQuIFdlIGFyZSB3b3JraW5nIG9uIGEgZml4IGZvciB0Y3AvcmRtYQ0KDQpUaGFua3MNCkFt
aXQNCg0KDQpJbnRlcm5hbCBVc2UgLSBDb25maWRlbnRpYWwNCg0KLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCkZyb206IFNhZ2kgR3JpbWJlcmcgPHNhZ2lAZ3JpbWJlcmcubWU+IA0KU2VudDog
VHVlc2RheSwgTWF5IDE3LCAyMDIyIDM6NTIgUE0NClRvOiBFbmdlbCwgQW1pdDsgbGludXgtbnZt
ZUBsaXN0cy5pbmZyYWRlYWQub3JnDQpDYzogR3J1cGksIEVsYWQNClN1YmplY3Q6IFJlOiBrZXJu
ZWwgcGFuaWMgZHVlIHRvIGEgbnZtZXQgcmFjZQ0KDQoNCltFWFRFUk5BTCBFTUFJTF0gDQoNCg0K
PiBIaSBBbGwsDQo+IA0KPiBXZSBvYnNlcnZlZCBhIGtlcm5lbCBwYW5pYyB3aGljaCBiYXNlZCBv
biBvdXIgYW5hbHlzaXMgaXMgZHVlIHRvIGEgbnZtZXQgcmFjZS4NCj4gdGhlIHJhY2UgaXMgYmV0
d2VlbiBudm1lIGNvbm5lY3QgYW5kIG52bWV0IHRjcCBwb3J0IHJlbW92YWwuDQo+IFRoZSBzY2Vu
YXJpbzoNCj4gSW4gY2FzZSB0aGF0IG52bWV0X3BvcnRfcmVsZWFzZSBpcyBmcmVlaW5nIHRoZSBu
dm1ldCBwb3J0IGp1c3QgYmVmb3JlIG52bWUgY29ubmVjdCBpcyB0cnlpbmcgdG8gJ252bWV0X2Zp
bmRfZ2V0X3N1YnN5cycgKGFzIHBhcnQgb2YgbnZtZXRfYWxsb2NfY3RybCkgbnZtZXRfZmluZF9n
ZXRfc3Vic3lzIGlzIHRyeWluZyB0byBhY2Nlc3MgYSBwb3J0IHdoaWNoIGlzIGFscmVhZHkgZnJl
ZWQ6DQo+IA0KPiBudm1lL3RhcmdldC9jb3JlLmM6DQo+IHN0YXRpYyBzdHJ1Y3QgbnZtZXRfc3Vi
c3lzICpudm1ldF9maW5kX2dldF9zdWJzeXMoc3RydWN0IG52bWV0X3BvcnQgDQo+ICpwb3J0LA0K
Pj4gLS0tLS0tLT4tLS0tLS0tY29uc3QgY2hhciAqc3Vic3lzbnFuKQ0KPiAuLi5zbmlwDQo+PiAt
LS0tLS0tZG93bl9yZWFkKCZudm1ldF9jb25maWdfc2VtKTsNCj4+IC0tLS0tLS1saXN0X2Zvcl9l
YWNoX2VudHJ5KHAsICZwb3J0LT5zdWJzeXN0ZW1zLCBlbnRyeSkgew0KPj4gLS0tLS0tLT4tLS0t
LS0taWYgKCFzdHJuY21wKHAtPnN1YnN5cy0+c3Vic3lzbnFuLCBzdWJzeXNucW4sDQo+IA0KPiBj
cmFzaD4gYnQNCj4gUElEOiAzMDIxNiAgVEFTSzogZmZmZjg4OGMxZTE2M2YwMCAgQ1BVOiAwICAg
Q09NTUFORDogIm50Ig0KPiAgICMwIFtmZmZmYzkwMDIwMTUzODU4XSBtYWNoaW5lX2tleGVjIGF0
IGZmZmZmZmZmODEwNjJmY2MNCj4gICAjMSBbZmZmZmM5MDAyMDE1MzhiMF0gX19jcmFzaF9rZXhl
YyBhdCBmZmZmZmZmZjgxMTI3M2VmDQo+ICAgIzIgW2ZmZmZjOTAwMjAxNTM5NzhdIHBhbmljIGF0
IGZmZmZmZmZmODEwODUxZjcNCj4gICAjMyBbZmZmZmM5MDAyMDE1M2ExOF0gbm9fY29udGV4dCBh
dCBmZmZmZmZmZjgxMDcxMDRmDQo+ICAgIzQgW2ZmZmZjOTAwMjAxNTNhODBdIHBhZ2VfZmF1bHQg
YXQgZmZmZmZmZmY4MTgwMTE4NA0KPiAgICAgIFtleGNlcHRpb24gUklQOiBudm1ldF9maW5kX2dl
dF9zdWJzeXMrMTYxXQ0KPiAgICAgIFJJUDogZmZmZmZmZmZhMGJiY2UwMSAgUlNQOiBmZmZmYzkw
MDIwMTUzYjM4ICBSRkxBR1M6IDAwMDEwMjgyDQo+ICAgICAgUkFYOiBmZmZmODg4YzFlMTYzZjAx
ICBSQlg6IDAwMDAwMDAwMDAwMDAwMDAgIFJDWDogMDAwMDAwMDAwMDAwMDAyMA0KPiAgICAgIFJE
WDogMDAwMDAwMDAwMDAwMDAwMCAgUlNJOiBmZmZmZmZmZmEwYmM1ODk1ICBSREk6IGZmZmZmZmZm
YTBiY2UwNDANCj4gICAgICBSQlA6IGZmZmY4OGFlYWZjM2Y1MjAgICBSODogZmZmZmM5MDAyMDE1
M2JhMCAgIFI5OiAwMDAwMDAwMDAwMDAwMDAwDQo+ICAgICAgUjEwOiBmZmZmYzkwMDIwMTUzYmY4
ICBSMTE6IGZmZmY4ODhjYjhlOTdiMDAgIFIxMjogZmZmZjg4OGJiMzQ2OWEwMA0KPiAgICAgIFIx
MzogZmZmZjg4OGJiMzQ2OTkwMCAgUjE0OiBmZmZmYzkwMDBjNDFiYTcwICBSMTU6IGZmZmZjOTAw
MjAxNTNiYTANCj4gICAgICBPUklHX1JBWDogZmZmZmZmZmZmZmZmZmZmZiAgQ1M6IDAwMTAgIFNT
OiAwMDE4DQo+ICAgIzUgW2ZmZmZjOTAwMjAxNTNiNThdIG52bWV0X2FsbG9jX2N0cmwgYXQgZmZm
ZmZmZmZhMGJiZTRjMiBbbnZtZXRdDQo+IA0KPiBDYW4geW91IHBsZWFzZSByZXZpZXcgYW5kIHBy
b3ZpZGUgeW91ciBpbnB1dHMgPw0KDQpJbmRlZWQgaXQgc2VlbXMgdGhhdCBub3RoaW5nIGlzIHBy
ZXZlbnRpbmcgdGhpcyBmcm9tIGhhcHBlbmluZy4uDQoNClRoZSBtYWluIGlzc3VlIGlzIHRoYXQg
LT5yZW1vdmVfcG9ydCgpIGN1cnJlbnRseSBkb2VzIG5vdCBndWFyYW50ZWUgdGVhcmRvd24gb2Yg
YWxsIHRoZSByZXNvdXJjZXMsIGl0IGlzIGp1c3QgdHJpZ2dlcmluZyBpdCBhc3luY2hyb25vdXNs
eS4gQXQgbGVhc3QgdGhpcyBpcyB0aGUgY2FzZSBmb3IgdGNwL3JkbWEgKGFuZCBhcHBlYXJzIHRo
YXQgZmMgYXMgd2VsbCkuDQo=

