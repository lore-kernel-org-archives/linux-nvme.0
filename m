Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB2A4C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 12 May 2022 09:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CDTfrcH2J+wpT6MHPwD//tRDQVCkGoq4f5SeJFs/ebg=; b=xMirhYhy4Je7he0X8WVKdm4FJw
	a5ffaOFQ+Qe2Y6Y/3ABWmOR9AzifksX1Ssuk39kfTDnCQ4F8O3xWuxOf9JPWp5SXFZezqyYySIAyG
	Yw+JC819C8tkfgzAilm9WYzX2sErGZLOpy4HCKkBVmKEsR3xzeXY89VM8H25h/MDUP4P0K4D4ns8b
	PmyBida5BNmBwtK2R9WJ4tJV4sZMQNGoKNuoTlYvG55hiYmhxBMoLq8XIgr9gvrmPCDOZha/+4gYw
	8HgQVj4ZJPhfcCNySPtWObt3SR3rAfIGE3GWba84VWku7KYtuxeClTex6OMmjBQD/+6IPJXEoKOIH
	F2NPZPRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1np5Sd-00BDw1-Ay; Thu, 12 May 2022 09:50:19 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1np5Sa-00BDuc-Kt
 for linux-nvme@lists.infradead.org; Thu, 12 May 2022 09:50:18 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 17D5821CA1;
 Thu, 12 May 2022 09:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1652349015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CDTfrcH2J+wpT6MHPwD//tRDQVCkGoq4f5SeJFs/ebg=;
 b=EQ6PJN0JB4lx/LOM+wyJrv3VNbMB2ixHb5o5wDyzk7j20QsqjLnys+VMIC4lEnHgbw8bqm
 D/E7rV6u/Gbwd37OBM9EcM42VoIT/xEM/tbWY5nkOkYTnn/imnWH8w+7YvHQhQiVdXj8VD
 6DS9QUJ467R0XQLCoIj/4nZdi4TB+uE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1652349015;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CDTfrcH2J+wpT6MHPwD//tRDQVCkGoq4f5SeJFs/ebg=;
 b=gV1ttrP49dNjOkI3ZocFd6KebCCRjVzz33zT2vw4BqKqgVmXM1SQhqtiiClsXHigxW6clX
 4yekcQSOeDVpc4AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EF0E313A84;
 Thu, 12 May 2022 09:50:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id xVSiOVbYfGIGPwAAMHmgww
 (envelope-from <hare@suse.de>); Thu, 12 May 2022 09:50:14 +0000
Message-ID: <1f999706-58f9-5521-aaa2-cd88c33669eb@suse.de>
Date: Thu, 12 May 2022 11:50:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/4] nvme-fc: Add new routine nvme_fc_io_getuuid
Content-Language: en-US
To: James Smart <jsmart2021@gmail.com>, linux-scsi@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, Muneendra <muneendra.kumar@broadcom.com>
References: <20220510200028.37399-1-jsmart2021@gmail.com>
 <20220510200028.37399-2-jsmart2021@gmail.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220510200028.37399-2-jsmart2021@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220512_025016_869653_730E9219 
X-CRM114-Status: GOOD (  13.02  )
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

On 5/10/22 22:00, James Smart wrote:
> From: Muneendra <muneendra.kumar@broadcom.com>
> 
> Add nvme_fc_io_getuuid() to the nvme-fc transport.
> The routine is invoked by the fc LLDD on a per-io request basis.
> The routine translates from the fc-specific request structure to
> the bio and the cgroup structure in order to obtain the fc appid
> stored in the cgroup structure. If a value is not set or a bio
> is not found, a NULL appid (aka uuid) will be returned to the LLDD.
> 
> Signed-off-by: Muneendra <muneendra.kumar@broadcom.com>
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> ---
>   drivers/nvme/host/fc.c         | 16 ++++++++++++++++
>   include/linux/nvme-fc-driver.h | 14 ++++++++++++++
>   2 files changed, 30 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

