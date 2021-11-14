Return-Path: <SRS0=Lvqr=QB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5469AC433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Nov 2021 10:32:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B42360F70
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Nov 2021 10:32:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1B42360F70
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=wK47DhJFqPNHpzWvFSBUABnDLl
	BQ6TkmRjhDh9piPT8t55z+dZw0xrNC68KArBNErcsn79PztoNyfb+zIYGc787Wf66WIwPCrg2fgYV
	pJdlfrQL3Ym1NWzd/w86qImLULo8D3blgNKaRC/NfqWqNik+t9wZMbSv7KsJ0M8/L5Cxo296iLZMC
	caw1jV/+Pkr55x35g3lLzM7NdPCVJ/ugj+6OGXCjEeSTIe5n7HeszlRJx/pI4CSXnP8BiOdXHLaAv
	H2oPWjIs2poSu+7yu9dQH5hwPRg4oYF5JjcwW2xAs4HTYuWvdfhi4XV3tQctTHUcSOseDCQ2eCmje
	55fsxHZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mmCnz-00DWl5-Vi; Sun, 14 Nov 2021 10:32:12 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mmCnx-00DWkY-GU
 for linux-nvme@lists.infradead.org; Sun, 14 Nov 2021 10:32:10 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 az33-20020a05600c602100b00333472fef04so12608202wmb.5
 for <linux-nvme@lists.infradead.org>; Sun, 14 Nov 2021 02:32:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=YLqA5CtFnFFqkglJzL89ktCNJKcceRYmMr3CnfokoswlhhyjgJffgk7pTHAgL3HObF
 aZw0RvyTi3WPX6J2Lt1jKkvSMb5essO58LERzWuJT9CpOuRCIpTbjF82k2/4jqKsn294
 zznAfitQbogvzNkvWAiTEIhpp0Igj+xCflIKnSD9b9KVtOZXe4Ab7ebSJ8mELgCis9cw
 d9umocX6h00BnoE4wLRdm+B6HLozIv2yOgnoKFlGizck6MquqXUuq12jGyh3VhvhHlgB
 evyzpq1HVLARTDSsXeWdqaOLPqeS6Rm5Pp6yXHJDZqU/NvKoNM9ohjpy6QcO+j9fOlOL
 /pBQ==
X-Gm-Message-State: AOAM530aOmY9zlzVClsXCXrTPod11xPliA1XBrJYARCcoev7H3ku0cQ8
 RfZm6elLL+CdYMLvFa9ZK7M=
X-Google-Smtp-Source: ABdhPJwN4m01elLifnez573yRzd+3sUbyTV7Q7ttPk1/d9rvO4JI0zsWz2n9O8d6nGHUtdof+wVt/g==
X-Received: by 2002:a05:600c:4e91:: with SMTP id
 f17mr33524278wmq.195.1636885927984; 
 Sun, 14 Nov 2021 02:32:07 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id t8sm13057651wmq.32.2021.11.14.02.32.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Nov 2021 02:32:07 -0800 (PST)
Subject: Re: [PATCH] nvme-host: prevent nvme-cli from setting invalid
 fast_io_fail_tmo values
To: Maurizio Lombardi <mlombard@redhat.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org
References: <20211112141612.201297-1-mlombard@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2efc72f8-f624-2c0c-5390-86df06f8751d@grimberg.me>
Date: Sun, 14 Nov 2021 12:32:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211112141612.201297-1-mlombard@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211114_023209_585070_89CA6037 
X-CRM114-Status: UNSURE (   7.76  )
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

