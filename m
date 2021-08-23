Return-Path: <SRS0=nO+g=NO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B41CC4338F
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Aug 2021 17:21:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D642361378
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Aug 2021 17:21:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D642361378
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JiCI4BzalMu58PWG/4/aayC3j0d6vJaXCeWPJup9nv4=; b=2N8VXIps4Moz9ReMCrPVFuR9iH
	u5XQHQOtPn0FbLG/Kt2km1JdDyNHMoQTyPPoJ0wEZSF/K9Q7dpulbABt9YGeyz322k76pSEhKEs0c
	F5ffsOlbaHv0J2ttgvy1EOKDEP+9lTAM/nHTLANFAZlGrs7xhS1X2LLQKnnolFjtf8yODDstwlKGW
	ceghwWAtssG/BK5oTxWoy+EvoIxPWL996L6y3dDbTxWpFWyKzvTh80LQQEom5uvQMEwu429LVdfpC
	3ZCuwqBWnfKlwtdLqmFDCpBc3GlHq+J1OksbUCm2GyJadtmWP5G/cG39pjHmU0VmwufZdDy6xY+Ym
	Ew4KgGug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mIDdY-0008WR-Kp; Mon, 23 Aug 2021 17:21:28 +0000
Received: from mail-ej1-f48.google.com ([209.85.218.48])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mIDdW-0008VE-1G
 for linux-nvme@lists.infradead.org; Mon, 23 Aug 2021 17:21:27 +0000
Received: by mail-ej1-f48.google.com with SMTP id a25so11841838ejv.6
 for <linux-nvme@lists.infradead.org>; Mon, 23 Aug 2021 10:21:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xFZ1nwqiJ3yMX624wDBY6+6QGWwRvaBOfsjCWVShAnQ=;
 b=QxgE3FB9s1NlN+E3bn+hgqH/29QDQ3ZlA4CT3VLZJYoZepDcj9WooAv4NLtYLql9bF
 BFU9KTqU9j5ScIS25j95Uu/nXHYnBelsde40J7h1BFddmK03NMirEmbyOwb/6mW/BzZS
 SdrrKKZn/OZNf1fCOqRSr+lGD7qC3rpdKCceVdSra1jRa1Rjr5BReJ0zWEAVDb9c0q4X
 AnG4KNwn3jNHCdi2+jQyaM6ArPDVG81FZ1SBIFbpMmmnESnPPEfVy8T2DP6ohSUK8dNO
 Y4WxEvgZjuJIm/qIw49fbwaZtHgwbkmUT1bO7JbUTuCMWSYWtCXuTrD4SIOvrMwyNCbw
 VNwg==
X-Gm-Message-State: AOAM532faJOxc1POJ+LRSG4txRdbYCtarKwcywJcibo/73467Q2wxvMs
 KOHBvcZhnCeOjVBKB2Ttyog=
X-Google-Smtp-Source: ABdhPJxbo+Z6eUdl+qvu1sBx7005ZEOwn05i+F/w0rLIPxgvvyNQ0V+gqlM83RFd04Btr1F9Bgmj/w==
X-Received: by 2002:a17:906:c087:: with SMTP id
 f7mr35708865ejz.487.1629739284094; 
 Mon, 23 Aug 2021 10:21:24 -0700 (PDT)
Received: from [10.100.102.14] (109-186-228-184.bb.netvision.net.il.
 [109.186.228.184])
 by smtp.gmail.com with ESMTPSA id t16sm4668980ejj.54.2021.08.23.10.21.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Aug 2021 10:21:23 -0700 (PDT)
Subject: Re: [PATCH 0/2] qla2xxx - add nvme map_queues support
To: Nilesh Javali <njavali@marvell.com>, martin.petersen@oracle.com,
 linux-nvme@lists.infradead.org, Ming Lei <ming.lei@redhat.com>
Cc: linux-scsi@vger.kernel.org, GR-QLogic-Storage-Upstream@marvell.com
References: <20210823125649.16061-1-njavali@marvell.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c72c7669-8818-77f1-2e5d-98bb24308f08@grimberg.me>
Date: Mon, 23 Aug 2021 10:21:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210823125649.16061-1-njavali@marvell.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210823_102126_126950_3160D801 
X-CRM114-Status: GOOD (  12.28  )
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


On 8/23/21 5:56 AM, Nilesh Javali wrote:
> Currently nvme fc doesn't support map queue functionality. This patch
> set adds map_queue functionality to nvme_fc_mq_ops and
> nvme_fc_port_template, providing an option to LLDs to map queues
> similar to SCSI. For qla2xxx, minimum 10% improvement is noticed
> with this change as it helps in reducing cpu thrashing.

Does this make nvme-fc use managed irq?

CCing Ming to see if this affects his patchset.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
