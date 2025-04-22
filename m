Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6149EC369D7
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 06:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qxMTVqBp78N5XzmLWG8ccAkqELrbLa18amelVdYylzA=; b=4PEEnXX5qeNHZfSL5Vq3wfGsM4
	VBty2rJl26xUsWUkBhA6aHwiRWcGxClILNmoSVg/ZUCRvX0PSfaHrZoMNmA2LBF8A1n4vI+yHDpik
	LRPKZXEKwgt4R6focRriyAtoj9ULJl/HQb2T1GpwMRP9lWbi5hFIn2QYZ92nkmh2iY/iTE7wur4N6
	Lamn1obku9F922ujvpKk/6C+VoWjl7aLm+Pcy3cAdrn08E81yklpilHIpxVT6KRYexDNydhW02JSo
	i5o25ZtWUyTnAxtHDN2fG/TTOH8INYp8bWo0Not8lxNznjuzeSTP6hh/HJIBqAJ43EHP/5obx5UPN
	yUf8GkQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u77AO-00000005xyc-2d29;
	Tue, 22 Apr 2025 06:31:36 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u777j-00000005xVZ-1ZO4
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 06:28:52 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7911F2121D;
	Tue, 22 Apr 2025 06:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745303329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qxMTVqBp78N5XzmLWG8ccAkqELrbLa18amelVdYylzA=;
	b=Y3ifeju3R9xaV2LLoozE396Cj7rQOSgiYmbdq2zmYfqS449ZSYB3NgtHnR14PEgmj32jav
	uVypqjWSpl7/DAPOMze83WGn+/pc1cKjK0jq6QGh4+ExqF9K8gmhGfV6c57aR6GeZgyPk0
	10/iQbc/qAFPw6BVBNY+/Z93SiX89Wg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745303329;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qxMTVqBp78N5XzmLWG8ccAkqELrbLa18amelVdYylzA=;
	b=Li7vh86Pich7yMzaWGxQjXgWbqOQSKKvDbj6raZ5bqETZU2nOqlkiPehHnYRjsTlpe0UiM
	zRymZgXfFdL2fyCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745303329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qxMTVqBp78N5XzmLWG8ccAkqELrbLa18amelVdYylzA=;
	b=Y3ifeju3R9xaV2LLoozE396Cj7rQOSgiYmbdq2zmYfqS449ZSYB3NgtHnR14PEgmj32jav
	uVypqjWSpl7/DAPOMze83WGn+/pc1cKjK0jq6QGh4+ExqF9K8gmhGfV6c57aR6GeZgyPk0
	10/iQbc/qAFPw6BVBNY+/Z93SiX89Wg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745303329;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qxMTVqBp78N5XzmLWG8ccAkqELrbLa18amelVdYylzA=;
	b=Li7vh86Pich7yMzaWGxQjXgWbqOQSKKvDbj6raZ5bqETZU2nOqlkiPehHnYRjsTlpe0UiM
	zRymZgXfFdL2fyCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 043B0137CF;
	Tue, 22 Apr 2025 06:28:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hRdnOiA3B2jtKAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 22 Apr 2025 06:28:48 +0000
Message-ID: <949760d8-c279-4899-bf4f-62290d78fee6@suse.de>
Date: Tue, 22 Apr 2025 08:28:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 4/4] test: extend sysfs tree dump test
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@kernel.org, kbusch@kernel.org, gjoyce@ibm.com
References: <20250417135951.239447-1-nilay@linux.ibm.com>
 <20250417135951.239447-5-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250417135951.239447-5-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250421_232851_554340_6AF0E72F 
X-CRM114-Status: GOOD (  12.25  )
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

On 4/17/25 15:59, Nilay Shroff wrote:
> In order to validate multipath link support extend the existing sysfs
> tree dump test.
> 
> The updated tree-pcie.tar.xz archive includes a sysfs dump with two
> NVMe subsystems. The nvme-subsys0 simulates a single-port NVMe disk
> with a private namespace that does not support multipath. And another
> nvme-subsys1 simulates a dual-port NVMe disk with a shared namespace
> attached to multiple controllers.
> 
> The json tree dump is also updated to include NVMe namespace path
> information. Since the archive content has changed, the expected
> output file tree-pcie.out is also updated to reflect the new structure.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   src/nvme/json.c                  |  90 +++++++++++++++++++++++++++----
>   test/sysfs/data/tree-pcie.out    |  53 ++++++++++++++----
>   test/sysfs/data/tree-pcie.tar.xz | Bin 19712 -> 12656 bytes
>   3 files changed, 124 insertions(+), 19 deletions(-)
> 
Not a big fan of having tar.gz files in git. Can't we create it on the
fly and only store text files?

Otherwise:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

