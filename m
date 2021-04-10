Return-Path: <SRS0=Ubpo=JH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1A2C43460
	for <linux-nvme@archiver.kernel.org>; Sat, 10 Apr 2021 20:16:27 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F02D610A6
	for <linux-nvme@archiver.kernel.org>; Sat, 10 Apr 2021 20:16:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F02D610A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jThHKhcLHLzcPdLpBQ9tfO839jxSSHaQq7qtunBqEoc=; b=oXLtXAp/btMzFkrMJ4InymnNaB
	YEEfaPPDKPraE74TzrYYThpX1zT4QYrGa1AiMKGdcauMHRscN2f4elpzZkbyqgTyuN1Q5yuZ4PQqu
	YT/GXf9KgclMaiWoCtYY0KbzxHCDV5Ef2D2b2fbFtfAtP2/3nnOrEow8Rd4oy2MZTL8T/kf14kX+l
	dP7Pu0lof61RIQDjrAeRTiVyLV1qPny3tILvi15lbBfbZEJnYwW9Cq79Xj2ISHbUZYiImyfdT6H4O
	q7JhV9LqpqcQ/p23QTm8kPR/Uls6Gs3DlIDXgwcGReRJPUQiOAmBhTalfytzl6c0EbEVVxwIEfBN4
	cUE7aVEQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lVK1Y-003Nxi-Qk; Sat, 10 Apr 2021 20:16:09 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVK1G-003Nux-Qd
 for linux-nvme@desiato.infradead.org; Sat, 10 Apr 2021 20:15:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From:
 Sender:Reply-To:Content-ID:Content-Description:In-Reply-To:References;
 bh=nmlHPmxwfc19XfBSUPzYUnUV9Z0XPLjvQmB8+6lAUsI=; b=Iv5bs4cSyBu+H1yRnZKVZQTpPi
 8j5rfBIkUu8X+C9qSgquoDgBfdNz0DvyDQluW43nBUmE9PFxSIeri1ZvXleoM/uE8tUKyOT9JFIlz
 6oKhE1RGaN1GSGzbCnxlO9q+jZiU+wgI7Phg+H8iSCgvRJcapr+dOK3zI/YggP9K9ufHUy1/BVb8X
 PXagTJ76ZA2/xul3mCAS779SM4O1GZaFcURpa9VKW7AGccswgOY0hm9MKs5h4PxX1gfi6lskadjzV
 ld+fPtPAR/xoodcc6wI9CWxsX6x0Z/b9g3GhcDM8qzLfZrUMm40If1+RxPs3rUnqI5xO6CotT/yc/
 /03BrFPg==;
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVK1E-005FNC-DW
 for linux-nvme@lists.infradead.org; Sat, 10 Apr 2021 20:15:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1618085748; x=1649621748;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=7/Gioj+Qb+JXfNu/DSykvMXC0YHNahP+LGcWWlkPb3k=;
 b=ix59fD0BpTlp7vRGPFbxxmEzjzVcKu/k5sTXqlu+NH5I2MuyjRWoproP
 2WtyV6EaIvSrcyv2/7PWNVPB2I/+eDWUchWR2s84IHiw4ouYgChPdVS/O
 t2qg3uaqGP7DWDsKZUacVlpupdMS3hP/ri34ZOFVWPb8pfu/tmbawsJpV
 VT6Aob+r1yj0zOB3d/LqOXTyd8pcSdf86dPhEL1iRL06RSTUGa7NrESwc
 TXhaWwdgemfF6PXNsjtruhthB0HjalnMIlCgbOOWhIjfXqYGB2vwxr01f
 p2n1BbgiMb8neLFldwQyXxSxrtd7lb4YkT2TKENdoMe0JTB9PzqCLsZHl Q==;
IronPort-SDR: lP/a/bTKRNbvbZvzkdDKqhxvQy5jq2WwXC3fYjjfmzQwZPSs/+0aiB+CmMCQDtxhi1+nlYCgVa
 DQDm6lUwc/kBM+1jmBu27BfUkUIgK0bmd24GvYGGFsbFEm3qdC7lEjbW9NORdWcs2WOGXsUD4t
 fGB+WPhxFXbnBq1eN/N7vGUTkXwi+F08XVQ1qpA/sl2CrB03sLJAA35q6x2XnZRDW+nRQCD14P
 tsSLXOQguQwI7Q+TK/WPFTEg8wfJCXtupcxMbgFdQ2iP6ZIxctcfEsweukWzBcRZEa18cTENvd
 ErY=
