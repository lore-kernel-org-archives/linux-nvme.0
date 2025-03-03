Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98099C282CD
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Mar 2025 14:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gAOr3k+sN+jnpZ0rMd39VL4NJq+5X6WzFjJEE+fgXGk=; b=rTYiEGpw5FUZxD6Tirc3xEZqU5
	yoPoZJ5e6ibP5MtSprfvY5utM2kd2y74pJ9jwtHDbAAaqo9ID9g4Lbn13QRzL2JriZ1YzGi64L+iz
	ovdGdCXH58XEE+70fnVnRJvzlcVlyOHVshGTqS7R6w+mDVu2J+kJZ5bVlDc2d2rSjcM+6ZayrTrXz
	+7iJqWhnd307Kv5lY2jQGKPY+6097sAvK3VO6FslVgxmqnO16ZdC727W5YB49WyogMhc8r0+VB40/
	6dMJyCm+0hQDP0Ya37VLOs7PTPXcAqO5WB5BP/x8i8pODhObDQXcQOS8zgJOhrQSrUnVsXiDQTDo8
	5CYR6IBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tp6cT-0000000147F-0qwp;
	Mon, 03 Mar 2025 14:18:09 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tp6Iz-0000000109O-18Q9
	for linux-nvme@bombadil.infradead.org;
	Mon, 03 Mar 2025 13:58:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=gAOr3k+sN+jnpZ0rMd39VL4NJq+5X6WzFjJEE+fgXGk=; b=ntMqTwkJ555qY9BGMnmma3JdzR
	rcYLt3dpb/u3sRiLqMaZMxaiujQsjyLL/YQQeJs7U3bdkZUviwuhe/3EN0jY2QoApICo5c+Nbc5px
	XKKO80Efp+LBDzzk2pfTrrMA0brBQhDznGxQDhF40AdS/oDbUG5v1Y7q3P/ZMgV7tTrJeonh9gcXO
	jPsaXzoDPaYnc3hbjElcrUtVXxn0UiH/UK/NEEoF/PsayuQn5AVyt6g7KSbUwFLibDs3zA5c/NBDg
	lqk2S3SqryO8VvGnZK1dqfL+CdQ8WAzbeIsyS9zoRZ75sHxZKixN4prEkpypXWWdhaJ9ozBC1OmB3
	Gb5/VbJQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tp6Ix-0000000BijE-2SH3;
	Mon, 03 Mar 2025 13:57:59 +0000
Date: Mon, 3 Mar 2025 13:57:59 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Hannes Reinecke <hare@suse.com>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	linux-mm@kvack.org
Subject: Re: Kernel oops with 6.14 when enabling TLS
Message-ID: <Z8W1Z7m_fWse8KWz@casper.infradead.org>
References: <08c29e4b-2f71-4b6d-8046-27e407214d8c@suse.com>
 <509dd4d3-85e9-40b2-a967-8c937909a1bf@suse.com>
 <913d3824-04c7-4cb1-a87b-01f9241a37aa@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <913d3824-04c7-4cb1-a87b-01f9241a37aa@suse.com>
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

On Mon, Mar 03, 2025 at 12:06:18PM +0100, Hannes Reinecke wrote:
> On 3/3/25 08:48, Hannes Reinecke wrote:
> > On 2/28/25 11:47, Hannes Reinecke wrote:
> > > Hi Sagi,
> > > 
> > > enabling TLS on latest linus tree reliably crashes my system:
> > > 
> > > [  487.018058] ------------[ cut here ]------------
> > > [  487.024046] WARNING: CPU: 9 PID: 6159 at mm/slub.c:4719
> > > free_large_kmalloc+0x15/0xa0
> [ .. ]
> > > 
> > > Haven't found a culprit for that one for now, started bisecting.
> > > Just wanted to report that as a heads-up, maybe you have some idea.
> > > 
> > 
> > bisect is pointing to
> > 9aec2fb0fd5e ("slab: allocate frozen pages")
> > and, indeed, reverting this patch on top of linus current resolves
> > the issue.
> > 
> > Sorry Matthew.
> > 
> It's getting even worse; after reverting above patch I'm getting a crash
> here:

If you revert that, you also need to revert 8c6e2d122b71.

But let me dig into the original problem.  The fact that it's
kmalloc_large might be a clue.

