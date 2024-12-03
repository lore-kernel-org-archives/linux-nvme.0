Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 203EEE64AB7
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2024 14:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6GohCIQRAcLSYny+42muSoNkm+OYcL1t+mOmK2HZ2u4=; b=ZkeMlMf9s7OV3COgu/BfITD83k
	YxkCmvEfkNPIO+hv3VsbK5gxnGoXM6w2KLeW9kUW32I6P+Ms5nRdiLh0H8poUoxxRc6mLhC8HUeaO
	Ynv5mqqc0ElP3L0Y/ms26S3GtoH9XJKhA2kpugxzZhq0/7KMFjAHx7Hdqk6CVi4vXc7jnk3xDnR7v
	8ZW7BLhSyyEa09zL59BloEc1//w57k1Mra2ypGxpC66bZ3Vvs4GFgOMcBZnpyU8l4IJ3DmxLO9mgo
	uHMXDx2nZGk5rY0wgzDYwXbcCofggJ+PU/2TIycffSgWVEFnxaRUQDWpXpjCVcsJDKW8R9Q/ramCu
	V5LtKphQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIUEA-00000009pV0-0rhA;
	Tue, 03 Dec 2024 14:50:14 +0000
Received: from mgamail.intel.com ([198.175.65.9])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIUE8-00000009pTY-04yw
	for linux-nvme@lists.infradead.org;
	Tue, 03 Dec 2024 14:50:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733237412; x=1764773412;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=6GohCIQRAcLSYny+42muSoNkm+OYcL1t+mOmK2HZ2u4=;
  b=lVQvBa1YKtuR9KeAr7iLtJRMySNHg04Ivyxuu2VmtlxBvV1HpMtRu8Vz
   qi7CJKdn+h6HqE0hmPS9my7LFuYqUgmR9Gpbl39UJEgnT+Lw60/FY6HzN
   OqxCDVwwLXtdUuoUMxofNA9+GcM/OhhhocZ1jZm0wLxCCveaI8sG5tego
   wB4wUXhMERBCTU+cjXCfUwUk4sYMaUOphiz3hOq8aZrYFFopuBdq3jXjy
   czTcMBnxy8THaCv3UjhrsMg++cOB8YyKFUTVT8OZVXroWYUtG8KL4bb7o
   dGmsMtNfFMzqa4aXyS9Cj0g0hRbLPjpN1ZKPOivjQ6eVKOGPv/TMTL2TW
   g==;
X-CSE-ConnectionGUID: CVvDV6uoRNCQsvHSF/GSvg==
X-CSE-MsgGUID: G3JPGwqsQl+lUJTfV3vf2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="55939991"
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="55939991"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 06:50:11 -0800
X-CSE-ConnectionGUID: /WFhlr8yQRGAbSQH001YGw==
X-CSE-MsgGUID: YN2sctLgQaOOE6INAvUEEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="93651918"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Dec 2024 06:50:11 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Dec 2024 06:50:10 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 3 Dec 2024 06:50:10 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Dec 2024 06:50:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gKHa0qetR8D4zMYcoOEDlSj/FxS0qHc3AxnFrvBOx1R2GqxadbWufz6PoC2kI+jPYCBYoknQpp24qpWuz/t9hyy8Xr7XjmKNnV/ukiHHDaqaHJHd0ShcSYCgpCLf5zl5lT8rGuf4H01MWTCJ/xEaIR7JBqy1rT4azKIz9xtSZD61D5wvYe3fpXmKQv5cD8axX6Ga6IqWxbDuVoNzu7Cyp5B/DiAB1/zffuR1tHDbOqu4WeUQrfDCi6z/ntPG36VCzAILhUgy+JWuxe1G7ZZOQ+Ud805764aoasS6zhZbnVgUnHwuF38g+Li4MVCbNJlNQ2XFupNnG9amZv4Ano6P/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6GohCIQRAcLSYny+42muSoNkm+OYcL1t+mOmK2HZ2u4=;
 b=HVKPGKih7zIZGbPAehD3CCt+u7no/wzqsAd6+uJOvW5ZvF4tNkvzr9InAn/RaIJ7sbSLJpXX5X/Ak0/Wto414Pqd/8WstuQQyp003fIddNPBL4VEHRR1KduyiST5K4tDMFcD8KAhW1bAOJT6ud2jo9WCyxAjQlzlb1eHnOkZOy1SwW2kd9SsZBE8t0WPUDABFvkPsV7I5B/OGDXvPhAWJqei9QuYjt1TxlSqvlYBKTscGZjfmNczJRWP/D4RuKZ+UJ7Bpy+Tps5jBKQbPuRZNf3PTwkhs5lnKbW8vJZQyrMEdsdPJ/uDAeT0Zhq2FHG2goDM334kPDxroZbKWiQ7cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com (2603:10b6:a03:488::12)
 by MW3PR11MB4668.namprd11.prod.outlook.com (2603:10b6:303:54::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.20; Tue, 3 Dec
 2024 14:50:03 +0000
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::21c3:4b36:8cc5:b525]) by SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::21c3:4b36:8cc5:b525%4]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 14:50:02 +0000
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
To: "hch@lst.de" <hch@lst.de>
CC: "Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>, "Saarinen, Jani"
	<jani.saarinen@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Regression on linux-next (next-20241122)