X-IronPort-AV: E=Sophos;i="5.82,212,1613404800"; d="scan'208";a="164388711"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
 by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2021 04:15:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lT5EOwO3+oafKjwLyOiX82BG0AjDyKmHnoud4/UVYuklwXChNoF+wHy3d4RL5Yj2XrvpzDDb1bLnT7gvzCAaHCw0HMf9OtgqwPHs9axI3qlARtV5x6APLwtjT/WUQUaGF+Iztp/a0LFaznzICQDcAGYbVMSNKCqEWTBFeNrxFOa71Rr8KjLHOflOdHlLwqPC9HEl4FMThwtoexN9m7XYuwceuk8QF5RHS5Ag9VOZgFp6b9zI1HzR9Vd8N42cUbihMa29h7HPlK9uxKJm7N5ZWp9hLIao7UOjfktyxobTH1Hx2IO0SR1XXWZqeDo4v8pP25AKPq5nvHz8hFDjtiKLHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmlHPmxwfc19XfBSUPzYUnUV9Z0XPLjvQmB8+6lAUsI=;
 b=OyfJHAbFBmOIzLWdzfeHjyMnk3k1vjexy6wj5qzj2OW/sAcvtIQ3hI7L3o788EAFqz1KPzQynHAVYKqbGEPcC7BV+LB3owXUSOqmdVGGh6w4X16inMZkTFZgef1Zw6Wp737xX/UmD4eYxj6TAFqs91tlmOXH4AY+4mlm55HjdxoDucy47PlU99TyiZ7S2QVXxqgCE2MNc014qqBs1EulnYYK+oCP9NSu8BxEqD2LNcpRcgkbDHjP7Ecb3K5irnI623KCKhO5XrTzWau8+H0Q+UARY5ZuobQBtzs+7xMNAL2zgEgmEACRAOBS71WE3tF2aXRXqRgPaEY8pymW9dqvBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmlHPmxwfc19XfBSUPzYUnUV9Z0XPLjvQmB8+6lAUsI=;
 b=XDplf2bA4CIA0k8sBAnMOWwxAygQS0Yx0FQWEFCpIoNdp5i7bhvbfNeNdtDv3Ix7FEcHVnop+dYDg4u2EOGVLP3VHmdJa9q77JKVn4Wkam6LBJJwmIbaRhT9LuA01F0t8UXYKMIi5vXaci9SINMdJnixfaFNjipg3iS3EElibLY=
