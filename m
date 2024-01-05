Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B786BC4707B
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Jan 2024 20:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=goP5QMBOF4sEQq6KPeqSZk65HdR0+fn5lRd+99JeKS8=; b=GjdqwVnHhWFeUQl2B+yr2EcXR0
	kJNQxbXCHMg8vY/bpoGVDAb4dno+uXKcyIo7J+v8wcCuedOy3CU5ZKy7Oj7mSVX53OpxA6yIiDi+2
	YAwxHgY6taHaW9aDgobE6lApSL7SYp2Sdk/GHTsWsFkDx6EwgfgIx99ZT6X5n6apRwO9VfacEJWQC
	I9jNgIY5S/pVzQtrpDfUqaw3NsNtSofSXZ35gC1dFUsK5MdWgXasKvo7Tyn1ACde2scU+BIvkSZIX
	cjNkpYAyaZwnaeAfJjy00RPMAgNmYKgvxcVMuWfGAP4DiZabfUhfIO75sU01YW1JrjcU9E8W1X23U
	uUEayjPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLqkT-000BTx-2J;
	Fri, 05 Jan 2024 20:24:57 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLqkQ-000BSc-2a
	for linux-nvme@lists.infradead.org;
	Fri, 05 Jan 2024 20:24:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 561F9CE2022;
	Fri,  5 Jan 2024 20:24:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 196E1C433C7;
	Fri,  5 Jan 2024 20:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704486286;
	bh=1a7qWhc3IkRvMd9r5UgVqn8LxrHXD9LTb10cVXrSdHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V9X+Oye8z7iu0w0FhhhYTZrfJwWTudlLZKoWWlJ2DeeCV6H1loJsfBnEpixFaw+Gw
	 GzBskTlenX/upnXYUhtpC6KxEOD8KLUBVhiPK45hEOSkbeKbU8OgfHPsGDPWkqUGrC
	 PMpMY0rMLQ9mvxtUAFQLSkzbtve95f4rckMLmrmCxyeQn1bi/OJ43nANLdRa/bd7jV
	 FhnaOMygpMPl+LGZWtIrZGOWJrwqPuABKu3f30cV4ht7zDvhzN+JVjwsdvpllRfiwJ
	 2GYsgpwd8Ggbs78f2kUXgTYWT6YxUDF5GPEfsLMIEDPZPCT5TZOYtOq/6Lx/SfkyWj
	 tGPYmO7g53SEQ==
Date: Fri, 5 Jan 2024 13:24:43 -0700
From: Keith Busch <kbusch@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nvmet: re-fix tracing strncpy() warning
Message-ID: <ZZhli2FWXwP1XSRG@kbusch-mbp>
References: <20240103155702.4045835-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103155702.4045835-1-arnd@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240105_122455_033416_3BC9F92A 
X-CRM114-Status: UNSURE (   9.18  )
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

On Wed, Jan 03, 2024 at 04:56:55PM +0100, Arnd Bergmann wrote:
> @@ -53,8 +53,7 @@ static inline void __assign_req_name(char *name, struct nvmet_req *req)
>  		return;
>  	}
>  
> -	strncpy(name, req->ns->device_path,
> -		min_t(size_t, DISK_NAME_LEN, strlen(req->ns->device_path)));
> +	strscpy_pad(name, req->ns->device_path, DISK_NAME_LEN);
>  }

I like this one, however Daniel has a different fix for this already
staged in nvme-6.8:

 https://git.infradead.org/nvme.git/commitdiff/8f6c0eec5fad13785fd53a5b3b5f8b97b722a2a3

