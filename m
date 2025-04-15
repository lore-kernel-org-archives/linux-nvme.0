Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C641C369AB
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Apr 2025 21:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3ilcKjopp3Ixsk38sKct1Un6j+cqQNHWSl5QguoU7UI=; b=bwhLgQg+cq3DXxvSUuRtz2QOK+
	56UtYqxiUjOF+iwrP2Bwk9m0/rZCtqNkX/g1wlbYBzNYYLQPS8bNJozNE3vMUWOFTYZbeMF6r2ghw
	HVVATswDky8nAEr/7Q6WQOGujFZn96Psqwze8+XigPheaJqESVTDtOI3hiSzQyiUGB7h9+uIT/aJC
	sndToBYYu1xY0gh9gO2sHVkkXyDvmD1nGKl56tRw0kS/YUrobIcOwOuR4btN9AdSBtQuaRWr3lxQZ
	izvSCvH2bloAXZAA+lTRZLGe9A6ZiKDN/YBigCB2JddoYXGa0O+ZQS4V0FTAhfHcVfB0gB39gof0k
	SrVqvvOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4nwd-00000007Cwe-0774;
	Tue, 15 Apr 2025 21:35:51 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4nwa-00000007Cuy-2b6o
	for linux-nvme@lists.infradead.org;
	Tue, 15 Apr 2025 21:35:49 +0000
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-39c1ef4acf2so3919558f8f.0
        for <linux-nvme@lists.infradead.org>; Tue, 15 Apr 2025 14:35:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744752947; x=1745357747;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ilcKjopp3Ixsk38sKct1Un6j+cqQNHWSl5QguoU7UI=;
        b=q11gzupTPuCEX3G7odFQYz35X2xJvtl+LreKxVdA39ima7Dytkh+Vr6g01k0k1IY5p
         2r/M3K3C3E9RDpu8sIRGqiuvMPF6Y8NnXeAV0Mv8nm6ovZLdD/3abR1ZEFE8e4yUIBX5
         SsHy9Z9da1DHNrGDjp+tQ+Ru/V1z7VY9lASIC7pIjzCnE3lYcP6JYvf/xUnpPXG+eMzF
         dyK9JWmgQerN2RCObYEEJ58E4XBwDzCaID+ln5xkSbcg4T4xZqnAi1elE048HwLT65YH
         7GnSVFFH2idhdBLAL0eyswvXFxai8Bs3UAVaRN8hFnWlHHTJjznETnoxOKCB19c8RAFE
         3y9w==
X-Forwarded-Encrypted: i=1; AJvYcCV06CdGMJpEU9sABYnkyPwVPzfgiSZPIB1gaUfjyD2/GKq59naAA9KIYwqZV84wUkQ3qeZaSqvW1qd5@lists.infradead.org
X-Gm-Message-State: AOJu0YxhmnrXhBH+pjfx8qcVYG0sHQVzy0c5N6kiQTZZbUNYnmkmXi9x
	WKDbOhxsGeCFGLxBlFM9/gW/YSnejS0Hp4zAMT+Ak0xEmiiVdbQ7fUCMjg==
X-Gm-Gg: ASbGncvP/7aiXASwL1v/I+Oee1icCXYPWQhcgjWWfycHnfB7wZW7DW58v5tKgzyqVdq
	1Dsf1VDXw2oZeMp40RlJmJAjlEiq7puffpn1cZL/d+5O9UT2tqzAZ8XRCsqtyPX+35FFfAHSpM/
	oo3XaTs4R9nNfkaO+W7uW69Es+rSexmG0vxwPy9BVARntTWpmChTdpB2skO6H9M7HEoJF9VN/av
	1BXUN+j+3UmfAOMJqamoJR4397DfNKL3YG4qMpgUv13ZeLtcyJNobTHUF66rv7sjIKSkj6j5W+5
	/N8dTMhRgL3MsiNd/bVm3vknSg4/hNAZqHJSoDnvtj33UsGfcj6w2z/wT1nkm0aHT/BYfiM3
X-Google-Smtp-Source: AGHT+IHLRlC0XZr4mrgM3PV9EuSPFg+EOMo5Meoyfge+AY7eep/eZaW5wtxDKQOXW3K+cJ5KKqMDTA==
X-Received: by 2002:a5d:64e3:0:b0:397:8ef9:a143 with SMTP id ffacd0b85a97d-39ee2737cbfmr858811f8f.23.1744752946996;
        Tue, 15 Apr 2025 14:35:46 -0700 (PDT)
Received: from [10.10.9.121] (u-1j-178-175-199.4bone.mynet.it. [178.175.199.47])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf43cc7esm15339292f8f.77.2025.04.15.14.35.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 14:35:46 -0700 (PDT)
Message-ID: <12b52f15-c070-4d0a-8757-f28eb48fc300@grimberg.me>
Date: Wed, 16 Apr 2025 00:35:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] nvme-multipath: sysfs links may not be created for
 devices
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Nilay Shroff <nilay@linux.ibm.com>
References: <20250415064737.80953-1-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250415064737.80953-1-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250415_143548_652683_58362443 
X-CRM114-Status: UNSURE (   5.03  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>**

