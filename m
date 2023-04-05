Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 397BCC7619A
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Apr 2023 22:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ICcBBlolD5dK06VoGGCPxHvn4T+Ucm1F3OsVpEYFznE=; b=WG/MI9CSoid2Gdvl60tpZzpKq3
	L/8itYzrSH+cEktlnk6KiySF4y4zzLn8GVTqkzo5mJBy209DmaeYHNksJOcaFknW5E1nqHhXrOanD
	AIalYJNsPsmG0eBQJ3XsexM4v1KZdYxYakGmQhMvE34mzeZeWD6ehT6KBeU8onlZ+oMUBd86hDCt8
	x1vxYZXGAF/uiNqyGu4ug6wFskXTQI9cMYHmVthRJNGp+3SEwU156xUCOltxy9S2Oomy5x9u2yAVj
	FPd0tnUdH6uZSL3dFTrF1A7lnNNbRtmXT1FNu0eJzXgvXlukgEzNCGvokSMYkgD5xRuzuWLB3CR3V
	7vHgNgUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pkBDU-005omw-2k;
	Wed, 05 Apr 2023 22:02:56 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pkBDP-005omW-1j
	for linux-nvme@lists.infradead.org;
	Wed, 05 Apr 2023 22:02:55 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 19ED363D41;
	Wed,  5 Apr 2023 22:02:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00EFAC433D2;
	Wed,  5 Apr 2023 22:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1680732170;
	bh=gwT5wL/2+gOyrLRjN6ifxW3OWwV926MSAjA+THy5cak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eNRKV7e6MckQtFhW9rTnzzv0RMaa2IqnwGg2F2uFVEqnUH8Yg96nrQb98dJc6Ecvb
	 Yu+wzIIqNsoNylxpT0DZdWnQPmPpzFe7464soc0XWW6hqw/6n1sp1fsTNH397hSpV8
	 iBOJlwlhSKpysVm18yDi4u+YrPCZILlHk9rF3loQfKZJSjG6TYgNjpBLwNjhVledKK
	 GpBrz/bBsycXeZ3I6FSC5hpIT7k4lrttyUxkONYKMvSeCtbN3IWkSsW6l+JZswWDt9
	 O466ljeq/W/WgwpOzIoKChgU4BU49qGSbyvL1F1P+6qPdDdPU89yNiLKpVTFpzbJdL
	 F5ddbNzZTKIuw==
Date: Wed, 5 Apr 2023 16:02:47 -0600
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Nate Thornton <nate.thornton@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH] nvme: fix async event trace event
Message-ID: <ZC3wB7/QBB1UcPqF@kbusch-mbp.dhcp.thefacebook.com>
References: <20230405215720.2872579-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405215720.2872579-1-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230405_150251_628611_422CD9E7 
X-CRM114-Status: UNSURE (   9.42  )
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

On Wed, Apr 05, 2023 at 02:57:20PM -0700, Keith Busch wrote:
> Reported-by: Nate Thornton <nate.thornton@samsung.com>

Well, no idea if this is a real email address, though it's a copy-paste from
the "From" in the original report. Getting this error:

                   The mail system

  <nate.thornton@samsung.com>: host mailin.samsung.com[203.254.224.12] said: 550
    5.1.1 Recipient address rejected: User unknown (in reply to RCPT TO
    command)


Regardless, patch should be fine.

