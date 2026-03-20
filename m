Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89BF21093187
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Mar 2026 08:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xhCmzUz4NlnTMvdQAtML9UnKE9EV7GnyIm1CqzfVA+Y=; b=XmgKfHOIOCS6jLGSr7ly84L2a5
	DMzpJpkSHW2/NdxbGgAPqQiT8mIPSt3IPB5qsPI6rMt6EqHE+hl+GWpudiTmkOgiTTjXgKR6zaYr/
	+wlpovYy6oDTFo0Uv1AZPQjnhK/TxJagZYtlbjy7s5IQEdzFayPH3r1jRVfkTBg3q1k9NCvlE9MLN
	oUgLHlSEKXcSVHha2dC68FKNuajOhNCif+71Hu337O4iOiJnhRKYjqphTdBeMuxTT02zDsja9I+aK
	Zd4QEyimZ9nCnsmwhW5QS9tJNPMimaTnvKR1pWyyuCX7UQNMBrdCg03voOBt/Uk3DqoEUEjU9dKzk
	T5PeYQeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3VFW-0000000CLfV-04VJ;
	Fri, 20 Mar 2026 08:30:30 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3VFS-0000000CLf7-3vn3
	for linux-nvme@lists.infradead.org;
	Fri, 20 Mar 2026 08:30:28 +0000
Date: Fri, 20 Mar 2026 09:30:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773995423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xhCmzUz4NlnTMvdQAtML9UnKE9EV7GnyIm1CqzfVA+Y=;
	b=LF71P68wSZqgSOyc5TSrj8qzi9Nt0XRjzWPIiJoKFEsRxthX8UjmgEYX6SbLLfhJj5jyAr
	R3JtrEMXl0pqYw3hjwLNWGrevetZNo40/BxBxG423ouqwBRJAXDG+zX4ZKOysYDjr8Yw/t
	l9Vhsv+o5Kt3tZxrPLsDsSS70ETHJeovoJDCnc7hzRAm1UJls+z5Nq/jBQ4zVod89qMQBZ
	9NgzigpK2Vnq+O1Z/X7/A4t58xa6qw3p8K1KXsmIvGeKmf/oVyszXFD0DMNgtjU/pkt3E4
	TcUgip5PzgB/9oBiUeNrLrFVqdp2GZe1tSQd4x9U4e7Ae998dHbeONJpDyn50w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773995423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xhCmzUz4NlnTMvdQAtML9UnKE9EV7GnyIm1CqzfVA+Y=;
	b=3jGnZOY+j1WNqYimRFzowZ3e968F+hy+mJq0vcwADM+WcY8WSUQ1YFNsV8T/KZ5MqC7513
	3PyYsMejyoyHvjBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Marco Crivellari <marco.crivellari@suse.com>,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Michal Hocko <mhocko@suse.com>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v2 1/3] nvmet: replace use of system_wq with
 system_percpu_wq
Message-ID: <20260320083022.wDoaRc9K@linutronix.de>
References: <20260223102336.108512-1-marco.crivellari@suse.com>
 <20260223102336.108512-2-marco.crivellari@suse.com>
 <20260320075750.GA14771@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260320075750.GA14771@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260320_013027_144185_319902E0 
X-CRM114-Status: UNSURE (   6.01  )
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

On 2026-03-20 08:57:50 [+0100], Christoph Hellwig wrote:
> "dfl" is a weird acronym, that doesn't really help understanding the
> code.  What does it even mean?
default
^ ^  ^

Sebastian

