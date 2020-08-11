Return-Path: <SRS0=CGXy=BV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E70C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2020 12:54:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B26202075D
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2020 12:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GGCU9MmA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=netapp.onmicrosoft.com header.i=@netapp.onmicrosoft.com header.b="ei5MsHCg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B26202075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netapp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=dO2RYfZdaFChziigN8So0zX7V9Vp+MKJi7tTy61tIag=; b=GGCU9MmAynMfSHDrQuzeVj6qf
	JqmtSMwFgxD7V/01EMUbSkcUTQRk256DOG2ZXnbL2xkUr9sDqwsp8Eo0UpVDJ9qDwquak2X08oilA
	fUGFB30QHIPHag7WAvUJ5NvBzl5qYvZkSE0cFWuTJTBx5abagBA5D+zc9Ni8Vy6j+XDsdWCi1axgo
	DOXHbvIzMsfBBag6rGHXKPUeqwPc4xEXWY11YrMSuSuRX+ILV4Xs37AGslqZsqr7N1QUn1gb1qpG0
	dw6qhjg8aEnlgY2m7ToGFjlXyrDc1JK4BzUTFQvk7885hcPWS4q0aiGJAX0VLk7BNVsG1VFMUaUHP
	mFozkMPyg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5Tnr-0005wS-3s; Tue, 11 Aug 2020 12:54:55 +0000
