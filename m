Return-Path: <SRS0=o8oB=PC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CC8C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Oct 2021 04:42:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92AF4604DC
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Oct 2021 04:42:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 92AF4604DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D5f6otzX/eXRYOTbYA6Fp/mgkxDWLzJRA9MtgNvJ2fk=; b=2jcKt+b84oTyprWm2a7/RlOtX8
	Kxvew4qic0YUoUs0VGF1gb0u3GtykC/YJmmu67y/C/7WfELlmL+d5OhOh6Z7/OSDAij+MGg7QXvXF
	sYzoQ6gU7I8vMS56k2s9NmT2YSVEaQrTyB2U6e30laDx38EMTRZ43jwa+/rdFup+iBihJnyM7r1xM
	2TgWTujPMZNfd0MaYfwG6h7gSc6woUmQmxqevOFNAUkKWzmWFR9BqtRQFvnMGdtkss0rCICpPuoNa
	jeuNRZu0uIkBp4kG+68wqrqZQIAv2nqOXeVRj+sQeiYL6D2uKXW55Aob23eL9F7q4SLTFLE22sw/q
	kpjf62qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1masZV-001X1f-0x; Thu, 14 Oct 2021 04:42:25 +0000
Received: from mail-mw2nam12on2063.outbound.protection.outlook.com
 ([40.107.244.63] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mamsh-000tjn-2O; Wed, 13 Oct 2021 22:37:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLSPD2PGO6dHxVVAdg4tretcqqxncAjX+4iOvKHjzmVaw1OwBZnxR5y6oAwipYytTa/NBkP1do7WKVtS7W4W86Ao0ORMtS40Ql5HDWcuoDYkXKrIKmQkosy3sfLHDsLIR3aosN2m2PQ43GPsK71p2UaWdsbbkV9Hvsc//AxVZwiwXuk/Utk/vC45luELoh6wYVaQoZxBSp2L2bCE0J/L8qNvkNwQL5iFPmffkT70OEPeiuTuhynIKjhBvPcc4tkQFt/4nXEwV/uqKyfyli9/4Qw2f+gmVLnEgMja+Pbq77a7GeLAt6GiZNZehTnLh1FShPBHGy5XdJPA8DGZD1QDKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5f6otzX/eXRYOTbYA6Fp/mgkxDWLzJRA9MtgNvJ2fk=;
 b=mjoMsIFYDxYKZEKAZSLI/UQLuciHsS1kIGfkMdvB8fUzFnJNYGkK3hGbIvOjVIp0eMpXOdMSrF9Dk8LqFuWntABAe7TGknw0zejBKq3miCiSALkoBGzoRWyoq0NTr7RMYH4fJ9UKf9lZH5/PADBz5+4k1Q7dDfXi1cNT904C2PYyxKXplnH7PnqOqh/YSCtigc/5gsdLWnPvfP+atMuOntKRJn0NaMjyym+rmPMLo9mdzLTSfyvbfEuWMtyRQxgDL/f+1bidZdRfUDEs2Wo3lQFPpRZzYQmbIJJ4uFNzaoDUdS/zjhqWUNPYggybdEw/nYkvJp6vzpV4qFUjjnSgeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5f6otzX/eXRYOTbYA6Fp/mgkxDWLzJRA9MtgNvJ2fk=;
 b=jnyvIjRMceCOQVoy0C+7er67MVrOBt7AazIqO4shXdhL4L8mWkpvY0Dvup/tvlpjVRxn3ZxnwABgr63UBtczKjWSXHP3JjnXFIw6uVflje1EXvNb8GVKicg2g/dE3eacI9TvHfak1efX5UiaF7BuVFkXEz91Ehxq3wgouVlIwpk5s/Yv4RvHAPVqP+BE5O1TGw2c21c8IMNzPIrgHaDNzCO/5mLH3xf9dcybUvmLEn9NbML26wbo0PDbDCsEpOSFwnhD8LtnrgFhU4g9lzcPENPvF5t03ITMsUEtKE+9zwdM1itkSvAM1/PIjwAtgrcmZLgr8rqb0ziAGkKpVZY26w==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1472.namprd12.prod.outlook.com (2603:10b6:301:11::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25; Wed, 13 Oct
 2021 22:37:48 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 22:37:48 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>, Song Liu
 <song@kernel.org>, David Sterba <dsterba@suse.com>, Josef Bacik
 <josef@toxicpanda.com>, Theodore Ts'o <tytso@mit.edu>, OGAWA Hirofumi
 <hirofumi@mail.parknet.co.jp>, Dave Kleikamp <shaggy@kernel.org>, Ryusuke
 Konishi <konishi.ryusuke@gmail.com>, Anton Altaparmakov <anton@tuxera.com>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Kees Cook
 <keescook@chromium.org>, Phillip Lougher <phillip@squashfs.org.uk>, Jan Kara
 <jack@suse.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
 "dm-devel@redhat.com" <dm-devel@redhat.com>, "drbd-dev@lists.linbit.com"
 <drbd-dev@lists.linbit.com>, "linux-bcache@vger.kernel.org"
 <linux-bcache@vger.kernel.org>, "linux-raid@vger.kernel.org"
 <linux-raid@vger.kernel.org>, "linux-mtd@lists.infradead.org"
 <linux-mtd@lists.infradead.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-scsi@vger.kernel.org"
 <linux-scsi@vger.kernel.org>, "target-devel@vger.kernel.org"
 <target-devel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>, "linux-btrfs@vger.kernel.org"
 <linux-btrfs@vger.kernel.org>, "linux-ext4@vger.kernel.org"
 <linux-ext4@vger.kernel.org>, "jfs-discussion@lists.sourceforge.net"
 <jfs-discussion@lists.sourceforge.net>, "linux-nfs@vger.kernel.org"
 <linux-nfs@vger.kernel.org>, "linux-nilfs@vger.kernel.org"
 <linux-nilfs@vger.kernel.org>, "linux-ntfs-dev@lists.sourceforge.net"
 <linux-ntfs-dev@lists.sourceforge.net>, "ntfs3@lists.linux.dev"
 <ntfs3@lists.linux.dev>, "reiserfs-devel@vger.kernel.org"
 <reiserfs-devel@vger.kernel.org>
Subject: Re: [PATCH 07/29] target/iblock: use bdev_nr_sectors instead of open
 coding it
Thread-Topic: [PATCH 07/29] target/iblock: use bdev_nr_sectors instead of open
 coding it
Thread-Index: AQHXv/I6LcfbFcbjFUqHgkcEjSj9CqvRhf+A
Date: Wed, 13 Oct 2021 22:37:47 +0000
Message-ID: <a225b3d3-372a-9804-374f-936f8d91c553@nvidia.com>
References: <20211013051042.1065752-1-hch@lst.de>
 <20211013051042.1065752-8-hch@lst.de>
In-Reply-To: <20211013051042.1065752-8-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21ffbdf9-fb98-4423-6d0d-08d98e9a153a
x-ms-traffictypediagnostic: MWHPR12MB1472:
x-microsoft-antispam-prvs: <MWHPR12MB147240C774D40B8FFC4DE6E7A3B79@MWHPR12MB1472.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Icrd9OfNs5Hs98wp8bFy7qPhkKD5AIpjplpXzp63TS+9oPYHQTOR5rmOt3SMOaP2oqL1gY4dTfpWH47NFclI7/3oh0X9JN98YprIIFcWahrjXnxCv/EJKCx3/STHOggPas8H/u1RVFjzMqfllZRhp44883R0NO2we8RVBv2yeURglijpN86mRR++W3YOC7KGBDYmV0pSkHDg7NiDO0nk9LKdex2EivuC/svGrtCVZQajmChve3TGE3lE+76DSwvMAgh1FbpaUjkc0zY7u+t0qpiLPHrEVj/mp6tP8ah1ZzKMQumCYTFmRk6ZP0A6O/ektnt76lqb2ywzeZ30bTLPgU/O0FTTpS2/FcrlBJox4A5m+1Jmbe69wjzn6BIon5Iur5yeQTJSJ8hnRsv+UheYjByB5jgFe0LnwVBivcgghBXU29UlXEQ8V0LXekzf1SDzhhYkSNXi1WJmU5UH8X7pxF526gTOjcqU0qsKHEmSDZXYQyOtFMiS9KxLFpiixkzV4bPHfj3jHPN2VUJ3OM48QUZFhH+VJuCXIRWyulcL4jyRnBvEXYrs2wDAPWl6lTaeW4V/DzgIQ6cDKUMafBNxhN5117evRJLlVaOOP+izc8uNFFE7kK1Q5yXfpDvgVODHVARCObztWOpAN8V21TYDAIiYHy0sTHhOVv3Zs8WIowFjjKq0nqiKBX/qDk8kv+OFFa/aMjqwxKmkL2lmfl9B4Ca8d1xDD2IIHyYElkpq3RFYkPiOeaSJ2uJNrSZly4zrXwtHtMnq0jf997DtFCr0xA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(7416002)(66476007)(558084003)(66946007)(2906002)(186003)(66556008)(66446008)(64756008)(31696002)(508600001)(91956017)(316002)(7406005)(8936002)(31686004)(36756003)(8676002)(53546011)(6506007)(5660300002)(6486002)(71200400001)(122000001)(2616005)(38100700002)(54906003)(4326008)(83380400001)(110136005)(76116006)(86362001)(38070700005)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUxxZVF4RXdkd2oybnAyTUo2UEFLcDY4QWxHUllYVEY3WFpQNWVSVC81anBy?=
 =?utf-8?B?b3l2c28xb2kweWJRV0JLK0tEV3BZUHBneDZuOFNsSndvVXV0bkt3VDlpU1hZ?=
 =?utf-8?B?UGdjUVo0L3U5OEJZeFlKTXl6eHJ6V0ppSys0b1FQd0hIZXphUzdNcHZkQ1dl?=
 =?utf-8?B?enJ2NlhMdHlVYXZZbU1KVWVvb09ad0FtanBtM1QzVEJ5TFNXVXNPRVUvcG5u?=
 =?utf-8?B?WmwvL25mOTJFbElHOE1EOWMrLy9jbklvdkVZWmIveTRVVGRUQzJITjQ2Vk5B?=
 =?utf-8?B?UjhCZHdWYmtWeWJrM2lnRk9oaW84T0YraVJpZjdPKzU0QXhvZzVTd1hTL3NU?=
 =?utf-8?B?azZUSWRUTVNOK1dqNHFRL21ndGNacklSZmpZZVgxNThTcHV1SlZxc2JPb01F?=
 =?utf-8?B?Tllua2s1Q1dDQ09XT0lLSUpmSFZDT05CSndYQ1QyMlpFdEdSZk5ETUUzOGNy?=
 =?utf-8?B?b3ZPMWg3RGVKVHFnRmo1dUdURUc4ZkRFNFRTS1F5V0pQSVJkWDRHTTJBVis2?=
 =?utf-8?B?b08yOXFON2lBVUl0R2hxVkJHazdkWUVkRjRrZjVJbG5CbDFCMnd2SmxubUFO?=
 =?utf-8?B?SktjNldsa016cVFhOEVnM3VzZENwamZRWlIwVlU1djkwUnhMMlQ2THJUK3Vn?=
 =?utf-8?B?UDR5NlJvZnRZMGt5bW51K3lYOTdHZDlQSnpnQ0kxelFNdzFjK1g5Um1XQWxZ?=
 =?utf-8?B?aW5JcEkraTBDMVc5SFlhY3BnY1RhY2JIclpXb2dETTRVd0hCZW02cTRnY28y?=
 =?utf-8?B?NkQvZVd1MWpJbVpMRmM5YjZhZEF1YTlpRGkwaXRYVkhHc1R6MjEwZTJ6SDZW?=
 =?utf-8?B?MlltUzdhYmlMcitUTElrd3dKSTJKRWFGUGxuQXB3cHBqZjdtT1Rwekpwc3ND?=
 =?utf-8?B?TDk0dWhMYk9KczA1Nk14QWN1enRrNTdKMkIwOCtHaThITWFLQzV6c2QzdE8w?=
 =?utf-8?B?VU5FZnkzVkFWWkJKUTIwQ0xlWFZhSHIrSHZFWHR0Z0srT0k0RU56Qk51RXQw?=
 =?utf-8?B?TjZLbWRGTUw3OUQ3ZEJxK1dRVVhBVDJoTU40dWtGTFFGL0NCWlIyRVprMzZN?=
 =?utf-8?B?QnVsY2p2NUdsRGNtS2c0d0VFd2FSWUdPcmJjcllHUS9pdi9IN080MHVBdkdx?=
 =?utf-8?B?QnBuanB3dHRtcjZDRzU3R0lNbkVGQ1dzZFNBam96NzRJQlNKcDJnYk9YNVd3?=
 =?utf-8?B?WlFLNXpva1g0TEJZR1R1Wmw1YWtIOTlsWU03VGhxM1A4d0JjQVdvL3JEYm41?=
 =?utf-8?B?dGNydEVUdzBRZ0oxdEczMWxMVnhoWHpLdDBRMExqMW1BRGFtRURpc0VJVFRh?=
 =?utf-8?B?OVhZTDFUK2VvaUlVOGM1bWNhNnpMdHc2N3p2QzRXZTRCMUMyTGNoQ2pDakZi?=
 =?utf-8?B?ZnVlaVhkV0dvQW5HWDl4Uy9MTWdGeUxVbWFvbkdzWFd6RkRDNTRCc2wrMEgv?=
 =?utf-8?B?SFNDbUxleFdVTi9RVndPRitsU3VRNE10UXlKVjFCcGtwTTJXelRKRFVVT3Bw?=
 =?utf-8?B?bE5hbTRoczA0aUdESVMra2p0VzVXK3ppNDFxZVNjdllaaDlpVTlZWEp6VlRV?=
 =?utf-8?B?cy9YQnVSdERhdE1ZdzZKZ2F3OHdpcU11b2xxeDhsMUE0SmE3VitKUFViK2FK?=
 =?utf-8?B?Qk11bDVBZHNtYXk5WFBjL3VPNXV1ZjFORmJkeXZCNEtXdW9oNkhEMFBuWTdY?=
 =?utf-8?B?VldCb2ozNUNQN0QxdGp4TkpSTTUyRDdyZ09WWlNBd1VjRUtLbkRCSnk3ZkZU?=
 =?utf-8?B?TmlmVzYxMXY1a1hsVFpUUXpnVkRiYURLVzZLWG4vRjZQcEJCTGNvcGQxanlr?=
 =?utf-8?B?UlN5Uk9LTWlZa2N4OHgwcUxZdnl2QWM4WWtualJwMTJmUTdjNTVnaGxtUDdT?=
 =?utf-8?Q?TOHaF0OuoojI7?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <52B56D3B6B73B04C99CA63695B49537C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ffbdf9-fb98-4423-6d0d-08d98e9a153a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2021 22:37:47.9775 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HjHZD36FpHFZOFCZzuaq38WAfBzdw16/159r/+6euWE1VYKL96xgq+W/8JgWDJsnyL90WuH4E42kPagGQF2UQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1472
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211013_153751_162550_9D95CCDF 
X-CRM114-Status: UNSURE (   9.22  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Wed, 13 Oct 2021 21:40:48 -0700
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTAvMTIvMjAyMSAxMDoxMCBQTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFVzZSB0
aGUgcHJvcGVyIGhlbHBlciB0byByZWFkIHRoZSBibG9jayBkZXZpY2Ugc2l6ZS4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiAtLS0NCg0KQm9k
bydzIGNvbW1lbnQgaXMgZ29vZCBmb3IgdGhlIGNvZGUgcmVsaWFiaWxpdHkuDQoNCkVpdGhlciB3
YXksIGxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBu
dmlkaWEuY29tPg0KDQoNCg==

