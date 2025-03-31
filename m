Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BDEDC28B20
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Mar 2025 02:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=rY1T1ip4TI8euc2v4gvg+uMFKx9b8h8i+utaYSGbP0E=; b=lCdk4EInSOIzOP
	wJ1TDfkGxwaHp5ulo1qgGwAD1BGWPh8hfx4goU5X866Re+U9QIyXpfh3frkxEtOxAsgphONkEpu9C
	aOCxyUImbDL9x0yG/5NEMdWdr0iLDd666F611ucN81r+5ocQm/sU1ss9ZVmRCvq0gm7/5zN6eyZlw
	mwnCY7gk232co1HduLC/Il8twkMrxA6GyWnVsUSGbkltoRvxtGs//Fjks7tQskc8cdLzvsb2jsh5+
	hsSIuLbVKmjOkLt2yUQioNL1QEHyvkD+jg+FT6j0zfCzsua5O7NDB5ZmJU2/ukizFdpymkMztkpgS
	v2T59arH+ysRugAD4mJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tz4th-0000000Gv5q-2iaw;
	Mon, 31 Mar 2025 02:29:09 +0000
Received: from mgamail.intel.com ([192.198.163.8])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tz4t3-0000000Gv4h-0rqJ
	for linux-nvme@lists.infradead.org;
	Mon, 31 Mar 2025 02:28:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743388109; x=1774924109;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=rY1T1ip4TI8euc2v4gvg+uMFKx9b8h8i+utaYSGbP0E=;
  b=GkngdYs2lnMfKnMx4HxKJDFkmMSExr12pPwoycTFLXZ8Tawbe2cxZc8M
   c3hVeK8BcEwElJgV5+iShMb/6/qtl5ZjcX/Slzj7brcRLM/7ulcI19W62
   Q8+c2frk/XTZyszU8bL/LF6KbpHacOcKQKTGzc+mGZqwORLMttRVrJ0Nq
   UI2V5DAvaE2H+vf3yAo77bWzTS6A+lbisIyrj+gtDJoVPXcReQMjAOO2B
   6aeYA9UjM53c1RgInYG3+WEh08xyT6Dm8EHPFJEVSasklaQk4ubQso6Ln
   qbfU1vxWvBr2X5Vy9gj45SqvQjilVDWtrdTMlH2UKEX3e8WG+XHeKmx/7
   w==;
X-CSE-ConnectionGUID: TqpTvOdlTKyYdQuMBf5i6Q==
X-CSE-MsgGUID: WzHF+8jpRCaVjfAQGx0B9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11389"; a="62201783"
X-IronPort-AV: E=Sophos;i="6.14,289,1736841600"; 
   d="scan'208";a="62201783"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2025 19:28:23 -0700
