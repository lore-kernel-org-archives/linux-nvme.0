Return-Path: <SRS0=kA5W=CC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29799C433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Aug 2020 01:39:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5C05206BE
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Aug 2020 01:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gGJw8HP6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="X+c3v3eP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5C05206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ILYRswAPqAe3sYCeYl/IylEYF7662ec60Yf7IozJtjk=; b=gGJw8HP6CBGBBa/z+/jxPdTEFI
	APORXBQJqaBBRKiTP/LXwbixQMS+ZB3ee0diOAimBqK2KfHSPKdylR9/qrxHaC4nGwpNpSuMP2vCQ
	SSh6750iAAvwszeE5/NQpcSfhh80cdz8vwx9asbBOdAbCt/6ONam//BczQpaoIentiTjOrfgFmRY4
	PkkTeR2Ad/xm/1CulI7I84F/aIrIxDAx9hg8IFj+cPvJgtnAkodCC0s7o3rrXP/0GUVYFYDvtM3I9
	D8tVIhSjNoXY9o4aKs5Siav3yFW+pTXBlrz60haA+95wrkr+nMX6jRi+MflqSA9oPg64TirRiXfOo
	ImiEjM3Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kA1S7-0003Y4-BY; Mon, 24 Aug 2020 01:39:15 +0000
Received: from mga14.intel.com ([192.55.52.115])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kA1S3-0003Xf-7U
 for linux-nvme@lists.infradead.org; Mon, 24 Aug 2020 01:39:12 +0000
IronPort-SDR: HkxHV9crQVuH1Xmv3dNgZymJrVIPcgUcnhrUpUybe4YOcBEZNyIyOAjKYtJZCtOaR7EcPMUdci
 U5ngbfWQdLmg==
X-IronPort-AV: E=McAfee;i="6000,8403,9722"; a="155085097"
X-IronPort-AV: E=Sophos;i="5.76,346,1592895600"; d="scan'208";a="155085097"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2020 18:39:04 -0700
IronPort-SDR: WvgIsBPjzPcMYzTwvzLN0a0CkFM/BbKLmdrFIPx9wWrVG/Nyuvo0ITMGFjWmrEQ+RyZb1j24d9
 kifO/xm2pz0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,346,1592895600"; d="scan'208";a="330778102"
Received: from orsmsx605-2.jf.intel.com (HELO ORSMSX605.amr.corp.intel.com)
 ([10.22.229.85])
 by fmsmga002.fm.intel.com with ESMTP; 23 Aug 2020 18:39:04 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 23 Aug 2020 18:39:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 23 Aug 2020 18:39:03 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 23 Aug 2020 18:39:03 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 23 Aug 2020 18:38:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFchMEYH8sjfUzIbSUhUktGzqjCNLY4Ygnc6ChowQ2R+qyREO3M+Ht/v9CFhCip9f47pI8/wshHetZO9UlBnOsUlaN+GY6DenIjXX5LJUoirF0dnmKF9G6SZby6Nxik6ApS5acp8xQ31jvYGHqsW9fJGb0IBZ843JJoQKuC43RlBKWtrZqWeiTx/iiwu5/kPcKlmI99EV9n98VjcArjAQd7Z0A+OnxAUT+INdUvbbXRoQ7v5VLoXIwYOrizUuP0guqtVqsQdUTQIKrcSjV+UAdTZ5/lubv72Kojxx4y4nhj/Pye6lDyWigvqqAoB9q2+NjFXVkZBIG9aKt5Tf0YOWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmI6L9vMnxBUJG9jpC6mg2i+AtQVsiOxeLhzriigWjs=;
 b=Wb1FRNaertWt9gGUr9qESo9VuVBeUJZU33pzmCYnnDJXiX0/GKSrVschgKpcypi8KUnS4kYComoVwAlV+lHEbNbGHrK+/V6d9rEk9NF2H/eQXYbpu50C9pLpBhoPmfjmXux2XdH8LWj8KvSs4jSrn+WSwCtRKbnLVnNh5tuYD5XPmvMJhYsoyxq1Ko2+KnmQHATSKMx040V2Tf3b5qeUlvqOzoBCsqYr2fcOeCgzGo/p0C6Nqbiu5ANUU6d1b19/12ifEs8HkfNT9EA1thx4noasdyAxgTxLhCbudCh2m0/YaIeGii3pHn/KAm8V117XL6M07OlrMkXgMURuDz+iLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmI6L9vMnxBUJG9jpC6mg2i+AtQVsiOxeLhzriigWjs=;
 b=X+c3v3ePaw7faysYT5m3YYyl/6FHtD3MfxvO43ke3u2WATDv/3yt9CQ1MINSTALuvufzPPUnYtB9ocvuHdtYsAFQyZFFrBn4cbIfcIIb//WTcs0pHrR/s6u99FCTj3oBncO9gzVCztqphAAarfCzJWAbNl+3nhAMG6NJCKT0GbA=
