Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63AEAC6FD1D
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Mar 2023 08:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Y36syUg4K1qIc/QCV0zQIJimf+aY0gtADhvBxaG2arE=; b=YZNT6hdMBSu19bZaoBDoeGFDMy
	ZW+BifRctZlSUaVYSihfCp3UCSH0qIV3r0L3tpxPO/9KUv7rtOQkMyMtI3hNFsn2KWTsc9p3CulmE
	CQL+kxIkZDpNQLFjY1Lij3B65q9aXc1Ef49JiBJGPbqd6eQdCOHdTebUlDvQCpGKRwZJog+RnS0aT
	yhE+qUbPOYZEcVszNZXU54IcD9WcIFGvfZ6Mk3/aUjFqQ7RVijePgk0SIgMsRpnX7c4r1Rdqz2C56
	W3sx3856byA7K45BciRRU75Xa+ktywaS04TkhiTPnG1OZ3xlH4f4+/nd0VjgrKDErAYpsQW5H0qGQ
	/CB3T4NQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfG9t-001EaB-1y;
	Thu, 23 Mar 2023 08:18:53 +0000
Received: from mail-mw2nam12on20629.outbound.protection.outlook.com ([2a01:111:f400:fe5a::629] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfG9q-001EZe-1e
	for linux-nvme@lists.infradead.org;
	Thu, 23 Mar 2023 08:18:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D5IdH0CamYmJr6NAFcRpHttXHkJUsyyZ56KoEgvY5NEBuhY6HOyIGitypQmxcHAJzWBgfO/dBuUX0yM2keaH+KVirF1V47c4fPDFEAdvfsl9hSbWINQdnqts8bxzr8Yqqh21Z1lcCuWQhk9QWJwe9WxNUXl9Z1/BuhszYKhAyrZveg9geY/eVJiIzDBiLSKZ8cqhkEQw6ihe2hYflFQbF+Z5j1ZmzA29ebC4atP6RAiD1rFoLWUWs14VVVVHROm6n4rtzo10gDAZE20kOsy5fgRV3tfL89G56wYeXUibQkV6NFmcJmWqiQHIFA+q/K8UI93/carhaIH1EEaXtm+UoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y36syUg4K1qIc/QCV0zQIJimf+aY0gtADhvBxaG2arE=;
 b=AiIf8mPs94Le+tNFZBasF+SCx/0ZEdsuLYcxspCM1HwcI2CWnneJxc2Lj3j8rqcEMIgF8ho5UJTGY/3Pf1k8k9MlP0M6Dys9SW1TcgGxtmPrF3DaoXihSdys2sjsDT2OFpk5+j21MKwPUnGftYd3tgH0szl3MSk/DHFqMXmCuaG3IaPTNzNLi7uwCrg08zuRvmwm834zlsnzWWFivNm6+gTFRQEoki7c632xVp8YCGej7Ty4dYRx9txeiRa99NSHZPzcFHiNGzVSbkL4vlb5NmRHf3wUo8LcFamMr0XxcGJ9h5QN8Iwg5K6pcvEzoXFdNW7aCUfqqsEPYzMYazDJaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y36syUg4K1qIc/QCV0zQIJimf+aY0gtADhvBxaG2arE=;
 b=gpFlCMRleFGe8q/i8n0wAHmr+jpGd1TZ/jOYHl2sQ0lnnMAIgnxPqcjHlu5QVu6yZCNEOti+E7hhDTvXlWnhMLbwZukQAsEDqc0p23KvAaklUHvAldqbJ7wuPIA35CT1PUhUoy/i5mIYAo8L6swZVpLZiPEfGheB3mLYpGYazXOOwGQMZTxwAUzeyr3XVqvo4J9TeOvcqq/TINjjjuPyERLrWYX/iclgXDr5vPmzW6o7loDZPylrwEwgiCoqHWAbkC9eFKqepxCvwP2oxdPW509oM0QZA0pGjgoovjXdOStLjGpWVFI+LjMjV5UpaplSMk9WbfeBeQdLeJp0C0Zeew==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM4PR12MB8557.namprd12.prod.outlook.com (2603:10b6:8:18b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 08:18:47 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b%4]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 08:18:47 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "alan.adamson@oracle.com" <alan.adamson@oracle.com>
Subject: debugfs message during creation of the NVMeOf controller
Thread-Topic: debugfs message during creation of the NVMeOf controller
Thread-Index: AQHZXWAXLm0GudwLP0miOy+xj46htw==
Date: Thu, 23 Mar 2023 08:18:47 +0000
Message-ID: <40baa75e-fdf5-cb73-5fa8-b12d65bce4e7@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM4PR12MB8557:EE_
x-ms-office365-filtering-correlation-id: 156e3bea-06ef-43c0-342b-08db2b7739cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  y+WGL6eMifjASrA8DZ49dYNHspIDHKyQBygjsJLomSqT6meszeteoxbHZIJwhFFXEG4XCmeHD8ST3j6H9DgogCg3V7cFUNA9wzq9RPJXNae9pksHfIk6bCe2x+C5Q7j5EKuoO64bAXdfUECYHOWUvKVpeaKVuMx9sqFASpfDHosxCJTtWemmYvO5/dRiizv7b8oqAt9LZZWIR/93HCTrldWN8XKgPjP0KPBQAeCRsD5ckGgpjQeLt/48/9lxdggBBUyWg6FwZ4gyT+IwtPDdBwcJZGHVoP3oe7OjvH3mSkc9GTllSJIB3fp2bjJ/+ayHC09nopBw6vwEZLoZ+r4iVHuiWFyfm3vEWDZiUno+7BJI3MG8ZzMDEp81MaH3QGUBq5brWnxuf9Zb+nqZJyCadWANhJ0PzXXmtullEY4eJcTuBO/pjvNulNX1Fi4Zip7qOgN7a4GPSGuvYXs1FwwdrYfo7ktZ2XGvVQqzg+zknkvTr8S9FKkbdJLy5nQoG4k9VkdDhuwAysGNJ8APewsm6oEQwXQodeBNhNENGMxuBlkRcd5hMZ31eIkaACZ/38J2pZI5oyuoeGjEjbUCIh9K5AFd8yuaR6fOUcgNqwwdUG4d80eKyEftaEyRsJHtvw969XLMq3vcQbLkZw8IrgHnGmt3Qh6F/J9FM5B2YHBz+3+uxZmwi06TPFGIB7mn6HiEhmTU7WkYyvRoLUmXa5nwL8kUF/c1hJeDzeOzgFvgviXcp2YYxhFdc2I8C6hSP4dflOX0K00vbjaZCjP8F/mLaw==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(6029001)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199018)(31686004)(38100700002)(38070700005)(2906002)(71200400001)(83380400001)(478600001)(6486002)(2616005)(186003)(86362001)(31696002)(36756003)(316002)(4744005)(91956017)(66476007)(66446008)(64756008)(8676002)(66946007)(66556008)(4326008)(6916009)(76116006)(8936002)(26005)(6512007)(6506007)(122000001)(15650500001)(5660300002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?OTRobnd3YWZlaWZTNEcyOEwxNHE5T1F3YldoaDRWOHdscVhZVWtwNzFnNURx?=
 =?utf-8?B?c3hXSHcyeVg0cFBQM1VHQmhiMlR2MVhFNk9td2ZUZVkyZDVnMVU1NUlmMjIv?=
 =?utf-8?B?cS81K0RJRm5Tc2ozczJGcFBBSlVaekJUYTBMOER3dFEvR3ZVcWRMMFdvWFRH?=
 =?utf-8?B?Q3JpVHZIUTdtOVBGZnZQcEh6Yk5qM3FNSW9SeW05SE12ZzFQVzQwTzFDWEF0?=
 =?utf-8?B?TmdkVXJ3N0RqL2VWdVFIaG9ROCtwV0Nsa3orZ3dOYzE1K2tBcGUrbDc2VDN0?=
 =?utf-8?B?OWxYQnlOdGNMMEhGUXdJaDBkbmJXRURXSUwrSlBXOVV5bElXc0FMbHJqUnk5?=
 =?utf-8?B?am42Zk1ldm9KQmhYdlFiS09mN2N1cjJVVGk3M2dPcGdYZWxDT0JCZVQrRUc0?=
 =?utf-8?B?b00wOXZRRHZ6d011RU9lWTkrQ01DVmNnWncwU21EU2NrZll0Q1FVRVpSRElz?=
 =?utf-8?B?RWpZMzhZSUpGdkRpNkRCRi9wdGFVaXFhdnA4Rkt6bVhrc0tRWkdvZ2FPdUlX?=
 =?utf-8?B?S3dGV0RtcDBZVmV3ZlNuR1kzWEtRRERhOG8wODhwQlJBcU5HeSsvOGk2eElh?=
 =?utf-8?B?dVAvU2NXejdpUWQ0ejlWa3dlUkV5aXVQZEdRdjZvL28yVFVKODlDdm1yeElO?=
 =?utf-8?B?bmxIME95cHRlTVlBRXJjaFNmNGROVE9QTlAwQUJuZkxxQVFLankzYW94clZJ?=
 =?utf-8?B?Y2pXak9LOVV6WjV2SXZoVFRzZzQ2VFZnSkpLM2VvcnhEbUNDeGdGd3RXdkRI?=
 =?utf-8?B?TFA5NzV6bzFJSjdBYWMycmhpTTJxZEFNZUtJaDdpUE1PNEM2ZUZGMmpxcWVJ?=
 =?utf-8?B?WVVmajNqQ0QzSEQ1aGFSOFB0Q2F5L1pKTS9seVp0WElQZkROZTNOK3lFczFr?=
 =?utf-8?B?eEttZ01iMGFtT0g0QlhUSE1naWRURFdUNHcrTnUvQjR4UHR1RWczanVWTU5F?=
 =?utf-8?B?WWRRNjJxMVp0TXZuRzdjU1duMElGeGZWS3NzelhsS3ZucFVZa3J5QUN5Tlgr?=
 =?utf-8?B?ZFdTOGxad3JvTEttdUtVVmh1RUdQV2UreTlDS3V0SW9jVk9EUnFUL213MUVw?=
 =?utf-8?B?V1hRNWFDQ1lHbU1JYytITENOSHJLNUNSMCs0UUlzWlZLRkVpSU00QitROUl4?=
 =?utf-8?B?NkxWUk1CLzJ4QzJvZVh2SG1pemFWVzFDQlUyR084bjViQkc2K2lmcEJWblJK?=
 =?utf-8?B?RjVJRDY0YTBDSWk5djhjRnR3Uk5BUVo0SGY1RktnbSs4OW9tdXlkMm5GcFFp?=
 =?utf-8?B?OEVhRStHTUNhWGxDc21BMXlNQzM0RStIS1dia0RPVkpGdXB5Wml1Zmo5a3kx?=
 =?utf-8?B?enlVb3ZuZ3lFMWJnM1lTb0oxM2ZrNTcwRC8zYTUrWWtDZ0s1WlYvQU5sNHYv?=
 =?utf-8?B?Z0JjNmdZbWU1SHlsTCtsWEROMW9pUzBuYkZnWm0wc0RHQ2JNWGJXZVB5NWV6?=
 =?utf-8?B?TUlMKzR1b1VzOXpJejJoeFlBZHFxazR3Z0MrMHFreitmU0tNUHNaL1lXZ1hT?=
 =?utf-8?B?MEprMTloQTlpNFRUVzlxVkI5YWxnR3laeTFxSnNBOEczNTBjdHVwTjFHZXBi?=
 =?utf-8?B?azRSL1dWZGRNZFEvR3lGaHhoTmxYYklVR3M1d3g5ZGF3Uk1McWdrZmhOaUdZ?=
 =?utf-8?B?U2VZK3RiTW9scDc2ZFA3RkZCQnRRTW5KR3hZdnc1d3BoVXFXM29YNDRpRTlM?=
 =?utf-8?B?STZYYXZ0Q05QT05lNmlHSXk5U1lNQWJQZmI4c0UvNzVKK0s3UmU5clBNY1Fv?=
 =?utf-8?B?RmF4bzhMME05TGNXc1ZiNGJLek8zdTU3ekZtUXIrenRTTVJsdmw4VXJudnRV?=
 =?utf-8?B?bXIxdmhVSjVQQk9mTUU2WlY5NTc5ZE03UzJCR0ltaTdUOW5BUUM2UHVGU1RB?=
 =?utf-8?B?cEtFRldZKzEyN0xHVlVMZmM1OUxkbDFYUmNzOWZPTzFhU0lTNTVwVUxGRDBs?=
 =?utf-8?B?OHRXY1Y1VjVsTkRybURaZVpzRGtXVkZHbnVwQjFWY0xJaWkxMmthOThlbG14?=
 =?utf-8?B?QVd5c2QvN0JmTFRzejNsbzZmQzcxMXlLQkpmYW0wZWhKM2F2THU1RmJoaTFT?=
 =?utf-8?B?WUdxMUFaNEpvbnBPdVBMUEV2OUU0NDQxbE1zVmRSV3NreHk1bS8xeDRmYnRE?=
 =?utf-8?Q?hXSdG6Sdz3L1k6Wba9lNPyCKp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F5425042843694BA5D7CE2333E8B2E5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 156e3bea-06ef-43c0-342b-08db2b7739cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 08:18:47.3753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: auWntN3b/fy13wfag6C6B0INIoyP8MjBU7i4YxrwtSJnRjsbC0iiCJgGc0NnmnUjbuj0zmWdAO929/I8wUTsbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8557
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230323_011850_552782_68F0E155 
X-CRM114-Status: UNSURE (   7.39  )
X-CRM114-Notice: Please train this message.
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

SGkgZXZlcnlvbmUsDQoNCldoZW5ldmVyIEkgY3JlYXRlIE5WTWVPRiB0YXJnZXQgY29udHJvbGxl
ciB1c2luZyBudm1lLWxvb3ANCnRyYW5zcG9ydCBJJ20gZ2V0dGluZyBmb2xsb3dpbmcgbWVzc2Fn
ZTotDQoNClsxODMxOC4wNTIxOTNdIGRlYnVnZnM6IERpcmVjdG9yeSAnbnZtZTEnIHdpdGggcGFy
ZW50ICcvJyBhbHJlYWR5IHByZXNlbnQhDQpbMTgzMTguMDUzMTY0XSBudm1lMTogZmFpbGVkIHRv
IGNyZWF0ZSBkZWJ1Z2ZzIGF0dHINClsxODMxOC4wNTMyMzldIG52bWV0OiBjcmVhdGluZyBudm0g
Y29udHJvbGxlciAxIGZvciBzdWJzeXN0ZW0gdGVzdG5xbiANCmZvciBOUU4gDQpucW4uMjAxNC0w
OC5vcmcubnZtZXhwcmVzczp1dWlkOmJiMGEyM2VlLTBiZTMtNDI4NS04ZDhhLWI0N2ZjYWQxMWZl
MS4NClsxODMxOC4wNTMzNjldIG52bWUgbnZtZTE6IGNyZWF0aW5nIDQ4IEkvTyBxdWV1ZXMuDQpb
MTgzMTguMDU4ODEyXSBudm1lIG52bWUxOiBuZXcgY3RybDogInRlc3RucW4iDQoNCkl0IGlzIGNl
cnRhaW5seSBjb21pbmcgZnJvbQ0KaG9zdC9mYXVsdF9pbmplY3QuYzpudm1lX2ZhdWx0X2luamVj
dF9pbml0KCkuDQoNCmFueSBpZGVhIGFib3V0IHRoaXMgPw0KDQotY2sNCg0KDQo=

