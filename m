Return-Path: <SRS0=+1uq=AT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972B7C433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jul 2020 23:28:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D8BE206F6
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jul 2020 23:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tq5Iq9/O";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rugSGPzh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ZoCLB6VS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D8BE206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=ESct9oUk/VtomQ70UQ7A3UJU7o4ZSNTHURDC2XSdxSA=; b=tq5Iq9/OF5jI7/Hv68n99h9W1
	tiZibb1VrnYA8QfT6PebgHEvZDRTRU2pXOEvqkAv9dubYncfKGObPWpMUXKi+Lhb/YxPb9k/eywe0
	+hiXrhQeVk1i4HJQlr1JmLdH8wvwHv/RFsxN05Y3VVSdSioYUExdaYpdUDcU5SmEjHmfWpVsqMmb1
	otxUVA7ZMLv4TuYPCbyC7lf/SvT58KOqX1wzrx6EEknHrH8gucMzzkL0s12BT3/PfW3C7z0UjWi+Q
	NUYav9B9Jv1F/ttI9aCz23p5NfkzEagbJn6/QzesvLO5Ub4UK8y8PQZBu52QtvJ6/4jRhStfe1Llo
	pjtrcxnaA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jtJUH-0006LJ-Ta; Wed, 08 Jul 2020 23:28:25 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jtJUF-0006Ko-T8
 for linux-nvme@lists.infradead.org; Wed, 08 Jul 2020 23:28:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594250903; x=1625786903;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=NdbBy7UMXzinLoAThRUq0K3We6uk5E9+dVMg/KektmM=;
 b=rugSGPzhAzv9swzO7Y592Ze0fVTAOHreZjRuJ2FV/3OrPUzQi6v9nfrx
 hZ+x9ceAhQeecSi4CuDNNqkcQfAEkbFSq5HvaFlkdFwBclWNJEdACNDM4
 hJhr7LWyClkvyO6JJ0YB/z/G9XsgaugvcPxUX5Kum6fHJoA3KpLxbnp4Z
 8FI5/Avsg8abWBhFvmaSt1jqzv+TvTfq5ckQ/39C4HUDQXEkto1kAD865
 /1CkRUIbTYddYx91ZNf7cZISd2jcevhVtMI+kwJglDgSxfrZ4tCW4aujl
 2MjnP8LmqQMb5nFo8RkHN1ue5HPB517RnB9/Cf3UUqwfyPnJ7YPH7xHB/ g==;
IronPort-SDR: igzKIjp/TNk16z5mfB1zn+XWp4hfTYwOl5mSmT5y7KlGSs9me0Mxhq0CRyFQof3Mz0bHIN9ytY
 VKeRgwFhRysCg8TLxzPrq2i4JrG2xVC2ytIXLTCwZX51uTMDgJkhZ0qTnCyfRitMeUnj1cMcwe
 yxG4pZINuJM1Kwum/DPs8fqkSd7hTMyOFjTsLHIUMC2bGk+lmJDCxR55tc9ol5ovT6aPHjnv+i
 +But0+v3+kG54N2/Vq+wY3JSQ9+orK6c6WmUwFGs3XDHtFdpMufhIbMJDgudWlX+PKZjLgo5/N
 pY8=
X-IronPort-AV: E=Sophos;i="5.75,329,1589212800"; d="scan'208";a="251209363"
Received: from mail-co1nam11lp2175.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.175])
 by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2020 07:28:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HXCLZ0M574Sk8mVazKefJvFR52+CPv6HdZXdrStVq2GpJC8GUi3BDvfycOrJVeCLZx/B/X1CeR9MSQX6cp8QE0N+82X8rzvMlh5LLsH7Ou3WIr+6tJz0JD13kSv98+XRaei6vXTg/vmptK7edqXt+1bMFvt/UGnRgkKbtrZsJfqtbRO8KJrOHMb8TOhb8rxeqoh4VuNbCgcRfhTCfCnzJAIBT9/SEBe2WXKqI7WgGDrIbUFYftwMFILeYwxy9PpmViRRuE90u7bAXTzukOK9jVVzOpQfL+9AMxkO9u+k0LID15kZwhDEes58N7dio6SVsepLOkWNVaRTfXzRtFl7+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NdbBy7UMXzinLoAThRUq0K3We6uk5E9+dVMg/KektmM=;
 b=Li0duABsw2GOjikzul/h2dlUC4SPhpIxyg/ka4cLSTVY21Xa4Cy8hrpYuIFXxo+9l47ROn8hyZe8vYgKBtxwPxzH4KcZD+3BlfleHGPIACJL7jc8RuYS84dK5lZtq+muaqFv1jOA5fvOxNN/3eBcniTUkF9mhI3a2WAEuHLuoBj4KXKnORYPBG1aOgd2ZWjZvJypuFUdMPYAYDgCOaHAsPadnof7PJKDti/HxzirCjpaSgFqGor+xKQHlk4Va3FifdEHg4jM49gOLcihM+8Bx0FjWk7F3B6ZTrsawrZimctYuYECYu3ut6npoH6opBxpG75HBi26mw0t3bEfRoAy8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NdbBy7UMXzinLoAThRUq0K3We6uk5E9+dVMg/KektmM=;
 b=ZoCLB6VSmirdKFQZguUfLU6Rh6+2bEEy5sPXTHAoMZYDqYgKeLbTtaWsJK1cKXTCoOT0sBnxCzwgWUOC+r95T18+ORMKGXnypnoOE1iiFzp63kit/n42HzxGVxtsqupv6nyBC78mC9m/dBuSLkJ6adcqYZdRbxeMQ197TQoew8I=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6898.namprd04.prod.outlook.com (2603:10b6:a03:22a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Wed, 8 Jul
 2020 23:28:18 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3174.022; Wed, 8 Jul 2020
 23:28:18 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/4] nvme-core: use macro for ctrl page size default value
