Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4515BC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 08:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S7RWVEY8nY4ugQXehM1e6I9FLrBw6o9A+onsuUC+XBw=; b=oBPTyW2aO0C0jzmKJDG/vMYXd2
	YQDzDUx3xjUCKoU/pgWB9Mbo9uyqx2RMAUTlWsacjUHm6kq63/ryxEp1rhvlZDLIgv0+vIgBsH4G1
	QF67LfCNyqh5+0t11ORJSnc9o5fype3YFWa0W4B0DCFHMlemOR0gop9S9iOMaIjzLxBw3D1X8tLih
	k0cP40kgFyBeWAtHTu1a48Szv7dvuSKawzvSFFZ8Wc/8U8yRm46drQ/IYevRYpT6gcq8TGK6X1NvZ
	wb8qe3Uw9EZS/I5HPquFj2o0N3Hdf217LESa+Npw+/rGshxrBopdNxb+KxzvMWfr8sGxmJ09b1yh8
	qS+WjBbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU2o7-008L6g-OY; Tue, 15 Mar 2022 08:45:31 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU2o4-008L4p-91
 for linux-nvme@lists.infradead.org; Tue, 15 Mar 2022 08:45:29 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D1F711F37E;
 Tue, 15 Mar 2022 08:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1647333923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S7RWVEY8nY4ugQXehM1e6I9FLrBw6o9A+onsuUC+XBw=;
 b=eiwrgQZEN+87CVfyeTMia71idVcjKjLlADdBjVO07jUldWgknsvVzISlGjiJbR0AhKt5au
 Hp3Nm4Jae2oB0KCcQI3UNRoZw8TrY1rSr0TPaLgFTF/r+UJEwJYPe6oZsVWWN1uUu93PzK
 AO14tVCByczAhY9vs6EeDGT0joUgr4U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1647333923;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S7RWVEY8nY4ugQXehM1e6I9FLrBw6o9A+onsuUC+XBw=;
 b=BsT+SFWuHWHgmPBFiU4cZ6eyd4UxYJmUdOIqgZo8D6MieTSFH+ASzsqVKzEfCXuYFByM+q
 iXmJONMAyto2wiCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BCD1013B4E;
 Tue, 15 Mar 2022 08:45:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id PuzVLCNSMGJYbAAAMHmgww
 (envelope-from <hare@suse.de>); Tue, 15 Mar 2022 08:45:23 +0000
Message-ID: <ccd90b4c-7517-fd04-fcac-f1274460af3c@suse.de>
Date: Tue, 15 Mar 2022 09:45:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 3/3] nvmet: do not allow to create a subsystem with the
 discovery NQN
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20220314105333.56714-1-hare@suse.de>
 <20220314105333.56714-4-hare@suse.de> <20220315081013.GC3082@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220315081013.GC3082@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_014528_568285_A8D14177 
X-CRM114-Status: GOOD (  14.76  )
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

On 3/15/22 09:10, Christoph Hellwig wrote:
> On Mon, Mar 14, 2022 at 11:53:33AM +0100, Hannes Reinecke wrote:
>> configfs will only protect us against duplication of subsystem NQNs,
>> but discovery subsystems might have two NQNs, the standard discovery NQN
>> (which will be used as the configfs directory name), and the additional
>> unique subsystem NQN.
> 
> This is something that we should probably pick up as fix ASAP.  Can
> you add a proper fixes tag and submit it stand-alone?

Will need to rework the patch, as in its current form it relies on the 
discovery subsystem to be exposed in configfs.
But yes, can do.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

