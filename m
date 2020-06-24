Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D9CC433E1
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 22:40:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD5DE2065D
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 22:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eFdTo/ZN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AHZpEl/W";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="YG2ulwZ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD5DE2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=8LNM7YROU5Vq5jkfdjOWsXrELSbiVLVqCZcM7gxLMoQ=; b=eFdTo/ZNpPm7m+emgS/n3MOIA
	a9Owc9Alv0bwYWRWQEw7a0JRTTS82dKRMYWCrI/2OXMQwec2aglc9GlLLYKtM63yN9fQC2kOPQq4J
	w/2KwFkB0Qe6T7ks1dhL4nfUBtVKB15G9hXJ3BovqGK441jbJrNbbz7LJ45Tr7KB4DOTleYdOQc1y
	yQnUzrnsJoQfxLPrz5pi54J0z22foyN+sOkfwfZltCfSbDJ4QWyjiGY8vM08Jpae02WGj/0AHqemg
	Xv6EwGA5rdACQyvu7HMxm2RVDorLReskaj1541ytwv5lRfTnyqAH7fB5lI0Dr68oj/MMaMoFxjsN1
	ere0Ufu6w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1joE4F-0003HD-Tw; Wed, 24 Jun 2020 22:40:31 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joE4B-0003EU-OP
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 22:40:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593038427; x=1624574427;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=5euSSVb1mYmYe+gpDOG9ErBSVRQxh074Zs/+PDR0fps=;
 b=AHZpEl/W6pVfhOh76AGRioJP7Aw1yCldySOh0vKPyv9Qv/1XCMHvi4Yv
 kpxGBY/MSnBRR3aTqFqUKfqdz2xbbsjFixphA3bH8y4dTuhY4vMWFvGZA
 iKeqSPViwMFP6TIHmz/RmuHHhttLo0Q8JNegaDNhzoQLOTRKBY8q2klaT
 9EYE708LOnM0WNbA9ffE851eTP2jz2MjnRNOzsA1z5np7tmg2h4ltIkZt
 rjS0GkBn1WfL6XgrorNLf2bBv6RNIscfBdaw82eFUHbKHsvqgRNlAYllc
 fdAZbchV32lN5G8cQDJxB1OJ28NH9S3f4cMTWzu4whLJZ4c7UiFbMO3U1 w==;
IronPort-SDR: PlH3to+mgPMB90mU68GfXX9DSoH//O5JsuW1V2muoWcGChxlj31tfc6HkQg3oXhIJWG5eeBEGT
 rpo/lBPLsTxd37Hhw1fxm7jdr2BxLgBMTkLJSr4GeTWIMnoIoSGDTOtaRbt5PxDU2p/Ox5LBRt
 biSJ635ahtsYcPkay411pl/0i5vcTLnB0tWeRSn6oVrlpZ/dVlw/Aq20DcZbpYvo9VWV9tZxb2
 ctBaJgcDJ0KSyC9PQg5l33TaNTbS4s2KAbiAXCGDFOlPAcbWScIL2eaYFBvrrZuvc0SxzpSVPM
 TYg=
