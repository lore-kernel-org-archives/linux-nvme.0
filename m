Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8495CC4167B
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Dec 2023 14:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=XSTXXGcBTWJqhwidDqJPShl0dV
	mhBacIqC+jbUgskOTO+boBdjGz+4y5CiKWt//nC+TlOQaJeUCz3go0jHw3XCLMcjn1H+HsxueMeLb
	G3NiDtzVnJPzZxS50udJMG/nCUInYJCjyDrD10EPzLuedHLgVmuDqVGXMcRIjCvKAbTZ5d8GFO6sV
	CfGTSVkWOWl4hpem13+qBaLBfaHd6SKFDfyIa30uTD2mUXpcND/w8/CKWGtcDSQKYIbUnhz3qP421
	skYrhNJUM83tI+iIt0hdpXY2EBdOC1urFqKrCIilQ+wUohIOvnhUicOA+AWEXiM60c264t6Lg5FMx
	KO2bRzbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rCh00-0057Z9-0D;
	Mon, 11 Dec 2023 14:11:08 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rCgzt-0057W5-0L
	for linux-nvme@bombadil.infradead.org;
	Mon, 11 Dec 2023 14:11:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=e740SlBEmf/ZhQNLA0SQkpomWd
	s8vPtaMfx0LUKGaUbwMoH1hGKujnKJmhHS6PYq1/sxz4oh3ld+/+TdUosjyG6YMnv7YFxa4aOBrB5
	Xz3eWIT4hchQo3xxSID02ny/HW1PhISKHDD/aQ5ID1h3LD/Qjg1DuFVl77jTlIuE5X9zqcgclenOm
	/TOt1hD3sWc+1S/zrggY8ReuE04HeWJi6bcppBsjJswiw5lWYXh/xAoDwlT2Qrz90L+Hv6Ana+rzs
	kbh6JMx6Hnw87ma0FyiMtRR4ArvCs9TZfAKJVZnr4xa52wPYoLh56J0c0po+lAExDXly5RPJs2G/c
	kXN7V7QA==;
Received: from mail-ej1-f44.google.com ([209.85.218.44])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rCgzo-0086uC-26
	for linux-nvme@lists.infradead.org;
	Mon, 11 Dec 2023 14:11:00 +0000
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a1c6c8d2ecdso109417366b.0
        for <linux-nvme@lists.infradead.org>; Mon, 11 Dec 2023 06:10:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702303852; x=1702908652;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=sLikxH+/lGeox1WmYaMYRyigFHF2J1Pw0fy+uwzIj8ySoXsw8/gd4CntSNnq5fkHjJ
         OYqEyEFrvHNGYi2Sg/Ki0cWAkFaReSYH/dIdY2upwJ8nKSkX8pHVWhkgE8Y/xxgpuQUs
         Jff+UnWxpzYZ/bWJTrH1H/m2c+/DzdOTInNcfRl+jlin1GhH6hIwGwNIpMPeGuwbrgUB
         NWrUIoz/eBCFSJlzGRB+tpW+2/hJN/mDIyeQefEpVGgapgi+zh+dKHNa2OoEDH3B4Ue/
         Pa10PPDJePS6ZO7yEq1OlLcmNpibItu+FkQ/1fZXZvNIbecGnp5AFfrGjY84erNPc3AE
         Vbsw==
X-Gm-Message-State: AOJu0YwN8s3n3ZuPghYEYTpw/ESkOhmZ081JfZ4zm40vg4R3XCrr0bTf
	VCUq+HL/wISwWiW7+2EjspM=
X-Google-Smtp-Source: AGHT+IGk0Zdc5hNw2VZ8AUU4r1X/2kuerrAVLGHD2LxgWEzWJvS6mqyVytrp6y1HvLmhML40QsKFzQ==
X-Received: by 2002:a17:907:d384:b0:a1c:897e:fd9b with SMTP id vh4-20020a170907d38400b00a1c897efd9bmr5163559ejc.6.1702303852482;
        Mon, 11 Dec 2023 06:10:52 -0800 (PST)
Received: from [10.100.102.14] (46-117-87-214.bb.netvision.net.il. [46.117.87.214])
        by smtp.gmail.com with ESMTPSA id ss27-20020a170907c01b00b00a1d9afe42f0sm4865920ejc.35.2023.12.11.06.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 06:10:51 -0800 (PST)
Message-ID: <bd367ba4-0e2e-4e7a-81c6-695fc18607f1@grimberg.me>
Date: Mon, 11 Dec 2023 16:10:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvmet-tcp: avoid circular locking dependency on
 install_queue()
To: hare@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20231208125321.165819-1-hare@kernel.org>
 <20231208125321.165819-2-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231208125321.165819-2-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231211_141056_776881_69C1BEEE 
X-CRM114-Status: UNSURE (   5.37  )
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

