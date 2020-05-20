Return-Path: <SRS0=LBLG=7C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A59C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 08:04:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC73820708
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 08:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V/Ku6+dl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mEuCdEXo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="OqPZiMKT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC73820708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=q1FEFQF6E6T2gNmCI5uVZa6iJbTT+QiMqSORp4Ov3/8=; b=V/Ku6+dlXKqDWO
	SEuWk4O0Z/5KpX4m6BUmIt64/A+r18441Xs0LKJoS1LhwGsW/Ur8jRXuJCtnqojqgBCtTdA5L/vLy
	XETUPV5RZkDh7q1ZimgO9Zl6YbL7QJ3cAzcum7VazU3y1o50/9WfVzsHSz7JhJMQGPAvfxmtX/Ypt
	xPwKsTnAwd29dwA21H3CO1pWGtm1uVZiQCv1/Fbrcv4cdjQEK1JqaWrNj1gdTJPMR2nb+JhANh3RT
	EIcXfYTiiBn4ZC239b+5p4rXI+qwIyhskmYOtrMZ2LGSeHIxtS+ZFzwsU8oug1UMkj9IkDKYklXrf
	2oObfbsISAAEA5vJ0c0w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jbJiE-0007pM-GT; Wed, 20 May 2020 08:04:26 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbJiA-0007lo-BG
 for linux-nvme@lists.infradead.org; Wed, 20 May 2020 08:04:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1589961862; x=1621497862;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=zumQjx0DUSFeEoMbqzfIQOZcUy/Yi5iSQSEmMcbsZEk=;
 b=mEuCdEXoJ1pq97+Xy3aCfmSO4oGm5WW1wSy6lOTysxMvhV375x/RlEfx
 RBJbhBdmFmyCp8vk6mLRqH7H1D1DQemYlv92rzTsmye+gpzhco9hXxhLl
 i6jvr1O1p+GwBVjk1h80q04sZIBaDaXlgg+W89Yyza8Vt1pcx+I+JzpTZ
 nENIJPWV/zXHMblGw3GsgikoUGy7JkcVcg27VO9N/KB2QXAwwZbMoEv1q
 41ASkMR2irPhN5riQqCd0QA6dg3lmfc19CpBdhclqjTEynAvAu/3deCev
 FYgAiKLT4HYGjgXf3gGhl0RgGwyqWbmu0lcUIFRN5tcxo2EpO4HED/PXT g==;
IronPort-SDR: obI0PWpeewA3XH7YA6S2805ZkM8YyuJLU4svGmLbqXb9nduQvWbGqpQhVijKZ2c9NbWfmwQWBc
 kgFtt3Mu62d6Ni+c0ehlT8tVZcDVN5vBHR+3TxBoCzB1pUPFagWpFpf1zXsuH9KMgcDve2w3pC
 48NtLy/Ii/1/fkn5+KdzdsMQaqcOohS1ptdBaxhVdhiUZtz50ZwWEYfVtxZ98EkCxUJHEfx9F4
 Vmt+nG7uCITo1BpGLWj8+TtEnzoiwkWCZOCcnMDzE8j8ayIDLFS4S3HuS8O7bQg+ovlp5eN4k4
 7vA=
