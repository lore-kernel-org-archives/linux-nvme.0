Return-Path: <SRS0=9ikG=CL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7675C433E7
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2020 15:41:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A42C320639
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2020 15:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MD/tLBtd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="SyDESvml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A42C320639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CeiXo77HbQGcpZu+pV/7dUGmpIP60ElYa20keNS0o8Y=; b=MD/tLBtdsEcvxKTDAz8WV/Oen
	wfnLleqOuMdXyAYksZ/eCkBPySjpFjffOOcFvpPn/czXHdg3miLrpAXBDJRiBMw69hF/eQvT3bK0Z
	dr1mW8jKSDgp0ID1OaxqJ+r6vOFBR8+OEX5Hk5nGkQ3/CnIDRUT5at2AscWbm1dRIyZ+0b1yBGGHt
	pMZY75s57c6fxQAXNLwsaM5FScEh3EUEyeGgjYDc3+312DgV1n19atfmB9M66sbm2bFjllQwnmT/p
	iTeTfVB8YOWeLx5Z6rRg7ak3/R+TyGGlNCMJ0afFy1gx1kk7daIWF7G1NyIRvecYmRgNOjMA4G8Zq
	aneLe/u8g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDUso-0006e7-A6; Wed, 02 Sep 2020 15:41:10 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDUsk-0006c5-F4
 for linux-nvme@lists.infradead.org; Wed, 02 Sep 2020 15:41:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QwpIYcjEk238iT4uS9v6I45JXvL5b/5g62hiSn95l00=; b=SyDESvmlSiT4qXK32PaqqhBWAS
 Wql0b1anTRQwd+7ZV5Zpz3Kb4odz48QTGn+Scxk27JsJGr1Wy7wW0Jgvu+hE/2tqiIdZN8H+K/K8y
 4VqleqHMyGh/VIh5i1V+YOhG2HT8sdAsE8KiqLrug7pyPkZ8BY30oVzooDQdFy/msWDOQqp7arVZK
 os7GHGQy16FITR9myt8TxkqT6tf9/Rx6XUXGW932NRu21hj5t1e9aKqsKowb4mD9MQX/kzz6qkVLJ
 0gnoG/RV0Pg8Z/QNC42v9hJWjjerJmMgSOavZagCnnNnufEoitgC7kqCFuNKLBiZuZkzFMBti3G+P
 nEmU3uEg==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1kDUsh-0003IA-9O; Wed, 02 Sep 2020 09:41:04 -0600
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20200831222707.35611-1-chaitanya.kulkarni@wdc.com>
 <20200831222707.35611-13-chaitanya.kulkarni@wdc.com>
 <5f8c3740-9056-2eb2-90b8-1e7078492b4b@deltatee.com>
 <BYAPR04MB49657E669921B89DE66357D7862F0@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <d59009e9-bbf3-b6ad-75c4-f895dfd0aa64@deltatee.com>
Date: Wed, 2 Sep 2020 09:41:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB49657E669921B89DE66357D7862F0@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: kbusch@kernel.org, sagi@grimberg.me, hch@lst.de,
 linux-nvme@lists.infradead.org, Chaitanya.Kulkarni@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH V2 12/12] nvmet: use inline bio for passthru fast path
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200902_114106_515135_BACFBABE 
X-CRM114-Status: GOOD (  12.74  )
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
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020-09-01 6:39 p.m., Chaitanya Kulkarni wrote:
> On 9/1/20 10:29, Logan Gunthorpe wrote:
>>> +	if (req->transfer_len <= NVMET_MAX_INLINE_DATA_LEN) {
>>> +		bio = &req->p.inline_bio;
>>> +		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
>>> +	} else {
>>> +		bio = bio_alloc(GFP_KERNEL, min(sg_cnt, BIO_MAX_PAGES));
>>> +	}
>>> +
>>> +	bio->bi_end_io = nvmet_passthru_bio_done;
>>>   	bio->bi_opf = req_op(rq) | op_flags;
>>> +	bio->bi_private = req;
>> I still think this would be cleaner to just do:
>>
>> if (req->transfer_len <= NVMET_MAX_INLINE_DATA_LEN) {
>> 	bio = &req->p.inline_bio;
>> 	bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
>> } else {
>> 	bio = bio_alloc(GFP_KERNEL, min(sg_cnt, BIO_MAX_PAGES));
>>          bio->bi_end_io = bio_put
> This is intentionally kept consistent with what we have for bdev-ns.

So then cleanup bdev-ns... Doing something in a less clean way because
somebody else did it is not good reasoning.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
