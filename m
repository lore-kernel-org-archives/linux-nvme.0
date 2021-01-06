Return-Path: <SRS0=xG/4=GJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C25C433DB
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jan 2021 10:37:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A4B123102
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jan 2021 10:37:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A4B123102
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HMIy63+mabF+7mKRJqFxg4Io9c+2xNIEL7LE78B4dzg=; b=u5RlpOp4o8fWM1XEHhXobassiq
	swb/G9LzbXj5kcRCJZjbmMeu/8Uh2s/A7Rp6CvNc6+3QGo3CcZ8tJ40EogQXyBo1onczEIIhkAU/U
	eoqfX/VFeVy6RlBBion1LN0ymiKxgroYLSllR4sUG1tuh0UgI7ivdmuH9Avjg12VgKhqw//udmkuB
	q3SCN7qHQ0plsFmDSKJRJWmHUgqJPsZfauZA3GDAoH6RE2GR4v2Yhvk5q597V1PC4/tCDG0bL3WKm
	TArJ/GwEXixfgyHhnGglgULYdrhuD4tSfVXu0DB0wfawisxMptZhXcGnW3s3zUfBTpDFz22Qky4t3
	vpzuFKOA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kx6Bu-0001uA-01; Wed, 06 Jan 2021 10:37:22 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kx6Br-0001s3-34
 for linux-nvme@lists.infradead.org; Wed, 06 Jan 2021 10:37:20 +0000
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 106ASP0K017739; Wed, 6 Jan 2021 05:37:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=smtpout1; bh=t4D2ir0Q0aKSm8sEC1hyCV3qBjTKPm1JFL623K7yk+0=;
 b=aVYmRFfU5RRmemKkXn1lhbYr92TdOBlthGIDyCmf7WqrHCYiNWfAKdQ+6skhm+GOfb4z
 AlrGtH6Y87in/lvXGKnhV3PG9P5w0q0BTJZT03gZadf12Av6Lv4X7XhqaBdlndTq6kAY
 Ds/wwzW4hEWnHHbDA0T3mQL+s/hb4jBFS9QyocWyOpYBKksCcVlhhGrrcmZYJTxiHXnt
 TIE+9QrOlJKtX5DKkO69tRctrL40SyKgdTuHWNnHVM9EeU2Hj/gRtP0XUC57Y5tRddtV
 5Ue2oltE/ntsG70qOrl0X3jUiTt6ImNO30xevGgBd7RucHbA1pLveqjE/If1+kD66fCf Tg== 