Received: from mail-bn7nam10on2084.outbound.protection.outlook.com
 ([40.107.92.84] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5Tnn-0005vH-IM
 for linux-nvme@lists.infradead.org; Tue, 11 Aug 2020 12:54:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GvV1f8CrfUSxUMbwy3ERaqutnHvLIRFRUMpFypQuT0l6PFoOvIKn/t9IpH6ekCgbrE1/Gcg8GriAZolgoEnGLbSR/bPetSdo2hSXJMVCTnKrV+PWmoizBhzI1AMgkH5xbU5qOOYxJNAlJqk+nnLTO3Ikl1izw9w3A3b0QZ3KBDKf5tGl/D9a+m5JE1/bMj248HQNenEBduZT2w0l1ZDkGyvwqKS1aEMX4MrpAHvvQDIvRNsa9JVKhGf+9XZ7khtZH2LtXPk0xRJosUBBitI4+W9JQMgEgASX/yo2ubIJGC+2VR1Fy17nf4116ptYGmwDSsuXGLqYRJmXbJWbYPdJaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1xZyXp50y+bVPOk46cQp3b73fY/SA+MZauFGYl4Nbc=;
 b=PZCG5/6LayCph9DXu9WREvGPnnDytFIKMp2mhebAZtYgaD2PyGmZ/wGG3vrG/pKlWTeexoQdVuHWaSouNzVWUW413wEPBRLCb1soT5+WPB6SYkvaGECtiMJAB07Ie4qdT7GVeO3QxnHhDoyt25Msn9ctzYkGi868oueWKTakWTjy2LK9CG/apPC4X0eDaHV00Em+ft323tHJwvPddWh3Vqfd94P5UWj6GjJfx4VDnmItfR875Na2fME7NOS2KXPAtBkPV+OJw5HS2hPBsFsXMg5uNknFXNbLhuXFZHcxKeu34Q7qJHzRlLKJkoZvbnprO7ArFEYqt34rEmW4GAyhfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1xZyXp50y+bVPOk46cQp3b73fY/SA+MZauFGYl4Nbc=;
 b=ei5MsHCgh6sj5HbpB34X4dnLpIxaCPOdBPk/HzMpPHGfgqceGUuQ9hAJFAu0uilLbPKmj4nwZu+4CyLWfSlkyNdFU+JSybHPqk4S9eatswZjCRLVIURxwvJqzrAVqRWnFmFQ0Df2ZBEnCYwJXPE9+dOTb2sMgyaDsESKwMRsJy0=
Received: from BN8PR06MB5714.namprd06.prod.outlook.com (2603:10b6:408:d2::32)
 by BN8PR06MB6273.namprd06.prod.outlook.com (2603:10b6:408:52::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Tue, 11 Aug
 2020 12:54:49 +0000
Received: from BN8PR06MB5714.namprd06.prod.outlook.com
 ([fe80::9438:86ca:efca:18b9]) by BN8PR06MB5714.namprd06.prod.outlook.com
 ([fe80::9438:86ca:efca:18b9%3]) with mapi id 15.20.3261.024; Tue, 11 Aug 2020
 12:54:48 +0000
From: "Meneghini, John" <John.Meneghini@netapp.com>
To: Mike Snitzer <snitzer@redhat.com>
Subject: Re: nvme: restore use of blk_path_error() in nvme_complete_rq()
Thread-Topic: nvme: restore use of blk_path_error() in nvme_complete_rq()
Thread-Index: AQHWbE7UEz3pfV4MbE+GFAiYSFQMcKkr2WqAgAA6c4CAATpzAIABJjWAgAAArICAAvzWAIABL30A
Date: Tue, 11 Aug 2020 12:54:48 +0000
Message-ID: <4EFA1979-A126-43F0-9F31-B4A80576E329@netapp.com>
References: <E3390A8E-D582-47BA-A085-21663D883365@netapp.com>
 <20200806184057.GA27858@redhat.com> <20200806191943.GA27868@redhat.com>
 <6B826235-C504-4621-B8F7-34475B200979@netapp.com>
 <20200807000755.GA28957@redhat.com>
 <510f5aff-0437-b1ce-f7ab-c812edbea880@grimberg.me>
 <20200807045015.GA29737@redhat.com>
 <fec745aa-0091-ee1f-cb0f-da9e18cf0aa2@grimberg.me>
 <842F6313-F3CC-46AC-A15A-A44E50C5BD18@netapp.com>
 <BE5FA5D8-508D-4D2B-9BCC-632CDC51186E@netapp.com>
 <20200810144834.GB19127@redhat.com>
In-Reply-To: <20200810144834.GB19127@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.39.20071300
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=netapp.com;
x-originating-ip: [216.240.30.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea20b456-906c-49f2-2b4b-08d83df5bb2b
x-ms-traffictypediagnostic: BN8PR06MB6273:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR06MB62731E57EAFE2B2A832C92E1E4450@BN8PR06MB6273.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SwrmqRBIwvVEp4vaV1ZbTpCdQ4Row7fW/31/2dL0IWklNstpSLyw3CrC096ZNyitODmE91TjlZqqLFoI3ZThiM8ou23/cnu3D8pLn1ZNPP8QaxjT2g/AhYjXDX731Nht+uvNnIeYcSl+mZA40BVG3OJJ+6hgWrb9+MpPmWrNV0417ZgMR0p/6FdOvD1bAEoDDXOFFpw6/tuo/wKw3x/EWHKnCIQwwLEs4ZQbjRkB5Xsv22eHrLr+ZdJ0XywqNrMtU4+0JykXGrR2rpNC2d1pdt0W/w3JNLMH0NPpYxrodGw4YMwpOgghTdFx+wFWnBm0DXv75p/KEPzD/COkylq1j2zwm2MjVJYQiIxS0cc1lHpHZhfl7+eHi/9jL9jeaN54lIBMPd7mTqXodufBVmDpu28RnDVf+thuz3wsWa+AYUxhJGubr44Nififsfunv1w+HNkqpaAOzcnMQnbqkX+IuBzCTQnhgyJn5F6aBmyLfBjiyBQoVHd0LDxnDyRaz9DhdbLiQ6CBinUOF/0OREOoOA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR06MB5714.namprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(54906003)(316002)(2616005)(2906002)(478600001)(86362001)(107886003)(4326008)(966005)(91956017)(76116006)(66476007)(66556008)(64756008)(66446008)(66946007)(36756003)(6486002)(55236004)(53546011)(6506007)(71200400001)(186003)(26005)(33656002)(8936002)(6512007)(8676002)(6916009)(5660300002)(43620500001)(15398625002)(19623455009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: WnW2CRrZPtoG8bxcYg2aYw3lnR1dCBhBGU9V2N7jon9SpEKGQOnUv9cv1c8B910NHJ2aWyc3ygZ9xPGix1EoyFvHXSlBWfB7IFl8+4AqnJ97FbEiBVwe5p51uY2Uqy3MPlYK+n5CJsB1eRxE/OjMrbomEs0lC6nWzfCOZ+Bw/r1GN52f6box4cAItw9NZNLDk4qZTY9gSLe71TeoxhQGJwGqL+XuY/v9TWfGyBNsefzED4wB8xgt8hJe0latySQ+ezh6czBXFCpb+dChtgwOZAGADn4B5wPsc5HT3AmmiG0vHntXD4Chpy1Zycbr0k1kROtpR1uAQYduYUfFKhLkKtlrAEAH3TJGOPn8NcCiDJEs0zuH54YT0n2x0gw30vioWdxVlVxlEHurE+FyFC0cHnOGXe89ugbpAz6PpFTwa0X2vKWjMHIeFSQA2D6lyQckomVyNy6dwCY7UzKqEntCqdIY/8e4gKPM0iQbsav0hsxOY6CtcwnJ+UATVsBRT0qck1I/EgEUitJ2mDVeh+3tLzztY4KWR6oM2DwcgbIHGytHsjrh7Ap+qurkKqbCrP3ke4seV6YqC1jY66VNFOg2Q1tlDjuc/rM2p5g0uVde6zRRi6kLxyHHIWSFLLU6hRf5GcGZLsessf3FxW3w+B/Zeg==
Content-ID: <48E885D5D98E7348AA33FE50715E497B@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR06MB5714.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea20b456-906c-49f2-2b4b-08d83df5bb2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2020 12:54:48.7536 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VIh8F6WklnQqholf3rBp6Q4CV+qN0ctDnvpcaYJgOu7+iBptQ1Ygirn6Y/cxC1vghxHWEsgY8t8nEvqG+9KOag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR06MB6273
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200811_085451_961679_E243AAA0 
X-CRM114-Status: GOOD (  39.65  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@infradead.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>, Ewan Milne <emilne@redhat.com>,
 Chao Leng <lengchao@huawei.com>, Keith Busch <kbusch@kernel.org>, "Meneghini,
 John" <John.Meneghini@netapp.com>, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/10/20, 10:49 AM, "Mike Snitzer" <snitzer@redhat.com> wrote:

    I appreciate your insight about ACRE.  And that NVME_SC_CMD_INTERRUPTED
    is really just a preview for the kind of NVMe error handling advances to
    come.

    But, because I started harping about blk_path_error() I got you
    hyper-focused on it and that led to all your thinking about me wanting
    to somehow normalize both SCSI and NVMe.  Couldn't be further from my
    thinking.  I've always wanted Linux's NVMe driver to do whatever it
    needed to handle the evolution of NVMe.  I just really need it to do it
    in a way that: respects NVMe's spec for ANA, ACRE and the like in way
    that doesn't make NVMe error handling broken if native NVMe multipath
    isn't used.

Agreed Mike.

I just wanted be sure we are understanding the problem clearly.

    The good news is I still don't see a need to model NVMe error handling
    with BLK_STS et al.

Yes, I agree some alternative to modeling things around BLK_STS would be good... perhaps even required.

I'll admit my suggested solutions don't help much.

    But AFAICT the NVMe error handling needs some fixing/cleanup.  To be
    continued, with patches so we can collectively have a more productive
    discussion.

If someone can come up with a solution that allows nvme-core error handling to work freely with and without native nvme-multipathing, I'm all for it.  
But we also need a solution that any solution is future proof because more changes are coming.  

/John

    Thanks,
    Mike

    On Sat, Aug 08 2020 at  5:11pm -0400,
    Meneghini, John <John.Meneghini@netapp.com> wrote:

    > Having said all of this, I think one thing which could be done to help
    > support NVMe with DMP is to approximate any new NVMe error semantics
    > by adding new BLK_STS codes. Reusing or overloading existing BLK_STS
    > may not work well because everyone else already has a claim on those
    > semantics.  I would suggest adding new BLK_STS to the
    > nvme_error_status() routine.  I think this is the one place where NVMe
    > status to BLK_STS translation belongs, and changes can be made there
    > without impacting any of the NVMe error handling logic in nvme-core -
    > now that we've removed blk_path_error() from nvme_complete_rq().
    >
    > Another choice would be to simply disable ACRE.  This won't solve the
    > problem of changing NVMe error semantics with dm-multipath but it can
    > certainly simplify the problem. Maybe a patch that disables ACRE when
    > REQ_NVME_MPATH is clear.  Or you can always just turn the feature off
    > with the nvme-cli.  I'll be sure to keep an eye on the Host Behavior
    > Support feature at NVMexpress.org.  We created this new nvme feature
    > control mechanism to help with problems like this and I'll be sure to
    > watch out for new protocol features which could break compatibility
    > with dm-multipath in the future.
    >
    > /John
    >
    > On 8/8/20, 5:08 PM, "Meneghini, John" <John.Meneghini@netapp.com> wrote:
    >
    >     I'd like to up level this whole conversation for a minute by
    > talking about exactly what ACRE does.
    >
    >     The genesis of the changes discussed in this thread is NVMe
    > TP-4033 - Enhanced Command Retry.  You can find a copy of this TP
    > here:
    >
    >     http://nvmexpress.org/wp-content/uploads/NVM-Express-1.3-Ratified-TPs.zip
    >
    >     This technical proposal added a command retry delay feature which
    > is programmed by the controller. The controller advertises a set of 3
    > different timing delays though the Identify Controller data structure
    > CRDT{1-2} fields.  To make use of these delay fields a new CRD field
    > was added to the CQE Status Field.  This allows the NVMe controller to
    > specify exactly how long a command retry should be delayed, with 3
    > possible timers that it chooses and controls.  CRDTs can range from
    > 100 milliseconds to 6559 seconds.  Because this capability can have
    > such a radical effect on backwards compatibility a new NVMe Feature
    > Identifier was added (Host Behavior Support - Feature ID 16h) with an
    > Advanced Command Retry Enable (ACRE) bit.  This allows the host to
    > enable or disable the feature.
    >
    >     With this background there are a couple of misconceptions in this
    > thread which I'd like to address.
    >
    >     The first is: ACRE has nothing to do with the
    > NVME_SC_CMD_INTERRUPTED status.  Yes, this new error status was added
    > as a part of TP-4033 but the CRD field of the CQE status can be set by
    > the controller with *any* NVMe error status. As long as the DNR bit is
    > not set the Command Retry Delay can come into effect. This is how the
    > spec is written and this is exactly how it has been implemented in the
    > core nvme_complete_rq() function (after change 507fe46ac91276120). For
    > example, the controller can return NVME_SC_NS_NOT_READY with a CRDT of
    > 2 seconds.^  So CDRT needs to be supported with all error status if
    > the host is going to enable ACRE, and I think it's a big mistake to
    > get hung up over the NVME_SC_CMD_INTERRUPTED status translation. The
    > NVME_SC_CMD_INTERRUPTED status was only added to the spec to provide a
    > general purpose "busy" status, something that was missing from NVMe,
    > and focusing your solution on NVME_SC_CMD_INTERRUPTED, or any other
    > specific NVMe error status, is the wrong thing to do.  There is a much
    > larger change in error semantics going on with ACRE than just this
    > single error.
    >
    >     The second is:  All NVMe error status that do not have a Status
    > Code Type of 3h (Path Related Status) are subsystem scoped. This is a
    > topic that has gone through some debate on the linux-nvme mailing list
    > and at NVMexpress.org; and there have been some ECNs to the spec to
    > address this. There may be some exceptions to this rule because there
    > are always implementations out there that may not follow, and there
    > are bugs in the spec.  However, this is the intention of the NVMe spec
    > and it matters. This means that, in a multi-pathing environment,
    > retrying any command on a different path will not provide a different
    > result. Retries should all occur on the same controller - unless it is
    > a path related status.  This is how NVMe error semantics work and this
    > is a part of what was behind Keith's patch .
    >
    >     https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=35038bffa87da
    >
    >     Retrying NVME_SC_NS_NOT_READY or NVME_SC_CMD_INTERRUPTED on
    > another path is simply not the right thing to do, and returning
    > BLK_STS_TARGET after all command retries, with CRDT, have been
    > exhausted communicates the right thing to the upper layer. From the
    > perspective of nvme-multipathing Keith's patch was exactly the correct
    > thing to do.  I understand that this may have caused a backwards
    > compatibly problem with dm-multipath, and that's the only reason why
    > I've talked about backing it out.  However, ultimately, I think
    > nvme-core should return an error status like  BLK_STS_TARGET that
    > says, semantically - the IO has failed, no retry will work - because
    > this is what the NVMe error semantics are.
    >
    >     Taken together both of these facts about the NVMe protocol
    > semantics are what's behind my patch which removed blk_path_error()
    > from nvme_complete_rq()
    >
    >     https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=764e9332098c0e60251386a507fe46ac91276120
    >
    >     I understand that there is a goal to try and avoid having
    > different failure/recovery handling semantically in response to
    > different error status between nvme-multipath and dm-multipath, but
    > NVMe error semantics are truly different from SCSI error semantics,
    > and they are changing. The Linux host needs to enable and support
    > those changes unhampered by the past. With this goal in mind, removing
    > the blk_path_error() code from nvme-core was the right thing to do.
    > Hannes and I struggled with the patch to try and make it work with
    > blk_path_error() for weeks.  As pointed out in the thread below,
    > blk_path_error() is the SCSI multipathing logic and we can't use it in
    > nvme_complete_rq().  All it does is import all of the legacy problems
    > of dm-multipath, and of SCSI, into the nvme completion/multipath
    > logic.
    >
    >     At NVMexpress.org we consciously added the ACRE feature because
    > the SCSI protocol had no such capability.  This is something which has
    > plagued SCSI implementations for years,  and all kinds of tricks have
    > been played, in both the SCSI host stack and in SCSI target stack, to
    > deal with the problem. The goal of NVMe is to create a better block
    > storage protocol and ACRE is just one example of many places where the
    > industry is trying to do this.  There are plans to introduce more Host
    > Behavior Support features in the future.
    >
    >     In the end, we are consciously changing NVMe, both in the spec and
    > in its implementation, to make it different from SCSI. I think this is
    > what's at the bottom of the changes discussed in this thread, and this
    > is why so many people are so passionate about this.  We don't want to
    > turn NVMe into SCSI.  I know I don't want to.
    >
    >     /John
    >
    >     ^Note: (maybe a 2 second delay sounds unreasonable for a flash storage device but there implementors that that want to use NVMe with spinning disks... so the CDRT gives them exactly what they need).
    >


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