Received: from BN6PR11MB4081.namprd11.prod.outlook.com (2603:10b6:405:78::38)
 by BN8PR11MB3777.namprd11.prod.outlook.com (2603:10b6:408:8e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Mon, 24 Aug
 2020 01:38:52 +0000
Received: from BN6PR11MB4081.namprd11.prod.outlook.com
 ([fe80::1849:565d:9454:cdf0]) by BN6PR11MB4081.namprd11.prod.outlook.com
 ([fe80::1849:565d:9454:cdf0%6]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 01:38:52 +0000
From: "Yang, Ziye" <ziye.yang@intel.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: RE: [PATCH] nvmet-tcp: Fix NULL dereference when a connect data comes
 in h2cdata pdu
Thread-Topic: [PATCH] nvmet-tcp: Fix NULL dereference when a connect data
 comes in h2cdata pdu
Thread-Index: AQHWd9ONJ/Zkzl2DeUOkBScZkEXwf6lGftiQ
Date: Mon, 24 Aug 2020 01:38:51 +0000
Message-ID: <BN6PR11MB4081C5F4644B9284856E56FCFF560@BN6PR11MB4081.namprd11.prod.outlook.com>
References: <20200821161112.50363-1-ziye.yang@intel.com>
 <20200821164810.8970-1-ziye.yang@intel.com>
 <59671b4a-828e-7b98-507a-181e6dfa55e7@grimberg.me>
In-Reply-To: <59671b4a-828e-7b98-507a-181e6dfa55e7@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.204]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e454885-2037-40e7-5153-08d847ce74e4
x-ms-traffictypediagnostic: BN8PR11MB3777:
x-microsoft-antispam-prvs: <BN8PR11MB377775661779055E4BC69C4AFF560@BN8PR11MB3777.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MvtN6lRdZz1VffgzgHKiJsFq0wzsYGPvikFsu22DZh7YlqZFeAWmUbva1hB6jWEuDAGpH2s06103U0/zm7iprgxwPJpw6y6L64dtnPpllai7gsAcaGpiskhjRNFZUiWF24Upx46Q0E0dON297OSR7qnEnmnCAwDU4VZEdE718e0MGP+powvcvffW5YQR9bDMsclxABpR4vxFHjxZ4nv4KoJ7cHB1tOkPjBtGKJhN+CPD1lHlbzDO/rtVW2Zf5Y6bTPGpfAAlRSOM07G0XF/7Ekr/m0nVVz4S/FhXw5SxCBv09HBxzlWpsIcnhOwR6MjCNhD8v9NUh3C5qk4tGUtt+w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR11MB4081.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(52536014)(6506007)(53546011)(186003)(26005)(55016002)(7696005)(33656002)(5660300002)(110136005)(83380400001)(76116006)(316002)(86362001)(66946007)(66476007)(64756008)(8676002)(2906002)(478600001)(71200400001)(8936002)(9686003)(66446008)(66556008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: SGvefV+0RNr0Yb4gEK+OEnmLI9LwYkMn7NpaxtFfOorQAcKCnK+6A4gBS2f1d5gw+H9FMA4osWZXXijOBJoS99M64cZa/qLOzeplEDxQFR2NzjITvuUabznf72BxWDolJEM8xX/UysCnQhHJsAO+HQU3Anis5oxJe4wRAv0mldTXuGy779BE8eqxh2gOF36LEyLVmn782Ce4NSyfhz5GqcnkgwNTQKaBt8rsUk0NaxzJbzVSvq8LN0UWB3Cozshlmrmm7cQTzNwpYYXWEvGB/wb2R4r6Mi9n4TKX92cD7G78AcEd1aNr0fHaUlo2xJMvPK9P+1NBHQtVkJRYk7MPIlezniE81usfkU2JQjLAbZHpMpC/RfwCESAliigjd7hHkohh87IW+q/ZFud95O82/KY/4r05YXYjtXdUV/meNaVBjAbIui1B9IAeu6RRvcVMAEGRtfKb1SGU8PABC51A2ThezDSl2Hr2VApIEl3Rq4BV6sbulrHnrGOcvGzUAgsdr8rUuA0f9nPJu4tYEWuud+oKPwgfNJV3pw1ymjQ/94JLQqZJiFryZU5PBOiovcs0TouGdMKF7YxQ17q39isyKszQSN7P4/b2gsd65oIC6M9pdY+2tSR60IYTk3Ja1X8f71qNarD0qv5tTESlL9T3GQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB4081.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e454885-2037-40e7-5153-08d847ce74e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2020 01:38:52.0371 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kfK9fOmI8rQIHVtHjW4EF47pJsgmuC35L9NiD0gujrvrXN5J33L5xOrUFvZEI24jcaURjgxZSbdCraoB0HQ30g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3777
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200823_213911_496409_2458820A 
X-CRM114-Status: GOOD (  27.81  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Sagi,

Got it. 




Best Regards
Ziye Yang 

-----Original Message-----
From: Sagi Grimberg <sagi@grimberg.me> 
Sent: Friday, August 21, 2020 11:56 PM
To: Yang, Ziye <ziye.yang@intel.com>; linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet-tcp: Fix NULL dereference when a connect data comes in h2cdata pdu


> When handling commands without in-capsule data, we assign the ttag 
> assuming we already have the queue commands array allocated (based on 
> the queue size information in the connect data payload). However if 
> the connect itself did not send the connect data in-capsule we have 
> yet to allocate the queue commands,and we will assign a bogus ttag and 
> suffer a NULL dereference when we receive the corresponding h2cdata 
> pdu.
> 
> Fix this by checking if we already allocated commands before 
> dereferencing it when handling h2cdata, if we didn't, its for sure a 
> connect and we should use the preallocated connect command.
> 
> Signed-off-by: Ziye Yang <ziye.yang@intel.com>
> ---
>   drivers/nvme/target/tcp.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c 
> index 9eda91162fe4..8e0d766d2722 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -160,6 +160,11 @@ static void nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd);
>   static inline u16 nvmet_tcp_cmd_tag(struct nvmet_tcp_queue *queue,
>   		struct nvmet_tcp_cmd *cmd)
>   {
> +	if (unlikely(!queue->nr_cmds)) {
> +		/* We didn't allocate cmds yet, send 0xffff */
> +		return USHRT_MAX;
> +	}
> +
>   	return cmd - queue->cmds;
>   }
>   
> @@ -866,7 +871,10 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
>   	struct nvme_tcp_data_pdu *data = &queue->pdu.data;
>   	struct nvmet_tcp_cmd *cmd;
>   
> -	cmd = &queue->cmds[data->ttag];
> +	if (likely(queue->nr_cmds))
> +		cmd = &queue->cmds[data->ttag];
> +	else
> +		cmd = &queue->connect;
>   
>   	if (le32_to_cpu(data->data_offset) != cmd->rbytes_done) {
>   		pr_err("ttag %u unexpected data offset %u (expected %u)\n",
> 

Ziye, usually we send versioning of the patches with prefix PATCH v1/2/3,

and also add what was changed since prior versions.

This patch looks good,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
