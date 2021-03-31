Return-Path: <SRS0=yFSL=I5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8DAC433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 19:36:45 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEAD46101E
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 19:36:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEAD46101E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=AKyUNOcbKRSAckuqKesoEe6eP
	rm1apLSWqofAYd6ypr0ImUZekfajI7FDLPZL6ic8oMCtVVXOOiVZBK7MMp/A0dcrWnyfNkFwhhJaf
	5eXNAZq1ofFnD4jdojggSm+IjqTSsXm9UkvTtVr49o5IJHTuDkYI/GJeOnbzfefLks7CjeR27IrzC
	RsVIhNyi9npgjqpN9joW2eiEU4HGE10mT9AmVAoOxh32eHhVzGMwNBJ2F8G0C3Ukss8h3Y/7dGHLP
	SHoihM0hwYZjBsdOavdiXFp/hy+ww6dTJKH6RfLqJ/U4o4pCiQFbK9uhpSM+3sMdFVSEZCv0gPNjo
	dVitV0H8w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRgdi-007NS7-LL; Wed, 31 Mar 2021 19:36:30 +0000
Received: from mail-ot1-f51.google.com ([209.85.210.51])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRgdc-007NPf-4w
 for linux-nvme@lists.infradead.org; Wed, 31 Mar 2021 19:36:26 +0000
Received: by mail-ot1-f51.google.com with SMTP id
 l12-20020a9d6a8c0000b0290238e0f9f0d8so20058478otq.8
 for <linux-nvme@lists.infradead.org>; Wed, 31 Mar 2021 12:36:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=ajzmyb4IJfc28WFdWw9rVZiXIxJwNpZPOcf/WGB2YRy/I3QnZV4DHtF1jHFn45g3+c
 rM35RDu0JckW0Empf97wGe6rayt6tc615bnxvN4hNG4I347CdQlzufb0xELeOFPpo3Ax
 y5m6oZwv/KfOU9d9YgW5KR4cxB+W9/5J9/60lh0tERFDkM2jwGon5YU5XCiVAioUvL40
 DZuIsuPMy/epGQMSvlxRlEd9xCkJf3oepmvpwzaLTnMGmUbEeBAliE/oV3vy7Alt7CQ/
 rJUsXmKDljYdPbDbEFTWFyA1P1AyMwNCWe6qRZPZtSRMI01v2M7daULAaFT8KoskYLMn
 KkoQ==
X-Gm-Message-State: AOAM533gjhQ0nBEqeQRsFzuwOYiE4ZK819WtT5RPkA/AlzGH+JUCpBJr
 wQ5/IwGoVV/VFejgSxvBCpw=
X-Google-Smtp-Source: ABdhPJySChm/VYBcjuXrCZ4sYKbWRNOlVNtA3Fzd2pgMwMW1nJFynxt2gvMG40YDXpuJw0aU4RLd4A==
X-Received: by 2002:a9d:2f24:: with SMTP id h33mr4053945otb.128.1617219383103; 
 Wed, 31 Mar 2021 12:36:23 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:6302:5415:8f3:c3fc?
 ([2600:1700:65a0:78e0:6302:5415:8f3:c3fc])
 by smtp.gmail.com with ESMTPSA id f29sm683079ots.22.2021.03.31.12.36.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Mar 2021 12:36:22 -0700 (PDT)
Subject: Re: [PATCH] nvme: Export fast_io_fail_tmo to sysfs
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Hannes Reinecke <hare@suse.de>, Chao Leng <lengchao@huawei.com>,
 Victor Gladkov <Victor.Gladkov@kioxia.com>
References: <20210331131228.131118-1-dwagner@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6d68ce76-1db7-6f6a-9c6f-38824a49e728@grimberg.me>
Date: Wed, 31 Mar 2021 12:36:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210331131228.131118-1-dwagner@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_203625_446934_FF70523A 
X-CRM114-Status: UNSURE (   9.10  )
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
