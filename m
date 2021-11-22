Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE02C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 08:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=w+O37SxwlvcRsVx8Bw6cPTelTN
	apDuCQ2gUaMC+JQ9/8sbq7vmqwWFle2vxlmerhV+RU1v1SXB2p52kQ+mGN+2ATcyTue2ykbogHIRc
	xztV5/KPhP+rPWOsoOpOnXnntdR5ex6e3gzQTi/2hTcpY/oCcnp1SkcVJm8vqvjKoLy7G7MVXsxa3
	U6XgLaX6SijktNahFy6GuhHKV6LwhlNeDO8dcL0koyfnT2P2tIC4xfetm07BxwHtIdz/kc34q4E11
	pUo3dc+pOZ4ZiiiuWeV1XmisULbEYUvIRbO104JqDYibMVzLAW3zUfBnQavat8aVHIxhAcQDjg4CX
	ZxvH7xVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp56j-00FPxu-H3; Mon, 22 Nov 2021 08:55:25 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp51H-00FMFa-HP
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 08:49:49 +0000
Received: by mail-wm1-f50.google.com with SMTP id p18so14497033wmq.5
 for <linux-nvme@lists.infradead.org>; Mon, 22 Nov 2021 00:49:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=5yC0lKPmcZF9cCijxin3EAvRZ8ScMBamezq7QreaEDkIbXbwnqGaiIR8phq0RKey8O
 ItXynGRseGq/pouwht1cNg3xAsOOlJELNJBFJeBPCgD05TVCUd0+GbbgNU0phCVUNUH8
 ZiCJOioR2Bd1OX7rLXJXLaVTlAF/V2khiz/RY2ZHFtNaATTFsKlGBnsrE8LUpfR4S8P3
 GGrGKYt8DkpgWs2cFpUNhdWJ65f9T7bjhOaVTm/7OMHzQzfapJaZyaGCycAXAMcqTFb5
 skWhRKz6AXT4M4UGKRKGL2R9qxj5Lrnxibfx0eDTUcxPfO9DqYwzdapPGnBh3r3fTTVs
 EGpA==
X-Gm-Message-State: AOAM532ZDHCj8BMKFlNQgK7eMHtXq+3X406OcnY6nY6naNVp0YN5rjFk
 hCgnpmE7L4eKwy7+kQywkcY6bbM1RDg=
X-Google-Smtp-Source: ABdhPJxh7cGpinx8OA7b6+4YQxACpxSRFZv3cM+sMwV4l1bl4VYG7nXi+4CfmsOPkoW+hcH+Vxj0TQ==
X-Received: by 2002:a05:600c:35d4:: with SMTP id
 r20mr27704737wmq.76.1637570982625; 
 Mon, 22 Nov 2021 00:49:42 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id r7sm8135381wrq.29.2021.11.22.00.49.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Nov 2021 00:49:42 -0800 (PST)
Subject: Re: [PATCH 2/9] nvme/rc: clear allowed_hosts subdirectory
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org
References: <20211122075524.26207-1-hare@suse.de>
 <20211122075524.26207-3-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6036ac15-00ef-0cca-46d9-c0db50e4801b@grimberg.me>
Date: Mon, 22 Nov 2021 10:49:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211122075524.26207-3-hare@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_004947_658767_B00628E0 
X-CRM114-Status: UNSURE (   9.17  )
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

