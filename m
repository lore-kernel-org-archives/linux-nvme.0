Return-Path: <SRS0=kA4j=JG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75E8C433ED
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 07:10:25 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CFA961106
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 07:10:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CFA961106
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=gJvU3bOthXqU7RIoJuP24LLtJ90Rs9xOkx5w3DOCNu0=; b=asXIgbdRenQB+Cp9chS/nYpCE
	abBJ9Yf/vNO6cQ1NbBUpP/9D6XsD9/y3Dm/7z1qCbwb9yl8uiqp5K4MCwBx6+qQZLFmTRuBSzn6Z0
	x7fJHY58Uyc1mQ6hShy70unDHL9kdUOzboOVEfAbeU+8da91qZbU2ADDZBjTQFaK61DtGnHyKEWmB
	kkzr0g4gGJcGzcCCWwHr4rCa+qzJQDIxm3ASL1DngLdXV2gjXqvsRtgh+e4jRI1fDIdmHILKItEmn
	Y5lhW4hCAe2pF0QPb0Bqdq82sPEd35Ofct15s69GSlWhVgm+XhLrXc7FeRDAEqrlCXLaSAMSuBvr8
	G8o7uRVUg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUlHO-00AO2h-K8; Fri, 09 Apr 2021 07:10:10 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUlGo-00ANxT-QO
 for linux-nvme@lists.infradead.org; Fri, 09 Apr 2021 07:09:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1617952174; x=1649488174;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=/mlMBy31uf2GdoxLqze/QGx8Ff7LWIlhcf/vDJsh/vI=;
 b=HQWK5SC3zVrkfIGHA07XJ+93EroikWX/8V8vpi4TkyCIcycyZ6SkQP9Y
 ODXiYjuU4tkfzctOO1Ghq7jmggHVxrprk4+Rnh0phU5G6OKcbLTA12xq0
 TGtdxymApFxJmvjCzrGClmbyKKc4H3yStgZZGefZcIEStKOMkWSVOEnau
 UKj50QfOaOsyV6MMLy6pnIj96I9YacwhUPd59c+7c3lEo3sympYqhXYv/
 SFkrkcCX0MfhZoNM57fOexP0IDRsvegm1vc1tmvyQlS+jdNiYnvaL9Ekl
 uHJAx48RWG+NHLFji4C7UVAeVe5ZK68NsxVpHSfGI7K8+vM5yZk/m9J3D g==;
IronPort-SDR: rOsYdYOgRooqKT+drUCsrO7LWvmEtBE8qxw42gtV35/3eDed8TaDoVCp3yLlO30gdUJXJ9bWAH
 EvW2K2wfmgYtFIUOB5J4mc6IDywCgumLHAuhYrAdecOBDfLQ4eEOAcI7ItwTm2BuHoRjdWwV1I
 lF8vWYX55U7Ewvvx0f7BS6cNnIeID91ZZj6P13fjTBiHw3AcDKcOrPaW/bAINp53Yt9gXoMXnc
 +3vfDcrAL93aedLntZTVlwPeqYLHoSFmVTVcUXktLi4KuY7Mk064z9F1yXi7tfF9RCC55RhRdj
 zu8=
