Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E72C433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 06:34:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F6AC20774
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 06:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GeTRTElU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F6AC20774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+nEYAYDQWSle73yr1tYxWqZfCbZFuJYTwaoB3eMQucw=; b=GeTRTElU7gLsDWX6tl+/bvntT
	JUqkzcqe6y5Kp+CFxNaFvW184zu4OswHuG1q4yZGi03aWJZ8MuBT4cYwGdFM8lRHftwjuh4mFaQaQ
	xZAEoQrTchUhlRLxANQute/5pDxyeAIwC6y897P5qL8g5ED5eEzfpChJz1TEVulTmQId4WuSSy47O
	QY5T41mfXqqZezvrTjl6Lev/TGcFE5uTuc0pItHE1hB59DaD2xtmCmBFdpjgagYBPiDl5GmouMEu9
	reZNMheaUVrRsYLe8dKRYfZizfPvA6aku4A9v8BVLSR7TnMyAkFKZG9dbkVU47ekd0hoQHXwWpSjd
	eBQtH1V2Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6TIg-0004hZ-5J; Fri, 14 Aug 2020 06:34:50 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6TId-0004gn-6U
 for linux-nvme@lists.infradead.org; Fri, 14 Aug 2020 06:34:48 +0000
Received: by mail-wr1-f53.google.com with SMTP id a15so7336728wrh.10
 for <linux-nvme@lists.infradead.org>; Thu, 13 Aug 2020 23:34:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VMIcABDYh2/0ImtJxYG/Qee/8UM6Gbe/3WRO7zppoNE=;
 b=uIbHD/PLx70td8lZ932k4ptbOKkQgSrZLOsChykCzTVOg9mr2BTUylMONEqj+BnRuD
 FQmCxlMDB9f1RYdb0uFtjKSyFrKN9wL59+V6JFFjkENbksxuYo1mQ0zbC8l3YlrkiYof
 p0fdYTOU2O4kj7PQZ4JDprbzyIsLLDyMZM15/rgyPjRWD6d6xmkHLSPEi4pd0PnoiNI+
 9q6N58XkdiJ9Be52nFG203JdQxIA8eNtv0Lu3lTV4kvjJgFYJdJuQnpZYWeOtrMpCqv0
 MKI8jrvTcMn7jp2Q1wGzZTnsn2y/XR2l9LR1dP5KuUmybODIC5hKHJKr2sYc8IfkWYLp
 Ledw==
X-Gm-Message-State: AOAM530VLjyxixuW1wY3PZ0mwK1XJwhm8uFRmXCuFcvoBlliHXJzshvf
 Zj+BiKUgHrIGyWplDz1DJDR/5i1+sbbgBA==
X-Google-Smtp-Source: ABdhPJzgWS7Im4AaFSQTcLOOCEESuc4xcpO2xoBITi8KgxA11lckrI2MzhT8Gy5UpaasSzGbQ03wcA==
X-Received: by 2002:adf:e486:: with SMTP id i6mr1265681wrm.258.1597386885791; 
 Thu, 13 Aug 2020 23:34:45 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:51f:3472:bc7:2f4f?
 ([2601:647:4802:9070:51f:3472:bc7:2f4f])
 by smtp.gmail.com with ESMTPSA id o2sm13085615wrj.21.2020.08.13.23.34.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2020 23:34:45 -0700 (PDT)
Subject: Re: [PATCHv2] nvme: skip noiob for zoned devices
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200807163235.4155607-1-kbusch@kernel.org>
 <20200810123313.GA20069@lst.de>
 <20200810145622.GA4159317@dhcp-10-100-145-180.wdl.wdc.com>
 <20200814062844.GA1656@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <bedb5b9e-3dc5-8c8e-02bc-c4a190d234be@grimberg.me>
Date: Thu, 13 Aug 2020 23:34:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200814062844.GA1656@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200814_023447_385041_A7CAB698 
X-CRM114-Status: GOOD (  15.51  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> On Fri, Aug 07, 2020 at 09:32:35AM -0700, Keith Busch wrote:
>>>> Zoned block devices reuse the chunk_sectors queue limit to define zone
>>>> boundaries. If a such a device happens to also report an optimal
>>>> boundary, do not use that to define the chunk_sectors as that may
>>>> intermittently interfere with io splitting and zone size queries.
>>>
>>> Instead of skipping shouldn't we use the max of noiob and the zone
>>> size, even if that is mostly theoretical?
>>
>> No, I don't think so. If noiob is larger, we'll return the wrong value
>> for blk_queue_zone_sectors() and blkdev_nr_zones(), which will have
>> undesirable consequences.
> 
> Then we at least need to warn about a larger noiob.  And add a
> comment that we are ignoring it deliberately.

I'm fine with that, Keith if you agree you can send a patch
and I'll fold it into the original one.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
