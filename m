Return-Path: <SRS0=Y48z=76=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1ACFC433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jun 2020 06:47:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B10AA208C3
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jun 2020 06:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ku3BJT09";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SuR5vlvX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="QAkYKp4f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B10AA208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=t89mZBcv417qgBaxABI3YI4/sbPIrDtEPbiOLeFx9gw=; b=Ku3BJT09xiKOtU
	9cjrR578mXe/HICyWqzxsHAXWr11xcz9+e+/UugK2mbaVnX5aPqC0UFHuZk37N3rUujC97ZI+9Kk6
	dx4UCB0A0ikJ7IxclpUVhmV3CDpEPKseeHBrtpkojXn3yL1eUDiiU41JPDwRLTL2KjZB6s+dbwRc3
	sToKivadZr8jEUjb67xvHtCDkmxRc463ToU9GL4lS2BVoBvjCYkxkGPHOOmMWZ9LxG+ols202uiMy
	idZk7qm+QKFw4FET8Cg9GQ2F8EThRwTMrzwptFV34EFy6gWGsDZ0G1LuzhdvPu4NT2jg/SVVZQdhk
	t+q5H61AXfVv94laAgEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jlRrL-00062n-4D; Wed, 17 Jun 2020 06:47:43 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jlRrI-00062H-2Y
 for linux-nvme@lists.infradead.org; Wed, 17 Jun 2020 06:47:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592376460; x=1623912460;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=DiccMsEWLcLrcC5JyIwRe8CqHplD9Y9iLbzyKbaLxgY=;
 b=SuR5vlvXPTOzC2MAUf9ww6h4lNZ3RR4ytwYODRXqENDwiuEUK3DhI0/9
 4pkyL+lrK3Z5D2BsUKq/8x4b+Zu/hGc3/5JkMZDKZbU6Ot8Z7HleM9phQ
 wdODjivA2EK5Hfp2K1vXa0679/WhTZypXoNc/UTdDiq8x38fghMhrK0xJ
 KERESj3qaLn2dIiA+GLrz+h04owwdxytrOi1dvh4LB9kkLlGjkjPOowi8
 zhqi/kAOwSIg9wEp//3nHdght8j8DE/sEJQDNhWSs82XUz8OF8t+wOvxl
 wfSmwvVBzqqHmVw6rndcKUQO5fj4DUet2bre1zLdSa5A8U/JpNeAHXJKK Q==;
IronPort-SDR: r8WjqaKHGZ2uucD62jufY8JRSGK9AQTHmuHO5uSnV/RylNTh83y4EUlZcpQniGY8E63Az/5uqU
 VnXA70LmPZP77C2NMPGy+mb4EmU6M9xtmqMx+HOUAIzZ/KoxOO5nH0/iLVT1lZK3v4PU6CVWOm
 ntdtSNWsUsZESCjuF3fuNX051bJmHUsCaihmFCwHLLyRbM3zuehq0FoAuYvFUxGYRuwcTMNgp6
 mNoAxu+f1kzpPi9P7Y4F/Yev/zQy+X9bLnd61bXJAPBA9rwon1NCdErT891tZXnpQ3lCtwy+lw
 ztc=
