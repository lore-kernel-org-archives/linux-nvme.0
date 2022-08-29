Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68CA3ECAAD4
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Aug 2022 09:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tBJPPwC6qCsQKigCyaDrz/0HRDORoX1i5rFmhJheEx4=; b=tWx6RwrEue8YYz86u242+GAq2H
	DN30PqvWiUgXrTmcKWbk+TE8gCvnxOCa1rUSjaT7ER55iDXrKuqBmmcrpY6K9hDfhxTXAdG40b2fO
	tpSym/c8nzL8KVbOiFvQb3rEfv8zHXnTDeRU+LGSy0xtwRTj0aVwVSPR0xpPzqpKY/wiUqWFPrVo4
	6ERQNh1QeF9/C3At83bvnh4ygGi72Jvzr/vGwqOHNdc7aHQWc7RvwHG66lORbIg0picm9DylMBv7j
	z4OqRJ+y36CqHCkhD+k3dkXwVfU4OmBfM89xFrA1S0jShTyBZxA58ZTYjzwAeqzuaCY1JxF+bvUBJ
	dIKvAexA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSawD-006f7x-D7; Mon, 29 Aug 2022 09:20:09 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSawA-006f50-6X
	for linux-nvme@lists.infradead.org; Mon, 29 Aug 2022 09:20:07 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 85E6F33698;
	Mon, 29 Aug 2022 09:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1661764803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tBJPPwC6qCsQKigCyaDrz/0HRDORoX1i5rFmhJheEx4=;
	b=kFmLWqwI7INXw6K8TkZL3mNs7/r2US5mqlP7qFfqpcuJInLrNPAPJ/JcmWDnx06YY4pW04
	Y8r4Ih9W5sVeZL8vrREKTdGyGu9yqOunCCrwye5eHQ2nOuN2D/Sh5uDQ3lCWdb1PlguUFm
	mbkzFWBRuRO34Yc/toZzjgSdJpefY/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1661764803;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tBJPPwC6qCsQKigCyaDrz/0HRDORoX1i5rFmhJheEx4=;
	b=J9hDu0Fzp7HM7vXRPtei/+4vN8azLZzvZyuh5zHjUhHXGO/a5sQfL7x/M5NEyezR41QuBa
	es3M1VsAUvdEdmDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 705701352A;
	Mon, 29 Aug 2022 09:20:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id oWkoG8OEDGNfJgAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 29 Aug 2022 09:20:03 +0000
Message-ID: <40c3d840-88ca-18c8-40a7-030bdf3964a5@suse.de>
Date: Mon, 29 Aug 2022 11:20:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 0/3] Handle number of queue changes
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
 Chao Leng <lengchao@huawei.com>
References: <20220829083856.1850-1-dwagner@suse.de>
 <f8ee0fd3-45c2-7848-aa5a-6627c7672349@suse.de>
 <20220829091752.keztco4tonustfj4@carbon.lan>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220829091752.keztco4tonustfj4@carbon.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220829_022006_589176_46075B71 
X-CRM114-Status: GOOD (  10.27  )
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

On 8/29/22 11:17, Daniel Wagner wrote:
> On Mon, Aug 29, 2022 at 11:07:00AM +0200, Hannes Reinecke wrote:
>> One does wonder: what about FC?
>> Does it suffer from the same problems?
> 
> No idea, I'll look into it.

And while we're at it, a blktest would be grand...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

