Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20564C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Apr 2022 14:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GFrWyI3pnAaXT81fErIIpvt2wQOvd3gCUyoB7CnENBY=; b=aLMmtfN+L+dkqtXEC2O+VewMgy
	2oc9BOTiWwxHD8UPiKg123nxWPihXjGxgI8VonBEgAcSNzOVbmqSFU8yRLO5k+iJitOV2gNiSdZ0w
	myszWKXLof9cGjP+Qcl5cYPqJU2VGClVdAA4DOJy5hEhOABy3Zsx2RfdOzB0Opev6J9SpUeC9ZQSK
	2baymV8wr2ZRs/GkHGFR9QKyLnY/qlsuG/C7GnPRavmv5ogn2l3opYxSmYXNgqH6oZVwA0Ty3keE4
	mtrDVETLEiUzc56h8IUfYXv72AODtPe+zIMjWLD6Ip1sQX5w+m8Ft4uT4a/YrU0/PzpS0lcY1MZ0r
	77RSMdCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nk4kv-007JJ1-TB; Thu, 28 Apr 2022 14:04:30 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nk4Yl-007DAF-JP
 for linux-nvme@lists.infradead.org; Thu, 28 Apr 2022 13:51:57 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D4AA1210EE;
 Thu, 28 Apr 2022 13:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1651153909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GFrWyI3pnAaXT81fErIIpvt2wQOvd3gCUyoB7CnENBY=;
 b=KTa8ZgmaDnnB2alv1ZPLPdNAvU1N1/4jtghKJNzAvatRFtgpysCCEsn0eKxkY/XAm5hx66
 T4w8fr4e/6/JK8mi8o1B6feyupQfNRUgXV5mgOlj5aOYpZkv0kdYrRkIzCbU+La6X6Cj5J
 XyMh9xzC+z+9MegfHgoWSgJRu4+PV9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1651153909;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GFrWyI3pnAaXT81fErIIpvt2wQOvd3gCUyoB7CnENBY=;
 b=P5rfx4tv3diQ+ps5/9JJimsubqW+dOzfLCLY1HqyvhrkiuBbtJYhDmKvigoGYgCiHxByrq
 L9/YccyDPcTvp4Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A57F313491;
 Thu, 28 Apr 2022 13:51:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SlLlJ/WbamIKVgAAMHmgww
 (envelope-from <hare@suse.de>); Thu, 28 Apr 2022 13:51:49 +0000
Message-ID: <be7e3c4b-8bb5-e818-1402-ac24cbbcb38c@suse.de>
Date: Thu, 28 Apr 2022 15:51:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Chuck Lever <chuck.lever@oracle.com>,
 netdev@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, ak@tempesta-tech.com, borisp@nvidia.com,
 simo@redhat.com
References: <165030051838.5073.8699008789153780301.stgit@oracle-102.nfsv4.dev>
 <165030059051.5073.16723746870370826608.stgit@oracle-102.nfsv4.dev>
 <20220425101459.15484d17@kernel.org>
 <66077b73-c1a4-d2ae-c8e4-3e19e9053171@suse.de>
 <1fca2eda-83e4-fe39-13c8-0e5e7553689b@grimberg.me>
 <20220426080247.19bbb64e@kernel.org>
 <40bc060f-f359-081d-9ba7-fae531cf2cd6@suse.de>
 <20220426170334.3781cd0e@kernel.org>
 <23f497ab-08e3-3a25-26d9-56d94ee92cde@suse.de>
 <20220428063009.0a63a7f9@kernel.org>
From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH RFC 4/5] net/tls: Add support for PF_TLSH (a TLS handshake
 listener)
In-Reply-To: <20220428063009.0a63a7f9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220428_065155_809037_439A5721 
X-CRM114-Status: GOOD (  13.54  )
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

On 4/28/22 15:30, Jakub Kicinski wrote:
> On Thu, 28 Apr 2022 09:26:41 +0200 Hannes Reinecke wrote:
>> The whole thing started off with the problem on _how_ sockets could be
>> passed between kernel and userspace and vice versa.
>> While there is fd passing between processes via AF_UNIX, there is no
>> such mechanism between kernel and userspace.
> 
> Noob question - the kernel <> user space FD sharing is just
> not implemented yet, or somehow fundamentally hard because kernel
> fds are "special"?

Noob reply: wish I knew.
(I somewhat hoped _you_ would've been able to tell me.)

Thing is, the only method I could think of for fd passing is the POSIX 
fd passing via unix_attach_fds()/unix_detach_fds().
But that's AF_UNIX, which really is designed for process-to-process 
communication, not process-to-kernel.
So you probably have to move a similar logic over to AF_NETLINK. And 
design a new interface on how fds should be passed over AF_NETLINK.

But then you have to face the issue that AF_NELINK is essentially UDP, 
and you have _no_ idea if and how many processes do listen on the other 
end. Thing is, you (as the sender) have to copy the fd over to the 
receiving process, so you'd better _hope_ there is a receiving process.
Not to mention that there might be several processes listening in...

And that's something I _definitely_ don't feel comfortable with without 
guidance from the networking folks, so I didn't pursue it further and we 
went with the 'accept()' mechanism Chuck implemented.

I'm open to suggestions, though.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

