Return-Path: <SRS0=WLLZ=IK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69659C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Mar 2021 07:26:25 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7798C64F81
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Mar 2021 07:26:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7798C64F81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=K1Q67llf/tay3G+THBZYvpNpHh2ZsetQgy9dgwOTEeg=; b=IHAf65MXvoV/FrIFGmCDolGnj
	f/6Arv+62SutIu67kTllXGbur6vVU6l4PH2884tI4q5p3oPiETcpepYaKdiA1yMPvbEhODqCU7gHZ
	FJYtHz2YqJyo1zI4kfqbCWDU1nwswN5DVcp9/G2Hm3x3kgZJaKDRWfT1RcHZMmFIylHjKf51mDypD
	I1mF9CSMkoIY0hsm9WJUqZI6u1kVphulybKzgzP9eyyIuau4de3mbiPMBbIvg0LAAgPSybwLOeACu
	Gy1/lkTm3PzBCRx5tPmXAqRIpvUp3jaEIDtkCN+3D7I7ahNbsx+9/9vRAystZA0Zthb2pRUZwOoyt
	4wYxGWreg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKcBc-00Amu1-SJ; Fri, 12 Mar 2021 07:26:16 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKcBP-00AmtS-UF
 for linux-nvme@lists.infradead.org; Fri, 12 Mar 2021 07:26:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615533963; x=1647069963;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=V+UITSbPrM0hEDkYo1nsDooo9P0JFJOzLfFeSaLuoWQ=;
 b=rxE2oCI/wu4cD96vRvSLnpoI2Ogroo7YHRiDfmTdYEkZhw8OTId5x7IK
 iZhN9aLqn3VDZ3IJUJrH4CKL1PTAtS026G09VgCpfVm4kv8eoNo4C5A08
 QaNmFwaHkncTpnD7ui/G2jwCRNuGmeouTr7pCKv+TwwBMXvnAYIlLt0RK
 c2wqGDknZCPYiooApmtrvvl/yqTUdI/ESyva0mf7NqjeqD3h/HsdTJuT1
 R4v0bdcNtwWpT5RPSknJ/ajh+oRvNZ8lu0qp5vXUDgXK441gKV3WgdiXI
 uMl3EiiB7ZjLjFM7XzO7Bs5aYhf3oUlkeRXMdjuPEjhb4l9Py5BLJ4Lss A==;
IronPort-SDR: gr3TxJ8i3qSOtSgxo6hv2X2WRtBox140pIZxIlvlDZIk6nK5dKChkSk2tSp4xBNtpTtq31BuWD
 toK2fbfsfsv3C/GxK630cv+1ItN6vSiwIWT1eGB7DjWOoaKt6EO05lhpt/UW0xJQHXSUoZOpiz
 hQnKVdwmtizYrUc8QO+ugRGyUtm0xD5k1rTMalsaPS86qM9VV/k/JlGRWVoU2jhKa5lKW6GHnG
 zWEnRWoZM7HAsgxwa+id9PNir6/TdIbxwhqk+J0pSgT+Ttha0ETnnYOr6IiW4btmMI4TJ3F/x+
 GUc=
