Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D206CC7EE23
	for <linux-nvme@archiver.kernel.org>; Mon, 15 May 2023 17:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j2msEUStbZgsGPWRMf2BCODl+2adw4zpJFULujwK2sI=; b=kd96YMmX/m+zeKCnwUqGH17QhO
	iBenPEyTZayez9Wbf71WYizU2Do7tKt61619VNStYwyH99DYyY1509flOQKwzgIOiWWWXsKnA/BgP
	nICYpEFIDstqrIEg0q54NeiFIKhSC6Zu3GVzvIIxmESgttlvj3O//P6GJ/ss3lnbtXduUya69x8yL
	mZPcBq8Owgn9c9eXwbp1eX9kM+uiY1Rs0NjcLPdoUFD/KNFOuWBM71nFUQ3yem7QxQm6J8J/IsGZt
	dTIhoMH6sjUcUf7dDnmdIvHP/89aUw8oWcnFaC/EPazN8wHtcrx63cPWCSpTUhoA/3tV/8PfzS321
	8+MQBoww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pybu2-002vbw-33;
	Mon, 15 May 2023 17:22:30 +0000
Received: from smtp-28.smtpout.orange.fr ([80.12.242.28] helo=smtp.smtpout.orange.fr)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pybtz-002vYo-1U
	for linux-nvme@lists.infradead.org;
	Mon, 15 May 2023 17:22:29 +0000
Received: from [192.168.1.18] ([86.243.2.178])
	by smtp.orange.fr with ESMTPA
	id ybtopjGaAOrpCybtpptulC; Mon, 15 May 2023 19:22:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1684171340;
	bh=j2msEUStbZgsGPWRMf2BCODl+2adw4zpJFULujwK2sI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lvlmcUU9OrnvTmkwZf+/yvSSTnH+zL4jQ86xVrXIg/w3eFhpYzHrwCYpkfWJjJSMb
	 0D9z0koQ2s6uiAuh4ACsC6aIKxVWQ161pkZHBENe/yN0CVrPnuRAdQBGw4Xn3gv8Qz
	 sQuwnfDC7UvPm2SJcpOLM7gPdass42BFSnq5oDJjyaWegMuynVDMkUVZvrjmzB9UTU
	 VwGHszlUb52qHFlu50SjEeNxR9deuD8VpFYBGpnmI7rUZg1JtqyxlssrSBxmCfV8Cl
	 XQq9Lz53BJFQ020ME8uHd5zT+Y+O3y9bXCUpvQsLMjJsCaa7k3749wT91nxF/nRMiU
	 sFT468zZoIcPg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 15 May 2023 19:22:20 +0200
X-ME-IP: 86.243.2.178
Message-ID: <af3073e9-e270-f8f0-ecf1-fb28eb21c7dc@wanadoo.fr>
Date: Mon, 15 May 2023 19:22:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/5] nvmet: Reorder fields in 'struct nvme_ctrl'
Content-Language: fr
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <cover.1682941568.git.christophe.jaillet@wanadoo.fr>
 <af016d2a5e7e7bb503eadb15037b80bc9813b94c.1682941568.git.christophe.jaillet@wanadoo.fr>
 <ZGI/6DT30JBfQPnG@kbusch-mbp>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <ZGI/6DT30JBfQPnG@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230515_102227_632345_E828DAD9 
X-CRM114-Status: GOOD (  10.44  )
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

Le 15/05/2023 à 16:21, Keith Busch a écrit :
> On Mon, May 01, 2023 at 02:40:26PM +0200, Christophe JAILLET wrote:
>> Group some variables based on their sizes to reduce holes.
>> On x86_64, this shrinks the size of 'struct nvmet_sq' from 5368 to 5344
>> bytes when all CONFIG_* are defined.
> 
> This patch is changing struct nvme_ctrl but the commit log only mentions
> struct nvmet_sq, which was handled in patch 1/5. I'll just fix that up
> when applying.
>   

Thanks for catching and fixing it :).

CJ


