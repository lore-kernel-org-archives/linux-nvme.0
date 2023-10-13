Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFBADCDB474
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Oct 2023 02:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ONGZKQc/6Ow+CtqTMX+d/BXeS5GDEV3q0c3P5dLsaiE=; b=pQBE7Gj7IBPkthz+lUq+mV/4UP
	HrRbOHa4KQBILfXb9EbeBiivPyHoOz6WD3EbTgWzaQ56nZpyfrKbnc6EEdsPqg4O4Y2Xr3qsdMgQf
	G/G2Sr3wLl/JhUab+UFZ+2963fW2AHAS2obtvUGxXfVHioeOsIAxxvYPMELFWYuvP5a61O1wZFamE
	hGaiCS7Uzz7BOoaijLwccrnpjKdaUuyvmVD23N4qPk4C2o4AO3IeuZ8yw/cKUM9pjzQUDYCCnO4VS
	M0Jw4Sg5lyzDh3pWejugl+AA5Zjl9n1k6kmeq0LmLjoJxJpjx178LWH7kiCxWrZ+YLMupHieII46B
	Z7xRIOTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qr7wr-002IdA-0V;
	Fri, 13 Oct 2023 02:30:45 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qr7wn-002Ice-1n
	for linux-nvme@lists.infradead.org;
	Fri, 13 Oct 2023 02:30:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1697164241; x=1728700241;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ONGZKQc/6Ow+CtqTMX+d/BXeS5GDEV3q0c3P5dLsaiE=;
  b=VCeOF97pYF0Clq8ZxLrSUK7gZwgjb83pPWPzjyL8qLrOqX0GDKwFDXWR
   rcbQ19u+nCoVYtdodYclTCXccnC5tDZxFUXEnGQtM0ymOZFkwyfmoA4wx
   F9hvaN9oAUo7ClGR8aTMWENuRTjmyCPpgiaDU5kgdGKAVyqKdbcJVXaUr
   LbZlbuPBU1UflK5XtH47VzmIQyjT0WMCfdmZgZSttQAt7dE4+YcI9UjPv
   3BNyY8vGOEy5RbBf/Mpk/ctX4LS84DnTew/Bav8VSF4JOIa8vY/3rn4qr
   QV1ddXrH3eHTGP+n46u0mD/NcX/hEBmdwNwC7l4wXn9mvyOfXFTb+qsac
   Q==;
X-CSE-ConnectionGUID: I/f/mihhTx6PZSMVn/L7qA==
X-CSE-MsgGUID: XvCkjbxkR62xoeQlI+VQnA==
X-IronPort-AV: E=Sophos;i="6.03,219,1694707200"; 
   d="scan'208";a="358527218"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 13 Oct 2023 10:30:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6EXMXAYiB9WOxU2Fs+aEC+kzs8macQKL0QoQ3H68UErW2OO//gwWbHbyjK7Zq1UccxaNPYYWhFWyEqQkddwgEsOIbQc0iWGFBsfhjSL3NNsDoWfwlosD4OAyLYD4nF4RByPD/o/jpplrKnWcIf7DPYx17UEeyFmed3JLMoXI9LXmUOr1Y3/Q/rp0LqAD6Bk5bb+3vO45lfTlf+hcSdnxiB/1mSmRyxRnq/xNNHWqb66+ZSeltRFi/0NAwTlp9lbbDThp2rltwMv0yHmTMIEzD01YDIuEFnSstsQxr9wXRIDcLei86C13wEkymg1ld/HRa5OIvUwqCYzt/ANm0RPXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONGZKQc/6Ow+CtqTMX+d/BXeS5GDEV3q0c3P5dLsaiE=;
 b=kNSybtDhSpIPjDackBJM/sIpTyp4W2KjkOSGFRFv8hpGmZTAWuGNSJhOMfEYi+ji7dKOPqzqGd2vebifcAE3KQtOBnsB8zLbaOcgCXw+rNiwDsEkVuHPxVIQyDv5j6ksr4Qly7HVcdu1+5ikHOv6QwZFbZ55mBZP6jjTTPybIBhMrUKCfJEjYMfk2/YCDjkTmxry4JsYxjtI8OMqDQftFApioxNAlPdzWTBwLd7XOKlLmfKOotjqCIIQgmZpgNAFWZxUZoC/6PdS6s0Rjbb6c9Z/Q3huZzLj49k/vDygyFNNrZ+nGpuT6AXC9lm5gG7zBBM+MnlopIZF05ALd8WyJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONGZKQc/6Ow+CtqTMX+d/BXeS5GDEV3q0c3P5dLsaiE=;
 b=BGiIIoSUSf/UMBcd1/SO7g9gLSvXKK6CcFhOWJ2G9DyyVPafgg3WDAv6c5xT0Txbnb9XEAtlhOVza73xLZ6EF6fBKJt7br3eQ2wKsLektCphRPFEwLCFFGm6nc9u/na96fApTZ/NSfrVsqf8WrrAvjWNvzFYpfuwdybMCGaYYIc=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA1PR04MB8496.namprd04.prod.outlook.com (2603:10b6:806:325::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.38; Fri, 13 Oct 2023 02:30:33 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2256:4ad2:cd2b:dc9e]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2256:4ad2:cd2b:dc9e%3]) with mapi id 15.20.6886.030; Fri, 13 Oct 2023
 02:30:33 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Sagi
 Grimberg <sagi@grimberg.me>
