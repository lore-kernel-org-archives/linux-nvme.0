Return-Path: <SRS0=U6YU=AK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC020C433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 07:44:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 787F923159
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 07:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OYEqldjf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 787F923159
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BNTygq7N8ZnVMo/YYNDLnCkyj8QeKPyJH4qtw6FFeh0=; b=OYEqldjfsIPCw63jQ3uBPfDqI
	TeM8mrOulI+HNGsBxXAywres5pQ2F4ek7rx91T6OMZOUEZ8jAIGjVscYcxu3GM7onmRWNztTSV5N4
	n/J5QAeHj2VWF3nHmUudjNneIK9AUAk5n7nE5CEQ7VLafz/X64sROLfoX1a0v0Q+oAqvtjDy6nzog
	zvql+MscHp0TFDIEutHRzI30QHQJw4ykqUyjxy3OK1BMCjE0NnF3iEqPFCnIvbB8UEPY6xI3TyeyV
	9sAkk9F2CC7Wz+Wtrdv1UizqcKVZmGF0yAPI4xhASXj5jHEe3t5oFeWEMRqOGTNlvvXL+7h1xTqxZ
	ImUJ4fz9A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jpoSz-0004nr-Ob; Mon, 29 Jun 2020 07:44:37 +0000
Received: from mail-pj1-f68.google.com ([209.85.216.68])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jpoSv-0004nO-EJ
 for linux-nvme@lists.infradead.org; Mon, 29 Jun 2020 07:44:35 +0000
Received: by mail-pj1-f68.google.com with SMTP id o22so2609185pjw.2
 for <linux-nvme@lists.infradead.org>; Mon, 29 Jun 2020 00:44:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FfrOTg1u1wG/8oN0/mdwKVzxUGwzt1YawLFcbM4Fdc0=;
 b=RbkO9eQD/cGpUtfuTWKIMoxcvjil+vtlWtBotAftvb5+zY/ksC6nKJcgsoYTg3J3gx
 BNWzkcF3W9HTBqY98sh3lKOdIe8I+u2o0lUCkOOWIHFmvw9uj2fpjxPL+t0HtC+FHMET
 siWbyKFukk5iPCnOcDR/mASrqhqMbqHWwXawaGsFXy+die5SUNuJkt8aI1h1tPtipMVA
 G76VgefQ3UpYV5FBLwRpccKH5I0S7/hhzh0CGYdru/AYiyrh+PcbJpVaFsesT8qN/Ian
 8LU9eeD2/9FkRL475zephK64Nhlz/ktHnhEf6iXwKaCWH8gMNq8xsyxrc1rnvPiWOLEZ
 41dg==
X-Gm-Message-State: AOAM531NfX3ysTeIer4vsTgesgQSbTST++kobLiMVwWGEcDg3SvzpIRR
 dhtjTk92JIXHJJz36f/5v11sOAZI
X-Google-Smtp-Source: ABdhPJxhrSxyXy0C78eKaV2Q6n60cSdJApDb2ILGYgrsePPUS4GCuQjIFI4L2N2p8fr3ctUA7i+UQw==
X-Received: by 2002:a17:90b:1087:: with SMTP id
 gj7mr16658590pjb.124.1593416671435; 
 Mon, 29 Jun 2020 00:44:31 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:944d:12b0:5a40:4890?
 ([2601:647:4802:9070:944d:12b0:5a40:4890])
 by smtp.gmail.com with ESMTPSA id e5sm17873601pjv.18.2020.06.29.00.44.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2020 00:44:30 -0700 (PDT)
Subject: Re: [PATCH RFC for-5.8-rc] nvme-core: fix deadlock in disconnect
 during scan_work and/or ana_work
To: Christoph Hellwig <hch@lst.de>
References: <20200626174733.116093-1-sagi@grimberg.me>
 <20200629064935.GC30821@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e98efd74-b47d-041a-bb08-9960ef31afbe@grimberg.me>
Date: Mon, 29 Jun 2020 00:44:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200629064935.GC30821@lst.de>
Content-Language: en-US
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
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> +	/*
>> +	 * Controller deletion started, we may issue I/O, block and prevent
>> +	 * the controller deletion process from completing
>> +	 */
>> +	if (ctrl->state == NVME_CTRL_DELETE_START)
>> +		return;
>> +
>>   	/* No tagset on a live ctrl means IO queues could not created */
>>   	if (ctrl->state != NVME_CTRL_LIVE || !ctrl->tagset)
> 
> Can we merge the checks into a single one?

Its actually redundant and covered by state != LIVE, will remove.

>> @@ -3913,6 +3932,9 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>>   	if (ctrl->state == NVME_CTRL_DEAD)
>>   		nvme_kill_queues(ctrl);
>>   
>> +	/* prevent mpath I/O before removing namespaces */
>> +	nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING);
> 
> So with the DEAD state above isn't this going to cause problems,
> shouldn't this be:
> 
> 	if (ctrl->state == NVME_CTRL_DEAD)
> 		nvme_kill_queues(ctrl);
> 	else
> 		nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING);

The DEAD state is only designed to get to this point and make sure
nvme_kill_queues is called. Shouldn't be any issue changing the state
here.

> But even with that I'm not sure it does the right thing for the direct
> call from the PCIe code.

 From the pci removal flow it seems OK, the only problem I now see
is when reset_work is only able to setup admin queue, then it calls
nvme_remove_namespaces... While the controller is in strange state,
we should probably not move it to DELETING state...

> Also I wonder about the state naming.  Shouldn't NVME_CTRL_DELETE_START
> stay as NVME_CTRL_DELETING and the new state could be
> NVME_CTRL_NS_REMOVAL? or NVME_CTRL_DELETED?  But with any name we'll
> need to document the difference between the two removal states.

Let me think some more about the naming...

>> +	/*
>> +	 * We don't treat NVME_CTRL_DELETE_START as a disabled path
>> +	 * as we I/O should still be able to complete assuming that
>> +	 * the controller is connected, otherwize it'll fail
>> +	 * immediately and return to the requeue list.
>> +	 */
> 
> This needs to run through a spell and grammar checker :)

Rilly? I kant find aniting rong with it...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
