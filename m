Return-Path: <SRS0=mLmp=GQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997ADC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 22:14:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2996323339
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 22:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2996323339
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=Fvc3cwuAaAP6fJ+OSISrB2De3
	ltxU01wKvGYtFVT+gzt7YpRCanOOJrw6+vO4qIfRdu/BsRR5gGDSXTQNcHL1I1xicN8jKjGKnKzrB
	JaEgblMJzBgrgSyhuzoeSoi3LCG9PV6Gf4unYs5bE+tlSMlLACH1tCrroZNgWq6lit6U83Jlpwx7T
	WXHguWIqxTaMkV0qGzD89cWlASwwMi4nCSZhV3sgyh0WZSa4F8FkMCZBwa4D0xben+YYvawa8s9b1
	yU998Nrgl0zTU/pB6DbhJShCdgTBdqM6jL+PUjIKIa2dpDPXgY0RrDgdu1eNVf27EDaCCEMKGs9Mn
	AkbgsM5LQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzoOn-0008QZ-Jd; Wed, 13 Jan 2021 22:13:53 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzoOj-0008PQ-GR
 for linux-nvme@lists.infradead.org; Wed, 13 Jan 2021 22:13:50 +0000
Received: by mail-wr1-f46.google.com with SMTP id t16so3753288wra.3
 for <linux-nvme@lists.infradead.org>; Wed, 13 Jan 2021 14:13:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=ZxDwTUtCb+UOpNOXGDljPuS5gpMPSPo+eAsUXo3I1w31OdHkdfGTLeuWAQTWQoOPyw
 y4/uMhxXp2kO7jCZDpCM9oQJTJ0/NF+ozuD3mjsmccxvXQhpCSkeqdZivjvaPQvrLuDv
 c6i6Lho3KWbq0cmbmSLZnXVZYpoDlvrMbvxBJsJ5lZDcEED8Rq8oFFRe3JYOdAJr7BnJ
 ARW9nnzKF7ZnVAGuS/ZmIvQOQ8YxpDXmw+0RVwWvi07G5xXpAp6US3/rSKecjJSvEvHd
 xXHLhJNWnx9py2Jo4QZ95D2IDS3YB1Smutvz45+W13Yx8anIOE/QjPkyqqF4PGfX9n7L
 q8SA==
X-Gm-Message-State: AOAM532DHhKWEiB+i3ih5O+6sl/FFx8bkyYcDMHD4EHp5/Xqee+xw5xP
 /gCcc+6ZISjF2bgNjPtu2WX867nOWIA=
X-Google-Smtp-Source: ABdhPJyuV5q4KED4wYJcPAkFZ4YqSx5UeCubk5OkUbi04A0/dsTF4vH+88YBnv3Oi13ZW6MZU5sxNQ==
X-Received: by 2002:a5d:6909:: with SMTP id t9mr4549261wru.327.1610576027982; 
 Wed, 13 Jan 2021 14:13:47 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:e70c:620a:4d8a:b988?
 ([2601:647:4802:9070:e70c:620a:4d8a:b988])
 by smtp.gmail.com with ESMTPSA id 33sm6190112wrn.35.2021.01.13.14.13.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Jan 2021 14:13:47 -0800 (PST)
Subject: Re: [PATCH] nvme: refactor ns->ctrl by request
To: Minwoo Im <minwoo.im.dev@gmail.com>, linux-nvme@lists.infradead.org
References: <20210113143627.787-1-minwoo.im.dev@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <03cc0e00-6419-d29c-37b2-c4e090efaf75@grimberg.me>
Date: Wed, 13 Jan 2021 14:13:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210113143627.787-1-minwoo.im.dev@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_171349_567405_82363D14 
X-CRM114-Status: UNSURE (   9.71  )
X-CRM114-Notice: Please train this message.
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
