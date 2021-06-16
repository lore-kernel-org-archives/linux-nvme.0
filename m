Return-Path: <SRS0=zgHd=LK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6D5C48BE5
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Jun 2021 21:05:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C333560698
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Jun 2021 21:05:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C333560698
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jVXlFAqfTJgtWqDgxRFye1+KIsZXqovoJMcoqSazTdg=; b=wrouVm0mRaMi6Puu8/2KVTGOj+
	ik3XkJXZ8X2Ex14uUDgb+6QJu9HMusWiEU+OQgvmu6e2r9aX/yav5fkRAUEcAELAo5s51si+8gPK7
	tuDMwIksqaTEIECIQyw/YMzwzNBHeBmSwPVH074Sr4f7gFYVHNtXW/uxbUFk4GUWFsR9ZsKQ4Ganv
	YTBfCUETc60H9xrKyOZQkHxbQVbEnUsiDBVu26gz4HJxG0WlO5G62ycWEnqHIu+J7E2uIYk1PMq5v
	SkYH4VYZ0Goh7xLVlbueDUfFgJMyaN4F1xa8vVXHiQ9tvxGJvEe+Hrp0JxyMcz7s/aRVPVsI6MaCD
	kvnSlimA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltciy-007idc-AB; Wed, 16 Jun 2021 21:05:24 +0000
Received: from mail-pg1-f172.google.com ([209.85.215.172])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ltciv-007id5-2P
 for linux-nvme@lists.infradead.org; Wed, 16 Jun 2021 21:05:22 +0000
Received: by mail-pg1-f172.google.com with SMTP id t9so3061874pgn.4
 for <linux-nvme@lists.infradead.org>; Wed, 16 Jun 2021 14:05:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=q/K7+Xgz9iom6xBIe1OgImNoJhs3+MwV4ijFinTn78E=;
 b=CuJIuIcGl23XnZGnppi5Vj+Wn4oTpF67HorliRzbuFWoZ+gG0rWOVHDe4g+ymrqRT2
 iiUi4o3UYnrxAiev/WShsOyhgJVBEWb4/ntizSiIFXjgmn6HwTUm0jq1X8kC/W+G3tDD
 u+DkQQexQbziMWN7FPEbHiOIvNqamFWsjLNyvEMe91deRV7VcdeLXvWl4DxhXNsDeBeD
 z4B/HmhYIv30dgRMANESJHxYS01fCIGu/VfCxIvvQlEl11c2una6lB8vWP6ybR04qOEe
 TvwpyfMAOmDmHLKP8x1ub0i74Axbo1/Mj0afDW4b8WIuUJMLLVAcJDoFpe5JkcXWownb
 +lbw==
X-Gm-Message-State: AOAM530tWdDqxGVJ569UfWmVYqN3oB3VZC9/ftrdLesEXpSNHsP9x9eJ
 p49L295/658t6BhUfTevIzOjMfVJ+A4=
X-Google-Smtp-Source: ABdhPJygGxqq9a3wmU2rbBlWGpMXqMvSo81TlINjAw/1mDXYIeMXzJzxg9Z5ky7kab1BWu/Q9GRqcQ==
X-Received: by 2002:a62:7848:0:b029:2f7:4ecc:f14 with SMTP id
 t69-20020a6278480000b02902f74ecc0f14mr1758215pfc.77.1623877519242; 
 Wed, 16 Jun 2021 14:05:19 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:1036:8496:ef40:673a?
 ([2601:647:4802:9070:1036:8496:ef40:673a])
 by smtp.gmail.com with ESMTPSA id h4sm3039880pjv.55.2021.06.16.14.05.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jun 2021 14:05:18 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] nvme: protect against possible request reference
 after completion
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Daniel Wagner <dwagner@suse.de>
References: <20210519174340.1144806-1-sagi@grimberg.me>
 <777a99bc-b7e3-ce39-cd98-ab1196aebb2e@grimberg.me>
 <20210616170411.GA921268@dhcp-10-100-145-180.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5c0766d9-9507-b0c7-4917-4b936fd7a197@grimberg.me>
Date: Wed, 16 Jun 2021 14:05:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210616170411.GA921268@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210616_140521_181698_52316130 
X-CRM114-Status: GOOD (  16.43  )
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


>>> Nothing in nvme protects against referencing a request after it was completed.
>>> For example, in case a buggy controller sends a completion twice for the same
>>> request, the host can access and modify a request that was already completed.
>>>
>>> At best, this will cause a panic, but on the worst case, this can cause a silent
>>> data corruption if the request was already reused and executed by the time
>>> we reference it.
>>>
>>> The nvme command_id is an opaque that we simply placed the request tag thus far.
>>> To protect against a access after completion, we introduce a generation counter
>>> to the upper 4-bits of the command_id that will increment every invocation and
>>> be validated upon the reception of a completion. This will limit the maximum
>>> queue depth to be effectively 4095, but we hardly ever use such long queues
>>> (in fabrics the maximum is already 1024).
>>
>> Keith,
>>
>> Did you get a chance to look at the performance impact of this patch set? I
>> think we are all in agreement that this is a useful safeguard if
>> there is no major performance impact.
> 
> Yes, I was able to set up my more powerful machine for perf tests
> earlier this week. I ran fio hipri tests against this patch yesterday,
> and did not observe a measurable difference with either io_uring or
> pvsync2 engines, so no objection from me here.
> 
> Acked-by: Keith Busch <kbusch@kernel.org>

Cool, Christoph, where do you stand on this? Can we move forward with
this?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