Subject: Re: blktest nvme_trtyp3=tcp nvme/003 is failing on nvme-6.7
Thread-Topic: blktest nvme_trtyp3=tcp nvme/003 is failing on nvme-6.7
Thread-Index: AQHZ/LvSe5kVkBO/DEeoMQkOD5c7HbBHAPCA
Date: Fri, 13 Oct 2023 02:30:33 +0000
Message-ID: <smhpbnyjiuqhq4ebaolhw2dv6gjdycrcgsrzxmbzbpmuienc5t@2pkcupp2og42>
References: <9998ea45-ed4a-4941-8e9c-d80f12591580@nvidia.com>
In-Reply-To: <9998ea45-ed4a-4941-8e9c-d80f12591580@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SA1PR04MB8496:EE_
x-ms-office365-filtering-correlation-id: 25f98cd0-1db5-4dfb-1fb1-08dbcb94602f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9ScW6IFezN5CXpu7yjZr8cS3hu6IKNxqHq4USwxUWhbHn0wjNeyQehfd4Psd/UsTWcLxiel/33eoE4ZykmFSJ9G3/sR7QCNxAx+Kutei+nSI9LSAg1EPaEOa3jkQysTtHnrwZfVLFLxwo5I20JEeDiHTZfiqZBI4dW8Gm+Mnr2p8KFmZggv1da+/x0msJMu5pxBBbYVMjsBiG5cYoq4HJezEV94h2R5IxaWJSeW3ID08sMpFviUhuH+YV4wTj8H7x5r0Zskvmy6/UKzvcsTSxcpnjcdrwuULa+V6ayJcfj41PTObhp6OJSzYyBIpBeJOBAxzlXTqrQWe0cMmOOUXXEwSERE4fdDRMGMCU+zSex3Wzr0b4lreBHIajx6VrnkkADA/NhVOHdKDMrN12sD/ZqCodo9fIBmPMHYQVUyqPKdF2XsLw4oP6tzZArkV0oEW5hH9jRkqaEqlvVCbk+nJvhpSYxt4v1se5KoyZ6qmeVxlNUeyCRRPjyqdt8zMZ1tEXnxCex3ZEOry6JqPFw+94qyhSdCCfOCmil6v35W6/lwS2GHZEJpTSC+mNXlwtu4hCBRZtA9FOhLeGOovoFTEXHRyL37x3bDvXA3mX3r7Kt4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(396003)(346002)(136003)(376002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(66556008)(6512007)(9686003)(966005)(82960400001)(122000001)(38070700005)(86362001)(38100700002)(26005)(4001150100001)(44832011)(83380400001)(2906002)(6486002)(71200400001)(478600001)(45080400002)(6506007)(8936002)(4326008)(8676002)(41300700001)(66946007)(66446008)(33716001)(5660300002)(6916009)(54906003)(91956017)(316002)(64756008)(66476007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?e12QUivJkNao8uCjBOh2Amwe/k0e1GFOJBcuwffoMHVfT2g4ekNVezY21C?=
 =?iso-8859-1?Q?rO8o+iONKB4ChOQZvJdI/dVqEMz2SjfwIUu/z+glfLBC0f2kJAOGYuyTt7?=
 =?iso-8859-1?Q?WQwhXDJVKM2m+LaqN+odrgARz6mzarbkBzAhVtXic8oPE5LMeqr6cVKIxy?=
 =?iso-8859-1?Q?t7+gJtXh1DZ/jrORwn88KpMlHGptZhJtWOwawuzZg2sVotrguiGxWMT3Na?=
 =?iso-8859-1?Q?2siIGuzJxKjoiyrXPNuu78yqENH+GMfNmX10k4Ks//Xoe2seCmx21OiFyC?=
 =?iso-8859-1?Q?v8Ep47++4ud4VH4Sf5XUIl0afu0H3+CDKhBKb5KaUfYRGABnYTljcf4nT1?=
 =?iso-8859-1?Q?wTW5YRYucwDGYZjJmpvVK0v9iUoVPEdZXnFq+wsAtWy6C3A2Xn4MU48YJi?=
 =?iso-8859-1?Q?ZMIZyjWtz7qOfj3CafVY6H6f/9XKZwP9kcmrLD83tZYyeKVxOIxSCiRBQq?=
 =?iso-8859-1?Q?F4C5CWmLVVsYSa55Z9eDNLcHwy99a5fQ7p80teZ5tKZweTmuxp/65EVicX?=
 =?iso-8859-1?Q?2Z+VvJW9+WdxAjRE8EX4s7rlnSab3rOcDsrWlMR/9i8TnNuWpP9DiEzfzo?=
 =?iso-8859-1?Q?AaHKbGBfKzY/FTDXDENT00KHtUZQyLHiZkXoV5JiYcjKBUQj/qrzRIf71n?=
 =?iso-8859-1?Q?G6BX05LfzxoSGwFryXcGTmJhPeGcirRSTjFSrXYib1teKBXQdJOmo4PaJ3?=
 =?iso-8859-1?Q?yHTNifI1qU4VKpSTBAPv05/fWsZ8N0arcO+/naP0WXgyoLi2NpdbY+TOQy?=
 =?iso-8859-1?Q?uvjKl80H84suqtxjIKUJz5bUMoVG3ZyHqjqzy0fTTa2ky3y4y9aHvCOVpG?=
 =?iso-8859-1?Q?+afpEAPj8A1POTYpU3AhMIHuLPChjLxeR5Cz8CQo7m9ZonalLjbv6B41ki?=
 =?iso-8859-1?Q?HLk0MhOEA/RMjr1Up5yKdIE8WLMPPq7X5Ler2Q9hdTB9YmkZacg54oOOtD?=
 =?iso-8859-1?Q?BUumihbmuAVVN2ZI5k+dJgFXZGvZuPvTyjMhbgbtoPePBQ6OC/8OkZl0CB?=
 =?iso-8859-1?Q?6nd2j5DZaCU83bDDiX/uKaIevGf6yqTBZA/7rz9nIz91qJlhaDE5IK6JZR?=
 =?iso-8859-1?Q?MdVworFJELcU6eyAA9ObTrZsWnMz6Y7re2mhbhesvSC3HWTOIcpUA/uDJM?=
 =?iso-8859-1?Q?WjC1GVIzLbBczysPCn5XVzXiV6rYhpByS6JqbupGcJ5jfGgwTtaQJ2rhUC?=
 =?iso-8859-1?Q?sWrvwepdmgnEbxB6PWU14808dskoLWqoJw8mDTU6vvP+H7iXn9q1/0OZQm?=
 =?iso-8859-1?Q?qtLSaNSQAQlOj6S24SENvmLHYiZEkmjgF50OSiTASYBmJI46qORkSMJnCi?=
 =?iso-8859-1?Q?d8Xuk/ArLKOxIAiN8zhkn31EgHPFD4JJ/cydvZQieAT2cPRkjfjWbce3tZ?=
 =?iso-8859-1?Q?acWT6KMgEbEcSJTJkBVYpbDuvs2JBkmZY2hbPIWHjpyiWIxPuwmo4fQlOZ?=
 =?iso-8859-1?Q?OOBlT3yAGYhnGwdMefXzlhp+Bzttx2kZc+visV/G7E6oyuO5u8JMyxaZ/D?=
 =?iso-8859-1?Q?inC0vhAguS/OrVQLrH42WzRuhsfmAH75y99blgwIkn6qImxp4d/LMeSzhq?=
 =?iso-8859-1?Q?bTm4ybW7ti/zIvsSICk/RwiNIkU/0lmxwVxHu2VJ19GfABlYsW+ZMiqgaf?=
 =?iso-8859-1?Q?cJEEKMFZ6XwTrNF2xHIsNPuFXs5Dxw48IDmtQYY5qrxvhtxA4UYM+i1VqE?=
 =?iso-8859-1?Q?F2vZ/8jpFx5NAvBT8O0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <2AC14C3AE35D7E4F86E5F546BE4DDB00@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mQjRMRJnSpfySWhtKDUKvKeV9xxP0FnPJsTvj7k11x/5BbPKrA6ym3gP+ZLlXX81/Nc/U7+hqaincbh/QCpCQMsPxP/jBrKzUk5UxY+SpVP2zB0auOnZPzxL3NDC3Do9NapwhTXSoRorFcRFu94nJ1GEPFTs4FVU/2+KHvbyEwN/31/lk2nrzqqiVd9ro3oXzN8peFRHZJo8rN89rIKwYocZ7jRI7025AvUDed4CVlAc8R6MNYiiPD+G1+Fnycd5ztpyqZtq/Go6HPF7OKW3viySxsRsmxBZMVqYfDvPvCjWa41yJLplFgo9mK2o7irnxi+3DeE2SlCXiN0kVuoaad1hn7eHWKw0Ur7XG82nX5DLGyhlqAc2Z4SNjL00cd3/eqdIyBdx4CIGibKTDdmJyfml1tgkpwZpKY66qffsfj0SeWvHjcKfvskb1SrrJap4Ppkd9klwVHKrcaPXsAUDbyB++D/2jVPIRf3VpF8DCRC1o+IC+n3uv4U7ESIofnWar4mo3rFzhK6Y95GNlyoCjWKmahFR+HmQQBTTwcJMa2F64daYc6mu1w+e1ib1o4fEET5IeCTfkVAudptEYceU/ZH+ZmjWLUWA8e6F5aGSL85StYFK4ZUVsrft+RyrAZ3HSyKtvj4rm1ktzAxpD0W/72lSg0DZTxTZM9S+5Lh9au1JEZrtxouSWLHZxz4YbWGpr7I6bph5FP/5RtpOgHgvZtfZGIxXgTTFWX5+7Zf6QfGibt8PgRhOnlXUQnMxoZSLJOOO5Tme+I0MQKs7Ei82DLdwekoQCVscTaazulvzsgdjw+4H4044nFXaAVwU/o5ZjdvZhdelLKTpKxFuWzwblZR7BVj8RKbbO5N57CWMmgM=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f98cd0-1db5-4dfb-1fb1-08dbcb94602f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 02:30:33.2330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QVBLf/mnSTTsx/oHQsKJmF8rd+kJb8GYfZGJ/VHC2HdIwO88xF/49JZ/zo4Y2VPBR2M/Ivt2l/l8bduBHxdxfovkcxV2mdQgiGPIbduHAvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8496
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231012_193041_663637_6D14F465 
X-CRM114-Status: GOOD (  13.90  )
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

On Oct 12, 2023 / 03:26, Chaitanya Kulkarni wrote:
> Hi,
>=20
> blktests nvme/003 is failing with following error message :-
>=20
> In case this has been already discussed and fixed please ignore this
> message.

This failure symptom looks similar as the failure I observed and reported f=
or
rdma and tcp transports [1]. What I observed was a WARN that lockdep report=
ed.
But this time, it is a WARN that workqueue reports. So, this could be a new=
,
different failure.

[1] https://lore.kernel.org/linux-block/dycg2iltyeezp6y7bqfhfke6bb3dantkk5n=
syk6qjfg2o55esu@liixlkhgtqy3/

>=20
> [ 3081.633737] run blktests nvme/003 at 2023-10-11 20:21:13
> [ 3081.649812] loop0: detected capacity change from 0 to 2097152
> [ 3081.661590] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [ 3081.666424] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
> [ 3081.676553] nvmet: creating discovery controller 1 for subsystem=20
> nqn.2014-08.org.nvmexpress.discovery for NQN=20
> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
> [ 3081.676954] nvme nvme1: new ctrl: NQN=20
> "nqn.2014-08.org.nvmexpress.discovery", addr 127.0.0.1:4420
> [ 3092.796012] nvme nvme1: Removing ctrl: NQN=20
> "nqn.2014-08.org.nvmexpress.discovery"
> [ 3092.796342] ------------[ cut here ]------------
> [ 3092.796344] WARNING: CPU: 34 PID: 19842 at kernel/workqueue.c:3400=20
> __flush_work.isra.0+0x25d/0x270
> [ 3092.796354] Modules linked in: nvmet_tcp(O) nvme_tcp(O)=20
> nvme_fabrics(O) nvmet(O) loop nvme(O) nvme_core(O) nvme_common=20
> snd_seq_dummy snd_hrtimer snd_seq snd_seq_device snd_timer snd soundcore=
=20
> ip6table_mangle ip6table_raw ip6table_security iptable_mangle=20
> iptable_raw iptable_security ip_set nf_tables rfkill nfnetlink=20
> ip6table_filter ip6_tables iptable_filter tun sunrpc intel_rapl_msr=20
> intel_rapl_common xfs kvm_amd ccp ppdev kvm parport_pc parport irqbypass=
=20
> joydev i2c_piix4 pcspkr ip_tables bochs drm_vram_helper crct10dif_pclmul=
=20
> crc32_pclmul drm_kms_helper crc32c_intel drm_ttm_helper ttm=20
> ghash_clmulni_intel virtio_net net_failover sha512_ssse3 drm serio_raw=20
> virtio_blk failover ata_generic pata_acpi qemu_fw_cfg fuse [last=20
> unloaded: nvmet_tcp(O)]
> [ 3092.796419] CPU: 34 PID: 19842 Comm: kworker/34:0 Tainted: G=A0=A0=A0=
=A0=A0=A0=A0=20
> W=A0 O=A0=A0=A0=A0 N 6.6.0-rc2nvme+ #18

Is this the kernel at nvme-6.7 branch in infradead nvme repo?=

