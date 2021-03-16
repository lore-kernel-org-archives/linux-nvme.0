Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52084C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 18:29:34 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE44165139
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 18:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE44165139
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=fqdPP9+nZJdjgLfN55qJXEey5
	OVcG1pYDiMrT9bgFGEEhHxb1Ldr32zvTFgkIpTSgoCqddP7cQdFrphKEVsiCFzuSnPGjXF+HnU/gV
	sUCD0yTEh+XzaRgZ3e39v6u//GQnvDFLxwIzlSecHctxrFjCxaRKQOaixg8luoa22QhMAbcKQex/4
	Wu+us/2Xwpo2X9OUmWmqmH3xhzQVZbDHo/aGdL+EHuebTjkca5oZ1AvCzvTE5WySdRGwdACE7paup
	5iZYfvCLlqGhGIyuBOcBt31FfvCt5aeTfGc55VcXW9KQ+kfTWzUD5IFsM5Ek2KRGIqXDEqF0LZ4LL
	Yx8qkSzaw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMERY-001cUP-Km; Tue, 16 Mar 2021 18:29:24 +0000
Received: from mail-pl1-f179.google.com ([209.85.214.179])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMERO-001cT5-RE
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 18:29:19 +0000
Received: by mail-pl1-f179.google.com with SMTP id q12so6888494plr.1
 for <linux-nvme@lists.infradead.org>; Tue, 16 Mar 2021 11:29:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=aX6htH+WtYf3C/dpGMseYpWRzt9xj1eLOQKis/DJIonzRQYu2wWyasv077uVyBmQhF
 b9y85mErD8xpEaMYLL+1TiFd5oQyl9eJOF2Ia65CkLdoe9tZEoecGYCqs2DydAJuza1I
 XnEwLgBSEIuhK+3CBTZFKVl1LYiFzL2RG6icO6sT8p8BQGCjLMMwv1s+QIpdCeFHWEgw
 ze8wnxqc8vmvaTNtmU/IObPVBdPwHBEBubzIq5ou1ydRbllIyqPdWdHCH7087jBPRfvH
 ArXkwVPkaU2fwYsMtta4pndZJ59cs+YrYrZuGgN27FR7ggY1CxVVfDt1Uzf0h5vEhRYI
 2CNg==
X-Gm-Message-State: AOAM533E1Yy25NBq+1NNtvP6AyN1A2GowM6THaBZBWVEbS5k+ch6IQPl
 TkpYoHiCCUDQ8lDprapQTTjYNOphCaY=
X-Google-Smtp-Source: ABdhPJwqt9IM2aWh36Nlnm5HfOyjn8UWLSYtbFqjxWHrhgNwoQ9G6ffMTslPUGjZFAZDuy6HMuzHyg==
X-Received: by 2002:a17:90b:46d0:: with SMTP id
 jx16mr374865pjb.3.1615919353027; 
 Tue, 16 Mar 2021 11:29:13 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:52e4:89ef:d916:a3a6?
 ([2601:647:4802:9070:52e4:89ef:d916:a3a6])
 by smtp.gmail.com with ESMTPSA id z11sm17778555pgj.22.2021.03.16.11.29.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Mar 2021 11:29:12 -0700 (PDT)
Subject: Re: [PATCH] nvmet-tcp: fix kmap leak when data digest in use
To: elad.grupi@dell.com, linux-nvme@lists.infradead.org
References: <20210316154425.16434-1-elad.grupi@dell.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5d1dc61d-bea6-41b8-ec33-e6bacc8ecc30@grimberg.me>
Date: Tue, 16 Mar 2021 11:29:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210316154425.16434-1-elad.grupi@dell.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_182915_002265_E8B50038 
X-CRM114-Status: UNSURE (   8.20  )
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