X-IronPort-AV: E=Sophos;i="5.82,208,1613404800"; d="scan'208";a="275152961"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
 by ob1.hgst.iphmx.com with ESMTP; 09 Apr 2021 15:09:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2JolnE4EcgQGfR/y8T15f89bcvWriVnZx9U+VBysSMZltYxMAg41vPRbJ/YNZXI1Q/TrXUI2KNJEyW7f3WJvFy2NqjUW51bcPRzxyYxRcsd/CID0tLQGmVm+b2jKLmgFxBHIhFAh76S8ZT1Pf9mE440H4OJHBLUut5nUqZi2mhjIvJEUzMayHAgBcUJPnKgD9FIcoymssHUweUlv95u7UC8WWnoWIKHGQ0CGEPoaZIu6OosHlh/2yNB9hVXrwqybXA2OBEFPLYMmIJ9IwWI1Tn0pqnTtDkJMilZnVIFBE+ljRDZTzGROWJJbbGG6uffwWhQuZKOJAxVF5F/lRDuSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1qfVRR2E8iXD3VAg07r8794FU64c9ShrLVQToLwn2M=;
 b=NEEFS6f/StaOBiuUrQ4kfF7UKh99kABM2OYvIlxHeVkrhdaj8M85+tC7DwOLxK3EeQlOXnApNx9GdoCuClrA/5wdWqn8rMif5W+Sky7WXcV616aNxdY2NnoZxZ+p6GFPjSikD5I2yFHiLqNpdCOolKTJtac9S7cM0xHW4tK0T8wVLTiCNKd8Qph9mg6Xs6x315NkX2TNXp+KIR9L2PDY4fc5g90EDN2rsYU5M1H38MFdco/Yn+9/y1P7c2dq7AUZsUgCdpP4qgt0AeQuKTtyPcTAMesL0r+MKJlLAaY7m17XQ7g0+LskKGl2zCo4B9Vi1LTgOdn8PES6sUopBTyINg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1qfVRR2E8iXD3VAg07r8794FU64c9ShrLVQToLwn2M=;
 b=e8BPCwkkKV00nEtZsuBxqJnvHeBjrgFxA0kZPKoNsDu+IY1PPIMddF6VzAhY1gwP49VXl7BRGjHXM+YDEsSJu28l9vn6mJ0ktEsFgsHFxeRPaEps23/qoIN2o/85MZpaOROaevteiOukXR8y87ocXDSpbHIrtdABX+XitWQISYw=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5685.namprd04.prod.outlook.com (2603:10b6:a03:107::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Fri, 9 Apr
 2021 07:09:12 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4020.018; Fri, 9 Apr 2021
 07:09:12 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Damien
 Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH V13 2/4] nvmet: add ZBD over ZNS backend support
Thread-Topic: [PATCH V13 2/4] nvmet: add ZBD over ZNS backend support
Thread-Index: AQHXLAw04l3W0N5us06JCpRfHcvipQ==
Date: Fri, 9 Apr 2021 07:09:12 +0000
Message-ID: <BYAPR04MB496511D1B547762FB9ACABFB86739@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210408001427.20501-1-chaitanya.kulkarni@wdc.com>
 <20210408001427.20501-3-chaitanya.kulkarni@wdc.com>
 <20210408072337.GB24502@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 902dcc06-d0f7-46ab-ce18-08d8fb2660eb