Thread-Topic: Regression on linux-next (next-20241122)
Thread-Index: AdtFkL8iTqxzS44UQN2+91v9hKmHXw==
Date: Tue, 3 Dec 2024 14:50:02 +0000
Message-ID: <SJ1PR11MB612981085F570BE3C81A665AB9362@SJ1PR11MB6129.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6129:EE_|MW3PR11MB4668:EE_
x-ms-office365-filtering-correlation-id: 599b8750-03a9-46a4-0ca9-08dd13a9c4c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?p+FDD/CHKNGVaOPnCtpLetp2DFhDx+ID0jPD7QOk7emGGiXrkmMZzIZkoT?=
 =?iso-8859-1?Q?TX55YisM7g22aub+SugUHFXQ912D1UfCb9FisacbY0pFpz69cak7blJmr7?=
 =?iso-8859-1?Q?rw3oNrT5XyyiHJUgvrRg0up/K5UzwiGfvYslZdiIzXLmLOU+z5Hc446jKi?=
 =?iso-8859-1?Q?ZIPTTfPjyxKHcKAZeW1DnR+RC9ph9hLpwUB8mhLYICcfNJSa7js+rtcZvZ?=
 =?iso-8859-1?Q?arvntTZd9gVxVTtVwfj7IrYQwLUh6TVB+64EzBtnJMBZDrpJklCgKWZdrw?=
 =?iso-8859-1?Q?13a+MW0gsclZYWyhM4V/5PQNfkO1ReMeKdb/TbFVjhFV6j+YTeazxd78su?=
 =?iso-8859-1?Q?EI3pnhAqmen+sgQUpj0qzkyj3JqpAGtYSH5p6Z3ToF3zd2vKBpBqbEMoby?=
 =?iso-8859-1?Q?BIkhb6MjZI8klDbOQx0JSwjW/o/Grkejng49YN8jGjL2Kr9VSQhxPnTGc9?=
 =?iso-8859-1?Q?rHbu7iMS8yEJoHMwoDSD0wxRVgngfaZtSK55mD5Oy/Q2xXotb5nqurY/8j?=
 =?iso-8859-1?Q?Y+uR+lHUS5PxtffKphOrFPhKhY+h4D7hfybDl0+GuNkSkhLr5k1cSkhO1p?=
 =?iso-8859-1?Q?v+GFfFItE/48ORn6K9tOj/IrpvMXDc/6vW1Xmxut8xP61wS4jQYdNN/gY0?=
 =?iso-8859-1?Q?6/ApZiOz984lH7HPI2X1A/gBNa5PNlgd8/CcRLzKaHQOA5W2hBl3gGLyY5?=
 =?iso-8859-1?Q?tXQNpLp6rCKwrn/FXZ9B9aDIpUdgm0qr5CZW+medKL2w+EHIj+TVSNTKzU?=
 =?iso-8859-1?Q?X+HQwwtCFkichsj673rm8N762aJWJBFYvfs2xaRW+TyII/fHXLgKM0c31t?=
 =?iso-8859-1?Q?eFsWrmqHhetnsSEg4t961bKI8XR6XtvJFnZ+DVUrtDW/t4NdrkEHw+aQDB?=
 =?iso-8859-1?Q?6yZGxGPu8U9TFomSfaJxnM6In1BxuiDDp60Cep3FkcBVX6DRoGWZqvzPce?=
 =?iso-8859-1?Q?BUKWtxpvxqnOIDThvJ/xnF4qzn4CfrKF+JGRLy0rMFlzssAPt97Tc19i5a?=
 =?iso-8859-1?Q?xicpRo59hiVaWH1WCUY+I6QTQJ15hLlzDwz/2IgX3oTu65kcoRjekcg0oA?=
 =?iso-8859-1?Q?/7GvkUR5f/7ryxT9314Gkpe7lyRo8fWssUVHQQOfk/GyIy7hps1troD9pa?=
 =?iso-8859-1?Q?E36FB2MUyUm6fcSl5TstwuMJ/1PPAIAVAcxkd/Em/Q6X7QijCntzt9iRMg?=
 =?iso-8859-1?Q?uE1oxb3raH6CVJa+n8RWwoxaag0xRcANHlz6PTRT4uF/MtpcxyBybUywMl?=
 =?iso-8859-1?Q?dZaMU7PyiOu5dVogeV2zFMOrPO8OkZ8Fw+k88hV7NvGyB/UVSrXba9yGTT?=
 =?iso-8859-1?Q?5mG5sOZgf+rYM48yOE6pGdCH/4O6aq+0GZUaRFydgITgYZQRluT0Bw+/x5?=
 =?iso-8859-1?Q?BUfm6rOLJTneFbeU5FdaWJzBswAkP4zYd07leS5cx1G063HTfD/dQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6129.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+LvnLLt86J9VUbBaNjuGNrO60swflqTm/JOz0q7XhYK8o2CK4FWY0np8Gk?=
 =?iso-8859-1?Q?YvVomvZzKeQrFdu/abStxXcDUmSeHXcYkvvhy6OQwzlcx0BUNWuRYvwdy2?=
 =?iso-8859-1?Q?boJQu9q10QWvEFjuoHCDqc61x93ADJuJlNqZs/C2dXatTRnHoyJyt4JYwA?=
 =?iso-8859-1?Q?EDi+zp4mlFK/JTyG2Df0F7ELsgTuXCP9Th6hF+JzRggW1En2ZLzursPfDS?=
 =?iso-8859-1?Q?PouFLq8wpuqDE8q4bZNJ1jlQ+M0up2MCJuZBqJYJog+2HaalZ7sM/2iblD?=
 =?iso-8859-1?Q?b9wYnkdz61Lo3VWM1Q63FYGAFOYbWdcQrEAHUdDr59eq5KMXBmBNbKLC+b?=
 =?iso-8859-1?Q?1+83zQCR+YYRI3UaVFwK/6AO5kuSKgmDUJn8iETvogYmmoASXZsNI3/g4i?=
 =?iso-8859-1?Q?ccpTrXbekN6jbCmYD4e7Nt1gfHQy7xXSZp4VNRYZwDn5T6oyaSRjN54aey?=
 =?iso-8859-1?Q?BgJch54REE9lmUYYhguz1jMxjb3OuKLsj0y/38WoGdimUhUPTrE1W/tnCj?=
 =?iso-8859-1?Q?i1xIfMRsIsMnR8goFOlb4C5GyUcHr4EyUNJylf9l0EBiKg4+DIlZYWH+3s?=
 =?iso-8859-1?Q?/Oo+LYrZabsT2RBIbM/wT/gAHX2OtQkfD6NTU0TRvs5wqQSY+G3pObYxjZ?=
 =?iso-8859-1?Q?51xlVsASwnZavRp5XoA+/CH2yqzG4vaudH4VrQzzA6eGoQpPhtq2w9KgK+?=
 =?iso-8859-1?Q?CKbJCou1hrUIaLYK7RTcZX5oXiR0VOKxSYS30XMT1dOi5+vbjyqCCXD6II?=
 =?iso-8859-1?Q?To1vlF7j3Ci5wWH3n5JTSEBJPE5z8GsHhzG4KO9EoHe4NO5ky3EryvaQqp?=
 =?iso-8859-1?Q?4KEeegzsRMnly+gsYQmsmbUiE2A3dfht9EGmr/CTS8kWlWAyzzHhJa8CkJ?=
 =?iso-8859-1?Q?L/ZEkRAdbhKbLXy3nqXI2pLeQ2tYuZ0t68fS7yHnroZiw6REQtuyBDMGeU?=
 =?iso-8859-1?Q?nsLxRZjMdPz0xFiDKIKvv+2hOhcmxdUdGLboJ0RtFLSJ3S3jAkIMx4hhaU?=
 =?iso-8859-1?Q?80FuGARwE7qojDSlvyY0KrGxbKTc8xz+mYKrPGO0knelF5sY+sDOnYRjwF?=
 =?iso-8859-1?Q?EKQnxrBe6avQXdh+ZeBqjOS4KWiS6lnIZAo7UOz+CpBaMwiMrbjs6dd9by?=
 =?iso-8859-1?Q?jAkmLNGaKZgyf/TBuzFrrX3tnmP0YUlIJxlaJ6FhxnDaAejjL1TMw/QAk/?=
 =?iso-8859-1?Q?EqgKF48uRevuMv3BTvSXocxREYxPF2i7vcrm4dpKVMduCazORRJaxxwk09?=
 =?iso-8859-1?Q?KWQDRfaFULDs89FsvZXrMmfz5sFSGILS+NqLN1usLNRDzdjwvQ0vGfu8U8?=
 =?iso-8859-1?Q?Lb3xW8RPR1IDT9Y+a4OdEHGiPYWMXUh/KmB+QNeDAUVDWyQzG71UHR0mXi?=
 =?iso-8859-1?Q?vKKCpZXPoYrFwoAKsRWpVO+RPUCd51nDYhkEVGoYEyWPqmR1pMdo2Hs8Yi?=
 =?iso-8859-1?Q?TrmJd035Rvim4TkKstcY/5YLvPbOIKibSSYtrBVtPtMt4REqD+gciia0I9?=
 =?iso-8859-1?Q?uKJQVjKJD1dYHoO/bmLRO1VyfoYFVcOris50oIpl1eS1eW8vh8k+zBNpA1?=
 =?iso-8859-1?Q?GOti5qIOfElwNOFgeTNbPnBmw68wW8uVWkLehLKD0wOz/CerpIv9ecyMPx?=
 =?iso-8859-1?Q?od4HiVevpaXHG4qVlxoMWTtojDrtIKu0ExnkfM87cw5A1Wn7Zlnq2Ghg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6129.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 599b8750-03a9-46a4-0ca9-08dd13a9c4c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 14:50:02.8131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yQJHVYj36vO5djHR1KwreP8asPcVssiJJJEZKURGMYtHeBblgGnY+hCjSN0OVzKIq8w19bx6ZvEblUk/OQAUW4BU7cKPRyotLN13j+G90LE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4668
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241203_065012_112339_A927C2C7 
X-CRM114-Status: UNSURE (   8.26  )
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

