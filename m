Return-Path: <SRS0=MITl=OJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CF8C433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Sep 2021 14:06:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 765D060FF2
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Sep 2021 14:06:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 765D060FF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Dx74MkwuDuF1jvIN391QWNV+RlUulZCHEbtz+p2UDuw=; b=SmSaT+IDlpgn/9Uum0cutRkGVT
	weMK+6zkNAuyXht0JI3GRIxuJfCj5OF1K4MAzw7cJ9QZRr5Ox2GQBYXmahn852mulQFkbQVXaxRfP
	uYFzMF59HvtyVraqDza1Ofb+6nX/4TRQlQAIDVHSqrUPVeLARkHnT12PPnyvpvfsYY18R0x1R+eBF
	uU7Mo2Fe56Drcdld1HgfzSdwhbeoMA9JWqWge7otWaimdRV9684Po3vOezYwt7YnhcFLM3MYnD2s5
	ih6pA6eY3QuoJT9sTXQHVmF1ZCFQg6XHSslGojlu6sYSPQ1xPw+NMts31pvbcV+A6ONR6epYBGJ12
	t1pXbxyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mRxS2-00HOOf-MM; Sun, 19 Sep 2021 14:05:50 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mRxRz-00HOOF-8P
 for linux-nvme@lists.infradead.org; Sun, 19 Sep 2021 14:05:48 +0000
Received: by mail-wm1-f43.google.com with SMTP id 140so11100916wma.0
 for <linux-nvme@lists.infradead.org>; Sun, 19 Sep 2021 07:05:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=khZ1gp0podNVgaw/YKgLQm3PIjqOC5aasDptwlPkZhs=;
 b=BG24Yqm3SVUAVcuXqmYJxPPC3scnLl2gD6HD+TbXjBTbTCConGk39N/duJryTarowj
 29i5xxpsl9qOxQa9mc+qjVVpaoVMg6ay0HgKXxW6M/jk/OhXmj4Iy+l0SuKZL7UvpYx3
 VsZ6zQ5EPu6TdaqE+dNVxTd/WtYfDLsZgjec4rh2e8YIYbRmTwAo0NtmcpOe7MPmFyPp
 GK1F+2X64ubvOXgLp8k5XTb+ATYYcAdZazTmVI+RrHvnED1lz3oodxFAnMXB5rKF86Wk
 7B3KfkuQCcriO9URLuvuum9tRC5j0x3ATyANepqt7uYV8c0BO9FfsFTP7G2A9aa0pUqQ
 uoZw==
X-Gm-Message-State: AOAM532+Nb9zGg5JJb1HgI45UBJslzsGz3/z1J9DhHKAThyHdrzQxcFj
 lp5bIwzjsB+VfBNuamAHmWs=
X-Google-Smtp-Source: ABdhPJxivPbx22GUPOnZ+Dn7HqMibFM4sRtTJfrTzwwzqLQeQTaV0wEVyjlNoAZlkphl8BJ4vQNdSg==
X-Received: by 2002:a7b:cc96:: with SMTP id p22mr20048519wma.83.1632060345686; 
 Sun, 19 Sep 2021 07:05:45 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id d9sm16192667wrb.36.2021.09.19.07.05.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Sep 2021 07:05:45 -0700 (PDT)
Subject: Re: [PATCH nvme-cli 0/2] add "State" field in command "nvme list"
To: chengjike <chengjike.cheng@huawei.com>, kbusch@kernel.org,
 linux-nvme@lists.infradead.org
Cc: sunao.sun@huawei.com, jiangtao62@huawei.com
References: <20210915132912.3004-1-chengjike.cheng@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <efc0a9d9-0ebd-e90b-faf0-3ee8c53d4f98@grimberg.me>
Date: Sun, 19 Sep 2021 17:05:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210915132912.3004-1-chengjike.cheng@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210919_070547_356736_6EB7E170 
X-CRM114-Status: GOOD (  16.79  )
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


> When NVMe Subsystem is connected with one or more controllers via fabric, such as NVMe-oF over RDMA,
> if some links are down, some nvme disks on the host are faulty and they won't be deleted immediately.
> But the "nvme list" command does not show these faulty disks.
> So add "State" field  in command "nvme list", and display the status of each disk for users.
> For example:
> [root@localhost nvme-cli]# nvme list
> Node        SN                   Model         Namespace Usage                    Format           FW Rev   Status
> ----------- -------------------- ------------- --------- ------------------------ ---------------- -------- --------
> nvme0n2     25658552656655456265 Huawei-XSG1   2         2.83  GB /  10.74  GB    512   B +  0 B   1000001  live
> nvme0n1     25658552656655456265 Huawei-XSG1   1         2.78  GB /  10.74  GB    512   B +  0 B   1000001  faulty
> [root@localhost nvme-cli]#

State is too generic, Maybe "Path Access" or something?
The point here is to provide general feedback for the user to go and
look in nvme list-subsys?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
