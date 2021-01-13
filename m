Return-Path: <SRS0=mLmp=GQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064C8C433E6
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 23:22:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 783752339F
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 23:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 783752339F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kbyy9dRKU+tI1tLH4Yqbf42Lv4hLnWBNik23+OUUTH0=; b=i/Stw07j72ZF8sdwnlSDk4Aj+
	hfvDBAV+rjdfTdP8rQeTbzNka00iZo2hzoz5JvjtY3VSnZdU7T2+2dmoOfAJsdKl34bHGjpnK/7px
	dfcsWK7ZdojzaNvVbfFZq6yaHMp5D280nGKZfR3Bi2Xz+D7x1pkKLA56+LxorLaoeoBFXS5ryxsXU
	Aq5TDR+qIc+JNObIxnrG+6DoZZLfqQw5JGIWnES6hd86Rnv2rFdItI4JAN6c8MtuTMuIPHI7zc19z
	N7+LufPsTZ5hXwnZxDnznP+Cdf+pOctWszLJE0MdPoz7JOgiQxXVnj/1Ugs7Y6U7pwJiNovdJaTBZ
	ETRjUKbzA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzpT1-0000Xv-U9; Wed, 13 Jan 2021 23:22:19 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzpSx-0000XS-86
 for linux-nvme@lists.infradead.org; Wed, 13 Jan 2021 23:22:16 +0000
Received: by mail-wr1-f48.google.com with SMTP id y17so3861065wrr.10
 for <linux-nvme@lists.infradead.org>; Wed, 13 Jan 2021 15:22:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EAD1NNiUKRbW2AuIhdlRBYCSNPU8MCggmuQy96n9Jb0=;
 b=buR1cre92Fx1pbTeeS2GgevYHf+68nA33sbrjmM/PcDMr71fJjn14Ud+TK6jobTOf/
 XIb2gRCAQjWsTFSTeXM4MIq9Q+tnqIyPrPFkcqCKl8j9Fi0Lx8CTsZGLmDx2fu6MMlb0
 dtc4jEPnjmQ3Xnlo09kpSntcfKw5ihv5j2XeCTrDrOrB2Juae4uOfW3hQnHilougTAco
 F9bJSr6jsXbNKCLXpdRpCqdvDpyUyJB+DJcxGCtwCN0weBdMBZEJmZqtMEi7DAb69C6o
 VUbFUUHjdAfurtt+q433VwxdGCFw9viPjqgVDTHk7BZQx47mO58M5M+OHYehEIlHqepO
 wN2g==
X-Gm-Message-State: AOAM532dHdOrUJz17/Zc+F4v0IEt4j/c2RJKY6sW/a4BFeLQb7g95/HT
 vedUYwBl1wEd9TSkB5A+pFw=
X-Google-Smtp-Source: ABdhPJysQfHW26lKHesiaDvlg+jg4inhhnt6xh4OAgIk5Zg5N73fpIXXwK/9vc0Swuyhz3ujYBtXvg==
X-Received: by 2002:adf:fdcb:: with SMTP id i11mr4873023wrs.349.1610580133713; 
 Wed, 13 Jan 2021 15:22:13 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:e70c:620a:4d8a:b988?
 ([2601:647:4802:9070:e70c:620a:4d8a:b988])
 by smtp.gmail.com with ESMTPSA id a25sm4872002wmb.25.2021.01.13.15.22.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Jan 2021 15:22:13 -0800 (PST)
Subject: Re: [PATCH] nvmet-rdma: Fix NULL deref when setting pi_enable and
 traddr INADDR_ANY
To: Israel Rukshin <israelr@nvidia.com>,
 Linux-nvme <linux-nvme@lists.infradead.org>
References: <1610280545-57812-1-git-send-email-israelr@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <36e7d294-9738-d2a2-2b56-75788707e260@grimberg.me>
Date: Wed, 13 Jan 2021 15:22:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1610280545-57812-1-git-send-email-israelr@nvidia.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_182215_331044_90BD867B 
X-CRM114-Status: UNSURE (   9.43  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, Nitzan Carmi <nitzanc@nvidia.com>,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

FWIW,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