X-IronPort-AV: E=Sophos;i="5.81,242,1610380800"; d="scan'208";a="161978939"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
 by ob1.hgst.iphmx.com with ESMTP; 12 Mar 2021 15:26:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ecQO8S2F7yswfeGE2i1wtgTWYd5NX/P8rUdtq2mXEjFLXr/OMUMhru8Uifn/0/9X3oT1GOTg8ee42qGOVge82wteA8tzAf+S39K5rzNBWCBajBD+Rx+zJjMLTLpKmP8piqYTUpf47ayQ06tp0o3+SiD5g3zuZS9+UZ9ndpUKFrerOJ0rHdemwzdB7NoY4V+WaoiasJWIYF1fvqUwFSl3Nr4sM0A/fIoJHbtWNrw1LAghb90Ksg0Bn5u5KGuGjy1+O6L0Hx52rfEmyPZN1pB+c5S+pH5uI+LEffHd+cCi60/0uFy/7gAELRGSF4StGFM9000LpVc4mmkd1p18NdgT2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+aW9cyai1IkZBBpqA/RdsqgicS1q5E2JLnkqdqi9lRo=;
 b=mJUM1B/k3EPuu6PQ2Fzpwhhp2l5VFZlFJKWgdR9WeEsGJzuE3Y9t/+iCfAEQLhsFsWXvKiEJw0P8HVveWZVL++kC0i+MdKQtayMW7/3tr3b5eYL/3Ku3vwR9XhLE4Deeg+HdHUpTxppswAieIQnHQQlXl1Rsv5r+TYbZjWBc/yijmacwO8OkG9Vdw/RmqBhndDI8zANV/l+jRitcVOoyjOVj2hTT3lS2GIwzcMgjyoYbVHIAWC3nys/CcWzXhCo7++JG9t6dyuhduve1fm4KEKBWLEVFGgIuDtWMqIgJrUAvlWVc/e575XrKYnOQmWXdnR+YZaXBmZzBV8gDyzqSTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+aW9cyai1IkZBBpqA/RdsqgicS1q5E2JLnkqdqi9lRo=;
 b=dSCGSYE4JTVbFNFHLbfp/6nspVFUVDDQGCM/HgdVJIarhECDwncpaDalMOE+084YEWB42ZyiFYyuuimIfwVb2opnIOk4egaEOVRXUGcfhGEVC7+UyVd/+zY99B2iBAc6Chv/yY4GSWyNuwz6mLZiSUrD5IEfCbtUyWAwtVLeZQA=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4641.namprd04.prod.outlook.com (2603:10b6:208:26::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Fri, 12 Mar
 2021 07:25:58 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887%3]) with mapi id 15.20.3933.032; Fri, 12 Mar 2021
 07:25:58 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH V12 2/3] nvmet: add ZBD over ZNS backend support
Thread-Topic: [PATCH V12 2/3] nvmet: add ZBD over ZNS backend support
Thread-Index: AQHXFkZtVLB3m5Kiw0yrvZIx/W7awA==
Date: Fri, 12 Mar 2021 07:25:58 +0000
Message-ID: <BL0PR04MB6514F4EC40A62AB4763560E8E76F9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210311071530.18680-1-chaitanya.kulkarni@wdc.com>
 <20210311071530.18680-3-chaitanya.kulkarni@wdc.com>
 <BL0PR04MB6514B749F68EB412FEC032DDE76F9@BL0PR04MB6514.namprd04.prod.outlook.com>
 <BYAPR04MB49657E04A5017F5C31D4EFE1866F9@BYAPR04MB4965.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:bccc:6f52:efed:4bfb]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bdc08fbe-eacd-4cc7-4871-08d8e52814ec
