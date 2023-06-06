Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFFD6C77B7A
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jun 2023 19:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=+Baq12PwLPnoS3274eeOcUwSOlZ6tr1bnHuq6JqxwRw=; b=qBqjxSqhrAisKf
	7YvIvxkrm8jsiueE4UlpWFqwDUiAfPcpsJbK5YTbXjmP7fOj2EF3gEKpuFZOdcQgJuItrANpzPE5C
	nNiSyuJitU1VcuIBGD4VVZKg/pwCV9so1JX2vZmrCXKupVfkXn5Msf0LUoBXCOBGMQrWqam1GV7ZC
	l/7me0zPBYX+MX0BKj7MbqRqzTSYr32u2Fka4ixh38KEarZ2fodmJGZMSsPn7Fh7/+aIyx7t/NNV8
	WN4eBeZZY6FU6McKpF6ymA5Lwd4clzj2tPn5ytJqFY2HWsnaMTVEvsOmWRayyboJpHteJKCLPL+GH
	IIrpb/jgmmVniyBVtmlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6chD-0032LJ-1h;
	Tue, 06 Jun 2023 19:50:23 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6chA-0032Jg-2Z
	for linux-nvme@lists.infradead.org;
	Tue, 06 Jun 2023 19:50:22 +0000
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 356IdG7x011008;
	Tue, 6 Jun 2023 15:50:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=smtpout1; bh=+Baq12PwLPnoS3274eeOcUwSOlZ6tr1bnHuq6JqxwRw=;
 b=nVqlw4ZWsxL/HWV8vD8jK2heThAjFAXhc8gxZXh+ISgLBhjcK4D+yo8l9x3tBQiniI/b
 jAkMrpSc84t+awwbLnr+2cvk06ukaO5VqEftRBECf3p5WZCSyl1C+ONUi/shtD+douRr
 t1JnZ5VKYbVwYYAcb/6hqqvlOaCn+sN3UT/zSV+hBjItc9i8O0f2iYKejkZnAZJOZZcf
 8Xe3V1waE9YG+W1w5rHhwVtalYQE+WkCo8A05LIbTYdHZrbv2CkraQLyX/cl6hrQKu2Y
 pTr/qdx+3gphM4QyTmO0+jH5PlWSncZuV+2DzgjjCU8nhTzoNRZYUM3J2E1udh09bqlh 7g== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 3r2a93g913-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Jun 2023 15:50:07 -0400
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 356J7d5k016646;
	Tue, 6 Jun 2023 15:50:06 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 3r2ape8gah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Jun 2023 15:50:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ge+bAZG2TSrOe2U6ze/4R826TyXLg4EA16ebFeO97mHKWzF6ByGeIoEJcA8cMo5j+S0E7pVLJzmHUBQsvZI6V7qbKtoOSEoWpd68L/mR5AE3qTZol0cmFvBIgHEfBSCrzpilmVd+1Sc+bEMM6USwAGcZiLJri8QqjKPysnaJulpUwoADBG8BXx693SPbqgcVRjbPA/8kQt5II5cJtyPD1MdyOIIZVglSlXjZu/zKnmT2/kw2UT55j1iS4pIiLmfDN+0Y70riVrnPRxWUDgJnv8KYGVuzR5fB/RhhFLsl1sQiXnOBkHyK6AQ4YcHI0RV/44r5D0J75judpqGKXZNxHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Baq12PwLPnoS3274eeOcUwSOlZ6tr1bnHuq6JqxwRw=;
 b=m0SngpNmTNV/W6CV2y6YpMzgMDfDYzZAHrDZq5SUI0DltbA4XO00aP2HMQ09IvWmM20U/21hg6w4MHORWec/uIOYvdTAW6/vG03sUJ7JjeQm2hCj0wF6QqEqdgZ1rTXkMpw5nr/swkjAp+DQeMIfULNQbn67WqKQ0TB4BGDLqxYqcFFPmzs7JE8gUi/1m6pJj3q/f50vefTlt6g+n0shksshUaqJgzSkKF/QgNtKtHmVbSBP+jGpEK+T/Y1l7/skd6Ij1dfyOfGJKjTyBTH8ipFzGfYj1VeiI6lTMdLghzv8y/p+D6CE2ASHfWrX2MhDVc6mwPo5A6esqD033/wgRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com (2603:10b6:a03:281::7)
 by CY5PR19MB6147.namprd19.prod.outlook.com (2603:10b6:930:c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.18; Tue, 6 Jun
 2023 19:49:50 +0000
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::df7a:f673:307c:d4f8]) by SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::df7a:f673:307c:d4f8%5]) with mapi id 15.20.6477.016; Tue, 6 Jun 2023
 19:49:49 +0000
