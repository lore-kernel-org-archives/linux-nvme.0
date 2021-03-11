Return-Path: <SRS0=tknV=IJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246FAC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 10:51:43 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B2A464FC1
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 10:51:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B2A464FC1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/rxW8oc6RBpUO6lpG70oHkIJC92L++lK3qEGfzoJClc=; b=lMtYt6NSRQNlk8QFsUKyqgfB0
	+/Bxr1Ibn4abhe3PWkrd8NPvT8kWP8lmbz0ggp1prHIdt11kFbE7o97RPC4Fwh2hchwkbsYfXcy1D
	DN6iXgCLrsj2gjoUATPtT1WKNQoTGcXICcxih+qHq/3c1NIamZ61519KpHm+CIFsoO2tEMGA3CUb7
	AhflVtBTHvA0mt+6x/srAumXO8zYTpIJbYkisieYq2HjiDPFWF1GXZihNpopns6EpHv0SAgXRbgtY
	4u4PgRpBw6vzXmscOqEjLPyg4fibRgyFy/VDdNMSuRTX7l5GJUTbxKAIBVPUuAkhFzFaS08iW7dzl
	Y9ezoFm9g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKIue-008sjL-TY; Thu, 11 Mar 2021 10:51:28 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKIuZ-008si6-QI
 for linux-nvme@lists.infradead.org; Thu, 11 Mar 2021 10:51:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id DFDD868BEB; Thu, 11 Mar 2021 11:51:22 +0100 (CET)
Date: Thu, 11 Mar 2021 11:51:22 +0100
From: Christoph Hellwig <hch@lst.de>
To: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Cc: hch@lst.de, sagi@grimberg.me, chaitanya.kulkarni@wdc.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme/rdma: Fix a use after free in
 nvmet_rdma_write_data_done
Message-ID: <20210311105122.GB16485@lst.de>
References: <20210311054413.8731-1-lyl2019@mail.ustc.edu.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210311054413.8731-1-lyl2019@mail.ustc.edu.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210311_105123_966864_D4B60F25 
X-CRM114-Status: UNSURE (   8.73  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks,

applied to nvme-5.12.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
