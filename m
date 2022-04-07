Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D1EC4332F
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Apr 2022 20:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pb2HkSTA17RdDmmV8tAcIUHU6JivtMPk0TkD6dsB3+M=; b=BqLSsRfH+xGqwNe9kyzpMvgGQk
	vvvMN74wkJAaqVfozwLwZr764/iVEs8vV5lX1Yq8psriWjXfOmktWGiPEsdpJKs6lTS8Yjv4X/6aA
	M3i2DZ0+WvHoUbCWuimnE8wDjbjluZ7u3eOsdzi04eJ4aem6xk5Wp3Tc3x0XwDI8RGyEytLZHBa+O
	pRyoFQwfdznW++nkJzEhh2CqAyYsd06o5CyL3TMOBuHe1igvwdrZXz0ZXdTlIEgKb15/R8xwjXVeM
	JvFfvPLHuCjBZR5Zfj+fzJdTVAqDXOufY5BPPZ9cvfoy3iasPAndUats7mKPNrgd79fffnNWs6TFy
	Ckycfb6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncYqm-00DvwX-2Y; Thu, 07 Apr 2022 20:35:29 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncYqh-00Dvty-4H
 for linux-nvme@lists.infradead.org; Thu, 07 Apr 2022 20:35:25 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 237He2IQ000849; 
 Thu, 7 Apr 2022 20:35:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=pb2HkSTA17RdDmmV8tAcIUHU6JivtMPk0TkD6dsB3+M=;
 b=M3G49+Xs6FmAx5sEnNB+L5X2kJjQKbWgfqfapC/Owfi5OawUjnev7YPJeq6+CQJJ56+g
 eYTZpX/awOExe9NHo4OsAq6UqUdIu/dBi7jJt62eHMSvjQOMmP42+V9/b1DjhIk6BJA4
 bP3DpfdVbryP4aXrDNQLpOJA7UqYAtu+5b73UCjZSUifH209GaSi8yqhDte1EL6eJjJ1
 MrzDu7WGiJYbcpRfqL/GCC8NYNmukJnSp0Nb1CRivcqM9dB+EcOv2XCDkU4FkYiFSl6e
 mu8U/uoDg4lix2MvNC7qbtuql8D8mqiwPknGzffbbaEEJ+PXRa26J5WWLfJWsLxQkWy1 zw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com with ESMTP id 3f6e3sw19h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Apr 2022 20:35:14 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 237KS1aM036811; Thu, 7 Apr 2022 20:35:13 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam08lp2046.outbound.protection.outlook.com [104.47.74.46])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id
 3f97uxaac3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Apr 2022 20:35:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qxmc2VRouznvWPqlNMZQiujd8AotongEpeOieMzBebMmJq+CdI+h7l5Hm0y+J/4z8yE6r5AWPdDXPCF6bqzddGDxLt/2P7ZDUDliF7zEGDLTWN4ICarveFpX2q4Qllf5PMyKUgdhJ9tIoAXJfBfMQacVYGIbPbuANMVYq4pcdGKoS6884zYtDWx8alwa1utSUp/+bYHvka6J4FIsxFw9U1fITOUYRD9ifgDJ44uxofwHgI8JYoPyRD1feT3AkCSecxfZFpLhcN0lwBxCczffG6D75waRsh+Nk0ACwYEOWLJhok04zxtORmnhm3Xk6VvX20pjy3cDjR5xG/UO0LYMxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pb2HkSTA17RdDmmV8tAcIUHU6JivtMPk0TkD6dsB3+M=;
 b=PhhXvtPl3ro9qIsSe7hX675EwEHxMEzPoHIyPFn4s7JX7dV4/knU5qjQK13RcdZ6RXVNsRAZ7DNLcB1NDzXTm1TLW9V7QPe9s/cf10hHI7giiick+H3eJOhS2gLN1W9qq5WPrtGFE0L0rw0HiHxsdARSsXFB9JrbjaIZttaEMiS6LquV/qY97/qn1kInkEDQ7gpKq2ZqwYW/yA2LifgE288VBdcPd89+cE6VVEOJ+SOsuKpLX0ZBlKiwkvS57TTpUZrDIdnYSE9SA4Zf2bGltmkterjmoXUfqP/LvEKv0nsCvQkRvZbro2DXovweYHU/Zm1IU4YecpGH1rT41iWWrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pb2HkSTA17RdDmmV8tAcIUHU6JivtMPk0TkD6dsB3+M=;
 b=ZIPiM/H5xZjdwlodCQORoE8igqFxWi16wnH0a9zaBs1kK/Ke4odzqN2Mc7FrU0sYlQaF1IgnEgioZt7BJp42TBT+xXDY5WUOLd1GfkQTasUM2iW5+qvXYGQplmUKMnYC9d2WFIespfIxIokmW6uoI8a2Act99nq27kVGuOXswuk=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by MWHPR10MB1680.namprd10.prod.outlook.com (2603:10b6:301:7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Thu, 7 Apr
 2022 20:35:10 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::19cf:32fa:454f:7bff]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::19cf:32fa:454f:7bff%8]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 20:35:10 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: Sagi Grimberg <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>, Keith Busch
 <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-core: mark passthru requests RQF_QUIET flag