x-ms-traffictypediagnostic: BYAPR04MB5685:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB5685B78037D71AB38BBB249786739@BYAPR04MB5685.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6TE0OBlRe3hBYnrhzIIFVH/0DaAYZYEm46UyYtnHmiBVjdZSVIm5dkQsCz1dFiNI7dUVcHrav/XBsSY4kNMMQm+YHLnVktg/RT7bDusX0ot3+Qhoc5crd8aUfB69QOBaBDDqGjfOs+lAVthKCWtOjUhBpz0jDGs+C8TsaWa6kBz00+bzncjcUOYvFXkMdgb1McXX15vva114KYJJfpRt3OSxuoDsoX00/rGs0zmSA7Xnyb5x5GuQQgy83WTaHDazvHrgCSK/IsY7oHgqZbTLowq9yQWZM8FtDmD5AwsIhekN8dj+V5GFMc4lZBZFelkpwuBOu1NMxjT5ZSAQU6qHuKUSIZ/EM6SI2MQklU9QZPIAZLKgvIcNFONh2R+BFub9NyoZdmNGumg9JFG8JbhDFdUkhKcF/f+fL/x8+CsbkOzCwQMF3n/N51xtbaMV/n8kVIErgqaisjVdn74DLglUwE3HRTv/np4EqrRBMBcc01rEsAY/GkMHNYeVz4wYO8WE6qIUkOoC7yt0ZPfZe3NZTiD4ncItSmPOapBOHvjh60jiGFI0tkPMtm1gkReVmg4auzGqObx/+WLfdNAmoxfXFYkSK9N8qZ9AwyOvAIazzNzrPnNVRQfVdYn3N+53JSPL2ATZGtXGaVSxwtoqV413/FMILW6P4X3LhjDjJsUPefU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(366004)(136003)(396003)(376002)(5660300002)(9686003)(83380400001)(66476007)(66556008)(6506007)(66446008)(52536014)(38100700001)(66946007)(33656002)(64756008)(71200400001)(54906003)(6916009)(55016002)(76116006)(8936002)(53546011)(7696005)(316002)(478600001)(186003)(8676002)(4326008)(2906002)(86362001)(26005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?/YO26/BpjdOAYdh3aup/xQoe7qrjXy80jgsOSSloDhCMku1N+9icjE9AKW7M?=
 =?us-ascii?Q?PIgrQXlgg6yjOX/U8oox7YYlWnb0MgZ6nmejN2S77H/hG/O8kQBQXfVMw3Ny?=
 =?us-ascii?Q?XwZDtAKHWJuGCksACtr2M7hGZ8bE0U92BJWfk8SMYvFIIy0CdPtHDJgZG/D0?=
 =?us-ascii?Q?VaqNdLB0877k/nbc3Usu/wCD1ZgpAAAQ3rxCbMFPoXExXxWFgEGxJiS1Wg+q?=
 =?us-ascii?Q?+b772WphPr/fGhcNox+1u86ReqocYjsF+M2VyyfGp6x9iIpSkbzrmWj1ENtV?=
 =?us-ascii?Q?m5y5b5mCt6GHhotAuYw5JeNtyQGn7o0SQP3I7fDYN2Rz58EA8JMB4PCPft4y?=
 =?us-ascii?Q?7eUGg1blNUgmSe/ZFnp0cnoPr2liuKUbUH4pUnDNiC/Sr3VX6qyAvR0Bh+B2?=
 =?us-ascii?Q?pPSnwXe4pTxaFFKzJx3nUKrogthfc+EYOglN8FrtgNmRwA0mATfeBDFaJJSw?=
 =?us-ascii?Q?aZ8VO8BbWnpnJM67gsM1WQen7+P8/YwPpysUe209oBo1KQ9swn+HRE+nbv03?=
 =?us-ascii?Q?Q7fvf4qxsHuxNeB13cFe/qj2coWhT8px18pE298JZBDFUc8hYmo1Dl8TBmr/?=
 =?us-ascii?Q?/ZL0zepCbMqMGrKGOImU9M23bEx8RInp0of5Ewlg0Jd2jWa4PV/AfqJNE/9D?=
 =?us-ascii?Q?k4tU1FqUPhX97lN0F/USyW9bAf5Mpa+FAp5q0mSP+C6ifWCb0f+NdZ5GGNgs?=
 =?us-ascii?Q?E3wyk2wP1MGDVkbUINzMR2JS1Adc8D5jeVuVyJX4Jgf0aAvnkqJ3zF1FXn5X?=
 =?us-ascii?Q?kRcveTrOrrfA1kq2l52nmnogUu6NtuoCmQCFa5TSo223hmxAaRZ5WQoDYdn6?=
 =?us-ascii?Q?fglZlLltiTDrZmmumfUh05dnvs10Hm9I+/j6s9HM2chUVLDu05TYfEkTyKvH?=
 =?us-ascii?Q?AUxhWPoJj6dyUd10OyE0L2pwku5zQlGlFrAuwIJGvG1EfJ5RsRIpDWCdsIlO?=
 =?us-ascii?Q?B53lLDm3cXzbtsagHFit0DFz/gJy27EJ9j/NcwA+Zcv0DgX9GKC1Oy3K1RQj?=
 =?us-ascii?Q?0KA7E9l402MIuHBnLyrIRcuiE/vAAFNiQxDoPYZ6fAuhdCrXGKAX7yWbUPCI?=
 =?us-ascii?Q?EaqwAceMNEvjOK0k1dtZV0kkSKu7ZEteU3Pc1IwvBE4vVowMVeURFOWhuH/g?=
 =?us-ascii?Q?32QboKtYWnmj3LgOdIvuS9ZAJN9xrZrsit/tLExgaLKO2GGfc6n5aFi3Mh6c?=
 =?us-ascii?Q?Z6UeQ/kVrXxsAztoKCtw5thJ4kICeXkeUxPZvl26WAbguOZO0f7kjw0GNLjd?=
 =?us-ascii?Q?/OWqaOP6CtddLEp3gQXnH7JZlla/JsQyOiwLdm1r4eD2HbRxY2xEvX9dxzjS?=
 =?us-ascii?Q?jSLPfklEge3JtD9+E0/0Ien52dKT8USYyCUnQaVPfuLMaQ=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 902dcc06-d0f7-46ab-ce18-08d8fb2660eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2021 07:09:12.5101 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9TwKnm2B2qtG0cjQiUZOu378rp4LqC8B6QwixF2sOYN4rPFbWntRzLx30wc8XqxSNbP7jT5LG2g3dwrRdrNxJVLOkhjzPNbqKPRA7LX10Jc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5685
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210409_080937_950055_D581E7AE 
X-CRM114-Status: GOOD (  14.98  )
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

On 4/8/21 00:24, Christoph Hellwig wrote:
>> @@ -448,6 +456,15 @@ u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
>>  	case nvme_cmd_write_zeroes:
>>  		req->execute = nvmet_bdev_execute_write_zeroes;
>>  		return 0;
>> +	case nvme_cmd_zone_append:
>> +		req->execute = nvmet_bdev_execute_zone_append;
>> +		return 0;
>> +	case nvme_cmd_zone_mgmt_recv:
>> +		req->execute = nvmet_bdev_execute_zone_mgmt_recv;
>> +		return 0;
>> +	case nvme_cmd_zone_mgmt_send:
>> +		req->execute = nvmet_bdev_execute_zone_mgmt_send;
> I think we need a separate _parse for just ZNS.  That way we can
> do the ns.csi and IS_ENABLED check in one single place, and we
> also don't need stubs for any of these functions as they are all
> under the IS_ENABLED check and thus the compiler will never generate
> a call to them for !CONFIG_BLK_DEV_ZONED.
>

Do you prefer something like this ? (partially tested with and without
CONFIG_BLK_DEV_ZONED) :-

# git diff
diff --git a/drivers/nvme/target/admin-cmd.c
b/drivers/nvme/target/admin-cmd.c
index fc5f64a38661..da6d5225f25a 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -685,6 +685,14 @@ static void nvmet_execute_identify(struct nvmet_req
*req)
        if (!nvmet_check_transfer_len(req, NVME_IDENTIFY_DATA_SIZE))
                return;
 
+       switch (req->cmd->identify.csi) {
+       case NVME_CSI_NVM:
+       case NVME_CSI_ZNS:
+               break;
+       default:
+               goto out;
+       }
+
        switch (req->cmd->identify.cns) {
        case NVME_ID_CNS_NS:
                return nvmet_execute_identify_ns(req);
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index d33ba4c3c3f4..a0bdd39de23b 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -892,7 +892,16 @@ static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
        if (req->ns->file)
                return nvmet_file_parse_io_cmd(req);
 
-       return nvmet_bdev_parse_io_cmd(req);
+       switch (req->ns->csi) {
+       case NVME_CSI_NVM:
+               return nvmet_bdev_parse_io_cmd(req);
+       case NVME_CSI_ZNS:
+               if (IS_ENABLED(CONFIG_BLK_DEV_ZONED))
+                       return nvmet_bdev_zns_parse_io_cmd(req);
+               /* fallthrough */
+       default:
+               return NVME_SC_INVALID_IO_CMD_SET;
+       }
 }
 
 bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 8333701e4154..fcd01e303e19 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -404,6 +404,7 @@ void nvmet_stop_keep_alive_timer(struct nvmet_ctrl
*ctrl);
 u16 nvmet_parse_connect_cmd(struct nvmet_req *req);
 void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns
*id);
 u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req);
