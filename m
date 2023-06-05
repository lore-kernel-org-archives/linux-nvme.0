Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C94C7EE24
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jun 2023 23:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=f468ugtEUKZDAFgJMy4YC2t/oM
	L2i3WTKJ+tLm5YuBtFdrPkI3PDHCdQk4raKio3C19f2GHic4OHSu3NZZhpeucSmE0hZRc6oRbLtHj
	bS2+ChYLNjfhS2rPyhQx1wtOPa7PCbkoy6Hzx1G10gGzANoNipQkpD1Xd6MmGsCTWgtz8VAgor2p3
	6Axa+jejB0a0RiNsTJpMUfdr0BiADmfwTNg0UtY1VaF+W/NrNJ6i9hIvS4MkhNDbWsZ/g4DLde4qg
	Pukqh1b113kt3puATne5tqLGeJNidOrf1pvFP/auepcLOUSNt0ecYjkolgTBMpxfB8dJqnWVurpxi
	wM+eqNZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6JDc-00H5RE-1k;
	Mon, 05 Jun 2023 23:02:32 +0000
Received: from mail-lj1-f174.google.com ([209.85.208.174])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6JDX-00H5Pf-2K
	for linux-nvme@lists.infradead.org;
	Mon, 05 Jun 2023 23:02:30 +0000
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2b1ce5e337eso3758861fa.1
        for <linux-nvme@lists.infradead.org>; Mon, 05 Jun 2023 16:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686006144; x=1688598144;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=gSCB3yZxPey0aYTkKPuJm0+Fc2lgA71ZRzdLW781pHeEdrQZf3dqMGCPfvCnKCS2QP
         HiXgYMcOUso5ZhVMv5z7HTiJeGAgoU3U/FLTD3mH7vwpn+q0cz3iEK+q2o80yh1N/0hp
         5rTzzsLWUdUBw3wPHnwQkl4HG/OxItYFUm9Y/CGV0cl0xBAlmlO7PnAeGRWqebcK4eCq
         DE+vUwXEG0w3qGC8dlE9RaaiIEjO6oPFoeKiE8F0PGQqSrm3uy9UAsypa1tfnPji0ZbU
         XP3ES+ssTm//Xr/ELnsoZAE9cE2NOpXe3qcnI8tEZ1dh4GG7C44yiK1MnAsclD48Z7PV
         UzMA==
X-Gm-Message-State: AC+VfDy0wUcuokADVr0AnkQcHMmdtWQLktqfyHaO33UNtRy+o+A8jsuX
	kWbN/UwX1lvU/5b92dVxEPo=
X-Google-Smtp-Source: ACHHUZ4i8igRIPXlI9LYzTJydK2k7mD2tYjm0Dnf9uJDM6vuLFmVBN3oHujS9b/3SiOTwN+lXCz1og==
X-Received: by 2002:a2e:b4af:0:b0:2b1:ebdc:c4a6 with SMTP id q15-20020a2eb4af000000b002b1ebdcc4a6mr278821ljm.0.1686006143698;
        Mon, 05 Jun 2023 16:02:23 -0700 (PDT)
Received: from [10.100.102.14] (46-117-190-200.bb.netvision.net.il. [46.117.190.200])
        by smtp.gmail.com with ESMTPSA id k15-20020a2e888f000000b002ad99aa3fa8sm1631893lji.13.2023.06.05.16.02.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 16:02:23 -0700 (PDT)
Message-ID: <71e356d7-9b9c-b425-53bf-c583cdd635e0@grimberg.me>
Date: Tue, 6 Jun 2023 02:02:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] nvme: skip optional id ctrl csi if it failed
Content-Language: en-US
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org, hch@lst.de
Cc: Keith Busch <kbusch@kernel.org>
References: <20230530152221.2388252-1-kbusch@meta.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230530152221.2388252-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230605_160227_754545_7C8CEA84 
X-CRM114-Status: UNSURE (   6.07  )
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

