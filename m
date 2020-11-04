Return-Path: <SRS0=H+rW=EL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B100C00A89
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2020 03:40:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4E4E2072E
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2020 03:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C8iLfgXp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zh3Ou8Sk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mRwbqFaz";
	dkim=neutral (0-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Jnukxk9g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4E4E2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=KvXkZpzWRcrI664kKxJp7G96S4e91GFNj9lfbURoL1M=; b=C8iLfgXpsoeKXRwr1qIggE/pn
	68Qf+fWo0QeqknYjDrl/7ik/3kc58Mgfhi+05wIhGBHYeGWCQ/xAjDSC1uImJsX56DW2B5zL1ga5G
	nF/stpL1oWSLMeLnRzOAF3Q9O4E0Zj1F8Vof7CFCLd1t1/lLRdnCCB+YARM+HhpX6CO9No0jtdUHM
	dCgR01RNv8kyn+leWfqptIzWz7P7choCa03cuvnQKJA8hG1B6vSYCBO3E6aYdUfQNwNKr6SjgG1on
	UX8HLlCG45/vnXdpHRwj0n2DtgoDL0aUkIO3w+BHg9cZTCyAMu2em3yOiwhE8uDPkipgbphmXwCdm
	snySRPq6g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kaW8J-0002cY-CG; Thu, 05 Nov 2020 03:40:19 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kaW8F-0002bw-Q5
 for linux-nvme@merlin.infradead.org; Thu, 05 Nov 2020 03:40:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To;
 bh=7KsOHjllHEsJQXZauW64KEsQFjyM2mvB+G2kMrElh60=; b=Zh3Ou8SkToBe8YWBKADc62cJYP
 OusTypxyNtBKtmZv1IxxxfyWpjIeNbCAGPs58g4XPYU05kWv67zBY1c+d6OmaJt+o4t8dK+0gCfOS
 x3ImG1zlZEAEaqa8O5EWFC7QnaHQzjQHK4Z42jwnqNhiyeSE2AzA/GsNa4bktc67rSYg1rslfHA3E
 2S8Ct54YZFK5l9w0GRrIOj3bq1dDcW8ROhdzF/JnRW+4lCisYvJo59EoT/rFG6/miq8mJUM/nkl6W
 Xpo9werq5YhKTFcoPz263o0AFF5ErgRSfk9w4AUiTdzsoJTuBby6kJ3WJ8Y5wzYRxyYZRG7wR8ajK
 bd89iYXg==;
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kaPx2-000887-8s
 for linux-nvme@lists.infradead.org; Wed, 04 Nov 2020 21:04:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604523856; x=1636059856;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=szs3B0fQxDlVZHuiRSPuJe9haSRGot8v964mrpPdi3Q=;
 b=mRwbqFazR+xAbBcq4HhqKrCFgqTYWNwK7P+FwMVfcjx9GCY71VblZPtr
 F6i1M3WuzKBFYpPsGUQPyyMJw9pDZeNVz3m8ULc5ARExAd2FqRIZzBs2p
 hscCRQYiyFTUvTEwHmfukWilfp5syvjsg1+YNfKRybxlLMh86Fbyv74WS
 jFfmMHBvsxJIJtH8JxMxPYyMK2+Nvw5gc7D9seVgrJ5QwYUp6EqJ6DqPu
 8UFt5SZloZVJYVReP14mFuGz9uELZwfbImIB0h4llWMjbt0RHCAv2RMyY
 MfasKDUxR9pt9pqnOZfoKfl1r2BjOplfUK527kg13NXGlOgzEP7rQL0E4 A==;
IronPort-SDR: eqAtDctKpjfNXqGl80A39w5jav9CrC6fbW2qfSOIyymo8qaXZ3R+laHfqzV8FfUQ+WFoBZlOS4
 TSVL5H+qfIjfWNR3BLNYi18T20D6ZueUTvM6zpurXqOC3gsD4s2cSH+ZTBlq0BA3k2WLYiz42g
 IzAUReK2/zVi2fHCSs48gIuzrph1j/+7KL9YqMZuU5HYwMuGk50o3Aq1XP6PTPUHwQrBCgdMi7
 pPZD2ykjGQkc9z0p0h3WYTvCmQyOUjK2zMa2f0m/az38S1S1/J+nYOpv+Mo2ok2k0OhvSx1yIN
 lOQ=
X-IronPort-AV: E=Sophos;i="5.77,451,1596470400"; d="scan'208";a="156309341"
Received: from mail-dm6nam11lp2174.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.174])
 by ob1.hgst.iphmx.com with ESMTP; 05 Nov 2020 05:03:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cT/GcOaO7JDArIe6HCVdf12uvMj/qKuHWGlSkil+wAf66ERb3LxM3odtxwp7oQpXROMpjXo7euR/+pBSK/Xx8QnkOO6Q+Sx4a0R4wBx2DqtYwOBnKAIFQr1MwSI/aL7AjL8B3QFgqnKCYL4zW48yJjaKY72dT72GOY2vpyzexSNFLds43JXryplPUgrbbvdEWTqFTXF6XAhDqIRhywgBArG12JozPwsS7i07WS825Ks0YDCL+1DIBCRgyYGxNOhsmVcBlcTVkfEqV2qMWV/xJJ30rWQm8xjcd/vcRR+SA7L0Mf+yieMAt/RqeIH/eGNOlFFIsH5dP/TBLyYj1HbNAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KsOHjllHEsJQXZauW64KEsQFjyM2mvB+G2kMrElh60=;
 b=ObJ3nAJlgvxWy7WcVXWz0xEV4Byd4qWhg3OEyMAebhDWvNzsRrlIaO+44tBHHgPKGgCRIDpB0+sYh00EFuC7RFTZcSAoPqvpppSOdgsk1TND1Xnxpi9ASRJqFBv09ag8si5jyEyrJejt5QfZ2B87T6uIwIN/OKXvaAtpRYu7puGLbsQ3ahhelMZ8XucIuPAKn15gBNFjorIlO9D2XAf+bbaeksTlo9p5O/VGHHVLmKxLkipr2KLhOA9aaIoKaJYxHNzyTat/JDhZM8OV9cq1yc2p5VDBwGHfZPMrZfQAfvJebtlw3dWX7ij9uswglJO0k6qut8s5oyidguD0MRwImQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KsOHjllHEsJQXZauW64KEsQFjyM2mvB+G2kMrElh60=;
 b=Jnukxk9gCscmTZqXcpCyvdfL8yG/zAdQKUCyHTBSQDrwi7r5vKVVtgkcyDbphRBMQLD4KpES/bOZxbrFugqYHSVwpv4YNJWmv43olVw9x4oeS5eg9hImarkCXQV+cxZYMLQoJl3NLRSIIHCES5xgS7K/iB736XxWh+VHy2owYag=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7423.namprd04.prod.outlook.com (2603:10b6:a03:29c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Wed, 4 Nov
 2020 21:03:54 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4%7]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 21:03:54 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 2/6] nvme-core: split nvme_alloc_request()
