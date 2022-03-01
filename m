Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E590C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Mar 2022 07:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CuW1vIzHyoUIoNGKAP81NHK+MwN4d/SejoMX4ssNxV8=; b=q8aCfIl93wslRz4h41Gv81QbQ9
	76dTVGWki1rB3fh+1lWb00Ne2Z/uO5YKeoTLjo8xa/f85FewSPAWQ9/uTm42f/Z1y7ejk65PiCEbQ
	+aAqYnNQkf8jetQx1nATJKqYXfuuVDe23LILhA5D9WTQdk+z6TyilLkMJqCvK8w/K8M4Gp6Qc8tCq
	B/oiIUIrsUJmWDQHKxw/WsXmYm5yAKhZaoBlshqaa9fTV+zBImCX662oNjbfZ4fnJXrQlYJwyQ488
	yvDtpBSm7VwlYBXk7dVFRDbdNQz3k1HFFUr3npR/slv14OMzKkuvaZT2yoeap8MwRoTLDsUuEP7eQ
	EzRhHqEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nOwZt-00FFQy-PR; Tue, 01 Mar 2022 07:05:45 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nOwZm-00FFQC-HS
 for linux-nvme@lists.infradead.org; Tue, 01 Mar 2022 07:05:44 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7C2541F37E;
 Tue,  1 Mar 2022 07:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1646118335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CuW1vIzHyoUIoNGKAP81NHK+MwN4d/SejoMX4ssNxV8=;
 b=vIdpC7IHqIKC4HPf0soAfaW3J2fi1uSRS1EyIjOrFBifQZcoqG0GwrRuzTEb7pA29CYyTt
 v1Q6FSe9ZRoNJP2lQimiQYBN0IXKPtdwgqm4lzqTy+/Oo4VmSx5trk1iqnSUmJp+KmJWlW
 FiUMObYiMsF9NOCVp8qUa31bjgouc3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1646118335;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CuW1vIzHyoUIoNGKAP81NHK+MwN4d/SejoMX4ssNxV8=;
 b=CrnR3a/dzIyCoTrI5ohfSNNhjZ+PiYvOY/YC01pDSjHxqD1sOEW9cjitKwVWyJX7H8CVQa
 qQEEvsgummBQlPAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5F7CB139EF;
 Tue,  1 Mar 2022 07:05:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kIYFFr/FHWJxIQAAMHmgww
 (envelope-from <hare@suse.de>); Tue, 01 Mar 2022 07:05:35 +0000
Message-ID: <5109f07b-b99d-5e3b-f5b3-410fbbbdfcd4@suse.de>
Date: Tue, 1 Mar 2022 08:05:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: Nvmet discovery implementation. Questions and a patch / proposal.
Content-Language: en-US
To: Mark Ruijter <mruijter@primelogic.nl>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: Sagi Grimberg <sagi@grimberg.me>
References: <1B761FBE-58C8-4A52-9747-42ED84A6D383@primelogic.nl>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <1B761FBE-58C8-4A52-9747-42ED84A6D383@primelogic.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220228_230538_769290_6048BFC2 
X-CRM114-Status: GOOD (  18.85  )
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

On 2/28/22 17:39, Mark Ruijter wrote:
> 
> The current discovery implementation only works after a subsystem has been created and has been linked to a port.
> As a result, 'nvme discover' from an initiator will only show a discovery device after the first subsystem has
> been exported.
> 
> The patch that I propose adds these features:
> A. Make discovery work immediately after the target port has been configured, without needing to configure
>    subsystems first.
> B. Move the discovery_nqn configuration option to the port instead of having the same configuration option
>    duplicated in every subsystem.
> C. Allow to enable and disable a target port without needing to unlink target subsystems.
> 
The current nvmet discovery implementation was designed to the original 
NVMe spec, where a discovery controller could only return informations 
about the attached subsystems.
But with the recent changes to the spec a discovery controller can now 
return information about itself (ie which port it's running on), and so
it does makes sense to have it enabled even with no subsystems attached.

But: the current implementation only has a _single_ discovery subsystem 
(nvmet_disc_subsys), which is shared across all configured subsystems.
And there's a filter when generating the discovery log page such that 
only the information for the current subsystem is returned (cf 
nvmet_execute_disc_get_log_page()).
So in effect each subsystem has its own discovery subsystem.

Moving the discovery nqn to the port will only confuse matters, as then 
it's quite unclear what will happen if you change the discovery 
subsystem nqn on a per-port basis; with the current design you would
change it for _all_ discovery subsystem ...

So if you want to do something like this, you'd need to change the 
implementation to have a discovery subsystem per port, and also change 
the logic in drivers/nvme/target/discovery.c such that the discovery
subsystems will return informations for _all_ configured subsystems.

It's actually something I wanted to do, too, as I didn't like the 
current implementation :-)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