Hello Christoph,

Hope you are doing well. I am Chaitanya from the linux graphics team in Int=
el.

This mail is regarding a regression we are seeing in our CI runs[1] on linu=
x-next repository.

Since the version next-20241122[2], we are seeing the following regression

```````````````````````````````````````````````````````````````````````````=
``````
<4>[=A0=A0=A0 5.177548] WARNING: CPU: 0 PID: 11 at mm/page_alloc.c:4763 __a=
lloc_pages_noprof+0x1425/0x1470
<4>[=A0=A0=A0 5.177560] Modules linked in:
<4>[=A0=A0=A0 5.177564] CPU: 0 UID: 0 PID: 11 Comm: kworker/u80:0 Not taint=
ed 6.12.0-next-20241122-next-20241122-gcfba9f07a1d6+ #1
<4>[=A0=A0=A0 5.177574] Hardware name: Intel Corporation Raptor Lake Client=
 Platform/RPL-S ADP-S DDR5 UDIMM CRB, BIOS RPLSFWI1.R00.4221.A00.2305271351=
 05/27/2023
<4>[=A0=A0=A0 5.177584] Workqueue: async async_run_entry_fn
<4>[=A0=A0=A0 5.177591] RIP: 0010:__alloc_pages_noprof+0x1425/0x1470
```````````````````````````````````````````````````````````````````````````=
``````
Details log can be found in [3].