x-ms-traffictypediagnostic: BL0PR04MB4641:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB4641F89E22DEC0653B0B16C9E76F9@BL0PR04MB4641.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0bLDjfOBeGvA/k2xVG+4YMJ1q6/idFupj0nZCZnOWfK0H+8ITSesu+kicTvUHEtj9gTfucE0ttdTyKe0j6aDvnBtLVJ4a2xGNH/XkyWyoFaAn9edy7vt6ciL3rHCHnLlaMu1BQnamYwmpHZslV8R5259FGBUlpwMjmKDlzL75AQlSjKW13PvDCaEk2JXmg14fSQrPJoGgylf3jIePqBZm6rwsRk8caNyezLcj3eKcDNpMqZBf/5rS2KpG654MMmFLx8Zcs9kmW1HkyFigAAAURMyAfjjZOyQ4so1PN2DNsJF+EFawynURoVg/mVQtviXLC1dSkrAlejfA1khR1Md/XJ9GEawKL8nnWjRp1ixKaE29e116AWiw7u+iZk9mDIbZZX8I7nhhqPFvbMQMPAtErvZNNRquQR/ZYjZX84LJXYQZ4K1x4hKQz/RkismE+YgHcXUe1bTz+YP+DL3bx3JU3HZuoFhxk8XL8hjb7jWebi/zQN12UaNkmaAZo7gZRoE+QDI9MKGZPr8bhJN++6+HWx2sZtGYeLCeOGDlgVKedZhJ2tngCLh2GKmd1YfhGQSNLZr05J2bUzuYxpkNK2uOnXhQlJedmpno5Y4aJVe9Yc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR04MB6514.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(186003)(33656002)(54906003)(8936002)(8676002)(110136005)(316002)(2906002)(91956017)(4326008)(66946007)(83380400001)(53546011)(55016002)(66556008)(9686003)(52536014)(30864003)(76116006)(66476007)(71200400001)(66446008)(478600001)(5660300002)(64756008)(6506007)(7696005)(86362001)(21314003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?p5dZ9K8uffjjchoLBJRtdGKpquNM/YCX5qomXDQM31/+x/EvQ+4RimZ9CEoL?=
 =?us-ascii?Q?NSt4Vr2Bni7IeaNDRaIl6rDkmhBnc3U5s5lcM4j33oigLe01mrqx/zdHeVpq?=
 =?us-ascii?Q?3UYu7FVdZiLoTuWdoZ5ozUt6VOBCS6Crn0X6s4bDoFBwBK1Ku6WPlzoNWJBU?=
 =?us-ascii?Q?eg4EeM4P28gByL/KDAqKyBc+SSYOFd7D/emBrhKDIjmGoUbQVTsQszVMMbeY?=
 =?us-ascii?Q?ni+tFrWa0D5PRQeeh5Stj7oIcCdJH1SQh9AWQSP9PlIOIyZQ+LgYONme8b2+?=
 =?us-ascii?Q?9NLUgY/+iEOcSu00BOR7NdB3jUB/SMbN3TliwoatlBikOEc4NPv+pqcJBjpR?=
 =?us-ascii?Q?Nd6A7yBAEnPnoa2IDiYLZaa2/lo3fjVIFVzZrOVf7FZ91QaUDuKM8HUOxsr3?=
 =?us-ascii?Q?1enk+VDuvr3BOB40QP0UNXFe1awRi/krfr8EOOWJDQpgGqWIswXzG3yuWNy1?=
 =?us-ascii?Q?/ckbYnc5BJ75nWd6UaGRrDfvUPh7AMt8s3zQhuNkh1yUq88LtHTdk64QRe4Q?=
 =?us-ascii?Q?x3q9SY6wTlIWvpQT9A1l2IVc3P2Ndno281bxh7Ta8djImJmce/b2SInQK9Iz?=
 =?us-ascii?Q?pqxBE9bAnyA674g43fAx1CRl6gf18IS7wYRfY4hhNeuLt6fcr67FvE7l6+mV?=
 =?us-ascii?Q?Dy7qdBvBovy1tvRgUrbqdyohwBfRFvjYT1UQReiShZqjbWU3Sws+svcP9nw7?=
 =?us-ascii?Q?2di+W3kFJ6tF6stpjX3N+jHAep49bioz2PVvl975bZxFTzDccgMf6rAfDaaO?=
 =?us-ascii?Q?lLlvwONrlvcb5rW5ywxrCyk3EjFZNgcxFKDGcXIWZMuDFynGbpiAty7cI3ur?=
 =?us-ascii?Q?gAP5ZT37d6Iws5QI3y/woXePrJpfRnBfS7lbxhMBwUlcdVAlewQTIB4v+UQr?=
 =?us-ascii?Q?h5N0uW31dbWAC2GBL5mLhOCWRF4D9h7+8HVcmc2ojaD5eYM5XMXOL6JAnGUK?=
 =?us-ascii?Q?TBKR0geNBO3MX87ZVkPzj4NcongYH4be08dcuCjDcOicvfgCPGIMi6jy++La?=
 =?us-ascii?Q?Q5HsGW4uMPgFJTiRox1bXb7n0LSoMdCsahAA1d+ceNeepmMim+pmlnMXLRdI?=
 =?us-ascii?Q?O2uU2fW+dQckaDSutV05k6UE+5udtBbi76qMY+VCdOTpQgvl8jfuYLq69neJ?=
 =?us-ascii?Q?DHrx+JKNlQ6uCn2cDhWx00EUh1u/nQ1OQpvPGTnGt7vKilN6ijPcjRNTiJIJ?=
 =?us-ascii?Q?09MHESM1vOppyFjqZWjGSttVlrDAvInURLyAcRyXdqJ0hJKDuIef6wcl72mv?=
 =?us-ascii?Q?yMAeyWht8NqGtxfeS/VugOJ5/ijo3q6PGM3fufSVh9KfIKaskWbrTvyLa1BE?=
 =?us-ascii?Q?XgSeDJsbm4k/FrB29toU51obbJ3VWmWyfqJ2tRJzjm9xi61jyt7HNcu2UdVc?=
 =?us-ascii?Q?Ua52WX4Bfn50tx/XgzsmC0XGXBzCyAmzjbMTUgrA0T9jtRw2iw=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc08fbe-eacd-4cc7-4871-08d8e52814ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2021 07:25:58.4511 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2AjvjnkL6EX9wiB83DWE5PCATAMrwH1k9bOmOLxsEMmUb16/bNZtLyd3eq+l68OA2ZJhLayzh4KJzpJ8dQ1klw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4641
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210312_072604_846554_425327FB 
X-CRM114-Status: GOOD (  26.29  )
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

On 2021/03/12 15:29, Chaitanya Kulkarni wrote:
[...]
>>> +static inline u8 nvmet_zasl(unsigned int zone_append_sects)
>>> +{
>>> +	/*
>>> +	 * Zone Append Size Limit is the value experessed in the units
>>> +	 * of minimum memory page size (i.e. 12) and is reported power of 2.
>>> +	 */
>>> +	return ilog2((zone_append_sects << 9) >> NVMET_MPSMIN_SHIFT);
>> s/9/SECTOR_SHIFT
>>
>> And you could rewrite this as:
>>
>> return ilog2(zone_append_sects >> (NVMET_MPSMIN_SHIFT - SECTOR_SHIFT));
> 
> SECTOR_SHIFT patches are nacked, reason being it doesn't make code
> clear, how about following ?

Weird. I personally find it much nicer than a magic value "9"... But why not...

[...]
>>> +void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
>>> +{
>>> +	struct nvme_id_ns_zns *id_zns;
>>> +	u64 zsze;
>>> +	u16 status;
>>> +
>>> +	if (req->cmd->identify.csi != NVME_CSI_ZNS) {
>>> +		req->error_loc = offsetof(struct nvme_common_command, opcode);
>>> +		status = NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
>>> +		goto out;
>>> +	}
>>> +
>>> +	if (le32_to_cpu(req->cmd->identify.nsid) == NVME_NSID_ALL) {
>>> +		req->error_loc = offsetof(struct nvme_identify, nsid);
>>> +		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
>>> +		goto out;
>>> +	}
>>> +
>>> +	id_zns = kzalloc(sizeof(*id_zns), GFP_KERNEL);
>>> +	if (!id_zns) {
>>> +		status = NVME_SC_INTERNAL;
>>> +		goto out;
>>> +	}
>>> +
>>> +	status = nvmet_req_find_ns(req);
>>> +	if (status) {
>>> +		status = NVME_SC_INTERNAL;
>>> +		goto done;
>>> +	}
>>> +
>>> +	if (!bdev_is_zoned(req->ns->bdev)) {
>>> +		req->error_loc = offsetof(struct nvme_identify, nsid);
>>> +		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
>>> +		goto done;
>>> +	}
>>> +
>>> +	nvmet_ns_revalidate(req->ns);
>>> +	zsze = (bdev_zone_sectors(req->ns->bdev) << 9) >>
>>> +					req->ns->blksize_shift;
>> s/9/SECTOR_SHIFT
> 
> See my earlier reply to the same comment.

I do not agree but if that is the nvme code policy, sure.

>>> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)
>>> +{
>>> +	sector_t sect = nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);
>>> +	u32 bufsize = (le32_to_cpu(req->cmd->zmr.numd) + 1) << 2;
>>> +	struct nvmet_report_zone_data data = { .ns = req->ns };
>>> +	unsigned int nr_zones;
>>> +	int reported_zones;
>>> +	u16 status;
>>> +
>>> +	status = nvmet_bdev_zns_checks(req);
>>> +	if (status)
>>> +		goto out;
>>> +
>>> +	data.rz = __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY | __GFP_ZERO);
>>> +	if (!data.rz) {
>>> +		status = NVME_SC_INTERNAL;
>>> +		goto out;
>>> +	}
>>> +
>>> +	nr_zones = (bufsize - sizeof(struct nvme_zone_report)) /
>>> +			sizeof(struct nvme_zone_descriptor);
>>> +	if (!nr_zones) {
>>> +		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
>>> +		goto out_free_report_zones;
>>> +	}
>>> +
>>> +	reported_zones = blkdev_report_zones(req->ns->bdev, sect, nr_zones,
>>> +					     nvmet_bdev_report_zone_cb, &data);
>>> +	if (reported_zones < 0) {
>>> +		status = NVME_SC_INTERNAL;
>>> +		goto out_free_report_zones;
>>> +	}
>> There is a problem here: the code as is ignores the request reporting option
>> field which can lead to an invalid zone report being returned. I think you need
>> to modify nvmet_bdev_report_zone_cb() to look at the reporting option field
>> passed by the initiator and filter the zone report since blkdev_report_zones()
>> does not handle that argument.
> 
> The reporting options are set by the host statistically in
> nvme_ns_report_zones()
> arefrom:-  nvme_ns_report_zones()
>          c.zmr.zra = NVME_ZRA_ZONE_REPORT;
>          c.zmr.zrasf = NVME_ZRASF_ZONE_REPORT_ALL;
>          c.zmr.pr = NVME_REPORT_ZONE_PARTIAL;
> 
> All the above values are validated in the nvmet_bdev_zns_checks() helper
> called from nvmet_bdev_execute_zone_mgmt_recv() before we allocate the
> report zone buffer.
> 
> 1. c.zmr.zra indicates the action which Reports zone descriptor entries
>    through the Report Zones data structure.
> 
>    We validate this value is been set to NVME_ZRA_ZONE_REPORT in the
>    nvmet_bdev_zns_chceks(). We are calling report zone after checking
>    zone receive action it NVME_ZRA_ZONE_REPORT so not filtering is needed
>    in the nvmet_bdev_report_zone_cb().
> 
> 2. c.zmr.zrasf indicates the action specific field which is set to
>    NVME_ZRASF_ZONE_REPORT_ALL.
> 
>    We validate this value is been set to NVME_ZRASF_ZONE_REPORT_ALL in the
>    nvmet_bdev_zns_chceks(). Since host wants all the zones we don't need to
>    filter any zone states in the nvmet_bdev_report_zone_cb().
> 
> 3. c.zmr.pr is set to NVME_REPORT_ZONE_PARTIAL which value = 1 i.e value in
>    the Report Zone data structure Number of Zones field indicates the
> number of
>    fully transferred zone descriptors in the data buffer, which we set from
>    return value of the blkdev_report_zones() :-
>   
> 
>    reported_zones = blkdev_report_zones(req->ns->bdev, sect, nr_zones,
> 					     nvmet_bdev_report_zone_cb, &data);
> <snip>   data.rz->nr_zones = cpu_to_le64(reported_zones);
> 
>    So no filtering is needed in nvmet_bdev_report_zone_cb() for c.zmr.pr.
> 
> Can you please explain what filtering is missing in the current code ?
> 
> Maybe I'm looking into an old spec.

report zones command has the reporting options (ro) field (bits 15:08 of dword
13) where the user can specify the following values:

Value Description
0h List all zones.
1h List the zones in the ZSE:Empty state.
2h List the zones in the ZSIO:Implicitly Opened state.
3h List the zones in the ZSEO:Explicitly Opened state.
4h List the zones in the ZSC:Closed state.
5h List the zones in the ZSF:Full state.
6h List the zones in the ZSRO:Read Only state.
7h List the zones in the ZSO:Offline state.

to filter the zone report based on zone condition. blkdev_report_zones() will
always to a "list all zones", that is, ro == 0h.

But on the initiator side, if the client issue a report zones command through an
ioctl (passthrough/direct access not suing the block layer BLKREPORTZONES
ioctl), it may specify a different value for the ro field. Processing that
command using blkdev_report_zones() like you are doing here without any
additional filtering will give an incorrect report. Filtering based on the user
specified ro field needs to be added in nvmet_bdev_report_zone_cb().

The current code here is fine of the initiator/client side uses the block layer
and execute all report zones through blkdev_report_zones(). But things will
break if the client starts doing passthrough commands using nvme ioctl. No ?

>>> +
>>> +	data.rz->nr_zones = cpu_to_le64(reported_zones);
>>> +
>>> +	status = nvmet_copy_to_sgl(req, 0, data.rz, bufsize);
>>> +
>>> +out_free_report_zones:
>>> +	kvfree(data.rz);
>>> +out:
>>> +	nvmet_req_complete(req, status);
>>> +}
>>> +
>>> +void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req)
>>> +{
>>> +	sector_t sect = nvmet_lba_to_sect(req->ns, req->cmd->zms.slba);
>>> +	sector_t nr_sect = bdev_zone_sectors(req->ns->bdev);
>>> +	u16 status = NVME_SC_SUCCESS;
>>> +	u8 zsa = req->cmd->zms.zsa;
>>> +	enum req_opf op;
>>> +	int ret;
>>> +	const unsigned int zsa_to_op[] = {
>>> +		[NVME_ZONE_OPEN]	= REQ_OP_ZONE_OPEN,
>>> +		[NVME_ZONE_CLOSE]	= REQ_OP_ZONE_CLOSE,
>>> +		[NVME_ZONE_FINISH]	= REQ_OP_ZONE_FINISH,
>>> +		[NVME_ZONE_RESET]	= REQ_OP_ZONE_RESET,
>>> +	};
>>> +
>>> +	if (zsa > ARRAY_SIZE(zsa_to_op) || !zsa_to_op[zsa]) {
>> What is the point of the "!zsa_to_op[zsa]" here ? All the REQ_OP_ZONE_XXX are
>> non 0, always...
> 
> Well this is just making sure that we receive the right action since sparse
> array will return 0 for any other values than listed above having
> !zsa_to_op[zsa] check we can return an error.

But zsa is unsigned and you check it against the array size. So it can only be
within 0 and array size - 1. That is enough... I really do not see the point of
clutering the condition with something that is always true...

[...]
>>> +
>>> +	ret = blkdev_zone_mgmt(req->ns->bdev, op, sect, nr_sect, GFP_KERNEL);
>>> +	if (ret)
>>> +		status = NVME_SC_INTERNAL;
>>> +out:
>>> +	nvmet_req_complete(req, status);
>>> +}
>>> +
>>> +void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
>>> +{
>>> +	sector_t sect = nvmet_lba_to_sect(req->ns, req->cmd->rw.slba);
>>> +	u16 status = NVME_SC_SUCCESS;
>>> +	unsigned int total_len = 0;
>>> +	struct scatterlist *sg;
>>> +	int ret = 0, sg_cnt;
>>> +	struct bio *bio;
>>> +
>>> +	if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))
>>> +		return;
>> No nvmet_req_complete() call ? Is that done in nvmet_check_transfer_len() ?
> 
> Yes it does, you had the same comment on earlier version, it can be
> confusing
> that is why I proposed a helper for check transfer len and !req->sg_cnt
> check,
> but we don't want that helper.