Thread-Topic: [PATCH V3 2/6] nvme-core: split nvme_alloc_request()
Thread-Index: AQHWqA8VaYaH9u2hX0ax0hNP3CFlqQ==
Date: Wed, 4 Nov 2020 21:03:54 +0000
Message-ID: <BYAPR04MB49652A52CA9D130C4D2ECE8986EF0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201022010234.8304-1-chaitanya.kulkarni@wdc.com>
 <20201022010234.8304-3-chaitanya.kulkarni@wdc.com>
 <20201103182444.GA23300@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 645b1cad-27b0-478b-e0c5-08d8810523b2
x-ms-traffictypediagnostic: SJ0PR04MB7423:
x-microsoft-antispam-prvs: <SJ0PR04MB74231C3D2FC76BD4B6915E5286EF0@SJ0PR04MB7423.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i9b6ep+kKZBgEXZmsmg3tVw45ckjUQeUZg/zctyLT32duQboRnN3NrwESeUMM0+i6SOLO0Kf3I75DrbRtY0rl/yenRU6YyEdeHqYAnpenXNG5rABpdwjc8Zdy3e3PxiYExI5otZ5NrYdGCHfZ+hgka7WMNljeEQQd9eHJ81EiCO2omxAKa7d4xNYjj3fKG6Ytj4E1CC24Sa3pMIp5aJrpp4OCHf97K6Niw8v8SNY3QIInFuS0SVZLc9yeJopAW65fQH6/Qmsozz1x3c2C3218+S/NN1FlhiSdArFxMUbHGMfrIdlWYjHmjGE7uRW9e7ZOfC+RfIr4Vs1Exrsv8qAGQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(66446008)(66476007)(66556008)(64756008)(86362001)(2906002)(478600001)(76116006)(52536014)(316002)(66946007)(33656002)(54906003)(9686003)(55016002)(6506007)(186003)(6916009)(83380400001)(5660300002)(53546011)(26005)(7696005)(4326008)(8676002)(71200400001)(8936002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: xr+ibcnmXc6jdkxrYKkN/4iCRXgfQrvHmHflErOLMCjb8ec95YbhKLCh+idqTVukXM00a/elkAiMXRkPrsO+Thk/7quEfrRyVugJfxa+bNU3t8Q5MQzPkTw0lI1XWd4OCT/Rb6FTqU2fHCzNj0LxybVEDSwRQsKJNQpu9O5dRq/PMHUTOyn8QtnuJScWjm5BsLzS6uWsBqtZ7mVIRGF9/lyK2P4n/LxDv3vyuL8fG6p4pLXgtgWq9mm6aM/hHoSUkkVKgmoFJqCq2DIN+9RhoZVKHelz/r0trufJ8AJCdJoEyTR8Ar+q6XO3divtP+K/6nTUFF0u5guAPvDKh1TAo8MnHiqYMGMcOpr9tuKN4tXK+3tS9pSf30DsUHELd8/KpYM3qz07s++tf5Ee++A2eguuUNqtffYR+6XpO1Nz7UU49+n1KSNmmrQ8VbrmjTp9DivtZjE3l9SU7s9YQZNM9sM1C5fUuXp+sZkULRuWpH9g8fMTGjQHPhAiSfJfwjyQhLZErvb6WV72FdFofyyUuHrQZq6DYxmyIH5CFpPsxxQCEFUYvh7tx9zFXHw/JsB7gJTszq/y1TG3gC70p9NNtDyyydLvoDJiIxDGPQXczu08TuPvYKc0FWTjbkZIQRFn948RV6dC6IR3FOjs113yxg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 645b1cad-27b0-478b-e0c5-08d8810523b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2020 21:03:54.5321 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pct70/ywVSo1EpiaFX6Mtzk4K1yAqcqKhvZM1TVc5vM9ZgH/unCI6cG7JD6SO/EZX3k+YfTDCGVJumrJGs4G8Y6G/Nyw3Bo28CU5mkoLHdE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7423
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201104_210417_301167_8EEB2430 
X-CRM114-Status: GOOD (  17.46  )
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
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "logang@deltatee.com" <logang@deltatee.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/3/20 10:24, Christoph Hellwig wrote:
> On Wed, Oct 21, 2020 at 06:02:30PM -0700, Chaitanya Kulkarni wrote:
>> +static inline unsigned int nvme_req_op(struct nvme_command *cmd)
>> +{
>> +	return nvme_is_write(cmd) ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN;
>> +}
> Why is this added here while nvme_init_req_from_cmd is added in a prep
> patch?  I'm actually fine either way, but doing it differnetly for the
> different helpers is a little inconsistent.

I'll move this into the first prep patch.

>> +
>> +struct request *nvme_alloc_request_qid_any(struct request_queue *q,
>> +		struct nvme_command *cmd, blk_mq_req_flags_t flags)
> I'd call this just nvme_alloc_request to keep the short name for the
> normal use case.
Okay.
>
>> +	struct request *req;
>> +
>> +	req = blk_mq_alloc_request(q, nvme_req_op(cmd), flags);
>> +	if (unlikely(IS_ERR(req)))
>> +		return req;
>> +
>> +	nvme_init_req_from_cmd(req, cmd);
>> +	return req;
> Could be simplified to:
>
> 	req = blk_mq_alloc_request(q, nvme_req_op(cmd), flags);
> 	if (!IS_ERR(req))
> 		nvme_init_req_from_cmd(req, cmd);
> 	return req;
>
> Note that IS_ERR already contains an embedded unlikely().
Sure.
>> +static struct request *nvme_alloc_request_qid(struct request_queue *q,
>>  		struct nvme_command *cmd, blk_mq_req_flags_t flags, int qid)
>>  {
>>  	struct request *req;
>>  
>> +	req = blk_mq_alloc_request_hctx(q, nvme_req_op(cmd), flags,
>> +			qid ? qid - 1 : 0);
>>  	if (IS_ERR(req))
>>  		return req;
>>  
>>  	nvme_init_req_from_cmd(req, cmd);
>>  	return req;
> Same here.
Will do.
>>  }
>> -EXPORT_SYMBOL_GPL(nvme_alloc_request);
> I think nvme_alloc_request_qid needs to be exported as well.
>
> FYI, this also doesn't apply to the current nvme-5.10 tree any more.
>
Since it conflicts with the timeout series will rebase and resend once
we get

the timeout series in, otherwise it makes reviews confusing and stale at
times.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
