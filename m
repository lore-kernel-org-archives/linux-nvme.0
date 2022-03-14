Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43009C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Mar 2022 12:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Subject:From:References:To:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N37TTnn2utj4I/pgjrB5NDzuJTSw1PpPf0cQec9YUOI=; b=ZFyBcMhvNxISXDV3b+9rA815t7
	lsXaQBYv++G1jhhcWHEPBcnVQDtyIi0T4oiII2p6kCCP94HlAT0wRO5tk/nfzkQ11b2lMNRJA6X83
	RUTBzrIHJf8NVSmLh9KWgHKwFz8F3MMN16/U0Ogcla+DE0wLqN5Wodk0Uc7qJEl+exO6zywfb4Hq4
	ur600rQhQaALqjMHxLk2mt0MlN/pYQ4DPc41DMKpYag5GE/p7gjgDIid73LoIKGWUc4cF4xtlcdwB
	ftftSh9Wvxcn7cwcJofkJlIIFhNsG5EL9FmcsnZwk6lJCEnAowK3M+9JjhTHJE7DDgUg1CofgzTHC
	X140YVRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTk9k-005T8G-7D; Mon, 14 Mar 2022 12:50:36 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTk9h-005T7m-JI
 for linux-nvme@lists.infradead.org; Mon, 14 Mar 2022 12:50:35 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B15AE1F388;
 Mon, 14 Mar 2022 12:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1647262231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N37TTnn2utj4I/pgjrB5NDzuJTSw1PpPf0cQec9YUOI=;
 b=Lvt/GVsGYVp+7GTyrMnqxMiQuW3CTTnYhnWVamcrb+Z+jo1lZl3FXsc+tYi5tw5/l0odnu
 8VYttt2TbBkXd7K8iGiCrUdC7INISezoAd4VcAeiE4vI6cofKuJe7Zt7KdZoTvNd8jK8mA
 v89gXTUIEVgbNdRI9UX1ZOAGWtbtfWc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1647262231;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N37TTnn2utj4I/pgjrB5NDzuJTSw1PpPf0cQec9YUOI=;
 b=jbmte+oVnYLPn734zuzSAReopgKjWsNA460BPoKFhYMYU2Qoypgl22Zq+9mnqcjOsJbuH+
 B8sFhzjXV8dm4xAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A0C7313B34;
 Mon, 14 Mar 2022 12:50:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OBLgJhc6L2KiSwAAMHmgww
 (envelope-from <hare@suse.de>); Mon, 14 Mar 2022 12:50:31 +0000
Message-ID: <81d6a8c3-8fc8-cae4-cbfb-32594dec55b6@suse.de>
Date: Mon, 14 Mar 2022 13:50:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To: Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
 lsf-pc@lists.linux-foundation.org, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <1cc5dd40-47e5-0756-db22-42e4e86468c5@redhat.com>
 <ab4cb09f-cecb-0c1c-36e7-07db2556bc61@suse.com>
From: Hannes Reinecke <hare@suse.de>
Subject: Re: [LSF/MM/BPF TOPIC] network storage transports managed within a
 container
In-Reply-To: <ab4cb09f-cecb-0c1c-36e7-07db2556bc61@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220314_055033_810057_458E5273 
X-CRM114-Status: GOOD (  12.09  )
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

On 3/1/22 20:20, Lee Duncan wrote:
> On 2/28/22 18:04, Chris Leech wrote:
>> There are various challenges when users start trying to manage SAN
>> attachments from within a container, and how we deal with network
>> namespaces.  I think it would be worth a discussion around what can be
>> agreed on as desired behavior, and what it means to attach block
>> devices from a containerized environment.
>>
>> iSCSI has a number of issues here with the kernel to iscsid
>> interfaces, netlink and sysfs, which are largely fixable without
>> needing to break anything.  But for kernel maintained network
>> connections, there's an issue of interacting with namespace lifetimes
>> without a process.
>>
>> NVMe/TCP has avoided complex user-space control planes, but when I
>> checked subsystem connection occurred within the active namespace of
>> nvme-cli, but afterwords all fabrics subsystems were visible,
>> controllable, and disconnectable from any namespace.
>>
>>
>> Lee Duncan had submitted a proposal to discuss this for iSCSI last
>> year [1], partially based on some older work I did that never
>> completed [2] (I need to update that code)
>>
>> [1]
>> https://lore.kernel.org/linux-scsi/e9f0297a-a914-ba83-f706-5a2d508c666b@suse.com/ 
>>
>>
>> [2] https://github.com/cleech/linux/commits/iscsi-netns-old-wip
>>
>> - Chris Leech
>>
> 
> I would certainly be interested in attending this.
> 
Count me in.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

