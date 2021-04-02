Return-Path: <SRS0=ZbIm=I7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE0DC433B4
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Apr 2021 16:50:40 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 990E661106
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Apr 2021 16:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 990E661106
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7xin8YcM8UXA1N0nCbD4BbyDBrLeWo+T/XKKPOETZ9c=; b=TqNE1CPXhui1VbY3dk8PcPEqN
	SrR/V0GwQ0UYNPeLrkE5gJ5JQ0ZocLdB/z5nBmLPCFAdcNyXXtcHBEvWMKEM+sMPGENWhwi40Qol+
	H2YLV1A676fBD5fVPZYgxCprPH8an2rfZRGRlhtJNYTs6oK9TpKXZGYZmXBdOIgfB665fyu0+O9/P
	YG6xqHZrLL/nhQafOC9bN0Y32WdGBVFWQ/h2I0R7f66uBZIH9ue5tFADGU3k9upksa4ATCxZijjLG
	mRhKjkZ7alejEqsnYSMgTKHPnZj1Cvo4utlrvQIz+5aMffz5b8Uhl5KRxH3nbFTEgHuR3dHvUkdcu
	JGB6cyh4Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lSMzu-00DR3w-10; Fri, 02 Apr 2021 16:50:14 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lSMzq-00DR2W-5u
 for linux-nvme@lists.infradead.org; Fri, 02 Apr 2021 16:50:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 42E3468C4E; Fri,  2 Apr 2021 18:50:09 +0200 (CEST)
Date: Fri, 2 Apr 2021 18:50:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hou Pu <houpu.main@gmail.com>
Cc: sagi@grimberg.me, hch@lst.de, chaitanya.kulkarni@wdc.com,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvmet: return proper error code from discovery ctrl
Message-ID: <20210402165009.GE22030@lst.de>
References: <20210331065239.45337-1-houpu.main@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210331065239.45337-1-houpu.main@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210402_175010_331075_FB6FDE95 
X-CRM114-Status: UNSURE (   8.11  )
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

applied to nvme-5.13.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