Just add a comment saying that nvmet_check_transfer_len() calls
nvmet_req_complete(). That will help people like me with a short memory span :)

>>> +
>>> +	if (!req->sg_cnt) {
>>> +		nvmet_req_complete(req, 0);
>>> +		return;
>>> +	}
>>> +
>>> +	if (req->transfer_len <= NVMET_MAX_INLINE_DATA_LEN) {
>>> +		bio = &req->b.inline_bio;
>>> +		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
>>> +	} else {
>>> +		bio = bio_alloc(GFP_KERNEL, req->sg_cnt);
>>> +	}
>>> +
>>> +	bio_set_dev(bio, req->ns->bdev);
>>> +	bio->bi_iter.bi_sector = sect;
>>> +	bio->bi_opf = REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;
>>> +	if (req->cmd->rw.control & cpu_to_le16(NVME_RW_FUA))
>>> +		bio->bi_opf |= REQ_FUA;
>>> +
>>> +	for_each_sg(req->sg, sg, req->sg_cnt, sg_cnt) {
>>> +		struct page *p = sg_page(sg);
>>> +		unsigned int l = sg->length;
>>> +		unsigned int o = sg->offset;
>>> +
>>> +		ret = bio_add_zone_append_page(bio, p, l, o);
>>> +		if (ret != sg->length) {
>>> +			status = NVME_SC_INTERNAL;
>>> +			goto out_bio_put;
>>> +		}
>>> +
>>> +		total_len += sg->length;
>>> +	}
>>> +
>>> +	if (total_len != nvmet_rw_data_len(req)) {
>>> +		status = NVME_SC_INTERNAL | NVME_SC_DNR;
>>> +		goto out_bio_put;
>>> +	}
>>> +
>>> +	ret = submit_bio_wait(bio);
>> submit_bio_wait() ? Why blocking here ? That would be bad for performance. Is it
>> mandatory to block here ? The result handling could be done in the bio_end
>> callback no ?
> 
> I did initially, but zonefs uses sync I/O, I'm not sure about the btrfs,
> if it does
> please let me know I'll make it async.
> 
> If there is no async caller in the kernel for REQ_OP_ZONE_APPEND
> shouldwe make this async ?

This should not depend on what the user does, at all.
Yes, for now zonefs only uses zone append for sync write() calls. But I intend
to have zone append used for async writes too. And in btrfs, append writes are
used for all data IOs, sync or async. That is on the initiator side anyway. The
target side should not assume any special behavior of the initiator. So if there
is no technical reasons to prevent async append writes execution, I would rather
have all of them processed with async BIOs execution, similar to regular write BIOs.

-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
