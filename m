Return-Path: <SRS0=Ni0e=M5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFD9C4338F
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Aug 2021 19:37:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1444C61165
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Aug 2021 19:37:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1444C61165
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=bUOQs36EaoZSWcx34Kebxgsfpe
	miyVuvwx7lQ9+blvh7ErGUO5RooTF9tdHKrS3BY4K10bEGz0hxMB/pwQf6ojJhY2KAR+Q7/MLZnms
	i6npGFRh10HctThj+pa4gS5ORLMiyHDGe756ASq6taGWYh1XKFS10lyPfSrx+tsV3Qtyv4CLC507i
	5HcqWX/nRN3zmp3qQMvgBKBvkdxbWWZo1SRTnBcPSkwGKvz+ch+OTgH9nD3qtlroin6tBdEzurn5v
	aSSBwsxJrmv/3p0+UJO/P/hvvnyrsBP3bzYn0s36rOajlryuUqSN8sMAvAR/Wv2qQp9V7LoTjuo+p
	br6JoPEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mC5f8-00DK3z-FL; Fri, 06 Aug 2021 19:37:46 +0000
Received: from mail-pj1-f48.google.com ([209.85.216.48])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mC5ey-00DK1l-E9
 for linux-nvme@lists.infradead.org; Fri, 06 Aug 2021 19:37:37 +0000
Received: by mail-pj1-f48.google.com with SMTP id
 dw2-20020a17090b0942b0290177cb475142so24258881pjb.2
 for <linux-nvme@lists.infradead.org>; Fri, 06 Aug 2021 12:37:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=hn3sgj8kq6Yvs97tYMhHzRdR0tiw06MQuxeuHQCF4w4Od2jgWL1A+CxQaHgcRs57wj
 2aHj8KKjgIAmCIaSNOJhaaYeQCPQBzpxVW2Kc5bC2AJtE9akZbsfdj0OgY1ZyUL/Jkhp
 ELsh+k3VKdN116gbQ9chGZwiPdysMiBrZQZ5+UkGxCfjYMQsdzjeVT6rxe8ZStoJNyhV
 j6Lkq2Au+xRN6U9PaplkOy9HIXOIj/rqst555DjKiiLTZilA0e//9+m6G0Uw2vOl8DZt
 CZCXhcYGp8ZB/0rBjU08oztHh1BUnH3qDMIyjrmd0RhJPsBxpVQI2Mj9sOpIgYVkttDB
 LrOw==
X-Gm-Message-State: AOAM531KnY69wxEa9BoxRNRDDxZ7xvLLp9VNlgdJ8OOv7KrQD9fjQ4b6
 alaSlLGPFYAfqut8SRUEAKg=
X-Google-Smtp-Source: ABdhPJzKm5zeR/e079MgmkbWEf/VWl7ZnEFwdPESudHuSUmbK0ljM2Iypf5VVrwjDur78TTYiVaryQ==
X-Received: by 2002:a63:e04a:: with SMTP id n10mr15715pgj.381.1628278655721;
 Fri, 06 Aug 2021 12:37:35 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4a77:cdda:c1bf:a6b7?
 ([2601:647:4802:9070:4a77:cdda:c1bf:a6b7])
 by smtp.gmail.com with ESMTPSA id z2sm13917456pgz.43.2021.08.06.12.37.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Aug 2021 12:37:35 -0700 (PDT)
Subject: Re: [PATCH 2/2] nvme-pci: disable hmb on idle suspend
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, hch@lst.de
Cc: kai.heng.feng@canonical.com
References: <20210727164044.2285364-1-kbusch@kernel.org>
 <20210727164044.2285364-2-kbusch@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <36f34111-33da-3f94-494c-7c3a42f9480f@grimberg.me>
Date: Fri, 6 Aug 2021 12:37:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210727164044.2285364-2-kbusch@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210806_123736_516631_C4F9F185 
X-CRM114-Status: UNSURE (   8.00  )
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
