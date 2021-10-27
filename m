Return-Path: <SRS0=8pqL=PP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFBEC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Oct 2021 07:09:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C706E61073
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Oct 2021 07:09:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C706E61073
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
	Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=28J+6PtnJ7qhPqljBBrvPcWY9y
	62+U9rdKRCk9MnLhDtLjCDJ/G8p3C17p//SDJGGUBb7NkQ6R6hb2AzrxAcXCL2UV03xNqh+ZATm3O
	6THkfV/UZZ5YssPOPcJqHy6twSV56E2d9AVQAHk7zTkLVqatJsofnDxYdJE/oJe32xNl1lk6xPxU6
	DucZgz92HxujPxrbebNmfVwSyFuqfCWIGCsVi48BiAnupNWC7zVSOURdPbwLwMyh7aHaWuLbtN1aV
	J6Qrlyd+ExiUkoPM1eW9M0408gpHuQAB1mBr2sT9nq8JJ8BFFoSw8XFWt31A38b6SSLh+1wXxyD7u
	podnKPBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mfd3t-0046x1-P6; Wed, 27 Oct 2021 07:09:25 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mfd3r-0046wC-6F
 for linux-nvme@lists.infradead.org; Wed, 27 Oct 2021 07:09:24 +0000
Received: by mail-wr1-f53.google.com with SMTP id u18so2344703wrg.5
 for <linux-nvme@lists.infradead.org>; Wed, 27 Oct 2021 00:09:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=OmGGRtiAn8Nkciugc0tvf90KHLU/hrupkEn0EAWgwj012k0qUeznZnwgeqOi+LxY8W
 dX4BTJL6YEG8RoTgmgi7Yz+6xV/DAgCsXzkoA4a6XpHK1+jNabFnHnIUjxB0SpWJ9Ywn
 6FHU7gJCpf+PCMFiSfj6sSrToWVjb/C6FQdlDAhAB31t5uZnE6AuGMeThWwBMhfxV7Ga
 /FQ6QhuMO8zF0i9Iin69DHy8je4NJAtxxBLvZbp67CypSDvhErP41JakBV3w4mxaHtzp
 Up6N6FtGmTAu5cV8ZK/4HFipymU13Xo18GgoAwCgzzXroNdjxKIz6ofSGaK000CwxM+i
 NwnQ==
X-Gm-Message-State: AOAM532SnOQiUQZcCTDQXrQ7zipT8Ou3DXXhv22t7Wiij/ne7Lb0ArSd
 2nJ3NZ5VZeTeTzz3ubWWmLg=
X-Google-Smtp-Source: ABdhPJwYSyBMLEv2LONPj+sJJjVdf3Lay4SPIqrnLZu1kCbxhE5DCjg0lQEjrRewmM0ezxM3UWCK9Q==
X-Received: by 2002:a5d:4ec2:: with SMTP id s2mr8686846wrv.119.1635318560545; 
 Wed, 27 Oct 2021 00:09:20 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id s11sm12956429wrt.60.2021.10.27.00.09.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Oct 2021 00:09:20 -0700 (PDT)
Subject: Re: [PATCH] nvmet_tcp: fix header digest verification
To: Amit Engel <amit.engel@dell.com>, linux-nvme@lists.infradead.org,
 hch@lst.de
References: <20211027064927.20452-1-amit.engel@dell.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3a489f15-3a95-b1e9-7333-6ab8b357174c@grimberg.me>
Date: Wed, 27 Oct 2021 10:09:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211027064927.20452-1-amit.engel@dell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211027_000923_243275_82F9B942 
X-CRM114-Status: UNSURE (   8.19  )
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

