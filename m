Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE54C04AA5
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Aug 2022 08:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EhAN8wdjp3I5yuOfSYY3j/6wsFO2W7STjDhYXQyGd34=; b=iwIcD6eVDcR2TYpqJK7lmzNrsR
	UFW0sjtusQ5nkxUt+VX7X0dEP0911HIaCMmo6Pg+hbqu2Y8Ds6BPyo+J0ecJwXYWA0oxWDM56WKsK
	cuIjBvZAuTgfFOQz8ikDMvh5IxA1PenBcLpR81FcBTCEWqm4zJXWij/vcPdT07QylMLDmTqs69hAq
	GePrlIHHhT9wSR/xeDpKkDsO/qdkeQdz5l3G03wm5UnbHAwo7sa6gyoFbjMky64/Fhgs3q8SKjfYv
	qgwfFwpe5C30B0KELNKNPuOv3/q8xXzTt5lXjJueS0BSZ6WJ7zV7MvJDhUcK7XZY/QBRrxYvDKOy4
	IjdZduHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oR8D3-00A3WA-Jp; Thu, 25 Aug 2022 08:27:29 +0000
Received: from mail-eopbgr50103.outbound.protection.outlook.com ([40.107.5.103] helo=EUR03-VE1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oR8CL-00A2ui-Sw
	for linux-nvme@lists.infradead.org; Thu, 25 Aug 2022 08:26:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TYE4kypjm0pBFhNht8eZHZ69vwtiD/Ojzyr0IH2rmSzmk6zLw/7elUMyDPptc8VgHe5WTBqryovQuTJk0lD2pahQV41sE1l8IznaT/dCyQFS+gwga8SEmQ9vbPhROAsDrNSdqEe4V39if+PhkMamu9VhuegXXkaFRC/1ck1hsk68cSfkydIzHoboL4TghKr4eYov09m0qcETxjxXzfeuVg8Y3wyQg5iz5ZB9norOKeTtTYr3FdPtlDVBQD22ye5V+VKC73DZI/yE12bnEbpWd75z1upPvXDDg7Cl+aG/jNPAvR0KRciqIiU0NXZR/vUktESnvCApKtbsR1SEt6ogZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhAN8wdjp3I5yuOfSYY3j/6wsFO2W7STjDhYXQyGd34=;
 b=EyN+21J+nkNQzJwAExMty/B4TDa3xnBIiY93MMjpdCKr1MU9GvToPK87vHXfqO67xBNhaukP8FdaGMHoyQIbNzbhvmGzZRIcEZfNpRqjR5mkJsLm+vpuimOtG8Qo+5VN3xwVe9L6wwaE7hn6ln2ioapPvsLYX5spDp68/5hCvJ2XAUK9kN+Pgl8FHQO20qXWU3hmKk1mRm6tkKAZEMzf0JGcIC9sE+fX52gL1EifwRFbUqvsaHaGrm3WClN9xH6pIQU4uFWN7AjmiU/jhGeDQmJEcRmiG1OuvUICtGV8hra9Gta4Z+J9knONZ5lQlemGBHHvczoKQSjkfK3U7+5q7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.com; dmarc=pass action=none header.from=kontron.com;
 dkim=pass header.d=kontron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhAN8wdjp3I5yuOfSYY3j/6wsFO2W7STjDhYXQyGd34=;
 b=JUey4XHtBdBAo0tJ3cu333OytbiDSoFtiyLs7lDocsKVc06tkt839dFMjTUaJGSsIuESCuI2z54tiU6yYGoz0kpWEklW4QIARPz5LRhcNEfQIj8JIki3SFISwN3ZKXf+U/WNGWVkClgLIV4+kKyLMM8j59DXwNkE2tUcZo5l0co=
Received: from DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ef::11)
 by DB7PR10MB2457.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:49::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 08:26:40 +0000
Received: from DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::88c1:4797:9d1a:97a5]) by DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::88c1:4797:9d1a:97a5%9]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 08:26:39 +0000
From: Gilles Buloz <Gilles.Buloz@kontron.com>
To: Christoph Hellwig <hch@infradead.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: RE: NVMe write protection support
Thread-Topic: NVMe write protection support
Thread-Index: AQHYpYEbiU4zQ2Uo+E+2RUoaxlVOoK2aX6uAgADzx6qABkBkgIAd0tbe
Date: Thu, 25 Aug 2022 08:26:39 +0000
Message-ID:  <DU0PR10MB6252E237D18FCFB37CB17B8F80729@DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM>
References:  <DU0PR10MB62528F66099C2311E2AF1EEE809A9@DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM>
 <YugctzU0uDZvfAal@infradead.org>
 <DU0PR10MB62528A77489B4ADE66503166809D9@DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM>
 <Yu4nt1bzSynhmeUF@infradead.org>