X-IronPort-AV: E=Sophos;i="5.73,521,1583164800"; d="scan'208";a="141584792"
Received: from mail-cys01nam02lp2053.outbound.protection.outlook.com (HELO
 NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.53])
 by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2020 14:47:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aP27uHcakV7pw6sji7hlRjFPE7KcLmatyDFYJcoaS1RLb8VQ7hLiFxiMkT7B1+aAhZUtpqaMzvrckkJUrUVlhTwLkq4CGiqkoXwPOFDOceH4I6kJnJngp19K+h87w7nPO8r5wqKvWPVaftuSh6pS8cpLC7TSioSLTE0Cypx/hWVfOkgdi7PP2096IM94koA3Wx2JjGfMrltpd269MtENzb9c6DTG+gxmU2zXanHVaM4tz81Y1qN+l60DRWRqdHw08qucuu0wkRE7GhmF7OWm/00GGof0ZHlFzx5i5WGhHRPryUviSc1XE8iNvPlHyWUbTGobTAbwct2ZWsw897gpaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpuc+G8mbJfpFxW9StPA7rYmQpPpOGZFO2cGyVfvqlQ=;
 b=NVWGizEQdyhWnkskZEIZg5iYDTlZIvrN7tktI0GhELlhtWdbXnY+v0KTBQGWfax/Of00m2kC4Dyc+Xz9n9d+IWq3MNbgYzvQI0PGYJ5cNCIi9SUAYZFutX6fGJ1mT0fTE8WmzghWnkmwcAMIUPMeinPP9sYhIb6yDagvZWFq/zEp78Xg8GANBvW+tFk4hNIYPpjTN98aT3hHZTNIp5M/7j29wszlvm6OPAw+GFJljDvv1JcZ9trmMeiVf7au+iN+VhvMsdfAmE0QNP7Am16n7mZGf7cP6TId2CSrrei4GaVUVY2kwHAiNm6/gND/7qoSxBHpNQnV4iEA/OcqrBSlDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpuc+G8mbJfpFxW9StPA7rYmQpPpOGZFO2cGyVfvqlQ=;
 b=QAkYKp4fUZ02HTS9A0Dds9GpuJx7DMdeP+lBrUpZXO5lWajgiNGx0YtP0/tqtU2Set0no+EH93QFjql0jHBZ2NbtGVq2NACJunH3BAmTp/6XZJwprd2hGfarLWogfLXyUH7pcetssvHYbyT1bonjJkdAMv+lLOTR28MaQ/NmKCY=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0728.namprd04.prod.outlook.com (2603:10b6:903:e4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.24; Wed, 17 Jun
 2020 06:47:37 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3088.028; Wed, 17 Jun 2020
 06:47:37 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
Thread-Topic: [PATCH 5/5] nvme: support for zoned namespaces
Thread-Index: AQHWQ22ncHPAnMo9ZkarXHo4UNlnAg==
Date: Wed, 17 Jun 2020 06:47:37 +0000
Message-ID: <CY4PR04MB375154B897296A3A4C82503DE79A0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200616104142.zxw25txhsg2eyhsb@mpHalley.local>
 <d433450a-6e18-217c-d133-ea367d8936be@lightnvm.io>
 <20200616120018.en337lcs5y2jh5ne@mpHalley.local>
 <cf899cd9-c3de-7436-84d4-744c0988a6c9@lightnvm.io>
 <20200616122448.4e3slfghv4cojafq@mpHalley.local>
 <CY4PR04MB3751CC8FE4BDFC256F9E9CD1E79D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200616141620.omqf64up523of35t@MacBook-Pro.localdomain>
 <CY4PR04MB37512BCDD74996057697F5CAE79D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200616150217.inezhntsehtcbjsw@MacBook-Pro.localdomain>
 <CY4PR04MB37513B2D2B7AAE343ABF14C1E79A0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200617060953.ypviiz75cua4bt25@mpHalley.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [60.117.181.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6718ce5e-97fa-4668-be57-08d8128a52ed
x-ms-traffictypediagnostic: CY4PR04MB0728:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB072847FA534E7EC7ACD9943EE79A0@CY4PR04MB0728.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04371797A5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sMbT2bX2Yw977ZnjFCdMgHm9ID1DJ8ewvGVX3nqFHJ6Fph891mupTihX2jfKADQKEtHISeYqUpiJ4GjoE1ZxQzRc7fLfoecNpAkqvpg8NuzEokZBrcnZksg5s2kqDGpgn0k4T45RGB3hA6nwJlqXgUCGieCOXYlXuQU8+psAl7AzemIrz/zqFuvF1L9NiTwBjinv3t3SEGwg19fnlvogxY5KAmTza6CLn/lQ5ebDXyUzrDvr8JBxZYfW2TZ1jMG42WE5/moxTI2hnYSG/U3XSsmnzGgWbOzMbq4lLS1q4MLp/wfAc8yjOyZWNwn7grDdpso+zfZ2G1FJlxSkuQTvJ4F5+goONo8kCqGfs3kKsCKpnTlcRyXd+MsRPH3CoxMtmrP6Ebu8hSnxUxeg3msFdg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(66556008)(64756008)(66446008)(86362001)(26005)(9686003)(5660300002)(186003)(76116006)(966005)(71200400001)(8936002)(66476007)(4326008)(2906002)(478600001)(66946007)(52536014)(55016002)(91956017)(33656002)(316002)(54906003)(8676002)(6506007)(53546011)(6916009)(83380400001)(66574015)(7696005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: uOG+uhTw+stELk6CpihxoJ6OquAtFCYaFYZeSYRBVfmQjoWwjXpU9jnUMbqPNI1i36SF4Kwoi5obNVYSRNNrtwLEKNhA8nHQvPfFiRup9fGDZuhXPHYG8X5pG5t5oQ7ehOFI1Zd0UQJ5h0XsARN2grDICeQ2d7Si1XDehg1AUHwHTW7fwwdURyARpY6+0t8px5fn0kNpgZ2MhXKqfoTJqMo5QDayruKb9f+UKPzEhdVtgXnOU9mdXWLMq1QPqBHkRnPniQsp+8A+KesuBmOW3pz5A1O6d8+BUgl037XJb2ORcMWg6qsN30H5lvJl1Tbicea5Ewejy6tUQA02StA+uCbqU1/tvsNvKCNCop//OIyrxGjV3/MLADExt4ukmfvrcBZD/oUqUX/Y1+sfT949su24WYd93NBDuXUTzkDY6ywib8QD9o6HV6QOyger0QHEb6GAhNkKymzMXfE5rxlcEuoIuBTMXrvHiFz2VgooqFEmJPBZvvMLD4D2pqJ3ymxd
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6718ce5e-97fa-4668-be57-08d8128a52ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2020 06:47:37.7725 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1FdM2guLYPLXnZmxOauBLMK+dKU1eOInW0cl90ir1SOCgwIGlRB5q7K4iU8JQsw5K8xIC1H2EvQiRzCj0EZ2QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0728
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200616_234740_266193_0D52FC01 
X-CRM114-Status: GOOD (  21.36  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 Ajay Joshi <Ajay.Joshi@wdc.com>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <Keith.Busch@wdc.com>, Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
 Aravind Ramesh <Aravind.Ramesh@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Hans Holmberg <Hans.Holmberg@wdc.com>,
 =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>,
 Christoph Hellwig <hch@lst.de>, Matias Bjorling <Matias.Bjorling@wdc.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/06/17 15:10, Javier Gonz=E1lez wrote:
> On 17.06.2020 00:14, Damien Le Moal wrote:
>> On 2020/06/17 0:02, Javier Gonz=E1lez wrote:
>>> On 16.06.2020 14:42, Damien Le Moal wrote:
>>>> On 2020/06/16 23:16, Javier Gonz=E1lez wrote:
>>>>> On 16.06.2020 12:35, Damien Le Moal wrote:
>>>>>> On 2020/06/16 21:24, Javier Gonz=E1lez wrote:
>>>>>>> On 16.06.2020 14:06, Matias Bj=F8rling wrote:
>>>>>>>> On 16/06/2020 14.00, Javier Gonz=E1lez wrote:
>>>>>>>>> On 16.06.2020 13:18, Matias Bj=F8rling wrote:
>>>>>>>>>> On 16/06/2020 12.41, Javier Gonz=E1lez wrote:
>>>>>>>>>>> On 16.06.2020 08:34, Keith Busch wrote:
>>>>>>>>>>>> Add support for NVM Express Zoned Namespaces (ZNS) Command Set=
 defined
>>>>>>>>>>>> in NVM Express TP4053. Zoned namespaces are discovered based o=
n their
>>>>>>>>>>>> Command Set Identifier reported in the namespaces Namespace
>>>>>>>>>>>> Identification Descriptor list. A successfully discovered Zoned
>>>>>>>>>>>> Namespace will be registered with the block layer as a host ma=
naged
>>>>>>>>>>>> zoned block device with Zone Append command support. A namespa=
ce that
>>>>>>>>>>>> does not support append is not supported by the driver.
>>>>>>>>>>>
>>>>>>>>>>> Why are we enforcing the append command? Append is optional on =
the
>>>>>>>>>>> current ZNS specification, so we should not make this mandatory=
 in the
>>>>>>>>>>> implementation. See specifics below.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> There is already general support in the kernel for the zone appe=
nd
>>>>>>>>>> command. Feel free to submit patches to emulate the support. It =
is
>>>>>>>>>> outside the scope of this patchset.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> It is fine that the kernel supports append, but the ZNS specifica=
tion
>>>>>>>>> does not impose the implementation for append, so the driver shou=
ld not
>>>>>>>>> do that either.
>>>>>>>>>
>>>>>>>>> ZNS SSDs that choose to leave append as a non-implemented optional
>>>>>>>>> command should not rely on emulated SW support, specially when
>>>>>>>>> traditional writes work very fine for a large part of current ZNS=
 use
>>>>>>>>> cases.
>>>>>>>>>
>>>>>>>>> Please, remove this virtual constraint.
>>>>>>>>
>>>>>>>> The Zone Append command is mandatory for zoned block devices. Plea=
se
>>>>>>>> see https://lwn.net/Articles/818709/ for the background.
>>>>>>>
>>>>>>> I do not see anywhere in the block layer that append is mandatory f=
or
>>>>>>> zoned devices. Append is emulated on ZBC, but beyond that there is =
no
>>>>>>> mandatory bits. Please explain.
>>>>>>
>>>>>> This is to allow a single write IO path for all types of zoned block=
 device for
>>>>>> higher layers, e.g file systems. The on-going re-work of btrfs zone =
support for
>>>>>> instance now relies 100% on zone append being supported. That signif=
icantly
>>>>>> simplifies the file system support and more importantly remove the n=
eed for
>>>>>> locking around block allocation and BIO issuing, allowing to preserv=
e a fully
>>>>>> asynchronous write path that can include workqueues for efficient CP=
U usage of
>>>>>> things like encryption and compression. Without zone append, file sy=
stem would
>>>>>> either (1) have to reject these drives that do not support zone appe=
nd, or (2)
>>>>>> implement 2 different write IO path (slower regular write and zone a=
ppend). None
>>>>>> of these options are ideal, to say the least.
>>>>>>
>>>>>> So the approach is: mandate zone append support for ZNS devices. To =
allow other
>>>>>> ZNS drives, an emulation similar to SCSI can be implemented, with th=
at emulation
>>>>>> ideally combined to work for both types of drives if possible.
>>>>>
>>>>> Enforcing QD=3D1 becomes a problem on devices with large zones. In
>>>>> a ZNS device that has smaller zones this should not be a problem.
>>>>
>>>> Let's be precise: this is not running the drive at QD=3D1, it is "at m=
ost one
>>>> write *request* per zone". If the FS is simultaneously using multiple =
block
>>>> groups mapped to different zones, you will get a total write QD > 1, a=
nd as many
>>>> reads as you want.
>>>>
>>>>> Would you agree that it is possible to have a write path that relies =
on
>>>>> QD=3D1, where the FS / application has the responsibility for enforci=
ng
>>>>> this? Down the road this QD can be increased if the device is able to
>>>>> buffer the writes.
>>>>
>>>> Doing QD=3D1 per zone for writes at the FS layer, that is, at the BIO =
layer does
>>>> not work. This is because BIOs can be as large as the FS wants them to=
 be. Such
>>>> large BIO will be split into multiple requests in the block layer, res=
ulting in
>>>> more than one write per zone. That is why the zone write locking is at=
 the
>>>> scheduler level, between BIO split and request dispatch. That avoids t=
he
>>>> multiple requests fragments of a large BIO to be reordered and fail. T=
hat is
>>>> mandatory as the block layer itself can occasionally reorder requests =
and lower
>>>> levels such as AHCI HW is also notoriously good at reversing sequential
>>>> requests. For NVMe with multi-queue, the IO issuing process getting re=
scheduled
>>>> on a different CPU can result in sequential IOs being in different que=
ues, with
>>>> the likely result of an out-of-order execution. All cases are avoided =
with zone
>>>> write locking and at most one write request dispatch per zone as recom=
mended by
>>>> the ZNS specifications (ZBC and ZAC standards for SMR HDDs are silent =
on this).
>>>>
>>>
>>> I understand. I agree that the current FSs supporting ZNS follow this
>>> approach and it makes sense that there is a common interface that
>>> simplifies the FS implementation. See the comment below on the part I
>>> believe we see things differently.
>>>
>>>
>>>>> I would be OK with some FS implementations to rely on append and impo=
se
>>>>> the constraint that append has to be supported (and it would be our j=
ob
>>>>> to change that), but I would like to avoid the driver rejecting
>>>>> initializing the device because current FS implementations have
>>>>> implemented this logic.
>>>>
>>>> What is the difference between the driver rejecting drives and the FS =
rejecting
>>>> the same drives ? That has the same end result to me: an entire class =
of devices
>>>> cannot be used as desired by the user. Implementing zone append emulat=
ion avoids
>>>> the rejection entirely while still allowing the FS to have a single wr=
ite IO
>>>> path, thus simplifying the code.
>>>
>>> The difference is that users that use a raw ZNS device submitting I/O
>>> through the kernel would still be able to use these devices. The result
>>> would be that the ZNS SSD is recognized and initialized, but the FS
>>> format fails.
>>
>> I understand your point of view. Raw ZNS block device access by an appli=
cation
>> is of course a fine use case. SMR also has plenty of these.
>>
>> My point is that enabling this regular write/raw device use case should =
not
>> prevent using btrfs or other kernel components that require zone append.
>> Implementing zone append emulation in the NVMe/ZNS driver for devices wi=
thout
>> native support for the command enables *all* use cases without impacting=
 the use
>> case you are interested in.
>>
>> This approach is, in my opinion, far better. No one is left out and the =
user
>> gains a flexible system with different setup capabilities. The user wins=
 here.
> =

> So, do you see a path where we enable the following:
> =

>     1. We add the emulation layer to the NVMe driver for enabling FSs
>        that currently support zoned devices
>     2. We add a path from user-space (e.g., uring) to enable passthru
>        commands to the NVMe driver to enable a raw ZNS path from the
>        application. This path does not require the device to support
>        append. An initial limitation is that I/Os must be of < 127 bio
>        segments (same as append) to avod bio splits
>     3. As per above, the NVMe driver allows ZNS drives without append
>        support to be initialized and the check moves to the FS
>        formatting.
> =

> 2 and 3. is something we have on our end. We need to rebase on top of
> the patches you guys submitted. 1. is something we can help with after
> that.
> =

> Does the above make sense to you?

Doing (1) first will give you a regular nvme namespace block device that yo=
u can
use to send passthrough commands with ioctl(). So (1) gives you (2).

However, I do not understand what io-uring has to do with passthrough. io-u=
ring
being a block layer functionality, I do not think you can use it to send
passthrough commands to the driver. I amy be wrong though, but my understan=
ding
is that for NVMe, passthrough is either ioctl() to device file or the entire
driver in user space with SPDK.

As for (3), I do not understand your point. If you have (1), then an FS
requiring zone append will work.


-- =

Damien Le Moal
Western Digital Research

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
