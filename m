Return-Path: <SRS0=MxcY=4O=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8678CC4BA2D
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2020 23:19:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 595F9222C2
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2020 23:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="reEHCDgD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 595F9222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BwWbjPAGOZO33DtRNI/u9mTICMQRjp2EobSkEpurLBQ=; b=reEHCDgDvIyOd9YKldmaJ8bpQ
	TB32rJyOHQz2OZuFd1GxLauatu/dyLewN+Emc3cFNTqEnlEtj71BuyGt88vg2UKf66gkO/v/w+iEe
	ohJb0ykplY5qf4zzn6eeAxeboLPyn8erFFeQx0AA/DupqB6Ou0epZ5DJrEzrCrK8E+tYKbCHUoCp+
	wtBMb654vXtuv8XbHJROM4CaNmTRd8VsfehwWV3mbi8DUaymy9wDYtO1fuJv6LBHw1LyNnfR+wnPQ
	vk3nOizqCaiVSiFAYN1OQihiktx2gOGOpnYX/TAobOH8GzKgtc+SLVzn7uQMaFZNXLSLSqnKn31NO
	xp8X9enQA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j75xz-0006qO-6x; Wed, 26 Feb 2020 23:19:47 +0000
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j75xw-0006pq-M7
 for linux-nvme@lists.infradead.org; Wed, 26 Feb 2020 23:19:45 +0000
Received: by mail-oi1-f194.google.com with SMTP id 18so1363928oij.6
 for <linux-nvme@lists.infradead.org>; Wed, 26 Feb 2020 15:19:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=I9MypL6BAsKfZ4rRFkaqekxBpNaZPIdxOAKCi7jlEQ8=;
 b=f5/Q+APCn70+4KA7MmGYYKreJiPJ7tuJpLCcG1n+e7NE/bqDoL4qWKodwc03CMHJoz
 tNt/nYIp2Obo4pmV0Fr9WJuaguj3jAfHdX0i0Zamz6MXmQ/PIWiEilnEHzto6RkgGGMr
 UNjY8GbSQJhniu/5OiKrmXvGDA1btMe9H0GCKJuaLB99yak639S/2C6yTbERKEPleaD8
 51BPyEanlxSrerZZ/yiTbw3LLNIJgUVeYr94prNhcINFjqBfLFTqKnFxBeMgaJYP2M11
 8se012t92BlXy3qGsSaFzjjQ413W4WMjMZLOVSkvs2u2iWluncL69BMu0NxrqwfpO4bR
 3UzA==
X-Gm-Message-State: APjAAAVlSevmaK8kPzZGt0VbCKNds7qydbmWkDvv00/iEm5EKJlamkW2
 H0zRtplef8EJVTgZLpxNMzM=
X-Google-Smtp-Source: APXvYqxuGp5dlmVYcBGCJ8WQnQO59GX2wbuy1BC9+t9iduG0vuM2R2IO77+f/Kvr9LuSuz6480GUqg==
X-Received: by 2002:aca:2315:: with SMTP id e21mr1126185oie.147.1582759184090; 
 Wed, 26 Feb 2020 15:19:44 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id e206sm1324231oia.24.2020.02.26.15.19.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Feb 2020 15:19:43 -0800 (PST)
Subject: Re: [PATCH for-rc] nvme-rdma/nvmet-rdma: Allocate sufficient RW ctxs
 to match hosts pgs len
To: Jason Gunthorpe <jgg@ziepe.ca>,
 Krishnamraju Eraparaju <krishna2@chelsio.com>
References: <20200226141318.28519-1-krishna2@chelsio.com>
 <20200226170720.GY31668@ziepe.ca>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5d883018-0c27-fe1d-3dfb-2ec9de76325b@grimberg.me>
Date: Wed, 26 Feb 2020 15:19:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200226170720.GY31668@ziepe.ca>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200226_151944_727312_35CAA742 
X-CRM114-Status: GOOD (  12.62  )
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
Cc: linux-rdma@vger.kernel.org, bharat@chelsio.com, nirranjan@chelsio.com,
 hch@lst.de, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> diff --git a/include/linux/nvme-rdma.h b/include/linux/nvme-rdma.h
>> index 3ec8e50efa16..2d6f2cf1e319 100644
>> +++ b/include/linux/nvme-rdma.h
>> @@ -52,13 +52,15 @@ static inline const char *nvme_rdma_cm_msg(enum nvme_rdma_cm_status status)
>>    * @qid:           queue Identifier for the Admin or I/O Queue
>>    * @hrqsize:       host receive queue size to be created
>>    * @hsqsize:       host send queue size to be created
>> + * @hmax_fr_pages: host maximum pages per fast reg
>>    */
>>   struct nvme_rdma_cm_req {
>>   	__le16		recfmt;
>>   	__le16		qid;
>>   	__le16		hrqsize;
>>   	__le16		hsqsize;
>> -	u8		rsvd[24];
>> +	__le32		hmax_fr_pages;
>> +	u8		rsvd[20];
>>   };
> 
> This is an on the wire change - do you need to get approval from some
> standards body?

Yes, this needs to go though the NVMe TWG for sure.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
