Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C51C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 18:59:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A26364E0A
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 18:59:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A26364E0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UmgYX11LD5DgDM5tKjZkru0R7NqIUtTnzZRoYewGvq0=; b=1LvSV7fsypGZsc81LPeXHt9/5
	WxzU/t39BLnU3anCTkErEF/aJRyLtoI+hwi+G1rZIU1dCyFSsVizjILiQMZg2VQWr8LgES9OE2Bc7
	SEW3eW7qk8N9BjCvNaku4E+kC774cKNW0DlSQBaoxu527VW/36CnpcWPjKjzjIHlNSGIEYU6W4ytj
	wxpEqSCM6Zjt358OWELOko3zvySa8kLWOv9fy0W7+0WMU99eeUpScan2eDKZp2ZXVnet9CP0aWEUT
	YnZSn5RdR5n8bIwYVSTHYHm4qPB2i24ERstg4bDeLEywRKuQb/buRnzlkpRw7kUga8TwLOhUYq1p8
	IIgQZ3skg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5YzN-0005ZQ-P8; Fri, 29 Jan 2021 18:59:25 +0000
Received: from mail-pg1-f180.google.com ([209.85.215.180])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5YzL-0005Yi-6s
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 18:59:23 +0000
Received: by mail-pg1-f180.google.com with SMTP id r38so7280504pgk.13
 for <linux-nvme@lists.infradead.org>; Fri, 29 Jan 2021 10:59:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jrkOpu/h1HRCADxoJMdVu6X5ki8TxZ7meT6vK8ezDf4=;
 b=eJXQXKj3cuHGf1xvai1FTas75Ww3mf/VICDFexC9DUgGux9nSKaDyc/+hxaNdo4l35
 fzZfNNmQ4fIQMGx4QDvBevN/6fPJQj88ApoNU8zHyItb1DyYwMJjG1sGdNVWVyVedoq5
 k/rS4Y2c3/LTgWGbutWoCBXqKNvlbhjZWvPk83CIiKpccs2h+aymKBf2/s771kXrZLdB
 qQSwvpEPMNOUyCDMl9lms6/+eCcFucZYSnlCfTfwyYMNIDHy4RLDhAzj8Om45GCthLv8
 rSd8omUTfDj8mJ+kdyprxpFSGkbMi9HHzfTCOrL37dGN4m0zxSf2CYq3cSIlzhFYtf13
 LEzA==
X-Gm-Message-State: AOAM533gLL3x195iWwxXJeHz4Tt/wHI2/6vhH3VFUoYXrarNAH9XSmlu
 r3UO2oD8HbNTD1tmJ/+6osSSGz2UhuQ=
X-Google-Smtp-Source: ABdhPJyrO3wZcvpjsDMHugYlhmzkmWy/fNKiQ2RtQwOEzsGeKWCxSg0l07K0GdqtSX4KOwP1Hw2nYA==
X-Received: by 2002:a63:d901:: with SMTP id r1mr6136225pgg.209.1611946762121; 
 Fri, 29 Jan 2021 10:59:22 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:db7:4f5:6eca:f1ab?
 ([2601:647:4802:9070:db7:4f5:6eca:f1ab])
 by smtp.gmail.com with ESMTPSA id k141sm10219759pfd.9.2021.01.29.10.59.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Jan 2021 10:59:21 -0800 (PST)
Subject: Re: [PATCH 11/35] monitor: add option -A / --autoconnect
To: mwilck@suse.com, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20210126203324.23610-1-mwilck@suse.com>
 <20210126203324.23610-12-mwilck@suse.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d9c74675-a324-b863-1dee-454fc90d5e77@grimberg.me>
Date: Fri, 29 Jan 2021 10:59:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210126203324.23610-12-mwilck@suse.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210129_135923_282789_77758C98 
X-CRM114-Status: GOOD (  10.48  )
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
Cc: Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> With this option, the monitor will try to connect to newly discovered
> controllers.

Maybe I'm missing something here, but what does it do without
autoconnect?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
