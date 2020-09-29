Return-Path: <SRS0=g+aI=DG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F75C4727C
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 21:12:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5322120757
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 21:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aa4wQnst";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UYXEqQu1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="QAuOiess"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5322120757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=5CTPw7zbnIjpLZc0Z2RCT43VOm1Kbe93ri2KMfBnlAk=; b=aa4wQnstW/yyJ4Aa36i2c4jta
	QiFd8KYPCAUd7MVpHnZia3pSg23eXuTUwOPfteSlvf3FMR3l9PKKi0JUIRDlcEk1yre0IcHhEy+5r
	qiASUyaQ6ACFtZYt6njna6/3R3rTK/nPCHqrfliykmccMbwgk4N6bhTlSBJiAIFM0OT93Qp+HSUzn
	Qvlh+oHY0Nq7vPsFjiwYTZ7C2SySNFzVU0HuFy7eKOqvqztxzVtxaK/JoFVd/Y/Br8gW+vSPyF3cu
	bWAzN71TNCNBRgyYvM++lwAZqjMWYXP2luSdxBSSBV7fYoYbxclcJ6r5XEfWbvNYpfsYdsTy76Y1m
	tH86hcdHw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNMvZ-0001Ab-Vd; Tue, 29 Sep 2020 21:12:50 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNMvV-00019z-Pf
 for linux-nvme@lists.infradead.org; Tue, 29 Sep 2020 21:12:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601413966; x=1632949966;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=aJs/XqgTp8GEFnBQ+K8eCpyxGjECYytZn43nuIIQbbU=;
 b=UYXEqQu1UPowrcnpMHbDr6kBIXgJnfEOBYwDY76lKi8SjkkGL3/kgiHD
 LEx0vhDS/gV5odFu1c7VGsrmRt4KfY7uoGqf1qRnt5WCePFoQqRM+l826
 WNGPJkadlAzFjEWgJkuuSSc3Cb8e0dLJSzn7YWJMjd7juNDvOOa1fJ0Sa
 QccBpbtWAoGx1roklCBpKzHirVOCHAtZEciJa2yFouAoXFKEE6NFVU0Lx
 urEvnLq4tgC/5WQmxZiV0SJB1W8vKGH02Ix5QTHQNjcP11TGJeiUq/hDw
 oDRHVuJ6rRP4oSoXkkw9FDbIi+UNNCNH4LY8PX+26rZaD7C/lbj9yHZgH A==;
IronPort-SDR: QRxfcJxbx+O/kLwEK1w5urrbdOASmiLg0nMiVpawmk2yMlnEMBaZjxXVbEZrfZ2nuyjD5VoGRH
 EBQ+DT0d3fF628LbHDE+Fus5a/szqQkdRRBwDTOa9HGqcYyLawsEvj1TPeSEuRmWWG7whdfagE
 lO9K3lCZUl7vo7fnHye5mcdnKQLcyhHpdlCK7sRuVpavnOxHVB19tvGlN+lRDaO/bqcAjweAtF
 7QR3zS8HYz+aIbcUAxC6HbuEeCoEqhzhqGfyhs8BKFiCWlZyeQvoq02VUYdM//iK0QgwdGKhre
 4nY=
X-IronPort-AV: E=Sophos;i="5.77,319,1596470400"; d="scan'208";a="148620795"
Received: from mail-dm6nam08lp2041.outbound.protection.outlook.com (HELO
 NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.41])
 by ob1.hgst.iphmx.com with ESMTP; 30 Sep 2020 05:12:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLMZrcz8brN2zO6LMSGgSowyzklNoaOa/mxU6vih+MbC1q3U+sRw0JCqRajWKHShqVXcfM95JWSH8f+OfiIo0yBgjdLYzyrKCW/2DZDm7OzSFnapmCHR8168nDct77nUjH+Z44BvNfZJWG64/AFRZRlGtn532vJOsx1GWlRI7nD/DF6fKiVa5c/ec4C8BtXaFDUhhYCWa4i6Zgpvgt5V4VuhdTBy4cYTNWKpuK5rrlcBHHqJIWx2gLoYn4gdqCHg4GQCz14+RaXS8U14QPt6/xxd2LPd7l+KVQYMj+ah4fXw9B8MxgPpnNKmEcjXsQ98xc1gbnrc2ZPHB3EMBUALmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJs/XqgTp8GEFnBQ+K8eCpyxGjECYytZn43nuIIQbbU=;
 b=hrTo2kQtUX9ru3XakDjDah7bfjigG+xoq+Oxwfvb3PNJp3AtZvEuK9UDn9T7OAYuTq3niUhSA04wu9VMHr6sut8itd4lrpRmSDFpNDNUDWIVgqmjU3V/TjCaFliovFb/Dyf0k6sWumaTweIYt4Lx7JgYtxj4P55UaPFQo+kLz30tYUuRF1AvMwylY9XwpCenxp57PLGbAk3GhrHoPZF5koQH0USESkGNkU7Fj+O6npy9vPqEUyIop3BlC4Gf3FwQFRnKk5yTvEx2UT7oP6lBW3lFW9737511U8V537/wKwQ92rnzoz3DlxwdleH40EhFEBOqhzo4BHNbzcFlkY6aFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJs/XqgTp8GEFnBQ+K8eCpyxGjECYytZn43nuIIQbbU=;
 b=QAuOiessk9r4/nbeDnP4OG71n1+7NjkkMPaQT77SXPSfVqCrFyJLPXMknD2AURFQY8Ryz+rh+k8Sc0Ju//KCMjlmWDIsDb2+B1W+/fMlQyT++8dHl4QorT+y9CfutBNnmBgtOXiBUVtxGfD6GM4bMBhugYAslJ9mBUBqNsJ0taM=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5333.namprd04.prod.outlook.com (2603:10b6:a03:c2::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Tue, 29 Sep
 2020 21:12:38 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::e1cb:3a58:d588:d7eb]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::e1cb:3a58:d588:d7eb%7]) with mapi id 15.20.3412.028; Tue, 29 Sep 2020
 21:12:38 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 01/20] block: optimize blk_queue_zoned_model for
 !CONFIG_BLK_DEV_ZONED
