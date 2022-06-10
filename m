Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C70C43334
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jun 2022 09:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IEk4kiPguK+ZI7lD3B/WuFZa+N1PEfU5yYhI5rhFmPA=; b=IkAL7ewQvlDLPVM+IReJDEQbmq
	jIx4l9AHSxz59MJSZBB6mJrzL8ZlmbUGPilxI+ZxmINu5RZs95+PY0oymKvWRd5xCKnMPN9L9cZSZ
	4vdxIacnHIEzu8TaCFeneZCZdAXOt1dwBN9ZAlxIC9lpQG7rLpuoqgEQ0PcD6GgqlUl2Txms08lj9
	Cd/ji22C3H11YqOD+frUO+AoSnuxXzG3RZ0K49ZnpwpdPc0OKybTR9oUfL5/QdXwgMIoII33S7dV3
	ZD2bal6M+hChxOZAf8XBMEbaGA+WxN/pCVzhLvSHBP0W+38NO1vbh7RZhVkqUbIou6QTckYYEl3tN
	ERPdPDGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzavF-0079Si-Jx; Fri, 10 Jun 2022 09:27:17 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzarr-0077VY-EX
	for linux-nvme@lists.infradead.org; Fri, 10 Jun 2022 09:23:49 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 732812202F;
	Fri, 10 Jun 2022 09:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1654853025; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IEk4kiPguK+ZI7lD3B/WuFZa+N1PEfU5yYhI5rhFmPA=;
	b=PzoZdA2wKenhMBRA/NkGG4X5OklQHp+i2Pvp4YhG2B4ps8BwrDHuLuhlDRX6Mj0IqDq3GC
	gynBW2w/yq14/Al3UnsiBw9aYNovHusroOfzXYANH1oYACvSZ/QkbCEnmFuHjqxB+2rTQh
	gvkbt+nFiO+JAuy6e5l2VA2p/ucoRrE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1654853025;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IEk4kiPguK+ZI7lD3B/WuFZa+N1PEfU5yYhI5rhFmPA=;
	b=rYnNdEtzQ87r0/0xsXuC0gV2wK9PrD659wGy+JkvWBu1FBDmjLjTpkdhNMbrGsf9H0doOn
	fxCPywqAYcAGeuCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 67D3D139ED;
	Fri, 10 Jun 2022 09:23:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id UJYOGaENo2LdXgAAMHmgww
	(envelope-from <hare@suse.de>); Fri, 10 Jun 2022 09:23:45 +0000
Message-ID: <0c092736-29b9-306e-50ad-3e52d1d7af32@suse.de>
Date: Fri, 10 Jun 2022 11:23:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCHv14 00/11] nvme: In-band authentication support
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20220608144518.67607-1-hare@suse.de>
 <bc6d292f-f1f7-3cc4-772b-ef8e2a6466db@nvidia.com>
 <3d2cd533-6bd8-abfa-4df9-40aa6a2eae63@suse.de>
 <55751e76-de76-59e1-541a-6f4c93acc378@suse.de>
 <1951ac91-edf7-815f-bd16-271cb7911e1b@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <1951ac91-edf7-815f-bd16-271cb7911e1b@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220610_022347_668808_204EB8E7 
X-CRM114-Status: UNSURE (   8.70  )
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

On 6/10/22 11:06, Chaitanya Kulkarni wrote:
[ .. ]
> blktests (master) # dmesg  -c
>     810.765135] run blktests nvme/039 at 2022-06-10 02:03:42
> [  810.794825] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [  810.795094] nvmet: nvmet_ns_enable_store 535
> [  810.795098] nvmet: nvmet_ns_enable 555
> [  810.795100] nvmet: nvmet_ns_enable 559
> [  810.795101] nvmet: nvmet_ns_enable 565
> [  810.795102] nvmet: nvmet_ns_enable 573
> *[  810.795108] nvmet: failed to open file /tmp/blktest-ns1.img: (-22)*0
> [  810.797146] nvmet: nvmet_ns_enable 610
> [  810.805542] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:dbdf14ac-d4e5-4a3c-b547-3c39899650e7
> with DH-HMAC-CHAP.
> *[  810.805556] nvme nvme1: qid 0: no key*
> *[  810.805559] nvme nvme1: qid 0: authentication setup failed*
> [  810.824145] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:dbdf14ac-d4e5-4a3c-b547-3c39899650e7
> with DH-HMAC-CHAP.
> [  810.824174] __nvme_auth_work 701
> *[  810.829094] nvme nvme1: qid 0: authenticated with hash hmac(sha256)
> dhgroup null*
> *[  810.829115] nvme nvme1: qid 0: authenticated*
> 
Weird. But I'll update the testcases for the latest master branch; maybe 
it's due to some infrastructure changes.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

