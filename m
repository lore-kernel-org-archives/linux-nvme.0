Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B661C433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Mar 2022 08:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KmcAlwv7bdWG/BuEZDTmi6ciEcCv7iDRa7CSEPWDgIA=; b=hsP3hzqBP5DrpLThBJ0zDNs2Te
	rX1qlOVSNhQsmGPOoNq5UHDSLmxp9pxSAeRZRjEpgvLbAL5m2y76j/c1yAj3l+/V06lymfnFhbSO4
	uByXQCrMY/HExxxv0fJ8gNPp+1TBRK8JFK0hci710+gsnC0Mzhy9ctGqrIfN7zmw6X6jsWemL0/qk
	mfJ0137Ne4JkyA1s/WQ5+FIf4OYAaXCPf+OkulKZGuRIqxH90Rzt3I66/QphwS3p7VF5gxhwgjsZm
	J2HaW9BbKAkcR/Xiy7sDDWXH3NS0SLQnJjARhYpFNIlzwjiaBqADBz8eA/9VFnVyNWGNBGIH7W5aK
	bIUaE+KQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSax2-00Fgo5-9E; Fri, 11 Mar 2022 08:48:44 +0000
Received: from smtprz02.163.net ([106.3.154.235] helo=smtp.tom.com)
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSaoY-00Fcf7-Fm
 for linux-nvme@lists.infradead.org; Fri, 11 Mar 2022 08:40:01 +0000
Received: from localhost (localhost [127.0.0.1])
 by vip-app02.163.net (Postfix) with ESMTP id 2E4E8440140
 for <linux-nvme@lists.infradead.org>; Fri, 11 Mar 2022 16:39:56 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=mail;
 t=1646987996; bh=yYffQcBKLRbGtRWbyWPUTkTs+t8t9AmrQpNgV1htlDc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=bhpgkKCvoySfBhgsFJXK6crewuOASBAtjy2y5t8Xj2b9hEJniQIBlbf0LtOWbn6Ql
 8Ur83i6FlBZA4tGmZTbNkTRI4oLr8mgykxa8XO572BNqYExAhyEzxmx2hUWHH9rjlJ
 O25MUCCcZMFQIRStIs/vrB083lFoy4JmqdQFRn4I=
Received: from localhost (HELO smtp.tom.com) ([127.0.0.1])
 by localhost (TOM SMTP Server) with SMTP ID -1995956455
 for <linux-nvme@lists.infradead.org>;
 Fri, 11 Mar 2022 16:39:56 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at mxtest.tom.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=mail;
 t=1646987996; bh=yYffQcBKLRbGtRWbyWPUTkTs+t8t9AmrQpNgV1htlDc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=bhpgkKCvoySfBhgsFJXK6crewuOASBAtjy2y5t8Xj2b9hEJniQIBlbf0LtOWbn6Ql
 8Ur83i6FlBZA4tGmZTbNkTRI4oLr8mgykxa8XO572BNqYExAhyEzxmx2hUWHH9rjlJ
 O25MUCCcZMFQIRStIs/vrB083lFoy4JmqdQFRn4I=
Received: from localhost (unknown [101.93.196.13])
 by antispamvip.163.net (Postfix) with ESMTPA id 8D22615414F8;
 Fri, 11 Mar 2022 16:39:49 +0800 (CST)
Date: Fri, 11 Mar 2022 16:39:48 +0800
From: Mingbao Sun <sunmingbao@tom.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Sagi
 Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Dumazet
 <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, Hideaki
 YOSHIFUJI <yoshfuji@linux-ipv6.org>, David Ahern <dsahern@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 tyler.sun@dell.com, ping.gan@dell.com, yanxiu.cai@dell.com,
 libin.zhang@dell.com, ao.sun@dell.com
Subject: Re: [PATCH 1/3] tcp: export symbol tcp_set_congestion_control
Message-ID: <20220311163948.000064d4@tom.com>
In-Reply-To: <20220311071319.GA18222@lst.de>
References: <20220311030113.73384-1-sunmingbao@tom.com>
 <20220311030113.73384-2-sunmingbao@tom.com>
 <20220311071319.GA18222@lst.de>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220311_003958_942202_56EB2C2A 
X-CRM114-Status: UNSURE (   8.70  )
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

On Fri, 11 Mar 2022 08:13:19 +0100
Christoph Hellwig <hch@lst.de> wrote:

> Maybe add a kerneldoc comment now that this is an exported API?
> 
> Otherwise this looks fine to me:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

accept.

will add it in the next version.
and will notice user "Must be called on a locked sock".

