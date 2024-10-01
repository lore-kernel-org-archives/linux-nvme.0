Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26626CE7CFF
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Oct 2024 09:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ezzC7dEUSyV/MZPWsQycB9Pd73So6aiC/T45/whr32A=; b=OQ2Xd7dQ2ZedapU0aJun1ls26I
	Rt2fLfJzTXCbJDPqykHmfTaQFQtHJ2YJxLTt3NVe1i2KB5bqHyCkbVKXVWnZBqyG0iugukUGjJkq/
	M4gCte2AMsNM1rkTtLn2/7trHEZZermTi0dzviSAowqlwnWjOpzUEDOFL2ATbyTbF92yJ/9u83drP
	GKDWjaRddAIXlO6WDnuFz7rUHMuAsG39GalqJLZ3WN507XUbyrhbC0UtIOvL5bRdbobzePKNSLLRK
	3q/4IQ9DqaitBA3jhPknynvb4VdLzyqHsc6KT58Lz9s8Pu7NgWdQEuYRCkDIG04SiSDciVpKvtGn7
	3xYGfKuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1svZKr-00000002FXP-0HCz;
	Tue, 01 Oct 2024 09:38:25 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1svZKn-00000002FWH-1q1B
	for linux-nvme@lists.infradead.org;
	Tue, 01 Oct 2024 09:38:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1727775501; x=1759311501;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lIGeEjwK1tDmwq2sG3QCI4tGbcMxeYSchVwVJXKglEE=;
  b=oo/6xYKdNRqYsi6OyHvzoR1vVO1rdDtt9/u5zTed3dskXObQk6N8QnDr
   e4WbOPfNYK9XXxO/wnlaaLWqwC1tRmr/Glfwctdvi3QwXyES3/lSYpgOq
   sNKQ7JRsYepPIg2ABbOtTI5medzQI8P+pggT8gbGihv8S5p8f+1B5mJrG
   Awi0tja4ZbbHgnHjjBjTjtmHubFUK3QQuEhO6EY3jnA2Qy+fXLV9iMVrB
   Va/TQ2sLL3jQtrhr5K6dXHQQD9fy6hoKm1N9ciHrQjK+1Y1rqsgBYcCJk
   wuwxl/f7ToAkbtLDRAzirtD6HI7qQhRZDkn9P7bAEtC2/hCtx5ITdw5nh
   w==;
X-CSE-ConnectionGUID: gsFYGT+3RWGeipPQwebIIQ==
X-CSE-MsgGUID: jvtWbfq2S+ac/7XSVAECPg==
X-IronPort-AV: E=Sophos;i="6.11,167,1725292800"; 
   d="scan'208";a="28875369"
