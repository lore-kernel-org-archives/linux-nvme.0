Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A1BFC3601B
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Apr 2025 08:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0P0td2Ta1Bn5HRDiv0MgFzAVAIUkdGkKeoOcApo+1+c=; b=fveVbQlQKuEKWhyN0qC5kp9eib
	vHBC2TDJdky5uZxpKkKgD2yMbU4p+kTUgP5X1nibTOLi2WJpE6H4gz2nInvcuTTd3a4NLtpkZMvPT
	zO3QpgHrYdKbHEMkVwY8doCuTU0H2d8qhl3Owun9RoqtQvQWZsYsLJbWOvdPJnHLTYjjWpM98fLBB
	SIF8Wkk6pjNe6nqrjr3dI5pp6txO1Y2DacpIpuJUOcwAjQ9aIxGqEmGXDSmDZwLX/VQp4Gg+0GjWX
	c4wT5NKgs3vjfLKL4KaMmUBsMwTOGbxa8YDVLQ0zJMcoIJWpMGSTw10oTeMAZ58S7xFv6AZG80T/m
	fny2qn5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0FV3-00000008CKa-2gEK;
	Thu, 03 Apr 2025 08:00:33 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0FKV-00000008AqZ-2bq6
	for linux-nvme@lists.infradead.org;
	Thu, 03 Apr 2025 07:49:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1743666579; x=1775202579;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aIhmeM44z7unaleNAZHVr60vw1bM+2NoOAz+hiMqOW0=;
  b=AKyBMRw3ecWjdE0oy1xOrDPI3SdGgzeb0s3XakL5rg7M/aGte5JPDGWT
   Fi3UpljrHRLb5fMQJ08zwOXodLH4Dc8aZWEP9qhdAyDfEqTXP8+Zh+EPM
   kR0kDYQ8MpVJqf4ubLaB5nLB25rVzvWbfdh7lSnLXmEcjAPysWQe3VctG
   +ThiMXhrwNGMw6l6MWxrjFN5bq3yTA+Q/8VNVKKmMqSXplEJ6Gf9Qaaf0
   Q2LUlTez6Ytl4uGC/m034vxx6AaIeDmbqKWd1ccPiIBNJ7466AhsCSM8d
   pqEp/VUOuajMt4veWo7ixXotiLK8TzCAKQX0pBTVZEsCbI+3XF27n0nyM
   g==;
X-CSE-ConnectionGUID: 51Stt6aZSPC2Ts95t9ZC1Q==
X-CSE-MsgGUID: erGeQZC2TJOABmtl8DuP/A==
X-IronPort-AV: E=Sophos;i="6.15,184,1739808000"; 
   d="scan'208";a="68121812"