X-IronPort-AV: E=Sophos;i="5.73,413,1583164800"; d="scan'208";a="247100595"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
 by ob1.hgst.iphmx.com with ESMTP; 20 May 2020 16:04:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cecjJeh79NkNhN5IhKUHojxRxWNZCkxaztluESUu/BnK51yXOMwVBWUcWAoLN+y8vAcMpW37wGRsZdWn3QGBFv6vb3MQ+bibufmZcTI/vW84eq0QimS3NzNtkJdp/DF6FMWtVD79/NBxho3TqtAmaiIEuOHXv/Oy9EPr+W5fGW1oyf0IsE8OQ5RBqrWkePT5KCpnAEijOuCfzKuCQ4H5nuOCoAJpAtQw5JhMVElJ6THRHgiulzH3ZMGtoIc7mhI1Zc4bbyUb9V3PKUonqaqVgrOZmFF74n57A+3Eyq71jHkRKwZZfL4Elqfij10eBlAzmWLfg77I9mhyqt7KIYOIIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCN5l1F8SkI6YA/VBoNQUAKISK097/LEUhddRY27pJw=;
 b=hiiG5bJ5ekEKPKGl/jPB9M1Kqq1mF3o2HIdR4pI6dVyCxjx4dBSlo3pNS0ooHgr9+HfIpUlcJXrElo2RWypuJeVp9glkBGLBX565y8BNAFLsramIRFq2xhS/aQ5+FOJuZI3nSNMuGumswejffOkKz8qTXZg5NzdA+/LiwSQUuxpJmvrlG46zb4/cHqedYI3BCuEOWAGQSmwOjTqDk4xHSWizgcKSokksAXuTOl844Dl5Fbo4NIvnYtTVgamr2bytI7EHMOftHGm2wEf+MDGgkFL5YweE19RXahGZXtvCqh8e5UXpERjrxwEG2nj1fQ/0Y7RAES0BRScV4ZrB8AulOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCN5l1F8SkI6YA/VBoNQUAKISK097/LEUhddRY27pJw=;
 b=OqPZiMKTjf7F8YpjmJpVrxsAaDMBMfZmhEuvBZoYfnQch0jooaaUPHN9xu58BeP0f2j9Uxo/HUeE/OGfYKepUXEWc5Eya0sIb0mOxmI0Zvudtzxb1EUs4+Hb2ij4GwTGBlh2Ni40bQgoMVz3yNoWAM4uioK2+kqSaTI9WNLgVOs=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3846.namprd04.prod.outlook.com (2603:10b6:a02:ab::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Wed, 20 May
 2020 08:04:14 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3021.020; Wed, 20 May 2020
 08:04:14 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: l00293085 <liuzhouhua@huawei.com>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH nvme-cli] edit huawei ssd filter
