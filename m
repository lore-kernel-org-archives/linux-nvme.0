Return-Path: <SRS0=Q2qb=ZS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3994C432C0
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Nov 2019 04:01:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64BFD20678
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Nov 2019 04:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JZxoCgbj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lzL7YhEH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Nq0NZtVd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64BFD20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=b00Rug/qNjUZG409U8F/cDFYWSNKJAI0fwrL9hMYIxQ=; b=JZxoCgbjMVtwoi
	adunc6pf56n1BjUVFy7WMsHhAVbTecs4Hs0x/O2UgYQ8me7cuPWBSWhYFgzMjEXRHTBkUIUt+o2wQ
	IkUW5IVl7OulJt842r0gZn8ye9QlFZjEnjMmBaIkVw0oGweMD/hCT44MoYeAvBafye1zE5kaUVX/3
	tPTiJJVmycrsWGQJZdrEkCJM8uI5tMFsCCzBVWlyPxrpWDWm2DC1LCu2nqz5JrLrN4v1mX07zybeK
	HwR/PytoajnJDdhf0xL6rdEh0k2+qAdc2w58GE5QNg1rxGibqA4rnLNKqang3AKzLKJRh5mtSAg0e
	dcyG8XR8QPt40l3fvRag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iZS2Z-0003Rf-BB; Tue, 26 Nov 2019 04:01:27 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iZS2W-0003RI-0T
 for linux-nvme@lists.infradead.org; Tue, 26 Nov 2019 04:01:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1574740988; x=1606276988;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=oxCwCpRFLu0ZnrS0lPvz8s6QUWOrtx/iLcb4PYZTxuk=;
 b=lzL7YhEHb8TRhWZ4ovXQ5MPB1Et44GJXmlx6KmR9d9vVupX+G2xM4Rt4
 HzdoP4qpuBmULf47GKoPMpz0Yn6xDhgUgshDJvqXu+4J4JT4t7cR1YK1B
 tCtsKR9Z5C+Vun62Xr2oVUzBK5h5jsaHDpupGKP3LHA5rKU8GqnB900Iu
 Fk+6NvajWmUkpSrCajolrOUDfR+mRDIttAir8AiJinuTJY8SKM4FQoY+K
 0PMfyWwTPdYQCZsG0OwAh1e7Ps0pM+xEvpbF8/Dl6bMoeucrAGDuT9a8c
 rBdKER3PFRIzh+0CjihE8a1UqTZrb7ebHEiMjI/LMDQMYtWliaCMSL9Gy g==;
IronPort-SDR: Fnpibw+2b7Jse+ryhVQ/Smq5kzeYXNcjtUvru+pt9acMuyQEMc6fiZXuVkLBDqZKubYV1Akdqm
 u0ABNG9NCrg+I0WsS2VWN7hNHfX9rd0M98tFw0zeggiNQCqX64euU2mlPHgdxYnJO7xV2mkMY/
 DJi8tibyWUS+WsR47w9q3gbY25V0ySMSX+n+AWwxiVpjK81fvdJC+TBhkFWTX7PqfzgcGCRlYK
 iYgcGuby0I6uaoxtR3eY3BkfBx94SnP98yDwu3Ye8kkMFpmm/QRA7mMQ8VKzhSoptMBcB1BRsO
 myI=
X-IronPort-AV: E=Sophos;i="5.69,244,1571673600"; d="scan'208";a="225392487"
Received: from mail-bn3nam04lp2058.outbound.protection.outlook.com (HELO
 NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.58])
 by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2019 12:02:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwHY6q1/PclsHhRlO8QHVRihv2v9v2nEfJD+w6SbBIwKsISISQFfhMOrepvGjBYwKOxaknjnapJ5nrFNT49v7Kp859Zc3JEQcXJ9EkuCyc2XFLQ9H1aQ7c1GavI3wU7VTQOWIrFhPKy+Mjrg2AHzsBLoapVtkZTOAL2NbAyAump6gHIKewBdqIzGCFDmKhDsltX9eS/bU42JQLewW8zUXvO0TTyC9J9cVfI1bZutq+Uf2sDR8J8nAVCCdig96x6OoIBycoyNMCuC0z2mTN18TA4QcCbCde/dqhIdBoUwCNGw+FZ5I5yzcwZbUaRD1wNp6QCNQL699qbDGqSoXAWyyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxCwCpRFLu0ZnrS0lPvz8s6QUWOrtx/iLcb4PYZTxuk=;
 b=CDp2w8iLhuBC8IZIo+n3Mwn8wtZcyTTLYZ2caLFRBiw6a+YY4TnOT11cRrSW+c2G4tYH7pNGLa8gL3EzvZzU7mumn0/zpopTNoc6JAkYadpconMRS53nMllGOlEgzTeTKWHRiqKZlNUgGvO53yjd1Pz+0D6RBizgPk3F6e10fdkYFiBfnC1ZgJ3NrG1k6oy+7W77wXtPEyJefjnx9iiqZjDKd/l0jdopUqQSBG3lgOyaTr+Pugt07esqrZdCcwuld0OBoMudD0ApR16XCcaaGUBADHB5nH530x0mEQK6xmQAraFhcVDc5DU1CH9Rr10A/Jkz6395jU6iNDMxl+npmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxCwCpRFLu0ZnrS0lPvz8s6QUWOrtx/iLcb4PYZTxuk=;
 b=Nq0NZtVdJMjy+wPe4y6hKG7Bgq2qZGM/lOOaF+oTZ3yU/RD788iMN9cV/sSAJg6rPKpCx1u3k47IlweBylox7jNKXnWYCbxy6fTieH6UEL1jp/clh2PSSpNLndNK+yvXQudFDe6setfp/A7IgUiGTDDO8d0LmwfmZDIol48ZsQ4=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB5830.namprd04.prod.outlook.com (20.179.57.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Tue, 26 Nov 2019 04:01:12 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04%6]) with mapi id 15.20.2495.014; Tue, 26 Nov 2019
 04:01:11 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Keith Busch <kbusch@kernel.org>, "Nadolski, Edmund"
 <edmund.nadolski@intel.com>
