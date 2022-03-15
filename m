Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15930C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 09:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=30LSGMYMitX+GE/+pDy1BICKzQQv4AD9JutHG07ZJ2g=; b=QaKxiVuvzEFDHxRJCSVWWcawb/
	H6Qcr8JVBa5D7bp1YDgIYj5Mz12CbE46PAm7v8CUsZ07Ty+oBQ/YB39BWwTcokWNuZlrBTWDHazeP
	rClarlrnwglQZ9NqDu2TaOhN8XCzBDBmtKSb0KdCTFbBHrt+CTPE9XTCgzq3TItqLx2kcD1wwhYoM
	qP0aX+dYoV8TIiyNbOXcSc5S52YLIB1zvF3a72sU0n0pQailRpwKyySq8nYepnbkh9EpxmUaMwkDd
	vsQ71Vf8Fv6abzL7bjWKzCr+tM6FJuhwK0xyASWcNCtUQPkS2n6Wgy2TKdeAWVcdIe3SCkmHh60C8
	PaEzyV8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU38R-008QlM-Su; Tue, 15 Mar 2022 09:06:31 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU38O-008Qk5-CU
 for linux-nvme@lists.infradead.org; Tue, 15 Mar 2022 09:06:29 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F2BC12190B;
 Tue, 15 Mar 2022 09:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1647335186; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=30LSGMYMitX+GE/+pDy1BICKzQQv4AD9JutHG07ZJ2g=;
 b=kFgjj9vAci6MEwZk8gWZWC7Duy3odlNVJfpOvjvqoDxHrNwCxE81msJkoMJPS2og1WaqH2
 GTAGb53nHQqUFHUEIMl0oPsyDtzDMkHFAp93MC+2sGSrL80PqBO/+tyxPu8VkOFVKnbvdb
 qmYN/cBosM2h3YjbJEUx4CHmhqoSDt0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1647335186;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=30LSGMYMitX+GE/+pDy1BICKzQQv4AD9JutHG07ZJ2g=;
 b=4RrRUP3CRdMNnSgqXHRGNQaWXOYp61WiUGTwSlVMKrL3HZ1WWXun56hqeE3O+Hw6sGeoIP
 7GkzINJYq8BRiaCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E5FCB13B4E;
 Tue, 15 Mar 2022 09:06:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id nb7pNxJXMGJGdgAAMHmgww
 (envelope-from <hare@suse.de>); Tue, 15 Mar 2022 09:06:26 +0000
Message-ID: <ec115fe9-2b3f-8f31-d3b8-b85686c2788a@suse.de>
Date: Tue, 15 Mar 2022 10:06:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20220314105333.56714-1-hare@suse.de>
 <20220314105333.56714-2-hare@suse.de> <20220315080602.GA3082@lst.de>
 <f2fb9eea-8c9c-cb95-5380-2a10b6ce3f46@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 1/3] nvmet: expose discovery subsystem in sysfs
In-Reply-To: <f2fb9eea-8c9c-cb95-5380-2a10b6ce3f46@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_020628_598724_4D6C8C2E 
X-CRM114-Status: GOOD (  13.87  )
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

On 3/15/22 09:40, Sagi Grimberg wrote:
> 
>>> Expose the discovery subsystem in sysfs instead of having it as
>>> an internal structure. This requires the admin to manually
>>> enable the discovery subsystem by linking it to a port, but
>>> this can be seen as a feature as it will allows us to expose
>>> subsystems without discovery subsystems and discovery subsystems
>>> with no I/O subsystems.
>>
>> ... and completely breaks any existing setup.
> 
> Yes, this needs to be backward compatible...

The core question really is: do we _want_ to expose the discovery 
subsystem in configfs?
(And this was actually why I prefixed this series with 'RFC').

Unfortunately, exposing the discovery subsystem and trying to configure 
it with configfs does _not_ match with the way discovery is implemented 
today. While we currently only have a single discovery subsystem, it 
will only ever return the subsystems visible from this particular port.
(So really, it's more like a discovery subsystem per port.)
When using configfs we can link ports to the subsystem, but seeing that 
we'll only ever have _one_ discovery subsystem we cannot restrict the 
discovery log page contents to that specific port.

Hence this rather simple approach, having the 'normal' discovery 
subsystem exposed, and let the admin configure it accordingly.

But yes, this approach is not backward compatible, or, rather, backwards 
compatible only after it has been configured accordingly.

I can look at keeping the internal implementation, and only expose 
unique discovery controller (ie those with a unique subsystem NQN).
That would remove the need to having the 'discovery_nqn' attribute, and 
address Christophs concerns.

Hmm.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

