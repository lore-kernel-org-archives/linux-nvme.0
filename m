Return-Path: <SRS0=uaVC=IP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E236C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 21:41:45 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C222264E64
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 21:41:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C222264E64
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LWLr+jlkuhs+TLlZkbyQ0rdx4YQa0EjC5V4fAGzOwhE=; b=VjDkjveq97mUt2uM39SlvsRDD
	TvDLSV6Yvz5eZWHxBrfZm4gErRUOudUpzQpMyjjCPvijkIQX3IF+cM+BXjvKik+uZvTKpHAt6u81L
	bhESujoLr3KZhhRErW/KJQFZItjmS96YXIpcx7NyCpVBT0lMJDdsp5+3P0kIhqesdPxbYBG5guJ7B
	n+EUUaqWKcT+YpwawZ5oX6LEPiS0B7kq8tV4QbpLIB7KV1bBj7AIpRQZ5779wMo2Y5XeAitWF9z4t
	DUBSuIQXaFOGGg9ccdk+dBnE/z6nsEhpCgGJ4OMQOdgkDzVJjevqLeOPZeJCgAVjf0iUkUadx+vQr
	ZK/01CeSQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMduZ-003xJo-Bp; Wed, 17 Mar 2021 21:41:08 +0000
Received: from aserp2130.oracle.com ([141.146.126.79])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMdtN-003xFT-Aw
 for linux-nvme@lists.infradead.org; Wed, 17 Mar 2021 21:39:55 +0000
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12HLO1mJ110365;
 Wed, 17 Mar 2021 21:39:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=f/F7SORh/LHUCU6t5Xg0/K1+E2XUJuRnhCBVAXwobP8=;
 b=PUMxXXUo1mwNa51Xri1zAX2K59u1Dk02D07HSLitnIfglOKM4VbEgn8fmf+9+ino0I6T
 FGs/yOgtomk2e19SiUcBg9xxZS6lMJWCaibcD60RdvPa/c9ssEDabli4/CPQheG4ONx9
 vyQrSHXJBh/zAeoBJyjS+uxAfdv+Eq5r+yAVsc2vogUODxhMlUGCo80YMZ3qGhYykD/J
 sxv2gTHQK80m9jAtDHPKO5EM6xqHtGbSfoPtJgabEfZzCUnBqO8DLRz2yNPp9kQZuunB
 OFqTcs8RnGvqSdCrrevgSqEcvoid0EaxfdZXCsmV20A2K6IxxJ4+SoU1uovemF6yl9qi mg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2130.oracle.com with ESMTP id 378jwbnput-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Mar 2021 21:39:42 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12HLPsqV053851;
 Wed, 17 Mar 2021 21:39:41 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
 by aserp3020.oracle.com with ESMTP id 3797a33yqf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Mar 2021 21:39:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkvQ8VeeFCGSiezQzcBfXQwy8e0BftyjNACnl/6PY31xjJE6RALYXHUXsjlJkN0gbHjCLWdLdidBG2bdPc5QAwt9PkIhHppCTIEvhKJ81+O/maWA8uhItz3dsFwyyR6KBMaHlqs/0ZiAbGsdyEWsF4Y0rXqftnibddFvWQYhKG63l4cZMjtWQKVKLdylGGNQO5HcgiW/Onw9JBITGhg+RdeMFf9AvTR72UGdSsB4+N2k5A3szgp/6op6dNmjMT0rBQrxyxTOxw/O3np3exRz4MdWXoaryGyDXyrDeICSd/GBDdJ0VpjGcOczCV/KR3nERLPLCi3XBHSjGXGCgJG+Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/F7SORh/LHUCU6t5Xg0/K1+E2XUJuRnhCBVAXwobP8=;
 b=KKtWRoqBuIqQwhlsM/oHpLgvLnhGez3MQKHtxrwVH3OpyvAo9PtM7M2qZ7G6qVF7Rca61lGl4nzjLSVQtDOF+DOqN/ftHCZ05aswUxKroH2kr4ESM5V7uKvNVwt35+91/Jsd3s2xaQ0UzjAbqibH8GReUsLmjmFV8c9rhb/lZbEHbzZ9xkSRkTz4wVorN4GANzjS/8NPpPRmz3K2ne8g67RolN4zWT4jDu0bzZmmU72fO2LDw6tCPMpmTvf7NpBfjJBGA+ZUJ6cKqmTLGlR8iqHfsIb27N5jQDUong1JFvB4UjD6+j+4FAZHrT6mWaBjK9DJLb4yMPJFe1bzs6ixfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/F7SORh/LHUCU6t5Xg0/K1+E2XUJuRnhCBVAXwobP8=;
 b=fMx2nbvR4Xcmxdyy9djUGOhLnVrBnnYaELCaVcHsaa6Tc8CAw/FPrm18OzSZaqAPUprHA7EeovqYOLyj1A83UTqZXl4yXajwQZUva7BYmv43bQESSYleG/wSHZH5bkTJuLZkV/Wu01ADRsT6YSrNsJulIoLYamMDI3KHg0my63A=
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SA2PR10MB4665.namprd10.prod.outlook.com (2603:10b6:806:fb::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 17 Mar
 2021 21:39:39 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::20c7:193:d737:7ab1]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::20c7:193:d737:7ab1%4]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 21:39:39 +0000
