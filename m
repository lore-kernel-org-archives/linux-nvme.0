Return-Path: <SRS0=McG4=37=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8BCC352A3
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2020 16:46:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1705020708
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2020 16:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QdOp3zyX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="h5Hs0u8p";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="qveyiXgr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1705020708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=Mw3IDeVpfTgxLHmOBc9rnb15MRKQnRo3Zksq40hg0no=; b=QdOp3zyXAYFM9G
	qoSwnoSVU/Nxe/j+zh9NC/3aXfpLEldKRjZXR7cnMkj2WROSb/0sV3QpJvvSRQWT4sCPTH+y2KNw3
	7wb128L3t4vlotmYAL0B7wNj9jab0DNJxwTuRgnFa/EqPwsiSlkJx17ZsCk0NyrQCzC+cwyKc9I2A
	psVNkepRddRFSbOCJ6qVylfWQhJWeHxGh8NXTsZWvrdITGDLMXCRfLojkWFXxg+oTqy0c8ZwshM5Y
	3yXhUzCSkjAObPF4hQ1/Z3mezUUy0Xe9Niuktg0PcQHBmUyq+7fp1rc5gWot7MT3CYoN8Elu3BF8P
	zsvS7ccl4Sv8nGoCDMkg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j1Yfv-0002U3-A8; Tue, 11 Feb 2020 16:46:15 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1Yfs-0002TI-Fl
 for linux-nvme@lists.infradead.org; Tue, 11 Feb 2020 16:46:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1581439572; x=1612975572;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=3O6wx/D0mT0J+sAfw+nKPYOWxOOHYcQTYvczaet5rII=;
 b=h5Hs0u8ptJ1PjC7KpvgAQ/E8/DPGrJia/5ocQLSA9kRZPvXjndHkEeam
 oSLLuZgxNnFIhd9RNSlcSTFMtxdxzR/VV/p4nK5qWztJO5PXQGVNHvUxW
 0+Buiz3fVd8e9xIQH2VYAv4zWFhkmFRN1ufzR9TcIUKFKt8SHnL6U2ZD2
 JjHoF7twSSsdhk3kGvPVATglSDmOvZrJpjGJDNqDRfojkVoyNStKK3EA6
 KR646FRoF3QRYUdqWEknh1U5I4Bi8Hbqmua3mE1UJDigsgl5czIdnJOlj
 3Pogw/Xsh/Vy6K8PRf/pLqOdIHc8D5bG6nzUvzsF/+THnbOQ48EwPAv13 g==;
IronPort-SDR: vVXY6BEwGG7EIHcJHHFnhNl7iaTez+eS/DqI3XpAJEISgS/Apnk9JLseTKBxKBixe3RNUbeFAe
 IpAKN04JSQ/LLKTnXfZOaL5onHnnWosS3IhFEEZyHh6wqqz3H6bucROJN8OZ4Uf83U3SR5X7de
 TklYRuyeUwMc/fU6pyOaxpUaHtYr8Q40BtKtEci7SSjo2g90ujXO1gyNn11LnHR4raSdJnYGsR
 jM5rvCLCa4f7M4kCLdhMLRn8JiAJxN0EuXaca24EJ7ZdbzrUGOBeaCfVwoWA4l0k1QbZQOn1O/
 Ctw=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; d="scan'208";a="131049164"
Received: from mail-cys01nam02lp2053.outbound.protection.outlook.com (HELO
 NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.53])
 by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 00:46:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvr8T+ke5jk85/LvN9rU4zZ92ZoFonw8UBRq2UTRFHOHcTqimIFQZnrurGfw0FwKu2BRYXELqe9AssGwqm2h3eP/YO6sztmToNgs++ZzA3UOngxVTUR+pzF2ONMex2CmK7zEr6xfucApLra5UhI5/soomITRkPkzKKGxIggxX8JyEQosN2ZXKtxDpturUFOeHjwKFscHfz0UsLll9shmhkcOSh3KwCjCbbYxQ0IwvRzIQqHEIPI6k2kUD6cYzWKpAuI2SIsgop3o6ijyI9n2lmU65OB3mGZJwsozU5f5Zy3O/VgN1JJwqUDtqQ/ugEpmHIpLE9hoQHhngL3TYGcWNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HK2hSEp4jMM6v2IjJpcflPASxvwoUb96KGQqZtZgxXA=;
 b=BsdA/GPIJsP5RE5QhLas9V7AS4AmaKsjw64C97e9hFRBMCAc8vjiMRjt/o7UgrtuJci8OurLO3u96UDsd0wiLuKFnjGnz4B8QMQE33YxtFhoH1htiNjMI9TgQ/9IJz7Ap1Oc3C+Gz0FHQwDfl6abGvB2Mhw3NrDaEHjutnS+iXrjhOFnpc8OAp0p7oymB6b8JB+x0DZ6DUgWMLZsA8wQZ16Rik5Lyu2w2DPg1kSFkYSzxAyJPgk3KnCpSXQqK4NtxOzOWuSjI56b8wffpg3HSTvKA05/Qk01Ugo8xCeQM+hRfZy8434wSUHQAiw83tEj5kv3qZUuSOCPbWyBwPn79g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HK2hSEp4jMM6v2IjJpcflPASxvwoUb96KGQqZtZgxXA=;
 b=qveyiXgrVUAkR7MZstnrbQ1b97LJeAFBvI3CtSWLWTUmesPOTyOHyJw6yg4gWues133Us9gyBJQTmzr2mk9FqN0mhWxxcH/FsDOmyswTbgVsslcY1w78Xn6eoxX8oinNu3ufJVyXvX0Aq6XhDuyQvnvGfbsxcxPSJiID4kftREE=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB4053.namprd04.prod.outlook.com (52.135.216.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Tue, 11 Feb 2020 16:46:06 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f%5]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 16:46:06 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 0/5 blktest] nvme: add cntlid and model testcases
