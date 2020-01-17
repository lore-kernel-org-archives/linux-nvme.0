Return-Path: <SRS0=A48R=3G=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A118BC33CB1
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jan 2020 16:46:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6951F2064C
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jan 2020 16:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AgY/84eB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Nm41WcUO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6951F2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/Gb0FH083+gXysvnmhJmO81KHrYyeflVh65zepInCBI=; b=AgY/84eB97Hq1xLooefFqMhuW
	Z5uDhZskyFp5Cm2jMY1P+1rhhRK5lFZnhZhdbBJLN+H5tos54r0FxuClAccv3g8EvgqC6poVD+QPz
	yHq1mEVT4t5iHv+6MADUelhCJs/u8o2mpAFEfKTmj6Sk98UeM+4jl8wIhj8xfbbSk6a5R2RGSn4yL
	9zsflAoWInUs6PAVufBbSVPptbDTr7rJ31dr4Ru5g7xgSFf0FYAwplhhc6/tsUy3xLfZ4/t0ZuOFx
	FSLCnDLdZkq9rPfWoF4hmEHHhvBrXb73KS7fyPLWIw0s1tAlqt+++93vKmlboEk0dyWq5fKofgXc0
	DAuPyiMAQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1isUlI-0007XE-AI; Fri, 17 Jan 2020 16:46:20 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1isUlC-0007Wr-Ew
 for linux-nvme@lists.infradead.org; Fri, 17 Jan 2020 16:46:18 +0000
Received: by mail-pl1-x642.google.com with SMTP id b22so10063917pls.12
 for <linux-nvme@lists.infradead.org>; Fri, 17 Jan 2020 08:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=oZyVdSEnLXgaW6Tob+nEyDNlC+TBXa24w9Vl0+FvGg8=;
 b=Nm41WcUOgk91f8u6Gd3bq//utd0CjkOWZ95hbxjjg1+4HzLoCueXVB5WI8yJeqZGyh
 gC4N9BF6Q44wls88m4d11hU0jheJIvmw5o/ggqcm0tbwKr/vk95CAVCD6NjoXQFyaHQx
 XgJlCaPd2CJUedeYKwE4E9sQzBP2NL3c5D/aY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=oZyVdSEnLXgaW6Tob+nEyDNlC+TBXa24w9Vl0+FvGg8=;
 b=Hbj1ye+Hl1gjyptq1NLqziWCrV0JSPbqBONTecYNAA1pECYWU/dO5wTtu5qfsoegGC
 GNbKJQhWdhKr7bOaCOb9yI4YStwOfI4vgt7epFAqxjDydASBxy5duVHXWmakgM1lSJcm
 E0fNUyzWNzkDfoVwjYwJx6VdjBCX9znzeFvS7nYPropVVg4P+6Bb098V8WCEqBiHZL/3
 QFZauRg5z9XrxbhuUllZ6/EEbcfUqGot9nmt1Z/E1e71mb8lWJJteRijeok+w1bUjkmM
 kNKxdwz4VaX2vh023DKGwQ/44NrS4as0HkRpI5I2qdlKp8r2tb+D31xvPEtjZP+nq2Rz
 iKWg==
X-Gm-Message-State: APjAAAUYiE8o+SAz2sysNEXlNdc6aJrz+/CKYDXrV/95ZRqKtKbM25ey
 NqlAScfdhy1fAYndRQV5w1x0Vg==
X-Google-Smtp-Source: APXvYqyn8Tgg4a6YHLjC9xKj+TbZGba9UyCPoG1/GTK4hF8qlKMrC2kfFDuEfw4XQVKne2Xy7J3xig==
X-Received: by 2002:a17:902:b785:: with SMTP id
 e5mr39713895pls.327.1579279573673; 
 Fri, 17 Jan 2020 08:46:13 -0800 (PST)
Received: from [10.69.45.46] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id d4sm7421606pjz.12.2020.01.17.08.46.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2020 08:46:12 -0800 (PST)
Subject: Re: [PATCH 13/15] nvmet: Add metadata/T10-PI support
To: Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, martin.petersen@oracle.com
References: <20200106133736.123038-1-maxg@mellanox.com>
 <20200106133736.123038-15-maxg@mellanox.com>
From: James Smart <james.smart@broadcom.com>
Message-ID: <ae42f71d-689c-3f75-3a80-9fc4bea1427b@broadcom.com>
Date: Fri, 17 Jan 2020 08:46:10 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200106133736.123038-15-maxg@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200117_084614_504390_02241BA1 
X-CRM114-Status: GOOD (  10.35  )
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
Cc: axboe@kernel.dk, vladimirk@mellanox.com, idanb@mellanox.com,
 israelr@mellanox.com, shlomin@mellanox.com, oren@mellanox.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 1/6/2020 5:37 AM, Max Gurtovoy wrote:
> From: Israel Rukshin <israelr@mellanox.com>
>
> Expose the namespace metadata format when PI is enabled. The user needs
> to enable the capability per subsystem and per port. The other metadata
> properties are taken from the namespace/bdev.
>
> Usage example:
> echo 1 > /config/nvmet/subsystems/${NAME}/attr_pi_enable
> echo 1 > /config/nvmet/ports/${PORT_NUM}/param_pi_enable
>
>

Mind adding a core routine, callable by a transport, to set the 
pi_enable attribute on the port ?

Also - I don't know that all block sizes, metadata sizes, and DIF types 
are supported by the port. Should these registration be "capabilities" 
lists ?

-- james

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
