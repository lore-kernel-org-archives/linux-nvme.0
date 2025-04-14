Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F090C369B2
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 22:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=LH14GhqgTfLSgfqisEq4tAN4g6
	YjXkZGluQ1/+Zp+Oyggexrkp03qoPveSkytQ32preVLwb9M7wGxOEGJKxByBjVmm1GwtGkG35T04U
	WLZ6OK3ayTqpgw1EOuizFnzQuhdPJK8kFI2OCqFsaF4cdcatfESm7YLJ8CJjc9KPPNH8DNiR8XjcO
	ij8QboP5e4LlWCz5zyfJeuXcLs6YvCMYd4yqOlE+vNb0ab2x4dZPXk/UChtHJqj3dJGWpW1fSX0t1
	jq/c/mQBSXxtkY7doNJX5FxER6c5vtrVgF1qssvMbPxR/ixsDvO5wjUXKEOMOLtuKPMvW7mII9qBg
	iP7mD+hQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4S1L-00000003hRN-1tIz;
	Mon, 14 Apr 2025 22:11:15 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4S1I-00000003hQh-3Lgs
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 22:11:14 +0000
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39c1efc4577so2497330f8f.0
        for <linux-nvme@lists.infradead.org>; Mon, 14 Apr 2025 15:11:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744668671; x=1745273471;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=kTmx+dqKy0g+Z8bTbx8QSOyAwLh9/7RlmGochOYHaXgpSVy7uKycE9Et9olxQPi7wQ
         0AnjtJ90osxRwl5f0ET4R2VpQf5Nlo8SR3x3MJzQT1i0Imt6VO7RrJbhxiaxc5HDW8m4
         +dsmj0X1GknzvQdg9yOgFWE5o159ZdClw+BOqVFx+6NoTVZex1sKZg2+b/+gSj8F6DtI
         V+Z6pUiodgvWfravnQURWe3cB+7aDvlDRbF5Cm8WAvOHK6+PZFTF0iFAaN2fAMxo1FHy
         pmDrttBbiUQvTQKvG7qJanTcINfobsI1mKVZBvHVzbVPoRiJve6f3MUb4BDIgkaLED5V
         YWNg==
X-Gm-Message-State: AOJu0Yw4UFdJ0wdBxG8znUVo5qdHjreFJILlx/WloGWxV1+3mCOvypu9
	tED1hK/qFKhnFfJVuBjPcLlUxanVNRbWMjYX59Vb13eT1MI1yq34
X-Gm-Gg: ASbGncsp5p/0vX5/xF+2m3h9BgNm9FeW0WbIld2kS7sCkuQh7BPpHQeMkzE7m6VTwZ3
	wiQCNKtC/Y+/XZCKDtB79Cg9six0rHZmcm57E6FhV38J+WZdRfwxdCUfKC5iwbrkAB/CW9tLJd1
	QGhMsZ8V2A7zqMtlcXAka5NR8WbMOkkpwg/QixQyWGXkuCH93RCTolV0+P19qacCi6pgAURsuXF
	kEgkf0nq1rceyzEhdxiGSTA2QiEDb145nxNBJdDJRj+LhfAVlW/83B1MGqNNVp18QKY5rXg8YKD
	R3nvh+OOozQWAONo4krEgNWL0UeGqXgqwFZPlqWlahWnbl8WctJ2UtdT7L18YfZmsx+CzX1n
X-Google-Smtp-Source: AGHT+IFCiTY/l8yOfCw5tgPLcaFmiVl0aCRjtPjcf+Zz6hNuEVn0GZMpZiy+vJzvhsh0z12ZqOmlkw==
X-Received: by 2002:a05:6000:184e:b0:39c:cc7:3c5f with SMTP id ffacd0b85a97d-39eaaecdacemr12156572f8f.45.1744668671022;
        Mon, 14 Apr 2025 15:11:11 -0700 (PDT)
Received: from [10.10.9.121] (u-1j-178-175-199.4bone.mynet.it. [178.175.199.47])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae9640a9sm12253790f8f.10.2025.04.14.15.11.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 15:11:10 -0700 (PDT)
Message-ID: <a3fa6c12-22d8-44da-82fb-ad4e044cfa25@grimberg.me>
Date: Tue, 15 Apr 2025 01:11:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] nvme-loop: Avoid -Wflex-array-member-not-at-end
 warning
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <Z-axRObjXYjIHGQC@kspp>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <Z-axRObjXYjIHGQC@kspp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_151112_828657_3B853ACE 
X-CRM114-Status: UNSURE (   4.75  )
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

