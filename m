Return-Path: <SRS0=u6WM=6K=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209CBC55199
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Apr 2020 10:50:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E68B22071C
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Apr 2020 10:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EwmRBxUt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="g/cMvscY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E68B22071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RE7gXKqz+2AWwd63WkOwphQoJ8Wo/3u0Zs03Q4Fyhi8=; b=EwmRBxUttaXu8hu175pYZqZ1G
	JsZOET38czFBpcBwJlUUxLNJ6y2TQ+3jxp/hnwY+1Na0i/60nVSd6MbAmKlPiGdtE5amjCPZ+Pvy2
	6URLMhuQRouJ3oI6CcVJuGKuDSqSt+ZsPMYw3eMPfjdqb5i7kwIP8tQaynNAb/HmDwYf0/Qf1R+3+
	9dBZHpxLXehcKowZClswL5rsRV/ZGLeoCBHQCI7JaCLNOJ/0RfW6dOIxl1pSwuQaOOxn35D636tLW
	rLLORc3Jt96LJkZEklwCK+XzS6NwI44MFQAqo72pj3s3OoMlI1wc/y8TyuRc/Iz5Hdjrd2ZnOX6AA
	lH+CS/cHw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jSerc-0002rc-9h; Sun, 26 Apr 2020 10:50:20 +0000
Received: from mail-eopbgr00076.outbound.protection.outlook.com ([40.107.0.76]
 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jSerX-0002hK-Q0
 for linux-nvme@lists.infradead.org; Sun, 26 Apr 2020 10:50:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bOB0kIz5wkIzEZDV1deGNAZGM6AGJXi8f7mAYBxPdOiHoqAv6wR4ybDV0YS+8JbPgB1aO3LmPgymlIEWFBLWn+6/8TVb4RIukJFuB1v6KoRBBDLjuHll6GXVgd+0gLAVu4WwF2C4Sw5uLVAiGhSp5sqd3yzP5cy5Uv3K1AskypfPnoYbs3zaQ2yakGEtNNveKhKt46XTNPA7kegwTBQkBAjj7XB04s62sTeLs2+h6/uEZcj7/37bFBjVwkMk7wcrmZ6gMIAZM1o0gBkJXKOptyPPdPrWFwOQfwDrRnEpX7WtuY43BNsFvn1OTlMC13xqEmKegyHqWhUirRdSQWMXYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4Z4vqG8/wiFgPOkBS/B7XpedqHDRL8Ip9+gP48Y9U8=;
 b=aJMDkuPNtfdDCUztuUj1CMQEk/EiqAKIFo+sSe/jX4vFxG0tKKil74O686F69mXjYRt+23ui3VTHGQ0qQmaUppt/lxPZdeDFF6ToBtSt2Kqwr9CzZKdMI3h46HddsMYzyAuTtMmcPvSGjpYyh0XO/g85Qr7qYMJ5PKYgtCHhJVtU+X/Vyss3vjIyeKXdx2Q2QoyV5TzA9n53W6WJXRJseqhyn5s/YWniCD84AkIkmh449wXkYiUNET81f+1qXWgjil/LgXnHT9Ac6QIn7VGlVoV7a+LBbjHUiw37Y2jxWM+G+cGRugVUS5kC+4hdmCwozBgZADMSWpCj1oGNC3mDtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4Z4vqG8/wiFgPOkBS/B7XpedqHDRL8Ip9+gP48Y9U8=;
 b=g/cMvscY+K5SB5UN9Ik3yZ1KrhxZ/gQk64SSyOZivolZB3bbKVyfmrPovCMIJBcF64895TIOUq0qVm7P1/KSZmifPWBirXJOKLaI2mq0yf1RyrwXfGa50OQ7Hm0UPUSKXZw/rdcfI7XgRzL1ObDpy2QZlaSyFU+bKLLEH/03BQ8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=maxg@mellanox.com; 
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB4244.eurprd05.prod.outlook.com (2603:10a6:208:58::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Sun, 26 Apr
 2020 10:50:10 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4%5]) with mapi id 15.20.2937.020; Sun, 26 Apr 2020
 10:50:09 +0000