Subject: Re: [PATCH 1/2] nvme: remove unused return code from nvme_alloc_ns
Thread-Topic: [PATCH 1/2] nvme: remove unused return code from nvme_alloc_ns
Thread-Index: AQHVo6pkmnYa0fZgtUqAZNhB9+q1Lw==
Date: Tue, 26 Nov 2019 04:01:11 +0000
Message-ID: <BYAPR04MB5749859E2636E3FCF355769386450@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20191125160612.3542-1-edmund.nadolski@intel.com>
 <20191125160612.3542-2-edmund.nadolski@intel.com>
 <1ca1b4c3-8c42-c728-d987-18821f83088a@suse.de>
 <221e4352-7fab-abea-9f43-2cd1df60dbaa@intel.com>
 <20191125170644.GA1639@redsun51.ssa.fujisawa.hgst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: de9a7442-8050-4c7a-5169-08d772254690
x-ms-traffictypediagnostic: BYAPR04MB5830:
x-microsoft-antispam-prvs: <BYAPR04MB5830DBBD32CFCE87DCB522C286450@BYAPR04MB5830.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0233768B38
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(396003)(136003)(39860400002)(346002)(366004)(189003)(199004)(102836004)(6506007)(53546011)(26005)(446003)(33656002)(186003)(76176011)(7696005)(66066001)(478600001)(6246003)(4744005)(4326008)(25786009)(316002)(3846002)(99286004)(54906003)(110136005)(71200400001)(71190400001)(14454004)(86362001)(256004)(76116006)(6116002)(81166006)(229853002)(2906002)(81156014)(6436002)(305945005)(74316002)(8676002)(52536014)(9686003)(5660300002)(64756008)(66446008)(55016002)(8936002)(66556008)(66946007)(66476007)(7736002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5830;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6DMzdpjfNhvaatJ34VtR6H+iut/gV2wnJqjAFzutY5aSTeRhrYmgboTpALMjsV7j7UFrkP4soM8pEM3Okm6plOzYrxZF3Ca1mtmVcPeOapnpjMGXfple2CUqS+Ov1OFx5cCNzjrCOMAyHNQ9zxO94mmUSJOadPjPcWPm5iXgQoPrjwNAf9fnawlKtH+OM3cpY2Unzs/LPfJYZO3DFD2SnOqpBvlI/eC+A/QN0onZM09M+M4VoCFQvW+1jc39oHLDzELQpAhB2x7+yJxpRuzwVb6c5XeoJa2ydwENtkZKyPYDQCsA3qhXeZh5UI/Q9UfiC+ymFHGl34esEqmQyqeIZier0frcW7GlJOHKYkheM9cWLK3w0z3Bzu1dDTwNlMxc9+SYAyPFS17ELa+rLqn133VMFy5eMxOsFb9Uqov/JmRBSMGvqJ9S8vHQBpjgqkeH
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de9a7442-8050-4c7a-5169-08d772254690
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2019 04:01:11.7785 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U4VfektJULId/RIPlJZ/8T71OiTcZWsJGNDt8r6DnWiZze+CHkBcgMZsSOko6/eJQpOl7cJ/nNJRp/IniHUeWDtw4GtOqgSuEBQhBJecmYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5830
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191125_200124_141087_66E57136 
X-CRM114-Status: GOOD (  10.45  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Johannes Thumshirn <jthumshirn@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/25/2019 09:07 AM, Keith Busch wrote:
> It would be informative to just log the error that occurred so we have
> something indicating why an expected namespace wasn't created. Otherwise,
> I can't think of anything else the caller should do in response to an
> error in this path.

Please do this, shouldn't be ignoring return value completely at first
place.


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
