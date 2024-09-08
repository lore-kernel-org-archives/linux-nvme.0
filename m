Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EAF2CD4F4C
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Sep 2024 19:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UOihtH4yJ1kLHr5Rva6dNHZ/Fdk32dkRwJRPptenczI=; b=Kl0yhz/F+HiKFrXij1dPEZy31K
	MZApxpP/yWW8Q0NKVBRGJE4vjpSPenzPePqUixKf0X7RUAPdOc58s5FLR6eemYbDW9IeOiMxJeQIO
	ROAoZbb0E0PeUTYDR9t81P4ZjOOaFNCIWUOsrvR49TgCb7exwKWECtoGfsBmhh3xpR+ZLKRDcc7ov
	DnQH2g0rC922kxFWor7eH40xpWpxtXreRyOsn2PfJ2s+oVvQ6WDCqAjB0Jt4d3a6A1n2ZTgWWFlCI
	fuu9kkmNpwI4DCgsvJHdsXsPxKKJFhnnaG1v0eNz9QO3Zufe2s3m61Zv67U0Fs4TbHiDfwRMdDtkK
	YJDl9Tqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snNdL-0000000HLBY-223p;
	Sun, 08 Sep 2024 19:31:39 +0000
Received: from 89-138-71-253.bb.netvision.net.il ([89.138.71.253] helo=[10.100.102.67])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snNdJ-0000000HLB3-2NUN;
	Sun, 08 Sep 2024 19:31:37 +0000
Message-ID: <d3c63cee-cf99-4191-a434-aa1d36879184@grimberg.me>
Date: Sun, 8 Sep 2024 22:31:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] nvme: Convert comma to semicolon
To: Shen Lichuan <shenlichuan@vivo.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240906065815.40300-1-shenlichuan@vivo.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240906065815.40300-1-shenlichuan@vivo.com>
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

Again (now will hopefully make it to the mailing list after some dns fixups)

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

