Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F63CDB465
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Oct 2023 13:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6PkhFLMN2psAqfXe2KDkquFJOeVJNLb2oIL4+vBp7L4=; b=R4agTLWWfIuOrjR9sL49OQqQRy
	mSHdd3q8tqSLwVTqx2ovM9gfwYI3TRTdJRwjEURgfyCCC5YGw9qTvqebbWRHpDcAn6iy18MpbbKZF
	8jQflWic3BGQKX2mKgSS4rGVKWxKSB1rcqJFDsELbmISOk+aQ39qYFHHh6hjhkmLn/n2UifnM9IfX
	8di8hfOk/px80NaWzesa8SW96mk4q8C8XxgnDfptSZmOi3iBDS9StKVyGVGAcorb2p35mC5SZ7Y3L
	CvYraUG4E09tZy56nRyghZVMpStr6gMl+uJbeLogafUVhoIKhrjbwUibUyZ1PR1dwuiwIF646SJlm
	8VIionoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtSea-00HTeW-0a;
	Thu, 19 Oct 2023 13:01:32 +0000
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtSeW-00HTdQ-1e
	for linux-nvme@lists.infradead.org;
	Thu, 19 Oct 2023 13:01:30 +0000
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6bd20c30831so1214770b3a.1
        for <linux-nvme@lists.infradead.org>; Thu, 19 Oct 2023 06:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697720485; x=1698325285; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6PkhFLMN2psAqfXe2KDkquFJOeVJNLb2oIL4+vBp7L4=;
        b=Fq6xNLKVnxom6eMRidyhnOodbnOOlWW7hI0hPn5CFMMYO6vjh3ukXtqE0Sq/cPb77j
         xyWsbM4h11gAg0Bzx5ezRR/KY2/1P1vuWC8TM8Ur66fpaMdjCa3Oby0JqwcHQleqyChD
         LFpk9X3qCraQkjXpWelH9Zxr3ISUiaLXv+KWyQYEJfhNGnXJ8efX+PCN1xxOFDct8kEM
         dbtWcQjM7A/XEUPHvkK4wmHdlPQZK0RcuSjfeRLqFYitzjMyQ8EYbQ9VG++MoTDUj0ix
         7YTKeTEsQjK8jc29lz0tC3N08SpKETkGgz03tK0nzz4fKvw88lFi75S9IjiWenq33iqp
         bvmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697720485; x=1698325285;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6PkhFLMN2psAqfXe2KDkquFJOeVJNLb2oIL4+vBp7L4=;
        b=OhI6eUlc7la1hXwOXLM921opuuZnE0qD7gntS7daMqE070RcijZGDacdJBIP6Jxs/S
         t67PsIAsuEI8WC7EGu+a73GRTXs4V+y1pF3SzmctovZH5HIVKJYEvINX7vOEYq0Xk15o
         ii2AlY40xs1pXjjDjtkjVQ93mSgCuiRiaW8J12BbUwl8livW0Oaxv+u/94LiiExnmJOn
         feIMsdId9DfpmX8jjCiGKDxthmFwRHkC9lM4YP9I8LRY3MM8B0FuCxzxrxcMQaML3JdM
         sgJT9sEcYZxY0DQA8ixnbIgFeIk4G6rbkaybV9nJ63kSC/Pw0bmAD1s9GkCTVZ+24xL+
         3KAw==
X-Gm-Message-State: AOJu0YxHXz+dFVwqxrO/2WLOZychOmmPl1pUAn9CzyoGOrFu+k4jiSMq
	iYFi3AAyWDqKFw8dnzxIMScV0A==
X-Google-Smtp-Source: AGHT+IHqj/A3SFUIhodHye483SoWgkawHq0tuJIGo/Kn6neVhXoZNlx2mH0kdva7lcwPp1GWU/b5EQ==
X-Received: by 2002:a05:6a00:1d11:b0:6bc:ff89:a2fc with SMTP id a17-20020a056a001d1100b006bcff89a2fcmr1859786pfx.2.1697720484800;
        Thu, 19 Oct 2023 06:01:24 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id k9-20020aa790c9000000b006be047268d5sm5223820pfk.174.2023.10.19.06.01.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 06:01:24 -0700 (PDT)
Message-ID: <61a4991d-1ad3-4c7e-8629-ac3100a0f745@kernel.dk>
Date: Thu, 19 Oct 2023 07:01:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-tcp: do not try to cancel uninitialized
 tls_handshake_tmo_work
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Yi Zhang <yi.zhang@redhat.com>, linux-nvme@lists.infradead.org,
 Maurizio Lombardi <mlombard@redhat.com>
References: <20231019125336.138578-1-hare@suse.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231019125336.138578-1-hare@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231019_060128_758154_FC10CBB7 
X-CRM114-Status: UNSURE (   9.22  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 10/19/23 6:53 AM, Hannes Reinecke wrote:
> The TLS handshake timeout workqueue is only initialized if TLS
> is configured, so we shouldn't try to de-initialize it
> unconditionally.

What about the one in nvmet_tcp_tls_handshake_done()?

Please include a fixes line.

-- 
Jens Axboe



