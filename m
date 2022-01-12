Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C62C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jan 2022 08:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WwJVaRzRUx6SGgX8lu+qCB0YWwBAJIWWY6asI7yKKVs=; b=Gt21Wh+IXPlPE9yi3G2xrxmd9s
	buxVbjTINqxkxOhnAnSkpgPiTHbRtjEJwSbA1HknSL7fiOmP+AULD3Y+M4S8bhrO4jInol4Xi1b46
	r/LMtKvRnhI86zqynHloOtxJyhswmWlCtLOH3+aB3ap09rAH2Fb59QVOlaJfr/Ad0BwUsj2egkCIa
	7wYaeBU9vOq0ueia7BhWS+9w/u4i9ZmNOwkXzXl4gNrkEggrLqZWQ2eMp9m0VB3pxeIQ6sXSodm3u
	CWnTH0Fw9AGuI538AQv5I3e3aX1DcGcbiKDXjq/cptMN3xDkaqS+cOEjgFa9ZnqdlYUtEgA8VcgPZ
	RWgGOXtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n7Z9d-001a7g-5D; Wed, 12 Jan 2022 08:38:49 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n7Z9a-001a6J-4t
 for linux-nvme@lists.infradead.org; Wed, 12 Jan 2022 08:38:47 +0000
Received: by mail-wr1-f42.google.com with SMTP id l25so2721715wrb.13
 for <linux-nvme@lists.infradead.org>; Wed, 12 Jan 2022 00:38:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WwJVaRzRUx6SGgX8lu+qCB0YWwBAJIWWY6asI7yKKVs=;
 b=hETorpGJUTAQOKeezyv5UMfAsLRFRPsnhuciqMD4ffMFQKqS8bEkeXsYtxqN2O787f
 pmfW+nseLikWn1b4DDWN+GcfpdAqj0TAxjGcDrE0IL/4ji+ZD1C14v9ipiGIr9OCyoDT
 15QV1EZ45nZ4pxc5zMtxuAV57/9eTQ6TOM4SJoe40yfGgDwc2NQ4MOTB6sHtrGGSUKo7
 pkqnmIhz9vmqoI0IiQREUdIgXhJ1R/xxgdqUu9HVjpPNx9eEfLLrFj6ved2fyB2rWAmt
 dFCvja6+dPaRm7SuG00mGr3tUZUsaddPk0BgwGmip9EES5rZ6W8pel1MrxAafBMexE05
 QfJg==
X-Gm-Message-State: AOAM531uT6moyF/fIR2KvzjcIGFi+9HwjXmkUutcOuI4g5UliOzqUfR7
 terVDauQe3ORQe8Pq1kk3iQ=
X-Google-Smtp-Source: ABdhPJzjW88riDW5DvYGR9CcW3afhgqtMYHD2kCRbRPbENxLz7A8MxmmABHg2Bh2xOzgpvEpsv10sg==
X-Received: by 2002:a05:6000:188f:: with SMTP id
 a15mr7123464wri.153.1641976723596; 
 Wed, 12 Jan 2022 00:38:43 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id k33sm3680879wms.21.2022.01.12.00.38.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jan 2022 00:38:43 -0800 (PST)
Subject: Re: [PATCH blktests 0/3] tetss/nvme: fix nvme disc changes
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Cc: osandov@fb.com, Chaitanya Kulkarni <kch@nvidia.com>
References: <20220112060614.73015-1-chaitanyak@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <dabc21d2-6431-67e0-8ce5-62c74c76bc99@grimberg.me>
Date: Wed, 12 Jan 2022 10:38:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220112060614.73015-1-chaitanyak@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220112_003846_223634_34039EB7 
X-CRM114-Status: UNSURE (   9.36  )
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

What is preventing this to break again?

Can we modify the tests to not rely on a consistent
output here. Perhaps just search/match the expected nvm subsystems
in the log page?

