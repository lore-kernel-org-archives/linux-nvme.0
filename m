Return-Path: <SRS0=uaVC=IP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676B3C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 21:29:05 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA26264F01
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 21:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA26264F01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZGElGzFfyQH30BJ19eGVufhsMqdPqjwKOETIdmPN6PE=; b=aWygNeMEBFOk9rPMBhxDuW9dN
	cgZ3lfd5emKpHEeTcIH888MlF2ZeB6XETHR/i3TfpiNLw5e6cbKprPtkwNHl3OjPgi1wZHd+X0oS1
	540LSiH0Uk9SBFcc0CnY2OSnwnBfLZ2ZuiTnKS3YDLimCZYrniYzJ9E7NUXzHsS+ZojEdZFV+FGbl
	AX60f5NaLfLtHNiYNoFz7r9QId83lK8GvCxKcEofJoMdXIpwBdsZ3N2SMmcI/3va4l4iRkcxSBapx
	bOQk9fv8S60r/IWSbCHGs84oORozo0GMjwDm7KQ4F/szP9nYwkoogZ4fAb4eiFGoArqGMW03W8oiA
	Zdn3OT8DQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMdid-003waf-De; Wed, 17 Mar 2021 21:28:43 +0000
Received: from userp2130.oracle.com ([156.151.31.86])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMdiX-003wZa-3c
 for linux-nvme@lists.infradead.org; Wed, 17 Mar 2021 21:28:40 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12HLOdeV116014;
 Wed, 17 Mar 2021 21:28:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=CF0UKegZuSmdGKLmaRGHe8R0FlVmzPONPYOSCJIus/8=;
 b=arRpdkZIB5iKtDOZovWaNHWj1X8YMvDW6anfzteBAgO1e2HD/LwByjlkFO3+XQBjHKye
 C4eAlAf6ywv0K2Ie1Yf13SuT0a/cwXB/L4z9VbzZlxdiC10TXRT/ecWdzOar6UY9lWJR
 mHimEhBCMT3EXpe26TNJDvatkCu0WaXdZzv5LiHbEybf7e+biNFY9dI85EqB3XpHAYlJ
 cfVJBIqVbP6GEBQnt/i3LhSOMdnjRGUH3wnzYgr/cZvzzd9D3rEd1lQMzTgABJtfUDAQ
 n1TCMp9di8eaNfpWGV95zRaerzXKwLD9Xnhn5AXtP+ckNV62LANOY0Hdx1JbINYrlpu9 jA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 37a4ekthhc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Mar 2021 21:28:32 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12HLOkYY014695;
 Wed, 17 Mar 2021 21:28:32 GMT
Received: from nam04-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam04lp2052.outbound.protection.outlook.com [104.47.44.52])
 by aserp3030.oracle.com with ESMTP id 3796yvbmnb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Mar 2021 21:28:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFZDkG7P+ng2BZrc6lOBMWsgb43Z0MxqhbSv/xP+bgDAbeZe8Ff0ANEXI/FziZXuQ8rri+lFr02T+Wla9RVZtBTRkponSIbmGHDH+y6SRbcfZvDWb1t2pGC2gUk/S77xC/A+ejyvLKpRNuwaHi0ArSK8yNMI9pPO3yf2RixKJ3HWdg/Z+m6VOy9ryHrXXWRIEEUq6l8arig7DqXflMh/oef5g/f22OvZ1zksmhZzU3kJ4h9Ftt27IrHYZMeaDmro5bNj8a4Eb+TMb5eO8yMxvD4O0V3WciEAP1LPyihkvXw4DuDruP+ADdKIcS3W163dv/VHNd214DaReDeyrNivFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CF0UKegZuSmdGKLmaRGHe8R0FlVmzPONPYOSCJIus/8=;
 b=EBh1+O6zk4po2ModzY1ofZt1HZJlycYO6kUwDZ17dehCdpB0XgLr1JoaG3baiBcGgV1lYWeBmL9wTm41zwdt4fYgHKnFpLe2CcZPnT+p1VnQ25LZd5pJoRXQ9Yanvij6jlqvgtUbMObf1GDjj4lVTz0g6BHb7VQzHwvjgkRF/ICdPHYpwAbGniNGK+yYCxJgFQcwFNxnjiTorbFe3nAEwux/HYOswi4gWG7B3JS6eUUEbLkynRuPdy8QeKttwVDbEihJWncN48wSth16bbgZ/xIHJOyoC3e2sT9dQSIOiEvvyHWZXx5dOkceMktVSYw8YLNN7npntQCN7EBMioKmYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CF0UKegZuSmdGKLmaRGHe8R0FlVmzPONPYOSCJIus/8=;
 b=gmD7mq2gnHP2NTCi4lGz+y6l/vaxLEs0aPrLgWkz1NJiHtbgrtbfX1LudcQN7JKlxhW95nkp/LlUuskri5ed0s3bu0MAcPDdPHHtw+5m3pdRPY1fhntlflS5A9XUVNynJNHaRhwe1548ITrAAAqwidsegHWUMpyAvqIHfFbBOPA=
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SA2PR10MB4556.namprd10.prod.outlook.com (2603:10b6:806:119::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Wed, 17 Mar
 2021 21:28:30 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::20c7:193:d737:7ab1]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::20c7:193:d737:7ab1%4]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 21:28:30 +0000
