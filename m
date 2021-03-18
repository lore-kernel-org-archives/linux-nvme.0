Return-Path: <SRS0=ZogQ=IQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA2BC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 16:28:58 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C0CD64EB9
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 16:28:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C0CD64EB9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=S5SidqGDDdFgO1mPFpPxAphZWDWzLpPwuDS/UE9dK9Q=; b=akN13kusvWC4lcVujZSL1sh3B
	Pkl4R+1b/hTSMc7929WgWtLl945Zqfpzhaa3J5txeXdXHjR3mf/SguogFiAOFjHItmaZmpmrUTiSV
	PVYaC3QBbTwGIB2GvVb5aZ96blYHlHUFRD1QwZnV3hBzCA+H9mKtBMiiuG1qNK6i1uYUaaK8c0L+i
	05yyo3J6n3cjGmBbiSlgfXLC3wGbsezmJ2qooapi5cYlZjg1hteKDCZcbb/5Jvsbl1Waf/YpSfpTo
	YOutiKMVcw2SxjZOyc04NfT0bQYDb5wlRFumpWzRmtXEgKeJ2ugpp1rBHDdbWYOkLqtii74sFq3te
	jtZqbHSnA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMvVq-005ccp-K3; Thu, 18 Mar 2021 16:28:42 +0000
Received: from aserp2120.oracle.com ([141.146.126.78])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMvVl-005cc7-K8
 for linux-nvme@lists.infradead.org; Thu, 18 Mar 2021 16:28:39 +0000
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12IGPIv1062112;
 Thu, 18 Mar 2021 16:28:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=32DhNssuugH2eumBbzqcz46/wVMD9J2EGP/ToGcDVak=;
 b=xmjwa/XjqMfyabdN8C1Fj4OxbZ9Amo5d3pcSfn8gc2L42X83+ZPA0xA7n7W0gzs3wxzo
 PQDC6jmsd/Xc/DoYdKMTrHiD86lv+M9u76na+yHC37csBRcZ7Etxw8nK3DRhuf2WdA6G
 Y9b/NrSb+oj0P4hE6PB1fx7FhHlz6egLSEh2T73+9X//nAkmD+uIR4Lyogoot8+tIO10
 OhBVIucwc9oJRu1uQ2aWJEX2a3/ap7EVFW796lNmycl+45V4+LtNBpK4UPSx+Jb9ue8K
 X+WXVjRxIZ3SpHDLvseCGTU6O8+om9Cal6MEQgUMDlZpnUktkuXJg453jIXCk4HTcJ4O mg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 378nbmg4p9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Mar 2021 16:28:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12IGQnpL051977;
 Thu, 18 Mar 2021 16:28:27 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
 by aserp3030.oracle.com with ESMTP id 3796ywdft2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Mar 2021 16:28:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UdiB/oplFpoVhayjMFbE15h91/z78K3SyGgjChZBCIvRhECAs5GJ19OkDcX2W35qBCxFJQVJYEVuSIS6utdAo7anGeosDNDFjOD0F4RXOQGS652YeSHEbk047lwYnNYKBOx8QfUQAZ8/fE/SFFZAID1jgQTykEV+VIe6as8gCuz0mv4RBLdozG3iLhyS5L71a6oROtklvbxWFpmYVoN6Fd/H117JlhbXczGSfaDaoHyD5Ep2Yqf0w5VxA0OasSTlEPoSVnAUOPJ+DmShRfJhHgMpHDSinTkKmQegOu51q6PvzxT0nXt8OcBNLRqfbHVpZJR+udDk95rDHZabIi0O4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32DhNssuugH2eumBbzqcz46/wVMD9J2EGP/ToGcDVak=;
 b=Ind1SAuQtMEpNJh4SlMsR6WCHbuaLbwa8fNeZGT0d2f1l3fs5y1+uhmYbdiLV5iJalAGFhg0XoW5gNrcK/z/R+x8BbSVSKhoJjQ4Mx14dPKs3IhKV1iPRx8vwyrIFlUKMhye58Pc7GdD635szwpGlOhT8SdXOts6HuDZLsgQLZdxzKytczjpFK+GYzmbCBqJflwhqjIHfyUvtO2J4cI13VgZeKvVKhwyV0jduV+cciAomHAdQQ0JZyt54IMUOoSVF8Yy7TKF6KHfYRJFKB2DVGY66JLzIj0NZGHKmtVE+HGJ3V4C9IKoxBMycdnKu+Xh4DYZYmp9LUqR/M7lUOlfQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32DhNssuugH2eumBbzqcz46/wVMD9J2EGP/ToGcDVak=;
 b=JE02buhMwJVSMIGqwC9uIPEagGKV3dGV7GukqxJUbpMu1x1OQDGG2ajVi27y+0LukI9DAFrfUPNwpgLWZA4099866aHBE+c0PRGOVk+WrFd3s2jSGv/lTvA6wKtooU6o4cN574cAv7OEXVsKByxdhfj/bI6W995cw7b5kJ1TR34=
