Return-Path: <SRS0=eYyw=5R=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B1EC43331
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2020 20:33:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4312520719
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2020 20:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZedsLylx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4312520719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=NdBlEs7VPpCbD52Fg6T0gZg6AZ+ufswPcMl95KQpetY=; b=ZedsLylxAvTw/BXI+eG73NmsD
	JyyaqFuh3/3OGauAs4KfRjN0QKPmQ8ep9kvdbo09S4nYrXSTy0iztStfHnsjk2aRzzvZYvdXkFWg5
	fyEqAmcKA/+mrKvUV0gpoJs4XPjCtcPlNOJHtHMU6TAyNd7voqZhDF9YtXYur1LK6mGJvNf29zoso
	imzU+XL0dfQQr3XppOh92u3i4iKPnEgGROT4BjjnCHqyuIDcWFpE/9loql3Dwy2gPKc7sV9PW80Zy
	vhq9n4XYNujpPxfEFUwWM2/hPGSgjHfFz/vMG/muqRpBKeFVObcr9XEVl8gqXNgrnn3CXNxw/KOyF
	rUV9xVfKw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJk3b-0008Nd-EP; Wed, 01 Apr 2020 20:33:51 +0000
Received: from mail-pf1-f194.google.com ([209.85.210.194])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJk3Y-0008N5-DA
 for linux-nvme@lists.infradead.org; Wed, 01 Apr 2020 20:33:49 +0000
Received: by mail-pf1-f194.google.com with SMTP id b72so579254pfb.11
 for <linux-nvme@lists.infradead.org>; Wed, 01 Apr 2020 13:33:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bQ/oTxqZR/woXkMdSlOd7UuprSUTa1j6DvkxrgcRLns=;
 b=WJ13FE1U1mxFG9EAprOSRYC1eJQXaNe28xRpjMZs6NaYwhV5b50Lqt30HMgKvQCLuB
 pXe8mkjexV2C6HyXiaYJ7A/2BHnlLfHhULKqoE+y+Pqu74qkOkYxYKGPJ1bnSypeaAp6
 4BJrQ6GDTmR7SzB6FawmCgrHe6TBBhhLXbZ91kfB8+IiYqMqs8/MwLKyvd3Mj8MtmCZe
 rwu2zi+iOuTA7g9COtzkL+2SMgE3TW2OEdME8yZArHtaEKYlX7/EKv1BNjFDMqCH0px5
 LuGHmdhWTabLol4EM3QG68OyeOuBr0TDpm8ghr9AgoOyX4AFOOGgKwk5X11LAk2o5qVr
 HB8w==
X-Gm-Message-State: ANhLgQ1jEfErFDc+cLqjAT6TCZRwU5r2qmKUKV7Rb3IV2E+WKdS5J3vU
 YSzwRdlgPatmXN6r/L60R5m3ZR5Y
X-Google-Smtp-Source: ADFU+vspKRJrXI6/vBU3ovDC9A9oaJkH7C4CS+mjh8mEB9YduOney+EBcA3Nr4rB8OAGJ6vrT8TI1A==
X-Received: by 2002:a65:5383:: with SMTP id x3mr24156657pgq.279.1585773227141; 
 Wed, 01 Apr 2020 13:33:47 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:a836:db4c:a7ac:3d7c?
 ([2601:647:4802:9070:a836:db4c:a7ac:3d7c])
 by smtp.gmail.com with ESMTPSA id m29sm2011126pgl.35.2020.04.01.13.33.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 01 Apr 2020 13:33:46 -0700 (PDT)
Subject: Re: [PATCH rfc 2/2] fabrics: allow user to pass hostname instead of
 traddr
To: Keith Busch <kbusch@kernel.org>
References: <20200324090324.24459-1-sagi@grimberg.me>
 <20200324090324.24459-3-sagi@grimberg.me>
 <20200401193908.GB1144965@dhcp-10-100-145-180.wdl.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <66d26b09-7a9f-cd2c-c2c4-e7e311271f5d@grimberg.me>
Date: Wed, 1 Apr 2020 13:33:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200401193908.GB1144965@dhcp-10-100-145-180.wdl.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200401_133348_442578_8E0BEFF6 
X-CRM114-Status: GOOD (  16.03  )
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
Cc: linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> Some users would like to use well known hostnames instead
>> of remembering ip addresses. So, allow users to pass --hostname
>> and we will attempt to resolve against the DNS.
>>
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>>   fabrics.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 75 insertions(+)
>>
>> diff --git a/fabrics.c b/fabrics.c
>> index a7d628b1f0c9..7bd95c4b0d10 100644
>> --- a/fabrics.c
>> +++ b/fabrics.c
>> @@ -33,6 +33,10 @@
>>   #include <sys/stat.h>
>>   #include <stddef.h>
>>   
>> +#include <sys/types.h>
>> +#include <arpa/inet.h>
>> +#include <netdb.h>
>> +
>>   #include "util/parser.h"
>>   #include "nvme-ioctl.h"
>>   #include "nvme-status.h"
>> @@ -60,6 +64,7 @@ static struct config {
>>   	char *nqn;
>>   	char *transport;
>>   	char *traddr;
>> +	char *hostname;
>>   	char *trsvcid;
>>   	char *host_traddr;
>>   	char *hostnqn;
>> @@ -857,6 +862,54 @@ static int build_options(char *argstr, int max_len, bool discover)
>>   	return 0;
>>   }
> 
> The code looks fine.
> 
> I realize 'hostname' in this context is referring to the remote host and
> resolves the target's transport address, but it just sounds potentially
> confusing given we have "host_traddr". I'm not sure of a better name,
> though, so if this is normal convention, then okay.

We could do it like ssh that can accept either IP or hostname (we check
if string is IP and if not, resort to name resolution)

Is that preferable?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