From: "Belanger, Martin" <Martin.Belanger@dell.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Daniel
 Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg
	<sagi@grimberg.me>,
        "Rose, Charles" <Charles.Rose@dell.com>,
        "smith, erik"
	<Erik.Smith@dell.com>,
        "Farley, Douglas" <Douglas.Farley@dell.com>,
        Keith
 Busch <kbusch@kernel.org>
Subject: nvme-cli/libnvme: Controller reuse policy
Thread-Topic: nvme-cli/libnvme: Controller reuse policy
Thread-Index: AdmYrqKwYm54nqJuT/+bLvyzZeDrHQ==
Date: Tue, 6 Jun 2023 19:49:49 +0000
Message-ID: <SJ0PR19MB45449814FDC4D1279E8FB0BDF252A@SJ0PR19MB4544.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Enabled=true;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SetDate=2023-06-06T13:16:52Z;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Method=Privileged;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Name=Public No Visual Label;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ActionId=20ca6cf5-13fe-4e41-a035-fc966280e77f;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ContentBits=0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR19MB4544:EE_|CY5PR19MB6147:EE_
x-ms-office365-filtering-correlation-id: 24785ec7-99e5-42cf-f27c-08db66c73014
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R9sbAQrf4uOf4d+FQ5q1bKP9x4g7pEHFvEuBxCQESM4dJZ7m0Mc1LC1anWBcdJckDCNtkctv5/J+ATtKPWPOoaY83ZOfKg46dkYRoaJJdXLsWpxGmDbI0oUrHVZUrZgmYckbKX5FNlIvCsYVTRRFGAWcLf47tTGip6btDWUabp6fmF+sAT0j94P+sVEKPBi78BCo6YbMaACukO72UeLgG3kYMJc9ZC0ApZ5fX2e2baU44Z6nr4AKMA5V0GmMMr0CWvBemZId4Ro5F4gGyYG9UX5+GF88/ZAgA1dBIOTDahVWMTBcxl8IArB9x2EV1T8Ehg3XCxVE+Wx6z6/HT2WFw5bW/dV9bkK0PMoLGTB+9cWInkPX+7Yuo8xW+G0BzyAVI92u0OaZnSH3fcNaabz2fs4CQLF6qDfdbFLyXeVdPbzC0bgh+2/sEc5qCMBJAmKXpi+KE+9H7MxtvAsRTbh/cEP0RhYqI0/g0hjgQ83q1UodGZjI+U9cyNIbriCudCCvxvoMnFrzKJJUc9fGTI1sfqJTDWgbkNKtiwNfY4yPaGHNFp2zsYipqCUsJS4e7kltHjx2gZ83A9mACTNtNUje65AXXY1MKSNzuV8aMTqHjl3yMmwhPAwxOMx4gfy6XfzQ1F++d2ykzVqxc43Y6Ok0aGaQn/c/lzoQg2mBm7Xrv2s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR19MB4544.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(451199021)(38070700005)(33656002)(55016003)(38100700002)(86362001)(921005)(122000001)(82960400001)(478600001)(41300700001)(110136005)(7696005)(71200400001)(966005)(66476007)(64756008)(8676002)(52536014)(66556008)(5660300002)(8936002)(76116006)(66946007)(2906002)(316002)(786003)(66446008)(26005)(9686003)(6506007)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D4/7XGXH0JJGsMxMhN9qJ3QaSO4q52rOEJx0So5pAdz5Odd1l+RhO4pCXB3H?=
 =?us-ascii?Q?eMV/KNbQpSJgbRkM/96oKnxgoezhudhWEl9ukd/GGI5q1Ws8VRIQs++CzxTn?=
 =?us-ascii?Q?pV5Ufmy/kqrAJmU1EfDSEC5iqepmM9yDaSg0c7+Z9UJj9CV2KkS4FbvA/a4F?=
 =?us-ascii?Q?kmixUko4GjhMgZ0jDBo1RhXxURQMENXA2SaN5KBHyNMPB5XHJqiLSrcFj6CA?=
 =?us-ascii?Q?Rjnv6NNfx98QgKug1sgbxVC291wlitVD5ZNk474tblKjUxhq4o+zY+FZtuDK?=
 =?us-ascii?Q?vU2OOB1yyljdo1EXuKOHfsVkCYR5ryg4b1k5zssCeyCu8C843yXuWrT5DLOt?=
 =?us-ascii?Q?IINtsP+xDY5NEcwvqC0lU0yNok4bfQKYyeNO93XIzd6e9wOLJMTSSlLp139a?=
 =?us-ascii?Q?zMJJzcJUTQ0TvuPKQcGHos9AroeqjMEXjRGaElLpKzvyFMqJrDIWPkgRV3Ex?=
 =?us-ascii?Q?Ct5HAiMuOncjFmJn66IwZVl5TrzQlCLBXmMb1HWVJSYvmM4N9sY0dpwU/uqi?=
 =?us-ascii?Q?dLRJX3adrIqlwX+4uxvUQZ4+OjLfFugC9sJKC4Be7ghyvB38nmNkInLBmFH0?=
 =?us-ascii?Q?vGrnDNJP619QJLoiH9LYXzOWpWUW9ajfPTSFGTgORbPYHY/17/nbdncZFw2l?=
 =?us-ascii?Q?z1S3gQVJCbbIOE8mMi5YahcEVf3e/SsVQRB9XiX8pw9dl5aKIk8CFoumN2//?=
 =?us-ascii?Q?VSJE+R7ULN/KuUuYt49OWQSahMCh13gymTOggTwok5pG0fk//mt4oVs1ePbv?=
 =?us-ascii?Q?ImudM27PnCHBQ4jpKE4qJd/x0MqjDKNdsoqAp0pTsAin0ovmmBXQw3WhSSwG?=
 =?us-ascii?Q?RIIej5Pi48E9FsIaZXZmlX4IYPA2Ee2O88MwADUZ513AtJj2GaUYj5EmQ4FM?=
 =?us-ascii?Q?J6Ve1r9BxIJAup6yi6RLn2lSgqQWL5fczU8fQ1dSUkyLy+2mJAsN3ipcc44p?=
 =?us-ascii?Q?wsM2HaJwTmZV3PTjCY7WhfFeG0iSMsb1ayfLQeB6zvNdsZvA+1+7ZXklGP6B?=
 =?us-ascii?Q?C1b8o1srCaCCO/hBcSSVhKPYYkc9GwatJM/VWfgxRUOTMsu3nTxKRD5LB4E8?=
 =?us-ascii?Q?8eSITH2+EfAOY3XrLB2YTZ17r2ZoNf20LXHCowO5OUw2Kuu9i0l1dbn99Z1B?=
 =?us-ascii?Q?mFZL+XIMF6qjJQQo7G5Bh4wxqaW9FisQzpodWOKZmwubiilLpdJTot5DJ1em?=
 =?us-ascii?Q?zf/a7awFdHdaW2b3NWYyhOVfsxmcIpGdP8PAqoqy2SuJrhxCghzZqI+GpOU5?=
 =?us-ascii?Q?EZ9GAPlv7kHvGt5lIeXelzT1frd4DRQBc47LFNyPyDoS+j4oYNut8aB+AJpr?=
 =?us-ascii?Q?U4MzW0zfa41ss3wGqZnAsYoim/1QWAm9K6A0utEgupg0/MI+Jo+Lhl9zmDFl?=
 =?us-ascii?Q?mcNe4f+b7nhG+y4X8bgu0+033MgKlvXNhKPKQGxnVkmQEU8smHUM7X9px2XS?=
 =?us-ascii?Q?HjKqe2RzCbeiOLqsyion/Ypm/rLh8cN6ep4X1nTHj01Z8L5v3woL+WkpcnbI?=
 =?us-ascii?Q?dVM1cFBgUUjCPUeGZGw4qb4G8pQgtio6LRZcUkLis8LKlc0Wz+vEvlZIK+Sn?=
 =?us-ascii?Q?Mn7tF3OxT3tWvCbZq5goZ5PODETOJE3LfWwQYqzA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4544.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24785ec7-99e5-42cf-f27c-08db66c73014
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 19:49:49.3917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DAHon0gJg4HWiRsuSD3NoAtwtCL9pPKUCmKWt4mFaz4njysv1e0Oci4M1MxrQQ1vGb/gNa963qCEXe6RIZIkPlwtfYyfsZaCDbfYk62fQw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR19MB6147
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_14,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 clxscore=1011 impostorscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306060168
X-Proofpoint-GUID: 0u-QmGQVC16UWB9EeadGZjYpA7WWbb1d
X-Proofpoint-ORIG-GUID: 0u-QmGQVC16UWB9EeadGZjYpA7WWbb1d
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1011 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306060168
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230606_125020_951637_636551BB 
X-CRM114-Status: GOOD (  31.48  )
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

