Return-Path: <SRS0=7pRJ=KP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AC7C433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 20 May 2021 22:40:16 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87C74613AC
	for <linux-nvme@archiver.kernel.org>; Thu, 20 May 2021 22:40:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87C74613AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=APadBOhaFtywjMWdIRPLwRaohE
	OQtCQzA4QK+K5Bl1Yka+v8xA9hlW17HydECczugKAl4zmNxzH6ipS9RrzRNUYVl9Spjv475trpItz
	Rw0z1TckSdky2wNPSlU4cQqdSP6pXfbMOzu8Zg6W2X/MYMxaJreCyDcOPUX0RCFPgnCC9a+kmFa1g
	ycshzoOlep4yzF0tmPhCUvsTYAzycylwpVMICHLNniL28ohSTJyOnC4KnDG12UN0DapMThFsMPuhn
	ycKeJ5nLktIBgjbmTCVKKl42AebwVW92c4z8Boyko/tNQ0knABzajLpwIrfu/eLhRYsqcfgwfTVQL
	hwNfUdug==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ljrKf-002vxa-D8; Thu, 20 May 2021 22:39:57 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ljrKb-002vwY-7r
 for linux-nvme@desiato.infradead.org; Thu, 20 May 2021 22:39:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=AWsWg0KuBuV7qNhCcyt0jl7xzX
 5Wf3UbGaLSNMblPmYbmHZayPaZGf514+3E9S+cyMYc6RL4hF9giDyTQ59Hr9lDXsVTNPPzbGd87vQ
 IjC6ydpI9edGi/ozlB74Y/44NAgFUdHiqw4HRD5nSJqVF0fmtFjNsda9HeRhoDBtfmppp1PlDrrf/
 FSdkp98wCnQgu6LSQ9WBTduzqe9/kAbCLk0r8EuZj/AnlEOu0KBl38QTQ+PNFHLMY3m2AfMYxmCxM
 WlOnkw0y7IdujIEocsNFWOj/0Fa2ZSZSjpoI8KWw1xSRIkHnXfY1/yisJqR8sLzrF8vPTm3Xc/nRt
 mlv5ht6g==;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljrKY-00Gh9s-J0
 for linux-nvme@lists.infradead.org; Thu, 20 May 2021 22:39:51 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 l11-20020a05600c4f0bb029017a7cd488f5so3463091wmq.0
 for <linux-nvme@lists.infradead.org>; Thu, 20 May 2021 15:39:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=m+lmWuSBLda+tUHPHBswCI7qjKgbLM11uq0N7oxkWGegwJuL1XIzWbSnVd1f+sBAcQ
 iqgpWnxsf10dRDF1hPNW1lmJOWoI/h0jY9PTcJtZPctQtk7AOD09nEMmymq8reNx5xqj
 VqQCrDzOT38RMu2ijQxDBVf06fzPTQsucPnQ2jPkh0rg3oRr3yJgJNlvmZAYmTH2kGfJ
 0LUHjJX1FMfSxSOijGRyA1gF7AjggwkSu3y0qsj2cvf3dSKgDVQ6WjOqp4FRhr/IJKtS
 KMI+pYxftXxW0fUtOUfXZVaYWQJYoKcrLp43BLLfbQE7sIZyXUdXSfz9nD6Pdxs4S2t5
 4QaA==
X-Gm-Message-State: AOAM530OX0MUylI+FV+FTtDdbLtZxwkR1C0opRE3quuHrkdPnb1JhSqo
 0kHqDxl+IShSrzWAK2+rIok=
X-Google-Smtp-Source: ABdhPJx6lTfYJVot6/e7GV1ch+GbvNs4T+1mEHxcW06nzYbBSeRRP98mwVc6rO03anmngJstejqvUg==
X-Received: by 2002:a05:600c:b58:: with SMTP id
 k24mr5970445wmr.155.1621550389008; 
 Thu, 20 May 2021 15:39:49 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:1349:5b78:fe05:c9c1?
 ([2601:647:4802:9070:1349:5b78:fe05:c9c1])
 by smtp.gmail.com with ESMTPSA id r1sm4491952wrt.67.2021.05.20.15.39.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 May 2021 15:39:48 -0700 (PDT)
Subject: Re: [PATCH 1/2] nvmet-tcp: fix inline data size comparison in
 nvmet_tcp_queue_response
To: Hou Pu <houpu.main@gmail.com>, hch@lst.de, chaitanya.kulkarni@wdc.com
Cc: linux-nvme@lists.infradead.org, larrystevenwise@gmail.com,
 maxg@mellanox.com, elad.grupi@dell.com
References: <20210520113046.27821-1-houpu.main@gmail.com>
 <20210520113046.27821-2-houpu.main@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <89265081-d16a-27fc-bf70-a39e3609859d@grimberg.me>
Date: Thu, 20 May 2021 15:39:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210520113046.27821-2-houpu.main@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210520_153950_651484_3E79F797 
X-CRM114-Status: UNSURE (   8.87  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