Received: from mail-bn8nam04lp2045.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.45])
  by ob1.hgst.iphmx.com with ESMTP; 01 Oct 2024 17:38:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m19Gl7k1mQ7EUowAMRvn6B8PtdQrnYPKk79KH8AkFRjQyXOL2QEsQ8waVRdnsjJnoePFfnPq2GHCdEYqt7kp7484qrRcNzv+aEVbPzQAhUTAAHvH0rSq1cEUoG+6ZkYLTwCz4CvqU0LvDjxnQ8yi4fCWQdir+pTpIov273cutZLSMdrt9+0mYkDU9fzBJnTZym0bU01buwzPIxo3fxLXof8EgFwYpcwCgVDEFy3p2hnk0JNNTetGmeFv/jDvqmAS3LYZcPzCUH0UuadV3tM5nGshGLqMdZ8HI2SLBKWzViGLsAqL0U8e5hhibHCbaRG5eJYWBF8bTciB/4MARYVfyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ezzC7dEUSyV/MZPWsQycB9Pd73So6aiC/T45/whr32A=;
 b=nyqaVqVCfXMce0+xRRqEJrjfvf5wsZ5wC7GtEvPLr6W6IKwllmPkygWu4jQ/MRTkcoHzNE8xirD7VjwZNQjBafjSfRdKMZlSPMCZOCuRSW/1PsORiDgpGQFs2P7SiVZP/X2VaNUbbmm8td+rs2/i3xMYTHkaAaVsHnVKdBeqs75zUpiZp9djkI4oK94dSeR1Fi+VnBv6dKrj9RLAagZslVIfRSeuBg57Sk940n6dBMJTTquZioF+eka93EW/DL4uW5impoGePprWgs8eraqpz79URmoyqmrY/5ujBOK4IloN5eP9IFKlC16MRF2sIeB+7tHOFAiX/zuUx6tid5KUIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ezzC7dEUSyV/MZPWsQycB9Pd73So6aiC/T45/whr32A=;
 b=yUtiY5mbkgLItnG+9bl5nrkLgT6HCIpbG9SiFL7d7ZqyGGlphCoVQAgDHD30EESAcIY9fAFJMg4oAfSogSE+guPhrWT5DgecTR/A2+cD6u/bn46POB++3eaZFxT+4x4s21JPVZ3REQr7LZEVnE9BV4Ing0edWy+AgOfLV0mCQOk=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 IA3PR04MB9355.namprd04.prod.outlook.com (2603:10b6:208:515::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 09:38:17 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%3]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 09:38:16 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Hannes Reinecke <hare@suse.de>
CC: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>, Akinobu
 Mita <akinobu.mita@gmail.com>, Martin Belanger <martin.belanger@dell.com>,
	"hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH] nvme: tcp: avoid race between lock and destroy of
 queue_lock
Thread-Topic: [PATCH] nvme: tcp: avoid race between lock and destroy of
 queue_lock
Thread-Index: AQHbBNzREKULrCYt30e3MBDquy4VTrJTuOkAgAAmIwCAABIcgIAANHMAgB2b8oA=
Date: Tue, 1 Oct 2024 09:38:16 +0000
Message-ID: <iuqvbkvvtgm4z6wgtkgfsz73najwspbbbjfbwxtjhuj7cafccn@dlh6gpmfktd2>
References: <20240912062707.1759715-1-shinichiro.kawasaki@wdc.com>
 <f32b1c7f-4c63-4333-9f43-f777115de9ce@grimberg.me>
 <0a699cf1-66a1-4793-874d-05902149f727@suse.de>
 <1eefa343-e2c3-4a50-8bce-16b451bea3cf@grimberg.me>
 <mz7efyxba4h7qui5pfykj2g3d76fwtmco2nyxsbwzhox3th35b@vziif5djzv7p>