Received: from mail-dm6nam11lp2172.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.172])
  by ob1.hgst.iphmx.com with ESMTP; 03 Apr 2025 15:49:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CIpEApqaFt+4sexCwoVui5t/XsijZqdHt/JRgbkYVbp8pbI4uEHjvmxvD2nFPrEMLvGWghV9yB6o7NLkk9ERbvdPOtJtdoA8flkwDxHb/YmCPu5Pjf+OlXIAOBvy7T933FONdk07y0CqoE3LTQ3bmtJJBGiviQt3EvyZrfhM9qmmiDnBw2QJLWMkK/cqPlKR2+RI77jG07jHl6lpauJcVm8V/OkgUzjKMlzjBccW5S/Wov23epgx52FtNFjGv09dczAk3D3d4IJf0fQtMsgJsTX8AOjywMUVnGfqzI2lrijRjc7cks/SRNYPe+a//WKJlh/C9IFkgVimnEhZGOxHtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0P0td2Ta1Bn5HRDiv0MgFzAVAIUkdGkKeoOcApo+1+c=;
 b=sNrXgAl2/9u7KAzxZjBSBlVfE00FewUihVeAIVI1xa9ELDYSZwHNZy/fM0n4IxvSVFGtyXsIR0flRWkec+kKIyooWGmN4XF4rQHZs4mdxBSne2weLq/fW8hkEawdbHYL0RD31uC+SjGdEf+PFZUJYJG95aeFfm0sg2xj9GeM5E5e5phQXDe7y/g1HElKOY5xGOriccosrMtjqjqS4B76zRj0azLPNfi0PwTQZospVbX3koTUoEcuvw8M/q4Rtfz3BSi7fICLq9Ip0uMkc9oMFcU73DO0CM1AmcU7IsbiNzQvSroD9AB+lDDpDHCOi3ia9mjFjh+Kq3Tjz3/Gb1wG7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0P0td2Ta1Bn5HRDiv0MgFzAVAIUkdGkKeoOcApo+1+c=;
 b=o/SABeNjsr0MVE/ShbGXXLsrkDt1kRD7ZSclQ/CSYmrC8d1GPmy0P6I83QToQxbU17RuXPjJMfA7yVL/hq/zpVjXysKRGmGP1nzcWC6/L9wutnKIGdG1uPWv3gvGbX5pBqXTYPNLzjj13msAUeGUyjgGDJWvnjmm9fb8KIPY8ig=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB7246.namprd04.prod.outlook.com (2603:10b6:a03:296::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.47; Thu, 3 Apr
 2025 07:49:31 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%7]) with mapi id 15.20.8534.045; Thu, 3 Apr 2025
 07:49:31 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, hch
	<hch@lst.de>, "tytso@mit.edu" <tytso@mit.edu>, "djwong@kernel.org"
	<djwong@kernel.org>, "john.g.garry@oracle.com" <john.g.garry@oracle.com>,
	"bmarzins@redhat.com" <bmarzins@redhat.com>, "chaitanyak@nvidia.com"
	<chaitanyak@nvidia.com>, "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
	"chengzhihao1@huawei.com" <chengzhihao1@huawei.com>, "yukuai3@huawei.com"
	<yukuai3@huawei.com>, "yangerkun@huawei.com" <yangerkun@huawei.com>
Subject: Re: [PATCH blktests 3/3] nvme/060: add unmap write zeroes tests
Thread-Topic: [PATCH blktests 3/3] nvme/060: add unmap write zeroes tests
Thread-Index: AQHbl9iTjGnH4dxeH0aXvqwDldXWhrORqiqA
Date: Thu, 3 Apr 2025 07:49:30 +0000
Message-ID: <dghqqezhieaion633vvmclyy3k7w7ajkt575qrhyi6bhvhb3rm@rymbo3ntfsni>
References: <20250318072835.3508696-1-yi.zhang@huaweicloud.com>
 <20250318072835.3508696-4-yi.zhang@huaweicloud.com>