Thread-Topic: [PATCH 0/5 blktest] nvme: add cntlid and model testcases
Thread-Index: AQHV1vvxPjad+7sLRk2UwG5mK03ccA==
Date: Tue, 11 Feb 2020 16:46:05 +0000
Message-ID: <BYAPR04MB574971DCB7CF63F7A4A269B886180@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200129232921.11771-1-chaitanya.kulkarni@wdc.com>
 <BYAPR04MB5749FE36341AB61547C1218A86000@BYAPR04MB5749.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9396c376-abfd-4903-4f87-08d7af11e369
x-ms-traffictypediagnostic: BYAPR04MB4053:
x-microsoft-antispam-prvs: <BYAPR04MB405363F30133A18D6FB5757286180@BYAPR04MB4053.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:628;
x-forefront-prvs: 0310C78181
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(199004)(189003)(53546011)(81166006)(2906002)(8936002)(6506007)(7696005)(186003)(8676002)(81156014)(55016002)(26005)(9686003)(64756008)(66446008)(33656002)(110136005)(478600001)(76116006)(316002)(66476007)(66946007)(4326008)(66556008)(86362001)(71200400001)(5660300002)(52536014);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB4053;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /pWZxEeWwhnBfa1F9DGQGENZNC7lvvNUN8wW2Dfk9yZBUw/5HAvnVWNpGkT87MsvjvyUWipOdnuhKO8GXIIaLn50p3IuQKT+P5BdsqYvkS//IeJRz3KyCa2fnimALwV0qUye4T+I+6wwO1l5Ske9KJwSKFneE/pIhNU+rU8gvHZAQTeOObiJ0Z351zMjqaRzDQTANM51guWv0tPNBG5ispIARVurK5nDYGOSCIDA7DZhdV1Ff9tR//RhgsmV8CjE7pBUAa8IPxmlpRTQh8CMEWNbNanRfHKjIBJvjVN9kBLvwPnkD7tK7XyIWLNZEYr+mIUVlPjN9MTlJW78Si8R+VUlPZC0QtNJDx5j1Fnals9ywhF4GO7i26zNuCw8Z/gnmqOHvJ5Bv1fpmBFQ3umW5i5UXdKBSd8EKLDRS6huGWXj4gCC6nkC3tItCEAH8Dom
x-ms-exchange-antispam-messagedata: ySLy5kH6O/cEck+Ge+eSxNv4d1Ur4UVHqQzu4t4rq4YWmyyW5N3qgxjygvWjR86szRU70N1uLY26r646S2vGAhqovN1zmqAl4Sx8uLjk9wWr7Sq5weRj8fdxwI1wyZ4haTLLzUQ1vt64aGd6GBUKOQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9396c376-abfd-4903-4f87-08d7af11e369
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2020 16:46:05.9299 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /yd9+LeQYT1tsaYDWscRPf9yLctjhWPlKfQixmtsLT+hYfcF6Yw6dJ+iW83ogEr6wr5l+De59m6LW+y6THfwdQ5AVM+75IHT+47Lr900dMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4053
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200211_084612_569978_18668CB2 
X-CRM114-Status: GOOD (  11.21  )
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
Cc: Omar Sandoval <osandov@fb.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ping ?

