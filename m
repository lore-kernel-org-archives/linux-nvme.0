Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04809C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Apr 2022 17:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fjeXYoAED0kdkHyrRTQYhWgP7997l5hHLM1SQZlbinc=; b=YqLiIVlNKsEl7C3TpOib/B8nWe
	AHib+zuh4IJaHs5NQ5AVgBv9bASvrNqXQ68qFY3o9rInzbDbAKjPuOgDNYtiFb4wDwznZLKuzmtM2
	DB3xSn5M3j07mmlXkduitJXyVK/FsMGQcdF/GAM0VPu2KbywBJ18FyQ53f9svwvfbZGeyednEJbhN
	dxTtri2en5JMN0w8u61EtwKixhthEe3n1cjhSPETeyiXyYkYfE2/+89Wqf0tzuKmsv5xCuD9MClqk
	XQeb1TBKc/cr3wE3AnpM6U3eWEb0Xxx7d3kwXLOaSr6gMoa01LJ8+cmcP2LnJ+kxZ9dcMQ6A6fFlo
	irGyHEyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nj2FI-00AYXK-50; Mon, 25 Apr 2022 17:11:32 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nj2FF-00AYX1-Df
 for linux-nvme@lists.infradead.org; Mon, 25 Apr 2022 17:11:30 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3894661515;
 Mon, 25 Apr 2022 17:11:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31CC6C385A7;
 Mon, 25 Apr 2022 17:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650906687;
 bh=+bgp0PfSTA56OI/cMQNiiWX7cdawrhm8C4d75Ow+If4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=KYWt7eUYGSFAvr/Q6cedy60WfBDeIUGU5kVNpwszBm1hC4HazvvJ37RtMC3sUrw3m
 XTICnlfapX5xfG8Kpf2GKjCpg4ZYW9N05NyzJ7JIG+rvm/CG0YiTqanDmom4e5kPnZ
 f29mybYSk/SUUCCT7h79rmWanjEyeWH+HrzYgyW6pwiUjbtRnhc7QkWsV5+hb6+BOH
 qD3IFU2pasMZgbStcsIKbzzT7nJKMyl6tmTBDJzKgorW3txcyOhKeI6a9hB2f5O+It
 1+p4uKQrKi1WgdTvZuw2BQrolj3tu16PD4Tf0ieZGmDNNsjxmRHQzkn/PJoQyQnPVc
 0rlhgf+IrkuvQ==
Date: Mon, 25 Apr 2022 10:11:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: netdev@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, ak@tempesta-tech.com, borisp@nvidia.com,
 simo@redhat.com
Subject: Re: [PATCH RFC 2/5] tls: build proto after context has been
 initialized
Message-ID: <20220425101126.0efa9f51@kernel.org>
In-Reply-To: <165030057652.5073.10364318727607743572.stgit@oracle-102.nfsv4.dev>
References: <165030051838.5073.8699008789153780301.stgit@oracle-102.nfsv4.dev>
 <165030057652.5073.10364318727607743572.stgit@oracle-102.nfsv4.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220425_101129_547821_5F713CAC 
X-CRM114-Status: UNSURE (   8.57  )
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

On Mon, 18 Apr 2022 12:49:36 -0400 Chuck Lever wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> We have to build the proto ops only after the context has been
> initialized, as otherwise we might crash when I/O is ongoing
> during initialisation.

Can you say more about the crash you see? protos are not used until 
at least one socket calls update_sk_prot().

