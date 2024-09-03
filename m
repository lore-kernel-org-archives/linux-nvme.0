Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F65C54FC6
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Sep 2024 00:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fOGqkyX6qEzbvutOJJtol823dsCSmz/V9+5ORD2bk9s=; b=t5ZzzX4QKi5I4siXqeRN1/IyLH
	dSVvpKZB2idJmY9MNfrK1azXyxn9oi+1kg7+EC33ZvsRsNl03Qy24NU8PP+J9sWw5L29hXVMlJwfM
	AaBhHErCSmOqLIEOvu75wxw+sKBlcT0ES14ZYheR9ZThJa70PLo2EM4T3n3WecdfyNZEBhCdeu/t7
	00wq2+Z8qd6ndqtEMVYgst3XpACMtYdDVKk0AZQWcy4CwHqC90VqbzyzKVKgkONUtVFjtPMxL0YCA
	BZxMeltobLQRpfu8eF+A85khKlwL0sNmDVQKEPdTNZZiv9kMER4//P3HFE36UVwD04SwcyHk61Th+
	IMvQI/vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slHDa-0000000FqNt-3ppR;
	Tue, 03 Sep 2024 00:16:22 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slHDX-0000000FqND-2S2e
	for linux-nvme@lists.infradead.org;
	Tue, 03 Sep 2024 00:16:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1725322579; x=1756858579;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fOGqkyX6qEzbvutOJJtol823dsCSmz/V9+5ORD2bk9s=;
  b=rJ7lnZj4Jqd79iW0qD1zDRX6wr0o/a3P7AvEDd70V91UqAkq2GNrjyW2
   HoPB81g+OdOXt2qVwVhxnGL62T1FIHmfQ6TwOx5iga6CoEA6pN7vwe83C
   rSH/zX1D9NqUVLAQRdkD4HaVGZyTaW5CCAclh8qXv0tcOM2nT/tdjOcDv
   ut8ylk0rHMP6o7pwEx7uVP5jOFrCW9QnbMM7FSZG6LIDRapcnT1D3kOrj
   Hs53DHQy2+FgPNFJJHbBEuZeHROeRIQt920lyises+2ZzA+H9I9ap+WEO
   G6nZY2QRDO2KV2yk5w+vJUikKsAOiDcxF2z6YDqArDBiAtLUR/+Wb0sVY
   g==;
X-CSE-ConnectionGUID: 7PWWPAKOR6mLr0ii82/4Rw==
X-CSE-MsgGUID: pxXbIGv9TQq8Xl+98J9+pA==
X-IronPort-AV: E=Sophos;i="6.10,197,1719849600"; 
   d="scan'208";a="25754961"
