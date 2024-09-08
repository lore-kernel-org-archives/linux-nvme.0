Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B239CD4F4C
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Sep 2024 19:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p1jleCrcvcEsUgvoOnEF55ZwRx8+vaMRREkGzy163EA=; b=RS/D0leHzh911i8EZR7yfdWb/p
	vqSb1JljT2LRgeF+f0K85Wu8Rjy33lX8d1tj5012GwYWU+lvIlNqRVOm8mBiPdo+siSfbyZ2TDh6X
	6vTYzcliVblmDIF5WKeYKXLz0cK6cQTb9nJMGiljDvLrCgW3iII6IMOwyuhYwp9u55U4Jk9jdFhGY
	QVJBK4g9ppaZXPCRssNMwKF7WBjTNq0CGtjSDX9C7Mt7t6Mr/iwAi5zfjDkqxsSRx2y/SZzAwpETG
	8CPM4/JHqXuLQVjBMAtG/1Ls9Exq2zMKHubeK0eyMz3nu73O/J6qOWPf2zAaKsEoC1F0W8d1cPYd3
	5NyCB/Ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snNhJ-0000000HLZk-2mil;
	Sun, 08 Sep 2024 19:35:45 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snNhI-0000000HLZW-30Ab
	for linux-nvme@bombadil.infradead.org;
	Sun, 08 Sep 2024 19:35:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=p1jleCrcvcEsUgvoOnEF55ZwRx8+vaMRREkGzy163EA=; b=vfjo+Bm1TDyDY0GuD0d5ACAa9V
	p5MVHj9Xegp2R2V7VE9buZfW9alfpZeBIVfWvv9NvgM3t8htDq62XEou7LqxGYq3v75U08Oq0np+y
	i1GEroMnXR//Xx2XcDosgEGSOadumGEm7vQ/ml3PpcxGLtCYWNvTgpFNL41ZvtirPB/CZDJOYgyse
	7JGdwwslUQm28i/WhDHUPurSrNEsI6tP/DABuHQQ/NrB5RmW5MfoO0PQvRIu2uHvgCwoMbUMEmkRq
	TaEAGlQN19yGKbtJbPI89aOzfKt5mRlnooWsQ7Ao1aJ+Mi/ECWgeQQ8RwUaUh19F1HSVr2suZZU/v
	CjhMotxQ==;
Received: from 89-138-71-253.bb.netvision.net.il ([89.138.71.253] helo=[10.100.102.67])
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1snNhE-00000001oXy-1cjD;
	Sun, 08 Sep 2024 19:35:41 +0000
Message-ID: <af8f2f8e-29ca-42cd-ae0b-bcdb707a96ef@grimberg.me>
Date: Sun, 8 Sep 2024 22:35:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] nvme: Convert comma to semicolon
From: Sagi Grimberg <sagi@grimberg.me>
To: Shen Lichuan <shenlichuan@vivo.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240906065815.40300-1-shenlichuan@vivo.com>
 <d3c63cee-cf99-4191-a434-aa1d36879184@grimberg.me>
Content-Language: en-US
In-Reply-To: <d3c63cee-cf99-4191-a434-aa1d36879184@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Testing again (sorry for the spam)...


On 9/8/24 22:31, Sagi Grimberg wrote:
> Again (now will hopefully make it to the mailing list after some dns 
> fixups)
>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>