In-Reply-To: <mz7efyxba4h7qui5pfykj2g3d76fwtmco2nyxsbwzhox3th35b@vziif5djzv7p>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|IA3PR04MB9355:EE_
x-ms-office365-filtering-correlation-id: 46374fa9-ecfd-4185-3bff-08dce1fcc6d7
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?SAiW5aNg5bX6eqKIPWrq23bCLk4dnWRgeWZoN0+b627FhVX5ghkYR0jkf5wA?=
 =?us-ascii?Q?oG/P082PfMNa02KNMTfX9/Qxg1MErg9RGYq9fQhvwDyLA1h2zmzbsf3aVsii?=
 =?us-ascii?Q?vsRRe6hk9sUy4kibGEcfMXG9rg4O4buvLgLljcreEryC6mhshNd5pp40YgUP?=
 =?us-ascii?Q?J71rpobkqoD+H1CBH9UhleTV7nb7PbmEbaZas0c4e6eoETtaFDju6U8rQUGc?=
 =?us-ascii?Q?oYLBkqTkp6x5skugijWRXgB4FyCGH99Yjjkd3tsa9zmEHFy0qnlZIGAAUefa?=
 =?us-ascii?Q?/2s0dlXS4b/uJSV73yENZOCfutsOywtoLZxNOs+qCbFmew+3wqekVWR1MPR/?=
 =?us-ascii?Q?kYV/ONKCPg4HIDxiX/s5cluVNIkcQjMFLf6ChRSO8IXXOse0a/mggldJmqfZ?=
 =?us-ascii?Q?wP971I0qKnaFIfPfl9TWznZLUwyCPmYcCq9KsVCvvQmj98OIEC5WufIWBGrB?=
 =?us-ascii?Q?bHarRN03ZQmk1h/eQDPgMhUE50Rz9r5gRuUcV9vpqORtSDfErl8mqsjhXj/J?=
 =?us-ascii?Q?+K6+fbz18U57MhIb7NTc/FJYx8OTbnOT2HoF7h230KJs0nSJq6fPIj8UAC/7?=
 =?us-ascii?Q?0NB4lkBDUWUY1X7YY9DPyowzj2yW2T781oJuH6RzjK+1r1WgkQEgc5Q4zA1X?=
 =?us-ascii?Q?dt442LqFdu2Jo/tEgFPIBIbGE99YVIDvfYZTO6LhQhz1/Qagcds8iG9L6UDE?=
 =?us-ascii?Q?FvGxqdtbxlycSUA7uP8zPGfL02zQlHPX5SVZ+4cExDPSCzLkHc0Vcu0ssZGI?=
 =?us-ascii?Q?JXfTtYz4J6swIMCtosajOhqAhINm/qBRGjfQ3JHrh4GwxkscC1XmZbDhnjNy?=
 =?us-ascii?Q?VxuMt27z5ARRtHPCEWdOJ6s5+eRkglGiXFOIEjEeaPwZBBK86bS1O6k5lhsC?=
 =?us-ascii?Q?lxUiTjx9ILlElKWQ3relcza2L126ANpDBUntRUv1uCSst+aErXOkZp1RfOzq?=
 =?us-ascii?Q?ZxbH1rNeFJzVf/NNpyHYM4+wmWrnIZVPEF5l4hibadQxRPaKwaKRqkN9RX2E?=
 =?us-ascii?Q?fWJaQWwk00QJU2fRiHodnRHkdZ7obyhzJI26SCRvb6qGQm3qhtxH56O+Qf/a?=
 =?us-ascii?Q?54PcG75Lb6rC+CvhcUGI+HGCjgysem9FHqTCgbRk/y65lAoZ+B+xl/2n3ArZ?=
 =?us-ascii?Q?BVtuM1wv3B+Er9DEpF9owNsSv10zLJCmh9OrJYkUiX0aaYCu0qm/W5rubGnZ?=
 =?us-ascii?Q?LE6JzsHi8PsHaC063cWRx0zkZPfHT2BTBaZ8Rz3gcw/sCw3FD9umR/kjNGBp?=
 =?us-ascii?Q?Cyb+ZtuF2OvD1Gb7lewPDxWlHBwqhX0g7l5DNhxKsHvvIqjYUwk+G6lSbGvG?=
 =?us-ascii?Q?ihJWb4jlVDZWQbDKjQlUeDpaN6bBFH52a6tZMrDP/r5MdrsXxFTypyEVP69T?=
 =?us-ascii?Q?2y1Tz+vK33juwHHwwOMqmiXzy/5rY9C368oFiSyZVP+omPlmIg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qCMeS9GmnAAtvF0D1FMJk5EkaNY/mR7Y1oQKdcQO+BWeKWc9QcGPjZwXQpl1?=
 =?us-ascii?Q?FhMneYqEDi9QvAJYJEBvXE8GHQHs4FFa/EQT6XO5slUxAd/FOJg15quGTIas?=
 =?us-ascii?Q?jqOwt31oGYn8vZsv+3O05z9GjX2fdjTqIaB03hWUC0x48wIrMY8G25f09pg0?=
 =?us-ascii?Q?p+y/QPtKH5rAyZS9NungQrXsY8EGtCJwCBYIswq4JLilyKdB5IClpbJMbTq0?=
 =?us-ascii?Q?qLA/OtHem//OrzxzXSpMOqzE+WuYmb4nMRBaP2Oc1sOnzYNiZ3JLCfFLa5t2?=
 =?us-ascii?Q?pweUp1fd0qUDJDySqWMqkI1EKH+y4MvK2MTnieBzsYluTm4iU5kluTsxlE3v?=
 =?us-ascii?Q?i9yboS41w0rscI48VO20KHANMvnrBNp7T9s55Iz94qmaETxHEjFGubIqJSfi?=
 =?us-ascii?Q?iiQCH22G37Oxhr3OsRfSUk8ifyeWQ9F4AFOoFLcvTliQd/h/Wh15WdBhGnh/?=
 =?us-ascii?Q?b6FCc29rNLu88diyD8me26A8M1fi0hnscSnHAqviXBBt+JKzyAGzPYqvXnKY?=
 =?us-ascii?Q?6vl6Sb9KOG4Om3st0ewNTXzDO1nqfJTQVNVF36fHkcFeLR7Wcm21pLNyxg9j?=
 =?us-ascii?Q?Dgv3OldJqc7FlPlpx7hvENxtEpAQZCK2c6C+3dPRI+lUrGtGNmZNdBHlUs0W?=
 =?us-ascii?Q?aBjXxmjUf9109SVYpkG2isZsWQCQKIRxpWUmf6+H3PQvcqo/FULYbPoIit/b?=
 =?us-ascii?Q?rP47CgOfkfAvwC/s0OJ+TuiK/cawJjlsI0RTyVlyGTv9d8AysXoIl3Dm9+YR?=
 =?us-ascii?Q?JEbsHZ+3A/dm4zI1Yk8NToZf2M08aV9VRyVxfiqN6A4MfzTB8asOoj9f56H5?=
 =?us-ascii?Q?zFFLgWe2gEthdLO02+Lkuk4iVC1pN5tb4c/Rm26CHJKjhU1wm0hlyyI0oCEQ?=
 =?us-ascii?Q?qB6WjgqWgtUowcxC+sWhw17NwP6NGlZ4cG8+BAJrPiQ2Z2qRCWclQ3enzFg8?=
 =?us-ascii?Q?GzS8RCjrTMYdCbgIrhh48gbZSpOpiAQRmGj6wuDvmRqv0HrM2V80Jzw/7cZV?=
 =?us-ascii?Q?TmehBx/AYrPMLeijrnjpiDrOMWlf7qPw2SfKh7nq6mridl2RKAi62psPR4+5?=
 =?us-ascii?Q?bCUYCjBItpePYSB56q6BpjBZDXgViG1E5J1zBIgQqM1yDZYaOpWw9oj4pacN?=
 =?us-ascii?Q?6XSeuBiuPqqkZNJ/zE39/KsxTDabBLPbKQOC5jadWpygAQJOnk/mOOZlWked?=
 =?us-ascii?Q?akR8oGVXnE//6kaKIfZRU3B5zqUXo/Msx/4SoT4qvWFh6iRJ/Tpfr3LrnJIE?=
 =?us-ascii?Q?IizywSPByflgkSqAQjOpEhM7i6L78andQu4zbayw70kyedbscA84TNLX0yE3?=
 =?us-ascii?Q?H0CD2LbzY+XvkHHXJqOYQbTAI2lXC/qn2mVD3DEIUQP7RRFl+EH1k2Lujw5G?=
 =?us-ascii?Q?wh53mQyy/5WXFvUpcapcBzEnhUTGjewNco0tPZ5eAs1x+kRI0RMJ2dUbWO5h?=
 =?us-ascii?Q?bf+YiSAtB8xVVp4U87+2ryCf0lvKeyDRMxrBq+EWGg4IkaAehPQags+FDviz?=
 =?us-ascii?Q?zqoF6ChCMUr0x1nhL9+iCTv/3zrfuQ51uHoE/7p5yTRh89+AwoI/QdLdfOdV?=
 =?us-ascii?Q?B2IMiqk340DTm/tpf/CK62dvq0zPbKN7KcnMigA+t4vtOyOB72LTFA4NTfEf?=
 =?us-ascii?Q?bC30iiwhMENpd1hyjEVBzgk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <90DBE363D1489741BCB4BDB641B63D94@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Eusb1V2oYCqYYBT3lGRfC7M0xKeNwmjIPUAduK5ncHRnyhnzwtGjya61bG4k7oGm0LsqhpivRpVGifnj0ceHA9LzoqfT1Q9PEzCdpOuOYAlwT2qykLglQ4pJVbVkICnWSNt71dePXvcWgvrgfU1nKH6keJYP8sR5ggUb4QHifs5LWzNFqsyhL3Y0nzn8DferWp+D6M4OmkxiTqNEvpccdOQLgHyctM0p47yoEtxG9IfnPyTx6sYuqZUzIfoyysojtZXkGpolwhL7Pn2wn3MNDIi4K+rv4AtfYStiLvwVQuOz+cqTq0dO6pwPZFutC3OmQeEl3fq76CHufqnHAAU4a3OQ6wgHvUpcvf0sNz9TNV9C+Y/KWimznnp0lybd1QzM8X6xmz/iZhQf3gTdE+FaYYBozepfxscE+6rL1lh1SoMeQfWX2pfN3WmeALDZi7SmhNpRYBClwuQ3IkHprVMJXBgedd9vdMgc7IbQvOV4Mm0c0TuXI6NrlYyBJCT3NkfrHHBI0cz1qBofQXV8Xci8jKhN3HR98yygFItseKpHHiDFHWLsi/wunRz3+GXPtBLobhcrM4d8SpkSpDpMT44dSwvm7V7Pxz4IWp0DXaL8Iy2CNx3hKErk9sDIfXt5QWJG
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46374fa9-ecfd-4185-3bff-08dce1fcc6d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2024 09:38:16.3378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9CNndSFHvD7Q+oXwb0or8zIQxFh250zYUFgfbOjj98+zRxnYlPalLf9aJbrevqeX3oI3L5oyMV/gAk2qd2wC1+YnV3mdHVr4BDQIxW0WwRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9355
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241001_023821_900651_CE228B9F 
X-CRM114-Status: GOOD (  15.84  )
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