Received: from mail-southcentralusazlp17012048.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.14.48])
  by ob1.hgst.iphmx.com with ESMTP; 03 Sep 2024 08:16:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Skw0Ie/pUPkfuNA5BDM7sjUhTESeNolcXolAF53giIoe1XvZgM1LkIgBQir+oxDab50OTAC1pzcwi1pd5PxFkl+4jiAGJmq4ccHmyjvaBicRpARY3KETl4LtUG4DiFd9bVA7C++YJvxVdEMTTHVUM+Xj46WGyGcM4UaAj9W/7CUvbwStn3s1ek3RlYNNmp4LYAKq2NyuuWgJfCClOsl9YwbYCh1HHRvjHhLqiteldmf9SMlZTykIq1KCrEU+NT8VT5MW2R+VnifDJg9Lzb0ug67Rizs3sZPdJLyQUqhlOJzGJSCh1Z0DqEArsySeVCF9mwZKQIGOugmHf4XWGsN2Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOGqkyX6qEzbvutOJJtol823dsCSmz/V9+5ORD2bk9s=;
 b=dTu+65sUfJOHFss0SmQGekKFFXp6pi6hdGQ740MLDLouniJvLxcXl8G50BZRrRvenW92ERrB/p9oZ+QxBs8J1dXF9Z7lHamRWjpaZWk3n99pJgnRwwFqB969Ag/OGB9HyaXXa+8i5E0rVjdVr5Ew3jNyxHBoY82RX7UrfDsbCPKECabXs8/CL8cPfFQVB8AZjm4tjhhwyUSC75oqmHxf94XFK6OAuQgRSHxzZjT2gWHWY1vVatWRy1I1h/SMFF34IJcFJZLJz51zSjLoJ6Lb7iS3qT7CK3+UaXEnGOcVovkqUqAdoqBqhTjBIGBkKYfEW5TUVkgSJ8gbsnJLeFRvUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOGqkyX6qEzbvutOJJtol823dsCSmz/V9+5ORD2bk9s=;
 b=Z5OonRUXkXSZZtkrBy7j6qoTEEQENwp9rvIv3LsuXrj9zFFnL9BIaAtJcRep5MQiQnDLGebaWIOcXH6vMbN+N+11nyaEDgkE+ahrvKlo1G0v0slP5lvJCORThaDQVvjS0p9e8mJYSRijNS3dRFOtcJU6tGkWnp8NVLhgyJdSzTU=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ2PR04MB8583.namprd04.prod.outlook.com (2603:10b6:a03:4f4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Tue, 3 Sep
 2024 00:16:15 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 00:16:14 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Martin Wilck <mwilck@suse.com>
CC: Nilay Shroff <nilay@linux.ibm.com>, Daniel Wagner <dwagner@suse.de>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, Hannes Reinecke
	<hare@suse.de>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v2 3/3] nvme: add test for controller rescan under I/O
 load
Thread-Topic: [PATCH v2 3/3] nvme: add test for controller rescan under I/O
 load
Thread-Index: AQHa9ZhNW/vrdcNHu0GOnXkEesSR3bI94Q6AgAaymQCAAK4hAA==
Date: Tue, 3 Sep 2024 00:16:14 +0000
Message-ID: <vq34kiz6wkjmea6z2p2amqcypixattafudkjmiqh63atmsh2e7@tgz7tjdcvlbu>
References: <20240823200822.129867-1-mwilck@suse.com>
 <20240823200822.129867-3-mwilck@suse.com>
 <57yxf7o7zcp4j34cfgk3glhmfag4ukvedzqgtr7fbqdmy2gvsq@t573offeg3kg>
 <fa79e577a8883548d12a8932b7769af1db80c8b8.camel@suse.com>