Thread-Topic: [PATCH nvme-cli] edit huawei ssd filter
Thread-Index: AQHWLkiUTt0iwLFwtEqVryqKzPchdQ==
Date: Wed, 20 May 2020 08:04:14 +0000
Message-ID: <BYAPR04MB496503E2EB0863F2C69CB2AC86B60@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200520013922.101374-1-liuzhouhua@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2cb2d592-e98c-4ef5-e3e4-08d7fc946344
x-ms-traffictypediagnostic: BYAPR04MB3846:
x-microsoft-antispam-prvs: <BYAPR04MB38460B9DA95FD7192536A8CF86B60@BYAPR04MB3846.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04097B7F7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r6YvjTfJY2Gj1kmmv3wYpywQaWj2UOBRmyRkbbtR8ahV+ptgc8JofXrRDsZrNjLicbs72hqEztaSKKtyL+5UFELPgNVB3rJ24pB278adschu3gGG+dLHzGEd2rTBNSG4yuvS5wLBdwZnPLZyaNHMKNRGqNZP4seKwpO7ckNXRWHKBz+glCBiKB9dqYslQnM2pvkCF9MV9kJLCvl4PUoz9T7Gt4fdTUgLjZWgkGGw69p5Y22T1dv6JP6NeWeZMz7Wp+PUyAIKCctesLv4dBgtItsEQDcUgHV+2gQvsId21MUl1YUFcRq9q7ZYoiB2oIiK9cCFHYztMpWCCouH6wJz4hKCRZgJRN3S96uxg1WDp9sCpMPuOrewF9Lq3K8j6TKkdeE2Bfs0kwmap6hNMEDqiPeLC2o56TRhQ2u+lYL0KB3XL4/QvMaLA9rQiPt1ysP4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39860400002)(136003)(366004)(346002)(396003)(5660300002)(86362001)(71200400001)(8936002)(26005)(7696005)(2906002)(53546011)(6506007)(186003)(8676002)(54906003)(76116006)(478600001)(316002)(4326008)(55016002)(9686003)(52536014)(33656002)(66446008)(66556008)(66946007)(64756008)(66476007)(110136005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: KjS4rYZPAOW6ddtrSEo4DnkXyHKa6fk5rF1GrZmAnXWvAiSuCXORGLCF+2CgkUnrrzL+grdn5L8uFGMerkNvizbSQPz1EKKyQVdNSZrCjd3z2WatZjKZHoyzLplEU+Jbrpj/7jukfZbbQ1KV10MpiJ6cP5Ob6HIKWLn5oAtERZBqNbc5z9xZYeupuL+9Lc+8Uo3pfoLATRXloiuPu9KCC3H4UzO3E50ZnCks3N9trcifIVIhZOPK7jjcR6VCIhlqnI2sACNNeycZ+ChPHB67xcIEWNCxackyc7XXJAgOVgT0UU6SBcjlk8rNk/mSFtt0cU626vmBbckyIWwuf99psoZCLV40WeqWFpo0q3cjOnFTv8Z8E5mmpKZzHw0YeZw8V5alTBWPWMbgF+XN0yrmPYNvubJSiFlNqTjP04TVCyTabHd6T9e/cfyAt3qbdlpbXDF5ut0w0mbJBUVCVBmpDqa5bYF1NGchlx8zWbI6iINDM6rseHjtJ8498/HC9f+2
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cb2d592-e98c-4ef5-e3e4-08d7fc946344
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2020 08:04:14.5573 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c96hZolUZRShG5vpbfnn+tXns3+CrXHcM0tO90RLR2z9Jc5NkpCsoVSUIL1R2bvhEGCcjpSWDfZapWoNbOFxRYe5Ku+ChD8Eda3cTc++D3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3846
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200520_010422_471958_ECB15C82 
X-CRM114-Status: GOOD (  13.71  )
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
Cc: "wangzan@huawei.com" <wangzan@huawei.com>,
 "kangwenhong@huawei.com" <kangwenhong@huawei.com>,
 "Michael.wangchong@huawei.com" <Michael.wangchong@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 5/19/20 6:47 PM, l00293085 wrote:
> Hi, I'd like to modify command: nvme huawei list, add huawei vendor id as filter
> 
Please modify the subject line and patch description as per the style 
present in the tree.
> Signed-off-by: Andy Liu <liuzhouhua@huawei.com>
> Reviewed-by: Wang Zan <wangzan@huawei.com>
> ---
>   plugins/huawei/huawei-nvme.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/plugins/huawei/huawei-nvme.c b/plugins/huawei/huawei-nvme.c
> index c935f47..c7f3307 100644
> --- a/plugins/huawei/huawei-nvme.c
> +++ b/plugins/huawei/huawei-nvme.c
> @@ -41,6 +41,7 @@
>   #define CREATE_CMD
>   #include "huawei-nvme.h"
>   
> +#define HW_SSD_PCI_VENDOR_ID 0x19E5
>   #define ARRAY_NAME_LEN 80
>   #define NS_NAME_LEN    40
>   
> @@ -80,16 +81,15 @@ static int huawei_get_nvme_info(int fd, struct huawei_list_item *item, const cha
>   		return err;
>   
>   	/*identify huawei device*/
> -	if (strstr(item->ctrl.mn, "Huawei") == NULL) {
> +	if ((strstr(item->ctrl.mn, "Huawei") == NULL) \
> +		&& (le16_to_cpu(item->ctrl.vid) != HW_SSD_PCI_VENDOR_ID)) {
>   		
Consider following coding style to avoid \ in the code and break at the
&&.
         if (err)
                 return err;

-       /*identify huawei device*/
-       if ((strstr(item->ctrl.mn, "Huawei") == NULL) \
-               && (le16_to_cpu(item->ctrl.vid) != HW_SSD_PCI_VENDOR_ID)) {
+       /* identify huawei device */
+       if ((strstr(item->ctrl.mn, "Huawei") == NULL) &&
+           (le16_to_cpu(item->ctrl.vid) != HW_SSD_PCI_VENDOR_ID)) {
                 item->huawei_device = false;
                 return 0;
         }

item->huawei_device = false;
>   		return 0;
>   	}
> -	else
> -		item->huawei_device = true;
>   
> +	item->huawei_device = true;
>   	item->nsid = nvme_get_nsid(fd);
> -	err = nvme_identify_ns(fd, item->nsid,
> -							0, &item->ns);
> +	err = nvme_identify_ns(fd, item->nsid, 0, &item->ns);
>   	if (err)
>   		return err;
>   
> 


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
