Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC1EC6FD1C
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 08:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=NwBqAi2g8tKJId6ZvMD3z4DBtF
	5baHcfIMl+wOaK+d5IPPwJ+/nY3hkFYUchSA5RHaZ2poAKNywne0kpKNX40ay9a5Ov6f1Rv78QM7K
	2c/6MmD7Ui6GQ+TGdvvIrijZUgT3Ga4ZcfNYfn0bdKXXTKw8x2xVhMEY2ODrFrmn1TV+tdINiPCyv
	ZIOGO8k7fG6gYiUJhxprofwkg1bRuMa+AbJyis9sR6u7Tu9lWNmuuTkpm51tnLLFXzVRer7rFsIqH
	GF78A3m801EPrYNX4Rhnn/wwclU+kCgbJ7OOtZjEoc6T1/RfmzZTxnMVfbuNnsQTPMQehD9mW+yJa
	2ceurRvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1petgW-00F8yf-0g;
	Wed, 22 Mar 2023 08:19:04 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1petgU-00F8xv-1o
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 08:19:03 +0000
Received: by mail-wr1-f51.google.com with SMTP id y14so16085015wrq.4
        for <linux-nvme@lists.infradead.org>; Wed, 22 Mar 2023 01:19:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679473139; x=1682065139;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=bwcq+pjLzcbgepimmJvhhsyvcEv6FtY79LqwrceEE0wI2Ow385PkfGlWR1yUs4UOij
         ERYa7HSBtR714QLauLKI/oVq8b8WpzXh+/l+xNaTp/k9wi5dC3TX9QZRFzvIZkGKwj2H
         GslqAlV6age2wUFhMfMObbxL159EjO4NJhCc82gtheGMEfGQinkfjASINjTnN/eKGnlT
         zWuK/H76fbQutvxPwEAF8/Nd0pYGKcdFKChMDD/SueR1iS75/wNZLuv/7+7C6DQSg7Rr
         HOuUOtidTUzRECHERjYUOssV2R3aJsimFDzYdrARdOP3BFh1JOgoKd0z3AM7kO5K3UWX
         qj2Q==
X-Gm-Message-State: AO0yUKWoXDRMwtN1GLyX6lPv8GivzOJJJF4yh/pGMGf9Ne5nb9EVKbWX
	YnXBBcjbV/ascZ7b0co2/PU=
X-Google-Smtp-Source: AK7set+zO2AVMCbFZMbULBnM+hjOZ8HOMXZ8ZSmBzgnfEDJHfxP6o4/TJQDaiDMieSbhaytlJwA5bg==
X-Received: by 2002:a5d:4586:0:b0:2cf:e5b8:2ca9 with SMTP id p6-20020a5d4586000000b002cfe5b82ca9mr3397228wrq.3.1679473139552;
        Wed, 22 Mar 2023 01:18:59 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id b15-20020adfe30f000000b002c706c754fesm13265082wrj.32.2023.03.22.01.18.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 01:18:59 -0700 (PDT)
Message-ID: <5469103c-cf73-a6b4-a704-d3160a8b8d8e@grimberg.me>
Date: Wed, 22 Mar 2023 10:18:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 04/18] nvme-tcp: add definitions for TLS cipher suites
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <cel@kernel.org>, kernel-tls-handshake@lists.linux.dev
References: <20230321124325.77385-1-hare@suse.de>
 <20230321124325.77385-5-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230321124325.77385-5-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_011902_596046_406B6E17 
X-CRM114-Status: UNSURE (   7.08  )
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

