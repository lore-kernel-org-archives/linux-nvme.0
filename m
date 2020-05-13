Return-Path: <SRS0=q3TM=63=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBA3C2D0FD
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2020 08:16:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4E162492E
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2020 08:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YjDt2mvs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZbKQOK9h";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="FG/Ym5Q9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4E162492E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=LSQRiVWjnJRIP9jJwB+gcQPowW35h/YL0JvNJEOM1/Q=; b=YjDt2mvs0sU+ao
	r6SG2MOcQD97G+YhOrOmVzQ3jusxgjaKTE09At6JNlfPcMYBwUrKB4xZb1N33BWTBtW+JHf8x2wYC
	0u427N6uo73u8ZldGqlYKunMoo76Uo1iRhYO2WykhvqXex2s6iASQR/oSlU4MepHSx+l0M8zL5Gt0
	9OAS0MvnFIILGJW3hEA8HWjIGKyZjuFIGXbYAG2APfUSJIq9wcCIdZFnq+kRNdKpHSdJvYe+vH36z
	WLUvepSSv7kVlMqe9n/4CffUeAGOFbWDR/PmNS7PjC3NKJpMNVWVQDjG69qizkXsssIL8xPQueiVU
	/BpXKeDQbuE5moyp+W7g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jYmYp-0007OU-SG; Wed, 13 May 2020 08:16:15 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jYmYn-0007Nl-6n
 for linux-nvme@lists.infradead.org; Wed, 13 May 2020 08:16:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1589357774; x=1620893774;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=PlLGYXw8t4C/9oTWXvj13OF9S22iRMEd16NfUqRMTPk=;
 b=ZbKQOK9hvnPDXITN86ULqidjBqMJgRmhRVWbRn3PffbRhL2QsR3Gohvx
 kogvW5SW1jfQ5h1vCbsFBRZjzNPU0WG9thb5L3pVexx3GidJNtcDnIFtQ
 AAYHGepHN5ryPts59RUL/aXDMGeVQgcODGXScM0yB5tMmjGGsdo9ea5s3
 UmSrJkrivd4g4VGuu+jjF2PCP3nFn4e73b+y5BJFCrkZ1j8+3N9N1VFKh
 jSpFoDjbPpkT9b6Kshdj62M42qQsEXSyecnIXiKxkAUhTlw4F5FBg5Ic/
 hWyDAVR3EucB5NQfdfmWZFq2mcSh4HhhVj9i8/oSz02U/TREFHxAKNjiu A==;
IronPort-SDR: BrAw9BJnmESClpSdmt7H6lAlk6e7SMEsl9nxbT0pE11xehSZPnG+Nw9M/Rrv5qMrLmNMqhAyBC
 tUGcDCeWo1W48U2zEoUrmYTtudccDvgp25VynPY9u6zzFn4ti6rkeN0IidXaf1jXLmrsnsPYMz
 iq32yTRHZeV69weDEahSDgT27zIWnWH44WIad58lkKOm9RFv6ho+X4yvE3ENyovc/LpYSJ3DBY
 fEEkI8ObA2dZyZxd91wvuuvQUkcRdehykYKfvPUTRbh0X3x6661nTzs+rLxSX9ELqvK2T+6C4P
 2GE=
