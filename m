Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E973BC4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Nov 2022 11:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t6eGUc5h9ulVoiwc+f2bYlw2l/90CJpzRQj97nJYYgQ=; b=1KjNKV46qaEhgOnGRrC7aGAklN
	YvdIK7ILIIU6qPAkWhBCgIwDaqPh4+c5CiBit1xG9O46yxifBMStAlzd0eHkx0ZZZWFmIh5cJYL1C
	8BveFLy2MyUPhmsUSCL+f551VzOgb8eZvVCJfk9AVoVvXA9seyXwKjPhr0yNBEf/1HQPBUF6bzk6p
	/QgaJlw4+rbYEKtolJxsMGepzFt5G+rIO7tNQAVssNGMHd5hFmsGjjHNojXWdwXnioYBLwn7qsY/c
	Od/YY3eBjfx0l3xFjf5lZEvD8Dt33OoWOvmqQk9A69qrr6nksg9ErML6/pptOoNsonpwEPxJp9RBA
	sPDm5J8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1owicR-003vF0-Di; Sun, 20 Nov 2022 11:36:15 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1owicO-003v7u-2g
	for linux-nvme@lists.infradead.org; Sun, 20 Nov 2022 11:36:13 +0000
Received: by mail-wr1-f53.google.com with SMTP id e11so3081107wru.8
        for <linux-nvme@lists.infradead.org>; Sun, 20 Nov 2022 03:36:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t6eGUc5h9ulVoiwc+f2bYlw2l/90CJpzRQj97nJYYgQ=;
        b=D+/7/fDT2NvSpOjtFjqPnvX8L4us3cUBTVM0V2ca3kyEQMB//CQFoBUDK9MkQTGPb8
         q0+qbWP4bfvrJKJfT4TsC8OB+HMEfWBavy3h84FK4YLB/hkvIKANtF8QvhzPZNPWweCt
         3B6LkzHew1T8oLShDmahiGiBdxmVdI1ljrMD/wiEavwibD9cBdWxWJ9ZCrvF3R9pTGg8
         dKmWxBEci5HGlr/X4iBKLf00y7NfKeuSixuxP26lo3I3jatCzaE/IUHZprJbnWBkQHLN
         6CcRnAlpL8qVGVZPtYN9VODxdb0fyyqe8+d3W8aGjYQjgIIPnCzLWX0nF3vNWysWH9ib
         49CQ==
X-Gm-Message-State: ANoB5pnjV6db+/GMAT6GV0E+m60+hBVpP9ivVhUeAS3WsFWXNG0wTvDl
	VPnX4aztkrvd5KxUyLawhsU=
X-Google-Smtp-Source: AA0mqf78KzSoj5L2InVsPBxNNSQbNyc9O0ADgxgQLcG/4Fro13vKHfr/8gKgXzjpnIZ2GoN3O/c0jQ==
X-Received: by 2002:a5d:6dd1:0:b0:236:75a8:58d with SMTP id d17-20020a5d6dd1000000b0023675a8058dmr8697345wrz.295.1668944170010;
        Sun, 20 Nov 2022 03:36:10 -0800 (PST)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id a5-20020adfe5c5000000b00241bc209ae0sm8123901wrn.32.2022.11.20.03.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Nov 2022 03:36:09 -0800 (PST)
Message-ID: <f6c2e855-ae4a-1dd4-5de2-b6a5f64406cb@grimberg.me>
Date: Sun, 20 Nov 2022 13:36:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/2] nvmet: expose IEEE OUI to configfs
Content-Language: en-US
To: Aleksandr Miloserdov <a.miloserdov@yadro.com>,
 Christoph Hellwig <hch@lst.de>
Cc: Chaitanya Kulkarni <kch@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux@yadro.com" <linux@yadro.com>,
 Konstantin Shelekhin <k.shelekhin@yadro.com>,
 Dmitriy Bogdanov <d.bogdanov@yadro.com>
References: <20221115115810.75848-1-a.miloserdov@yadro.com>
 <20221115115810.75848-2-a.miloserdov@yadro.com>
 <1243d214-e399-237f-e70d-bb4541a66b28@grimberg.me>
 <20221116065838.GA19952@lst.de>
 <626CFF30-AC50-46A5-B8CD-1387E2D459E4@yadro.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <626CFF30-AC50-46A5-B8CD-1387E2D459E4@yadro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221120_033612_151002_D900426A 
X-CRM114-Status: GOOD (  12.23  )
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


>>     On Tue, Nov 15, 2022 at 04:05:14PM +0200, Sagi Grimberg wrote:
>>     >> index c8a061ce3ee5..48a2f587f38a 100644
>>     >> --- a/drivers/nvme/target/admin-cmd.c
>>     >> +++ b/drivers/nvme/target/admin-cmd.c
>>     >> @@ -372,6 +372,8 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
>>     >>      memcpy_and_pad(id->fr, sizeof(id->fr),
>>     >>                     UTS_RELEASE, strlen(UTS_RELEASE), ' ');
>>     >>   +  put_unaligned_le24(subsys->ieee_oui, id->ieee);
>>     >> +
>>     >
>>     > Any particular reason why it is placed here and not where the comment
>>     > was?
>>
>>     Keeping the ID assignment together seems pretty reasonable to me.
> 
> Also assigning adjacent struct members in one chunk looks neat to me.
> 

That's fine, just wanted to make sure.
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

