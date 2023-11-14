Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B86A6C4167B
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Nov 2023 13:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UWOn9xkLXfzAyDa9uwvXEslUJqBEK3Y7R5kAlZOGMt4=; b=3zKNGCHsxRxw06oKtmNHjaZIOM
	7YOL8kLoA93umiAiZUp2ILQOV9dGnrkzia1cAoVA0QJXDZGdc4cUof1qZgtjWCG4eNlJXBu+axrAF
	MN98mFdpSqhzUUCAr25zAGIvreapd3/1rym2CoHP5yQi7TYOGLi1Fjhi0TM4G5E085UGJ8zi7xBQ7
	+f2IfRXdckYN6a8xj4xupHcmKQTrq/euE32ZtlPxJT6LOEIil+D/6TaF7uJ4KuO34494QhMHvXuKv
	iGmO3EUnPKmeXjuz5TX6gza1TGEg4EavdkQ2tMpd9Rq0BA/FRYxFYYfCnMRJlz48YR6N65KLLOH8a
	FAGUAPGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r2tFD-00G0OY-1E;
	Tue, 14 Nov 2023 13:14:19 +0000
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r2tFA-00G0Nz-2A
	for linux-nvme@lists.infradead.org;
	Tue, 14 Nov 2023 13:14:18 +0000
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1e99b05c8f4so688746fac.0
        for <linux-nvme@lists.infradead.org>; Tue, 14 Nov 2023 05:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1699967655; x=1700572455; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UWOn9xkLXfzAyDa9uwvXEslUJqBEK3Y7R5kAlZOGMt4=;
        b=KOJpHA+BZzrJMSH+WbEpD7YA2whQGFMu6mHZoy+Zvsn6T73KMErBS83F6IHOkF3qdW
         L/Nvy1QszP3m7G8VivgbVVxV4y4gFaAwBvmaNnI67wImzCkwd4VuNfZT9wSXSjqv3jYU
         LQ6akhWrQMRyfU/y3vaywZ7rqDQE1qiiN4F8YbWHIRxpUeG7R4qOlpS/Fri+2xyEXwGW
         etIIQ7IcAAXqf5yO92PU9TfPrVnkdBXppQvkSbFUn0tkPZJyvT0fZ7gbozUfYqY1xtS2
         RwmHsfQpVfGV9ZY/ECX8wZMDYGMfT3m1wHFyky1jJt6TwnO9h/EWgxYv2RoUZKb2tDxG
         bA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699967655; x=1700572455;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UWOn9xkLXfzAyDa9uwvXEslUJqBEK3Y7R5kAlZOGMt4=;
        b=WHiNH/eUnrzeAiHzNmVFj09TZnVqyr/0FuhBeHP9vdj4Npd36VERyll3Be8DE0vHDG
         Uts9p3OlGaQxaUCvFRdYsrOxniXNsN0DkcemFkk7yNT+ukM4PlZfmeTdWLNX2e2uJUoG
         x82Xiqmvu2rqfEjU/V0EPOGzsNBJuek+PPSdnQduwHlBc7S2Y8Oliwz6nJY+DDmdAfM+
         ZKNTEIasCXcAoCwKS5ttR8sCMn01GxRQK1hpg1/M4A5uzU5ZX4trz9BokPna2CCacHij
         By8Racu/RcCowOmqMHxU3hmILvM4Waoz+bn25GZmHAcTLkcrK1Kobxvx2Jbo1CZ5dzJ9
         VRgA==
X-Gm-Message-State: AOJu0Ywqtj1TxLk0c+l3euE/AfxVay+gO0TLgXDiVDlkHKM31XqGE+vw
	QOYzPurclnE0Lx8G/om9LYf9bw==
X-Google-Smtp-Source: AGHT+IGSh+Opin/c9+FfUTdefpe5Y0Y9nQUw/FVaNCBuwITnHsLBN4mi7LL5EXjtZ30fGcwfaB+BtQ==
X-Received: by 2002:a05:6870:e983:b0:1ef:9f6c:3dee with SMTP id r3-20020a056870e98300b001ef9f6c3deemr2247625oao.1.1699967655050;
        Tue, 14 Nov 2023 05:14:15 -0800 (PST)
Received: from ?IPV6:2600:380:9158:8653:d646:d45e:2850:11a1? ([2600:380:9158:8653:d646:d45e:2850:11a1])
        by smtp.gmail.com with ESMTPSA id q1-20020ac87341000000b0041e211c5d0bsm2720376qtp.6.2023.11.14.05.14.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 05:14:14 -0800 (PST)
Message-ID: <8022a0e4-f171-4442-a8e1-7d4c7c4f6ddb@kernel.dk>
Date: Tue, 14 Nov 2023 06:14:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-tcp: only evaluate 'tls' option if TLS is selected
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, kernel test robot <yujie.liu@intel.com>
References: <20231114082032.146340-1-hare@suse.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231114082032.146340-1-hare@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231114_051416_925340_3D2135D2 
X-CRM114-Status: UNSURE (   8.07  )
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

On 11/14/23 1:20 AM, Hannes Reinecke wrote:
> We only need to evaluate the 'tls' connect option if TLS is
> enabled; otherwise we might be getting a link error.

As mentioned last time, please include a Fixes line. Don't make
the maintainers do this work.

-- 
Jens Axboe