X-IronPort-AV: E=Sophos;i="5.73,387,1583164800"; d="scan'208";a="137902310"
Received: from mail-mw2nam12lp2045.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.45])
 by ob1.hgst.iphmx.com with ESMTP; 13 May 2020 16:16:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3uOOjtGbeIFeuMIxDesQrGisRYw8zaF2oj0GQqRHvYMy0CA8YfPt0Wps91CdkZ4deVD+iEMHIEb+1CAYviGjcyt7G47XxMaj1Z+2YCtnuw4GrAEaKtRjvcThVo6s4reol/xvCOqlil89YsLuGTi40/50g98GyM7bVSpcP9Q9cVDeBfVHpEVJDsOxsDREaYkOURKGlgqb7mDiNZ/sci0NbKqgUhQarkR4tSwDps4DG+tShw/Zw8+zw9fXwymeYiEiOtAuO2UtKa41TTvfRVQHBaWiabnKjd9sOt+vhtc/ttuPdBb7sAyDQsezgb0uSDSujNQfdY/Cbq+2ttQPH7W/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wpK88DmDxpX9FnOJ0xAYNz5nW0tScaWX0O7Fcod3qs=;
 b=S+BJNXztiYtXfXiVK7LNkfamAD3U7ar8yhuXRGcslx5X3EvgB0wu7JRijQX3hIIW4aDSmbPj9uihyQ0MaxY+GsqVvcqZ7xUtbe+Rye3KjoVo2lFk7DYYmpR9j5bA/gFt8IRR2q44p38M3i78eJ12yXu5Zt8/1E6gUSgkF3Azfg5EAXR8OSY3G1EwbcEPGOA1eSr7WaCF6QNITV4QPGRR8Dhz/+186hVw3Rnb8Vr6ASlIM0xQ32A1yoc0tbEpeV/WQXnX3ekgVYJXJBaQTr3TIHAIhcTrAPsLTQuhnuAndlzVZeKc5m9PaJtQu8LWoKCbqIgYr5NR/yb4DhmKYx0t1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wpK88DmDxpX9FnOJ0xAYNz5nW0tScaWX0O7Fcod3qs=;
 b=FG/Ym5Q9HV4tRGop9FNVZTj0ig6PSop/A91zuR3zesH0S0RvXVRoXsWmwms5OxbLwIhnFDzvdmAZZ0fhL6ediZJyz7HRX8LVaUqFJpw2qoK/5kvCO7NexKibmfNtLtfkdfwmLC02esd2l23TOT1XTud9rRPZNha1izDjmyEpPY8=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5400.namprd04.prod.outlook.com (2603:10b6:a03:cb::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Wed, 13 May
 2020 08:16:10 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3000.016; Wed, 13 May 2020
 08:16:10 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvmet: mark nvmet_ana_state static
Thread-Topic: [PATCH] nvmet: mark nvmet_ana_state static
Thread-Index: AQHWKHkiXfXHHa8s2k6DpG0K1//JuQ==
Date: Wed, 13 May 2020 08:16:10 +0000
Message-ID: <BYAPR04MB496515288062F84FA3E612D686BF0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200512161926.1822603-1-hch@lst.de>
 <962c56fe-4530-43bf-4f95-c732b74b09c3@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [75.54.103.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b068523d-8716-4fe1-5aa1-08d7f715e4f8
x-ms-traffictypediagnostic: BYAPR04MB5400:
x-microsoft-antispam-prvs: <BYAPR04MB5400B0E68F31AE70AFE6C19886BF0@BYAPR04MB5400.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:296;
x-forefront-prvs: 0402872DA1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yJg8mD6gkobQyAaUVazjc8dZ2xcBW+4AtPaln5uLA1DhZ6k2TUl1m38B8dgq3d84enNp7kTLZKaV8hdCaYPZGhh5BB0Ss6TLSPYjKq8aNyfnQjp2Bk0rAOBN9Y35/mFR754G49QWAdHuu5sLytlRSnWSADwmSYRCa6tXG+stvIQ88lc8ed5cBJY+gFu54jchvmxj1DrURqomIOWEtNqmiDegTu9hXfq4gHoDS4Vc0e2bXuRFd171qOWkOldWEEABlXmyWhrjCKg+hSfeuf+sj/SQRj4Da7aczM3SjTlFpP6fyAGB97ieJWBabP3066XQy1faiQs7lXnzntIWS7bjU9nU0IBNoJlVL5yL6Y5xhF5VLmGPpgFpdQ8wUMqGbMXkMHTCAMMovi1USawXqipWVJB612gyuJd1gYD2z42F5iUTSLqoZzpDvHB/EVNxmxPYMwT/ymTEb1X0FLuISAaS+0xzr0oVIlNb4Ikdbkcl8b9WAHtOlK/zdm2gVdDE1FEUIW/ejZaHTSJrWxzzWaMtDg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(33430700001)(110136005)(52536014)(186003)(26005)(6506007)(9686003)(53546011)(71200400001)(7696005)(55016002)(8936002)(4744005)(478600001)(33440700001)(76116006)(33656002)(316002)(2906002)(66476007)(66446008)(66556008)(64756008)(8676002)(66946007)(86362001)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: vAiS0+Rh25nyvksWegB6Q5tD6ono+MSra4boMC17Yb8E+baOEeIfOev0db+0nCK0FenvPqKV3TSBiuWe79SHIuiDaldPLDtRxW20104Ja1Qr2vgMAdS1TU5ng1xZ9mPhL5bYmO6F6xJeiOVXsQRyqkKBfl5jHAY4wI/Qpr81kl9xqr6avo1UU5qT4pp7voenW/Ndy1jMaSWixzOVg6pYLyH0/d7vUUy1iW8HVAEP57iPMt0VWIoebvlCbDhkZ+5giGz21Io512R+F9nKVtArdVRvv86/Ra8euDZy8jwIK8OQ3WFy6hn0UbbrBdrWDzRyWhx7y8+EtfUU9Z091sdUfF/j0k8JaB3jO/b5L9lTbQXhWSmOg7nLqV5QubvxDT7kiP+9DM2p+8sZwdKt+HWnCs6qCAujbD6WW2iOxInPIlzR6NHj7JTUvWhI+YQjuTjgSmZafMi/mbIV0Jyx8rzFOP6u1B87z0OJw9ZrDG90Wd0=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b068523d-8716-4fe1-5aa1-08d7f715e4f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2020 08:16:10.2980 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MahSc0374xgWpk0I/nOTxVI2uascGdSDIyipMJHKIhdUfq2cVe1G1b1egzaBVJkZCj9+yMttJtNoSiU7tQlWk5Y1hIL0jQ31DBrfln1VnDo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5400
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200513_011613_333550_D029D2E7 
X-CRM114-Status: GOOD (  11.48  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> On 5/12/2020 7:19 PM, Christoph Hellwig wrote:
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>    drivers/nvme/target/configfs.c | 2 +-
>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
>> index 19bd5e1c681ce..24eb4cf53b4f5 100644
>> --- a/drivers/nvme/target/configfs.c
>> +++ b/drivers/nvme/target/configfs.c
>> @@ -1146,7 +1146,7 @@ static const struct config_item_type nvmet_referrals_type = {
>>    	.ct_group_ops	= &nvmet_referral_group_ops,
>>    };
>>    
>> -struct nvmet_type_name_map nvmet_ana_state[] = {
>> +static struct nvmet_type_name_map nvmet_ana_state[] = {
>>    	{ NVME_ANA_OPTIMIZED,		"optimized" },
>>    	{ NVME_ANA_NONOPTIMIZED,	"non-optimized" },
>>    	{ NVME_ANA_INACCESSIBLE,	"inaccessible" },
> 
> 

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
