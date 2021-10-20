Return-Path: <SRS0=Nmvj=PI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C36DC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 05:58:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED44E60EE9
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 05:58:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ED44E60EE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=glMUE3PGChr42vWAhJHVGB2150hn/b/2HsM8cx/qvBc=; b=njsMyALRimhoDYJg2m4WrNzNeI
	pAMDN3wXvV1uVS1gWIH5rzptkuFTK/1or8OeRAtvJd8zJC1BaEjQXCCWb+dBJ58BEUhtCnAjNKl9H
	mTgxruAfUiw+cWzjeP2e8JQ+WpHPo9rjT774+DFR8EXC13USZUhARmVzKJZxqK2UWeRfvKwusUp67
	ccqJBdCkOT7kk92XpMBp0ozedXMwDJygetomV8VabifHHqo58iu8Qk1z5McLlcG+0Yyt4+nlDKzW+
	4d0zOdnDG8vBFUOrNoX00OhJMcpnNNO2RJXbdouqAch3KwzLqMxiLYpPmlq7du3hugBYjoQ4vAe0r
	hrU5KXyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1md4cm-003RSS-Iz; Wed, 20 Oct 2021 05:58:52 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1md4cj-003RRl-BM
 for linux-nvme@lists.infradead.org; Wed, 20 Oct 2021 05:58:50 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 77D6C21A7F;
 Wed, 20 Oct 2021 05:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1634709527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=glMUE3PGChr42vWAhJHVGB2150hn/b/2HsM8cx/qvBc=;
 b=kHSz2qcgk3yHZgR1BJZ12DEEu8026iWWL55Ly388yaZl1NBwKuyujo+8e4daVAlmbqiMHD
 FZn3DefMZzhZAKrlWF5zndu54kfKAnnSME0Nyic2kdr1NtKdREw2DXkRIQ2JcQF5NTc0T9
 mROyRWfusgChsrimKQdMmkirwfGsICo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1634709527;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=glMUE3PGChr42vWAhJHVGB2150hn/b/2HsM8cx/qvBc=;
 b=8ninQhk5Vuq9dQkiRkvC9VuhKaeg3VKJADyvgDvunG9COV1ljVH+HSRZIonm68exIdY/cg
 Sy8vzrjg4Qp+nlAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 54450139EC;
 Wed, 20 Oct 2021 05:58:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id LyP6Ehewb2FZIAAAMHmgww
 (envelope-from <hare@suse.de>); Wed, 20 Oct 2021 05:58:47 +0000
Subject: Re: [PATCH] nvme: invalidate paths when removing contoller
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20211019154823.91586-1-hare@suse.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <1785d43c-b161-3378-04e7-c9a229d680db@suse.de>
Date: Wed, 20 Oct 2021 07:58:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211019154823.91586-1-hare@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211019_225849_563374_A7CF3258 
X-CRM114-Status: GOOD (  18.55  )
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

On 10/19/21 5:48 PM, Hannes Reinecke wrote:
> When the I/O from the initial partition scan encounters an error
> it will not necessarily be failed, but might trigger a reconnect
> with the I/O itself being requeued.
> Upon disconnect we need to ensure to flush the requeue list
> independent on the current path, otherwise the I/O will never
> complete.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/core.c      |  2 +-
>   drivers/nvme/host/multipath.c | 13 +++++++++++++
>   drivers/nvme/host/nvme.h      |  4 ++++
>   3 files changed, 18 insertions(+), 1 deletion(-)
> 
Ignore it; I've found a better way of fixing this.
Patch will be send shortly.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