In-Reply-To: <fa79e577a8883548d12a8932b7769af1db80c8b8.camel@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ2PR04MB8583:EE_
x-ms-office365-filtering-correlation-id: 9b8ceb49-7043-45cf-ae9e-08dccbad9fa6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?elGLVGvDOoRq48dr9+gh4s/x/y6/dmSFPl9wL3+YfBRsWbHj9xCB32ToSN?=
 =?iso-8859-1?Q?RKEPyn7qw54bgPdM/ULWQqwI1vlm9xnsvMbY9pNYlsiQVvb7xH9oBIlBv0?=
 =?iso-8859-1?Q?q8KSHN2GHW0fDCxiT09HsXkgnhRfWQ4aCCR16J9wxno8jdwYmuDjibKxWM?=
 =?iso-8859-1?Q?odbn37gta+8tna23sCslrSOYll4qk1UA4PUvVrttCGMobFgqhFdQu+FPk1?=
 =?iso-8859-1?Q?M6+JcSACbJsxByw9UbojZ8kM9o0uA2jvzXoccJBj/YsaXWe5XuhzLIlmhh?=
 =?iso-8859-1?Q?Xo6OUja6pC7kXBHr0cTsNBhnSns3EaVdeBSCezauJSjh2r89mMa9yebsWD?=
 =?iso-8859-1?Q?BI4ufvq7VK3ibzfqQide2cJ4MQMJHd9U8a+B6LueeMlMhEdxWgl/QlRc3L?=
 =?iso-8859-1?Q?8vjrEm4zwYuBDL/+l1HPr68mN1kpZTa4V758Ieql+hAuu/kxWS8ubwW2jv?=
 =?iso-8859-1?Q?SDjZaeAv3RSNCyn+g2TzgXO8bg0yKQrC6BonceqdTUhzDJHRLNTuPESR+k?=
 =?iso-8859-1?Q?n7eSiwtkgw+c9Ccmu5jXc2WNh3xxCUdjKuQo6RmRt8phOES3k1zWe43DT8?=
 =?iso-8859-1?Q?GNsgjJL4ANe3yGId0ruic/Fx/sxksSeOAkqkq+8UeWnGjUzsX8vlYfwBtU?=
 =?iso-8859-1?Q?MsbXQHMTlZWA60bdrAjkltFWiqwRTfV4PQwlbhwZZsqpz2k+terXEhaF6A?=
 =?iso-8859-1?Q?/uJQmFF4QVAsP3Bq9661lmTMaRvwbWLqHB45E53M02plScDCPlhu4pWSyZ?=
 =?iso-8859-1?Q?H6orsgnHSolBBNCH6Gunm3CuckzYF7wrwfsvF8W/BrcwvI3mAnutkS/RgM?=
 =?iso-8859-1?Q?qDaF1j/nDQteOMZdkzBMKekHRI/i1bWgKjuUK6KavIX8UFagL6xwvyX8j4?=
 =?iso-8859-1?Q?VVV9PnGkJ1Wx4HgIIuLzY/CIGkPSsvjfkV9Ai0f2Dcyb8rgxfNQy2NxdJt?=
 =?iso-8859-1?Q?lmZv0hgfjoZcSXK+i12aWh648/GKsDF7vc5vKXWNyp2NBrA7oOCOg/BrQM?=
 =?iso-8859-1?Q?6HRofI4noYF5ZmuHJIV57CBmfphJe0f+JP/T7O19Ur117KJa4yznKFGL4o?=
 =?iso-8859-1?Q?5h5NidOGxla6d2bbDNJYxXsXESt2PW1TEAzqBAK7qmSF4nb7+5nxhPbqy7?=
 =?iso-8859-1?Q?bA8tzc8m7DkQktmbGB6GCGShRBlXH17g5yzm0ejB3VyZki/zDGur2/nN0O?=
 =?iso-8859-1?Q?5YeuZPMduKd/O8lsvE1/6dRmLpTOp8KosNCx/bIPSM0sJud2N5gkaiaMm5?=
 =?iso-8859-1?Q?8hbAKLHsxjuhHFug4C34CagkkDsBEFUKVO64XlUeJfnfbqjFvvK7T0umzZ?=
 =?iso-8859-1?Q?c6fuRljSWcGU2/5J9InXUcev1Dwtds3ibAdIIe+QjbHtS/ezIIYiJvLNoS?=
 =?iso-8859-1?Q?JG2iESm+XrFJ/wCbBXXmKqbN1/ZohvEDdqZCzW9JxjmhXOEGaCEXw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1CcWDEUAtFSKiaea0R0YWWcDsvvncIC7lHC2yO2cgBC2slY/tISdFYKGi6?=
 =?iso-8859-1?Q?9OrvBfL4SOdlOE3HHSnVjTGsABZ+uB1X5s9lPsLiZ2I9zn+o20j4pYmiJ0?=
 =?iso-8859-1?Q?oDOELlUGYaPUyJ0k7Wo3d5W8SipW/8tQgWjz7XE1Ow513LVCEmpwg54K0v?=
 =?iso-8859-1?Q?hzEt62z3SL7xLnbxE8t3/aiZi5+8J4khy4Bw/cGNPUVW5qA/wd64MGQhps?=
 =?iso-8859-1?Q?U6YG75kAUdwMbHnpDd3U9+D4plZ071LbmfRthawAzihUggZKRP8+sa+7aV?=
 =?iso-8859-1?Q?thmqQR2AOSnBXvfxeG3rF/RfWPDgRRhBiEFqOdFiXnd0o/RsVcVkEZSjx7?=
 =?iso-8859-1?Q?7UJLcemrJp6xr0NPN9GOsU6w63C41aV/DoFc3COJlr/3WxhKEsNeDza6+s?=
 =?iso-8859-1?Q?o1xe9QayGA/jJ6HUJ+emcCqARoU2mByEz4Lt7yBvmZNWcsP+s+SIoOOA67?=
 =?iso-8859-1?Q?YS8STpMpQafLnmCguMMa2AzschBzS9di3vN5wfCctfWzgtI6zOYTKa+jzJ?=
 =?iso-8859-1?Q?bfaTprGRSnCLp9eedHP0gbAYJpSaBWjZRl11aM9pzJLmoo1bukwzQyUSLI?=
 =?iso-8859-1?Q?RJlDiGEnWZRcCleY6p9ibethNGFuxttqvrZv4LKe+jBc6KhKtJqiM7SsXR?=
 =?iso-8859-1?Q?K9OgBsOihKqgWUVV7sPKQXnEIGnLz0tSEAo91skt31o6zU8FF7lZ8tlR5H?=
 =?iso-8859-1?Q?oYxSCWCY1JB8A5SxZWznaDky9On25xlq7KREMk9uh7LqZYa5fFIsrpzyET?=
 =?iso-8859-1?Q?l2G1sDBMjgp5uMi7JEFikGV3KcEXO5hSARi6Om0o4zmf8bigZSph5Pfibn?=
 =?iso-8859-1?Q?VCwcm/KJiMfUmlm5RLvPSpZmeDVGC/DHcwSoKwt5RCb8SpWw62TSuabM9g?=
 =?iso-8859-1?Q?yRmXvcKnEiTMMh2DBtvl3loLpmb7Z3Y76ROcrmowpd+G930ZI/e99NsGxC?=
 =?iso-8859-1?Q?DuKO1UK4OMqx8jdcWTEb3TFEI++B+YIKXc2+vUXv1ZdP3BI57M4RK9Zg31?=
 =?iso-8859-1?Q?tWka3jlHcM8nQ3wtSRb+WLcCYbk33MK0rCizex15XNfpxNcX/gKJtWjTrW?=
 =?iso-8859-1?Q?DRgQffYY2vkEonBCO0gy5H9hCRMcOSHg6EKFTHE9bkrxpYMvP8Zt1P4r2T?=
 =?iso-8859-1?Q?J6ydd+jxA8WbUTHBqAMtgMiW6nCoE3lVds2oTRy7pn5aNvardXyMwzWMA1?=
 =?iso-8859-1?Q?ZAqv2y0JBa5aK1WwR06TV6cv0/dck00pAn4J+rPFo7pNtNX3ooqSe59u34?=
 =?iso-8859-1?Q?oTN3LIbP6qkkk9g+xFUFcRSHmnWn0kLZVDbtSXpp/sW8oxVFWnYkBFEBn7?=
 =?iso-8859-1?Q?kBCoAvw1VowNuLulEE/aVKGDzEtTJESU9gTJr+XXaE+A9O6ZBNCPyLJ8Si?=
 =?iso-8859-1?Q?qZvHz93ChqxfvbIrrYLp60glputMafw5PusJXiIYAl19xVxAfeih1Rj4Ix?=
 =?iso-8859-1?Q?iRkGJ5SGyp1Obp+5rH75bkd3vjz6ZN8VEHi1SPrgbOZjrj3IDv8m2MDRJX?=
 =?iso-8859-1?Q?fz9fouVI6Gx4p2/rAANNEnlzUT3XaqGpB1m37Od5oKTcz0RDsHBJWFXsvg?=
 =?iso-8859-1?Q?KWVqg0IiX24cTh9D7sNHIuJkycQALuipleEiorzLgMk1CNnNbHpPD9a/3b?=
 =?iso-8859-1?Q?YZlkxSUeQp69ZFW2OQYKaJ1uU1ToXFmnglSmxVb5S/bHeSMX6gu+iMNcr0?=
 =?iso-8859-1?Q?oXRaQS1NXe2XoCjRdu4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <ED846D1336C5094F885BA8CBE5E19C79@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RGj56xEjK3f30ezrCEsnRIO243M7J6NS6IY0G2VeA3dbD2qzaW6mVw3nmCO/tDCTF+9RJkfLxS9Ij97nrUM7CIfTG68AnMBnzaqYB7HX12VZIky/QVdSNBemPe1gt94eJ1kPdKvwJo2RvwpAx+cWKBQxofyGFlR+feOqjR8olxeM9d+5y0Z7GFGV5ka+5NGK7C7Je821XfqKHPrwYyfmYv0zYD7I8J+QkmHcVhP2793kK5qq6havWHVtHa9l3TjsVtqKbnL4g+jbodxJnfvxR2KPfr0V8b21IWH9j+dBW0LJNZXTM1U5B6LgHhuaW4C5VQWd0sF1Sqi+Z4HovMNOFKfdQA/RGToDcATjRMsHSAdO4y3YFwpVEMVccrmbEOCwWeQ0Owd9BjOCctbXCMVBr3bGVm35n3IM1voKdNiJPc3e/xrBGggBeQAXiYr4S/ic3ZnDv8nC/t5Rt2CjVR3/r03B6+Qo0Ug4slL58bsRF/olr2Vk1MZa6lSyveQy+J8kna3+FZ0kN0peuUlv7mYeLA983SxqMz3rCrzlUa7m3w3h2E56HWD36tzYgZ67xVy3sHYJuHCCkalLSdTazEophY1yuYDRK+dldkO6kDjlgXqhh3b+gPGjDL/1zmJiF8+P
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b8ceb49-7043-45cf-ae9e-08dccbad9fa6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2024 00:16:14.7809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fCZnfuKUnr8JQsCD1+YZSB0jEXfE4jICUkdHRlHALt0X5hI1s5CiW3ee8aKvagKczAnaHgFvE0tk17Vwls6PBs895+vNCkuK4D9+86ETq3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB8583
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240902_171619_665855_DB15CB04 
X-CRM114-Status: GOOD (  19.99  )
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

