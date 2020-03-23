Return-Path: <SRS0=QV8n=5I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CF8C4332E
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2020 08:33:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9935920409
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2020 08:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VtLBnBqY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9935920409
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vYy/uwPENK8EwNIDU8d0whiEYNzDsil38sKHPiTV2+s=; b=VtLBnBqYt1z+EdU6ybZMziQVe
	xHNe7n/9N9zRB8NKSxNC3G1dmmS4VFvo5Un/lhC1UAjnPfNs+yJG9G89xf7pgaebF5fDRk+9VOmpT
	ydMCgluLYep1mjfZHjH0XWkGW4VhVlOk4zghBT9WL03mCIc0h7juwKDQjUQSyaxCAavCV3l6FCEBg
	RHCfyaNRX0tkc+8SnWBiJaYrpnb1M545eKV9RAGOuDw4abeTiqXiWGt8UleFycZEX+6qs8ShDgazn
	DF93LDIV1tEmF0g+8YhM2TzYI2LCSnm7TqRwmrrIvjBn2YJYYpE4a6yakZDNFFgtdqyv0Nk3vs4Me
	GBo68V9Pw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jGIWs-0007ZF-8x; Mon, 23 Mar 2020 08:33:50 +0000
Received: from mail-pl1-f174.google.com ([209.85.214.174])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jGIWp-0007Ye-6S
 for linux-nvme@lists.infradead.org; Mon, 23 Mar 2020 08:33:48 +0000
Received: by mail-pl1-f174.google.com with SMTP id h11so5626191plk.7
 for <linux-nvme@lists.infradead.org>; Mon, 23 Mar 2020 01:33:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+u28EKEsTNyAKU74Wk7JsDAzIY+OE9chsjO4fQUZYZw=;
 b=Z6V4cN77JuwzYdy+dqIEGUtAV/KXL0kW8OxzJtqUfvVMVKbsXzQO/+JosYzYAx/MH8
 FR7P/IiGW8Icxt9uAIcep3dODaFU1YzIhJ7qbdlKCxmii73OjNB4ARPMBNaj/Db7bcn3
 8xKbdpsGb4am1cqlsZpDWXwWnGSM7WM8gyHlAxUyekoLm7oF6i7GJ/42vICQrwiAvg5N
 Eclg+8sYoCA5u4KQJvs2rkeRw2zx6c4zMq9mJgMFtzIMBsbdRKtEurvS2DiDTHKeENQP
 PQrA8zKuFxaLIS0WYOM9udY3UmC9JJ+jnieVzzCaMU9DjEFWumgXltllSuEAH2sVBJRb
 fTBw==
X-Gm-Message-State: ANhLgQ32GQPmQwg3DOuqiNROOBJ9d4KjcsfIhqYmN4beI5KGZR7bvxv3
 nvS048q4fMz3CrvjJDH4mjYgfLUF
X-Google-Smtp-Source: ADFU+vuOZ879LGRDvpo7gXicuYM7LYLoMM59vhMK3yoQagDnUMKf9Jb55Sxk06fH6t/eiWVl+m10Xg==
X-Received: by 2002:a17:90a:208:: with SMTP id
 c8mr23983844pjc.153.1584952425456; 
 Mon, 23 Mar 2020 01:33:45 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4c50:a06:3358:69f8?
 ([2601:647:4802:9070:4c50:a06:3358:69f8])
 by smtp.gmail.com with ESMTPSA id g2sm5372701pfh.193.2020.03.23.01.33.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 23 Mar 2020 01:33:44 -0700 (PDT)
Subject: Re: nvmet: Kernel oops when doing mkfs on nvme-tcp device
To: tasleson@redhat.com, linux-nvme@lists.infradead.org
References: <17c25d8d-0dc2-9dc8-2b65-954034c23646@redhat.com>
 <507887d2-96dd-b0ee-bb05-519039d98359@grimberg.me>
 <e16baf6a-c9e0-2249-6d7a-4e8d58f8e9b6@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f390f5a1-a80f-44d7-5d69-642119eef9b8@grimberg.me>
Date: Mon, 23 Mar 2020 01:33:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e16baf6a-c9e0-2249-6d7a-4e8d58f8e9b6@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200323_013347_236334_04F86CAD 
X-CRM114-Status: UNSURE (   9.44  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> Can you share which line *(nvme_tcp_io_work+0x303) map to?
> 
> I'm not running a debug kernel so I don't think I have that available?
> Please advise if otherwise.

Maybe you will still have frame pointers though?

If you run:
gdb <path_to_mod>
...
 > l *(nvme_tcp_io_work+0x303)

Do you get anything useful?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
