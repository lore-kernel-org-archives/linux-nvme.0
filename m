Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E2A4C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Apr 2022 07:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5J/d+SM7KHL9BwwpEelR22zLqcl+L3PD3ZatS4fmTLU=; b=ue4IhNAkGK79r1kIMPg8w/eRru
	4fTCrk91crecri59qk2ym3bOMk4sXPMEA3WQFhl24ASVAoAzWI3IERaSf98Ty9ZFdPBzr7IeOz93R
	Z7IbctRlZ4FE2g7/T8IpyXe7fF5W2YZoGCNOwFL2yjdUaIDm1LcXfKykj5YXsmThpXfYfw+fT0fHU
	NEKZuymu3rU4VKW4YfO8pu6+nRy0hLbkU9bg+6+RwGCOQmvjiHh6P8OzFywxdZYCrdBu2e8wz2SgT
	ad4QRd9HFzaj+igAldyO+rXty1+JpHwzd+rkwKbT5aauRC7L03ok7gOnQNY2oAim/wa7OxxAAbwn6
	asMG0YkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nhRLx-00C2wy-IB; Thu, 21 Apr 2022 07:35:49 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nhRLt-00C2ui-Vc
 for linux-nvme@lists.infradead.org; Thu, 21 Apr 2022 07:35:47 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9AFA21F753;
 Thu, 21 Apr 2022 07:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1650526544; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5J/d+SM7KHL9BwwpEelR22zLqcl+L3PD3ZatS4fmTLU=;
 b=cAb1NvX9EPQRjHLDGalKC2jKWS2yvR5AqagsSmTe/QiyCyeeFIoxFQNsdOr+42kA+6e8GH
 Hwl5MgrKv4sJFhYj03IBoKpdDr7BL/FAb5ZcAorOFWSmwHin8G/UwlZ7XvDjQfZvFvgvZn
 UYVyJOPLSv/4ou4fpkAHp6ztRcWrUKw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1650526544;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5J/d+SM7KHL9BwwpEelR22zLqcl+L3PD3ZatS4fmTLU=;
 b=6CPPkWYj7r3kuQRcRa41jhwfeLW7pMs++61sJes7hTzz11ie/PUcC/YhaIWG8vejWSt/0w
 D1GweOfeRzxDzqDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6C79413A84;
 Thu, 21 Apr 2022 07:35:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8SfeGFAJYWKvEQAAMHmgww
 (envelope-from <hare@suse.de>); Thu, 21 Apr 2022 07:35:44 +0000
Message-ID: <437ef42d-1c7e-5140-d89f-66bd1ab7293c@suse.de>
Date: Thu, 21 Apr 2022 09:35:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH RFC 3/5] net/tls: Add an AF_TLSH address family
Content-Language: en-US
To: Chuck Lever <chuck.lever@oracle.com>, netdev@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: ak@tempesta-tech.com, borisp@nvidia.com, simo@redhat.com
References: <165030051838.5073.8699008789153780301.stgit@oracle-102.nfsv4.dev>
 <165030058340.5073.5461321687798728373.stgit@oracle-102.nfsv4.dev>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <165030058340.5073.5461321687798728373.stgit@oracle-102.nfsv4.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220421_003546_184235_455FD299 
X-CRM114-Status: GOOD (  10.06  )
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
> Add definitions for an AF_TLSH address family. The next patch
> explains its purpose and operation.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   include/linux/socket.h                         |    4 +++-
>   net/core/sock.c                                |    2 +-
>   net/socket.c                                   |    1 +
>   security/selinux/hooks.c                       |    4 +++-
>   security/selinux/include/classmap.h            |    4 +++-
>   tools/perf/trace/beauty/include/linux/socket.h |    4 +++-
>   6 files changed, 14 insertions(+), 5 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

