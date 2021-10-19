Return-Path: <SRS0=W3/M=PH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62C2C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 13:22:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA3546137D
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 13:22:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AA3546137D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=89m+3nsenGzbnTyxCPMI1Ui8ql06ZOmU5wleotxbzl0=; b=DEuuksWkxvmzi/QKMTnAZntOlg
	KRV3FNYobv1kAClltbY01DJXgxKKWKTt/fefFzHhWIf4rwKHpLAZX2hAgmHWwnrJOZK8OFpDujvpd
	HCPJgRi4rSJ4HnkUZzKmLOGZ4VAZ3z6Sn3D8TbYpjXEEwpnza0o3eBrXjUKXDaEPTbff69l4/xD2e
	QKgfpp0tq9wy9lzJsoCOaePmE6Y0NIkBnTsvhrKtnstORWdER64GWjRnWbFexa01X4ajiNrEm1zLn
	K8MMuQWaptapx9tan7DL990LRsfbO4mz81U8tXNHSjTyoW6dxU8yhG9IfE4Mc5DCC2Us8IyaMdlf6
	5LnY5zHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcp42-001Oyj-4U; Tue, 19 Oct 2021 13:21:58 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcp3x-001OxR-AK
 for linux-nvme@lists.infradead.org; Tue, 19 Oct 2021 13:21:55 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7793B21A96;
 Tue, 19 Oct 2021 13:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1634649711; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=89m+3nsenGzbnTyxCPMI1Ui8ql06ZOmU5wleotxbzl0=;
 b=Rm1VxIGNQeqAyCzQthnov27Nz0CLHDpTAtgIRAJGgP3deUwvHgCf19N7YdGuWSh3M+mBYN
 LIn+ASnHWQksWFbcAH8kjIavL0nN322SEl3oQfXXJd9/Tq4Pj+2hNytli2IkV83KBpWbZE
 JDhm8W+lUKo3UeCJAiMRFsRvu2NxZgk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1634649711;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=89m+3nsenGzbnTyxCPMI1Ui8ql06ZOmU5wleotxbzl0=;
 b=tnAb7xJq86Y+iXshhvRlgjwYT49FgdEZHpXx200N6mb3HU59bRD40N9vlSQhcZyGfo1a+t
 z2DnM644euuISxDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 445A1139BC;
 Tue, 19 Oct 2021 13:21:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SjWKD2/GbmGBLQAAMHmgww
 (envelope-from <hare@suse.de>); Tue, 19 Oct 2021 13:21:51 +0000
Subject: Re: [PATCH 2/7] nvme-fabrics: introduce nvmf_reconnect_or_remove API
To: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, kbusch@kernel.org, sagi@grimberg.me
Cc: chaitanyak@nvidia.com, israelr@nvidia.com, oren@nvidia.com,
 jsmart2021@gmail.com
References: <20211018134020.33838-1-mgurtovoy@nvidia.com>
 <20211018134020.33838-3-mgurtovoy@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <079a9181-f53f-ad78-81ba-be7ed750635a@suse.de>
Date: Tue, 19 Oct 2021 15:21:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211018134020.33838-3-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211019_062153_561336_4FF1F503 
X-CRM114-Status: GOOD (  14.79  )
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

On 10/18/21 3:40 PM, Max Gurtovoy wrote:
> This logic is duplicated today for RDMA and TCP controllers. Move it to
> the fabrics driver and export it as a new API.
> 
> Also update the RDMA/TCP transport drivers to use this API and remove
> the duplicated code.
> 
> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>   drivers/nvme/host/fabrics.c | 21 +++++++++++++++++++++
>   drivers/nvme/host/fabrics.h |  1 +
>   drivers/nvme/host/rdma.c    | 25 +++----------------------
>   drivers/nvme/host/tcp.c     | 26 +++-----------------------
>   4 files changed, 28 insertions(+), 45 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

