Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9667C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 12 May 2022 09:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8JKMZ7rtPzj0GKKOUxhrwM/+Icn0awrpmJJtaPt0UVg=; b=BqOA9UQ5DgRlflTfiKqaODrQDX
	P1WKGymlfgIHySYK5tC2mc6e1rxzN75rAu6XL83mJRp/4TLT1RJtQmiwBIt3X3lqhAT2FPPFAPCLj
	mi3u1eN91H6N6Oc0zbGWSpQIW6zFGGX315FVKC3S7K1tCpulpbbEtiDL6D9wcfLlZaQHp6bcFa3V8
	PiR/MS/FWo5j4uGV42/WWtA7KPN7+0NCRKQvzA9U44QdVcniRlfbdYbgnxj7404iAss7ZSkXZzP3w
	cK/BC1OSJVsqdg2f8LG/NDWEcCDChFqHUKXvhyR/Kt4OJPn5jf8EqBaIkfbtUywNIQ5MfX0jx2J4s
	SSwgzKBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1np5TR-00BEBw-3S; Thu, 12 May 2022 09:51:09 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1np5TO-00BEAY-2p
 for linux-nvme@lists.infradead.org; Thu, 12 May 2022 09:51:07 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D35FC1F8C9;
 Thu, 12 May 2022 09:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1652349064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8JKMZ7rtPzj0GKKOUxhrwM/+Icn0awrpmJJtaPt0UVg=;
 b=nqgfjFIS0gDGADGY8IikP5OT9fYKQCQ0/Xhjqk3lkbK7oH96j8koYx9GGBpFlJqPrJqW14
 /qKnLD/473SXuVUoibkBQ7aq6KoCcMIf8rpiA5T4rGHAWW4EGZb5yzpyW4rUbnzG6/AFY+
 tGxHUZcOsWAKQHhXIkKmduJI1QGUXAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1652349064;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8JKMZ7rtPzj0GKKOUxhrwM/+Icn0awrpmJJtaPt0UVg=;
 b=Ic9xdIKp05LfFYexnjm5n+cRwzFNnVuvZXlN8WhghoT4W3a4VGxyVPAikfxC0fHMNRnL1k
 vwMhsf8kyuiGWFBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AD21813A84;
 Thu, 12 May 2022 09:51:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6RgcKIjYfGJiPwAAMHmgww
 (envelope-from <hare@suse.de>); Thu, 12 May 2022 09:51:04 +0000
Message-ID: <a5aa7d9e-e261-60d0-f0a8-0c1b9d6f7730@suse.de>
Date: Thu, 12 May 2022 11:51:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 3/4] lpfc: rework lpfc_vmid_get_appid() to be protocol
 independent
Content-Language: en-US
To: James Smart <jsmart2021@gmail.com>, linux-scsi@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
 Gaurav Srivastava <gaurav.srivastava@broadcom.com>
References: <20220510200028.37399-1-jsmart2021@gmail.com>
 <20220510200028.37399-4-jsmart2021@gmail.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220510200028.37399-4-jsmart2021@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220512_025106_305778_7EF5CCA0 
X-CRM114-Status: UNSURE (   9.07  )
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
> Rework lpfc_vmid_get_appid() arguments to remove scsi cmd dependency.
> It's now callable by nvme path.
> 
> Fixup scsi calling path for arg change.
> 
> Signed-off-by: Gaurav Srivastava <gaurav.srivastava@broadcom.com>
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> ---
>   drivers/scsi/lpfc/lpfc_crtn.h | 5 +++--
>   drivers/scsi/lpfc/lpfc_scsi.c | 7 ++++---
>   2 files changed, 7 insertions(+), 5 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

