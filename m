Return-Path: <SRS0=Onny=7V=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751E9C433DF
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jun 2020 05:38:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A9D8204EC
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jun 2020 05:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DhEU8fsa";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="H9Jelnhj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fr7WEskT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A9D8204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=kwmBsojAl3Ha7ENI533aQ8bdl8Da9paKmkzOdhBOvys=; b=DhEU8fsaxr/R1u
	ocXlLg6mzjt8pBu5fUlY3oNgKhpSRJhz+lwgAgrfIN9ktyEKHFbmva60g6bPqEiwETCrCgnVL/vE4
	pFISpp3WGlOcGdFTNck3C37iqIIf2WQSIYhlPLY0qYcfwpyYn/T+f91fgaoJ0suldJ1FP9Uif9x+l
	eBTM8pU8PFUD/vWChcZ3Korwn6LcUOukgdPle5NmnAlY2Skyv1czkt3c4LQbonqZKLPCyglo8AlpN
	H0C/GA7OJwAVNsaR/oCxi5YXnbM+rvPqAgXY5f04e4ZLe5FBarFq7KgWUq3ZozB/pnTlXK4p7eN5P
	XGzkG/IkgDLGXQ+pGCAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jiAUl-0004b6-Fa; Mon, 08 Jun 2020 05:38:51 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jiAUi-0004aT-H9
 for linux-nvme@lists.infradead.org; Mon, 08 Jun 2020 05:38:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1591594728; x=1623130728;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=jofzyz25pqzZFmCSZ1g34iV2iHr1WZz7sbEHNJIu1j0=;
 b=H9Jelnhj0yQnsSOiO9DTKTNmdgJVUq3rBM+1js50FjMBG+KA4bLE7UQ6
 +iNyIN786MioB3fw2TIZiVeWGWg2H7mQ29iILPwpSxeR37iaraCbT3QqF
 QuzcMmJnmbAl4u8pwchyGJbtqHu7RwTqbToSHECiTKbngoJMyB2PBdSvq
 jB0z28UoeV57cJxZcFvIOAl7N1XG0ChD90onNBz3JUfwWorL5OYVLJ0CO
 su96Xwgy4xotdawvL9KcjTr872tpbItRXI/f3ZP5+1eukicqXQe8pUc9K
 T8EoTpbidLfohg4eBnEmu9DzPjIofS9Fx4neOo3VB+/7pYGXtUWDuCupc Q==;
IronPort-SDR: cl2r0jgTaqPyg3Z72cGwCxmYsqXTi2dAE88CsXFhQbmzffLpJAvuONUsR2XkKrMzwrXZdjepyf
 3WgHVohdBDx/G6vdHDPmmfarbnr33c1WmLNrEIH6E0IMMLFLEl3b8wRtDRRtHgychqELolHaut
 K++YfRtwLn4noiN7P5zP2/JUA6WiWA3Q01IWSwjhW0sD02UIGnJlfiTToaIveIFr/pFYIuBwzn
 J/bKjOL96bL8YmZZ2f0s/x8GPgNuihsoG5xDer4kzmk1JEskmpc411tohP7Tmy23HdDKlDOMw7
 zkY=
