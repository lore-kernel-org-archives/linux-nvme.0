Return-Path: <SRS0=KW74=BW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D55EC433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2020 21:31:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5570F20781
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2020 21:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gRwgttBD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="PYFxoLIa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5570F20781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5m9M+WLjEb2P/XF02XJblPhxLHFG7dr0+qZWbdKL0ng=; b=gRwgttBDUoD7L1rG9nXX3xzpL
	0w1fHXh4Q49txvbB0frm3GnExnYuv4a9ZZIHW3lxhIhtz7V7NjEdZDjIQ74tyQtawR0dG79Qntv8j
	yzQpj+t0xn8DMyhIuq4zp64rRi4OpxEogUpFlPOop3i42WmWllYXgFeHQdprCtDWQGh7sFjEhDpUY
	wO9Y3qoyIUtQnYVTjMJga7mL1KyEykph83AF8zwGzTWt4I0YYTePRTr0h/E/GstYF6Ku4GCPRL/Qu
	rrSFVNVznTSQWv7T+SGevD92PLy8Lwf/4+FFAH/p9hgvjJgep6WyFu9IXV171FtSLi4Bl6FK5+nMT
	uvs80LYGw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5yLc-0003T4-CH; Wed, 12 Aug 2020 21:31:48 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5yLa-0003Sj-8t
 for linux-nvme@lists.infradead.org; Wed, 12 Aug 2020 21:31:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wZUfbWD2oBKIbcbRhn2MlHBlsAt09/GiRlxjIAJiqj0=; b=PYFxoLIaaTeOjTA6L1Grk2PoP/
 oohcnDZvDLUWM3SgcIGGzS4nkSYAtfAnxIS6aFMahUYZF47lYeFrz+VfJ7GuY6p/l2y5lIRLd63xQ
 oVKpTYqHf6uB5PJJnJB8KGqv7PtbkXi3pwCZcIjLMBafrFmICRXavdYfSDTZFcJ/Fmk9dHli/pJgb
 rl+Mya1p0IC6PZ7hVkZX6RjYy5XM8lb9/+U89MjMZPrOcFRUbnoSzSZRcO5G4kwbIKYscZ9lCWA7C
 94R53Wby5ZDUGd5WMlZws5yT/VJ+J7EnRhOD2B7FD4YpLeqoWoiNRJwhBIWZcJlF/odoaxs7NDWif
 gfcmEjvg==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1k5yLW-0004Gg-PO; Wed, 12 Aug 2020 15:31:43 -0600
To: Keith Busch <kbusch@kernel.org>
References: <20200812210119.7155-1-logang@deltatee.com>
 <20200812211959.GA1238450@dhcp-10-100-145-180.wdl.wdc.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <b86772c1-17ed-ec44-1b60-7f2ad80bd73c@deltatee.com>
Date: Wed, 12 Aug 2020 15:31:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200812211959.GA1238450@dhcp-10-100-145-180.wdl.wdc.com>
Content-Language: en-US
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: axboe@kernel.dk, keith.busch@wdc.com, sagi@grimberg.me,
 hch@lst.de, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, kbusch@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [RESEND PATCH] nvme: Use spin_lock_irqsave() when taking the
 ctrl->lock
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200812_173146_357780_091C4456 
X-CRM114-Status: GOOD (  14.80  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020-08-12 3:19 p.m., Keith Busch wrote:
> On Wed, Aug 12, 2020 at 03:01:19PM -0600, Logan Gunthorpe wrote:
>> @@ -2971,15 +2971,16 @@ int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp, u8 csi,
>>  static struct nvme_cel *nvme_find_cel(struct nvme_ctrl *ctrl, u8 csi)
>>  {
>>  	struct nvme_cel *cel, *ret = NULL;
>> +	unsigned long flags;
>>
>> -	spin_lock(&ctrl->lock);
>> +	spin_lock_irqsave(&ctrl->lock, flags);
>>  	list_for_each_entry(cel, &ctrl->cels, entry) {
>>  		if (cel->csi == csi) {
>>  			ret = cel;
>>  			break;
>>  		}
>>  	}
>> -	spin_unlock(&ctrl->lock);
>> +	spin_unlock_irqrestore(&ctrl->lock, flags);
>>
>>  	return ret;
>>  }
>> @@ -2988,6 +2989,7 @@ static int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi,
>>  				struct nvme_effects_log **log)
>>  {
>>  	struct nvme_cel *cel = nvme_find_cel(ctrl, csi);
>> +	unsigned long flags;
>>  	int ret;
>>
>>  	if (cel)
>> @@ -3006,9 +3008,9 @@ static int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi,
>>
>>  	cel->csi = csi;
>>
>> -	spin_lock(&ctrl->lock);
>> +	spin_lock_irqsave(&ctrl->lock, flags);
>>  	list_add_tail(&cel->entry, &ctrl->cels);
>> -	spin_unlock(&ctrl->lock);
>> +	spin_unlock_irqrestore(&ctrl->lock, flags);
>>  out:
>>  	*log = &cel->log;
>>  	return 0;
>>
> 
> Neither of these are ever called from an interrupt disabled context,
> correct? If so, you can just use spin_lock_irq() without saving the
> current irq state.

Yes, I believe that is correct. I'll send a v2 shortly.

Thanks,

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