Received: from SJ0PR10MB4815.namprd10.prod.outlook.com (2603:10b6:a03:2da::17)
 by SJ0PR10MB4799.namprd10.prod.outlook.com (2603:10b6:a03:2ac::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 18 Mar
 2021 16:28:25 +0000
Received: from SJ0PR10MB4815.namprd10.prod.outlook.com
 ([fe80::4570:7f3a:a913:4408]) by SJ0PR10MB4815.namprd10.prod.outlook.com
 ([fe80::4570:7f3a:a913:4408%5]) with mapi id 15.20.3955.018; Thu, 18 Mar 2021
 16:28:25 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 0/1] nvme: Export CSTS register via sysfs
Thread-Topic: [PATCH 0/1] nvme: Export CSTS register via sysfs
Thread-Index: AQHXG26dbipyKKgQXUmKwfMgG9mkE6qJKjcAgADGWgA=
Date: Thu, 18 Mar 2021 16:28:24 +0000
Message-ID: <0D18CE6C-4390-4040-98A6-14204DE33253@oracle.com>
References: <20210317204615.13971-1-alan.adamson@oracle.com>
 <20210318043828.GB26988@lst.de>
In-Reply-To: <20210318043828.GB26988@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [76.176.17.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a9604b3-e94f-49f0-1a68-08d8ea2adaa3
x-ms-traffictypediagnostic: SJ0PR10MB4799:
x-microsoft-antispam-prvs: <SJ0PR10MB47994565B0897728491E7452F4699@SJ0PR10MB4799.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NXyjnzKg9YnHVA2LYE5e2nEspFLG3MGy/gb/wPJ9FmTDGIipNowMrmDR+UkauXhQrVftwZQlJp4KX2tylaLBVcJZbRNKT5yZkqH6DGszznRNrWotna1i1rlkxh8izphOZ4QvdkztJPvmBA9njoJ4ZGS7L2IV3lEwXEyaRB1WV8qAUe3EFEiuLdNcU8TSSP0YtF0eXhFjy/cKw95uu0Bnk65Vc/1Z1wxsrD9zYCFVYcNhiWNbvwXwvsn9aEp0wzdH4QC43FBtRYUG+cfi9VHG89JvIB2DyErSlXWzn22BDGS6FAGU4L63I7lE1w7meIdkeB5quVpe7UwK95NwZQyp2yrSpozeoRy/zp2LB4FMNFXWdJULyDHuSEb25f/2Cf++ZaZfxD7G/vjMSjAUEH8JpDEkqCcnBtwQ+4KA3eMwsOts3NTxhIfxfpSwbyc0/v4t7Ms2IRyx2zTeOPGOEWdgX2Sdb619ZT3iwjb/DV6ZXHbtK4af1jIAo9xwOzfGfQ0CdOy7dgGHrewJJG2qYDwMk9UMyJGId2/3bsDWkFvKjLJQtXhRZr66sHxcjmMkgybynVmyIzQdSm5gV+omxnkNokiLL3V1mKe65KxHWU/KvPdZ6ZCiX5L90TERAT1Ry8uYelgT4+OXyQBnyPzACRHcyQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB4815.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(396003)(376002)(39860400002)(346002)(136003)(44832011)(316002)(66556008)(66476007)(5660300002)(4744005)(36756003)(478600001)(6486002)(38100700001)(6916009)(76116006)(71200400001)(66946007)(66446008)(6512007)(64756008)(8676002)(6506007)(2616005)(8936002)(4326008)(186003)(86362001)(26005)(53546011)(33656002)(83380400001)(2906002)(54906003)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?tPy541yXMVgTEs31tuQmcMXx3uYbjmHQLRCTFe79Tx4gr2BHUeggHM5CXvMw?=
 =?us-ascii?Q?bn7Z8cX541TXUuIuU4n0l4/gmxubyTAZvsdm1tlj872W+0lSGeJUsbOJsXuc?=
 =?us-ascii?Q?OLSFM1CBeoi4Vxh8h9NFVL1taA+PIjWOkXL0msurZLOATSN9QIg4zRKdDv2/?=
 =?us-ascii?Q?vDyySyfaAi2vscUIUSIkBC0KjThdf1gU84+oa2VjsDM7zFPMKtw16kzwDTX+?=
 =?us-ascii?Q?2GxvF04DIh7cMG6ALS6lsVpKKjOXPVpZnhBLF/MYfDWJa1wkH2mAA5/HkON3?=
 =?us-ascii?Q?M/jWdG9lgO9o7tY13AYrsPKiUNUimLfIvMBztBy3dVVuyO2Wx5vRT8RFTqdg?=
 =?us-ascii?Q?DLHq6d37czXl6FfFH9H0HUpwfFuzXoaAWaXrKNPdndtTcAIc01qusw5xzTuh?=
 =?us-ascii?Q?f2RZuKAE3StKmBx/yCTGCIfH0CNlSS6rOfTP+11aAHU6KFQHMSHE4dEnP2Hu?=
 =?us-ascii?Q?UkHfmRXZVpEqkDyPJhiATwcTtjKRrth2qC+B2KlhWruvGXCBbIKjeqQgQoPH?=
 =?us-ascii?Q?1A+OI14TtJIvKSCJ060ZpN0mB3wxfzOVVbUomZs0O0SYaEfW99JzZl/spJ2s?=
 =?us-ascii?Q?/QM29V7abinakTUy3w5Fa9QJm0kKJS2Qt9BlgsB2Fn0D+MzkVsuO4WPUQBm7?=
 =?us-ascii?Q?wrnDvE7ngG3c3zYDUEuGyyzu4f35jRmjawiotCbdeV3TSR5vwPfMSbVntkIq?=
 =?us-ascii?Q?sytHp/oUHeVpUjuDwATzQe2boyPdQaE5CtZcFgvNtrM1iwPPRBkwkepX2j3p?=
 =?us-ascii?Q?Qa2Mbyn4kEQTuggSFbUu8FfHFt7JEDNdopDHDfcnQY6dXaHRVuMi5nQCPBf7?=
 =?us-ascii?Q?/eTwTO0U3yOgDqhsDmOHY9IDk8rzlC1apkgvR+dCjqZpOqSb1fU87ws8d1Fs?=
 =?us-ascii?Q?9FLrUNFWLaamkogMTek/lP9aPAwuQV4Za5xh4Hl+1dH9Dl68CESTOqENdsvJ?=
 =?us-ascii?Q?JX4Xfirc+5Dcvs2Ex71mkL0eFUpY2eJEgGUh3SoFfF8YzwOxttCseI3zkrOA?=
 =?us-ascii?Q?fFJvtqOFlSR21GpAuYCv/0u3Odbnm4DGPriNoAPBMtekucEGsxdzx4TpRsON?=
 =?us-ascii?Q?0f7poaODiVmChcNhUqNnYKO8R3lLdhH0QVCFu1klHd5l5Vnkulupj/KyhMJN?=
 =?us-ascii?Q?/h9vatZWPjr9Y5TB3mIKjoLTlNIDBCdwvfhechHsxEd+qbsnoITCgfOMmkeX?=
 =?us-ascii?Q?MXnpasTVR/u7cW7zTjh6kLsTBwxCSaqReqMrmyoiPd7ExiVhH6o8TPcukw93?=
 =?us-ascii?Q?Cij8c9JiJ8RvZdoLcU5f5NNLENJlHAQd4BFtNmWX38yNnZ9iI+QtFDMT3+Vu?=
 =?us-ascii?Q?2gAxk77gK/aDbxgXf7YTq1g0?=
x-ms-exchange-transport-forked: True
Content-ID: <9D39697E8F57054CAA9E8AEBFD3A8B48@namprd10.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4815.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a9604b3-e94f-49f0-1a68-08d8ea2adaa3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2021 16:28:24.8622 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SwwF1Y6/Lf/u76YUNSe3HZhJ2XF0zjR8ucQUXT6rkjGRHC/4Zpi7rgF8rz6O1lLY/2bJOqUmPjQ5TbwmlAfA6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4799
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9927
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103180115
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9927
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 impostorscore=0
 malwarescore=0 adultscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103180115
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210318_162838_078774_C1A3F4CB 
X-CRM114-Status: GOOD (  19.27  )
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



> On Mar 17, 2021, at 9:38 PM, Christoph Hellwig <hch@lst.de> wrote:
> 
> On Wed, Mar 17, 2021 at 04:46:14PM -0400, Alan Adamson wrote:
>> This patch exports the NVMe Controller CSTS register via sysfs.  This
>> feature can be used by userland executables that accessed CSTS and
>> possibly other registers by mapping them into user space.  Since this ability
>> may not always available, exporting certain registers via sysfs provides
>> a safe/read-only way to access registers from outside the kernel.
> 
> So what is this application doings with it?  Should we just have a
> ready attribute instead of exporting a raw register encoding?


Was using nvme-cli show-regs to manage nvme devices. This is no longer an option.

Alan




_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
