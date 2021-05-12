Return-Path: <SRS0=ZvdC=KH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070EAC433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 23:03:44 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E93C613E6
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 23:03:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E93C613E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kvcjeQtpAP10Gg92nm5G5i4kPHJ52KQSIAgIVk9H6Yo=; b=Rh9xCQPFe0OhJXy1duNmb9tD0
	z/oVQYvDq/V5lfjO0WZ0qfqRD0Pi/lWfBDd+6F/7ceWuvAXfcpFUuOvc28PBeHdECk3PsvpmzrFVh
	M+l78Ph0lrJN9anmWsophTthMkbwKsoPevpp6+HgvBN5w/l4QDG8BT+dTvNvZJ3THaF1pVKbdj0iX
	yiV5wdwXl7zZ41Pl4woseMGGxl2im+E7ZHy5jnETYAqrVN9jcmmDWwnyZMQelAmoPBHBExPiquzb3
	94EBnCMa/GQdIyB1SdMhmRzL+lJRPbHqB7wz1bzPmenora/l+dkgv30yKbcpDx5M7vUtDkvO7/l3W
	YJ2ekMmSw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgxsy-004Ciw-NG; Wed, 12 May 2021 23:03:24 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgxsv-004Cij-22
 for linux-nvme@desiato.infradead.org; Wed, 12 May 2021 23:03:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=at/x4ujhwBb1I6B7G6zS733wEZ3y6hgxqlYHDG2px5w=; b=BD6G7xtEuccHY1DrwVwhYqQKHO
 J/7cJUqBve4LL3jtYLttyjlKXP1SFlCmL/VWfsF5lrma8iS1LahY9YMgPyJCkwn7JhW7Jd6qyIcvL
 a/zy1mf2fArr1hFVeX50GCdMxAck8yy2QJPruO7ktfQ8sE5oDoJ+2KsVKjfFarw+R6Obej56BoT7R
 BRipGpm6oSYw52sw9KVN8H4twUpxV01Syk22s6Cg/vNVyE4pKkJTcYKu0HMFh0xozU/N9R7MexiVn
 oyuHEJF+CBrEIUsllQz4lPRHfVRgJuwrpRq8/TF3Pp09RU374oEhg9vJay2rKoFl4nyv5DJ4Qm05z
 IyGMLqKQ==;
Received: from mail-qt1-f180.google.com ([209.85.160.180])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgxss-00AtdR-8n
 for linux-nvme@lists.infradead.org; Wed, 12 May 2021 23:03:19 +0000
Received: by mail-qt1-f180.google.com with SMTP id h21so14766362qtu.5
 for <linux-nvme@lists.infradead.org>; Wed, 12 May 2021 16:03:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=at/x4ujhwBb1I6B7G6zS733wEZ3y6hgxqlYHDG2px5w=;
 b=qseQWm8e2RxEhUs/lzG/QdRleU9ZZHptGFZRpbwQLzFQIWBXwIOLSXgTOartU/4d28
 UIK9xG/rXC1tJ5k/lCm1QFQd72SQu/F8i8qBajt0aaVFNcIJq+IJmtAkD04BOdnt7h4A
 w2du4pVNMy9NMXLTPLJdp8V5Jg9s56v+mQZtOP4cqrfUCR2sUB6dUPB+7SQtqQcffKrZ
 jpYEIUJpnIft/vGdXt853G35E614E63w9VDyCGcfFKcj06xWg4mTHktHG6+cZuCTyeF+
 DCuINRJMHQhU2M5BJvQMOvcETsGSLqE19BqvYyrWdjnz2R4EliJuCSpJmvWV+JDktL9c
 XLEQ==
X-Gm-Message-State: AOAM532aE/XtYpLbHsjUN5uA/S2D+Gmw9yft2ghJnHBoZrueFARfOTed
 p8uI8rL0i8w5x/8go2RJqiU=
X-Google-Smtp-Source: ABdhPJwISQYtEBFYD9TUIlTrkxkUSMiWwD9x7V7Qxf3i8qy9qQ+Qc+LgDt/+hTcIBUX4Gj22i+5gwQ==
X-Received: by 2002:ac8:4750:: with SMTP id k16mr18773465qtp.13.1620860595226; 
 Wed, 12 May 2021 16:03:15 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:c65a:d038:3389:f848?
 ([2600:1700:65a0:78e0:c65a:d038:3389:f848])
 by smtp.gmail.com with ESMTPSA id q2sm1225616qkj.63.2021.05.12.16.03.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 May 2021 16:03:14 -0700 (PDT)
Subject: Re: [PATCH] nvme-fc: clear q_live at beginning of association teardown
To: James Smart <jsmart2021@gmail.com>, linux-nvme@lists.infradead.org
Cc: stable@vger.kernel.org
References: <20210511045635.12494-1-jsmart2021@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <601fa5a1-e52b-edf1-f32e-b1c454e23758@grimberg.me>
Date: Wed, 12 May 2021 16:03:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210511045635.12494-1-jsmart2021@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210512_160318_340311_9A12D6EC 
X-CRM114-Status: GOOD (  14.47  )
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


> The __nvmf_check_ready() routine used to bounce all filesystem io if
> the controller state isn't LIVE. However, a later patch changed the
> logic so that it rejection ends up being based on the Q live check.
> The fc transport has a slightly different sequence from rdma and tcp
> for shutting down queues/marking them non-live. FC marks its queue
> non-live after aborting all ios and waiting for their termination,
> leaving a rather large window for filesystem io to continue to hit the
> transport. Unfortunately this resulted in filesystem io or applications
> seeing I/O errors.
> 
> Change the fc transport to mark the queues non-live at the first
> sign of teardown for the association (when i/o is initially terminated).

Sounds like the correct behavior to me, what is the motivation for doing
that only after all I/O was aborted?

And,
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
