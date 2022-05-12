Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E8CC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 12 May 2022 09:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+sU7RyHP0nMiUOqzUDGD1oZadnUmO2nhZ74SmIP8CZk=; b=3OrxjPiX5zqqe33G+UR2dDgAjK
	FiL3PyC9RPFPKTl7CVQcefpyP55BdtACoUEZI6Ngdowba8MK5It5kxyPO2HPvcd4CSTwM643ZaYzP
	JPVOGLRckPyySQ0jEK1Kb/HHcQtO7FgVtVAt3Pwo4F6AbOXtt1xpDyxieDVNnNxkJywIhhtIRBW+q
	SvMAFNTfyQvuySpmeL33PR03XuDBH85yrmDIwWHUsxk3nmkLj92NVPcaZRTMiyUdP6UUSjtDpEMp0
	jrqFdcFNn/H16An5JsCXsVcQL2x9RpOL5XwT5dktvMcc87rWj3YWC3KmHeIAQ6mRRHzHD0nAkqQXh
	vAdeyzrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1np5T7-00BE5d-Sf; Thu, 12 May 2022 09:50:49 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1np5T3-00BE3W-Q6
 for linux-nvme@lists.infradead.org; Thu, 12 May 2022 09:50:48 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7C0741F8C9;
 Thu, 12 May 2022 09:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1652349042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+sU7RyHP0nMiUOqzUDGD1oZadnUmO2nhZ74SmIP8CZk=;
 b=r+sHb5EDtR514FDLv8paXSt7Xy0M8QBgD8ntozCX/D0o3pRZEak4N9cyt03tpc+DWRAruV
 x8/2HDKYgGR8bRIiM0hHmxC+XKigDMBoTSg7pW/WIjjqhG1MJilXVKmKo/6TgsRjVIBvFJ
 YGQodcB2Xsjgur4BV/Yy/lnCDchcf8M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1652349042;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+sU7RyHP0nMiUOqzUDGD1oZadnUmO2nhZ74SmIP8CZk=;
 b=7NfmA9PLjlU5OSFRweE/5nlYri0EWIOlmbpvIrJsZvYGEhK1FZ371KCJBDTGScXQl8XCbr
 VSTmZ4RP/dkbQEBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5179313A84;
 Thu, 12 May 2022 09:50:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8ycdEXLYfGIxPwAAMHmgww
 (envelope-from <hare@suse.de>); Thu, 12 May 2022 09:50:42 +0000
Message-ID: <38c1297e-bd31-628c-9eb3-7f36b4591423@suse.de>
Date: Thu, 12 May 2022 11:50:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/4] lpfc: commonize VMID code location
Content-Language: en-US
To: James Smart <jsmart2021@gmail.com>, linux-scsi@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
 Gaurav Srivastava <gaurav.srivastava@broadcom.com>
References: <20220510200028.37399-1-jsmart2021@gmail.com>
 <20220510200028.37399-3-jsmart2021@gmail.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220510200028.37399-3-jsmart2021@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220512_025046_032004_E532493D 
X-CRM114-Status: UNSURE (   9.80  )
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

On 5/10/22 22:00, James Smart wrote:
> Remove VMID code from its scsi-specific location and move to a new
> file solely for VMID code.
> 
> Signed-off-by: Gaurav Srivastava <gaurav.srivastava@broadcom.com>
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> ---
>   drivers/scsi/lpfc/Makefile    |   2 +-
>   drivers/scsi/lpfc/lpfc_crtn.h |   2 +
>   drivers/scsi/lpfc/lpfc_scsi.c | 256 ------------------------------
>   drivers/scsi/lpfc/lpfc_vmid.c | 288 ++++++++++++++++++++++++++++++++++
>   4 files changed, 291 insertions(+), 257 deletions(-)
>   create mode 100644 drivers/scsi/lpfc/lpfc_vmid.c
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

