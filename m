Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA13C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Feb 2022 00:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cG+VPd5votjZdbrqq10T9Vx//8p+9VoH0UM4Py5DK5s=; b=HqxsYxlGI3mSTTRs46CdNF//0s
	aYiF8hvnZk30l40BIDwU4yDRtg6EJpn9Y+dJiMU8qYWl6O2pFeWlWjHRzYQTds7JR8TV8iICRMim+
	2a6Fpa+QzEXTXOdOrm3vI4wmyj+KVUOIHIdo15UUU8aO1KEiF5T9RBkhPov9yakMk6mkL95A/agCM
	02a/MuMvebAvEkUiA8IxelvgqgQV3H9tCJ8dFBA9uhS+wEgfaquBnohZ7pQfJOUw2infSkfajtIoE
	AuejLrm6pkTQLCOLfhNkjmONlqQtU5ci3euZm3IBURJnACWMDaubI3nhX9rPynqBNCo0X0wDrGmhZ
	nfewBkdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nNOHA-002lyS-D0; Fri, 25 Feb 2022 00:16:00 +0000
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nNOH3-002ly5-43
 for linux-nvme@lists.infradead.org; Fri, 25 Feb 2022 00:15:54 +0000
Received: by mail-pf1-x42a.google.com with SMTP id y11so3278637pfa.6
 for <linux-nvme@lists.infradead.org>; Thu, 24 Feb 2022 16:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purestorage.com; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=cG+VPd5votjZdbrqq10T9Vx//8p+9VoH0UM4Py5DK5s=;
 b=lUmWOyYQKukSvV+k3j3FYr0+Uq4+nawKdkJPlxqcvHKN/aGOa1G7J3fj2cxRmK/8n7
 ag3DJ6CrQEPcl5NrRQv1O2tLNonKs+tnbRlbikC2vExfqFLvSF/FSwk5HFCNwDkpEXjl
 MeyBuJYpSOKbL1wBpA4m/Xz9NiVF27Gz9cFkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=cG+VPd5votjZdbrqq10T9Vx//8p+9VoH0UM4Py5DK5s=;
 b=UOmEY5RU4ItICPcvKn2Bz9eyS/9REciDNMgpDCg0qEvhqNDr0hHJGuYmgHLPxzz9k3
 h+Q7B1wWYWm4UI/94MXi3FwY+cXXDHppKeJlr+hEE7ysRDKbtayVTVeE091TkmKQs23B
 4yJ1JcpdR0gMNsgvEmPdnolRQajylIzjY2wgt0AP5wZGfzJH+qo0vgEnzWpnRMeyBfa4
 HcyAicZkcvXWk8eE/eVOEKsHo0cCXoAGNfgWDGFNYAR4Qo/NgBpGbTVMWpAQOIwmFsbl
 bM3/dXtzT76sLBFPl4VL3iC1vgskFIFfvQjoJtwYUZgOqd68vwzd96vFsXvo5uWF2q4w
 aYRQ==
X-Gm-Message-State: AOAM532KpNCNS2FwJ9zfU7gkQAuDiNKiAI/FpqgR+EORSLIf57QxWK0C
 yVxFTVDzwzuydjKJvX6BJZZWQQ==
X-Google-Smtp-Source: ABdhPJwJBCyrWGjIMjRR5j7o4mCDlCLHhf4RLbT+WYUkVGDJJacw1fodWQYuyjbtCUYOYLtD99+eVw==
X-Received: by 2002:a63:4509:0:b0:372:8235:b060 with SMTP id
 s9-20020a634509000000b003728235b060mr4075061pga.92.1645748151219; 
 Thu, 24 Feb 2022 16:15:51 -0800 (PST)
Received: from dev-ushankar.dev.purestorage.com ([192.30.188.252])
 by smtp.gmail.com with ESMTPSA id
 s22-20020a056a0008d600b004f0eaa735f2sm648329pfu.57.2022.02.24.16.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Feb 2022 16:15:50 -0800 (PST)
Date: Thu, 24 Feb 2022 17:15:47 -0700
From: Uday Shankar <ushankar@purestorage.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Prabhath Sajeepa <psajeepa@purestorage.com>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Randy Jennings <randyj@purestorage.com>
Subject: Re: Native multipath across multiple subsystem NQNs
Message-ID: <20220225001547.GA3454995@dev-ushankar.dev.purestorage.com>
References: <20220211220714.GA370236@dev-ushankar.dev.purestorage.com>
 <20220212063422.GA16561@lst.de>
 <20220212212221.GB1660900@dhcp-10-100-145-180.wdc.com>
 <20220214081252.GA18231@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214081252.GA18231@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220224_161553_451521_663E284E 
X-CRM114-Status: UNSURE (   5.96  )
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

Pulling Randy into this thread.

