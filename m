Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A137EC433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Nov 2021 10:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eCKxSORFJkus15hUNembK1VywF4QnfPPmVFMRHBtuCE=; b=rJ25KOePXNCxb6bfG9nMjd/wyj
	Sv9ooqfaEYX0sPIxCwfT2Lq/W51WTH9ByVZosnR+Svb64w9CDVxB9sQ+BJ6vhhRziAwOupi+QuJ4V
	w8Pi1gFuExEkBeBdbQcjZHOHfAFwunYyioN5jNK85ReD/KEP6kyn0LB01AUMXzimij+nncOFw06FU
	27DdGKLftD1idBWJk/JEsUtsYEUtLrHIKt0BNmDGk3y1qWYSSAAYbvVZ1GaXjbxHaLV+ZfcZhHPGx
	lpeMt6XJW0UDcvHm9oJWSrK2tniBlN+7mX+zXrODCiXQSRQHhrI3E/md4HqVQx8Of90+XX2e0KmCp
	ZmuU4WpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mojzZ-00DUXr-Gq; Sun, 21 Nov 2021 10:22:37 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mojzX-00DUXD-1N
 for linux-nvme@lists.infradead.org; Sun, 21 Nov 2021 10:22:36 +0000
Received: by mail-wr1-f46.google.com with SMTP id s13so26900831wrb.3
 for <linux-nvme@lists.infradead.org>; Sun, 21 Nov 2021 02:22:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eCKxSORFJkus15hUNembK1VywF4QnfPPmVFMRHBtuCE=;
 b=xmkASEpqsmPLCLNG5egNKjfbJjohsbaxFksgJLnw47259N1QfiY90EnrEJWT9y1RTS
 yZzt1S462KGjUaqRLqOYLyL2K8nfou6p9ELlBgxIJdLewoO586Vx6m16CLlzRz5Ztwtp
 s+1ZtXMwObxJ+7APv4W7IsSgDpdk6VEh92itM1XiC2+ZO/K6LdnkfnuGzjtTnmw7bnnS
 Gxtq5SrithtkhuxSAvjT8hGz+PN3+E35y0Ltnl2OzQl8Uv7UxOqGS1C8pzKM/PuEpfez
 z58Qv8Hi3gINUFF6wVQWBBZ93OeOpTd34gfC4imO871CXXMurDDJ6GVlxXKnhmZ/K2br
 8sWg==
X-Gm-Message-State: AOAM531xV33AoHtYknrxcSHfMNy+9MV9i7C9QIcGPar9XpdYIRol3P7d
 UAWkCwz0nzBN3EkFZnnErFwn2ntebUU=
X-Google-Smtp-Source: ABdhPJzogasSQqP11mMKLb3b6K6DoK1urdVKGH1s0oIvGBNSUYT8tKjiT1H8x4+SMT8CVYoRDYwF8w==
X-Received: by 2002:a05:6000:1813:: with SMTP id
 m19mr25952336wrh.51.1637490149769; 
 Sun, 21 Nov 2021 02:22:29 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id n32sm5748652wms.42.2021.11.21.02.22.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Nov 2021 02:22:29 -0800 (PST)
Subject: Re: [PATCH v2] nvme: Add sibling to list after full initialization
To: Christoph Hellwig <hch@infradead.org>, Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20211111132135.19216-1-dwagner@suse.de>
 <YZfakf32dXVFhK5E@infradead.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a7f48220-8c50-3388-dd40-4f51081ec6ec@grimberg.me>
Date: Sun, 21 Nov 2021 12:22:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YZfakf32dXVFhK5E@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211121_022235_088305_3BEA3692 
X-CRM114-Status: UNSURE (   9.84  )
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


> Thanks,
> 
> applied to nvme-5.16.

I thought this is not needed upstream. Daniel?

