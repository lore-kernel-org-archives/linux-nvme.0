Return-Path: <SRS0=MUCY=OP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9D1C433F5
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Sep 2021 20:34:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14CEC60F4B
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Sep 2021 20:34:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 14CEC60F4B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i9N6Hh19aoGgU7Gap/TmDxmDJmrGavyFTJZ0W7Qrk4c=; b=bQdcFf9amA0IqgMpI014F2jvg3
	3ewrTNC0wP2Vi1hB3LrvKAOpQAZNcHAgD/iEj8KvHunwj/PaoLjCBCgYbshLt4PVtFEzOYrgx/3C3
	ijGOPN0uU753QkdZwnp4yP2cewztnQm3RhNhGmhFkfDUBWEGjJU8i9uRHlntGlmnFGDxZtgstov7E
	cP/5s9s/zESFQCQ2NnlkKU9tK3oFZCCjrp4w1cmZXkOF0sH9eRGa/cAPbHxK3reNVhUbuSBcvwwot
	eJo1AYM3+HCruE9g0SwYfIjj/0Q6kyUTw4G+BrXYaq6+FjqHynHneAfi9J2frDCZ8gud3xJgBdVF2
	OJVJz39A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUENY-00HD3e-5A; Sat, 25 Sep 2021 20:34:36 +0000
Received: from mail-ed1-f51.google.com ([209.85.208.51])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUENU-00HD2s-Ur
 for linux-nvme@lists.infradead.org; Sat, 25 Sep 2021 20:34:34 +0000
Received: by mail-ed1-f51.google.com with SMTP id b26so2287740edt.0
 for <linux-nvme@lists.infradead.org>; Sat, 25 Sep 2021 13:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7jUS0GLT445lz4KmtO0kmuQ8GSyq5Ff6GXWpF8lD5nc=;
 b=llkndp7GtBYMRX2dkM//9XZN691oJuRweI0cvF3TrWQ12xZVrrwUi354QP+qsMM8wV
 BDJtQ9sI43M40i3MgCfEVk/EkjYs0bNMF/w2cLvCr4mgd4aHfwAj14BQpJhxIQHLi/9k
 /f3ftUiBOoejBnlMUiF64qHKPBB3CKrhaRmFO/XCeu99hhgtynKedro84MVOQ1FHnAkJ
 le7RKRloNCJm+TnYIqB1f/hYy7Ff0rYWvb4n4Ntc+FiwGXQPMpTOakWbJDGO9ZOr1w8y
 XLIjJR3o4wsKxalFALfvHzYY464YnTy1x5n4L1o9xIHVcpqMyoV2qh0Otzfa5voy11eQ
 imrA==
X-Gm-Message-State: AOAM532effHR+aq+bIxakndGYHSO+zBs0lm9cmtr9o8fd1GBt+eMHd+z
 72wBahRBXYFrAl0V/MNW5KM=
X-Google-Smtp-Source: ABdhPJwaOm0+xy1Zr9WbaCpqgIXxryMm7ICNu1xVqv7gflMg/PmYEJycyTo454TfKk+xO8OveX/PCg==
X-Received: by 2002:a50:e0cf:: with SMTP id j15mr13521451edl.23.1632602070768; 
 Sat, 25 Sep 2021 13:34:30 -0700 (PDT)
Received: from [10.100.102.14] (109-186-240-23.bb.netvision.net.il.
 [109.186.240.23])
 by smtp.gmail.com with ESMTPSA id 6sm6681227ejx.82.2021.09.25.13.34.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Sep 2021 13:34:30 -0700 (PDT)
Subject: Re: [PATCH] Urgent bug fix causing Apple SSDs to not work.
To: Keith Busch <kbusch@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Aditya Garg <gargaditya08@live.com>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "james.smart@broadcom.com" <james.smart@broadcom.com>,
 "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "trivial@kernel.org" <trivial@kernel.org>
References: <PNZPR01MB4415600ACD3C8D9944F15058B8A59@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
 <CAHk-=wgML11x9afCvmg9yhVm9wi5mvnjBvmX+i7OfMA0Vd4FWA@mail.gmail.com>
 <20210925195425.GB116968@dhcp-10-100-145-180.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <7e75e292-3073-f1f9-287a-badf92c8e4e8@grimberg.me>
