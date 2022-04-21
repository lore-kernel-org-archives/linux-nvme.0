Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C1CC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Apr 2022 07:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B+HIkqvJLteia0esz/c1R+ShVrYpZv/KOM+i5bqa5bI=; b=lNaHE0MnxFqm1qQaO5wNpiklG3
	iaJczJ7v9R0sCJOjlA97r+D+Gz1uZvSmS6R+tN6w6FDF34UpHkBkVjcLh1RVXpbrBDW2t9sQBFala
	iJgoFHVs3+ishfWcCZE9/iX2anTh7CEZKxKsG4QuVieX4wDEQ+C0iQ/zgmYOc6MeBck5jI6E2U0Da
	+D2rAofpwznI9tx/eF2SRJC0LwD7dmZibpkTNrfuSDrORLRw8rAVeuLm/2n75tC+zmULnAyH+ls83
	5zUXoeRn0ZBNjxfCayDPrBbwaIQt4u96Pf/UN4yFheb/zYrFvXB6rsTFyW6U8Rgmz98c10yApZAne
	hPoBHrzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nhRLL-00C2jK-KO; Thu, 21 Apr 2022 07:35:11 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nhRLI-00C2h5-KN
 for linux-nvme@lists.infradead.org; Thu, 21 Apr 2022 07:35:10 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4E90A1F768;
 Thu, 21 Apr 2022 07:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1650526506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B+HIkqvJLteia0esz/c1R+ShVrYpZv/KOM+i5bqa5bI=;
 b=eKFBQIyNZSHAG9IjLiOquElLqMY9PFbSrMPMmch+pvdSSVMhEVa2p1LZp/8yDnS+ZRz/+K
 8LSEElyiipcKVP/SMULzhy5ApE7DsYwhZvUDgXc8L4+LOpa6mKnMnpfpcPNtFIvn33MBx8
 NzPNGLH+6kmduphpJA86f49LaLn7384=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1650526506;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B+HIkqvJLteia0esz/c1R+ShVrYpZv/KOM+i5bqa5bI=;
 b=eUB4zOR8pj5zrlYlITI46UDTDMVYlKdqGlmXb4LNWatQEKfFoE0WXe8OrUi+DM8arVnH+C
 KvV/G27vHIr805Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0B5AE13A84;
 Thu, 21 Apr 2022 07:35:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id AnJvAioJYWJfEQAAMHmgww
 (envelope-from <hare@suse.de>); Thu, 21 Apr 2022 07:35:06 +0000
Message-ID: <325938d3-bb82-730b-046c-451dde8cc14c@suse.de>
Date: Thu, 21 Apr 2022 09:35:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH RFC 1/5] net: Add distinct sk_psock field
Content-Language: en-US
To: Chuck Lever <chuck.lever@oracle.com>, netdev@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: ak@tempesta-tech.com, borisp@nvidia.com, simo@redhat.com
References: <165030051838.5073.8699008789153780301.stgit@oracle-102.nfsv4.dev>
 <165030056960.5073.6664402939918720250.stgit@oracle-102.nfsv4.dev>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <165030056960.5073.6664402939918720250.stgit@oracle-102.nfsv4.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220421_003508_848221_8AFF0CBB 
X-CRM114-Status: GOOD (  17.52  )
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

On 4/18/22 18:49, Chuck Lever wrote:
> The sk_psock facility populates the sk_user_data field with the
> address of an extra bit of metadata. User space sockets never
> populate the sk_user_data field, so this has worked out fine.
> 
> However, kernel consumers such as the RPC client and server do
> populate the sk_user_data field. The sk_psock() function cannot tell
> that the content of sk_user_data does not point to psock metadata,
> so it will happily return a pointer to something else, cast to a
> struct sk_psock.
> 
> Thus kernel consumers and psock currently cannot co-exist.
> 
> We could educate sk_psock() to return NULL if sk_user_data does
> not point to a struct sk_psock. However, a more general solution
> that enables full co-existence psock and other uses of sk_user_data
> might be more interesting.
> 
> Move the struct sk_psock address to its own pointer field so that
> the contents of the sk_user_data field is preserved.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   include/linux/skmsg.h |    2 +-
>   include/net/sock.h    |    4 +++-
>   net/core/skmsg.c      |    6 +++---
>   3 files changed, 7 insertions(+), 5 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