In-Reply-To: <20250318072835.3508696-4-yi.zhang@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ0PR04MB7246:EE_
x-ms-office365-filtering-correlation-id: e0381b04-2fad-485c-cb70-08dd72841167
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?eSFkd3MQ4r/yH1AKYwHY1+CvWLQzOkrgOtu32vvFMT+oqz4j2VmNW5j9GaE0?=
 =?us-ascii?Q?bzyY1/0a2dpCOecjDdS1WxMQ4KPzqGzYP+cSDWPSP7nTmsOo8pma2GZhDWFZ?=
 =?us-ascii?Q?8A3EuYXdkH6tY0DQKpgGcrgDS7+9BIkNBqU6rHLlillWcAgEZ8EGcwB8Px+6?=
 =?us-ascii?Q?Awzwui4HE+fvAiA7CSrCdN89dmmbt1Hcm+OpQHD964qG9Qz40XdwqXkqLhfO?=
 =?us-ascii?Q?Dsqawu76XzJ1VqL6akmF8z5xXNtrVzU/nOz7Qfm3HlcOMYsNcA0H/cx2YsBd?=
 =?us-ascii?Q?mc3/LHEtTJFWni5jGOqWdPsluSkKlz6eqPQG7zxdnQE8Nj6a7yDleThTK74c?=
 =?us-ascii?Q?7zI7mcsZZXY/kTVoPqXEdWwuoU0qtSD4t4k6/LlxL6C1pIolWwLhK+72VtGa?=
 =?us-ascii?Q?gdZ3/Bbt0X1r4sCEC6xF57OW47e73Kv/RR4cGC1ATXtEtym3FYMPSloiXlik?=
 =?us-ascii?Q?+uGZ4aIebuf+dy+jb4o1rm9uztcIcTEDpiGlmd5CvydOjbK+NGDuSwa0EFZV?=
 =?us-ascii?Q?dZbbA/JXE+ZvwhS6edjOFospdtaufW69kP2qO9jq3QDZJBnDw48tz+3JmrGO?=
 =?us-ascii?Q?Q6b2v9dwbU2w4sQ1hehC0zf8XJHI+/EGmWf6tJfwR83di34iZ539uZJJLN++?=
 =?us-ascii?Q?fiUmPxgemp8MTxKxIN+g/JfAg9P7FOStcZoSgEeN7wpB8Dxt2VbCYAy3M/80?=
 =?us-ascii?Q?Dy7p77XVmPuZPkDNrcNqQaNi1Kdlho+yUeO5g0Vfmqkh8Kt9dzffO0WFclVO?=
 =?us-ascii?Q?VtB/GmHFRIEJMErWiz6j2CNoeCEEVVz0N8JdHO4LAD+12MvcMRaV5tn/nJch?=
 =?us-ascii?Q?YuHZOuHnOIGRHsEFTOxG8Fry/n8L7Q3C50v4h5C68iS6TMpBBAS6BBs4Lb3b?=
 =?us-ascii?Q?Vti6NU3LDv0wAIwMMDeN7CRM97YrtJXuY6Tk9GGsqdNO6SJQHCNinaT9BoqN?=
 =?us-ascii?Q?FDQW+dwulxp5/QJCEBVZVgm+B3ShNa3FLsHAZ3jMwLYoRILTs6B+tYaHAc8D?=
 =?us-ascii?Q?B1aaTd+i9hymouUxlsdh2zrvCI5FywmM9u36dscS5NlrYdJVWt+7U8P0zX8V?=
 =?us-ascii?Q?eXKwad/LVXkh1TSj6s86HyORrK0kWaPu37Y1F13zSvlAoqYFJsaBc1aykUl9?=
 =?us-ascii?Q?k2r+m9u5y/w6mA9L2Zt7WdyRaU3NLV/aERIrA8Y5jvaCXxHfpNnO8McyJpDf?=
 =?us-ascii?Q?Nu3cPrbb73Y2rRgUuq1gnItWEZP9R0aK0DNirWPmQzlqqdnH6hl0XbncOOLE?=
 =?us-ascii?Q?f5U1ribMGAay/Z2VLJMyJMn53hFvnCAlZ1Mi0ksdCiSQy7MlfrD2QJ1ipwXy?=
 =?us-ascii?Q?l7ka//fKr7JqNQbkIliHkP/9vOndciMpcApgdEXUbF9frOpjehhNP5l/3Dyo?=
 =?us-ascii?Q?aU9+cBQuouUUGAiG3lRSoihZK1sazocCGwkO/Mc76CYbvRYuTHtdYc/3UZII?=
 =?us-ascii?Q?dn4O0TG5AaHemprBHh5jb/EabEghJaVE?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fjidW1VKp+0lSqvBslZlnsOGS0TUKh7qkFG7gmRnYDMpw/daKQ0yxbA3XtKt?=
 =?us-ascii?Q?XJKNNHU4TvStr31t9UlUAFaT3kDZTv+p96GjNTdj7Ou4lcCsrxXXVbhbDa1s?=
 =?us-ascii?Q?mt9utA/OK77nM3ZbY3LBkMF8vi9sjSsy85/X+5p0CVQFwkzypzChnWKMpj5l?=
 =?us-ascii?Q?o6DOQ64AFcEvNqx8ZZnF9WOhvLYvSQq7WnxTtigaXxLaY88XBFeeUhecfDFG?=
 =?us-ascii?Q?bI1EAh/v2cC0S5Q3bASwmwPgqvQUH67khfefu1Fj5OFR/ZCR8t1nUIRpidFA?=
 =?us-ascii?Q?61lW7dJu64jvMjftJR3NLOo+SbN/+cLm2TvFTrfNgP5XIVndpoxhuyNx9elv?=
 =?us-ascii?Q?D+5z2GxfnKsF/hHg99ARGnPr4MhbIXWTSxqvzXMultsXwbsdLYcrs6y9jhAq?=
 =?us-ascii?Q?O7nRy8ho9ZtN/MybLMJjlAy9NXjqxxLDwFWGKenaotGkWx81g444szjSpMfD?=
 =?us-ascii?Q?axGU7BMCFkEef6hg4jmNZ8DfDpSasueVpz24HSm4NAmE0EKP+9dqmEzP1jTB?=
 =?us-ascii?Q?aTPgtR0v0A3o2TXsTKd4TWON1tMOdFB+GjXZHJEuZLeXFbVwKzVKNKl8oVXT?=
 =?us-ascii?Q?+XcUev42xjS5F7Y5i4K6jxZeo0Qerd+NIDJNhoYaNdKjevQMg1O6enfOUDvs?=
 =?us-ascii?Q?Qr6STpu6ZhkqQg26t1qBxopIAYEyX+hSKFuJ2to//kNWI0iS3ESilytkqKqs?=
 =?us-ascii?Q?ylH1ihJ6jgoqM0xG/vtFbdBtbU0hYaE94PdDO7CbBCZU5msKBlAF/Llt7c4m?=
 =?us-ascii?Q?awDuxtTt1rNVmOjDbCXaDh8hSdotpHWE+KiuhlWhprervM65zmk99C8SVzZ7?=
 =?us-ascii?Q?51VW+9OS5tGwwUThU33gX3FDjpTkZAW/ufYUA+kS90dEze+bwYHTqqh71MIb?=
 =?us-ascii?Q?r4wWcSfRQMXDkC1PUNT9qu6H0KtiNkTrY7sHYuCLZAh6St2iSlwug4k3A8W3?=
 =?us-ascii?Q?JWwih7GR2ejuWB/4/iM7laCALyxExZmJvWuAOBQ48sxd/kbZZOxvmxxQz77p?=
 =?us-ascii?Q?jE750mSEFx4l0pl+jqa5dmXoQklr09w+k09omIdDOVEGivJvKFdGccqwRnYD?=
 =?us-ascii?Q?3fuKmzTj2obGKLKs5/eOoG5KwG26GqGx0UNOBqs1TKn1+FUlC0LrrfQUjIaB?=
 =?us-ascii?Q?HonQ9zlCkiVCixADcbsPZCcHzkYCYi9qMbj7QEU5O2PQnDYIwpn1Vtco7Bnt?=
 =?us-ascii?Q?Ik0Z0uJ0STCzK4AZKyvzt0tFqpNHCPyJknQ0wA62AsL7cZxrPuYQ7jQuhfeQ?=
 =?us-ascii?Q?zPysAK8eyBOO3CBUz7CEkl62FxTgHRzc9WqceDOW48kSEfKWCL35tyZ2IRb9?=
 =?us-ascii?Q?61QaBOmE0Ex4T6h4jEIIzsw+4z1d0Ua1j5f5qMrDpRtuDcMgNqrizpdwH/yA?=
 =?us-ascii?Q?2JI/SfQ6SEe/OiSq9WONux7SidIYoa61Xmn4g2bt4gMb/mk/IezZjyiawcXb?=
 =?us-ascii?Q?kGqQsKGxBNlF4A4g9UYVQjxFBV1z43nbcZSmdCXvpzaf4rzZfHQb5M4j+FN0?=
 =?us-ascii?Q?r6lK19gjxen8h4Nq3Gx1oysG/O8dFZRni175QImAZkd6ALfS2ZpWvJLhPpPm?=
 =?us-ascii?Q?eSoFopKKXBwpks2mIyHzIg0nJ9N0mZnMWIrKx+cyYuvnJg1PzplN47Zmug5u?=
 =?us-ascii?Q?tdph3nGjQGRBf+4Yq1w+gCI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BC02ED7BB83779459356BEBDF138AD03@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pPVyS8Z9LliPHJRYxC5LrxHS6UR2J7wVpKzw2aikChGHAgR9BMQ0CZG4aHvQuWrpW7wpf6pi0fvshhCZnwUi0ss7/0jdTiUAgDoAzAktr58Vod1tTtx8F4oMjNULYfsEo55a4w2c9rRWeJfhYBvV0gR0H4WzzY5w6pWKlyY1EVu4z7HCy74+GPTCwUHK1w0SZAlMps1Fx037n21QGdKvaS238KUI3h0QIldcdU3NIKEl9BSRneeqAc/9752kzZ35I4DVpBxaHDd+x396n8RxaLpCL90k1BriD3OnbH63/e6M2lCQpv+7HgQAxN/YL65uwBegZOdlgZfPxgY+r9RhrEQYajhuNG4a2LANw3qzFKuzipLSOAqg39kg6AnwEAv7Tj+IF072+yn+w9WJZXQUwsqrZtIbLId3YbxW8e/Zzdhy3oZ+pH/5QXupVLjQtRsRkw8xTDf7UKA4ePgdM9hpQ17l68xbLSuO8vD2ZL3Tru84bAqVgzIWs6F8ThliUIDbvsBkPr0Y4icgEjP92J1MdqeN7vMnwX1JieRmVRsHP1Ym1vHrtwjCVvxBcgy89FK4H7ns3zXEtwrFHZRgaGFYZfudzOTTHb/JsFPQxx81xK3d8lKG0mntn92y6TI68GeN
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0381b04-2fad-485c-cb70-08dd72841167
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2025 07:49:30.7721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zlQhx8yYfDN6BlIwSQTp/RYlOPP5y3h2p4kkO5uhmUDnZnGcp6Ky/mxDPXLHhA4penLE5JorYZG59i9caa2OSQeWzamEKDNXH7gxmdDgxRI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7246
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250403_004939_670504_61BF65E3 
X-CRM114-Status: GOOD (  19.83  )
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

