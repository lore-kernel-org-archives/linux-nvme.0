Return-Path: <SRS0=Xx51=D2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9F2C433E7
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2020 15:40:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F047222269
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2020 15:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="APMRTcQj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="fBahxAif"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F047222269
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qU53JLjkKXHOSHGFASHdRZI6avSNs5bwSoAztegbNvU=; b=APMRTcQj1Bbmctaq2ZZx7Uwmd
	fMfjrLLSjBSItuy44t9Q6771voVAsfDaCTCFN3PydKYve6tNpaXzslSxufWL9pH+sEcBE6zeuFvYl
	t5SGGdCbYWzm45lKPv4f+FkqRfecKY5VakUpy7v7kd8psOMrJTVJboHKXHjhMd4b0ua4rxEeV8w78
	hCMm+gl0hycWn5lsq6FZR5uybMwkCVpdKACCn4lnDiig9QyxCrQLXsMHkLweTK8ZVoNAmwS51BSu1
	DML59JBrhnxio7AXapVkl0wVOnl871ym2k3sbJJgRFqDkrOK49Ebxj0Ug6xkSlbTHY/88eJMlyTkP
	205N+Xq1Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kUXGp-00050U-3R; Mon, 19 Oct 2020 15:40:23 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kUXGl-0004zw-Vb
 for linux-nvme@lists.infradead.org; Mon, 19 Oct 2020 15:40:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CUiwQsyrL3hUQMd6gU6TFi741GjfZwCEna5fmnEK52c=; b=fBahxAifazYU99AUSER4o3exSI
 yvF9kXjMjgaqT5OX+IYyaYcbUouXTBfLCAwSrgVX8AFV2BGW9rn+nrK+MU6wdgEmhbAuMxoAp2GXk
 lN2Nlrs8hU+hl1Cw/qj4hzLC4xxqMsY3rEqR+G3U15bPEfQqBNS0MTuCjGCqNPgc8C0naE8amzAZ9
 04nGHxJeO5+bF9k+2ZGaf46W/XCFrMaIMi23uCrhTbBFiODNit2TR8s2TiJwTW+va8dLsokVsSETy
 Iwn6VOmEQSoY0nVMQPYmSYY+WufFoCr86yqlsGD9irOxAWX4GFXwK5BdAnhF7a9f1mxdFJFurFWK3
 ai8qxIwA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1kUXGa-0000D9-00; Mon, 19 Oct 2020 09:40:12 -0600
To: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org
References: <20201016221905.4686-1-logang@deltatee.com>
 <7fbd6b56-cda5-a9b3-7323-99d9704fbec5@nvidia.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <32db0b68-8e22-4503-e480-d7070e08617c@deltatee.com>
Date: Mon, 19 Oct 2020 09:40:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <7fbd6b56-cda5-a9b3-7323-99d9704fbec5@nvidia.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sagi@grimberg.me, chaitanya.kulkarni@wdc.com, hch@lst.de,
 linux-nvme@lists.infradead.org, mgurtovoy@nvidia.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v2 1/2] nvmet-passthru: Limit mdts by BIO_MAX_PAGES
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201019_114020_071526_27A65CCF 
X-CRM114-Status: GOOD (  17.93  )
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
Cc: Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020-10-19 5:20 a.m., Max Gurtovoy wrote:
> 
> On 10/17/2020 1:19 AM, Logan Gunthorpe wrote:
>> nvmet_passthru_map_sg() only supports mapping a single BIO, not a chain
>> so the effective maximum transfer should also be limitted by BIO_MAX_PAGES
>> (presently this works out to 1MB).
>>
>> For PCI passthru devices the max_sectors would typically be more limitting
>> than BIO_MAX_PAGES, but this may not be true for all passthru devices.
>>
>> Fixes: c1fef73f793b ("nvmet: add passthru code to process commands")
>> Suggested-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: Sagi Grimberg <sagi@grimberg.me>
>> Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
>> ---
>>   drivers/nvme/target/passthru.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
>> index dacfa7435d0b..1ab88df3310f 100644
>> --- a/drivers/nvme/target/passthru.c
>> +++ b/drivers/nvme/target/passthru.c
>> @@ -26,7 +26,7 @@ static u16 nvmet_passthru_override_id_ctrl(struct nvmet_req *req)
>>   	struct nvme_ctrl *pctrl = ctrl->subsys->passthru_ctrl;
>>   	u16 status = NVME_SC_SUCCESS;
>>   	struct nvme_id_ctrl *id;
>> -	u32 max_hw_sectors;
>> +	int max_hw_sectors;
>>   	int page_shift;
>>   
>>   	id = kzalloc(sizeof(*id), GFP_KERNEL);
>> @@ -48,6 +48,13 @@ static u16 nvmet_passthru_override_id_ctrl(struct nvmet_req *req)
>>   	max_hw_sectors = min_not_zero(pctrl->max_segments << (PAGE_SHIFT - 9),
>>   				      pctrl->max_hw_sectors);
>>   
>> +	/*
>> +	 * nvmet_passthru_map_sg is limitted to using a single bio so limit
>> +	 * the mdts based on BIO_MAX_PAGES as well
>> +	 */
>> +	max_hw_sectors = min_not_zero(BIO_MAX_PAGES << (PAGE_SHIFT - 9),
>> +				      max_hw_sectors);
> 
> can 9 be replaced with SECTOR_SHIFT ?

Oh, yes, that does sound better. Thanks.

Logan


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
