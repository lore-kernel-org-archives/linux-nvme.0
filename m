Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1049606D81E
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 12:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=LDkNvXU9;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=u9MBA7QE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Z3l8voVSRQ1W+oAj6jnsq+7tQcEM1c8H4FbUsCQNMds=; b=LDkNvXU9hUBxv0
	Pn3xKabIgA9KJy2aqa+TG7OgRj/b0ss8/fc07tTVSLR2mMSBhx8cCKxS6ZaKtfcuc4xVCwNv993KH
	viyN9FvNUgM6fcGeAjOA57vtfQ8fdQwGdHtslmWLqB9TJh9Wh6z1EQhqreZKoFflzXCIYVl2nvRjC
	Nn5dDZMHRwf8O6UVSuCLSytWdfLhLvnX86IozbG+GJiHovBjeFXIzqC3j9NKHdcLopdqrF7KUZfP+
	3XmDUqyqc16/5B9KfZfFDGhafYI9Q+WzxOlWdyyRtpjMY8EHjGPyNGp082UFNxIWAFK9ZNdd0kiVX
	nOovt76FgezhjnlQ+7tQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQOaf-00000000hvO-0CUI;
	Mon, 09 Nov 2026 12:35:13 +0000
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQOac-00000000huy-0R89
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 12:35:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794227705; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Z3l8voVSRQ1W+oAj6jnsq+7tQcEM1c8H4FbUsCQNMds=;
	b=u9MBA7QEk4blLEfsfs+Y3FY/oQ9lLnqOaKD8k1a6/SIZbZVnPPpHnJWGjkPWnoWgFZ+tzqbpmnp0uF0HK22P6LezYC7suMPf+WgNGSQEAO4WxFln2ugMOl/FPcgGh6OHOEs4qLv4zSOJc54cfs342I1IlSQeWEqbrpAD97vN2uA=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0XEPkcQv_1794227704;
Received: from 30.178.85.177(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XEPkcQv_1794227704 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 09 Nov 2026 20:35:05 +0800
Message-ID: <1b5dc444-89b7-47cd-8af6-736145bc302f@linux.alibaba.com>
Date: Mon, 9 Nov 2026 20:35:03 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme: define the SMART / Health Status async event
 bit
To: sashiko-reviews@lists.linux.dev
Cc: linux-nvme@lists.infradead.org
References: <20261109120207.1352165-1-kanie@linux.alibaba.com>
 <20261109120207.1352165-2-kanie@linux.alibaba.com>
 <sashiko-outbox-204916@kernel.org>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <sashiko-outbox-204916@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_043510_858932_48EC5E4F 
X-CRM114-Status: GOOD (  13.80  )
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-19.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



在 2026/11/9 20:09, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] nvme: NVME_AEN_BIT_SMART and NVME_AEN_CFG_SMART use wrong
>   OAES/CFG bit
> --
>
> commit be7079eb32755ede896d21f96ed7d1785a179279
> Author: Guixin Liu <kanie@linux.alibaba.com>
>
> nvme: define the SMART / Health Status async event bit
>
> This commit adds NVME_AEN_BIT_SMART and NVME_AEN_CFG_SMART definitions to
> include/linux/nvme.h.
>
>> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
>> index 6248711784b37..2b4f8e269d12d 100644
>> --- a/include/linux/nvme.h
>> +++ b/include/linux/nvme.h
>> @@ -867,6 +867,7 @@ enum {
>>  };
>>  
>>  enum {
>> +	NVME_AEN_BIT_SMART		= 1,
>>  	NVME_AEN_BIT_NS_ATTR		= 8,
>>  	NVME_AEN_BIT_FW_ACT		= 9,
>>  	NVME_AEN_BIT_ANA_CHANGE		= 11,
>> @@ -874,6 +875,7 @@ enum {
>>  };
>>  
>>  enum {
>> +	NVME_AEN_CFG_SMART		= 1 << NVME_AEN_BIT_SMART,
>>  	NVME_AEN_CFG_NS_ATTR		= 1 << NVME_AEN_BIT_NS_ATTR,
>>  	NVME_AEN_CFG_FW_ACT		= 1 << NVME_AEN_BIT_FW_ACT,
>>  	NVME_AEN_CFG_ANA_CHANGE		= 1 << NVME_AEN_BIT_ANA_CHANGE,
> [Severity: Medium]
> Do NVME_AEN_BIT_SMART and NVME_AEN_CFG_SMART match the NVMe specification
> for Identify Controller OAES and NVME_FEAT_ASYNC_EVENT?
>
> The value 1 is the Asynchronous Event Type (NVME_AER_SMART = 1) reported
> in CQE DW0 bits 2:0, not an OAES or Asynchronous Event Configuration bit.
> In the NVMe Base Specification, SMART / Health Critical Warning events are
> mandatory, so bits 7:0 of OAES are reserved and zero on compliant
> controllers. Checking ctrl->oaes & NVME_AEN_CFG_SMART will therefore find
> the bit cleared and never subscribe to the event.
>
> In the NVME_FEAT_ASYNC_EVENT feature (CDW11), bits 7:0 are individual
> Critical Warning bitmasks corresponding to byte 0 of struct nvme_smart_log,
> already defined right above in include/linux/nvme.h as
> NVME_SMART_CRIT_SPARE through NVME_SMART_CRIT_VOLATILE_MEMORY (and used by
> NVMET_AEN_CFG_ALL in drivers/nvme/target/nvmet.h). Passing 1 << 1 to Set
> Features only enables NVME_SMART_CRIT_TEMPERATURE and leaves spare,
> reliability, media, and volatile memory warnings disabled.
Sashiko is right, this is a big mistake, Will fix in v2.

Please ignore this version.
>


