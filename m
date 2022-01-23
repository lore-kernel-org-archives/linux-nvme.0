Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C06C433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Jan 2022 09:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=BRiRRY9PvP+qclKdExl7phFOib
	0MsdDGGraSEoHvcgf9XxYCPXdzdXgw9jq3g3oHuMG1fZMn8pRytIlnLpPobXRTKK8r+N57wj4z++w
	5yBdZz1a504pbbnz0+RQnFf7rShp1EHTPnBykRVlCvVfM227wkcE4Owxl2J6+LPfCMPDIozMbLsKN
	BRaTjsLrueqsEM3obz+nK7EiDs41mIHG3T65cyNLI4dJYAkjZHMzT1ZgewMCJ395YH4X9aOLo0+RW
	cGfUP3OnRzX0VOw74aH6oZJrEegAEhCbseb1jhGRe2twC5H7htAzGheankuTGWPrH83WjDUAalzIA
	yo9Q5TTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nBYzL-000VXK-UI; Sun, 23 Jan 2022 09:16:43 +0000
Received: from mail-ej1-f42.google.com ([209.85.218.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nBYzJ-000VWv-Et
 for linux-nvme@lists.infradead.org; Sun, 23 Jan 2022 09:16:42 +0000
Received: by mail-ej1-f42.google.com with SMTP id k25so12751591ejp.5
 for <linux-nvme@lists.infradead.org>; Sun, 23 Jan 2022 01:16:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=55BcuSOpAcDe1p2bwRumBlXTsCiRQoBJMh4UJgdLPasct3l/HAixygOIw+3lytzMT7
 zBN2sqfrp0VtXp0+eoNC/7a/dMDOIcQC9pCvyiHnOGXKiGmwJGTK/dor0Rd3oAxc5CC6
 eEcRh2CJIihHCOvqq9a7A9Qie8SZ1LRO3ok5FG4Z/UTVoAurevid9NhJRR9/6r+zv/pi
 bXXEkxUYsxe7A0WOYLcXpHmeFOvTm1a/5y+X9kQ2sZBPYgrokerXpDuJPr8dBhjJDzde
 womIDpkmItk8snWKKpiRoQ4s1BxLiCQlKHkTa7xOKhMjhFlLJzwKQRZ6MCz3UfmQt4b7
 qAXg==
X-Gm-Message-State: AOAM530ibAGNDxvQZVQAYaAeQMjhHE+g+7f5hrwQYi3ebl+lY94vQLay
 B7m+X+gex+jRQPvNJ7f2kJ0=
X-Google-Smtp-Source: ABdhPJzzz64xB41wXO5XOv3+AhbkqC8wUkUjAnMooki4uJHZwQblD09K+vnMhGWNvMU/Nvj1ZXzVJg==
X-Received: by 2002:a17:906:fcc6:: with SMTP id
 qx6mr8406229ejb.183.1642929400032; 
 Sun, 23 Jan 2022 01:16:40 -0800 (PST)
Received: from [10.100.102.14] (46-117-116-119.bb.netvision.net.il.
 [46.117.116.119])
 by smtp.gmail.com with ESMTPSA id gr7sm3640820ejb.2.2022.01.23.01.16.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jan 2022 01:16:39 -0800 (PST)
Subject: Re: [PATCH] nvme-fabrics: Fix state check in
 nvmf_ctlr_matches_baseopts()
To: James Smart <jsmart2021@gmail.com>, linux-nvme@lists.infradead.org
Cc: stable@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
References: <20220120201737.65390-1-jsmart2021@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <9484b632-c41d-04bc-364f-9df1c2e1ed95@grimberg.me>
Date: Sun, 23 Jan 2022 11:16:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220120201737.65390-1-jsmart2021@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220123_011641_514062_36F85916 
X-CRM114-Status: UNSURE (   8.65  )
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

