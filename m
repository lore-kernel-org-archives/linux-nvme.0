Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D5AC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 06:26:40 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A995C6520A
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 06:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A995C6520A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=kzxm+y8QsR9Z04UBtW50duPPu
	xIfWrE8vIJl/S/qvqKo8VBGGR49r3O6+GwqcGGi7vSvTrVHTwKU/5n6w4cWU2194/1wcJmyA3X6Fx
	EohP6sMmH+ZBY60cQg2lY/5NzNnNXXLe/agzOXeAf7+68bQfMH8gUBR1mxJwUXWwqC2N5369R/46E
	+irkIr3feGQoVAFpTS82oFmsvNURiwa81CDIu/bsA2LIdNsL1/VsTRZptNvbzlcCw2oj19jJDhDet
	JYkFqsrm3mC8HXTaWFuPISQQh/eW7nx27YiiyIOIpMmOR7DuUV4tEmMmsDCt0ZfK10XGSbT1jfovi
	TPjja1Xmw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lM39w-00HWTB-Cg; Tue, 16 Mar 2021 06:26:28 +0000
Received: from mail-pg1-f179.google.com ([209.85.215.179])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lM39s-00HWSj-LU
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 06:26:27 +0000
Received: by mail-pg1-f179.google.com with SMTP id n10so21937311pgl.10
 for <linux-nvme@lists.infradead.org>; Mon, 15 Mar 2021 23:26:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=fIU541zYJumPMJIQg29OE/1PdX4Q39Iic4OuZ5fJykTIcgKRwWuUUQG0LKIh+LgHnI
 SIctjSMGYSqPhObd4ks6TQ4Ky4zScoCpJ2cPkY+n5V8MPiNSP7r4SbkSk5uHoKWMW8NK
 qftDCjrz0xoxfAoQFg3Tj/cmP8v5e09pLVBP1NCdvVtVRIDZgYcvNWguRKJoK1FA20vA
 7YtUHI4tZHM4vU3YENNdtXHPzO8YXSFUsj8gV0jEWvodilsjxjInIIh9S9RMWFH5gzcY
 LN8itFmAnX6zGZWFr1ueL3MUUWfaW8ts2bQGupFdP5W2dHyDsf6VnqR4WFB9Nij9iDC7
 eJSQ==
X-Gm-Message-State: AOAM5325dMCV18uUCTMCY/pOJDaSZeXVTr5ywKvNJErurVt/9pTg01Zz
 5iuMque7FOE7eo51mbinE/yc63m3cQQ=
X-Google-Smtp-Source: ABdhPJxs6mGue+pzSLcP0j5Z4E2LsV+HJCNK9GZjqOjfEG9T0hkXkJkR8DP34z4QfGLYw75rW0Cw+w==
X-Received: by 2002:a63:4502:: with SMTP id s2mr2701474pga.94.1615875983124;
 Mon, 15 Mar 2021 23:26:23 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:52e4:89ef:d916:a3a6?
 ([2601:647:4802:9070:52e4:89ef:d916:a3a6])
 by smtp.gmail.com with ESMTPSA id u66sm7994016pfu.186.2021.03.15.23.26.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Mar 2021 23:26:22 -0700 (PDT)
Subject: Re: [PATCH] nvme: fix Write Zeroes limitations
To: Christoph Hellwig <hch@lst.de>, keith.busch@wdc.com
Cc: linux-nvme@lists.infradead.org
References: <20210315093438.66082-1-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8a6c04d7-ec44-c26d-0540-1b8792f7302c@grimberg.me>
Date: Mon, 15 Mar 2021 23:26:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210315093438.66082-1-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_062625_494953_5F507856 
X-CRM114-Status: UNSURE (   8.59  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
