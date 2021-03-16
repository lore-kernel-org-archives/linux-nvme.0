Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84BFC433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 08:57:51 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B21F65002
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 08:57:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B21F65002
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=VzVSeoiR3gOr2ByZW7s+Q66jiSwAs+Hu+fk5oRvJLrI=; b=EShyOwlfInEOEktzqUMvQ1exF3
	hNgVMa5IGVvvQ0v7IJsba+WrIj0cSND0Q2HlcCrmVXER5HRtlKG64+1TTn8nib0Y9S7BJg+UQ5laF
	+DfmXSZ+ezZa+jg25fPtHqVaLtMRE8Ae2aeuTru2HtRUeAWWTxn+1iUlzaMkiwpm8FkhJ4M80f1j6
	sQQU/J9aRjYB/hRTXtCAqF4HbvegPJwxoARvZiFwRj/0ogpiORrP+INx53Ow8d98YexZ3bsRpXdwi
	YcTVLu516Iafm7rqgGLAyjoDx09EUXuQbxYm7GabNFN8K9xYtKBSMMgoJyDfgigP6U/2S4JjNeMj6
	nmG7LzXA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lM5W9-000B5W-Sl; Tue, 16 Mar 2021 08:57:33 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lM5W2-000B2Z-6H
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 08:57:29 +0000
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12G8q6Ad025836; Tue, 16 Mar 2021 04:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=smtpout1; bh=/SA/GUlxFevZB964g0wuWlYfeOfa8EtUBzbSCqOCrCI=;
 b=k8fYMovEidLf0hq3TfjHKR7jB/L9oG6XsSSH2JCUcvpAxsW9bSWIoWKx0K+SXTVLdmKt
 pomje0oD+DISDkrLQFWJ+aKr/sfShhDJIEFPMng+tgW0I/zLqSFL89KiY4F+zXEXXZ2W
 gRqu62feEI9Qq2ppVittrmyapo5gcCwMYMGkIz3Dn/CJYOd25gNjyOGCLnTp3nBV8UdR
 /WvQEtWD6YbrEGdNeKZjdnJ43HYb3m4NEaSlHH8u21PCt9tjM6Muh+2eEG9Qk6QjiMlK
 yeJCbqcBAdeRR6Sr+aMFC42++u5K7Dbcxoq6T8gDA688OqlzYorZk89SUlI2EV8fo8L6 AA== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com with ESMTP id 378qbx7wu0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Mar 2021 04:57:11 -0400
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12G8sbYV160385; Tue, 16 Mar 2021 04:57:11 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
 by mx0b-00154901.pphosted.com with ESMTP id 378rj0n8bv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Mar 2021 04:57:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W6iibSo1KnJs3uwgG7b15OI96cNF0lZDRLGZ6AsYRWcmKgW/IXj2xv0aTOoTD9HIBD8218uizzz9QX1rcaRXlEZqKQ+hKMLVTqa78ePDYGepo4O9MUN1oLbFkTsHFQrzEV0xlyGCPxLoxPuOxG9+lsn+ek9+FyInXuHskqPHevzsM5lZUVHDMdBI6R6e/aVLzjd0Thumq48F8oh48kCcE8sxecF1ZnCr4odY0m5ObyFHCIMK0a7OYe2DMd8ciZi4DJbE38Ss4Dql/4NJmvJY7CvTo5pHBPWajSdWEH82/jXBEkcFbGGvYxR/CvUNDkr8U0cS1Fya5bqsJXFPiak6BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SA/GUlxFevZB964g0wuWlYfeOfa8EtUBzbSCqOCrCI=;
 b=KH40KH2sraUTnPW35CDC4qBXv2dyLcgkWCLl8iICUqsEU26FS+ffhpfFN3+8jzjRx1tV1GRqkXIXTpK2iEBnC55k/lAfrV0bF9d3yMd2bUZAAA0HBJM0CAuq5xig37AIwyZhKmPkHJ909n45p2Lqtyfmo2HgKyekxhm+xkhgIbbtPcQExeALs+u6EquWwSKIGJml8DhUGJpVQinvFRnwQgHSUMNNgpvG/wJyt6E8gZrwZIWiHXDPYrpiGkYXITHqeA5p+aZJ5YEz0/H7rE1UJ7Ff3A3eikEFfzh6vCGHhRkPabLllbKratBjp22sLC4TV9j7W/9mkbDQHBolIcSkYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from BL0PR1901MB2020.namprd19.prod.outlook.com
 (2603:10b6:207:38::12) by BL0PR1901MB4675.namprd19.prod.outlook.com
 (2603:10b6:207:1d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Tue, 16 Mar
 2021 08:57:09 +0000
Received: from BL0PR1901MB2020.namprd19.prod.outlook.com
 ([fe80::60b0:a3ae:37b2:2e25]) by BL0PR1901MB2020.namprd19.prod.outlook.com
 ([fe80::60b0:a3ae:37b2:2e25%7]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 08:57:09 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Sagi
 Grimberg <sagi@grimberg.me>
CC: "Anner, Ran" <Ran.Anner@dell.com>
Subject: nvmet_set_error ignores error_loc NVMET_NO_ERROR_LOC 
Thread-Topic: nvmet_set_error ignores error_loc NVMET_NO_ERROR_LOC 
Thread-Index: AdcaQlC1JQMsBcUcQtuIzJaPGyvIQA==
Date: Tue, 16 Mar 2021 08:57:08 +0000
Message-ID: <BL0PR1901MB20202EA160DFA04E828A3719EE6B9@BL0PR1901MB2020.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Amit.Engel@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-03-16T08:57:03.9124066Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=3f0ffe8d-cca2-4584-9452-70559b289207;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=Dell.com;
x-originating-ip: [94.230.83.173]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a9dc072d-6fab-416e-5a69-08d8e8597b3f
x-ms-traffictypediagnostic: BL0PR1901MB4675:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR1901MB467581041908E1656359998CEE6B9@BL0PR1901MB4675.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bghWSYijhjxerdxNi/qSWIPOlpMFyjTimImWEwl17sbdD/6of/7Btic+1UrcA5T26XoSvJga6B6MfBFuJUxgJuCqXsNTOCux8Gn5f3+w8QAV5z0sj8leuTWWnUrGqBgmSQQAP4wzPB9Dp54vFwf1L/VYtAze7bCiM01dMIBsJl3UBC3L3A2JPxNaappnNGfBPiAhL4M+VFUb3iRThRHsjfKtRR189LgNIqo5NhvtQYumHbEzHM/Wz8r/mAseZEYwOERXcZu5o8sJZ8PubdFFOjLLVzwjqW9mS3R23M9t1vtCMEoCo7V3N+6nRSgk2iqzM6KEAPomm+bH1TNAZv7Lb91ES5urZimjRV1gWFuJpanElNTE3WusIIPgwXk9nbX4v7TcdlTPXKW+Tqk7rnTO8KsL/RWAVD9ngLgVxQ3GZIIQe5DWPrTrz1547C9+p9WszvYrYYPFgEjngNogSLXgm8Fc2029YsGNr6ocbbNDlOMA13glxUfh2xqq7b3iiaBbKS8Y2bQdxl6gFmuXASPgZbIP6BrDOW1POGzkrSGwYX1nRL319Hk9NLHoQahzdrgM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR1901MB2020.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(52536014)(66556008)(55016002)(5660300002)(66946007)(66446008)(6506007)(33656002)(7696005)(71200400001)(76116006)(4744005)(478600001)(66476007)(8676002)(9686003)(8936002)(2906002)(786003)(26005)(186003)(86362001)(316002)(110136005)(64756008)(4326008)(107886003)(4743002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?/gDRNxDdsPzKK7kSn7/38hMbslkWwB3KOGwhWG3N7keN0qIWMn3X1R/haI86?=
 =?us-ascii?Q?HIp+rXxTaVDbbjVq6eR9bX+lUVQ+z23+RTfnjSeAEfHnpd3tpiJmDrEUfa5I?=
 =?us-ascii?Q?ZMhmpEaNQ8zzgcjWiD/BF+dzo702Gtbc50RIEWNNu71b7Qahdcqqx+1bkTEO?=
 =?us-ascii?Q?uQ00/9Zmy2Qo76cjcTXk8+bM6H1Oa1BOc9NmSyeSgQjmU9lb7NY2GQ6S2UGc?=
 =?us-ascii?Q?veEvdjjK+LAVM5po0yzeEUwd9juD60nH8TzNEHal7cXebarKfGxkgSHJygXK?=
 =?us-ascii?Q?bRTyo0RuqqYiSBiWzWZPGkR4bXHVb8ahSeBL4HgeSI9m5IDNanUr9T/1o2bS?=
 =?us-ascii?Q?DXI3mQHL6yN6uNs/FQFAT1NAY3e4CqXzEM9Q12CFAnoZJ2+yYv2z6xRuRfp9?=
 =?us-ascii?Q?8/AjtsMk1FjZjAMzto+bGi7fQXchf3h6orZLlz1W8a+7FgOl6ff1EcCdZ4wt?=
 =?us-ascii?Q?l/pf30/hjsFFqaLfHjkYSm8LM/6v01+4C7Vnhe4PXfOsVMJ59RksehAa6K/S?=
 =?us-ascii?Q?wguR1S+vdFDb3tXYSkVvr4i1AUL/yl8MmmGf3QQ8KZlBvzs5k28b3wZRl6Gq?=
 =?us-ascii?Q?b+F/wNv+dC3C+ZAxikPkHhFNv0YVirUqj3uK0MJwBALuDWmmAyaLqdZRDZWb?=
 =?us-ascii?Q?Qx/Rdrn3hqEvMRTWBI+QkD5oQqAxosNQG6+HCivJY++gT5isX4JNbvbT/80K?=
 =?us-ascii?Q?oME9Qq/CgXNU+JzQbVmC9REqrFOlP7kTtUtW+wGO+njIVhj9NXEJvw5oNDXy?=
 =?us-ascii?Q?iQBRZraVhjggO0XLfuyGUpctcX5SoQnjoLO+Q0AiIhkG9feea+jCEMViDTK4?=
 =?us-ascii?Q?3Vi0yA12vpjpZwUJoVxa9p6/KJp0txEpF2WK6fivMMrCvB8AGqN/7bUUHB+g?=
 =?us-ascii?Q?AA0ukZz1TZxaTiuExdh4w9yjWn7oKJuB40HDNl6TW3vikebpr8BbUQAGdwk/?=
 =?us-ascii?Q?Nn0d4ugnK0GksvZK6H078mfO5o+VdlC5zGx4WsyYoUfVAvKZDyPf5JXHt67f?=
 =?us-ascii?Q?UtfTvOIQvVZScVs0sBM0bwMU1nu/nYGORQKna5RA9a4385For1L73hcBFbry?=
 =?us-ascii?Q?Eki2068WvuhQDBBn5m1POCozEKc+vhsXhRgdL90V0C3YvJriSqU9m8yP0NOT?=
 =?us-ascii?Q?slBmPJT0r+gE8aE8wdmMt3tat7JMNMqUcAdLX2KyCDjNxmHzupMT+D5fK8kF?=
 =?us-ascii?Q?Jv1KajO05X/ZNNSq1S9qMoULnrVpbILWOjOW2dDHohrOJ0leiO6RUp8OsEG2?=
 =?us-ascii?Q?pPz4gLqo12NvwIrG+mkk5/Ty8ktY8J1fHhPn+paTiWYoDHgklJ9UjJJdXQ6y?=
 =?us-ascii?Q?pvKXkRsNHsU8EEekQWxzBywC?=
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR1901MB2020.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9dc072d-6fab-416e-5a69-08d8e8597b3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2021 08:57:08.9358 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HIRJC/P9UTr/FhuMltlEX5V1Bbc8KbKNzJ/SvwH6ffaqdy2KyEAONeD3mz36eke7LwmadWYGW1XuE2tG0n+B8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR1901MB4675
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.761
 definitions=2021-03-16_03:2021-03-15,
 2021-03-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 suspectscore=0 mlxlogscore=677 bulkscore=0
 adultscore=0 spamscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103160062
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=792
 phishscore=0 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103160061
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_085726_863006_5368E48C 
X-CRM114-Status: GOOD (  12.34  )
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

Hello,
A question regarding Get Log Page - Error Information lid 01h:
According to nvme spec 1.4,  bytes 15:14 refer to 'Parameter Error Location'
"If the error is not specific to a particular command, then this field shall be set to FFFFh"

In the current implementation, nvmet_req_init initializes req->error_loc to NVMET_NO_ERROR_LOC (((u16)-1))
Then nvmet_set_error has this condition:

if (!ctrl || req->error_loc == NVMET_NO_ERROR_LOC)
	return;

means that the error log will not contain errors that don't specify error_loc
is that expected ? 
don't we expect that param_error_location log page field will be set to FFFFh in case there is no other valid req->error_loc ?

Thanks,
Amit Engel
 




_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
