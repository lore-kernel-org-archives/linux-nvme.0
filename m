Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A504CD98E2
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jun 2026 11:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cbiNe1YnAqB3ZwgAA1UIZ6qFlamXDIo6ltboGjoQYgE=; b=uAqiSZl0O3pAVd1NeQUhTfZlot
	QXQwfPCFR3MXSlkgJn27o/VBwlkD4Of9avu1Y+q78SXHkOsnURdfbyy4uZpOKHi9RZzAfLsJkc0K7
	5ar4tRS5IBnNl6ogvrXCijRGMJTS12NXR/x/5qwKII4ybUvZQToJjBTAcgKOeUSU+1nH/DFi8QTFJ
	kfMymM0o+YZn/+L8J1UlvIavdYQiG6YB+tjF/1SRhqqVVOBu94scsGztVwk3VsgCL4Lg1wX+Hs9Fp
	I2O5aMQKX+7tpD59qYL8oznveLrUdBMo3cd22g1FAR9d5cACanOLDzQuksrPhKfAA40gE8NXE8Sfc
	uGFEC0xQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZoHO-0000000HDV1-1Kyj;
	Wed, 17 Jun 2026 11:17:58 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZoHM-0000000HDUk-2Lkk
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jun 2026 11:17:56 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3E5094174E;
	Wed, 17 Jun 2026 11:17:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA6411F00A3A;
	Wed, 17 Jun 2026 11:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781695076;
	bh=cbiNe1YnAqB3ZwgAA1UIZ6qFlamXDIo6ltboGjoQYgE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Hr2ubg8bKaBpPw/SK07W5fKBRUWFdPUe24ZYhduhWnHbPHHzdkbnj7cdQkqsZvyTo
	 EtRq2khN0nlPzSwqoJILt7ZxP2k7xzAB4hT6oHMse7Ydcez86K6h6fxYf/M+nbtzQI
	 s4ubPoNs4dfpBqsbx0eSmbhFmFo8hd3EJd1qe3/hsKHy/8p1+2Im+S+CUrZiBKgViV
	 PnocQw2LWYp7dyZM6X1wFJvK/RrBNe6kCNbuRcKgYlx0iOW+MnePknZyWicN/Lvj6h
	 gcaERT3hQnJLyZRRHiM/mqYzWMeSTpHl0s6KU3Xc/5tUmSZbBtFEVPF+QkK8AKgUol
	 4NTzXTh7y8pJQ==
Date: Wed, 17 Jun 2026 13:17:52 +0200
From: Christian Brauner <brauner@kernel.org>
To: Hannes Reinecke <hare@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Andreas Hindborg <a.hindborg@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 8/8] nvmet: make configfs setup namespace aware
Message-ID: <20260617-kaufpreis-zugang-raven-4b0129e8462f@brauner>
References: <20260613111437.101763-1-hare@kernel.org>
 <20260613111437.101763-9-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260613111437.101763-9-hare@kernel.org>
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

On Sat, Jun 13, 2026 at 01:14:37PM +0200, Hannes Reinecke wrote:
> Implement 'fill_subsystem' and 'clear_subsystem' callbacks to make
> nvmet configfs namespace aware.
> 
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---

What tree is this all based on? I can't apply it at all which makes this
kind of change rather difficult to review meaningfully..

