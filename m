Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A26ACC4828D
	for <linux-nvme@archiver.kernel.org>; Sun,  4 Feb 2024 01:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:To:MIME-Version:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=X9z/aWFv3PdK3hv8Ke9sV5dvvroTfXD8OGOZBqAHl8I=; b=Fmf5zJEu5k9l+5EBpusAv1mo+5
	5q3YtdelyecLqnZ61CzSTPI/LX423JinO0H2hMYxvL18qP6U/4E8xDdchSxXjooBo1mRjemjf/kux
	VSFOu69hsIXWvvw34hVT4gNfE88pgwgciY3BzRhG51MdLa4neppeF6FWV/mGZa6PtpmfaC7qh8IMh
	rJGr7AvxTD0le8liH0iTlqVS8REkGUPuzy2yRWSW+CAxkNKiU3wLVxRKMGrRZIsGorwURMoYa3V5I
	Xwa/XTReLintUWffHRfGFgZSw0Ud1zNVzmz88XeGavmLgp1IdBztxVneiMU4Hir9c3UG5o77HPMeO
	qdE3gkhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWQtQ-0000000HTbq-1RAl;
	Sun, 04 Feb 2024 01:01:56 +0000
Received: from mail-pl1-f171.google.com ([209.85.214.171])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWQtK-0000000HTbF-3U9W
	for linux-nvme@lists.infradead.org;
	Sun, 04 Feb 2024 01:01:52 +0000
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d953fa3286so22650945ad.2
        for <linux-nvme@lists.infradead.org>; Sat, 03 Feb 2024 17:01:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707008503; x=1707613303;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X9z/aWFv3PdK3hv8Ke9sV5dvvroTfXD8OGOZBqAHl8I=;
        b=gvs28W5jY3eeFdFct475p/7ATFQWpHfA2OUPEpLq4j4FFL/9zsX1S4RM2recdm6lAO
         J5sxSLbR5V34Leo5fNUNmq20XRY1yrx2v60HWehywVfQKZ/k9YE0yxLhYDWc3GUcjFxJ
         9WZLU6qzGzzrHD6p3fMbHXd7/8ApyP1kbAV4WFctoHCCxf3XHNNOJCKa96OgyYCTCyx8
         2+ad4fuMC8n3/m/TxEB2beLdrp+VG8L2DaX4GQvLLFottzpQKFkriomlUDua/UPyxM+W
         iPTG2NtCoM+4A1ChxaPa/qmmYVxDxpKzvQBDAyl0dnxuOOJZ0BLPf8/YVebtx4vB0f9g
         xj1w==
X-Gm-Message-State: AOJu0Yxv1GcaYM55UkF95Z+NHVoben0GowdTMfdUpKwhbQfimQcWrIkw
	xDwl3kZNZuw7ZCdahGgw+t210KTenXEQ9NxxPYw85o2eEdvPSFZtdgLD7ndF
X-Google-Smtp-Source: AGHT+IHpFcOqv0oqh5p0Igj0/S1MsEqYkxFDzq68TBvCq/zBZdSSnngZ5eY7w1IELcC0EXYolRUxKg==
X-Received: by 2002:a17:902:6b49:b0:1d8:ae30:eddd with SMTP id g9-20020a1709026b4900b001d8ae30edddmr9119886plt.23.1707008503333;
        Sat, 03 Feb 2024 17:01:43 -0800 (PST)
Received: from ?IPV6:2601:647:4d7e:54f3:667:4981:ffa1:7be1? ([2601:647:4d7e:54f3:667:4981:ffa1:7be1])
        by smtp.gmail.com with ESMTPSA id i18-20020a17090320d200b001d6f29c12f7sm3811315plb.135.2024.02.03.17.01.42
        for <linux-nvme@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Feb 2024 17:01:42 -0800 (PST)
Message-ID: <294cb317-22b1-4c03-9b12-b19c55ec3163@acm.org>
Date: Sat, 3 Feb 2024 17:01:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: Bart Van Assche <bvanassche@acm.org>
Subject: NVMe suspend failure
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240203_170150_906283_B1EADDD8 
X-CRM114-Status: UNSURE (   5.28  )
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

Hi,

Even after having added nvme_core.default_ps_max_latency_us=0
pcie_aspm=off to the kernel command line, the following still
appears in dmesg -w output upon suspend of an x86_64 workstation:

[ 2451.640676] nvme nvme0: controller is down; will reset: 
CSTS=0xffffffff, PCI_STATUS=0x10
[ 2451.640690] nvme nvme0: Does your device have a faulty power saving 
mode enabled?
[ 2451.640694] nvme nvme0: Try "nvme_core.default_ps_max_latency_us=0 
pcie_aspm=off" and report a bug

Hence this email. From the nvme id-ctrl output:

mn        : Samsung SSD 970 EVO Plus 500GB
fr        : 2B2QEXM7

Please let me know if you need more information.

Thanks,

Bart.