From: Himanshu Madhani <himanshu.madhani@oracle.com>
To: "amit.engel@dell.com" <amit.engel@dell.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "jsmart2021@gmail.com" <jsmart2021@gmail.com>
Subject: Re: [PATCH] nvmet-fc: simplify nvmet_fc_alloc_hostport
Thread-Topic: [PATCH] nvmet-fc: simplify nvmet_fc_alloc_hostport
Thread-Index: AQHXGjCbopw47+MAMk6u5hNmxS/ay6qItJEA
Date: Wed, 17 Mar 2021 21:28:30 +0000
Message-ID: <EC219DA2-0CCB-42EE-95B6-CEBE9D332551@oracle.com>
References: <20210316064345.25713-1-amit.engel@dell.com>
In-Reply-To: <20210316064345.25713-1-amit.engel@dell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: dell.com; dkim=none (message not signed)
 header.d=none;dell.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [70.114.128.235]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c81579cf-8921-400d-3bd8-08d8e98b9c33
x-ms-traffictypediagnostic: SA2PR10MB4556:
x-microsoft-antispam-prvs: <SA2PR10MB45562AAE4F40CF69D9C9507FE66A9@SA2PR10MB4556.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cC74QyOdygajZ53xZN41HkEgFc4lFCxdRrv1eoKxKHCUztRYggCh21nGnoY+rGODfTK/E+cxSkgvOR1MrGDUl/Vg3ZwlAzdt8Tligssh9ekiXgGWEkJ99gwqwuDU34z+ofWsCATe6O74C/oCNgeNtD0QtFT+QIkBuxH0XHhKLV8Hrb8sDS3Cu3Vqw479rAy/B2qgUB0tkdc+L3R1wOkXlK1xMskwDhFlPl4qhqJUdFAZXlamoRtswVmG7D7pULOrv71dBaJShJcoSFqQ3tPFY3Jr7IJehfjXOA4p9OAikHqAU2j1kxZFzhaV1dOw15hJ9ysqx31igSn/UC+7wRbm6wSH1/XAbhDVYqvBv4k+c+eHE7T0sc7qgQ0vhIVTBLgqkRmRoZyOQ6TVw/oXw084FGIbi6dnJd7swubsKUt8bWh+ch72NUthvR/LvviQGvQHTDUPnTkxMQS+dy7/4i+slxj46XFNIx88RnNS2VY/Q6DCdPAC0179uStqix5ae4vW1nYXXpJtTok2otRZPqx+hBic6bD9Fx3nEO+K3ONKxph0jUqpLX+wlKa0iW9xRH+NwqxO/lLbAYRZNyqxp7SfBwoWLZ7G48lD1KrrHdBuZ8Q5QrMDeFlwreNN+CFgCXGnv7Nu87asKYUstQJjOvh03/0azhx8YYps6c/bT3zjLUvvYZGBJ1H96o5eQGx2CU1SSwdIucHeFPrTJ+oq0Dtouw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR10MB2943.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(346002)(396003)(136003)(366004)(39860400002)(6486002)(6916009)(8676002)(66446008)(54906003)(71200400001)(36756003)(44832011)(186003)(66476007)(8936002)(4326008)(64756008)(316002)(66556008)(478600001)(5660300002)(966005)(76116006)(2616005)(26005)(66946007)(33656002)(83380400001)(86362001)(53546011)(2906002)(6506007)(6512007)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?CP6MTt6nobcH8+DMO+sQoLAqo0LA9wi6m+PWl9oMnni90jZhT5QR6UMUJk/k?=
 =?us-ascii?Q?c7CJqQcEepWOr+DhN+fVXZctiYt2OoPXdfSyXAbEP/qR3nVKsOocIvNAYAss?=
 =?us-ascii?Q?/7I6yabNiobLyEnV038ZnSFwr3HnHiQcT521pe3BPX27jXYmpLaFWLgGB0AG?=
 =?us-ascii?Q?x3cHIXy6bQcCwJ+en4a1sOPNL4hf5BtV3MwIPRqjhI6LhjTRo3Cx5+fjALFE?=
 =?us-ascii?Q?9inv/eE5KjCO5bH3bJ0avUYXarnnDdYJHgN+CDOkplzjO/VBExSwK1C0yI1c?=
 =?us-ascii?Q?By/U6LMYu48SPHAOLk32VHjGCbb4BBcdtbXagcT4XxwVBb0+ylF4gfzmSQCp?=
 =?us-ascii?Q?Z9sfkVX97GexRiU9EcIalUYF/1mlFrAg1nJnaFz74m78FPYbqfIaZrek5bO7?=
 =?us-ascii?Q?Q0hdP7lNgfyDJzgtxKCGRco4xQF6ICyKyy7McqSq7kHps28HmwgpaLyzaUOP?=
 =?us-ascii?Q?rgOp7d5HcLubWSAkLQcnwD6K64RCqFuEW7qc4HjSJ0GCB1ABluSLvFagW1TV?=
 =?us-ascii?Q?jlmY9JG1GP1uj3nxie1ZpjYLc4chWnUBXl4xZLBr3pbfw+Xbm+KEK+qYEtsO?=
 =?us-ascii?Q?UjbVK1dFEu3KwmzSo4fSvp5HJk18pxjdfquHj43ShfL4Ye1gj/hGkSmuJwsw?=
 =?us-ascii?Q?gBILqyBG8ovmeGZNLkI5icpzY9KqI6OAOVgBqvcZgiVEDuMC+TO3owEi2nxO?=
 =?us-ascii?Q?dIwPVwo73Al8S2Ev/JVZ2VPhib3e5rn2/1lV6AQuNMdhetOXGKjrAPpjFrhm?=
 =?us-ascii?Q?T968lY59yBE88keAfodRj6laigaJYcd/rPSHLAS4Qyyk/lNtzySVhlZH5syH?=
 =?us-ascii?Q?xhS+XXa70euXvHsrYT5ayVkK/2pgIlQVJ7suXgpX840C66i53uhG63tQUdwj?=
 =?us-ascii?Q?pgrHdggaIgM6alkXzavV/2BTEo/e1qcl494hn4Qrk3hOtCZVx+VCi4ND4HtU?=
 =?us-ascii?Q?aEFnKA+07p5nrCJcBRE+YU+sTYw+oxCJtZVeO0JtpE3IGZtiMhncjUmODbKd?=
 =?us-ascii?Q?p54JFOLv8Qi4CJywmlBnAyVge5D07F8dTmojmf30SpuOp+XIBUgCI9SevO8s?=
 =?us-ascii?Q?lNegmtyxZMBOpTpsKBMb3QD+ukFM6CFfQ0FMGcag4HlA5u1nYkC/AtfEjpcV?=
 =?us-ascii?Q?VL+NlIw+o4mO1O6lhN88idtliJvIGlRGK1aSEHfdO1WoS45YxQKpld6uXwtU?=
 =?us-ascii?Q?CUsD/2ujv2gmyZ00FnV5Q85wDshQuPi8WlR3QOmt5VQDTYSCG3Y2j4OQ7fYl?=
 =?us-ascii?Q?LwbySJoxbHkoXkjJ9sTgpJRzixI0Dac1qHG95HyhyEhYTr0eerjloKr7LaUR?=
 =?us-ascii?Q?rkxNAgFkRHtLHHeC5FkmjGDa6yJJv6fHrZ0j8Rols4udgw=3D=3D?=