+u16 nvmet_bdev_zns_parse_io_cmd(struct nvmet_req *req);
 u16 nvmet_file_parse_io_cmd(struct nvmet_req *req);
 u16 nvmet_parse_admin_cmd(struct nvmet_req *req);
 u16 nvmet_parse_discovery_cmd(struct nvmet_req *req);
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index b62925eb49ab..c65ac53d9b0b 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -445,3 +445,22 @@ void nvmet_bdev_execute_zone_append(struct
nvmet_req *req)
                bio_put(bio);
        nvmet_req_complete(req, ret < 0 ? NVME_SC_INTERNAL : status);
 }
+
+u16 nvmet_bdev_zns_parse_io_cmd(struct nvmet_req *req)
+{
+       struct nvme_command *cmd = req->cmd;
+
+       switch (cmd->common.opcode) {
+       case nvme_cmd_zone_append:
+               req->execute = nvmet_bdev_execute_zone_append;
+               return 0;
+       case nvme_cmd_zone_mgmt_recv:
+               req->execute = nvmet_bdev_execute_zone_mgmt_recv;
+               return 0;
+       case nvme_cmd_zone_mgmt_send:
+               req->execute = nvmet_bdev_execute_zone_mgmt_send;
+               return 0;
+       default:
+               return nvmet_bdev_parse_io_cmd(req);
+       }
+}
roo

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