After bisecting the tree, the following patch [4] seems to be the first "ba=
d"
commit

```````````````````````````````````````````````````````````````````````````=
``````````````````````````````
commit 63a5c7a4b4c49ad86c362e9f555e6f343804ee1d
Author: Christoph Hellwig mailto:hch@lst.de
Date:=A0=A0 Fri Nov 1 05:40:05 2024 +0100

=A0=A0=A0 nvme-pci: use dma_alloc_noncontigous if possible

=A0=A0=A0 Use dma_alloc_noncontigous to allocate a single IOVA-contigous se=
gment
=A0=A0=A0 when backed by an IOMMU.=A0 This allow to easily use bigger segme=
nts and
=A0=A0=A0 avoids running into segment limits if we can avoid it.
```````````````````````````````````````````````````````````````````````````=
``````````````````````````````

We also verified that if we revert the patch the issue is not seen.

This is now seen in our drm-tip runs as well. [5]

Could you please check why the patch causes this regression and provide a f=
ix if necessary?

Thank you.

Regards

Chaitanya

[1] https://intel-gfx-ci.01.org/tree/linux-next/combined-alt.html?
[2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/com=
mit/?h=3Dnext-20241122
[3] https://intel-gfx-ci.01.org/tree/linux-next/next-20241128/bat-dg2-13/bo=
ot0.txt=20
[4] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/com=
mit/?h=3Dnext-20241122&id=3D63a5c7a4b4c49ad86c362e9f555e6f343804ee1d
[5] https://intel-gfx-ci.01.org/tree/drm-tip/index.html?


