Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BD7C47DA9
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 20:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=XLtZuQH8uZv/3DCS5cXJDirOIo
	zyOJNymh7K8YTcEMrmGeNUSFwgr/dbv5D/+KFhWaP4ocZiUc8JzfOF6ZPLbcXpmG1HLQqldzUd77u
	M8jRtag36yWMEXl5ViO6r5f7XLSi92ELSb+kNrNYi7xZ0JKbN293de/2W4KsUFdCe1PUh+myV8mBi
	KfkGCmTm5OVWxzk2jvBy4pOufwMIVYTTfe+lKDaMR9DbGFr193fGgXCYFc0/z+yNljoZ2dJ4gpz6O
	ldK6OLP70UyhoOdEQ3xc3XgOp0bJS9+NYpqNumnTl9hiBqALdAZpCg2wLYlcRa/X98ofz1F1rrEQv
	OhLp6syw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUXng-0000000EBDQ-0kc7;
	Mon, 29 Jan 2024 20:00:12 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUXnc-0000000EB9U-4381
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 20:00:10 +0000
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33aee169b9dso93391f8f.0
        for <linux-nvme@lists.infradead.org>; Mon, 29 Jan 2024 12:00:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706558405; x=1707163205;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=O/hSD1uVTZQoPRFIuDVtzGqyuvS2cjCFCewJtGZCexkF+BkJA3w3k4Sz8pqNMnwheA
         CrdP0j3qsSGBXpa9B1zsd0kPdm1brlNyG+/12P4E38mQ1eukz/PA5kDWlONZ5K8LrwdE
         SrQOEp5EClAR2/F9/2byrDzsYgtkipyGD3T5WhfX0J8OrAyx8gf31CupDS0CGbjAIjOr
         JkCnr4xZ0H8D7t7gD4b5okpF3ICk96/Ab9OioJYQSYbUHuWbUxVXrhPTO8VUOCT6iMUH
         3+ESAwGwVEgA4b1OP4gk1VN4WYI/difLmatMjvHWPO22W3btEVXyianq77xruFYKoTTz
         NUNw==
X-Gm-Message-State: AOJu0Yxn6dIIzyrOgiPm95W6Xly1eO/eepI+vdmj+kpjb1kF+ZgQc+tu
	je7vGSrRFqHKwkJrZ6zyoclD6rr2DRUa5kRN3aH7ra3QOYuUsM4N
X-Google-Smtp-Source: AGHT+IEhOqnOEicF6RpDjF9Gl5lag7wxfmO0TO5+9sEVqHe/vbT+symm+lfXd0bXJTIua3nPCedApg==
X-Received: by 2002:adf:9b96:0:b0:33a:e605:57b9 with SMTP id d22-20020adf9b96000000b0033ae60557b9mr4579413wrc.3.1706558405335;
        Mon, 29 Jan 2024 12:00:05 -0800 (PST)
Received: from [10.100.102.67] (46-117-114-124.bb.netvision.net.il. [46.117.114.124])
        by smtp.gmail.com with ESMTPSA id eo6-20020a056000428600b0033af5086c2dsm1401965wrb.58.2024.01.29.12.00.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 12:00:05 -0800 (PST)
Message-ID: <65ed079e-cce9-478d-8831-88cadfd408d8@grimberg.me>
Date: Mon, 29 Jan 2024 22:00:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] nvme-auth: open-code single-use macros
Content-Language: en-US
To: hare@kernel.org, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20240129063948.3105-1-hare@kernel.org>
 <20240129063948.3105-2-hare@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240129063948.3105-2-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_120009_023323_6044B16A 
X-CRM114-Status: UNSURE (   5.16  )
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