On Sep 12, 2024 / 13:28, Shinichiro Kawasaki wrote:
[...]
> Having said that, I still think there is a very tiny possibility that the
> queue_lock gets destroyed between the NVME_TCP_Q_LIVE flag check and the
> mutex_lock(). That is why I suggested the new flag NVME_TCP_Q_REFERRED.
> Am I overthinking?

I thought about this again, now I think the patch I suggested is too much. =
The
fix Hannes suggested is much simpler, and I confirmed it avoids the failure=
 that
I observed. Now I hope this fix to be applied.

Hannes,

May I send the fix as a formal patch on behalf of you? The fix will be as
follows, and I will put your authorship to it.

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 89c44413c593..3e416af2659f 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2644,10 +2644,11 @@ static int nvme_tcp_get_address(struct nvme_ctrl *c=
trl, char *buf, int size)
=20
 	len =3D nvmf_get_address(ctrl, buf, size);
=20
+	if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
+		return len;
+
 	mutex_lock(&queue->queue_lock);
=20
-	if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
-		goto done;
 	ret =3D kernel_getsockname(queue->sock, (struct sockaddr *)&src_addr);
 	if (ret > 0) {
 		if (len > 0)
@@ -2655,7 +2656,7 @@ static int nvme_tcp_get_address(struct nvme_ctrl *ctr=
l, char *buf, int size)
 		len +=3D scnprintf(buf + len, size - len, "%ssrc_addr=3D%pISc\n",
 				(len) ? "," : "", &src_addr);
 	}
-done:
+
 	mutex_unlock(&queue->queue_lock);
=20
 	return len;

