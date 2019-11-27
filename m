Return-Path: <SRS0=HRbs=ZT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8D7C432C0
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Nov 2019 15:30:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FF6020674
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Nov 2019 15:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MzeJ15FN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=netapp.onmicrosoft.com header.i=@netapp.onmicrosoft.com header.b="E0F9z2o/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FF6020674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netapp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BcTqKQ2zCsgAO/WJDj1OSKQFmB7SJQ2Yfb8MyAX7xZE=; b=MzeJ15FNodAfyV
	XxVqiysW5TiNwcpQVXHxCkBw3Lrz1olOFq/71vLq71x0GPiVFGYIHj0PHOOVlkrII9FN+jZx23qlv
	I6h03JqXAFejhOKNvWs3ZIitEshd4NHGjn1uDZn7rql9Sful136VQxKYVgz03vIK1OBf0UVUv9VmM
	LZw9ve8iYK/XBZgtmfw+wQAdFIjQCzZAdFIkXKxpEz0iDYmsuhxzCqPL1ddmzua6YIO/nvU9tGEVW
	qu6CaNg9k8MpD6Jnwg2caeIYja6qoisCL+B7TDXzB7eYD1+hQUhBVjG3uBufEgNs67iWe4QZNwGBG
	K2NI/6xI7nCtcnDSoK1w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iZzGY-0007p5-Gx; Wed, 27 Nov 2019 15:30:06 +0000
