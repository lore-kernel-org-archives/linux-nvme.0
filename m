Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1458DC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Feb 2022 11:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Sek9apgOY8JmQpHf0UZOWethgc2qM4msvxmzz19IDxE=; b=4KqA7O8HsHfXYAvZf36O7r6hQ2
	tJL91H++SqSXZ6fo00qy38OSbXqbw8PaXRGbk8rFcmqiUTubFtz12Bgzc2U/V2gf8n7AnjaE8TGLo
	kiGZU85N8A/+BXpGSp3YqAMNP/rxSq3scJHxy24TPKw0OYnAwrV2VIMLtdluwD4685omdJlNF+sMd
	n5NtUYENod3VIP6Uq/F9uphd3uhmivPQfKFMMN3gInTAweFapQT1OiGrJA5GrvM92BOobs9A0pSLM
	VDHeLAQZFmHEWqel/hN9F7U2Ix2x5MocyktvmA+qofrk7AeXfXXeDbz984OvGfp71zMPUVDjUXIf8
	aJYFgDDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nMTX8-009RAg-98; Tue, 22 Feb 2022 11:40:42 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nMTX4-009R86-M0
 for linux-nvme@lists.infradead.org; Tue, 22 Feb 2022 11:40:40 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BA3D6210FA;
 Tue, 22 Feb 2022 11:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1645530036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sek9apgOY8JmQpHf0UZOWethgc2qM4msvxmzz19IDxE=;
 b=W4VvVaMmp7kqJ1i+e61+wkvPBrIDP7mdJnXVi+pGCMML9g1gndrsEnQnB1Y93xSBAccDN2
 AwmWjnPLPpa/ve/mjx2uqDQTKdZtuiP5U7pfhG95V36ZpVYk4GDDimLawmGI/Ir7o+hHVy
 NfWrMnM11Kc0tpSFz04h8CwEfZ5PGIg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1645530036;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sek9apgOY8JmQpHf0UZOWethgc2qM4msvxmzz19IDxE=;
 b=djqohL7gYf3xFaMl7WRMwBEKehlDKfuON5Cmh/xQoguif0VPfibw+dM1LnTnAL30HMNMko
 elgWpdNUG6iVDrBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A3B2113C26;
 Tue, 22 Feb 2022 11:40:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +7nbJrTLFGLkIwAAMHmgww
 (envelope-from <hare@suse.de>); Tue, 22 Feb 2022 11:40:36 +0000
Message-ID: <a6f477cf-d703-bcc8-c946-e04f99f7b801@suse.de>
Date: Tue, 22 Feb 2022 12:40:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] nvmet: parametrize maximum number of namespaces
Content-Language: en-US
To: Alex Talker <alextalker@yandex.ru>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20220222085415.292729-1-alextalker@ya.ru>
 <c400d418-8fb2-a603-d669-077b2d09f789@suse.de>
 <2c0cae51-44a5-e156-cfb4-6e00c9d0c7b1@nvidia.com>
 <7db5c527-3448-90f5-96e0-6849c00ac461@yandex.ru>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
In-Reply-To: <7db5c527-3448-90f5-96e0-6849c00ac461@yandex.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220222_034038_895841_538A0C70 
X-CRM114-Status: GOOD (  17.01  )
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

On 2/22/22 11:25, Alex Talker wrote:
>> Please no module param for this, right place is configfs subsys
>> attr.
> 
> That makes sense, I agree but I mainly aimed to start off with a simple
> change(replacing macro with load-time value, unchangeable at runtime).
> 
> So if I'd add this to /sys/kernel/configfs/nvmet/subsystems/<NQN> folder
> as, say attr_max_namespaces,
> what would you propose on:
> 1. Storing the value? Would it make sense to specify it directly as NN
> or MNAN value or the like?
> 2. What to do if set value is lower than the current value? Abort if
> there's greater number of enabled namespaces than the specified value?
> 
Relatively easy, and actually driven by the nvme controller model.
Turns out that the values in 'identify controller' are static, and
cannot be changed during the lifetime of a controller.
Consequently you can only modify them if there is no active controller
connected to the subsystem.
Similarly it doesn't make sense to have NN lower than the maximum ANA
grpid of the enabled namespaces, so I would inhibit that.
And yes, the 'attr_max_namespaces' should be set to the 'MNAN' value (as
we're supporting ANA in the target).

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		        Kernel Storage Architect
hare@suse.de			               +49 911 74053 688
SUSE Software Solutions Germany GmbH, 90409 Nürnberg
GF: F. Imendörffer, HRB 36809 (AG Nürnberg)

