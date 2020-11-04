Return-Path: <SRS0=H+rW=EL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50598C00A89
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2020 05:04:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB8EB2083B
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2020 05:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NsD7ND6m";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Za3C6X8D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB8EB2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=NsD7ND6mPxJXYsG5Y9N/JTmOp
	wohQ3wU4lhGnnzZ0PCcLmm0xje2KXJ+8U+6q87KXwbmv0V2Fx4IyBtvP4xvfouxtY/AixFt9kzAbn
	aZuTp1H0h9hqs4BtmZgbEdEzNn3WwZtMDAY4LiCSHhDkBOF5/kZFpfF9E/vWbsHggLIgdQpaN9G80
	2KBYGr22WS95f3vemt9/IVnRA0c1b3Whd7vFyFgs8YNwHQPpbkOww37GjJnpZmlm3VN/NI5zfgInC
	+r5txFaotW0qCedpEkRQ6zWV+KumfHTjCS6ahGc4tb3a2K4qrHTF0mfuNWP8ZAR1l0qlllXSDI/br
	PhEC+Swgg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kaXRf-0004SQ-Sl; Thu, 05 Nov 2020 05:04:23 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kaW6k-000145-Id
 for linux-nvme@merlin.infradead.org; Thu, 05 Nov 2020 03:38:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=Za3C6X8DfsNioHLJi2lxoQQsBk
 xwkLYFA81Ad4LPhjqb1mDHx9yFKeW+PYs94L/xd8XnUct89lNk4OoOZZuLSQmf/QgzYl00fI1wmgF
 53RhoSSy5PyjlHTiAHpGYBUWqRR+MEsqFoqrphtMw+Bd1RxEJuLZ+jfGcWsp8eOPA2s08piV04F5y
 jerD62Cgf1E5JFU0xujugPdQ1BrN+YQwuHCYCWkhMGGHXUlZ61O19pzvP0dwNRQqxVokCZLrmBICC
 zZyLJET1FhwkpLRDI0HfAjcMBDjYcbxu74Dx+X1RZUAR7IkCDA/XAEGhsWvongGNBI3Jlo/7NvZXi
 L2RS2vdw==;
Received: from mail-wr1-f68.google.com ([209.85.221.68])
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kaQyo-0005hA-93
 for linux-nvme@lists.infradead.org; Wed, 04 Nov 2020 22:10:12 +0000
Received: by mail-wr1-f68.google.com with SMTP id b8so156827wrn.0
 for <linux-nvme@lists.infradead.org>; Wed, 04 Nov 2020 14:10:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=aTTKSzFrBhXl0MCrGwTKnAYjwL+sNmjQH3zpkChud/Wz2i0CzyUwYQ5UtQKKnECu9E
 fjlKjeJjV8rGRE9XOWSpvBUcPcR2cJ9i2W1OxZTkMKH1BVDxOvlAPDIBoP4W5qO9I+bi
 mcA70BE20WVNTO3t9P2ybAhbb1LYv0MWX06ysj4QPeOwussPrw6VV0oB7bbzXSMLkneD
 UAZRpZtab7785O1Qvit4hv+OzcW3ztqFsloURkkp4kAS0U61HY5chTz2JpYv+l1ro6T1
 sj+VLXPaUcMZd5fLIli9XEa65vC55YwTsZ0uQDmaQI6Yw59Xk/soRNW7YyBnE9nrQaLe
 S15w==
X-Gm-Message-State: AOAM53001FZctAKuHXMNeoF3qePo0WiuPImO7iqf1IoBCVO/FpDn3KiD
 xsw1GVhx2KOoVAZTUbjBKpcvp1IeGwY=
X-Google-Smtp-Source: ABdhPJzrmidr6Q0f4RS91FvJd878OCrxTcSATjFnRbzg2FV/5OJclQd988r9AOuz3VUVLKrwJszdjg==
X-Received: by 2002:adf:8382:: with SMTP id 2mr92206wre.227.1604527807455;
 Wed, 04 Nov 2020 14:10:07 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:f032:e586:d54c:b9cb?
 ([2601:647:4802:9070:f032:e586:d54c:b9cb])
 by smtp.gmail.com with ESMTPSA id s12sm4003984wmc.6.2020.11.04.14.10.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2020 14:10:06 -0800 (PST)
Subject: Re: [PATCH V6 1/5] nvme: centralize setting req timeout
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20201104203736.62745-1-chaitanya.kulkarni@wdc.com>
 <20201104203736.62745-2-chaitanya.kulkarni@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <9c5f7db1-23a9-d61a-9985-b0f6fa1982e4@grimberg.me>
Date: Wed, 4 Nov 2020 14:10:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201104203736.62745-2-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201104_221010_502356_2766C628 
X-CRM114-Status: UNSURE (   8.32  )
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
Cc: kbusch@kernel.org, hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