X-CSE-ConnectionGUID: iWWc2ZASTJqYeqNGrGoEvg==
X-CSE-MsgGUID: Lnc2T+BvS1+YA5Q4yMAU8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,289,1736841600"; 
   d="scan'208";a="125793679"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2025 19:28:23 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 30 Mar 2025 19:28:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 30 Mar 2025 19:28:23 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 30 Mar 2025 19:28:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JSh90WZk/Isl8ZYIZQWo1hpBPeZgqiSkfkujnaZcsySxE1ZYMKJ8GIZNX2guvU0A078/TmrdW2I8K0pv3r2f3IA1T7TEGLGarNpHt1urkdwFhfkJGWLvYlxwP8dpoXIvshOW/bxYiKSB9WZfXG2v7x9MNRoc7qW5yUTzShDKDuRpOl6AzJi0xt2b4CX6QsFiibgTZB3mmRdsS6TAGUIDpFOIfQnuReBtJ7RqrRbkyfbVsrQYZuj2KOe6StfloAWv25wk3m2IL1T2qxy0+ZT6IbUcps6Vm7M6e2hFAKDkNBUHCojq10yUcV3Ui7G+CZFlZU8QS8T8NVJmfF8s0daXXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rY1T1ip4TI8euc2v4gvg+uMFKx9b8h8i+utaYSGbP0E=;
 b=F9gS6nOzv6qneQvu0dKwG7ylo2/4RLG+x5GJeS7MEz3lBJVDKcVT4OsSyd2oOn25erzT6ucxp6p29/Pk1p6V69e9SBodLWhv0hUH6lIS20EXhqgYvaBfM2m79QkfMA4v3ZNq7rxD6Yqw9ZNCJ+47vK/HiAmaOZ1+P4zQkfEtSVy3s4AdqNKot1cwqOGyaj2Cd/YLNc3Nw8I2F8VLJPHZcsEQLVrE1A3QOf3ooyC129vz23T8oj78e56fcSdEMfAEfwNq8iCmoMsJYBUNESh7HrfNKEH+YlilIy/dXWQlygmhFTblYpF/9QoVyZrfjIfR4snL7gkoTUlxCI/w3wFzng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB2646.namprd11.prod.outlook.com (2603:10b6:a02:c6::32)
 by PH7PR11MB7052.namprd11.prod.outlook.com (2603:10b6:510:20f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 02:28:20 +0000
Received: from BYAPR11MB2646.namprd11.prod.outlook.com
 ([fe80::418e:2162:dce8:2bf1]) by BYAPR11MB2646.namprd11.prod.outlook.com
 ([fe80::418e:2162:dce8:2bf1%6]) with mapi id 15.20.8534.043; Mon, 31 Mar 2025
 02:28:20 +0000
From: "Yuan, Xin" <xin.yuan@intel.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Questions about I/O queue number of NVMe device
Thread-Topic: Questions about I/O queue number of NVMe device
Thread-Index: Aduh5BCMNKLrdQj0TZe8a+Eepzfx9g==
Date: Mon, 31 Mar 2025 02:28:20 +0000
Message-ID: <BYAPR11MB26469ED9A1BBA947924D551E9DAD2@BYAPR11MB2646.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB2646:EE_|PH7PR11MB7052:EE_
x-ms-office365-filtering-correlation-id: 797f69a1-a77d-43a0-b9f3-08dd6ffbb3e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?+f+SIIyUdLGDKY7OGBKzP7st/bEYNlksIbcFVsLcvQ7GfFsMLMQ0GBDRh2lt?=
 =?us-ascii?Q?EgTjHhPPEN/w7luXDoEOgNoJzb18sAv4sK6gcMoCg8sxvTBlfXlRx9BqppoF?=
 =?us-ascii?Q?dgo0OEjUVqnRfPD9j7Oct1qL+x5GybgZNYZ4NO5JTxgyiiZW/Q/+nXKRflwA?=
 =?us-ascii?Q?159gjFJYn+SqSbIEIt32kWuMuOSKpmKs8mjBILSS3FygTNdpf0c9kgKMjCgm?=
 =?us-ascii?Q?3nGZFawRid7mkpthC7qRhyQm4EdpHjj4HoWlVwGDqK0Ss42foS2nDYanrzI8?=
 =?us-ascii?Q?iY6iBUhstIHPMsVDcQrnzXnT1TwkWqzCl9H7svIxxe1+Mc1PHHcSdrhVeA9s?=
 =?us-ascii?Q?7Ifif0fDFLC6WpTnqhTfw3BRbNe3j9OpktCNHgnXDt21HURCiyXTmcUZwlUj?=
 =?us-ascii?Q?lvHhSMYBVtuOPjXyO+DAmJT4n1KcUBtIQNNAb9tSce9alKw/x3FWgz6UFMDi?=
 =?us-ascii?Q?82ENKLS8berqX8wxxkZ/z84w8p+/YIzWY6TDt5hrZpKj3feYP+XP9cKglDXr?=
 =?us-ascii?Q?66DnAeKozuB7hC1y1uXuP9Pfl6OyYkeef+q3uu9Y/Zy6WPRlFMyiPNfAwES2?=
 =?us-ascii?Q?x+uBOlEFT/r5CSlGigoyZbtwLL5EWxf1Tr2Ug2n9/mYwWrY9O9ttatsl3guT?=
 =?us-ascii?Q?Rn+EMGtKf9K4Ruip8E52TpUxU6Wzu37HK2iTEYLRJ5TbtGY1PQfJt0HQIF9Q?=
 =?us-ascii?Q?InlrRVqiA1W8JpjHzOJIgYily78jrshLzAq8L7TI7Wh87UHKJ01JudZtvA6z?=
 =?us-ascii?Q?clUNrTL9tchVRV/3KvPSdps4meKZ4H50g8qsJODNasP3EWaCZmFF5zU2ylIg?=
 =?us-ascii?Q?ZyeEbP5mkVyLbWdoiTku5zZkOzZpT+mJv9WPim6870PVkVRNEMfYX7+Z0KyN?=
 =?us-ascii?Q?sj1uGIreggO2PGsMZcIHBXOxEzm9U4jUSBytSvhakxPw4xRnsNYPTPc+l3MP?=
 =?us-ascii?Q?aHXa8FAPY2K54BlmXuBXcmJYpLj+4V2dVUmOcH8VDbWIJn+2gbsEdIoDuqxm?=
 =?us-ascii?Q?2qVufD1wEAriFNohl3Gq5I9gNym2VEqqdBnMhhWkj4Hg9553/e0vSQSxdWKp?=
 =?us-ascii?Q?VlTJoqFMqm/3oJ1hlE6LMpsvBtJQe062EFxeOtGuI4tp7qCkEZ5VXj2YyYGL?=
 =?us-ascii?Q?0lXvtuiyhaiqyfLn2b0yuKbuzvUnkaQVJgptdM4e2y8173FErlzjKm+zWQuY?=
 =?us-ascii?Q?YjnmANi8OB+qjZVO7JM2HU8JiSs7dVDyR+xVBmivP2ouQeLSY0F52vslrL3/?=
 =?us-ascii?Q?ZS2a9ML1DGQ7TRxQeSsmIC+Ysvfu2Sjw7OusQcRLvx878J51kfmKcOpmA/v/?=
 =?us-ascii?Q?5sPUcOL0KIwxZwTFN02I77PZ0JLWjdYAPStq9tMvzS/dvweLF+f1KxK60F2T?=
 =?us-ascii?Q?0n4e64fOnldYfmrJdxjgabT+9yArd2PckqT3mUXl5tbXdz9Sg9m142P36f6z?=
 =?us-ascii?Q?474DhqitH8rRar6akPYpZzFwuS5Lo6jh?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2646.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?E41dOoqlz0OKqPkmCgOzoeSILmd/mu0Zh99TuDKz0hC0hypmDftg9L9lKISi?=
 =?us-ascii?Q?4GUKterC4M1IJ0jTyeL+9jhdjC8a3UylHqO4ixEMK3Y9pHtBxXpdTNZhDE2o?=
 =?us-ascii?Q?gdxTg0QGysOHTeLOSxExWGuE4OPlGcWZ14FYq652mfiGTXljYctQb3t10tV0?=
 =?us-ascii?Q?FvN4JmkLGeP98QNskwBmv6Xq3/b+lHQ9jzHITXnwoxd+kJDG7dKLqqkT3Rq3?=
 =?us-ascii?Q?kfhTKGxGjaXef3tnMvWa0boy0B4Spux02zXeRPiOBPRPiA4M8XYsjxZbtfLG?=
 =?us-ascii?Q?+eLF38gVRHQndU25FMbrJw/oY+I9+e4gMQtbI+vX29v74G+207WtXoPp1/fN?=
 =?us-ascii?Q?KA0Lj79C4bK96+jzIHasPVnq8WfwmmM8vK3BhxFiWvQC9tYvDMPr1qDorLbK?=
 =?us-ascii?Q?9AiX+9dW9Y/F3N6XGUOULusxjq51xTQM51vyyp8Oav8cAt9u4kmKqJ7mFmMA?=
 =?us-ascii?Q?2xt8YGIogAKnG2lE25ospfngh2SOiOPkbNzqV/OBz/izgXl0Zwzr1mV4LLZk?=
 =?us-ascii?Q?UYSBSol2RVigP57SREYqR30wUShregBPJtTYbqFDbL2JDU/4KyurgYXS08ND?=
 =?us-ascii?Q?GujFrtX4WoXbJHsiWM+ocjL9TH1SCw71Ho3blL7y6oYbt1LQ2X4EjUj+UVDy?=
 =?us-ascii?Q?wAAJ/QumnoY55nlR27Zz49eTWiFySAiFMQllS/MTQo5dzfftb56uKchARSkI?=
 =?us-ascii?Q?pTVkV87MnrOtvTetb/sV9iCYxbWicWFPLstZIvjoae2Q+tw0K66kw6aK/t3G?=
 =?us-ascii?Q?mnr7KuWklLRN+3ro9MBmr4h7esStdO7h5LUFxyTN3Zak/V96hgDeapFup2H5?=
 =?us-ascii?Q?IuMgGNFqIpveO+hNdz8E9YLqK2fdEZFkN3KrTziEAs77nNbUFXrlg8XP+MPN?=
 =?us-ascii?Q?74dlb0gN2cs4973Lt33Oywu36gHT7ZfPVn2t7klNjW0hyuTsmp3uN6Ncp+56?=
 =?us-ascii?Q?EfcLX+oC6OU5TwIJwzKI9peC+HV4rY6hQXQeMc8I7Jd3q0p4VzfxNOhJTuDN?=
 =?us-ascii?Q?lV1M3cg1U7/3uG/hKc4EgL7bTg2w1Ld9UuRwcMfD0Rc7sKUppVt1UcMg+sbG?=
 =?us-ascii?Q?GYNI+HUg0fvD2Uez1MB/G1xjiqizDEPCXZQF9+6TPcIRtzlzl1lL9wP5Tv72?=
 =?us-ascii?Q?FG4ZVw8yVAm6CWAWgju1uBpLoRfx++VKd0h42FPNGGzsfoABA6rxPNP0puGA?=
 =?us-ascii?Q?nU5hkQ51FTET2OnBL2OkzFlmIGztbk2Np2WmN/neawyBMhIAYlE65bpnKpxL?=
 =?us-ascii?Q?bOuhTXhLAsTaX78jYn1LNUr4owtZhMRKzFA5bNf8sYvViaM2K0iKlAEV4AB7?=
 =?us-ascii?Q?STrD2fbsQu5DO3UUH7+K3iDChtKkgL0nLUcDWuNYnm6cKck2EElbeD0meZVH?=
 =?us-ascii?Q?jP0Mfzs+KaxaMcVgYOt4xnwotrTrUto6Jf2ZZ+cIuOE9jIw2Q+wJvP5YPs/v?=
 =?us-ascii?Q?6QjNaMzDq3jS3Mga8MPrSz2OTmP2QgUjeuLppMY3ra13zvQ3x0aSmxxTAzfE?=
 =?us-ascii?Q?xwXfAXRMBqONt4bem31E0p93JO5LZBSFcuRghdPkketxHmfUDsZdKjKYbitK?=
 =?us-ascii?Q?AU+lczCo0MZR6zCs5xo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2646.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 797f69a1-a77d-43a0-b9f3-08dd6ffbb3e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2025 02:28:20.2023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zmedwTGyaxiVXSoEG/bu/33AIdIyXPuuDaTWIJ8K7nxZIV74VfYP13bDuzQp8v5ZrYxoLWxHyKxFK50AxnGrjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7052
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250330_192829_258619_1894C876 
X-CRM114-Status: UNSURE (   7.50  )
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

Hello,

I have question about I/O queue number in NVMe. Generally, the number of I/=
O queues of NVMe devices is equal to the number of CPU cores and is evenly =
distributed to the cores. But in some devices, I found that the I/O queue i=
s limited and less than core number. For example, I have a 14 cores platfor=
m with Kingston NVMe. But the I/O queue number is only 8. Is it the limitat=
ion of NVMe driver or hardware? By the way, I cannot find the I/O queue num=
ber limitation on the hardware datasheet.=20

Thanks,
Yuan Xin