X-IronPort-AV: E=Sophos;i="5.73,487,1583164800"; d="scan'208";a="139727600"
Received: from mail-bn7nam10lp2106.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.106])
 by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2020 13:38:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jm6KvG0WRCx+X0adqDwpuRu2IyrYdMbNrG1ZSLL8Qq3shaMQxCL72D6khE9BLfQQA/YreJPlCEOkR1y9diqxu98NBbmXeqGhSAy8IYalFkc7OFwo7moBLDoPA/DWEqGCdJ4XTglcYIKJiAEDFfg7zaHsOHPDBKunw7Au5Jc6ddvy8RsOsOUH2eqkZwEMw+0ZIcVAc2i8VuIXmVEEXFRmn/TmX3BgI9b6Vj/zO+Lqu0HB9CGa6S85OP3lT950SRcVFvtnoIBlDVifDcMVEGMFvywdV7uLvyhdEF4L5Tqq15cn7l37J28bJmRB0nXDCH7/NY5fCdHjfcNjMzNpXiudsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1/INOkIcTxb3+nCkWmpjqxSh9tCMhulBfZ9dkOs+gM=;
 b=M4ZRW697eLaOKai/PNk/8f7kwralA/b9mZSCHquS2jOow8jfhlnnt429lSI/sirZmE7aDg7hCZ8uPwlFIJ4QYubw99Vzv7ho1U7z1GtPPYY79XVnRQc5l10+MTkJHoPixYLIBiVJPGayrcFsRv+e7fBOlMA151Nl7ysWESfHyLZ00tXe+YBqLm+XhpwXjN5McgZwzjYl7QMaou7vU7OadMDE+el/0N1uYPrAzk/RpLt7sxKLq9NEc7AynWlLAjqt3TzBtMQ2baKn6Fh2W7UadrqfKzI9lErTaM/xvEdo3YSPZjeIF3rgDmpJFyfNXC03V7H+mng4xC6u8EMRWycfNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1/INOkIcTxb3+nCkWmpjqxSh9tCMhulBfZ9dkOs+gM=;
 b=fr7WEskTi6cO5rM6a86pq9DCks/2n0VOVPWO+3q4WCyRkxq/WejJ8hpOu5w/OrZ2U9g7PQ3Dpqs73H1McC1Ojcza4Dpl5C0cpv3Ey7Hd8+bNMUeVFjOuyQqpEhx7+zVMgGUx1Ek/iJ/j8k+Z0061hKi/Pe5GpLP8tasidOEoNsU=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4325.namprd04.prod.outlook.com (2603:10b6:a02:fe::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.23; Mon, 8 Jun
 2020 05:38:42 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 05:38:42 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: blktests test nvme/003 fails
Thread-Topic: blktests test nvme/003 fails
Thread-Index: AQHWNIJZVRL6ENIo6Uy1ge01JbudSw==
Date: Mon, 8 Jun 2020 05:38:42 +0000
Message-ID: <BYAPR04MB4965AB9C830958070F426B3286850@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <a2b9e92a-f499-b54c-a275-c08a23467866@acm.org>
 <BYAPR04MB49651040C77627E3A70FF86886880@BYAPR04MB4965.namprd04.prod.outlook.com>
 <fddde27a-eb61-7031-a067-5538e0fe3243@grimberg.me>
 <BYAPR04MB49651CF1169CD33108A484B386880@BYAPR04MB4965.namprd04.prod.outlook.com>
 <BYAPR04MB4965217373E87DFEE2398D3F86890@BYAPR04MB4965.namprd04.prod.outlook.com>
 <96530c68-0cc0-8b88-4d3e-c2a66be44167@grimberg.me>
 <e110c297-a357-5e8d-754b-09a5faec7399@grimberg.me>
 <BYAPR04MB49658EAA5D722230E5036DE686850@BYAPR04MB4965.namprd04.prod.outlook.com>
 <d3a692a7-bc4b-215a-4d02-a6711d542d97@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 930be70a-e34f-4f14-be97-08d80b6e3432
x-ms-traffictypediagnostic: BYAPR04MB4325:
x-microsoft-antispam-prvs: <BYAPR04MB43253C6AF670C2D273E730FE86850@BYAPR04MB4325.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1002;
x-forefront-prvs: 042857DBB5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f4+qPev18KCgWhQeBL6VVbwXXfj0+FnaDgz0EAtP417SlVMi2oCVXAaLpN4NoLrd4VsJduIUu5bYN/KKpozJvlLaGb8EE5a47ER9OaFPWAwvyCm/PIC39FgLiJWRXm2GXsuwi5jhQpjmdvuXw8ExW9bpHy2zqLl+qJrSkjyPTpWNq3mQpQ60FxhNZm+jgqeMksJqRMTgTqKKfjgj8Wgl4KybYaPbfgvKGnNdF5B94FjorajAFZ94Q2wxU4SORiqK1ur37PszLBLoK8sXFo6KvTEV0PO7qYpD9ykWrh+es8Aldf4V2VU1ZFCegPJ9E+ujp+3mu7By+R1HKbYJXymE2X4iiz9A080JSd70Ig+cqYIHpVC0hly8Vi2TZU6G6jvnJajLJ3xnLLGFxpyFyaRB5w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(66476007)(66946007)(64756008)(76116006)(66446008)(66556008)(186003)(8936002)(7696005)(6506007)(966005)(26005)(478600001)(33656002)(54906003)(5660300002)(8676002)(55016002)(71200400001)(4326008)(83380400001)(316002)(9686003)(86362001)(52536014)(2906002)(6916009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: QeVSvfsZglcDj+lU3v1350Igh+ZmrUkegibmvJxnZKnrXxu87mb13kj7o94LvvuqPAdfkRfHCI4BvbbLhcFaeDr7c46Jvv4WpFg9ua3TwLgfzFJi/GNjRlMIzZ1RM0AEOMAuQoBTUZUTU8FAzSNkXeXpldaayLwAKdoHP0tDd4XbvGUu1yKmw3X91PpC3lJL4InKoiHFpAkoZO6cHIGOT/n4qpdOBvVIBb5xy+7s8O5ZU/jjvokPfepxx1hxuCDLWjxvFVBbmpLyg8ayum/nbNNTHtrCUSE8DpbSeMazxhdxxZHjXFNvMfZhpFhzW7qr2KMwKx7Td6nxHuPCNDIuxzdfDxexjxBzoNzXTyU/CmHIkk0lu5W37GP22xrE9cB/8dsGAFuRxsQNfzi/FaKJCJjlnL1PE5sw3UWddyyTOC63xPY2IrIcZoLSRqjaAKcZjCn4vhVOwMOnPLmhzWaJ/9k6Af9KyHLW4AOyPn1Tl8w=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 930be70a-e34f-4f14-be97-08d80b6e3432
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2020 05:38:42.2224 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NIpETO8Qtufwx+iLsoN3Nj17ub/Ot8DKl1To3fnN0wyjmkoF1pFiyXD2rt9bErosKFFFQxhU2YsbE+FUH6lw4kVE9/Dkp68Khrv0/EsYoeY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4325
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200607_223848_581435_C5094084 
X-CRM114-Status: GOOD (  12.40  )
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
Cc: Bart Van Assche <bvanassche@acm.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

>> Here is the new patch which clears up the outstanding AENs in a separate
>> function from [2]:-
>>
>> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
>> index 6392bcd30bd7..b494a902c3fc 100644
>> --- a/drivers/nvme/target/core.c
>> +++ b/drivers/nvme/target/core.c
>> @@ -777,6 +777,20 @@ static void nvmet_confirm_sq(struct percpu_ref *ref)
>>             complete(&sq->confirm_done);
>>      }
>>
>> +static void nvmet_async_events_free_host_req(struct nvmet_ctrl *ctrl)
> 
> Lets call it nvmet_async_events_failall and keep it as is..

Yeah let me send an official patch with the name change.

> 
>> +{
>> +       struct nvmet_req *req;
>> +
>> +       mutex_lock(&ctrl->lock);
>> +       while (ctrl->nr_async_event_cmds) {
>> +               req = ctrl->async_event_cmds[--ctrl->nr_async_event_cmds];
>> +               mutex_unlock(&ctrl->lock);
>> +               nvmet_req_complete(req, NVME_SC_INTERNAL | NVME_SC_DNR);
>> +               mutex_lock(&ctrl->lock);
>> +       }
>> +       mutex_unlock(&ctrl->lock);
>> +}
>> +
>>      void nvmet_sq_destroy(struct nvmet_sq *sq)
>>      {
>>             u16 status = NVME_SC_INTERNAL | NVME_SC_DNR;
>> @@ -786,8 +800,16 @@ void nvmet_sq_destroy(struct nvmet_sq *sq)
>>              * If this is the admin queue, complete all AERs so that our
>>              * queue doesn't have outstanding requests on it.
>>              */
>> -       if (ctrl && ctrl->sqs && ctrl->sqs[0] == sq)
>> +       if (ctrl && ctrl->sqs && ctrl->sqs[0] == sq) {
>>                     nvmet_async_events_process(ctrl, status);
>> +               /*
>> +                * Target controller's host posted events needs to be
>> explicitly
>> +                * checked and cleared since there is no 1 : 1 mapping
>> between
>> +                * host posted AEN requests and target generated AENs on the
>> +                * target controller's aen_list.
>> +                */
>> +               nvmet_async_events_free_host_req(ctrl);
>> +       }
>>             percpu_ref_kill_and_confirm(&sq->ref, nvmet_confirm_sq);
>>             wait_for_completion(&sq->confirm_done);
>>             wait_for_completion(&sq->free_done);
>>
>> [1]http://lists.infradead.org/pipermail/linux-nvme/2020-June/030823.html
>> [2]http://lists.infradead.org/pipermail/linux-nvme/2020-June/030839.html
>>
>> _______________________________________________
>> linux-nvme mailing list
>> linux-nvme@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-nvme
>>
> 


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
