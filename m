Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EAA6C636D4
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Feb 2023 09:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3jLPzwB0t0BrPlWEST2Yp4YV+BUkyRWGsJxdGGo1LWM=; b=HoYPX+8P9JkyM/A1yjmdrrB4X7
	7k/HqlD7GAP8Tnlk8KQ8fLbsic8K9Tc0TtSi0SNCzoSf6fryawuOvm8SxdxcIl9V0jSdzm/AqRi31
	OIVp2X8k84s17i2equ0/xHZzVXntYWKmipztidWD7SPZd/Bztw0RbVrcH6ZKG/W/Edi2t8p58xTlM
	aPP4h62Gi+9nOpRRBX76Jd8j0uowmYf0F0LSw/6wz28h18ov6dAR/v63AIT0lmKUMw0zeQ0emk9zl
	/HndziZbc8ysvi5N+MWq8joiOR5NHe/HWqBpevhskJtGsPegQl8uaAGyn1hlyyutOvAMpx9iz/KEJ
	1S0hILsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRVQn-00DyFz-U5; Mon, 13 Feb 2023 09:47:30 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRVQi-00DyF8-0z
	for linux-nvme@lists.infradead.org; Mon, 13 Feb 2023 09:47:27 +0000
Received: by mail-wm1-f46.google.com with SMTP id j29-20020a05600c1c1d00b003dc52fed235so8514221wms.1
        for <linux-nvme@lists.infradead.org>; Mon, 13 Feb 2023 01:47:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3jLPzwB0t0BrPlWEST2Yp4YV+BUkyRWGsJxdGGo1LWM=;
        b=Mnw7+E6OhoMULCFzjmOOItvEE3wbHokz/hTMBl8lWYqV4/FC1ifc614qEjD/JUGJWm
         sNJfLeT30YEKr5UQY0cuFIWY9Kgi9G0GsXMLRE1Xt32QX03rMRLaCU+IUZIWaj6qdUIx
         bHJZkmk0tH8aV7Ct0G7sRk4k9bcClkCKlHiXRPbKzG6EKeVfEmIIqfroFKJdnShEU3hG
         bgGz05lfv01GnjqHQab8JfyOSTM1iYJl1GD+0kjTdv6DkoYt57j2/W29yhN+Teieg9sD
         MJEdwe81EU+EoScwOCKITZu9d9/4o/D/wWd3NfjoK5Q6xJWcc9TnAm1gBFLWV3zgxbZ/
         8kiA==
X-Gm-Message-State: AO0yUKUHEAN/BAYxeAUBm+IgBm3Plq0CBTB0j8AZRdUIFixLm4nsrHBD
	OvqlUV8/acaqb9sNztrVfshT9lizNoM=
X-Google-Smtp-Source: AK7set+dj4+LCwaDQY7LVlH8VmecYGLW1JNIi4tqRcwTg9smbhlBgYwbnNTSNEUy3WMSjvdp/0UgiA==
X-Received: by 2002:a05:600c:511c:b0:3dc:3398:cf65 with SMTP id o28-20020a05600c511c00b003dc3398cf65mr22388709wms.2.1676281641389;
        Mon, 13 Feb 2023 01:47:21 -0800 (PST)
Received: from [192.168.64.80] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id z9-20020a05600c114900b003e1df9bc86csm6785953wmz.3.2023.02.13.01.47.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 01:47:21 -0800 (PST)
Message-ID: <6e0bd345-66c4-be7a-cb74-7bfd62979683@grimberg.me>
Date: Mon, 13 Feb 2023 11:47:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/5] nvme: split __nvme_submit_sync_cmd()
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230209143820.118097-1-hare@suse.de>
 <20230209143820.118097-2-hare@suse.de> <20230213061958.GA14223@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230213061958.GA14223@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230213_014724_092986_4CF96512 
X-CRM114-Status: UNSURE (   8.56  )
X-CRM114-Notice: Please train this message.
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> +struct request *nvme_alloc_request(struct request_queue *q,
>> +				   struct nvme_command *cmd, int qid,
>> +				   blk_mq_req_flags_t flags)
>>   {
>>   	struct request *req;
>> -	int ret;
>>   
>>   	if (qid == NVME_QID_ANY)
>>   		req = blk_mq_alloc_request(q, nvme_req_op(cmd), flags);
>>   	else
>>   		req = blk_mq_alloc_request_hctx(q, nvme_req_op(cmd), flags,
>>   						qid - 1);
>> +	if (!IS_ERR(req))
> 
> As already said last time, please split out a nvme_alloc_request_qid
> function for the few caller that pass a qid.

Agreed.

