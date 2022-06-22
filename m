Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D95CCC43334
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jun 2022 09:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=toWsVnO37EgoETIolIFeEBtfu1DSv3e/jO8jIrvfJxs=; b=fAPEHZikLZhFg9f3Sz9sBDR0wH
	hvQFV5FEgWa2wOFMwub1glJw2Iup9bRF+8bMvpECI/ImorvkBKy3p971pusGmmBxGgcPHji/JIMTq
	CnKCL0P0OIPK4o60x0MA3/quFUHaXztfPA2ryiu7Wu7OX2dPyGKof+vFF0uuxmiHyFD/514KB7ykd
	F6+9C27MsKKGttz3vnmtwKoG1Oxp/eqh8teL/kpBpIfUiaAqFYWN1uSDJr2gQf03h+Ig49RF4K67U
	2TX+LCj61SHf78vq5xIxFhs0VurDBqOx/SThwK6l/f+9Hl48xkPhKo5DnFmCSrAb1rM1PoeCrbCKB
	exNYk2Zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3wKt-009TtM-Sk; Wed, 22 Jun 2022 09:07:43 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3wJb-009T60-Kd
	for linux-nvme@lists.infradead.org; Wed, 22 Jun 2022 09:06:28 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 554501F978;
	Wed, 22 Jun 2022 09:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1655888777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=toWsVnO37EgoETIolIFeEBtfu1DSv3e/jO8jIrvfJxs=;
	b=PPlg7XJHFFqXVV+2TJjfu2LxHSovcxmSTab4jdN43uvD16qAxtSFCKirI7KPr4L+6mVTjC
	CU3zef3KG5fFwlYrH8t+9FHLye8hwk88/hTFJ6Kf2kUb97BVul5OxVNHp4g8N5DglzC1ri
	8nDL9VPzC/LvObKBMkDvHAIHpSB2P/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1655888777;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=toWsVnO37EgoETIolIFeEBtfu1DSv3e/jO8jIrvfJxs=;
	b=kTcivFc1LsYbHxBLfDo5bDRDnuSh9rT9/2yrng7eQAjYaD2GFGKdwc2h17vM5eeuygAflR
	elHgjHTmhYwslaAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 385A5134A9;
	Wed, 22 Jun 2022 09:06:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 5zJwDYnbsmLwHQAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 22 Jun 2022 09:06:17 +0000
Message-ID: <c06b6657-b015-3ff4-6044-8e800aaeae81@suse.de>
Date: Wed, 22 Jun 2022 11:06:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 06/11] nvme: Implement In-Band authentication
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220621090255.69549-1-hare@suse.de>
 <20220621090255.69549-7-hare@suse.de>
 <f8f0a631-6752-096c-4e85-bcde9bb2869e@grimberg.me>
 <22236c51-90cd-1707-05b8-3772ef4c548d@suse.de>
 <ab4aaf2b-444f-2b3c-091a-396de62afbd1@grimberg.me>
 <a32afeac-983c-2ea4-e693-2d46411e7f4a@grimberg.me>
 <3784f492-67f8-c75a-dccf-7f7272e0b4ad@suse.de>
 <b0e6fa33-ed59-eaa7-3629-3d72430b8ad6@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <b0e6fa33-ed59-eaa7-3629-3d72430b8ad6@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220622_020623_905965_F071230F 
X-CRM114-Status: GOOD (  11.65  )
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

On 6/22/22 10:43, Sagi Grimberg wrote:
> 
>>>> Looks like if I pass a malformed ctrl key to nvme connect I am able to
>>>> crash the system:
>>>
>>> This was what I used in this:
>>> $ nvme connect -a 192.168.123.1 -t tcp  -s 8009 -n testnqn1 -S 
>>> "DHHC-1:00:QpxVGpctx5J+4SeW2MClUI8rfZO3WdP1llImvsPsx7e3TK+I:" -C 
>>> "DHHC-1:00:Jc/My1o0qtLCWRp+sHhAVafdfaS7YQOMYhk9zSmlatobqB8C:"
>>>
>>> The dhchap_ctrl_key is the offending string...
>>>
>> Right. Should be fixed with the attached patch.
>> Can you check?
> 
> Yes, that works.

So, to summarize: With this one and the tentative patch I've sent earlier:

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 53184ac76240..a03f41fa146e 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -842,6 +842,10 @@ int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int 
qid)
                 dev_warn(ctrl->device, "qid %d: no key\n", qid);
                 return -ENOKEY;
         }
+       if (ctrl->opts->dhchap_ctrl_secret && !ctrl->ctrl_key) {
+               dev_warn(ctrl->device, "qid %d: invalid ctrl key\n", qid);
+               return -ENOKEY;
+       }

         mutex_lock(&ctrl->dhchap_auth_mutex);
         /* Check if the context is already queued */



your issues are resolved?
Just to clarify before I sent another round of patches ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