On Sep 02, 2024 / 15:53, Martin Wilck wrote:
> On Thu, 2024-08-29 at 07:36 +0000, Shinichiro Kawasaki wrote:
>=20
>=20
> > Shellcheck reports a warning here:
> >=20
> > =A0 tests/nvme/053:47:9: warning: Prefer mapfile or read -a to split
> > command output (or quote to avoid splitting). [SC2207]
> >=20
> > It is a bit lengthy, but let's replace the line above with this:
> >=20
> > =A0=A0=A0=A0=A0=A0=A0 while read -r line ; do ctrls+=3D("$line"); done =
<
> > <(_nvme_get_ctrl_list)
>=20
> Thanks for the review. If you don't mind, I'll just use "mapfile -t",
> as suggested by shellcheck.

The reason I did not suggest the "mapfile -t" solution was that SC2207
recommends it for bash versions 4.4+ [1]. On the other hand, blktests READM=
E.md
requires bash version >=3D 4.2. So I assume that some blktests users use ba=
sh
version 4.2 or 4.3. I took a glance in the bash change history [2], and the=
re
are some mpafile related bug fixes between bash version v4.2 an v4.4. So I =
think
it's the better to not use "mpafile -t" in blktests.

Do you have any specific reason to use "mapfile -t"?

[1] https://www.shellcheck.net/wiki/SC2207
[2] https://git.savannah.gnu.org/cgit/bash.git/tree/CHANGES

>=20
> Martin
> =

