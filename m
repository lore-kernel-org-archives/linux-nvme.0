Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B6BC433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Jan 2022 09:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=KJnBk2zoBEOC3aLNS0KmhvxOxc
	sB26LPqUfg0UY9PqkieEWLVusIadQZsbCpbhodyEbG2BWJWs6JMU6Y83NxHI2jbudJrbrfNlF2And
	fuRQ/IA4SYh0bz38p/CKku1mRrcXUD5LkNFChsjQcThjbFwKb7mappGFNmE9Gz6mJkfABIfDtmErY
	MAPpEA7+yQbtny6O7p0QLa2alUqNKIVB9xXiSLkCvKrwLoVrkxVfXtmL6GtatJXEYIvNJmeTZKzr1
	i4+Hd/Wsof63jYYeuwx+KliXpR2n9sk/CISpPtDlGPq8C9PY6F6gEFbLZo7e6glUOI3+ykv8HIM/H
	6iGppYVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nBYzj-000VcW-2q; Sun, 23 Jan 2022 09:17:07 +0000
Received: from mail-ed1-f47.google.com ([209.85.208.47])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nBYzg-000Vb2-FK
 for linux-nvme@lists.infradead.org; Sun, 23 Jan 2022 09:17:05 +0000
Received: by mail-ed1-f47.google.com with SMTP id m4so50623796edb.10
 for <linux-nvme@lists.infradead.org>; Sun, 23 Jan 2022 01:17:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=B/F6RfU13EATfUgkNcUItGY/C6i93LTAE4r4HVoIZsVBfdv+TIe6i7BdL2DQABY3tF
 sSWqjX/u7Hv50mfeZ4KicsgvbWFxUClSM3wbjyU4v1ajbDsyYeQr0a3ocZHJZI4+skP7
 LzULEvrHibDc9idA6OQh5fZg9fh746jeUr1qLv8CCpsCFOzjeD1V3HLlfQDaa5W2eJti
 DpKEHsAL/g5C1cMdOWz420Y14abh/zSairVHs6lQRmX7tABwD6MrmldzTkbpOrokLeAf
 x/agnOtBgJqceXaJSTcGBDxqwu9klMTks9gmmxo4vbbDTmtk19sgitQGi/6gyYPhcr9l
 Ql3A==
X-Gm-Message-State: AOAM531f2LQZ5VaDea1QTWXT+Cg0rss59xH2+aMnr5L7LJq2qlDsP5wX
 brfByoOWoGbekyvMAM+91SE=
X-Google-Smtp-Source: ABdhPJxqppWNQYd9o/0hUwCRfotxjSI+Q7POozaSIC8z07G0ofHU6TMx7/C1kj7OHJxGghGNn5DdkQ==
X-Received: by 2002:a05:6402:3546:: with SMTP id
 f6mr11118946edd.398.1642929423044; 
 Sun, 23 Jan 2022 01:17:03 -0800 (PST)
Received: from [10.100.102.14] (46-117-116-119.bb.netvision.net.il.
 [46.117.116.119])
 by smtp.gmail.com with ESMTPSA id h1sm4661014edz.64.2022.01.23.01.17.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jan 2022 01:17:02 -0800 (PST)
Subject: Re: [PATCH] nvme-core: remove unnecessary function parameter
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, Chaitanya Kulkarni <kch@nvidia.com>
References: <20220122050539.6726-1-chaitanyak@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <eac7dd03-cb79-14a7-30d2-3c5da44a9d4e@grimberg.me>
Date: Sun, 23 Jan 2022 11:17:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220122050539.6726-1-chaitanyak@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220123_011704_541196_6A6B4E01 
X-CRM114-Status: UNSURE (   7.66  )
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

