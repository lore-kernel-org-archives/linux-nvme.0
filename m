Return-Path: <SRS0=Nmzz=DV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A44EC433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2020 00:20:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E06B22078A
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2020 00:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IPvCBJLD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="NTrsSBu0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E06B22078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PClUhtbqgbeOCpfiIVt5jhP3l3tB3rPx7art6ku/53E=; b=IPvCBJLDhagc0zC9TiSaguP2A
	OAS10I4nqMMIt8sXnMPWvvafuThPxMv84cx1nWaaEiAkROe63S9dlI/mWfA+8TS3coUMM/GkAauHO
	1HN04rRVCTosrZSiqk5sW88i3dd6K5F67+PD1xyQNLpoe1+zwpil6GqfVXWknAh1DCvAxgFGSA50r
	cHD5oQh0koEXS39wWXQr2Hc84SfMoljAwaff07hjPgfhZxb+cx7fYokD5Sre6AdZrbFtgdNygDD9S
	T0/NwG86l6p2VTfF/kibO7gUtSGQ/ZilHOr4Bfl5ZLituXseZFaqIBj92YU2UT9n5oIhDFBfJ9hOp
	R2TRgcQCg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kSUWc-0003Dm-Ss; Wed, 14 Oct 2020 00:20:14 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kSUWb-0003Cp-88
 for linux-nvme@lists.infradead.org; Wed, 14 Oct 2020 00:20:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qKqm5MgPOej/m3PwgpVDb2vxpMp8DxA9NrNauOcMFtA=; b=NTrsSBu0KbEdLgAshQy8PuBZG8
 Ely/70UI+YKu8P14FrkyQGP8mA2u8WytAdChAp8ooj77ETNjcDBM/HoKgiaF6FJNLCwCxNTTQG1Q0
 rev9LRXqs3t1T+DtpK90NIFLezmg+DbpA+s8onkVpfRKxD7R/U68uMMXbLom1EwWVNpPuO+Sw232H
 SaxOEzmelUvy649828j/HMjbcy7M/m/C9TwmiNTFCp2DAQDf60vy7reHPtmQjJX5sd9LlDfI7+wiC
 LDjLlG5g+CbzNYib7KqDQufAM0i/ZcOvB4w4htLA76PX2fNePewFb1gmksw7wvNxUButzVUqilPsl
 LSPIPESA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1kSUWU-0002xP-Sc; Tue, 13 Oct 2020 18:20:08 -0600
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20201009231816.1524-1-logang@deltatee.com>
 <BYAPR04MB496556A3CBC239BC57EE588B86050@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <e7d76d3e-955b-1827-fd2f-9b7db49646ed@deltatee.com>
Date: Tue, 13 Oct 2020 18:20:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB496556A3CBC239BC57EE588B86050@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sagi@grimberg.me, hch@lst.de, dgilbert@interlog.com,
 linux-nvme@lists.infradead.org, Chaitanya.Kulkarni@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH] nvmet-passthru: Cleanup nvmet_passthru_map_sg()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201013_202013_365015_BCEDBB66 
X-CRM114-Status: GOOD (  13.79  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Douglas Gilbert <dgilbert@interlog.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020-10-13 6:16 p.m., Chaitanya Kulkarni wrote:
> On 10/9/20 16:18, Logan Gunthorpe wrote:
>> Clean up some confusing elements of nvmet_passthru_map_sg() by returning
>> early if the request is greater than the maximum bio size. This allows
>> us to drop the sg_cnt variable.
>>
>> This should not result in any functional change but makes the code
>> clearer and more understandable. The original code allocated a truncated
>> bio then would return EINVAL when bio_add_pc_page() filled that bio. The
>> new code just returns EINVAL early if this would happen.
>>
>> Fixes: c1fef73f793b ("nvmet: add passthru code to process commands")
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> Suggested-by: Douglas Gilbert <dgilbert@interlog.com>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: Sagi Grimberg <sagi@grimberg.me>
>> Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> 
> why the prefix is nvmet-passthru ?

Well that's the prefix I used in the first patch, which follows other
similar conventions like nvmet-tcp, nvmet-fc, nvmet-rdma, nvmet-loop, etc.

Logan


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