Thread-Topic: [PATCH] nvme-core: mark passthru requests RQF_QUIET flag
Thread-Index: AQHYSdUqFpKGiT1CSkmELkSF7x4OoazjGb6AgAAClgCAAAWlAIAAT2KAgAC0P4CAADK+AIAAiyIAgAAGzAA=
Date: Thu, 7 Apr 2022 20:35:10 +0000
Message-ID: <650E6456-BCAC-47DA-B50E-4321E98AC9AC@oracle.com>
References: <20220406164109.30449-1-kch@nvidia.com>
 <Yk3FT78uVW+9rRV5@kbusch-mbp.dhcp.thefacebook.com>
 <21a3a237-5f3b-a608-2d79-e0a5fdcc0d88@nvidia.com>
 <Yk3MNrI3YfjvbRqZ@kbusch-mbp.dhcp.thefacebook.com>
 <92C8BCED-6845-46D4-BCD0-78E790A5F86E@oracle.com>
 <20220407085113.GB19062@lst.de>
 <64ff1e92-6c6c-da38-8753-0e6098394622@grimberg.me>
 <4386789d-6722-add8-5b42-f605e48e894b@nvidia.com>
In-Reply-To: <4386789d-6722-add8-5b42-f605e48e894b@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0835787a-7498-4f52-4f4e-08da18d61c34
x-ms-traffictypediagnostic: MWHPR10MB1680:EE_
x-microsoft-antispam-prvs: <MWHPR10MB1680B8039C107D7DB65B2E93F4E69@MWHPR10MB1680.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wMA8hMfN8kQWq9qh8LDDO+ExuVaJn1ubeogp1dNPZmHfP47h9x79uigkCzFtwMlkqDjf0kgUirG7pRUsyOLyrcfjn5FQBqc8UlQcX3CnLWOR/To/dUkslf2IZu0nj/Z+ANxb9Jkal4ZaJh6WZ4i0YBY43/m41G23QivTClHQ4gc6/HwDCXApKbYNNUwmwxMJMVSqKe+0AomHxph2HelEGaXl/hGN7tVfUvIzlSwNK2MK+RvP9i2JMdDxMdfY9Aveq+pjE2JlsvJ3t4eBeZHGe3jIolF7jpz7MhFoDovGIYX14pP82bpr1c0hPDIoB7dJ4u70DdFw/m1aLw7s5yTQQO+7SkfEBJWW4wcI8CTFNO78xhxRY+fz9jjfwkXgZb+2XIrZs9ywIl0vv5K2EygkSDky0lmZoTLD143EPWVm1cmNLFUrCYsugRB4VChvlVbOV25dK2ikp6C0qAKjAR2vFY5hWAK26dm/1OMoO2xUR9r2NivpqukKo29nPQXYLR7i4MkOJeru6mQ8kPTC1xBP9eYolAs5FOqXOcniUYEJdLs6XkCbClIqL8EU+cRBMjLo7S45Zgu+SoC+cckRvP02Pc6z+gZEEDL/sFVb2hBfbtCOg8ZHxgCFFrn9TfL0p4wIUqWfAt3ItvWclxrzNq4LUuR3isvwG6SIWQrl3RsqrURelJ8A3Gm4cPt5/ksU7MYIf/7xYMR6lAoT4V+1vCCBrmId7UC/Xf+PbRgBrE29nz12dRYJfYKdZDSYCM2mT8ZyDXsVDBNvhOM2E8dB1HzKcLKP58S9wOw/fBmxz/Hk7OyjrMkyLZE2JirmQBWgZGLs
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB5550.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(186003)(8936002)(44832011)(83380400001)(33656002)(6486002)(86362001)(5660300002)(66446008)(38070700005)(2616005)(6512007)(966005)(316002)(36756003)(6916009)(508600001)(76116006)(53546011)(66556008)(64756008)(4326008)(71200400001)(122000001)(38100700002)(2906002)(66946007)(66476007)(6506007)(8676002)(54906003)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0Zuell0Vk1hdVVTUVlJYUJFMitDQXF2dXp4U1N1UEtoQ1ZxRkhlc3l5cUxl?=
 =?utf-8?B?cUhpaE9IdG9SR1ZNWDBaMkNRRVVXaEVBUmdmRlVidVBMNlZGVGsyVnFJUUJM?=
 =?utf-8?B?NjNqd1Q4K0IybEp0dVdGRXBBRHl3dUp4NXEwWVhUZ1BqeFRoR1FWRFVEK3Rj?=
 =?utf-8?B?M042VFRMcHpwdE9yRjk2cUM1OE1RSGcrdExPcE1FdlB5T0JZMWRrUnREOEVG?=
 =?utf-8?B?aTFTeTNKQ2JxS2dnQklsVzJGNGFVTkFqOHcrdHE0cVU4aHlUN010OGJ6MFN1?=
 =?utf-8?B?ZEh0NDdXQ3RkTHM0NTUvTDZDM1RMUjNDTEU0eS9FcFNVOHBTTEF5aDFpS3Bq?=
 =?utf-8?B?L1hEV01NcCtRcHVhdlptdW9nZDFQYmFrMUlSalRjVnN4TWNWY3BOclYwcnZt?=
 =?utf-8?B?amh0VEJkUmVnUXRjWHJiUEs4bitmZVJsc0pKelZYWmNGc0E2dyt0bnJscERM?=
 =?utf-8?B?TnN4c1cwaitWem9MNWhwSHRHdlYrZGZXSU9OdDRiTjRnb013WE9IRHN5NVBV?=
 =?utf-8?B?NHJ3ZUJFYW9jMVhIczhSSzRCVFg4T1I2Ym1HMTlNRTJldE1oUVBUYko5NTBs?=
 =?utf-8?B?dDY1Y3BmbloxWFViZkt4amxoa25vbE5NMWVkVHAyVTYrSTdYL3Q2YkVmbXVz?=
 =?utf-8?B?NjQ0bmNuNXlvcG9MS0RkSFVVM2VtSTBvR1lTOS9KV2JuQUQ5K2FDYmRSQXB2?=
 =?utf-8?B?OHFyMXZsZDVOSzd3c1BLY2prek9MTE5ZNDU0ZVZJSENmUS9BelQ0QnR1VVo5?=
 =?utf-8?B?MWxkN1ExZjF4cFp3Y2RrZXBQcmFNZVJtZDFmYXMwUDlhU0pSMzdFbzhidjF0?=
 =?utf-8?B?cEcwOUZNK0tCTmVDQ20zaEgxMUo5ZzJ2Zk0yMGU5SDAvT3pXSjZ2dHRRTkdh?=
 =?utf-8?B?MWN2cFFSWkFFTW52MENvRXRPTCtTNEVMMUNtaDJlbU5sV25zV2dBeHpFL0xU?=
 =?utf-8?B?YnpxZzkyYUdMZVNBODJMNXFhK09UZm1EYnhEdXVEaU5iNVR1QUNlY0JTL1dL?=
 =?utf-8?B?ODNiME9KSXRsQXppWnY1MHBrR1RkWitqbTJ4eTd3SFZwaE5nU3pKcVFEa0FE?=
 =?utf-8?B?QzRnRm41V3NzUkR6eUI0ZC9JblV2ZlZRanpXd0pRNGJDL01xSlZ3RENwVEVj?=
 =?utf-8?B?bFJ3VXoyeGZzRldmMVhBOVljUDU5M0hXYk1GaTMzT0EwNEdwK3Z1TzMzZUZu?=
 =?utf-8?B?M0UrMC9tZGxvMjcvVkRWR0NvSnQrbmVDT1hFNHVqWmJmWktYZThjM2d6bllC?=
 =?utf-8?B?UHVDMXpVU0tHVHJKZTlKVFN5UXF4SVJHZ1pQMlpONXVHbEk5TlpFSmYvc1Ix?=
 =?utf-8?B?cHlvTXZGeUZzNSt3S0dvc0w5ZUJwVHh5WDNsY0hsSnEwcHRXRWJtSlhWcFZy?=
 =?utf-8?B?WUd3UWVSYkJWK0QwSFhCbVBFVS9DTFlVd0svZmNaSkhsb1FqeDhiVUJQWjJR?=
 =?utf-8?B?RmlEb1FmUWZjUWxVeVg4N3pTNjBLQmxQV25OcmxQL3RQKzQ2S1BqMW41Uyt5?=
 =?utf-8?B?dnRpMzNDM2tNenhVZnc5eUdwNnMwL0ZScWZVZTA0WDhDek4zNnU4VkQ3NW8x?=
 =?utf-8?B?YkdmbysxZSt1YldTczBYeTNxWSt6WE9ITzFEbGlMMjZTM2oyMU5NTjA5U2I2?=
 =?utf-8?B?UlN0YlpOOThHK1drZDMxMkpCb1JQTXVZVG5xRW1oTDcxNUVtK3pPNFZCYkJW?=
 =?utf-8?B?dU1nSUpWRHNxVnVoc1Z2aG16Z0JZQXVndWJidGRUR0dIQVlVZDVZY1FQbXAz?=
 =?utf-8?B?bE92aUtQL1dpYmhrdDBDUkJDcTN4UXRRaVJZK2J0cDlhU0o2SXc5ZElIVklR?=
 =?utf-8?B?R3BHb1NCRjJweVhSTHpDUnF4OHlMYmo3QTYzZ0x6Zm8wQkxTZThmZVA2Z05w?=
 =?utf-8?B?bEJKSXA5cGtzNk1uRmpPangvZ2NPekduUE8zWGNoa0xrV0QxL1lpdHFvU3hH?=
 =?utf-8?B?QSsycWs2dzM3NkFwQWZZcUNKZVhPTVV4ZHNsVnhHNUJvVk1KNlllaUVQSGow?=
 =?utf-8?B?L2Vab1hIMml5T2NJUk96VURUTWpSUUs2eTd1WFZ3QVdoclhVajFLa0lQM1FW?=
 =?utf-8?B?cERuc1E3NDVkTzZBcDZveVB3S295Rm9LY2NHQUdNS0FURG1iM241UWt3cENV?=
 =?utf-8?B?ckJkdUdXWGEzL1U1YkxaRS9YN3NsVlcrdnREaWk1ZGk1S2ljMXlqOVE2L2hS?=
 =?utf-8?B?THhtam51TnRSQ3VDU1FmRFZLVVZHYWcwcUpoRVFjNzMrOUVTVEMwMDJGazFr?=
 =?utf-8?B?WllhUWZWR0IrWVJPbGRmYXlySmRaZWVVSCtucHA2M1N3UC9QWDBUYWtIRVNR?=
 =?utf-8?B?RzUrSUgxaFdNZ01VL3FURm9kU0cwMGpLaCtRYnFvT1lTZlRqMXFJdlowVHVY?=
 =?utf-8?Q?X9hSPdDZnjkAC/H6jh7l6PLwQYKbXuR20xWcgULUF5BMa?=
