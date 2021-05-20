Return-Path: <SRS0=7pRJ=KP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E65C433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 20 May 2021 22:37:21 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12EFB6121E
	for <linux-nvme@archiver.kernel.org>; Thu, 20 May 2021 22:37:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12EFB6121E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+o2OJu0eDnKZeu96PiWavyYA9QrAj7ReF8Nmj1jSya0=; b=PCOPEKhot2LiU6zI6IA/naF4eq
	Ojso/DSg8OmYXH3DQLss8lJGXZK3aISVjAH5aKLfzabyWVbmlUEZPW8iUss7ldZaV6jyYIKf+1YWQ
	h5R4ywtv4pXCicfIOMbfbVQtmbI+k8/Wri37E9PNe92FPYY+l9JCgXnpC3zO658+8c+JMExZA0Oqu
	kuvCsSqwmgIIK7A/cFV2hEMwfrQeTeeCcYC5TO3Y08f3m0SFqUr/Agtiw4snKviJ5CYl5m36xSzWR
	vDc1AqzQeCgXfbl1ecwrda/6k9ByYcvpRGX+T9KdBCtF4fwyKPZQaC/tX1CWDQPQJb1+w2rX3Rogb
	jyYrmTOg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ljrHc-002vDF-Dh; Thu, 20 May 2021 22:36:48 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ljrHX-002vA5-R3
 for linux-nvme@desiato.infradead.org; Thu, 20 May 2021 22:36:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=VVjPXtU1mwrOFlxfed6IPmDk5Kt2isQEwgCM7ryzQO8=; b=BWANzNF1pH722PAfBMeO0ySlD8
 I25BFH6AbmF2skhFFxoZbXLNLDlFvrxS2q/3eTrSk5k/G+QG/NgR/mhP/Ll5Fhs8MRfRSZou7EKdc
 BwKz98Ti4BY/D8+eIchfuMujVDbHJrSNruRvkzggLBT3jk/gZRWvSIsNprSJxDrHx8CFJrpYodtSI
 Fd3h/WmNg2ESdKH8f5UoIoE8c6SHZESt5hnBqNKB5ETnRxj3Q4MyA7DLNBtGtTuKujeKSllmIrGLJ
 NwyVEDPllf9ABzbK0sRiCpDllpZzTKuspE98buSevOeykLoUbs8p3NQrilrNza1ZTzYj/ay8ECgR0
 Kvahf7ZQ==;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljrHV-00Gh4p-BJ
 for linux-nvme@lists.infradead.org; Thu, 20 May 2021 22:36:42 +0000
Received: by mail-wr1-f48.google.com with SMTP id d11so19138277wrw.8
 for <linux-nvme@lists.infradead.org>; Thu, 20 May 2021 15:36:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VVjPXtU1mwrOFlxfed6IPmDk5Kt2isQEwgCM7ryzQO8=;
 b=UyHKFWHLUP+kGiSBjRXfgJ4R6lWHp5jX7v5fbmV4b2aYteQ3zYAszBtH26p+okLuoo
 kJwcDosHvWjXb8aYFAcF/5EIuELXFIqB6MUZqBJcxEkqW/a7JPvMMPdMUUs06S26D0Nb
 djbsBBKjuZyg7C3nDAIhIMwH67neKmSRuVmi39aPP1XmCcADFpbqS9lvvRwCwfzWjLhq
 THsUntEvHM/7N4mq4ZHSlGhmZKbj5GW5cdznepyPR5f0dxmfTNmYi0S7sd1SQyEnMOcy
 ziGJbrvMwUFGQ/ova8rbSP5AJODSvDeN+N5CQ74NTAkk/VmQR+48yLF9AT8br4gpA9fY
 TEVg==
X-Gm-Message-State: AOAM533oSWdqI7SFSqbLya9YKR4rF6TXVGNKyICuzEhpbjrTJzv+61D/
 b6aLwmvQDHBphK/+8rO7WBWGkLHOEeI=
X-Google-Smtp-Source: ABdhPJwDm42K5WnIJpF6oA2W8RrAbHeaCCue/gT9oh0k9KjFuQa44jEwaI4iF02iIBU8Ao/r4o8SdQ==
X-Received: by 2002:adf:e50c:: with SMTP id j12mr6338948wrm.418.1621550199536; 
 Thu, 20 May 2021 15:36:39 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:1349:5b78:fe05:c9c1?
 ([2601:647:4802:9070:1349:5b78:fe05:c9c1])
 by smtp.gmail.com with ESMTPSA id n6sm3702008wmq.34.2021.05.20.15.36.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 May 2021 15:36:39 -0700 (PDT)
Subject: Re: misc nvme ioctl cleanups
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Minwoo Im <minwoo.im.dev@gmail.com>, linux-nvme@lists.infradead.org
References: <20210520054426.567241-1-hch@lst.de>
 <20210520153802.GA2937281@dhcp-10-100-145-180.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <521ff2c9-f4f9-6f9e-3150-a5159aedacf3@grimberg.me>
Date: Thu, 20 May 2021 15:36:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210520153802.GA2937281@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210520_153641_413160_25C69D29 
X-CRM114-Status: UNSURE (   8.67  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Me too,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
