Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF361E9A048
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Feb 2026 15:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mP4ZC0TEh8C+GrS8QKMlO+6aITosKr4Nbnd175LCzeQ=; b=FVGETrw9MEafrmVLzhHKpbaMaN
	o/UwKUXLFNBQ4MFOVD6hjmysE6wU7v4vzBw0PFTh87a+xOwINsc8MjPTgItVfUBn/zqWe0dstthw9
	r+9nApe9zsuKvuFDU0+fXGfi6IMvVRM6KgtUtKrovihrV1w2O7yEYkn+z+966UUwd39rmcELOlN/D
	ybMKXDIWbp3kXf+LPnyv4zebZ2i+8jakIQnqG25iSmIqRlHYTZT86LoqH0nicdv5tqMrVbqzrGxOZ
	5GPsvigquSfCOE5JVnhfGvWieq2RpK2QDNgsI+4P75am1pWhElS9bz/QeEw8GR7ux8yNxk/hp6KKK
	5DGA22gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vt5WP-0000000BUT5-2OcB;
	Thu, 19 Feb 2026 15:00:53 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vt5WO-0000000BUSm-0nbX
	for linux-nvme@bombadil.infradead.org;
	Thu, 19 Feb 2026 15:00:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mP4ZC0TEh8C+GrS8QKMlO+6aITosKr4Nbnd175LCzeQ=; b=sZCLI2iwwtDfv00ulHbwZN08JS
	TG+1RH2RthzkUqgNN3LdKJHRV3O9/7TFc3cpinGW4bWdeq7CYbRKtkueZoVdj+Up7Rs38+ep+1i+Z
	5hIeas+id064CMRlUo7sS6M36RAekYqpHKTzCZhGm7hNJBWOzbvMfV7uXHHpewouWOGE6pC2YEF1n
	JfdVeuc+Tc+On2OpMsWmvb6GiQpa07Q/Blyb2FrKdWGSW45CIaCKszXUX5wKIkXwvoBX3WrIVy7Tc
	QYGRXMmIa97PF2633C1GJfvVDb3SJaPZUSb67gYcj0N86jsPD/BkaK8MqgdkHJFobr7stM+99RX7T
	Gq97demg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vt5WL-00000007lC1-3YKs;
	Thu, 19 Feb 2026 15:00:49 +0000
Date: Thu, 19 Feb 2026 15:00:49 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.de>,
	lsf-pc <lsf-pc@lists.linux-foundation.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	linux-mm@kvack.org
Subject: Re: [LSF/MM/BPF TOPIC] Memory fragmentation with large block sizes
Message-ID: <aZclobp0vgE2YKRK@casper.infradead.org>
References: <f22caf98-1375-493a-a275-0500ffac3e81@suse.de>
 <e2733d9f-823d-433b-9bfd-24df20b98b7d@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2733d9f-823d-433b-9bfd-24df20b98b7d@acm.org>
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

On Thu, Feb 19, 2026 at 06:53:28AM -0800, Bart Van Assche wrote:
> Additionally, why is contiguous memory required for block sizes
> larger than the page size? Does this perhaps come from the VFS layer?
> If so, is this something that can be fixed?

No.

