Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD65DC61DE8
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Aug 2026 21:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=UgJ93YxCIFdzSiozpbkx7d3AZj
	KhP8uIMDvNOR9A3uqs8pw7PfFpho6gMzCvjN8zycSWEdSlP1WNnFAucO+0c4A5xldclWj3mQ7slV8
	Zroe52v2Nt4nIMv+vz34r1y4DIS9OCKNz8ICphCfIuXsFJ1CsG3IU141iKOejc4o9fyNLYLa1AceH
	f98GAVVfvx5ZZAzbvQ0nXZT8s3KJqQMaAxjLvq1e0/dmW2vrwDXgEy9Sj6XvYOo7NNJqg/zmjvWVs
	pM/zHk/+txjc7UpUwGVs1ya8FAJzqNopjwDIjnVAGKzUfcKoy3JXT7UM50zfiV3V/ZSis5upmCMOZ
	1HxvowrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0n4e-000000087lA-2Aer;
	Sun, 30 Aug 2026 21:28:20 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0n4c-000000087kf-35mb
	for linux-nvme@lists.infradead.org;
	Sun, 30 Aug 2026 21:28:19 +0000
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49b392ccaacso38261375e9.2
        for <linux-nvme@lists.infradead.org>; Sun, 30 Aug 2026 14:28:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788125297; x=1788730097;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=pFw0shMBn5to6GFQO1NJBtDqDsWc9jIxwzSZgblUmBPtHEf2qlUT4ybbpbVjZlbnHt
         Uzij8v+DISlAEovR5KthkweSPbc23zifkN38mAj429EShW5VoQSSOLkc29mBR5AWSyYd
         hstu1EBvuNZ6kurgb6X+0uW6+1VPK3cH6xoXyyeWhgPYwk1y0J9v556cff0OdCI/VPaL
         oFBlGCW1hG1PqHUHUW++amvvbo2Gdg4M+L8FprvJCmlZ5LNSP65v9Hx0mpjrmdjh0Xy1
         y0cR9EtPfNq+Xx4TO2sjdjrbO+yttWIV7c+qAW1w3D7sl/iQd69MlhNRaFuhPDIfoSIu
         nRqw==
X-Gm-Message-State: AFuF++lYKj0C/QWKZlsowR1TBVYM6Frfkgs9houFLgeMHAg2ekzvSFGe
	KJh1upoR5EytCF3g0FNHweUKbaospyR0/CevFogvnl9s7oItTMBoNrdKqG4VCeg3+uA=
X-Gm-Gg: AR+sD11OxPT4BWgQ/m8FlvKyRNybDXNoM/naL3ZZyLrSrLJmLYk82l18kwe3ynvFl3M
	7hXMKwvAKIqQeGO4H1sRVXcWPwYpJ2L71Xs2WBklJK1tkkPra7CEWQXzOhytntCOHqAXJT/i+/e
	ZfC/cINRR23tQvoDVO42poimP8GZGDJp85DE0m1aYjTtkDxrNEX5ax0MX6MN7oRfLti3aEyNO2G
	4eOvoVzS+V3/d2UH+lzCYuU1KSs7B5F7+tT4SjgDv+BXRPrqu0uUS/PH0wWIT2DPLyz4c843tdJ
	i17/zcvCxDQo6t5WGFtgjmLe8VnHRYXKcsXZAnXi6dUBOre8isVepNUfgWf4YR+CSW8eT74GNuI
	ruC78M9j7idAM55WzpHXS1qs/y5muwZIRebx/FpQh5aSDXEW2cb8m7okNh8/bURxi49vWh/b/ro
	gcYKSCh+cJFFLe5uEnWXGt6yYUQS2eUlCF9YP4O+6UN0X2XFDS9meggHrbcEQzo5y0CKQFqfxwz
	1AchbO4qyzIjW0FbLgpSw==
X-Received: by 2002:a05:600c:19ca:b0:49c:cee0:f383 with SMTP id 5b1f17b1804b1-49ccee0f3cdmr140900095e9.16.1788125296808;
        Sun, 30 Aug 2026 14:28:16 -0700 (PDT)
Received: from [10.100.102.74] (89-138-77-243.bb.netvision.net.il. [89.138.77.243])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48436e2af45sm9074554f8f.9.2026.08.30.14.28.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Aug 2026 14:28:16 -0700 (PDT)
Message-ID: <62abbbbf-e0ea-4e06-af5c-1e1854ea6295@grimberg.me>
Date: Mon, 31 Aug 2026 00:28:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: reject namespace enable without device path
To: Seokgyu Choi <tjrrb0313@gmail.com>, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 syzbot+f613f9f010ec98eb9d86@syzkaller.appspotmail.com
References: <20260827075221.312935-1-tjrrb0313@gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260827075221.312935-1-tjrrb0313@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260830_142818_777884_0DC2FFE8 
X-CRM114-Status: UNSURE (   4.66  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

