Return-Path: <SRS0=nO+g=NO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0442C432BE
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Aug 2021 16:20:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B67F8613DA
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Aug 2021 16:20:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B67F8613DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TvxKTSSoa8EIfBMSVjb5S12GKKggFYY5Y4pnK4c8eFw=; b=HLB7UoqXCQ2UIA
	C+Wey10cw7ZLkJYSavcAkPgOuDIpOn90QXm+Vkr2rrVRCNP03BdXqWMNhQoGdSeeYleRKBJOROHmz
	H78t4UVpo9Fh/1cRRLzBNjsJhaW5F8vTiiffvqK7vi0IgKf34WL5zk57oIPJ3PLNRcWdKoLIHEeBA
	CrKDm0Qz4XKn5PyIJ791CzP66kZYwNAV6NuINYxZIMYw88Cvh4TgS4GlI4D77pnjrUlUDt/Bn8C+t
	XhGejZo93P1skzUPwjbbGCG+xKCN2BKSf6cNzNRAkLRXeBD0A5/ajA/7D3chcQ7bx814cFDnixvpY
	jbO6yNatEEIbHC4JRyog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mICga-00HaFD-Ua; Mon, 23 Aug 2021 16:20:32 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mICgY-00HaET-St
 for linux-nvme@lists.infradead.org; Mon, 23 Aug 2021 16:20:32 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id BEA2D613D1;
 Mon, 23 Aug 2021 16:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629735630;
 bh=yfSurucw9g3APGwyYCaCrwNbo7Xxl8VnA5h5KuhGfH8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kEJOhTqtlj8auPBWrdYcvfdqN2homtPx4kooifkXtwQC2LtTx6rWjg5/ZV0rO4+aG
 Vrp11p2VHXAbY00PPG9+gNGb1s+Ay8xbspu9bDicvb2G7p3qleFOhMHNlU6fyzKkMm
 /2XCCE85rTWvQSq5Dwc/fVuXaMfy0sKvIlXE89Yb61n/wYTqgTOlkjFd8eI9kWHvz3
 5O+rg9NA1c6lANNVmcJbtoYoa3h3dx25fWkGWEjTQY0rrA2bdmHhXmKw9TVFV8SiWa
 raa6rXtSNdto04XJc4rINxnYzFtmH4WVCF+DZI0t0Jwhsnj73SGs6q6c4RS0PlYxQu
 G2P6upeUq/lwg==
Date: Mon, 23 Aug 2021 09:20:27 -0700
From: Keith Busch <kbusch@kernel.org>
To: chengjike <chengjike.cheng@huawei.com>
Cc: linux-nvme@lists.infradead.org, sunao.sun@huawei.com, jiangtao62@huawei.com
Subject: Re: [PATCH nvme-cli] fix list command bugs
Message-ID: <20210823162027.GA13068@dhcp-10-100-145-180.wdc.com>
References: <20210823124047.4593-1-chengjike.cheng@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210823124047.4593-1-chengjike.cheng@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210823_092031_039003_A93025A5 
X-CRM114-Status: UNSURE (   5.82  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Aug 23, 2021 at 08:40:47PM +0800, chengjike wrote:
> When execute the "nvme list" command in a multipath environment, it generate a core dump. Such as:

Applied, thank you for the fix.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