Received: from mail-eopbgr800050.outbound.protection.outlook.com
 ([40.107.80.50] helo=NAM03-DM3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iZzGU-0007Mz-B8
 for linux-nvme@lists.infradead.org; Wed, 27 Nov 2019 15:30:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKxhQGulIJRhw0VI0MvuIyUu441Z6cprHxWJFBjp3GsMrXHylODiSBrt9Q2nfWLZdTTWOGz1SOpC7DD3n80Yo4e4BexpR8MaaIHvRAbDshoZ4yXlUrHwwJ9z7O/uNBdHUN9BUEKETUlteEXcks9XycRdrt25keWKOdTYdGdoIfTMHsDjFcIB6MlksZdtIaqx5BfAwF5xfSH/Lluxe11G5BP53zPlg0/aEhrTrczMNyIcHu8EqrqXXaUsVbkl1s6sWzvZo1dL9apQjq9hdsVddpbZF2E8T2mWko/kuw5eY45qryHvVpCbLtjpGKnMcUABsOjOeOVwX/4TeLDTeblYQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNkkFxrQF+k+Te5lCW7E4stWVg2n+dap1ZTOYiCkQ08=;
 b=YxQjQqCTSFrQJz+BjlgFwIi++hXgTGNEGDHCTLo6fM+JGEyqcGHUpIHVlVocNBH7xLd40IncRgfu8XiKQHCt3IWB2/MMAuisrV/1PmWttjYY5YYia4H/FdEkP8VXnGMO/wa9VoVJwfA6CEesz8q9hMcuOcRLSjD+MfMnD2dlHo2la9SOAsbnmM65iejFNGpPAzvoc3YKi7bitfyhbdU5eDWFFM5ll1c71HDxPhQKemwuaK7L4/6IErn1JehuC4ZsL4dB9yS5a3BsXuLY0qqAFIEEaai+VxpFmauqt9HYI73ihG0O8vme8HlnWYMtR49CR/bgyYTFPJxqFSp6GQ+GKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNkkFxrQF+k+Te5lCW7E4stWVg2n+dap1ZTOYiCkQ08=;
 b=E0F9z2o/FIjrycG21TXsbsgjEadvf/Qdo3VQteOHF5A87sSpvpHw2YVbCDlCo6EXVYtobDAXWavxnHheEY5V+tyyE/S2UJMjYgzj/nQ82/iocAVuysFYJnECrWCPEE6+k6PSC+e9Fp1XU6s6in5KtIuq5UunWhq2AtpLFittNLQ=
Received: from BN8PR06MB6115.namprd06.prod.outlook.com (20.178.216.139) by
 BN8PR06MB6004.namprd06.prod.outlook.com (20.179.140.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Wed, 27 Nov 2019 15:29:58 +0000
Received: from BN8PR06MB6115.namprd06.prod.outlook.com
 ([fe80::6923:8e28:8cc8:6c99]) by BN8PR06MB6115.namprd06.prod.outlook.com
 ([fe80::6923:8e28:8cc8:6c99%5]) with mapi id 15.20.2474.023; Wed, 27 Nov 2019
 15:29:58 +0000
From: "Meneghini, John" <John.Meneghini@netapp.com>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: Add support for ACRE Command Interrupted status
Thread-Topic: [PATCH] nvme: Add support for ACRE Command Interrupted status
Thread-Index: AQHVpF6Ymda5HHf+tUmLPGNyVZkab6ednfwAgAAFJgCAAS9bgA==
Date: Wed, 27 Nov 2019 15:29:58 +0000
Message-ID: <AC3DED38-491E-4778-88E0-DEC84031A115@netapp.com>
References: <20191126133650.72196-1-hare@suse.de>
 <20191126160546.GA2906@redsun51.ssa.fujisawa.hgst.com>
 <20191126162412.GA7663@lst.de>
In-Reply-To: <20191126162412.GA7663@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.1e.0.191013
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Meneghini@netapp.com; 
x-originating-ip: [216.240.30.25]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2fc8be42-bb30-49a9-ef67-08d7734ea976
x-ms-traffictypediagnostic: BN8PR06MB6004:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR06MB600461F376D3C54D6A8C8671E4440@BN8PR06MB6004.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(199004)(189003)(91956017)(66946007)(76116006)(229853002)(64756008)(6486002)(66476007)(66556008)(66446008)(99286004)(107886003)(5660300002)(71190400001)(14454004)(54906003)(305945005)(25786009)(36756003)(256004)(71200400001)(7736002)(478600001)(11346002)(2616005)(2906002)(8936002)(33656002)(4326008)(66066001)(81166006)(8676002)(81156014)(6512007)(76176011)(316002)(6246003)(58126008)(86362001)(26005)(186003)(102836004)(53546011)(6506007)(6116002)(446003)(110136005)(6436002)(3846002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR06MB6004;
 H:BN8PR06MB6115.namprd06.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wWGhqT3oB5jDSYSFDdNL0I6i8iWLTyY8aTkjSyVFPqcfQLTo88XgEzZZbKPrFMdoYyrema82R7pvQbFlc/Mxr5w+yTexamyotq+kBubAynz+ytK0g9pNVeCQEwDzZ6oJybTVPi76Onin1mqYL05Zi/QFEeH6KL0q9d4KiFKNYT/ZqH7mbend+PhSRMnaLiNWin+2nV2/A6OaAjYDJ938cL0SqXXZ/Jjge7sHYW6zSwEfhrb0zsZNmnKxE7AMPiciG08mKcodGp63i8tALNXhw7Mj8ajxsX2OWw1z3KZ8r1IFgijcG3CMIPQ0w3WxW89aXKFdg+xGFmy4DtXHbT/O+oTb2Rl8YDerrVT33u1LFqGeKYeXydLUvVbPtqaiZanPiTtC0THu8bCNi03J3Z4dLpFjp9ZwnFmY2LvKNwfAdPBTYjghz/egjpb4K4SH/+b5
Content-ID: <D7D91EFFC9A1964980F7712D0E3B47AB@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc8be42-bb30-49a9-ef67-08d7734ea976
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 15:29:58.3272 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l0kHBruvpVU1RQ0PlO6zX42Wt4JfCodg9w7Ma74lnOsx2oK2mvGcFJxyspeAnjeS3ErWFzaglB8UlOFWN9OCcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR06MB6004
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191127_073002_452076_A4F0AE1C 
X-CRM114-Status: GOOD (  12.12  )
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
Cc: Jen Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Hannes Reinecke <hare@suse.de>, "Knight,
 Frederick" <Frederick.Knight@netapp.com>, "Meneghini,
 John" <John.Meneghini@netapp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/26/19, 11:24 AM, "Christoph Hellwig" <hch@lst.de> wrote:

    On Wed, Nov 27, 2019 at 01:05:46AM +0900, Keith Busch wrote:
    > > +++ b/include/linux/blk_types.h
    > > @@ -84,6 +84,7 @@ static inline bool blk_path_error(blk_status_t error)
    > >     case BLK_STS_NEXUS:
    > >     case BLK_STS_MEDIUM:
    > >     case BLK_STS_PROTECTION:
    > > +   case BLK_STS_RESOURCE:
    > >             return false;
    > >     }
    >
    > I agree we need to make this status a non-path error, but we at least
    > need an Ack from Jens or have this patch go through linux-block if we're
    > changing BLK_STS_RESOURCE to mean a non-path error.
 
   >>> most resource errors are per-path, so blindly changing this is wrong.
    
  >>> That's why I really just wanted to decode the nvme status codes inside
  >>>  nvme instead of going through a block layer mapping, as that is just
  >>> bound to lose some information.
    
It wasn't my intention to turn NVME_SC_CMD_INTERRUPTED into non-path related error.
The goal was to make the command retry after CDR on the same controller.  So why 
does this patch change the meaning of BLK_STS_RESOURCE?

/John

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
