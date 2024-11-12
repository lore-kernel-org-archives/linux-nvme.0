Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA6ED597B4
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2024 22:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eCWsj10cmdsRr7s6n+k/w1mMAbnWUc296wk/B0jLSt0=; b=uH26VhYAJPUsImIdOU3YMBTt5B
	JaBegQK35LZkkp9iJDHgbCbz7P9kP6t08/JDA6ljSnBB1N7fiWdsfE+GLsR8aAItoJ0Vwy0pfzOXp
	aRKnFU2PcOAzP3u65AGt1xLhDAVZsg2jKv5xyJ/hon9WdW9DCe6AGT+R4hZXT9MF92eFVWD9tbMGv
	FN/RhExDYaySA3UPhN5EMYritAUoLdhdiWDOtgI2jptOzhaOPk5o6Ku2ohCl0wQNEdGd9ENaIXI2R
	h7i/ydYnDT50zVtECOxdLaRwA+MKsVQmZ1BpGyzhLsXDvxYr9lI4B/xh0qNKpvfSMc4xC/d5SKpde
	YYE8BgOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAzhq-00000005Bc8-2ln4;
	Tue, 12 Nov 2024 22:49:54 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAzho-00000005BbA-09dm
	for linux-nvme@lists.infradead.org;
	Tue, 12 Nov 2024 22:49:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id B5126A418E0;
	Tue, 12 Nov 2024 22:47:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01597C4CED5;
	Tue, 12 Nov 2024 22:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731451790;
	bh=9n5PPYSsP9ZFxZbM80y5b6RWMk7TXshHx0U1ydQY2bo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LwYL1HeyiMtRdB7BuKKCakwequzOBGlTKsLodE0JLYU47DOWUqtSw7XWjzJPHT4c2
	 mW/OOCNKJDkM77aPye3zJHjR6Xkn1lgPmLW7ypE+hbHMZqzodyyTCGxqUNnqmCNY7a
	 aIkBzxLO4ceLMNusikuItjPa+MvCrf3vJXTg9sZjl/aZFXQ8ROC8iwKsaeR25tipLp
	 GyffLL0gvImPFALY9/nwylUPfcHrUQ116I+3A4T++Kw3n45LmOB2oeiFtTs9bow8Iv
	 lLSjVa33XEmC8gn94k1wNV38usZe7aSowmxqHSayk6ZXTvZxbZX7pGFAjp1oMGV7QQ
	 TZddKQ0hjY0pA==
Date: Tue, 12 Nov 2024 15:49:47 -0700
From: Keith Busch <kbusch@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, m@bjorling.me,
	matias.bjorling@wdc.com, kch@nvidia.com
Subject: Re: [PATCHv4 13/13] nvmet: report ns's vwc not present
Message-ID: <ZzPbi6s3tmrepPyN@kbusch-mbp>
References: <20241107193849.995554-1-kbusch@meta.com>
 <20241107193849.995554-14-kbusch@meta.com>
 <20241108142743.GG6694@lst.de>
 <Zy45M1HRz8cKLPxf@kbusch-mbp>
 <005617fc-656d-4180-87b8-c9ebc8bff48d@linux.alibaba.com>
 <aa121956-a050-4c47-be44-2d3afe6c6610@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa121956-a050-4c47-be44-2d3afe6c6610@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241112_144952_163879_33821ACB 
X-CRM114-Status: UNSURE (   7.58  )
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

On Sat, Nov 09, 2024 at 11:00:32PM +0800, Guixin Liu wrote:
> 在 2024/11/9 22:59, Guixin Liu 写道:
> > 
> > Or just remove !req->ns->buffered_io check? All file backend return
> > 
> > support vwc.
> Sorry, remove "req->ns->file && !req->ns->buffered_io".

Do you want to send an update the with the updated check?