Thread-Topic: [PATCH 01/20] block: optimize blk_queue_zoned_model for
 !CONFIG_BLK_DEV_ZONED
Thread-Index: AQHWlZSqJGNVxr289ke+jA5/N0DJpQ==
Date: Tue, 29 Sep 2020 21:12:38 +0000
Message-ID: <BYAPR04MB4965CA2C0BC5EFAF69BF32C686320@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e112c94d-2857-4c1d-1b05-08d864bc653b
x-ms-traffictypediagnostic: BYAPR04MB5333:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB533305CCF1F1C727FEDEBD8C86320@BYAPR04MB5333.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n3qSYmfkys2dq896/uoq2ivUDxg70pM//19T6FukIDOUTqRFh5Fti2+Bh2/8n4V1UFNpn1rFvxze1fuYWygPfPeE4potc92TmbOnTnnY0dTBJJHkpjeG7V3yx9nGtU6KcWasZnTl4NMQh/GnnoQSOfvR+aRgZb/tPVbBU2V4xPzBAgYXrJg4PyZFweKtorfsydC7Sm74GuT7qhapU7gylQmH0icOBeucGL4o++cdhHm+0Yv+IMAO6xwpgwggVghkwCi3EI7fpGwRQVb5lN+bjfd/y08d6wj3u91+FcM3MGYNkOiQYhxxpJDSv0fXluDTmZyBNw6mcMWOUs6fViYvRA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(396003)(39850400004)(376002)(136003)(86362001)(4744005)(26005)(478600001)(186003)(52536014)(7696005)(66946007)(316002)(54906003)(110136005)(66476007)(4326008)(66446008)(66556008)(64756008)(8676002)(8936002)(76116006)(5660300002)(33656002)(2906002)(9686003)(53546011)(6506007)(71200400001)(55016002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: VWh4eUGWrLfu8SSmt/60eu18VrTIi7mvuix1Q0s0d40SoSyQX9Ak/skMUDdESsECQo2sZL3FsJIhp1YCZB8WVH68SOI2yfzR0egX1ZT4eXfXWOxOnnCAg3z6zhBQ+ZtVLejWnW4+VUnFZv199GhtmIA9NJxBkF5IZ1IdWRWT05P+K7AlIkuj1itB+giKKut4kl66kyohLmzktXYe/D6YqQ3WkNVFHJ3IU6oJ3y0FVCb3cGW9j6WF46P+p8iRfXRhLzJxmqvENsk4d9KonC/h0yOk3WF1sf8jByxqlgcsxBYTBcKPNC3+ZQ63w232VPRtBqN/8yihy2qt4gv87gFYWVpaTe9LY8qwCYWqqJU8I56WNBSugGPnZpA/0RWPsv/4TPfGGVer2uLscj3FCOZg6DhItsfe2suyq50ipmbGQidEiwUj52g4n9YaAJxK2isJFch+3dq+FQn/5za1yfCTSF2yXEhTcWj9cLqXsd4Fid+Yw2b6142f0qVUSk/EQgzsvSEyuA9HWVRaL4tSzLJ9rr6E4vJlPNTRsapz2HFsT1KT584P48ASJedUZqyVeKwImr9G/9vrCDHBz8OBhe+pCiVEdhODjjMcY9e3JTC5iVqwTAfkzF48aEK0gvVZHlu9Ly2fFkpfIy0zOqpLp3b29A==
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e112c94d-2857-4c1d-1b05-08d864bc653b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 21:12:38.6207 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OUWneTr7m4VDzvmET0YiqyLH59Y5tikIATLyFJDTAtZyfun1pnGaaJJjTU6OCpTmya17g3P4bfMu8CdWoWAGJrFdFThn9FHqq5O5KjFeUlU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5333
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200929_171246_245103_4B8B0C8E 
X-CRM114-Status: GOOD (  11.94  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/28/20 05:41, Christoph Hellwig wrote:
> Always return BLK_ZONED_NONE if zoned device support is not enabled.
> This allows various compiler optimizations including the dead code
> elimination that we so like for avoiding ifdefs.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