On 02/03/2020 02:48 PM, Chaitanya Kulkarni wrote:
> (+ Omar)
>
> On 01/29/2020 03:29 PM, Chaitanya Kulkarni wrote:
>> This is a small patch-series which adds two new testcases for
>> setting up controller IDs and model from configfs.
>>
>> Regards,
>> Chaitanya
>>
>>
>> Chaitanya Kulkarni (5):
>>     nvme: allow target subsys set cntlid min/max
>>     nvme: test target cntlid min cntlid max
>>     nvme: allow target subsys set model
>>     nvme: test target model attribute
>>     nvme: make new testcases backward compatible
>>
>>    tests/nvme/033     | 61 ++++++++++++++++++++++++++++++++++++++++++++
>>    tests/nvme/033.out |  4 +++
>>    tests/nvme/034     | 63 ++++++++++++++++++++++++++++++++++++++++++++++
>>    tests/nvme/034.out |  3 +++
>>    tests/nvme/rc      | 24 ++++++++++++++++++
>>    5 files changed, 155 insertions(+)
>>    create mode 100755 tests/nvme/033
>>    create mode 100644 tests/nvme/033.out
>>    create mode 100755 tests/nvme/034
>>    create mode 100644 tests/nvme/034.out
>>
>> Test Log :-
>>
>> Without cntlid_min/max and model patches :-
>>
>> nvme/002 (create many subsystems and test discovery)         [passed]
>>       runtime  15.246s  ...  15.053s
>> nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
>>       runtime  10.057s  ...  10.063s
>> ./check: no group or test named nvme/0004
>> nvme/005 (reset local loopback target)                       [not run]
>>       nvme_core module does not have parameter multipath
>> nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
>>       runtime  0.057s  ...  0.065s
>> nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
>>       runtime  0.036s  ...  0.038s
>> nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
>>       runtime  1.233s  ...  1.240s
>> nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
>>       runtime  1.203s  ...  1.208s
>> nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
>>       runtime  14.572s  ...  16.051s
>> nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
>>       runtime  13.584s  ...  13.948s
>> nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [passed]
>>       runtime  9.877s  ...  10.750s
>> nvme/017 (create/delete many file-ns and test discovery)     [passed]
>>       runtime  18.902s  ...  15.584s
>> nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
>>       runtime  1.217s  ...  1.237s
>> nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
>>       runtime  1.204s  ...  1.193s
>> nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
>>       runtime  1.204s  ...  1.195s
>> nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
>>       runtime    ...  1.334s
>> nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
>>       runtime  1.218s  ...  1.231s
>> nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
>>       runtime  1.207s  ...  1.196s
>> nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
>>       runtime  1.191s  ...  1.195s
>> nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
>>       runtime  1.192s  ...  1.196s
>> nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
>>       runtime  1.211s  ...  1.191s
>> nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
>>       runtime  1.204s  ...  1.211s
>> nvme/033 (Test NVMeOF target cntlid[min|max] attributes)     [not run]
>>       attr_cntlid_[min|max] not found
>> nvme/034 (Test NVMeOF target model attribute)                [not run]
>>       attr_cntlid_model not found
>>
>> With cntlid_min/max and model patches :-
>>
>> nvme/002 (create many subsystems and test discovery)         [passed]
>>       runtime  15.053s  ...  11.918s
>> nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
>>       runtime  10.063s  ...  10.058s
>> ./check: no group or test named nvme/0004
>> nvme/005 (reset local loopback target)                       [not run]
>>       nvme_core module does not have parameter multipath
>> nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
>>       runtime  0.065s  ...  0.065s
>> nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
>>       runtime  0.038s  ...  0.036s
>> nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
>>       runtime  1.240s  ...  1.239s
>> nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
>>       runtime  1.208s  ...  1.207s
>> nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
>>       runtime  16.051s  ...  15.345s
>> nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
>>       runtime  13.948s  ...  13.977s
>> nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [passed]
>>       runtime  10.750s  ...  9.698s
>> nvme/017 (create/delete many file-ns and test discovery)     [passed]
>>       runtime  15.584s  ...  15.514s
>> nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
>>       runtime  1.237s  ...  1.232s
>> nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
>>       runtime  1.193s  ...  1.192s
>> nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
>>       runtime  1.195s  ...  1.195s
>> nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
>>       runtime  1.334s  ...  1.340s
>> nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
>>       runtime  1.231s  ...  1.218s
>> nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
>>       runtime  1.196s  ...  1.205s
>> nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
>>       runtime  1.195s  ...  1.191s
>> nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
>>       runtime  1.196s  ...  1.186s
>> nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
>>       runtime  1.191s  ...  1.192s
>> nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
>>       runtime  1.211s  ...  1.187s
>> nvme/033 (Test NVMeOF target cntlid[min|max] attributes)     [passed]
>>       runtime  1.213s  ...  1.200s
>> nvme/034 (Test NVMeOF target model attribute)                [passed]
>>       runtime  1.223s  ...  1.204s
>>
>>
>
>


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
