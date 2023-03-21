Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD44C74A5B
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Mar 2023 13:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uEitndIR6vyJoSrnYmZ0yeLcVZ8eG+GHXR0xzZiC3v8=; b=m50rOPHcnjObU/9I8cZpwgG6rg
	6jpsVv2CCvCurDiSpREDB/IeyY1g9tugC3bojiEw5RUj+i+fl4m1YyLvyOnxT82CLpnNYgC8rtru2
	G2ofc+GGnougjvN1j6+GJwUZLYjNqVfAnhFRQmEw9W1ztGJwTfaPVy8YBHK90z6c6xxaAC/pydkyk
	eUiOrpK/CW6oif4EPoYV4Uir8uOUxk4vQ+hTvZ/iO2xjk2BHhUyyFU8rCx8okWXv4Irkev9Oxu8QD
	3IeSZqKxfqepgCdSuWf83yVh8EvEho4C4Z0Ne6+F19bEFeSCqPOwhbBN5ca5LShooLzHykNGCBQoZ
	4TN+j7oQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pec40-00CWyO-1S;
	Tue, 21 Mar 2023 13:30:08 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pec3x-00CWvg-2j
	for linux-nvme@lists.infradead.org;
	Tue, 21 Mar 2023 13:30:07 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 28E7821EAF;
	Tue, 21 Mar 2023 13:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1679405401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uEitndIR6vyJoSrnYmZ0yeLcVZ8eG+GHXR0xzZiC3v8=;
	b=u4SIfw6IRVqZbie/ix7H+xAwabNT4TAzglBTkJjuCIdIWD8tRYg8wEt8Dg9UOKMb4nODif
	0leXlBt0uAUVAX4jg18XQ66phIW8JS4N1wVkrQrNn36yR/RvW7pfZoVVXjnnu7YSUGiRkv
	1S3RVkFvaZ9mA7lj7k0H4HFmnMC22JI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1679405401;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uEitndIR6vyJoSrnYmZ0yeLcVZ8eG+GHXR0xzZiC3v8=;
	b=7ns4uT6SycuGd4ozt/kpKxRiWeVqAAGOWHKk1Y8z8xzrDKtK/NHdCyrB4Lb6BDwKbljnbf
	nFOokqcXBSKnL6Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D33D13451;
	Tue, 21 Mar 2023 13:30:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id cFHnBlmxGWS3DwAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 21 Mar 2023 13:30:01 +0000
Message-ID: <f9630511-d843-89fe-64db-1a4c41dbbd08@suse.de>
Date: Tue, 21 Mar 2023 14:30:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH 00/18] nvme: In-kernel TLS support for TCP
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <cel@kernel.org>, kernel-tls-handshake@lists.linux.dev
References: <20230321124325.77385-1-hare@suse.de>
 <98884644-99f3-7b3c-387a-66fbdd98d4ed@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <98884644-99f3-7b3c-387a-66fbdd98d4ed@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_063006_070298_0C02C5AE 
X-CRM114-Status: GOOD (  13.52  )
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

On 3/21/23 14:12, Sagi Grimberg wrote:
> 
>> Hi all,
>>
>> finally I've managed to put all things together and enable in-kernel
>> TLS support for NVMe-over-TCP.
> 
> Hannes (and Chuck) this is great, I'm very happy to see this!
> 
> I'll start a detailed review soon enough.
> 
> Thank you for doing this.
> 
>> The patchset is based on the TLS upcall mechanism from Chuck Lever
>> (cf '[PATCH v7 0/2] Another crack at a handshake upcall mechanism'
>> posted to the linux netdev list), and requires the 'tlshd' userspace
>> daemon (https://github.com/oracle/ktls-utils) for the actual TLS 
>> handshake.
> 
> Do you have an actual link to follow for this patch set?

Sure.

git.kernel.org:/pub/scm/linux/kernel/git/hare/scsi-devel.git
branch tls-netlink.v7

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Frankenstr. 146, 90461 Nürnberg
Managing Directors: I. Totev, A. Myers, A. McDonald, M. B. Moerman
(HRB 36809, AG Nürnberg)