In-Reply-To: <Yu4nt1bzSynhmeUF@infradead.org>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be2e4ab3-f196-4e51-d129-08da867388b3
x-ms-traffictypediagnostic: DB7PR10MB2457:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  zPWFrBfUMQEmt7NBzkkJy4e+Fkcua6bQKyJeZKajKuffjyRF3RRpvvMjVyaao2YUlxpginoUGTfB5CqMnsE2m8TvNEaMkaxnfw7xpz1ynh9MLP3j9bOqcQ7asCqRJn8IDPji1aHpEkH3Vor2w7lQ9JH9ALr3KWeKCcHQotCUxjujP/3ZbXKMmgbwo0nCqDIszG3I8/wk88LmQKxtrV3sYCAAXvXz0Eiridx2XYBFcHLWYblmEl9DEUR+asmZ6cm50EM4vo3EHqguoKc09MpnQ0/8ySzwpYKxPsZQJFgQMUkyayEuYVOi/vimHeGlVf/22vq7AA4EPed2BsZwahcHipqAf4ZwVxk6QVnn84m+hvHpBU/adX4Bckiwd8icCJ129MbSERmD8Q5kx2nvnFvyk1VkdIQ0Xw2iKRBhqQM72++NZ9LSwb7L+QrmfM45fNjP9G3twB8VPrDzBovkxaGffVe02Y5B0Ncz7iI2s/SNrFUl5rgq7PAmw00Psfga1Wdp2X6SP9GD2BC6+3+6qCdoD1kzIlwSRyst+LHRufvZYjISt7xO6v3p1mBuisFmrt2LMARYESIWnhyO3gAAvSLoofxGmpfuj0oftfnoWSGrW/jq9CgTyfw9iJpIy++3dND0rgChp0GGKX/+1bKgnDhBNOm+PrM/7xZGkyznTWUY9qs/mJjDFnQObiulBZ7i+sjIAS1FGr4AESpsvCY729K89dfCFuMVIjm5MjDlTcDviodAqxvKxSzqxXfkDvF4e1phDsdPgR4yLF0wD1Yueqwx2KQD39MtOJt0RHVXW265XFVjWuwQneys+Herq8A5gQM2cO/f5B037U5ZqQiAMqUtM0P37ChaLlySoWCqvaOXJLs=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(66556008)(66946007)(52536014)(86362001)(4326008)(8936002)(66476007)(478600001)(91956017)(8676002)(64756008)(41300700001)(38100700002)(76116006)(6916009)(316002)(66446008)(38070700005)(71200400001)(55016003)(3480700007)(33656002)(186003)(83380400001)(26005)(122000001)(9686003)(6506007)(2906002)(7696005)(5660300002)(15398625002)(43620500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?iso-8859-1?Q?4iG2y1i8FQk5S7wawWw04nKtnvbngBvNty41vlF5w9qLSHAxF0b1AZpfpW?=
 =?iso-8859-1?Q?1sYWFmgaYHhKlLArreBadxvumIgYNvLcjkkZuvs7N489v/YU7B5gaFSo6x?=
 =?iso-8859-1?Q?rn+o5Tr7EpfMJZZNdKwv6AOiCt7OUZly4FSMowrRyjY9Nk++zah+NS+ps7?=
 =?iso-8859-1?Q?x2B9geZxVUIF/dWADAOOB19uD6EkZxYXniO74rafu+yGg507f6OB0Hfr/8?=
 =?iso-8859-1?Q?w3YfuYMQa4RKrhqQxbTr0KnPqb0Kzdtrh0SPGCDA8AlpYfUEApZqbGwnXe?=
 =?iso-8859-1?Q?c+JlGLmaYIZPTI8xMuYX3rpEAwsMzrmZV4ipZ+m5xRR5veY54Y0tzmVm9a?=
 =?iso-8859-1?Q?il6VGY2GV2pnLT+ydbCmaukTj4StHUrBXaQuH6D8B0jxYHdw8ILxsPG/MZ?=
 =?iso-8859-1?Q?GGb59aKYH34wjBj88v/rWFX94QRh2eLewDBg3ykcjbVbnwK6dm7vu9Nb1v?=
 =?iso-8859-1?Q?FCTzzro9isa/RznauAT5dTSb7LYuQ3dfxOXlnEMSrcjcqcwl14GzI5lbi0?=
 =?iso-8859-1?Q?Ad98JWUnTm3QCM7LXy12Iwlo4Ap4qiId618KyNJY6sZhMTPWuntS9/9OyM?=
 =?iso-8859-1?Q?ejZ0Yocddh0mVYBmSPTXLHssl6Zq8P7MTiM82C5S7W8pZQgkdamdUGLPZf?=
 =?iso-8859-1?Q?l6Cy6SXT6HSyRJMmS81q/qkiWKoz+k5JIlaGreVmdVwqksO0+MzWcshLNv?=
 =?iso-8859-1?Q?jNG1x8mIA+7/AF7kcFlDESr8NO2uCbqjeqUAXaBq1ZXxzYnSEfUUaimLfp?=
 =?iso-8859-1?Q?tztCP3UYE+Zm+bSuOHoVYCwV0qak1gig4t15CIg8PStnLa6O2GI3XTLzv+?=
 =?iso-8859-1?Q?Y/Sq4nqt5v5gYx/WlMlLWRxxHFmYrlQUHWuUajL5tOa9ErBR+XtJBSmQcA?=
 =?iso-8859-1?Q?h7/TcvUFrXwu60enewXyZTRHPXqg9RtXfZJgq0yVY/L5J8OQ3nIsHfBS1N?=
 =?iso-8859-1?Q?w0I+/D2zwtEYS7qXbtbMWb+GoL2ASXkSSQhK032I+Yl/2CVg3sN0uBznzZ?=
 =?iso-8859-1?Q?HfUVi/xcwHM5dY08LvtepBtkzqKIGhJIvI+aQkdnDU7Xb5LdZSrukzRNfL?=
 =?iso-8859-1?Q?FozVPQbF6/Eglikn6zqOu4us86FWecMhWlO4CKsSr+AYNfr+A/UqM0pKQb?=
 =?iso-8859-1?Q?TIHJuOC3nnZFO/jahVFOVWuvE/R044GZwh5TiVbsKS9bGlocoebticZF1Q?=
 =?iso-8859-1?Q?vO0diYM7SNLaR6Bw3lermAy0TZ96V4JAVnz5ZAW+QaD9a2kTsYtv885UoV?=
 =?iso-8859-1?Q?3qtSMvYDgvQMHsE2vg4bhXA8sQSiRByDuo1x5ePWGLrqEcOzmh2yNbcFQ6?=
 =?iso-8859-1?Q?/kRv+vmdvsZJ2RKOv9ZRDdrZuwFMQdnybrpEO9/1PwU50TKkRRwL6MlTOE?=
 =?iso-8859-1?Q?+F89fIkFxhG8/0nyNUtuKiFkf4STqbhbbfCI6uamZnzV9BWDSUE8wpHpJo?=
 =?iso-8859-1?Q?CqeqvzrfR4Sa9tUn3Tq3/F9z4Dm6LWcL8jLlF1lA56unfqFBrmbyRM4L9P?=
 =?iso-8859-1?Q?nK/WwyCqK2Ab0IwV6xipIts32I5uQKUm7RPU7V8WaKkhY0I7GyJpJ5HOWY?=
 =?iso-8859-1?Q?iTfzpezCESArqVQtfTRheQ+HWCVxetwnUpwwlt/mUFs3sv/aPT/RIssKMf?=
 =?iso-8859-1?Q?/ERzhZoh8srBi42PSjghtlZpTdU0NC2vme?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: kontron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: be2e4ab3-f196-4e51-d129-08da867388b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 08:26:39.8712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Lx6gI1b8bpQT2+Pk3eadAFJbbJv+JVVUZhSGpl0Gv1WyIDn8b2DaCAOXpcB5hPvcln9jx7UIM1VKd23AgSKijFo6rLoNGSveKsnk0UdR6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR10MB2457
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220825_012646_172325_3A826F02 
X-CRM114-Status: GOOD (  14.29  )
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

>On Sat, Aug 06, 2022 at 10:35:00 AM +0100, Christoph Hellwig wrote:=0A=
>=A0=0A=
>>On Tue, Aug 02, 2022 at 09:20:02AM +0000, Gilles Buloz wrote:=0A=
>> Sorry Christoph, I'm completely newbie in NVMe and don't know what "Name=
space Write Protection Config" means.=0A=
>=0A=
>Take a look at=0A=
>https://nvmexpress.org/wp-content/uploads/NVM-Express-Base-Specification-2=
.0b-2021.12.18-Ratified.pdf=0A=
>and search for this term.=0A=
=0A=
Thank you for the specs.=0A=
=0A=
>> What I mean is that all the NVMe content seen by the user is write prote=
cted.=0A=
>=0A=
>And that is what this feature is abut.=0A=
>=0A=
>> Our NVMe manufacturer partner has dedicated a pin of the module for glob=
al write protection.=0A=
>=0A=
>There is no concept of a 'module' in NVMe.=0A=
=0A=
In fact this is a M.2 module : a M.2 PCIe SSD one. A M.2 GND pin has been r=
eused for WP with a pull-up on module, so that if the module is plugged int=
o a standard M.2 socket this pin is connected to GND and the module is not =
protected. And in a socket providing WP on this pin, the write protection c=
an be enabled by setting the pin high or unconnected.=0A=
=0A=
>> But if we enable this protection and attempt a write (we should not), we=
 get a "critical medium error" which seems a bit brutal for a disk that is =
still valid but just write protected. So I would like to make sure the NVMe=
 manufacturer has used the right method/status to report this write protect=
ion, and if possible get a less fatal error feedback.=0A=
>=0A=
>It seems like your manufacturer needs to read the NVMe spec and implement =
the correct features.=0A=
=0A=
Yes, that's why I requested some tips from experts like you to be sure.=0A=
And with the features implemented correctly, is a the case of a write to a =
protected module already handled/expected by the kernel ? and what message =
the kernel is expected to report in dmesg ?=

