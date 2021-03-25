Return-Path: <SRS0=zNYX=IX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A7EC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Mar 2021 10:56:30 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FA98619B4
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Mar 2021 10:56:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FA98619B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=netapp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lW7idxdu4r8Ve8bPG++mwofb9w7tmtC0eTQeW+pUkEs=; b=cHNOXRbHCIwm4hjtIV17qkATU
	osBlpJ3oKi/P2AqQvKURZLINdcjLSwM7ZW9pxID9V5tBNooxFZAvNCCbFZekh3y4yecJHLlZu/b3z
	kovp5qQTpiq7Su5DJ5Q3dvcLV0lgSZcvTTOlxNbQ7fy0ULwjtdUIqx9sjHHU2KWsiKdm3i5WILBm9
	0fe48cycj2qZM96drX/PJ0Jbu/59G+aLneHlc98x51fheyw55uhm2vWRs5e7OiIjgZPO+teXYjM82
	+f080sOIiZevn5d5IwzAcRthjmHmHd5zf5itBHaAFyFY6MlEGpgcF2hgmU+oGuc+pVLg6JeyfoJMK
	0eeCPQ/Dg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lPNep-001FvY-0j; Thu, 25 Mar 2021 10:56:07 +0000
Received: from mail-dm6nam10on2078.outbound.protection.outlook.com
 ([40.107.93.78] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lPNeg-001Fv8-GK
 for linux-nvme@lists.infradead.org; Thu, 25 Mar 2021 10:56:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqIE8ecwapAi+bkYdA/GDd/ukFsy13MkV8assswoeGvSo+LP1WbYEew/sLmfTWQP2aTnPruW5JwNKKSvjWwlyl2TeZB6UALRe5l3wYbmTslodiM7UtRM1nYBXkgMaMZvyDjpqrQm3J3seuarL3ismw5EJKGw3oyr4FCY9IKR+m5z9gcj6cknz3lW+0ups03bytu2t7hTAsJVGqFCyQ2EP1FhTTPWUvprgWrDYlCnx9jCXTrRQdakV/EG4pSV+u6huLnFtKlm+uS3aBKJ8EonMUZvMmLfEsNSKyAJIG9RRpcXz+zdM8QPhzoFPZea4k6eSpa1WeN/HlNY0MaU2L7e4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2BSOvbJ5P38UE3TZxJgyRFXOqb6QAjHBuABZoxdc5E=;
 b=UMBeigcktxm4jfroDdB3wanbWMKtFwQBynWhcmpBMnOqbd5LO//+YN9+mg3bruw9X1j3RG44Qq4BU5JrEc1LPErz1j4wsqtGNma6o0ZHAq5KzeOJI4Zd7GpSj4Xz2EG4bxqKVH+tJgEdXh2wA8mLBLWLPQ4DtiHQZ2/eYt5bbfr6km83ERXkZWQL9AVsAgoo9WjZTTnh5M5e/PTaaGNMDE+5L2Y7TXsbvVQlTabTbsXCxYNT+50NTdzRNErAMpIpOGEpo+nf2j7Y/k7nztZ1WOfX03o8rCmVsV/KheOPujb3bk3zsu7izgmMcZNTjHmKkMyLiA+/MDLF6q7UeTPLpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netapp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2BSOvbJ5P38UE3TZxJgyRFXOqb6QAjHBuABZoxdc5E=;
 b=HIVznjjG+Jc50pIKBAX0zxDQUi/9x2khtLxVKmcf7GKuQfPl5lwZO+h1QoyunvZSrZQbJjhu3Mu1HhUh3edsMMJQ69zyfrnVsEPrQGHQohAE21O1q5kT52jc2YTc1TMA3je9RnHZNFKjGXaftoCOM4+RY8PWJhcKRSNG8ply5OuWN2tqO2UfAg4Sqm8EQ0ZlLg1Xx03j7+gS6v0jx9DsJvUC4HM9muEKTxjsD9WcCaeDY4m+udc7y3aS6WpeLkgnTa963gBZyZDoKg0JjlaP1GUPBNB2WeMvx1f6VFn0aEJ9bM0khOJT12hHXsuivtfnJeFDITW2GrnygRPh1CvkfA==
Received: from DM6PR06MB4634.namprd06.prod.outlook.com (2603:10b6:5:ff::25) by
 DM5PR06MB2940.namprd06.prod.outlook.com (2603:10b6:3:121::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.24; Thu, 25 Mar 2021 10:55:51 +0000
Received: from DM6PR06MB4634.namprd06.prod.outlook.com
 ([fe80::59f8:5b0e:ed9f:2998]) by DM6PR06MB4634.namprd06.prod.outlook.com
 ([fe80::59f8:5b0e:ed9f:2998%6]) with mapi id 15.20.3977.026; Thu, 25 Mar 2021
 10:55:51 +0000
From: "George, Martin" <Martin.George@netapp.com>
To: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>, hare <hare@suse.de>
CC: "Meneghini, John" <John.Meneghini@netapp.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "Knight,
 Frederick" <Frederick.Knight@netapp.com>
Subject: Re: [PATCH] nvme: retrigger ANA log update if group descriptor isn't
 found
Thread-Topic: [PATCH] nvme: retrigger ANA log update if group descriptor isn't
 found
Thread-Index: AQHWyxxQtO1j7+4gzE+tR4kfGcUmjKomsCYAgG6EdoA=
Date: Thu, 25 Mar 2021 10:55:51 +0000
Message-ID: <92763a7271a1eb07e28901e3e91345568202eda3.camel@netapp.com>
References: <20201205152901.56665-1-hare@suse.de>
 <cbfc78e1-87be-cc09-9b8d-44bf0659eb26@grimberg.me>
In-Reply-To: <cbfc78e1-87be-cc09-9b8d-44bf0659eb26@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.4-0ubuntu1 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=netapp.com;
x-originating-ip: [202.3.121.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4012156f-1fc2-4bc1-8fab-08d8ef7c8e3f
x-ms-traffictypediagnostic: DM5PR06MB2940:
x-ld-processed: 4b0911a0-929b-4715-944b-c03745165b3a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR06MB2940FF60A11AF3274945DB5D95629@DM5PR06MB2940.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u7aCcomR4xMQa+wlKgsmn9wE2G7Zet38DULS5e49OOiCqtDs9wu+rp7v7CS0zHr5CI9Dfw+PJFEmpRnvcpEB6zUQqVXSEls9yo7Y/rxpQua23fnVszIxijPet5wsSPBFYcFdcRqH1gXtuteB9miG+Ve2biecBUjjrBnq6tpjEq1PEOT1SyOVFglUjYsPuwSVTpoRY+pjKRss1/eoR7Ge8JXrDswQVKAM+sWQRLUQlPDciMVCSFsPZFMtbHpIpv3CuMU4bMxee+eLLdT4wLoA063de8eyTRYeNEYN20fRK/5XD9jRrHop5eZewfcGckkpVcmRMWtpDcr7I+AzpDIwCeCVfjUtBTEyNQMUgfwzSBNl3i3lAOe8znfQ2lxQRaqz/XG/n2YcKHkQ3I6BobKvSXpjJqefvlT/doLT6OVddk0UyRUX3ufGTkjc0+0A4XUpKHrxWEVBgPgeYmJtfGPzKvU83X6WFuZFFdU2QiaV4p/M+94c2qIHG5Oqoo0pdav1l8ANYYBMVrxXYMJ0IVIhMnMfKkT3TMe8/hISsVS74KlWvpYOrptHxOmwDNPUnuAHskVle83V9xY3j2EGs90m/SEImVv4f984fPePnp7cQsci7MPnk4F3BMnrcz9BjNgO3ue5BvGu2ymm/u+1VAzlBFKOJAYKGnxB15a3crmY40hDbGbdYae2/ApzrpKAcvw2WQ+rK3A3Yj9vxFVG8K0sEXylzxP+Ouchee6icWUrExoXARpRQDINQyUxQpn3JeYm4jGGO7fw29i6hwxMtV0wKtYeOQ3g0CT9goRlftMrMOI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR06MB4634.namprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(136003)(396003)(376002)(8936002)(5660300002)(36756003)(38100700001)(6506007)(76116006)(2906002)(6486002)(66476007)(66446008)(66556008)(71200400001)(15650500001)(8676002)(91956017)(64756008)(316002)(107886003)(478600001)(66946007)(110136005)(966005)(6512007)(26005)(186003)(54906003)(2616005)(83380400001)(86362001)(4326008)(15398625002)(43620500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?KzFZWndLM3A4MnRaSFIzOTMrN3ZqZ2VkdWZUOWFBaWJCbVNJV2hJTkhnQzRk?=
 =?utf-8?B?MlVDNk5CQ2ZDMVlZbTdiSHVXcERZYXZGZm1KV2NjR2hDNi9wNVZMM1I5WWFi?=
 =?utf-8?B?a3RFalRyUTVFSDVvTnM2ZnZ6QkJNakx6eDNyVURDSmVSMXVLWkV2dk1ORWFW?=
 =?utf-8?B?SnRmRmM3cHZhTWVYMHhhaDBHcEc5Yk1XYm5YK1d2OGExYnRlVG9wSGZ4cGZJ?=
 =?utf-8?B?QnRuLzVUcEJDdHJvcmlpY1BGRkNrRjM3M0g0bGRDM1haRW9sOVZyZGhEUzlV?=
 =?utf-8?B?RCs4cWU0SldpNTgyd1crcWtjcmRNRWJ5dGFlaVFBYUtaeXZ4dWxZd2Z2YXZl?=
 =?utf-8?B?YTVIZy9MZFFhN0dwSnlDdGJRL0xtQ3RXTXJWd0w4Q1VUOWFuZ1kwdnFJb21C?=
 =?utf-8?B?dktKb2RKbXlPK2ZVSDR4Qk1kbkdGVUVWUEdTWSswbjgyU0FBeFJxYlVLTmpt?=
 =?utf-8?B?cG4vSXNaZ3I2cE9ib2I4THgzcVV3T0ZTNFpPNnMybW9HTS9aRjBYaFNRbDJP?=
 =?utf-8?B?NjZuc0Z1UVVBeWt5bXcxWXZueEhxeDVCV1VaRGxZeVB1WFVFcERTNjlCUTkr?=
 =?utf-8?B?WitzK09kQk0zd3ZqMHJaRHMvN05FRFJTWUtBenBnbmswamRKYml4ekU4eDgz?=
 =?utf-8?B?eTM3RkVvU3Nlc3NlZWw4UWpqaHNCZjErOE1YTk9tVld2NlJyWHVJdzg5UDJX?=
 =?utf-8?B?dDJIZGNpVFV0V3NWY3F3V2hJQW94QmhhV1NZdmQwbUVaTWNBRXZIb2M3VUNn?=
 =?utf-8?B?Mzk2QUhRTG9rSDRScmV2RDNxTXByUnVSenhvNmk1bXR2a3NWamE2ZUFBOGVa?=
 =?utf-8?B?YXVKRzlPcGdhdVN5a0Ixbi92S0RtaXcwVXhGT0lPRGZFc2JkWGtFZ2NESC9i?=
 =?utf-8?B?YVZ2S0hEZ2F5MUF0MDI5dnNVVVpDUTJhNDNDUFIvNTUzdlNmelJjdC82RW51?=
 =?utf-8?B?T09RY05DWGRZVmhMY0NGd0VTelI3NXRMNEtoa01La2VFYktIald0bVZVcWln?=
 =?utf-8?B?UmFrNkNBOThNZWhVUmpkQXRNTVprUU94blIzZGd1Q09ZZk8ySzErZWt0UUc4?=
 =?utf-8?B?MndaeWRqckdJcnBPQnpyT2VJT3RDeUFVdHhxbkJrdUFkOSthVFBFc2t3Um9B?=
 =?utf-8?B?ZHZzSXJPZm5MQ043Szg1bktNYmNjVkk0bVFwb1ZCWktFRTl1TG5ZMHpUejlz?=
 =?utf-8?B?UWkyRkIrRi9xOUt4OFZDdGtrRkVaUlZZUWVRODdRQ0c0US8zemZPdTVGVG4v?=
 =?utf-8?B?WEVuOVBRL0NzSVM1US80cmxqZXNHZ3lCYk9BbklUWHBNMHdxcnNtV25Tamgw?=
 =?utf-8?B?NTM5VlF1VFVKeVJoMzU2UUhYODBGU1EwZjk5N0VxS3BHWW5YeUNMWjV4bUVr?=
 =?utf-8?B?MG00bUFUZVBpZ1VvUEJLdzhSV2ppMCtPeitKTERQY0dhelBrVU9iY2UrWHdZ?=
 =?utf-8?B?eGphMFVJMnJiS24xSTdEdWZVTGxoYXlzeCs0NUkxMDRUdzcySWxEMFNhakZ2?=
 =?utf-8?B?QmFwZmVESHNqL0xKclNzVnVXRWp2NWVrd0oyMFpUUnFjdjlSZ3o2RnlxS3VR?=
 =?utf-8?B?d1NnZlpRUk95d0F5UkZGZFlQaDFLdEloMWZ0UCtyWlVyT21Gd0w0Vm9GY1hS?=
 =?utf-8?B?dXQ0eHpML3lGVGxTeU1sVjZiY05ocXhCU0dhSldQWVBNcldieEJjUmMvSDNK?=
 =?utf-8?B?R0QxVlkwZkFCbHA1U3ZMakk2T0w2WHQ5a1kwR0VTZkhJbDc0NkcwVnBCM2ZX?=
 =?utf-8?Q?mO8sW6noPXaRixpWQQgoVIu75vrzEcPi7SB3jcJ?=
Content-ID: <01A8046A9995484FAC0F590C75661B4D@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR06MB4634.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4012156f-1fc2-4bc1-8fab-08d8ef7c8e3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2021 10:55:51.2999 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WWTdYM0khyvBQr4Cm3ujjbO/CkgOtpO8zaYBbKWy1iB5AwfIet59dW86AHCFPMdYRE1X0LPmWXmOlheJCPHoPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR06MB2940
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210325_105601_007940_AB89A059 
X-CRM114-Status: GOOD (  24.72  )
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

On Wed, 2021-01-13 at 19:13 -0800, Sagi Grimberg wrote:
> 
> > If ANA is enabled but no ANA group descriptor is found when
> > creating
> > a new namespace the ANA log is most likely out of date, so trigger
> > a re-read. The namespace will be tagged with the NS_ANA_PENDING
> > flag
> > to exclude it from path selection until the ANA log has been re-
> > read.
> > 
> > Reported-by: Martin George <marting@netapp.com>
> > Signed-off-by: Hannes Reinecke <hare@suse.de>
> > ---
> >   drivers/nvme/host/multipath.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/nvme/host/multipath.c
> > b/drivers/nvme/host/multipath.c
> > index 74896be40c17..ee4a42dc99a0 100644
> > --- a/drivers/nvme/host/multipath.c
> > +++ b/drivers/nvme/host/multipath.c
> > @@ -667,6 +667,10 @@ void nvme_mpath_add_disk(struct nvme_ns *ns,
> > struct nvme_id_ns *id)
> >               if (desc.state) {
> >                       /* found the group desc: update */
> >                       nvme_update_ns_ana_state(&desc, ns);
> > +             } else {
> > +                     /* group desc not found: trigger a re-read */
> > +                     set_bit(NVME_NS_ANA_PENDING, &ns->flags);
> > +                     queue_work(nvme_wq, &ns->ctrl->ana_work);
> 
> btw, I just commented on the original thread, but I do like this
> one better.
> 
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> 

We now have a ratified ECN which clarifies that a NVME_AEN_CFG_NS_ATTR
is sufficient for announcing a new namespace along with a new ANA
group, as opposed to additionally raising a NVME_AEN_CFG_ANA_CHANGE as
well for the latter - available at 
https://nvmexpress.org/wp-content/uploads/NVM-Express-1.4-Ratified-ECN.zip
. I hope that finally clears the confusion on this topic.

So could we now have this patch pulled in please?

-Martin
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
