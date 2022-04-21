Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F9CC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Apr 2022 07:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q69hhjwT+kSjonv8QFdlTZVMurQeV1T2PIMjNcz8AUM=; b=jOWh0GIaMY1cRMqAW6aVgvuimR
	tnLbW56dGoVWV9yZxLqwO2t4rvUUGYxZbL3edQZ0a7zV/15tR8RBb9fxFUAhiIgmjlYPk7FoWnWNm
	1HSWCQJ2QvBbncxABPpYpPlnddU+SDCrspvxjLF4GrwHijw/ENsrR9f8dR1GTyivkwgNdTIc0vmMO
	ovGS0+eFZVcyq6HgMFSAkhLRSaD7wNLhgLmlahFfKWjNzCz6w5NKCxBzJEm7MhNMV0kn3SYd5KmjJ
	eGeSBwffJ9ABI+8SENbS0sBLVSSzbliAvPim9x4u4G1xkN5g49yEwREXqeRayKzni4cIwJyO3ThuZ
	ooFWJZTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nhRNo-00C4Ro-N6; Thu, 21 Apr 2022 07:37:44 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nhRMp-00C3dd-7z
 for linux-nvme@lists.infradead.org; Thu, 21 Apr 2022 07:36:44 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F23031F752;
 Thu, 21 Apr 2022 07:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1650526601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q69hhjwT+kSjonv8QFdlTZVMurQeV1T2PIMjNcz8AUM=;
 b=mdjgoTvvaDF2Ag3Zqw5TpPk8QcQaYVhO//4b31iouM4Py+LJ8/mKSsHLid3sdz5izLLiuV
 FJOEjfr3iZbWnFgzUZOrI8zg2EmQlQZ/fZbz0ZYrUz9xd1bM/so3O7+P061vM1FOGZkhUX
 6rX/AoD0+63e10bLXr/B1SvAgvRnF5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1650526601;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q69hhjwT+kSjonv8QFdlTZVMurQeV1T2PIMjNcz8AUM=;
 b=id70+zebsG7sOnXb7k6LKxwA4b2EWX+tw6TAKsYoO3Nuz8qXpKPs60Q4dMW3heqjNf8wew
 nMDfQuXCV2JR9tBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B535113A84;
 Thu, 21 Apr 2022 07:36:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id D/ZFK4kJYWIwEgAAMHmgww
 (envelope-from <hare@suse.de>); Thu, 21 Apr 2022 07:36:41 +0000
Message-ID: <2683c56f-62c3-987a-72c4-0df5a97368f7@suse.de>
Date: Thu, 21 Apr 2022 09:36:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH RFC 5/5] net/tls: Add observability for AF_TLSH sockets
Content-Language: en-US
To: Chuck Lever <chuck.lever@oracle.com>, netdev@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: ak@tempesta-tech.com, borisp@nvidia.com, simo@redhat.com
References: <165030051838.5073.8699008789153780301.stgit@oracle-102.nfsv4.dev>
 <165030059773.5073.6168640435213548957.stgit@oracle-102.nfsv4.dev>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <165030059773.5073.6168640435213548957.stgit@oracle-102.nfsv4.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220421_003643_540806_488D3CB5 
X-CRM114-Status: UNSURE (   8.46  )
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

On 4/18/22 18:49, Chuck Lever wrote:
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   net/tls/af_tlsh.c |   50 +++++++
>   net/tls/trace.c   |    3
>   net/tls/trace.h   |  355 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 402 insertions(+), 6 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

