Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFEFD3C935
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Oct 2024 23:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=SlIm/u+J+9kmPkN48DJGrXduej
	+/p7wIRPvZ0gnGp/1G5dQar+IllCec137B1fuEvn+1gkNBWeDe2BfQY6h2eBSpf4zESnLSp0SxQ7o
	/nVvR8WUi9rwLuwPcB1RinKgvb+AplJOD9JPlHxAPJzcLKcZ8KD1/dK8xjEALfzWgxBhKDp1YNLsM
	4TUd/ZjqnL41gNmINtfsYeTyCkVP9gSjIcx44ZSD03i98WsCsqnWqDfTWLSuuBosGRYucg7Qo7QGi
	lbtSRHleFeVAD7IIXp4d9K+wMQOuDl0MWPudL3/WLCNmy/zisYojjq+6TKXue+yLBo0K9247YO2K9
	7WTCuO6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2ffM-00000005eMO-1x3v;
	Sun, 20 Oct 2024 23:48:56 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2ffI-00000005eLZ-3ppk
	for linux-nvme@lists.infradead.org;
	Sun, 20 Oct 2024 23:48:54 +0000
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d4ac91d97so3853837f8f.2
        for <linux-nvme@lists.infradead.org>; Sun, 20 Oct 2024 16:48:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729468131; x=1730072931;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=dM1bHFuZoDGVpUpxHlJQbo2cGpt/ddTn3cjDgY4SNMCeF6H8nzPNxq/pmXAgY74vSi
         C/dVluO2hzitbedcFGzf1lWdILubRO8cnxcJrSNIZVwkpNhpSZT3rInegKt6gSuVG0t5
         CjSvffbNPNAItEk49SFf5Ld0/uWRaMMQQImla9l13l5U+sAKyzncEoJM1bKYbgoTkQlM
         avu1DeEatXr1x3/DX+/S/gVloPbC73jEW6KMKTTtA7K1vXP957shHqc90X6NpPmL9NF+
         NYDpLOEs5YNa6MWeQLxU017PJ1vulK+Dmp1Ck62Fu4+k5HApIjaFSeiqqIMm2cPiJI3w
         7Q2Q==
X-Gm-Message-State: AOJu0YyJEb7MNC9gDzdWMI496VhVXsOGCRLcKxnl4Wt4Gnv/BMV6oXDu
	a1IrP8DOHxodsZZi4j7e/lFp7tDl42cNH+0oaBNsQSBtbR46bl5K
X-Google-Smtp-Source: AGHT+IEMp8CyQnZhHGtuwxR+W0JsLKMh3NqZiuKUszf2rJxpE1SXN8UZI0s7XARH3MyArg9K4Iwdtw==
X-Received: by 2002:a5d:558b:0:b0:37d:3705:84e7 with SMTP id ffacd0b85a97d-37ea21d8f6cmr9025720f8f.17.1729468131066;
        Sun, 20 Oct 2024 16:48:51 -0700 (PDT)
Received: from [10.100.102.74] (89-138-78-158.bb.netvision.net.il. [89.138.78.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b9bcb7sm2820109f8f.102.2024.10.20.16.48.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2024 16:48:50 -0700 (PDT)
Message-ID: <3a4cad19-9823-41d7-8e44-0fd12013cd76@grimberg.me>
Date: Mon, 21 Oct 2024 02:48:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmetcli: reservation configuration support
To: Guixin Liu <kanie@linux.alibaba.com>, hch@lst.de, kch@nvidia.com,
 d.bogdanov@yadro.com
Cc: linux-nvme@lists.infradead.org
References: <20241008080800.7712-1-kanie@linux.alibaba.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241008080800.7712-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241020_164852_962270_393671EC 
X-CRM114-Status: UNSURE (   4.03  )
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