Date: Sat, 25 Sep 2021 23:34:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210925195425.GB116968@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210925_133433_059194_16B9C2EF 
X-CRM114-Status: GOOD (  30.44  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

>>> From: Aditya Garg <gargaditya08@live.com>
>>> Date: Fri, 24 Sep 2021 15:36:45 +0530
>>> Subject: [PATCH] Revert nvme to 5.14.5 to fix incompatibility arised in Apple SSDs.
>>> Fixes: e7006de6c238 (nvme: code command_id with a genctr for use-after-free validation)
>>
>> I think we need to hear more about the problem than just revert a
>> commit like this randomly. That commit has already been picked up for
>> -stable,
>>
>> What are the exact symptoms, and which Apple SSD is this?
>>
>> I do find this:
>>
>>    https://lore.kernel.org/all/cjJiSFV77WM51ciS8EuBcdeBcv9T83PUB-Kw3yi8PuC_LwrrUUnQ3w5RC1PbKvSYE72KryXp3wOJhv4Ov_WWIe2gKWOOo5uwuUjbbFA8HDM=@protonmail.com/
>>
>> which instead of a revert has an actual patch. Can you try that one?
>>
>> Keith Busch replied to that one, saying that the Apple SSD might not
>> be spec compliant, but hey, what else is new? If we start demanding
>> that hardware comply with specs, we'd have to scrap the whole notion
>> of working in the real world. Plus it would be very hypocritical of
>> us, since we ignore all specs when we deem them too limiting (whether
>> they be language specs, POSIX OS specs, or whatever).
> 
> Right, we have a lot of quirks for the apple controllers, what's one
> more? :)
> 
> Could the following patch be tried? I'm basing this off the 'lspci' from
> Orlando, but I'm assuming the previous model has the same limitation,
> too.
> 
> ---
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 7efb31b87f37..f0787233557f 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -979,6 +979,7 @@ EXPORT_SYMBOL_GPL(nvme_cleanup_cmd);
>   blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
>   {
>   	struct nvme_command *cmd = nvme_req(req)->cmd;
> +	struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
>   	blk_status_t ret = BLK_STS_OK;
>   
>   	if (!(req->rq_flags & RQF_DONTPREP)) {
> @@ -1027,7 +1028,8 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
>   		return BLK_STS_IOERR;
>   	}
>   
> -	nvme_req(req)->genctr++;
> +	if (!(ctrl->quirks & NVME_QUIRK_SKIP_CID_GEN))
> +		nvme_req(req)->genctr++;
>   	cmd->common.command_id = nvme_cid(req);
>   	trace_nvme_setup_cmd(req, cmd);
>   	return ret;
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 9871c0c9374c..b49761d30df7 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -86,6 +86,12 @@ enum nvme_quirks {
>   	 */
>   	NVME_QUIRK_NO_DEEPEST_PS		= (1 << 5),
>   
> +	/*
> +	 * The controller requires the command_id value be be limited to the
> +	 * queue depth.
> +	 */
> +	NVME_QUIRK_SKIP_CID_GEN			= (1 << 6),
> +
>   	/*
>   	 * Set MEDIUM priority on SQ creation
>   	 */
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index b82492cd7503..d9f22ed68185 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3369,7 +3369,10 @@ static const struct pci_device_id nvme_id_table[] = {
>   	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2005),
>   		.driver_data = NVME_QUIRK_SINGLE_VECTOR |
>   				NVME_QUIRK_128_BYTES_SQES |
> -				NVME_QUIRK_SHARED_TAGS },
> +				NVME_QUIRK_SHARED_TAGS ,
> +				NVME_QUIRK_SKIP_CID_GEN },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2006),
> +		.driver_data = NVME_QUIRK_SKIP_CID_GEN },
>   
>   	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
>   	{ 0, }
> --
> 

Exactly the patch that I was going to propose. The only downside
is that we need to access the controller in the hot-path...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
