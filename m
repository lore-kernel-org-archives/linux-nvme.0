Return-Path: <SRS0=fYEw=LL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7378C2B9F4
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Jun 2021 08:04:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A73AD611BE
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Jun 2021 08:04:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A73AD611BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=21vTuyrkbXWVKpZWZAt0WqRbgV83sFGdZIk++v9oXdM=; b=4SJ9/qJf7Tlj5+
	7PM65ija+fFyC2Y1q3Htzsvk4ID54S5ma72yEeJOp9kRnxzNgOjcOyKv84iNKfY/B1fz96JRTNSeo
	gNWBM4BoeiVXNosmrO36ZEQYaNnfYaBp+mX9OEMLKnfnnnzUOjJpFthJofaIK5CeQdXiCzw61vHJv
	kxWH7spgYYa81h65QCSQszD+jKUcESe1ZNW3k+5/EPbRx6EvxwQ+XR6Aoj8GfyjPaK6LTDW0uup3U
	K2cXn40Ez6Zkwcl7bOHtYSxsc4fha7pFmxo/qPfTWokSMhjFNCaFBGvrM1Z+j7wrkBq67TbZTR8JP
	TXUWtuce1gpYQbEeL/uQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltn0t-009PtF-LI; Thu, 17 Jun 2021 08:04:35 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ltn0o-009Pqq-Rv
 for linux-nvme@lists.infradead.org; Thu, 17 Jun 2021 08:04:34 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0DE2D21A8D;
 Thu, 17 Jun 2021 08:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623917069; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b01wnSdyM2+2vXX1COz937DkqIdJcq4z477RhlclvHw=;
 b=elqQdPvPhG0QhJIXRKPCE1qsArHY569lNIHLAH/9kRqJUsm7tOjXJfSQoeM4oJcWq0wF40
 prnFeLxfP2pml2joAHIHjrwiNzngIAHJXTk5HnvNTLc7mvW7MkrVAqfYbjy6kEl7h+b46Q
 04ZQRQfGPxRu72HiZ/2ebPbsi9FdK50=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623917069;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b01wnSdyM2+2vXX1COz937DkqIdJcq4z477RhlclvHw=;
 b=P3CA4R5Lin9xtE6MuJc/ydwytMOmVF6TU9YPTY8xBY21DGm5J3QF/7Rdj3Wgb0U88qvUJr
 oxa4VAUX7yBMUqCg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id E796D118DD;
 Thu, 17 Jun 2021 08:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623917069; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b01wnSdyM2+2vXX1COz937DkqIdJcq4z477RhlclvHw=;
 b=elqQdPvPhG0QhJIXRKPCE1qsArHY569lNIHLAH/9kRqJUsm7tOjXJfSQoeM4oJcWq0wF40
 prnFeLxfP2pml2joAHIHjrwiNzngIAHJXTk5HnvNTLc7mvW7MkrVAqfYbjy6kEl7h+b46Q
 04ZQRQfGPxRu72HiZ/2ebPbsi9FdK50=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623917069;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b01wnSdyM2+2vXX1COz937DkqIdJcq4z477RhlclvHw=;
 b=P3CA4R5Lin9xtE6MuJc/ydwytMOmVF6TU9YPTY8xBY21DGm5J3QF/7Rdj3Wgb0U88qvUJr
 oxa4VAUX7yBMUqCg==
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id XMiINwwCy2AXGgAALh3uQQ
 (envelope-from <dwagner@suse.de>); Thu, 17 Jun 2021 08:04:28 +0000
Date: Thu, 17 Jun 2021 10:04:28 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH v3 2/4] nvme-pci: limit maximum queue depth to 4095
Message-ID: <20210617080428.dv7qbo3yuvkhkkmw@beryllium.lan>
References: <20210616211936.451128-1-sagi@grimberg.me>
 <20210616211936.451128-3-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210616211936.451128-3-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210617_010431_092655_F1D13EC2 
X-CRM114-Status: GOOD (  11.67  )
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

On Wed, Jun 16, 2021 at 02:19:34PM -0700, Sagi Grimberg wrote:
> We are going to use the upper 4-bits of the command_id for a generation
> counter, so enforce the new queue depth upper limit. As we enforce
> both min and max queue depth, use param_set_uint_minmax istead of
> open coding it.
> 
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---

Reviewed-by: Daniel Wagner <dwagner@suse.de>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
