Return-Path: <SRS0=YADc=KM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC61C433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 20:23:50 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 206B560FEB
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 20:23:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 206B560FEB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wiu9AONr2qigL//VG54Hmi5jApBQf99ghqiVcKXCjQ4=; b=aHlfN3leg4J43KfYm+AV7lSHq
	VzCJE5Ttm9IqhEuwPzw2HtVfKZ2Q7T9qT6emhnvN85L9Q66MRkWQG90gdGuxmrX1jpz34WVdeVGIw
	rVuFlYZ3G6Oh1DF8AXmRxvX5NtPfp9kOmR+aLwVtycCpZjy3i0gYs1GvIQFxzHfliS6j/k7+E58WU
	MvqlUhp4uftBS670rsuw1lgZlkbGrZmt5JXyhsaGxC5Ia1rku/QEGz7P18B9jiqclqeielUWgiX0K
	J5aEDmgr4DPLvLcWbKRtbsw/Ev8BC6wm1KrUKFzF+6m8jalbH9z0eMkuREDeNHZMJdeZ3xQ77F9MC
	51FmACFVw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lijlm-00G3HN-OS; Mon, 17 May 2021 20:23:19 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lijli-00G3Ge-OB
 for linux-nvme@desiato.infradead.org; Mon, 17 May 2021 20:23:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=vVjEswyX/E23IL/iQ8ItakunbE8Q0S8qQmpWEh0QACw=; b=jR/NNies5RBAnBOTFji6Y+67TW
 9t1FPvLwb/vvvQoefqHvwym11nSfi9oXbuveRfog4oNnxPVoY+WSOgQAD3Or+jOMvQ3OWhI4Ytld3
 l+Ty/aIXbYg8TMf4c+02ecFtWUmWuP58ikOIhQ0LUmHQWflV7EQUbWQjYrQykC0CezaBDcaoFOun4
 7OyqXqPtHSNcJmgMZ7Q0frRdguFSRPEh9b8B3A83JkmGMpKU81iF/uPA9CpttK+bEru2mswYn5oMr
 k+nfRmqLRm+/nmtVKZST9Lf44uPLaQxVeYNdKtTFFR5huHt7Bxxyj5C2+HFrxr+gkqVwWFdUYkQOz
 xMGDjz/w==;
Received: from mail-pj1-f53.google.com ([209.85.216.53])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lijlf-00E7xQ-Qf
 for linux-nvme@lists.infradead.org; Mon, 17 May 2021 20:23:13 +0000
Received: by mail-pj1-f53.google.com with SMTP id
 g6-20020a17090adac6b029015d1a9a6f1aso500271pjx.1
 for <linux-nvme@lists.infradead.org>; Mon, 17 May 2021 13:23:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vVjEswyX/E23IL/iQ8ItakunbE8Q0S8qQmpWEh0QACw=;
 b=qAB6/aSfhgZU0Rj15Lj2DA/FwxzI+oNsKXKbOmjV/0IUVYbed1U2nvU+Q1IPo3r8e0
 oDQpk3LHtRD+grvj6oeokS4XDsErrLFjnICC487wBvo6WRO3fAhF681ZPggCFDeP6mfG
 uR4Y4Czn/yTSUFHpTsCA4oX45B48XuSf9KZJgzrSbTLpjo60mCuB/1oEtBdPILnq3ikp
 i/r3uw8x6I+OeYbDb5Ni0g4NakZ7P4Cmy+QpOP3/J2h/lp0TwwYqYdm58sGT7W5aOFYJ
 4KmtZOwtSP0URJBlS4qj3Q0QvGpC91dfYDBnaGmxjnywr461Au+gbrqw80fcf6kKYyyG
 2cLg==
X-Gm-Message-State: AOAM533pWZUzr7v8jzaaNvIT0mJZ2FweukSlJePbR4JW/fOzIYyuTP2d
 h+OkpdN4kFqEFZn+rfJODeM=
X-Google-Smtp-Source: ABdhPJxkHrM/O8v0Q4Q2pOPKrW0WsQxQUCoYLcXhmECHYsBF2m5nOrFA6A34Q5EtIxCm9H1H0sk4xA==
X-Received: by 2002:a17:902:4:b029:ee:8f40:ecbf with SMTP id
 4-20020a1709020004b02900ee8f40ecbfmr285695pla.28.1621282990552; 
 Mon, 17 May 2021 13:23:10 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:e600:1f8f:de79:17f9?
 ([2601:647:4802:9070:e600:1f8f:de79:17f9])
 by smtp.gmail.com with ESMTPSA id r10sm7480050pjm.20.2021.05.17.13.23.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 May 2021 13:23:09 -0700 (PDT)
Subject: Re: [PATCH 3/3] nvme: code command_id with a genctr for
 use-after-free validation
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Daniel Wagner <dwagner@suse.de>
References: <20210517175955.602725-1-sagi@grimberg.me>
 <20210517175955.602725-4-sagi@grimberg.me>
 <20210517190419.GE2709391@dhcp-10-100-145-180.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <932db2b1-6ca8-7433-6d77-dff5d969dfd8@grimberg.me>
Date: Mon, 17 May 2021 13:23:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210517190419.GE2709391@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_132311_898724_9E0AE789 
X-CRM114-Status: GOOD (  16.11  )
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


>> +static inline struct request *nvme_find_rq(struct blk_mq_tags *tags,
>> +		u16 command_id)
>> +{
>> +	u8 genctr = nvme_genctr_from_cid(command_id);
>> +	u16 tag = nvme_tag_from_cid(command_id);
>> +	struct request *rq;
>> +
>> +	rq = blk_mq_tag_to_rq(tags, tag);
>> +	if (unlikely(!rq)) {
>> +		pr_err("could not locate request for tag %#x\n",
>> +			tag);
>> +		return NULL;
>> +	}
>> +	if (unlikely(nvme_genctr_mask(nvme_req(rq)->genctr) != genctr)) {
>> +		dev_err(nvme_req(rq)->ctrl->device,
>> +			"request %#x genctr mismatch (got %#x expected %#x)\n",
>> +			tag, genctr, nvme_req(rq)->genctr);
>> +		return NULL;
>> +	}
> 
> Should we also check for blk_mq_request_started(rq) here? It doesn't look
> like the genctr is sufficient to detect a double completion of the same
> command_id if the driver hasn't had a chance to advance the genctr for a
> new request.

We could, maybe incrementing the counter again on the completion would
be better?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
