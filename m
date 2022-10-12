Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B321C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Oct 2022 06:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2GVplZ4cUEvlsZcmokIDi8mBjVmk4InEj6ddWRhIcyc=; b=BrqMcOYwpOYHqJPYvcnjMf1BFp
	DktF1G4QwdTTQuKhMdQ/QVE1YfZiijWLv7xQW42NOJZlme29WdqXz0lNlUfKfhjXGjjc1SJ/V5HKU
	y+tjclZaF/tY/am58oAAAu211i58Imw08+Mtfs7FVP+/07I1fymZ21vFPSHaWKbLRxrUMDYsbL80A
	x4OEU3SoSzv7nGY2jZHO62q5eTBVeEEzdQ891Uz6pwNbmbMt6cfRLt5fewQeQAQvUeU59GSlPgo3/
	h00FOADLt76a5Pz+HdXpA2ibhMda4fJBPblTbSb+oWflC9KSYgIDWZVVGibOnq8CAnUyQPDhtZrQG
	N6+8ZzZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiVga-0077un-HO; Wed, 12 Oct 2022 06:57:48 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiVgW-0077tE-EO
	for linux-nvme@lists.infradead.org; Wed, 12 Oct 2022 06:57:46 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4545A226E2;
	Wed, 12 Oct 2022 06:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1665557857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2GVplZ4cUEvlsZcmokIDi8mBjVmk4InEj6ddWRhIcyc=;
	b=wdZxKxgOtxxo1iGoREcMx66aqL0s/xEMYPfcG4Wr8qdu815yRVzAeL1FccU79G6a+BATgg
	YKKaTciURByZDGRj1NttOofCRZljm7i0R1Bab5J9uXmd5X9+RvaM58k69vNaCrf/Wp4dYA
	DrtFkXeSwWrLC99BSuzhLc8s64b8xKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1665557857;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2GVplZ4cUEvlsZcmokIDi8mBjVmk4InEj6ddWRhIcyc=;
	b=O9DT/H7rnJs+5aY9EtHfiXlTki5as4xCQiHr1VIRmvMGzM7Ri+JHD6fLLh4YE4Ckn62eQX
	v1Q21gjkeS4GNuCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CD81113A5C;
	Wed, 12 Oct 2022 06:57:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 8jlhL2BlRmOtMQAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 12 Oct 2022 06:57:36 +0000
Message-ID: <e8379b79-bcdc-10b7-62e3-81e5e5ec74bd@suse.de>
Date: Wed, 12 Oct 2022 08:57:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3] nvmet: force reconnect when number of queue changes
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Frederick Knight <Frederick.Knight@netapp.com>,
 James Smart <jsmart2021@gmail.com>, John Meneghini <jmeneghi@redhat.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20221007072934.9536-1-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20221007072934.9536-1-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221011_235744_671796_D70C9139 
X-CRM114-Status: GOOD (  21.32  )
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

On 10/7/22 09:29, Daniel Wagner wrote:
> In order to test queue number changes we need to make sure that the
> host reconnects. Because only when the host disconnects from the
> target the number of queues are allowed to change according the spec.
> 
> The initial idea was to disable and re-enable the ports and have the
> host wait until the KATO timer expires, triggering error
> recovery. Though the host would see a DNR reply when trying to
> reconnect. Because of the DNR bit the connection is dropped
> completely. There is no point in trying to reconnect with the same
> parameters according the spec.
> 
> We can force to reconnect the host is by deleting all controllers. The
> host will observe any newly posted request to fail and thus starts the
> error recovery but this time without the DNR bit set.
> 
> Also, the item passed into nvmet_subsys_attr_qid_max_show is not a
> member of struct nvmet_port, it is part of nvmet_subsys. Hence,
> don't try to dereference it as struct nvme_ctrl pointer.
> 
> Fixes: 3e980f5995e0 ("nvmet: Expose max queues to configfs")
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Link: https://lore.kernel.org/r/20220913064203.133536-1-dwagner@suse.de
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
> v3:
>    - Updated Fixes tag
>    - Updated commit message with some additional information
>      from the v2 discussion
> 
> v2:
>    - instead preventing changes, force reconnect by delete ctrls
>    - renamed patch
>    - https://lore.kernel.org/linux-nvme/20220927143157.3659-1-dwagner@suse.de/
> 
> v1:
>    - initial verison
>    - https://lore.kernel.org/linux-nvme/20220913064203.133536-1-dwagner@suse.de/
> 
>   drivers/nvme/target/configfs.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
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


