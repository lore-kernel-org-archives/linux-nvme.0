Return-Path: <SRS0=roYe=ID=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22277C433DB
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 22:00:54 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9FEE64FF0
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 22:00:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9FEE64FF0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=LGHX6VWXqF2PDRJMyXURrzXpm
	OHHbmNSenda18bl//UViX9PsIqJuCPDufiFb0+XtBWP9NLp8/AUNbXkdWhJGfsmgWHrrBKhcspd6j
	XK9a1XWlZOHyP9DnlLtRhxG5Qi/feQegX89zO33aLd/dtXUeB3rFSFim6e9unarHR3DQhN0YiGYoB
	6ew/DQrdWug7HpaNzkwS1mIBbiq0apluPxY+H9y97ysQBfc3eaUz5vgQIH55KecO/YuxczztiHYyV
	0vnVjGQVxnPQxgfGen6Z0OORJWCLfk4wr5wjwImtHiwuLLmcz+BQMsZajNb00MG34bD360kVe3+qL
	y0WPatP/w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIIUg-00GiOZ-Dk; Fri, 05 Mar 2021 22:00:22 +0000
Received: from mail-oi1-f171.google.com ([209.85.167.171])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIIUU-00GiKU-Ed
 for linux-nvme@lists.infradead.org; Fri, 05 Mar 2021 22:00:14 +0000
Received: by mail-oi1-f171.google.com with SMTP id f3so4109536oiw.13
 for <linux-nvme@lists.infradead.org>; Fri, 05 Mar 2021 14:00:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=tgrp5eEuvkcl4b84J+7s5PQ0Vu0HyXPr2QREIAW1ukRU1C0XxIciE3PlFy5I9lAONw
 5nRzOBdHZ+NbuN+jICKVM0zD+8vEFg3omYvWk2BCf7YNRrwV8+GZ0gbB/N7jvPRL5O8j
 szXjZuMLFIDjBwB9jS1tziejj2+20ZMhwKvl03e0V5fdDHovoAf729yn8MRryHmkOqlE
 v1YEnc2WTXWktO33cSm2oGkhO9FNWqY31BqgqydeFo/0iQt45xwfoeevLDoNF0bMPEND
 bAyrNsZqiQA/MCpb+mhsxz+gv1zpxHQbopvlhx6rUp55Y2OKdyqnHtkdHAME/o0kEu4Z
 VXYA==
X-Gm-Message-State: AOAM53125MLlVKRHkifZz3pxl85/lS9k0qWGZ8i+Sri0+dAFCT7BSxdh
 Cb6lo8W92ZHYitdITX1sagA=
X-Google-Smtp-Source: ABdhPJwRqpUnVH+4/AklD7ZKbn0bOkuovgnwLa4Iy1YyeTfUbeSt+m8h+F+SXBRe2v8EDV2RBLpYoQ==
X-Received: by 2002:a05:6808:656:: with SMTP id
 z22mr8318306oih.163.1614981609158; 
 Fri, 05 Mar 2021 14:00:09 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:e55e:67c6:e7ec:9?
 ([2600:1700:65a0:78e0:e55e:67c6:e7ec:9])
 by smtp.gmail.com with ESMTPSA id u7sm814279oic.3.2021.03.05.14.00.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Mar 2021 14:00:08 -0800 (PST)
Subject: Re: [PATCH 4/4] nvme-fc: return NVME_SC_HOST_ABORTED_CMD when a
 command has been aborted
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 James Smart <james.smart@broadcom.com>, Daniel Wagner <dwagner@suse.de>
References: <20210226071728.106923-1-hare@suse.de>
 <20210226071728.106923-5-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <bf7d77a2-7278-b127-cdb9-38460a770a8e@grimberg.me>
Date: Fri, 5 Mar 2021 14:00:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210226071728.106923-5-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210305_220013_276766_404B8C2D 
X-CRM114-Status: UNSURE (   9.72  )
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