X-IronPort-AV: E=Sophos;i="5.75,276,1589212800"; d="scan'208";a="250058055"
Received: from mail-sn1nam04lp2052.outbound.protection.outlook.com (HELO
 NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.52])
 by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2020 06:40:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N96VLPK9oszIpIMbKo1O4jyhC7OTGcldyzOUUChI5xV4Yw+49NGViJDBtOAGXMapyngzLkcw9gjJ88YsMgK1c46WFxwcrwDwN0LL9dNX2TFqG/2jyvA2/JsizBHJH3fI8zBDLxcCLP2CTSrKUq9ItZw3NFsvkk7ehRH7w5uPl8oB62Y45MxNC9zbzad4a7hGAFomnIyT3LPSFqeds6rSUvJfHV52tjOVuxGk9q6HmrObO8mfsVAqRpa7NoOMTdNbFjcnO0PWmla+XzPNptk+6KHeyaW2jX2LC6XRfqXoHbSIZS2VLUcOTC0/rmJVh6bp5pJPOnYTKuGfPg3tBhUODQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oR9cU4ON1j/uGGIdtSJImB1uBtXvEm/p7e9YwnhH1Mg=;
 b=ifUwIJvoJhx/VT3s3WpzZzbwoWl3lEvRPqpxUV9fMVCvorlajyB3kUiyDy8ZTttyXb35qgvsEmlPdn4TxBZ4CfYRipHukpq7Kg7qqAIpTca4Vk8fFqiR2/fcCc3dzaLGEmA6Br+G09j0gp0k7G0HRlzYIlomHRAp95Pw1XOPG3x7Kb9AhDDbp9KdGP+3iTLs3IROwda3zBbJt+4VzEBR8zmM44tNKAyU68lIjWZu0v3FNXDhwTuOn8bh+deB+XvtNEcgZ/ZVaZ97z1r7KEYFTnpCkpdMlBFok0HtW3nZhr87lXJTdIJn+O41Vvm2ltf9SDqidrbTLbJWpsgbu250RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oR9cU4ON1j/uGGIdtSJImB1uBtXvEm/p7e9YwnhH1Mg=;
 b=YG2ulwZ/hxY04liKUwVAEdHKMUiGKEyGWsAlyi9AXuJp9t68FOrVCIgOLtSH69L+QFelrsliWN9xtjD4xZuWkc7nqm97RA9KySZhT7cgwB6YzJoxooaxWSmYxxszB8wPFCO3b52YM/3qWi+vulDjsDoSqGjP252xP8vVnnlTgWE=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4664.namprd04.prod.outlook.com (2603:10b6:a03:11::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Wed, 24 Jun
 2020 22:40:21 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3131.020; Wed, 24 Jun 2020
 22:40:21 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Sagi
 Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2 0/2] remove workarounds for gcc bug wrt unnamed fields
 in initializers
Thread-Topic: [PATCH v2 0/2] remove workarounds for gcc bug wrt unnamed fields
 in initializers
Thread-Index: AQHWRats4KkNpfsaUkiEB9dxdlImtA==
Date: Wed, 24 Jun 2020 22:40:21 +0000
Message-ID: <BYAPR04MB49655BD99E428B66EBB831E486950@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200618200235.1104587-1-niklas.cassel@wdc.com>
 <20200624164441.GA24816@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7cb668ee-b530-46ac-617a-08d8188f93ce
