Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC8DC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 18 May 2022 09:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nV3v3Tc6DvPqpOXZdtqP96dQ5Xo+sryZhZSrwMn52mc=; b=wfs93icqWdTOhbzjKe0WK2qJru
	msY3z7j1ToejQfuk9EEWe/Yx+QhzkMuIDKvvbvVE7hdvolpt1GihdjS1YzCye9aGQgwzwWmrBwigF
	fQTbiY9uivhffirlKFKroWdkRuxNQqK+T+QRFXTvTgpNGyzAf9S1urGxpL/mS0n6ozXFb+6eJx1U4
	Rb067QOejfLsRHv6KpYb4jttdV0rVlrD7TOaImE52VXh+RVYgAW7sO+3QYAHiIPgHpPo4dT8xNemU
	qB2wQRjwZcmwefjMNw1NaOT5XcxOeHHGyReoBv/n4WMp2amLzMNfV1hiMtGEmehZM0L6Pr+yuFJ50
	PqNmT7PQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrFx3-0010Lx-Du; Wed, 18 May 2022 09:26:41 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrFwz-0010Kf-OB
 for linux-nvme@lists.infradead.org; Wed, 18 May 2022 09:26:39 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B2B97219CB;
 Wed, 18 May 2022 09:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1652865995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nV3v3Tc6DvPqpOXZdtqP96dQ5Xo+sryZhZSrwMn52mc=;
 b=Xy1Evb4pHVA/gwQ8qPBoWKQ9UfH6zC9EkxGLbaQoVDs0Mz3rXx9jAYOBqPxqMfH2g4HB4r
 S1CIaQVriRPxVqS8tRTDwK87uBQC4oaHiXKp7s+sdMQPInqaZOz8WdPGgABbNy6nRwy0ak
 vrMpssOUCyvvoCrAqMD08bLOpkUHguY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1652865995;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nV3v3Tc6DvPqpOXZdtqP96dQ5Xo+sryZhZSrwMn52mc=;
 b=PszD6+qP+zID5LLXS8mjo44bFbDYaqtgV2scERRDlWCr+LLwPi9sWjxCrEGsYc5w/7TMgE
 /RLHDz+D+1x3u8DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 87F5E13A6D;
 Wed, 18 May 2022 09:26:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OaFKIMu7hGKnCwAAMHmgww
 (envelope-from <hare@suse.de>); Wed, 18 May 2022 09:26:35 +0000
Message-ID: <02fbd773-46c0-4c32-6a8d-414e08f7dfac@suse.de>
Date: Wed, 18 May 2022 11:26:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] nvme: add support for TP4084 - Time-to-Ready Enhancements
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, sagi@grimberg.me, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org
References: <20220518064040.3223894-1-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220518064040.3223894-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220518_022637_991235_074A8F00 
X-CRM114-Status: GOOD (  15.47  )
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

On 5/18/22 08:40, Christoph Hellwig wrote:
> Add support for using longer timeouts during controller initialization
> and letting the controller come up with namespaces that are not ready
> for I/O yet.  We skip these not ready namespaces during scanning and
> only bring them online once another scan is kicked off by the AEN that
> is set when the NRDY bit gets set in the  I/O Command Set Independent
> Identify Namespace Data Structure.   This asynchronous probing avoids
> blocking the kernel boot when controllers take a very long time to
> recover after unclean shutdowns (up to minutes).
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/constants.c |  1 +
>   drivers/nvme/host/core.c      | 73 ++++++++++++++++++++++++++++++++---
>   drivers/nvme/host/nvme.h      |  1 +
>   include/linux/nvme.h          | 31 +++++++++++++++
>   4 files changed, 101 insertions(+), 5 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