Subject: Re: [PATCH 14/17] nvmet: Add metadata/T10-PI support
To: Christoph Hellwig <hch@lst.de>
References: <20200327171545.98970-1-maxg@mellanox.com>
 <20200327171545.98970-16-maxg@mellanox.com> <20200421153045.GE10837@lst.de>
 <0c6caf5b-693b-74af-670e-7df9c7f9c829@mellanox.com>
 <20200424071433.GE24059@lst.de>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <9da15ad2-ed9c-9a00-4781-b57712835b3b@mellanox.com>
Date: Sun, 26 Apr 2020 13:50:05 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200424071433.GE24059@lst.de>
Content-Language: en-US
X-ClientProxiedBy: AM4PR0101CA0083.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::51) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.7] (217.132.59.243) by
 AM4PR0101CA0083.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::51) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Sun, 26 Apr 2020 10:50:08 +0000
X-Originating-IP: [217.132.59.243]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 639caa44-8f62-4630-5c8f-08d7e9cf96f6
X-MS-TrafficTypeDiagnostic: AM0PR05MB4244:|AM0PR05MB4244:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB42444511A47C7B2F251C541BB6AE0@AM0PR05MB4244.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-Forefront-PRVS: 03853D523D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR05MB5810.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(53546011)(86362001)(6486002)(16526019)(8676002)(31686004)(4326008)(81156014)(52116002)(2906002)(956004)(6666004)(2616005)(8936002)(186003)(36756003)(66946007)(66476007)(478600001)(16576012)(107886003)(316002)(26005)(66556008)(31696002)(5660300002)(6916009);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gY9G2g4jvd7rN/q9CjO70aGdZPusenqUtrfyuh4ibQJf66l+pmEY0TWuLnh5FkY2gNImwwjrrjjmDZmdPfJZfnYoRG51jiPMD0pPATbUMWh5/aFZRwDbRPVskoRtiBb5W8V+mAD2ZniNOfBvwdc/8toWYBjVonz2PUKKRX3I/gQFyp3JBIc5qvqvYwy/ULw7TKZF929kdvo6xHik83uzsjKaA9LpVjZZXlGqGpvH32ZwmVVvawCa0zDEON7meC1wyd2+ocLYgunNyhTVECaixTxhHJV6AKlu4LNFcLPLbMKsNz7GyPJMTdT7tWduAGguelnN5q03rG2W9c8+Oz95qEVl0JdlQFLddqDKqLqKkfJhVWTdzkzWJGR4WP4QDg8dOYRPcYkYBTKlz8CBC+xzdZr+MwLbCdW1MSpm3MKWGZq2Ij6wtUWfeO07YMR4sSC7
X-MS-Exchange-AntiSpam-MessageData: StMVGyRknFr8T9dyEGPlU+TUI8p1EV55HLO5SFNri3BSrFc/aWJ4T/ZRPK11phgX4gcLhpbSCVdG9DCTqq7zLTZpsem38+KjNSaX3oV92je4gkwK4PmoGiQmOc6xt9Th2ZN99jC9LPkSXFLD2mG33Eyd7NNth3khRvTHYaidEmcTTuxzGqvQMvWPcOi/eetEzNSEA6uss7n6ICGMLonYaRyXYWYm54LnDLW3mpRa15yfPhdPUX3608tcoQQ3p5+ZL6UhWCqj1F4Om4lgkF6XDRVaiwh8rS5ij1fuBGv/Es4LdJWTQbYPz+XJlAZMf9qpLtOu8WyfpCVUpMNnGcwLo88+QCDkV/q9pnkvNmFbSgvzKhPVhfGTzKx0f4Mn3+aygGRypglz5BKE7MzQiyGiWLaMqRfv7r3owMayV1JVB4QtCBAIPfKzbE92s4LT2C2PQcV3PYNwd7uopILHhP+JPMzPWDzUpcZiGD8WcpTL6vJEZbhIcz60p7IE7CeFuriltLckovTv3RB5I0Ab959ORYZ2CllpYLcp7uxTT5eZiY4htwNFt98p9115tVnWGv9DLn4T/kbEUS8Px8udQeKVZhoh2FmkOCtXd8qhhqFOoGwfU2q/2nSUrUi9nZGcyvU2BvfqxjqCi0JJFNanzIri6D27B+ngaAhHlpLQq45XQoFNUGUp5Emib2DINEhQpDydtntKxPJJS2PttePFPSHzkd7YS/mZmypVgA0LHUNADywo7sFGjdUlqm7rnvHCv7dh+EtOSuNHKwDqNcuQkmLf5WnxIOPSTWcI/RQKuNB22yo=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 639caa44-8f62-4630-5c8f-08d7e9cf96f6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2020 10:50:09.8423 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zjsKIGW0kIxvL+vWM6ySXls1TKRvghNCRhIegdMII5PjTaMua0dJln8tKf5k/W20LYcGP0jQTet0m9fdT+Kh5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4244
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200426_035015_934652_C83AD51C 
X-CRM114-Status: GOOD (  12.94  )
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
Cc: axboe@kernel.dk, jsmart2021@gmail.com, sagi@grimberg.me,
 martin.petersen@oracle.com, shlomin@mellanox.com, linux-rdma@vger.kernel.org,
 israelr@mellanox.com, vladimirk@mellanox.com, linux-nvme@lists.infradead.org,
 idanb@mellanox.com, jgg@mellanox.com, oren@mellanox.com, kbusch@kernel.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ck9uIDQvMjQvMjAyMCAxMDoxNCBBTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gT24gVGh1