From: Himanshu Madhani <himanshu.madhani@oracle.com>
To: Keith Busch <kbusch@kernel.org>
CC: "joshi.k@samsung.com" <joshi.k@samsung.com>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCHv2 1/2] nvme-pci: allocate nvme_command within driver pdu
Thread-Topic: [PATCHv2 1/2] nvme-pci: allocate nvme_command within driver pdu
Thread-Index: AQHXG3DJNH+0IlGaDkGpC1jJzDN7YKqItS0A
Date: Wed, 17 Mar 2021 21:39:39 +0000
Message-ID: <3E3552A0-3932-4EE4-A30F-E1296503CC2E@oracle.com>
References: <20210317203703.17391-1-kbusch@kernel.org>
 <20210317203703.17391-2-kbusch@kernel.org>
In-Reply-To: <20210317203703.17391-2-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [70.114.128.235]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a59324d-f35d-40c1-49e4-08d8e98d2b06
x-ms-traffictypediagnostic: SA2PR10MB4665:
x-microsoft-antispam-prvs: <SA2PR10MB4665EBE07332F30AA23C7835E66A9@SA2PR10MB4665.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rnjRCObg5x3TCWRH51ds4MpYGVVnrbWxbAdeZ+efcXxpVOdyByPZXdXF56uj84lxhlU4ABJnR10ju7qqWmYuQFJye//3MocIJpzLpFsaomc2URW7TewXCjix2e1HDZhiGfyUmc6sEm3kCozRVv7zcTy901uJV+qWTzgRQ8EEOwYWG4bEn1DBS9k6kSfjyd+76rqetvUAmldTdaXmgMYSvZzwemZPVojXztKWiaZXRPcq74kQVL+Mm9FJnwqxE2YqqMriSUX0cjHd7WKC3v5bIp9ALanWTbcxbaaTO94Le30h6xVjtIJnT5xDxBgxYTOR3Des/nbJJT8i2nobbRdkwRhzDKjago0pPHp4ZJjRMLqBB0TiYHKqvWIsPtwY9Jxouiv33tPOjmilii8i/ZD/dskmEJ7IYis+snphDP6yzlD3tD5678I83OxNwQAxSO9pqxFGY0beFdwDWD8HZTzJbR8juFifYAaakDapJhkN64dw33a6XeJFao7qy+SX1S+Wsh/rhQpetv42OwrvO2CncH4xsbr3Q0cK6052m6exUo+KsHfBmMNfLWzWTdLV7h8BBBRdyouSKucRnxJ8NZSIJ26aOE4jrE/n+udAteieRttK1wNuhm0oCGTUZiUL+mKc8XfNy1Xw7Pe8aGf1r4ZD0P40G0tRdvs12Gxcy5fqqvrUTFrMswijotkbNZ1s/slh
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR10MB2943.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(376002)(346002)(366004)(136003)(39860400002)(83380400001)(36756003)(2616005)(186003)(33656002)(8936002)(54906003)(6486002)(2906002)(44832011)(966005)(6916009)(53546011)(6506007)(66556008)(478600001)(66946007)(66476007)(64756008)(66446008)(71200400001)(4326008)(86362001)(8676002)(316002)(76116006)(6512007)(5660300002)(26005)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?jJScXKL68RFJVshk/BQ+iqZEGatmGOIDiQNJL82AL2UPDGM/v6qWRpMes2B9?=
 =?us-ascii?Q?JtCtLwyb8pknJvHrliYhLiiV4Qdkqk1VhoU0Y+zBugFDON6PYm1LLzrM6o1A?=
 =?us-ascii?Q?yYih0ELsS1wsZsC42HJwKyEnyyPj5bkxdLpv7hq7OL5t7Gr1eQCu16zcbP3t?=
 =?us-ascii?Q?IIWiQh1px5SSdj9BLzN3snkpdsAKCWw7Zv1Pl27RGkHQKwf9EBIeQZgwcgmM?=
 =?us-ascii?Q?yf3FxluzFanRS7dLb4tGd6yuzI4Aw4R5eKBgFv6UDrHzed5hSPM9tHnvr/UB?=
 =?us-ascii?Q?WKV2tfJNrst94nNdu/5hSq9PE5Gd9MBw/vsgTMj1wK5S1irKTnrk6xmLSDgS?=
 =?us-ascii?Q?gbgRp9g8nSg0ZJlkn2ABkz+aY3CuSOAfd/JpXmGL1+K7PqQGZzOxZh1IXgpT?=
 =?us-ascii?Q?OK/ud5yzeAUEnRzYN4kv493k0GxbVEjlg+LNRPAsP83jWJ6ajHDuv26mmJyk?=
 =?us-ascii?Q?27iv5zOUvtuxKH3Z8oFcP5OcZq8u2r6Jh426ZtS4rkVGzL9eqAagiltPkbTO?=
 =?us-ascii?Q?fNDaMigkLWEtjkQw2189SgY92gHm1ylvpdb4mjUROdLP3RAuCZqqxVqXYtv9?=
 =?us-ascii?Q?EAPT/Ibg4vDdAXTPQRaELrRZxYoUR0CLCYUmmV+LxeZXF5E+06/cgPHeys5n?=
 =?us-ascii?Q?E7hCd/F85icmNbWIQt3IwOrNfDJAf7NqQqUED6i7B+LVCfmX+sdpIfDKvdOT?=
 =?us-ascii?Q?UJR6MiQD7mVdSEKXeDxCZPUkHscg7rz3BFj+lWCSXEyfft190wiwlIRftTI5?=
 =?us-ascii?Q?mlK/TNWdb/dZNtff6BXUcWMG2Dqj9P2FWXz1zK761eG44GAheIasZeiMom7H?=
 =?us-ascii?Q?wJR5mEfx7JYNy8XCDbHKPnFwcicQBbJ8Fipqfi6iB/Rs2F1LtMfcijtT9icT?=
 =?us-ascii?Q?Ldz4MUr304hnuYBUZMsEsuiGJR7+2j7WE7G4n6+r5p54wBMn+3E4I/WgltH8?=
 =?us-ascii?Q?qyLu+26GReEMuP+cQH5A4MGbuBNCLVGkEAYxtnuaSu4UHihrc6n2KP+iTpIK?=
 =?us-ascii?Q?rHQT9jGii14zaJwzDZ66M2lCfLWOzESpEsu6i1Ej1hZ2FKjk4J9O9fdVmlr4?=
 =?us-ascii?Q?2IIQKuGWuSON9JWkPR4a+glUKQxYHkJ4NAQzerWuG7Cl6QsxTwGsFnjBMyFL?=
 =?us-ascii?Q?je5FOw6LLSi+8rrrpxjv+eHrQpwLatIV7c4TSRWEnj+qAHvve3RvxvwlvUhP?=
 =?us-ascii?Q?crQW6y7bExwv37BQaWjR/0GDIFN/+/uUwr8R1yX6JBV5tN2/cqa+u8A8wyM1?=
 =?us-ascii?Q?s8ETK5cTimWiQjtEFtP6Nj9TUYjTPoDHbcU1SPnPqI7R/nuSlP9MB7ahW5TH?=
 =?us-ascii?Q?OMnLySF0TPcBGtjk9ioJ5N+iHi1xa7fkHrm1JQqtrpJu8g=3D=3D?=