x-ms-exchange-antispam-messagedata-1: 0k68B4eM+mJv4Q==
Content-Type: text/plain; charset="utf-8"
Content-ID: <1FFC5B6609DFFF4385E8E19026D75B84@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0835787a-7498-4f52-4f4e-08da18d61c34
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2022 20:35:10.0667 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wZtOgsTT5UP0HIJCbWn/XPvr0ylUjuDs9mJbp7mhnIi/xJDxfu0IfPKAO91JreA60JswI4A6hZvBpUNlCCJpTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1680
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425, 18.0.850
 definitions=2022-04-07_01:2022-04-07,
 2022-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 bulkscore=0 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204070064
X-Proofpoint-ORIG-GUID: YP4va9PJTSGOAcCJV2h_3ggLdM0m3EmR
X-Proofpoint-GUID: YP4va9PJTSGOAcCJV2h_3ggLdM0m3EmR
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_133523_535896_CC7E0984 
X-CRM114-Status: GOOD (  19.75  )
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

DQoNCj4gT24gQXByIDcsIDIwMjIsIGF0IDE6MTAgUE0sIENoYWl0YW55YSBLdWxrYXJuaSA8Y2hh
aXRhbnlha0BudmlkaWEuY29tPiB3cm90ZToNCj4gDQo+IE9uIDQvNy8yMiAwNDo1MiwgU2FnaSBH
cmltYmVyZyB3cm90ZToNCj4+IA0KPj4+PiBVc2luZyBSUUZfUVVJRVQgb3IgYmxrX3JxX2lzX3Bh
c3NyaHJvdWdoKCkgd2lsbCBtZWFuIG5vIG52bWUgDQo+Pj4+IGFkbWluLXBhc3N0aHJ1IGNvbW1h
bmQgd2lsbCBsb2cgYW4gZXJyb3IuDQo+Pj4+IEkgcmFuIGludG8gdGhpcyB1c2luZyB0aGUgYmxr
dGVzdHMgSeKAmW0gY29kaW5nIHVwIGZvciB2ZXJib3NlIGVycm9ycy4gIA0KPj4+PiBJcyB0aGlz
IHRoZSBiZWhhdmlvciB3ZSB3YW50Pw0KPj4+IA0KPj4+IFdlbGwsIHlvdSBzdWJtaXR0ZWQgdGhl
IGxvZ2dpbmcgc28gd2UncmUgY3VyaW91cyBhYm91dCB5b3VyIHVzZSBjYXNlLg0KPj4+IFNDU0kg
c2tpcHMgbG9nZ2luZyBlcnJvcnMgZm9yIGludGVybmFsbHkgc3VibWl0dGVkIGNvbW1hbmRzLCBi
dXQgbm90IGZvcg0KPj4+IHVzZXJzcGFjZSBwYXNzdGhyb3VnaC4gIFNvIHdlIGNvdWxkIG1vdmUg
dGhlIFJRRl9RVUlFVCBpbnRvDQo+Pj4gX19udm1lX3N1Ym1pdF9zeW5jX2NtZCAvIG52bWVfa2Vl
cF9hbGl2ZV93b3JrIC8gbnZtZV90aW1lb3V0IC8gZXRjLg0KPj4+IA0KPj4gDQo+PiBNYWtlcyBz
ZW5zZSB0byBtZQ0KPiANCj4gVGhpcyB3YXMgbXkgaW5pdGlhbCBwcm9wb3NhbCB0byBmaXggdGhl
IGNhbGwgc2l0ZXMgd2l0aCBpbnRlcm5hbA0KPiBwYXNzdGhydSBjb21tYW5kcyBbMV0sIHNvIHRo
aXMgc2hvdWxkIHdvcmsuDQo+IA0KPiAtY2sNCj4gDQo+IFsxXQ0KPiBodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9waXBlcm1haWwvbGludXgtbnZtZS8yMDIyLUFwcmlsLzAzMTE2MC5odG1sDQo+
IA0KPiANCg0KSXQgd29ya3MgKHN1cHByZXNzZXMgbG9nZ2luZykgZm9yIGRyaXZlciBpbml0aWF0
ZWQgYWRtaW4gY21kcyB3aGljaCBpcyBnb29kLCBidXQgaXQgYWxzbyBzdXBwcmVzc2VzIGxvZ2dp
bmcNCndoZW4gcnVubmluZyAibnZtZSBhZG1pbi1wYXNzdGhydeKAnSB3aGljaCBJIGRvbuKAmXQg
dGhpbmsgd2Ugd2FudC4NCg0KQWxhbg0KDQo=