Thread-Topic: [PATCH 1/4] nvme-core: use macro for ctrl page size default value
Thread-Index: AQHWVMLuQo61zBFLpU2CazaefjjE5A==
Date: Wed, 8 Jul 2020 23:28:17 +0000
Message-ID: <BYAPR04MB49658CBB21A1509703E1B65D86670@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200708005831.10013-1-chaitanya.kulkarni@wdc.com>
 <20200708005831.10013-2-chaitanya.kulkarni@wdc.com>
 <20200708222303.GA2288916@dhcp-10-100-145-180.wdl.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8b331c7e-b64d-44cf-b963-08d82396985d
x-ms-traffictypediagnostic: BY5PR04MB6898:
x-microsoft-antispam-prvs: <BY5PR04MB68983063EB9DF05FE170746586670@BY5PR04MB6898.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KU8g+eIMrqu8GNc1waupjcUCcvmy61a7jMcF19atdCRcLed8q47076rlOMX8iuRZkOvqnVbTbsK2rDNTY+9sxXIJnx1oy3oNknkU54XUVvpH18RIyOr7hU+UUkLpyaTneBru+uUFSxketAA7Cf//Od1alnOPS3Xg64YcxjhG+jswO0QCSRr1NjiMpFwfJXer3crokVKIrg/Wrh8/MgK/83Gn4IyZH2NJaynLn/wd2P6HJplSgUUDo7f4buBvVmE1CDqQl1Z7ZSnQrBT9vRlH6Iv5+rxyZJaHpvOuz9ZBRYr75MxKe2WHyCVwJaOMP5ma/YAzTGXXWJXrei/aHDJymg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(136003)(396003)(346002)(39860400002)(478600001)(8676002)(66556008)(5660300002)(186003)(26005)(9686003)(4744005)(52536014)(2906002)(4326008)(33656002)(53546011)(6506007)(55016002)(71200400001)(86362001)(54906003)(7696005)(66446008)(64756008)(6916009)(66476007)(76116006)(66946007)(8936002)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: WjHdCpDfIpgp1R50SyELb5Ugiku7jdHN1827JROGEWkpuZZcpLSU2OAQuOKbmhAESJzQx7nWtFVTmASbw4Jqhsx27LJZ0sIJXf308E47EyiA4d1GpMbivBZH92qKjXYEHM9qkbuvhhmo86IfcoKY8N7zi02tuDmbnSGGc8LMaBCsgHhU66XSL07BlEMbW4pq1LmNkVRI2QZdqCM5wt5OXzSU/7bifvjmR2spo48WQm6G/XwCjF0XST9+6QfnmrJ+vwYmDrEPLlmKdx86KVK3vkGkHHeeCqJjFCYBZaS8+Vjgw1ZePKzgWNCKYS27zr8dEYvm6vCSRAscpZPQ3lwRgOhwFvifP5N4hAtOP0EjERtw+6uqMqfQh+EDMndF0en9Rj2eMLi18QseHDioMGTIXlitGcXZiA+HyGZpWwT3GX97Uv+25gfdGHakRyV1KWUrqpewHC8pmVD2hc/7UIsJaHg+d5VOzubCN7O5+k7p4AI=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b331c7e-b64d-44cf-b963-08d82396985d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2020 23:28:18.0121 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dEAC111ef5rHf8GbGDzEDRr97oYXnatCHDlQbu4w+kZy+xVtEmJuBGFCKPWDXS/C8qzc5mu9DkVod4P96AQ4t8XKrpATehoxcWq2KdiQbOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6898
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200708_192824_265299_ADF28466 
X-CRM114-Status: GOOD (  13.35  )
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
Cc: "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 7/8/20 15:23, Keith Busch wrote:
> On Tue, Jul 07, 2020 at 05:58:28PM -0700, Chaitanya Kulkarni wrote:
>> This is a preparation patch which is needed to centralize the page shift
>> value for the have ctrl->page_size.
> At this point I would recommend removing 'page_size' from 'struct ctrl'
> and use a #define NVME_PAGE_SIZE in its place. There hasn't been any
> attempt to work with different page sizes so I don't see much reason
> for keeping the older code to support it. As an added bonus, a constant
> simplifies several calculations in the io path.
> 
Sounds good. I'll send a V2.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