x-ms-exchange-transport-forked: True
Content-ID: <241307178DEF7149A4723C36EDC4839D@namprd10.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c81579cf-8921-400d-3bd8-08d8e98b9c33
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2021 21:28:30.2384 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DooczaCHkCwYPHD+FqOEbClAO2FzmuDahNPzPhb3Li6s7DsIa2yV5VQzdEEIK/UyCtjLAj/vcln5mqECny1v/UhMx4VchB3AVAaTH3BmwjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4556
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9926
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103170151
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9926
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103170151
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210317_212838_770511_636778BA 
X-CRM114-Status: GOOD (  31.12  )
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



> On Mar 16, 2021, at 1:43 AM, amit.engel@dell.com wrote:
> 
> From: Amit Engel <amit.engel@dell.com>
> 
> Once a host is already created,
> avoid allocate additional hostports that will be thrown away.
> add an helper function to handle host search.
> 
> Signed-off-by: Amit Engel <amit.engel@dell.com>
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> ---
> drivers/nvme/target/fc.c | 76 ++++++++++++++++++++++++----------------
> 1 file changed, 45 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index d375745fc4ed..4762f298e579 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -1020,61 +1020,75 @@ nvmet_fc_free_hostport(struct nvmet_fc_hostport *hostport)
> 	nvmet_fc_hostport_put(hostport);
> }
> 
> +static struct nvmet_fc_hostport *
> +nvmet_fc_match_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
> +{
> +	struct nvmet_fc_hostport *host;
> +
> +	/* tgtport->lock is held by caller */
> +
> +	list_for_each_entry(host, &tgtport->host_list, host_list) {
> +		if (host->hosthandle == hosthandle && !host->invalid) {
> +			if (nvmet_fc_hostport_get(host))
> +				return (host);
> +		}
> +	}
> +
> +	return (NULL);
> +}
> +
> static struct nvmet_fc_hostport *
> nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
> {
> -	struct nvmet_fc_hostport *newhost, *host, *match = NULL;
> +	struct nvmet_fc_hostport *newhost, *match = NULL;
> 	unsigned long flags;
> 
> 	/* if LLDD not implemented, leave as NULL */
> 	if (!hosthandle)
> 		return NULL;
> 
> -	/* take reference for what will be the newly allocated hostport */
> +	/* take reference for what will be the newly allocated hostport if
> +	 * we end up using a new allocation
> +	 */

Small nit.. Please fix the comment formatting for multi-line 

> 	if (!nvmet_fc_tgtport_get(tgtport))
> 		return ERR_PTR(-EINVAL);
> 
> +	spin_lock_irqsave(&tgtport->lock, flags);
> +	match = nvmet_fc_match_hostport(tgtport, hosthandle);
> +	spin_unlock_irqrestore(&tgtport->lock, flags);
> +
> +	if (match) {
> +		/* no new allocation - release reference */
> +		nvmet_fc_tgtport_put(tgtport);
> +		return match;
> +	}
> +
> 	newhost = kzalloc(sizeof(*newhost), GFP_KERNEL);
> 	if (!newhost) {
> -		spin_lock_irqsave(&tgtport->lock, flags);
> -		list_for_each_entry(host, &tgtport->host_list, host_list) {
> -			if (host->hosthandle == hosthandle && !host->invalid) {
> -				if (nvmet_fc_hostport_get(host)) {
> -					match = host;
> -					break;
> -				}
> -			}
> -		}
> -		spin_unlock_irqrestore(&tgtport->lock, flags);
> -		/* no allocation - release reference */
> +		/* no new allocation - release reference */
> 		nvmet_fc_tgtport_put(tgtport);
> -		return (match) ? match : ERR_PTR(-ENOMEM);
> +		return ERR_PTR(-ENOMEM);
> 	}
> 
> -	newhost->tgtport = tgtport;
> -	newhost->hosthandle = hosthandle;
> -	INIT_LIST_HEAD(&newhost->host_list);
> -	kref_init(&newhost->ref);
> -
> 	spin_lock_irqsave(&tgtport->lock, flags);
> -	list_for_each_entry(host, &tgtport->host_list, host_list) {
> -		if (host->hosthandle == hosthandle && !host->invalid) {
> -			if (nvmet_fc_hostport_get(host)) {
> -				match = host;
> -				break;
> -			}
> -		}
> -	}
> +	match = nvmet_fc_match_hostport(tgtport, hosthandle);
> 	if (match) {
> +		/* new allocation not needed */
> 		kfree(newhost);
> -		newhost = NULL;
> -		/* releasing allocation - release reference */
> +		newhost = match;
> +		/* no new allocation - release reference */
> 		nvmet_fc_tgtport_put(tgtport);
> -	} else
> +	} else {
> +		newhost->tgtport = tgtport;
> +		newhost->hosthandle = hosthandle;
> +		INIT_LIST_HEAD(&newhost->host_list);
> +		kref_init(&newhost->ref);
> +
> 		list_add_tail(&newhost->host_list, &tgtport->host_list);
> +	}
> 	spin_unlock_irqrestore(&tgtport->lock, flags);
> 
> -	return (match) ? match : newhost;
> +	return newhost;
> }
> 
> static void
> -- 
> 2.18.2
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

code looks good.

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--
Himanshu Madhani	 Oracle Linux Engineering


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