Received: from DM5PR04MB0684.namprd04.prod.outlook.com (2603:10b6:3:f3::20) by
 DM6PR04MB6379.namprd04.prod.outlook.com (2603:10b6:5:1ea::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.16; Sat, 10 Apr 2021 20:15:42 +0000
Received: from DM5PR04MB0684.namprd04.prod.outlook.com
 ([fe80::9842:455e:f0d:a1bf]) by DM5PR04MB0684.namprd04.prod.outlook.com
 ([fe80::9842:455e:f0d:a1bf%11]) with mapi id 15.20.4020.021; Sat, 10 Apr 2021
 20:15:42 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
CC: Niklas Cassel <Niklas.Cassel@wdc.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] nvme trailing whitespace cleanup
Thread-Topic: [PATCH 0/3] nvme trailing whitespace cleanup
Thread-Index: AQHXLkZH32ZQIJNvtUCw0O/hdeI8pQ==
Date: Sat, 10 Apr 2021 20:15:42 +0000
Message-ID: <20210410201445.53061-1-niklas.cassel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e1d2d5b-ec33-40c2-5e95-08d8fc5d6aa3
x-ms-traffictypediagnostic: DM6PR04MB6379:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB6379B0812AD47FDD83D5ED5FF2729@DM6PR04MB6379.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 34JK4wJVdGhCb++suVG1KMZBgIpO/lxAGIIT/qSrIy83K92TaMleh+I48xW5ggDSiy+mG8fJaPj+UXwQSc5kUxQeVpXRXfb0lktI7dgBFb7tfaGc5eh1TrLV3S2LNMASaiKZRHZzOGUnWkRjEQS1mIXLXPAlttRY2T/teFmYN1HfBjhPuz6slbnN+LKTVMt0+Z569Abh2EsYqVfFVS5usLjL2Nav5jvOKkjukYjhAsUfJdrLGhdSLKrZidGIh4Wf6bRFA0wfz+8JTgeRvKF5kpIzXqjFOlRtLVE163XLtZBwYY/k8Oap4wvC8TQvhn9Xn+HM+tqSprsDsFeGYtXeuSwXblsqKMe5sYGhws3OsYbTnTnrhVFHWyve1fL1rHBlXk3TNiTWN6mkIrpu9LphXA6Hqi2Z6Sxa3XLc6sjR8mffVIku846y0nKeiHgM4afQ9RBJASfOs2w7BiqkX0HSksbkIczwwK8spAIr1/rfGSM3Qw09Bt60NDM0eRma2QyKpdS6iKfzofw1Gn1bVX5d3awajS/Hk3nb5Xs0xXQhiKAh4IXpjQme1dBIjBQPc86EjQnmbOdnfb2kfIz1Two9rVJqjkZNEIIbCbj5uKIBbjI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR04MB0684.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(66476007)(8936002)(64756008)(4744005)(66556008)(66446008)(66946007)(1076003)(76116006)(91956017)(71200400001)(5660300002)(2906002)(86362001)(36756003)(38100700002)(316002)(4326008)(8676002)(6512007)(26005)(186003)(2616005)(83380400001)(6486002)(110136005)(54906003)(6506007)(478600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?zWtul3Txv03Z138Y0VgT0AdZkXXTnNJJPRwoJ8YSRtnuNkekwHXL/UQLGA?=
 =?iso-8859-1?Q?vUUFXZLhhdRA0Bl4dWq6Y0L5ao75bwLaR7b1i1eY8FU2dKDNOuppe4VP7j?=
 =?iso-8859-1?Q?rTxBavgR8XEH7btlcO7j0qtBNtttBGxxRvcbyurFJhtP3fJ8hEg5VE7bs6?=
 =?iso-8859-1?Q?OszQ47Vkgdt+VWD1qDJeTux03c0/P5Gh0I/l4ihzQdWG4qoritFQPYKXIp?=
 =?iso-8859-1?Q?ez6dOaB1Xe4hkzk8gcYRJtVIvb5r+icTsPtKj5ImMXtUCROyb+bCtYkRdg?=
 =?iso-8859-1?Q?FSuRIHtnAsx/DcUxPeY/hRH6h4DUfPd4hS6adLr1SN1hmiz0bQOz6V0rvc?=
 =?iso-8859-1?Q?Jrv5jGledvbGHgwdaeW0L1jBg3lIUF5ZjF7DGDL5gfvQ5wcvB6Xu7u7kQu?=
 =?iso-8859-1?Q?ZGomwy2UeYogniYmOQdzSjK2GxIa0w8isxWy25Rq6VuQMCFBpjuhsvU0Db?=
 =?iso-8859-1?Q?iZMujnSMGPCjX0Kt907Ke1uByNolZaNOOVDakDeFodo5qhrpik+6i9P+0d?=
 =?iso-8859-1?Q?R8ok8YQt3rYWJzfuXsZjIJdmTSgJfe/bNskS6RfZuDEKYVViVv9tU5DqpK?=
 =?iso-8859-1?Q?LhGYHNSJnkg5TlkOgC0ZEokRkYRoFQV1pSnICwoRxEQ3pN+KyoGnjNoiMs?=
 =?iso-8859-1?Q?inSgfhBCOlLL6eGuZ3RMzlZ8gjZQjbX7jZ9TPvIzkuez+5nu9fmo5AFDPE?=
 =?iso-8859-1?Q?ncio28mVlsY8TFFq/FA+tiEuPINp2gEU9Gt+jyqY/EafdOnHik9HoRvgO1?=
 =?iso-8859-1?Q?UOcTi6U1+XmMkYye6+Ej0GBSjtaM0Glo2CJE8JjMa0QcTGNgsP2n7l0MdV?=
 =?iso-8859-1?Q?aOk0QoXzxOMCapiZbMBl4OTaYDxbdSRy8JJB0sFDoCq5C/sD2VsJpFoOSl?=
 =?iso-8859-1?Q?YvzzW76UeNWl9mO9COrGpJRhe3hYnPcYCEgEdIuZ34/+seWFR89ToQ+i9C?=
 =?iso-8859-1?Q?+PKH/BPLtcqb/IKpQdn34zJk7JTvKrXpkzs2ogEcBYr5r9jepbCQiCEBfP?=
 =?iso-8859-1?Q?Cr3doECKk9RgHYi1phNnwxOrBwphzws0UYewglJC0ZkyUu75skCh4DbVIl?=
 =?iso-8859-1?Q?G9RHQUErOVGKvb7vC0k7PluH3mFgzjWj155Ki6KhwSEwhcfKWrJ+jn4FBc?=
 =?iso-8859-1?Q?lELRCBZL9oTrU8rXJK5kdTEv2MxSikK2ZGPx+NSIhM9eih2zDJkwnLIDKa?=
 =?iso-8859-1?Q?oqS1o1UuE+hoEkQHjQb4kAz3aibAOSImSAqMnAe2Anr0VwZHh1J6BDXR5z?=
 =?iso-8859-1?Q?rk8Nm7WDjhA/rVFqTNPU4GUsXY4kCMX44iCYg055/H2TJ0lFOeTgFTJcsM?=
 =?iso-8859-1?Q?iFo1NmtpiFQfDTpNTZV4HpVcU7WARQsoI7YuMPTRpBtGcAbYH6Z6sIsQGF?=
 =?iso-8859-1?Q?Y5PWyF4G00?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR04MB0684.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e1d2d5b-ec33-40c2-5e95-08d8fc5d6aa3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2021 20:15:42.3365 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WQTh29XnX6FbxZOLXDLZPg1PkTo7vyU7u05bsY+GXvLPLgj7Qwhloo9giaVhaeK3OYPI7ChwbmiSYS3nX6ewQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6379
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210410_131548_528881_2894B862 
X-CRM114-Status: GOOD (  12.08  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello nvme peeps,

This series removes all the trailing whitespace I could find using:
git grep '[[:blank:]]$' drivers/nvme

So this should remove all the existing trailing whitespace in
drivers/nvme/*


Kind regards,
Niklas


Niklas Cassel (3):
  nvme-pci: remove single trailing whitespace
  nvme-multipath: remove single trailing whitespace
  nvme: remove single trailing whitespace

 drivers/nvme/host/core.c      | 2 +-
 drivers/nvme/host/multipath.c | 2 +-
 drivers/nvme/host/pci.c       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.30.2

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