Received: from mx0b-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com with ESMTP id 35tjsywdga-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Jan 2021 05:37:15 -0500
Received: from pps.filterd (m0090350.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 106AZEKW116657; Wed, 6 Jan 2021 05:37:14 -0500
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
 by mx0b-00154901.pphosted.com with ESMTP id 35wbhvg1vv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 Jan 2021 05:37:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/PlbQ/Ri1EHEOcVo3akYa/RI+3Ah3XQTCLY5rh7uuCgvkBBxjq/394D/g9QO8baCazsNUbHJPao89dXhSLmRoQr6L8q6GA3xTzHOvybMfvxeScPOeZg2u85GRg/Bnb0agjcPxi+0brkmqDIeWr59WLvEPgD1e/HXYxbrbKYRoBP+u2pFcjdL8VOOqRJVmT+xlPFadHcHDMhnGH9P9ek26ju799ycXUF97zkIXYPY998EkDoZCziiu5iiZXMfU39Sho/IdZbyEJrX2puxxpWibJ0yMDUZcun377QNq2tqPSPMjpZdx1Qpb6cyZeFpBdV28upbbvaSht9mm065f06cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4D2ir0Q0aKSm8sEC1hyCV3qBjTKPm1JFL623K7yk+0=;
 b=QVyxlYO/HJmRLxugrW0+KrcsvwsAsriCJcCnNKVaWprkQX0bb1fxfLFjXWNjdIjJmnH17Mp25NJ8HIYl0VDAI31xtVlaxgiTsTH2BFZj6uFNEVv8rhaMSTFYQmo5JZOA6UHJknUHdMeiAPmuMNX/+QW/5DMoNm/8ha6TZRsksWVcj3kwv15Q0vHZcJGzErp0LpAt0GhYtOigM23EwRmR+lHJJG70+60mYAHVAHkw6qWAP9c9Q9/E6HutrCLqo3mbQqQLUZFD2stHeK7Un2+jOABMvvEYTs1uBj7UMZ8XD8/RntvvyOMQZPfGm5XwHewHnn/qt9JFLcSV740rWCs+9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com; 
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4D2ir0Q0aKSm8sEC1hyCV3qBjTKPm1JFL623K7yk+0=;
 b=MTNSb523r/XlC65w3j+JCRZK6DOuIQAal9rc1dSGQOHgT0jIc49aCyNR3lAG4riagMqFm962+pWfSee4Vl4s3TPPb5+d6kNEkwPTsR4wlMHxM0zrBT+ykt3JbdI4p7aIL/cxnLBKtCfGsEl/e1o53MMBl5aeUf7/HfBU/+PpOm4=
Received: from SN6PR1901MB2029.namprd19.prod.outlook.com (2603:10b6:805:9::16)
 by SN6PR1901MB2221.namprd19.prod.outlook.com (2603:10b6:805:b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Wed, 6 Jan
 2021 10:37:12 +0000
Received: from SN6PR1901MB2029.namprd19.prod.outlook.com
 ([fe80::6c90:e16f:4aae:c2eb]) by SN6PR1901MB2029.namprd19.prod.outlook.com
 ([fe80::6c90:e16f:4aae:c2eb%3]) with mapi id 15.20.3742.006; Wed, 6 Jan 2021
 10:37:12 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Sagi
 Grimberg <sagi@grimberg.me>
Subject: fabrics connect cmd with a non-zero reserved value
Thread-Topic: fabrics connect cmd with a non-zero reserved value
Thread-Index: AdbkF7/Xkvzn5zv5R8uAVpaUguhsNg==
Date: Wed, 6 Jan 2021 10:37:12 +0000
Message-ID: <SN6PR1901MB202957C808A7D493E252D873EED00@SN6PR1901MB2029.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Amit.Engel@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-01-06T10:37:06.3199941Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=e5983840-9092-4b05-a53c-86dca2be2558;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=Dell.com;
x-originating-ip: [152.62.109.203]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6bf6662c-392c-4851-2d0d-08d8b22f0720
x-ms-traffictypediagnostic: SN6PR1901MB2221:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR1901MB222116323283AC14D087A469EED00@SN6PR1901MB2221.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jHiFPVs7sIt+gXWHIC+zXBaGn+JC3kWGfHp947tk01u3ePRuVX3oX8mZ6b4O8i5mcDjmYs7OC1ezDRYlrQMik6DJu9PEYdjP39m1rwhmxq2bC6kj/R842V09RGI43YUHRjb8r1XLIUZZJlDqJ/auI1TOabAd8ZfvnCqCZsLI7pItyUHfrrdCEfvWK3tgqlpJa7YEtRvZH29hGv0d0jitBIhpjvHwP7uJVv9DS9qsQYjEkiKW1I2i9x668gYVW3UpHblLSMypCSE5xbET0W/+6gfxotAsCfDumNXY9gFf80bjUoemopJCFnBCLQsmrDv/f1V1Bpj6dOgqAUuJyzRSFDOINt/m0njZ+6S0uGZQcK/6821gFAfiVY+7J8am8tITgkBqNPfN1eC52pvFjTJGJA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR1901MB2029.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(55016002)(26005)(64756008)(186003)(786003)(66946007)(9686003)(5660300002)(7696005)(66476007)(66446008)(66556008)(86362001)(4326008)(316002)(2906002)(71200400001)(52536014)(6506007)(76116006)(8676002)(8936002)(54906003)(107886003)(478600001)(33656002)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?AI4xeYYIJ8OiLZNFXG88Vf/Xiefhjh3Sm5b+LntmIDvCg62EHmFK2N6AcexG?=
 =?us-ascii?Q?amRhs0S1RFkp3Hi33mkKsUHv1aeLpBlQ9wOei8wk9vaJhmUGZ3YrYbWdZKi8?=
 =?us-ascii?Q?+MK+mIykQRCqwy4ht8CO2A6mG22BHT+RJPEefXu1oavABoQKrcM5thfb99vq?=
 =?us-ascii?Q?Q2gdg7CAVCu0pDE31EVtAYfvNsuV/vqYHB3Qpj0WBCsZ8FnX9/ltUPYTix4n?=
 =?us-ascii?Q?Wsz2ODctRreDhQyfi4T/3dUS95gOhvQyV4fBCTOMOX036al9SoVZCyM5dkQG?=
 =?us-ascii?Q?k09a9ukOEsFZ8nUr/Q70V6C2yFEz2J3biSyw09dBJtgPFvZznRf9G/ypOYmC?=
 =?us-ascii?Q?EIbHGVgV9r45iCanA9VYFBrPaLbkrUI4vyqXS11Xp3ZRDv3cwYOhoUxdRRgj?=
 =?us-ascii?Q?XKwu4EmaFEg4gWVPg5V64MF9yZG3VsUXva6L0orTk+Lv/g/kd1AQegIDqn8i?=
 =?us-ascii?Q?fai48/i83d0xYxVRlY87TJBnlpw5k8uYkvfKqRzxYVhpf1JAmHKdYTYT+mbm?=
 =?us-ascii?Q?KYR60GcjWODyCTvDNtbpkoTes3gcWmEc4sCrvnM2wo5DWmmiCs1JePZVsXIX?=
 =?us-ascii?Q?oSvzrh2r/whIc8IWdtLv3WARCqMgHNlqsQLkaqnjr09A9pms0hXME+jL3HIb?=
 =?us-ascii?Q?2qiTbtHnFR+parGJBnHmpof8oMsonCtJNmqwEmbpHt4mpKYLT1y601X5tjCb?=
 =?us-ascii?Q?9uEXlkNV2k7tvYlAet0nqGfP4Xd8+g/YMI3I5XN+aX4xyrMcwtPUdEn6wzUd?=
 =?us-ascii?Q?W4sGJesGxfGW/WcE8eOS5/3id8/PS4ELhfl0fB8y0eE4gi5UVZ+ZrjQXIdC2?=
 =?us-ascii?Q?h3Qeu4mgIWZDdVTxyl1B7Udut9hbEGRJO94bBON+MnOVjnDVx6iQsjTkFhvP?=
 =?us-ascii?Q?b3tZPOHc3BW8P6chZlklSAjS8LYxeCsHRpJ1y1tHsMoE4PWSd5i2kRVKYnd6?=
 =?us-ascii?Q?FUSg1/OTauqPJuCSt3bCaH2tSi+KBsjgewbUl52MHfg=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1901MB2029.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf6662c-392c-4851-2d0d-08d8b22f0720
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2021 10:37:12.4462 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vTlSYkNR9z1go+dzLXRp7v692EoYT031ZD9tEFCU7iR9EjSp3L0bCLLpjuBfpGslKuseboQHUP8S3IK+pIu3Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1901MB2221
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343, 18.0.737
 definitions=2021-01-06_05:2021-01-06,
 2021-01-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxscore=0
 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 mlxlogscore=637 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101060064
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 mlxscore=0
 mlxlogscore=751 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101060063
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210106_053719_365617_F5878454 
X-CRM114-Status: GOOD (  14.17  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "Anner, Ran" <Ran.Anner@dell.com>, "Grupi, Elad" <Elad.Grupi@dell.com>,
 "Engel, Amit" <Amit.Engel@Dell.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello, 
We see that when executing nvme connect cmd (Opcode: 0x7f Fabric Cmd)
The host is submitting the cmd with reserved filed set to non-zero value - which is out of spec.
Seems like this issue is not only for connect but also for other fabrics cmds.

Here is a packet capture for nvme connect :

    NVM Express Fabrics (Cmd)
        Opcode: 0x7f Fabric Cmd
        [Fabric Cqe in: 302]
        Reserved: 0x40
        Command ID: 0x0000
        Fabric Cmd Type: Connect (0x01)
        Reserved: 00000000000000000000000000000000000000
        SGL1
        Record Format: 0x0000
        Queue ID: 0x0000
        SQ Size: 0x001f
        Connect Attributes: 0x00
        Reserved: 00
        Keep Alive Timeout: 15000ms
        Reserved: 000000000000000000000000
    Data
        Host Identifier: f1aa9784-195b-4814-893d-44f90a6a92d9
        Controller ID: 0xffff
        Reserved: 000000000000000000000000000000000000000000000000000000000000000000000000...
        Subsystem NQN: nqn.2015-10.com.dell:dellemc-powerstore-23b5145591975EDFF2FE
        Host NQN: nqn.2014-08.org.nvmexpress:uuid:nc5199007
        Reserved: 000000000000000000000000000000000000000000000000000000000000000000000000...

0x40 value is corresponding to PSDT, in a normal (non-fabric) nvme cmd, PSDT field exists.
Do we expect for the same for fabric cmd?
If so, the spec can't mark the second byte of connect cmd as reserved.
Based on nvme spec:
"A reserved bit, byte, word, field, or register shall be cleared to 0h, or in accordance with a future extension to this specification"

Is this a real bug or a spec bug?

Thanks
Amit


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