I came across an issue using nvme-cli/libnvme. It was suggested that I move=
 parts of the discussion to this mailing list.

The relevant info can be found in the libnvme repo here:
https://github.com/linux-nvme/libnvme/pull/647
https://github.com/linux-nvme/libnvme/issues/648

My question is related to nvme-oF-TCP, but may apply to other transports as=
 well (I'm just not an expert for those other transports).=20

The question is: How should nvme-cli/libnvme compare existing controllers (=
in sysfs) to a candidate configuration to determine whether to create a new=
 controller or to reuse an existing one?

Background:

The configuration parameters to create a controller are:
1. --transport
2. --traddr
3. --trsvcid
4. --nqn
5. --host-traddr
6. --host-iface (TCP only)

When trying to configure a controller, nvme-cli/libnvme scans the sysfs loo=
king for an existing controller that matches the candidate config. If a mat=
ch is found, nvme-cli/libnvme reuses the existing controller instead of cre=
ating a new one. nvme-cli/libnvme compares the 6 configuration parameters l=
isted above one-by-one to determine if an existing controller matches a can=
didate config. Some of these parameters like "transport" and "traddr" can n=
ever be NULL. Others, such as "host-traddr" and "host-iface" (and maybe oth=
ers), may be NULL when not needed.

Currently, nvme-cli/libnvme does a "soft" comparison for "host-traddr" and =
"host-iface". That is to say that if an existing controller was created wit=
hout specifying one or both parameters (i.e. set to NULL), then the NULL pa=
rameter will be ignored when comparing against the candidate config. This m=
ay result in nvme-cli/libnvme reusing an existing controller that does not =
match the candidate "host-traddr" and/or "host-iface".

Why is this important?

We now have support for booting systems over nvme-oF-TCP. What typically ha=
ppens during early boot is that a controller may be created over the system=
's management interface (i.e. the default route). The management interface =
is typically a slower interface (e.g. 1G), which is fine for booting a syst=
em. However, once the system is fully booted we may want to use a different=
 (faster) interface (e.g. 10G) to connect to that same subsystem. We can fo=
rce the new connection on a different interface using the "host-iface" para=
meter. However, because nvme-cli/libnvme performs a "soft" compare, it will=
 conclude that the existing (slower) controller is "good enough" and reuse =
it instead of creating a new connection.=20

One more piece of info (to make things more interesting):

When a controller is created without specifying "host-traddr" and "host-ifa=
ce", the kernel will decide which source-address and interface to use for t=
hat connection. The interface is selected by looking up the destination add=
ress (traddr) in the routing table. The source address is selected by retri=
eving the primary address assigned to that interface. It is possible that t=
he values picked by the kernel will match the host-iface/host-traddr of a c=
andidate config. However, because they are not exposed in the sysfs, the co=
mparison will conclude that none of the existing controllers match the cand=
idate config (when in fact there is a match). This is one of the reasons wh=
y I added the "src_addr" parameter to the sysfs (kernel 6.1). For TCP conne=
ctions, the kernel now displays the actual source address of the connection=
 through the "src_addr" attribute. This can be used to identify not only th=
e source address, but also on which interface the connection was made (by d=
oing an interface lookup to find out which one matches the source address).=
=20

In conclusion, we have 3 choices to solve the issue of matching an existing=
 controller to a candidate configuration:

1) We can leave everything the way it is now. In some cases, nvme-cli/libnv=
me may erroneously conclude that an existing controller is "good enough" an=
d not allow someone to make a different connection using a different "host-=
traddr" and/or "host-iface". We may want to document that behavior so that =
people know what to expect.
2) We can change the code so that nvme-cli/libnvme does a "strong" comparis=
on on the "host-traddr" and/or "host-iface". This may result in duplicate c=
onnections because an existing controller that was configured without speci=
fying the "host-traddr" and/or "host-iface" may in fact be assigned interna=
lly  the same "host-traddr" and/or "host-iface" of the candidate configurat=
ion and therefore could have been reused.
3) For the case where an existing controller was created without specifying=
 the "host-traddr" and/or "host-iface" (and therefore the kernel picked tho=
se automatically), we can look at the existing controller's "src_addr" attr=
ibute to determine if there is a match with the candidate config's "host-tr=
addr" and/or "host-iface". With this, we are guaranteed to never have dupli=
cate connections and we will always know when an existing connection can be=
 reused for a candidate configuration. However, this requires doing a looku=
p of all the interfaces to find out which one matches the "src_addr" (the l=
ookup can be done through the netlink interface).

What are your thoughts?

Best regards,
Martin Belanger
Dell Technologies, Inc.

