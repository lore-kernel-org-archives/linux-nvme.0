Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A849C76196
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Apr 2023 07:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IE/sy3rO8+1QPHMcfGUY/YuTsEQJjeySvH9FlCDRskA=; b=BCpwJ+lq2aCf1euFudRr7anXWv
	OJIq222BHfmtfJq5ezZP7uv5RJpBAu0hS8FiIlC60iLhyIz6lr+j5NWHLaq7Y9Qn25ot3CiNgXA9g
	1VxlGzFDulcUUFS/svmQGUMqOEZcUrFryDIpDRDAVfGWcaCGfb+TmGQ/2Wqpun23zv7PiBpoN1WPj
	EsIRsbRG7pqqUd3gjXG15/1FYLvNAMwfTyy297XT3gsPfsBZogwMFxaHCxJ1q350kj+oSTrFGqnUD
	Qg8n9b9h0l8tTHa3xDMf4y0ROsPJERZWQ599hihRYcYT8sYnjnC+WlsgohW3SQUH3S2RX7y8H6h+d
	Y2R3qL+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pm8UM-00GjVJ-2P;
	Tue, 11 Apr 2023 07:32:26 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pm8UK-00GjUj-2K
	for linux-nvme@lists.infradead.org;
	Tue, 11 Apr 2023 07:32:26 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7F68F21A4F;
	Tue, 11 Apr 2023 07:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681198343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IE/sy3rO8+1QPHMcfGUY/YuTsEQJjeySvH9FlCDRskA=;
	b=1qYokvT1snm0l5aQAmFuyEsgfQ03Y0RXi1bzIZhLpzpmyUC5lfZiPKTG/zmDJOj19hfJGa
	xAhs3LftTY4PKr3qu0ztyfygA/pIxuNlFboIaBQtSenuBNeX2ziuQGLRZv88wdgb/XWiQK
	omaBOkq7s7tQf17ikLRRczQwFY13e/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681198343;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IE/sy3rO8+1QPHMcfGUY/YuTsEQJjeySvH9FlCDRskA=;
	b=XkCLC86TCdCKjw07R+UtvluPlhZfkwzSCiI0WuvLk5uQEdtQznAorN+3Gt53nVNv+IVnFu
	Nk6TNyai6geV83Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1B66B13638;
	Tue, 11 Apr 2023 07:32:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id LU6VBQcNNWToZgAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 11 Apr 2023 07:32:23 +0000
Message-ID: <0b226464-e188-d4e9-dc71-4936c39020c6@suse.de>
Date: Tue, 11 Apr 2023 09:32:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v6 17/18] scsi: target: Report and detect unsupported PR
 commands
Content-Language: en-US
To: Mike Christie <michael.christie@oracle.com>, bvanassche@acm.org,
 hch@lst.de, martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 james.bottomley@hansenpartnership.com, linux-block@vger.kernel.org,
 dm-devel@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
 linux-nvme@lists.infradead.org, chaitanyak@nvidia.com, kbusch@kernel.org,
 target-devel@vger.kernel.org
References: <20230407200551.12660-1-michael.christie@oracle.com>
 <20230407200551.12660-18-michael.christie@oracle.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230407200551.12660-18-michael.christie@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230411_003224_900088_B217E4BC 
X-CRM114-Status: GOOD (  10.83  )
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

On 4/7/23 22:05, Mike Christie wrote:
> The backend modules don't know about ports and I_T nexuses and the pr_ops
> callouts the modules will use don't support the old RESERVE/RELEASE
> commands. This patch has us report we don't support those types of
> commands and fail them.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>   drivers/target/target_core_pr.c  | 17 ++++++++
>   drivers/target/target_core_spc.c | 75 +++++++++++++++++++++++---------
>   2 files changed, 72 insertions(+), 20 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