LCBBcHIgMjMsIDIwMjAgYXQgMDM6Mzk6MzhQTSArMDMwMCwgTWF4IEd1cnRvdm95IHdyb3RlOgo+
Pj4+ICsJaWYgKGN0cmwtPnN1YnN5cy0+cGlfc3VwcG9ydCAmJiBjdHJsLT5wb3J0LT5waV9lbmFi
bGUpIHsKPj4+PiArCQlpZiAoY3RybC0+cG9ydC0+cGlfY2FwYWJsZSkgewo+Pj4+ICsJCQljdHJs
LT5waV9zdXBwb3J0ID0gdHJ1ZTsKPj4+PiArCQkJcHJfaW5mbygiY29udHJvbGxlciAlZCBUMTAt
UEkgZW5hYmxlZFxuIiwgY3RybC0+Y250bGlkKTsKPj4+PiArCQl9IGVsc2Ugewo+Pj4+ICsJCQlj
dHJsLT5waV9zdXBwb3J0ID0gZmFsc2U7Cj4+Pj4gKwkJCXByX3dhcm4oIlQxMC1QSSBpcyBub3Qg
c3VwcG9ydGVkIG9uIGNvbnRyb2xsZXIgJWRcbiIsCj4+Pj4gKwkJCQljdHJsLT5jbnRsaWQpOwo+
Pj4+ICsJCX0KPj4+IEkgdGhpbmsgdGhlIHByaW50a3MgYXJlIGEgbGl0dGxlIHZlcmJvc2UuICBB
bHNvIHdoeSBjYW4gd2Ugc2V0Cj4+PiBjdHJsLT5wb3J0LT5waV9lbmFibGUgaWYgY3RybC0+cG9y
dC0+cGlfY2FwYWJsZSBpcyBmYWxzZT8gIFNob3Vkbid0Cj4+PiB3ZSByZWplY3QgdGhhdCBlYXJs
aWVyPyAgSW4gdGhhdCBjYXNlIHRoaXMgY291bGQgc2ltcGx5IGJlY29tZToKPj4+Cj4+PiAJY3Ry
bC0+cGlfc3VwcG9ydCA9IGN0cmwtPnN1YnN5cy0+cGlfc3VwcG9ydCAmJiBjdHJsLT5wb3J0LT5w
aV9lbmFibGU7Cj4+IGZvciB0aGF0IHdlJ2xsIG5lZWQgdG8gY2hlY2sgcGlfY2FwYWJsZSBkdXJp
bmcgYWRkX3BvcnQgcHJvY2VzcyBhbmQgZGlzYWJsZQo+PiBwaV9lbmFibGUgYml0IGlmIHVzZXIg
c2V0IGl0Lgo+IFdoaWNoIHNlZW1zIHByZXR0eSBzZW5zaWJsZS4gIEluIGZhY3QgSSB0aGluayB0
aGUgY29uZmlnZnMgd3JpdGUgZm9yCj4gcGkgZW5hYmxlIHNob3VsZCBmYWlsIGlmIHdlIGRvbid0
IGhhdmUgdGhlIGNhcGFiaWxpdHkuCgpUaGUgcG9ydCBpcyBub3QgZW5hYmxlZCBzbyBpdCdzIG5v
dCBwb3NzaWJsZSBjdXJyZW50bHkuCgpCdXQgd2UgY2FuIGRpc2FibGUgaXQgYWZ0ZXJ3YXJkcyAo
aW4gbnZtZXRfZW5hYmxlX3BvcnQpIDoKCivCoMKgwqDCoMKgwqAgLyogSWYgdGhlIHRyYW5zcG9y
dCBkaWRuJ3Qgc2V0IHBpX2NhcGFibGUsIHRoZW4gZGlzYWJsZSBpdC4gKi8KK8KgwqDCoMKgwqDC
oCBpZiAoIXBvcnQtPnBpX2NhcGFibGUpCivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBv
cnQtPnBpX2VuYWJsZSA9IGZhbHNlOwoKCj4KPj4gVXNlciBzaG91bGQgc2V0IGl0IGJlZm9yZSBl
bmFibGUgdGhlIHBvcnQgKHRoaXMgd2lsbCBhbHdheXMgc3VjY2VlZCkuCj4+Cj4+IEknbGwgbWFr
ZSB0aGlzIGNoYW5nZSBhcyB3ZWxsLgo+Pgo+PiByZSB0aGUgdmVyYm9zaXR5LCBzb21ldGltZXMg
SSBnZXQgbWFueSByZXF1ZXN0cyBmcm9tIHVzZXJzIHRvIGdldAo+PiBpbmRpY2F0aW9uIGZvciBz
b21lIGZlYXR1cmVzLgo+Pgo+PiBXZSBjYW4gcmVtb3ZlIHRoaXMgYXMgd2VsbCBpZiBuZWVkZWQu
Cj4gSSdkIHJhdGhlciBrZWVwIGRlYnVnIHByaW50cyBzaWxlbnQuICBZb3UgY291bGQgYWRkIGEg
dmVyYm9zZSBtb2RlCj4gaW4gbnZtZXRjbGkgdGhhdCBwcmludHMgYWxsIHRoZSBzZXR0aW5ncyBh
cHBsaWVkIGlmIHRoYXQgaGVscHMgdGhlc2UKPiB1c2Vycy4KCmhvdyBhYm91dDoKCi3CoMKgwqDC
oMKgwqAgcHJfaW5mbygiY3JlYXRpbmcgY29udHJvbGxlciAlZCBmb3Igc3Vic3lzdGVtICVzIGZv
ciBOUU4gJXMuXG4iLAotwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjdHJsLT5jbnRsaWQs
IGN0cmwtPnN1YnN5cy0+c3Vic3lzbnFuLCBjdHJsLT5ob3N0bnFuKTsKK8KgwqDCoMKgwqDCoCBw
cl9pbmZvKCJjcmVhdGluZyBjb250cm9sbGVyICVkIGZvciBzdWJzeXN0ZW0gJXMgZm9yIE5RTiAl
cyVzLlxuIiwKK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY3RybC0+Y250bGlkLCBjdHJs
LT5zdWJzeXMtPnN1YnN5c25xbiwgY3RybC0+aG9zdG5xbiwKK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgY3RybC0+cGlfc3VwcG9ydCA/ICIgVDEwLVBJIGlzIGVuYWJsZWQiIDogIiIpOwoK
CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgt
bnZtZSBtYWlsaW5nIGxpc3QKbGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