x-ms-traffictypediagnostic: BYAPR04MB4664:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB4664C4D8C06024838653B87486950@BYAPR04MB4664.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0444EB1997
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 517OF7IjKHQHwPpX3092bqykpnsn1S+C7u2TUvJwaw6sIku/8nTJB9QKIkwi58W4uXzdhs3BfQ4BcfA48agf+ulAlFWicpeQXWz7HHX3wf3IXqPn/+txvyNivuWWMyPdmko+gwD39jcz60Ve4ZJzIggO0AszvEEIN7muTI2ucGWsG5dIVOJ2Pjqbne9dMVl5vFUuvM9ADUuF0B5dVgu1XXxfh+39Cat9zI8nhIyekCqkL2CuuGTf6Su5RxE3NOglBgCnWZVyHAWjQvvVi3oqeoRICj4PqZd1wnoOpqWY01YV9LKZBdiDQx7mJCIwjIF6xYmlkg7/0pP/qecYu/fuGxxbdz5qcZb+FpYeDIy8JEK7EP1vaqG5xdSHtqidnGc5
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(136003)(366004)(346002)(39860400002)(396003)(8676002)(71200400001)(478600001)(33656002)(76116006)(55016002)(8936002)(66946007)(9686003)(86362001)(110136005)(66476007)(2906002)(64756008)(66446008)(4326008)(66556008)(186003)(5660300002)(83380400001)(54906003)(316002)(53546011)(52536014)(7696005)(6506007)(26005)(21314003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: eJIFVcZ1vvskxMQhLTs9yjWPzujziVMskVRtCe96Qy5RB03XE7kTzWW8nl/6a3kufKrsic45xPusfjDXre0UCBxfr1ilXPekLf8yEY6FHrK5sEXTlQ8nV8+HygU5QabkW3Uea/MxmwkbuHIAGCvwouo/jj4t38UU/M+ONxMvYQFP9mKtK/G5gz5cbhK1RtPrejBxbWs0mUS1xFxjtS0lJQHgWufgVJqnFmOxYRjWxE7M5VN9NZzK2MrUjp2O3BcLr4TpcZdLHEwA4pbl+9qBeKJFbCgmgY5W5ejDKArjbQiNC/Sx+fWpdandAhRu3hXqk4gtJJwgLNqvBLz66MAM5vcmhS/xNv+T/98+Yv8g1/Ugkes9nN/mr0j/Fy6VvhRHwe/28CqGcXObzkaODf3ZwfqhzPLYgQ/x7xD6qsAr6XmrId2WY8Rs+CvJ/3aZrI898qGhlJ3t0XWIxUXzhUEMBB9zzJOQRi6sGRoRQ24Z1pk=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb668ee-b530-46ac-617a-08d8188f93ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2020 22:40:21.1151 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JpiZ9a+jmfs5U121em5eTRILP6ciEQde6pgPPtkvzfzzOC6mVZY9D38xROC+dgTVsx+2n2dbdVjY77UaWDBTp3OjTA99K0vPaduV9ZzRrcs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4664
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@fb.com>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Christoph, Sagi and Keith,

On 6/24/20 9:44 AM, Christoph Hellwig wrote:
> This looks good to me, but I'd rather wait a few releases to
> avoid too mush backporting pain.
> 

Here is a summary, for longer explanation please have a look at the
end [1] :-

Pros:
1. Code looks uniform and follows strict policy.

Cons:
1. Adds a tab + more char [1] which can lead to line breaks and that can
    be avoided without following declare-init pattern, less bugs and
    no pressure to fit the initializer in ~72 char given that we do have
    some long names and who knows what is in the future.
2. Issue with older version can lead to adding additional braces which
    does not look good.
3. Writing a new code becomes inflexible and pressure to fit initializer
    will not allow users to use meaningful names in the nested structures
    and anon unions.
4. Future patches will be needed for backward compatibility.

Also code is perfectly readable as it is so why change ?

If everyone is okay with above cons I'm fine adding this.

Regards,
Chaitanya

[1] Explanation :-

I'm not against unifying the code. This will enforce struct 
initialization to be done at the time of declaration and is inflexible 
given that we have different transports and meaningful structure names.
Also, no one knows how many new structures will be coming since protocol 
still has a room for improvement.

Consider following :-

e.g. 1

static void nvme_xxx_func()
{
	struct nvme_XXX_YYY_ZZZ abcde {
		.member1  = line of the initializer calculation = X,
		.member2  = AAAAAAAAAAAAA + BBBBBBBBB + CCCCCC + DDDD +
			    EEEEE,
		.member3  = AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAa,
	}
}

e.g. 2

 From code :-
+	struct rdma_conn_param  param = {
+		.rnr_retry_count = 7,
+		.flow_control = 1,
+		.initiator_depth = min_t(u8, p->initiator_depth,
+	here ->>>queue->dev->device->attrs.max_qp_init_rd_atom),
+		.private_data = &priv,
+		.private_data_len = sizeof(priv),
+	};

In above case (e.g.1, e.g.2) we loose 8 character = 1 tab for every 
declaration-initialization, now if we have a member to be initialized 
with complex calculations then it comes down to the next line and again 
we loose 8 char of tab + (number of characters = name) of the member 
(member2 in nvme_xx_func()) and whole things looks ugly, in contrast if 
we do it outside of the declaration we still get 8 more characters 
before we reach line limit. With 80 char limit we should avoid line 
breaks and tabs as and when possible, this policy goes against it.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