On Mar 18, 2025 / 15:28, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
>=20
> Test block device unmap write zeroes sysfs interface with NVMeT devices
> which are based on various SCSI debug devices. The
> /sys/block/<disk>/queue/write_zeroes_unmap interface should return 1 if
> the NVMeT devices support the unmap write zeroes command, and it should
> return 0 otherwise.
>=20
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  tests/nvme/060     | 68 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/nvme/060.out |  4 +++
>  2 files changed, 72 insertions(+)
>  create mode 100755 tests/nvme/060
>  create mode 100644 tests/nvme/060.out
>=20
> diff --git a/tests/nvme/060 b/tests/nvme/060
> new file mode 100755
> index 0000000..524176f
> --- /dev/null
> +++ b/tests/nvme/060
> @@ -0,0 +1,68 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2025 Huawei.
> +#
> +# Test block device unmap write zeroes sysfs interface with nvmet scsi
> +# debug devices.
> +
> +. tests/nvme/rc
> +. common/scsi_debug
> +
> +DESCRIPTION=3D"test unmap write zeroes sysfs interface with nvmet device=
s"
> +QUICK=3D1
> +
> +nvme_trtype=3Dloop
> +nvmet_blkdev_type=3D"device"
> +
> +requires() {
> +	_have_scsi_debug
> +	_nvme_requires
> +	_require_nvme_trtype_is_loop
> +}
> +
> +device_requries() {
> +	_require_test_dev_sysfs queue/write_zeroes_unmap
> +}

Same comment as the 1st and the 2nd patches.

> +
> +setup_test_device() {
> +	if ! _configure_scsi_debug "$@"; then
> +		return 1
> +	fi

I suggest the same change as the 2nd patch to check
queue/write_zeroes_unmap here...

> +
> +	local port=3D"$(_create_nvmet_port)"
> +	_create_nvmet_subsystem --blkdev "/dev/${SCSI_DEBUG_DEVICES[0]}"
> +	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
> +
> +	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
> +	_nvme_connect_subsys
> +}
> +
> +cleanup_test_device() {
> +	_nvme_disconnect_subsys
> +	_nvmet_target_cleanup --subsysnqn "${def_subsysnqn}"
> +	_exit_scsi_debug
> +}
> +
> +test() {
> +	echo "Running ${TEST_NAME}"
> +
> +	_setup_nvmet
> +
> +	# disable WRITE SAME with unmap
> +	setup_test_device lbprz=3D0

and here, to check the setup_test_device() return value.=