x-ms-exchange-transport-forked: True
Content-ID: <90AE7C34EBB7A84B9BE9DE86FF083691@namprd10.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a59324d-f35d-40c1-49e4-08d8e98d2b06
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2021 21:39:39.3278 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MNK4V1fRReFeb/4Tl6pBBvTyR1YQ7yE8tpvfbmEN6/ELxWgOsOgqT1rv8v4xW1eOQpmhuekTTOX2CATzM3yhEz1mAu4Cr/3Qr/1bMM7dtAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4665
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9926
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103170151
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9926
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 spamscore=0 mlxscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 adultscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103170151
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210317_213953_556425_5A513B12 
X-CRM114-Status: GOOD (  26.50  )
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



> On Mar 17, 2021, at 3:37 PM, Keith Busch <kbusch@kernel.org> wrote:
> 
> Except for pci, all the nvme transport drivers allocate a command within
> the driver's pdu. Align pci with everyone else by allocating the nvme
> command within pci's pdu and replace the .queue_rq() stack variable with
> this.
> 
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> drivers/nvme/host/pci.c | 11 ++++++-----
> 1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index ecd11b1febf8..1a0912146c74 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -224,6 +224,7 @@ struct nvme_queue {
>  */
> struct nvme_iod {
> 	struct nvme_request req;
> +	struct nvme_command cmd;
> 	struct nvme_queue *nvmeq;
> 	bool use_sgl;
> 	int aborted;
> @@ -917,7 +918,7 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
> 	struct nvme_dev *dev = nvmeq->dev;
> 	struct request *req = bd->rq;
> 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> -	struct nvme_command cmnd;
> +	struct nvme_command *cmnd = &iod->cmd;
> 	blk_status_t ret;
> 
> 	iod->aborted = 0;
> @@ -931,24 +932,24 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
> 	if (unlikely(!test_bit(NVMEQ_ENABLED, &nvmeq->flags)))
> 		return BLK_STS_IOERR;
> 
> -	ret = nvme_setup_cmd(ns, req, &cmnd);
> +	ret = nvme_setup_cmd(ns, req, cmnd);
> 	if (ret)
> 		return ret;
> 
> 	if (blk_rq_nr_phys_segments(req)) {
> -		ret = nvme_map_data(dev, req, &cmnd);
> +		ret = nvme_map_data(dev, req, cmnd);
> 		if (ret)
> 			goto out_free_cmd;
> 	}
> 
> 	if (blk_integrity_rq(req)) {
> -		ret = nvme_map_metadata(dev, req, &cmnd);
> +		ret = nvme_map_metadata(dev, req, cmnd);
> 		if (ret)
> 			goto out_unmap_data;
> 	}
> 
> 	blk_mq_start_request(req);
> -	nvme_submit_cmd(nvmeq, &cmnd, bd->last);
> +	nvme_submit_cmd(nvmeq, cmnd, bd->last);
> 	return BLK_STS_OK;
> out_unmap_data:
> 	nvme_unmap_data(dev, req);
> -- 
> 2.25.4
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

Looks Good

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--
Himanshu Madhani	 Oracle Linux Engineering


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
