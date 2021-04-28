Return-Path: <SRS0=oNUT=JZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694B8C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 07:07:00 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB46A61076
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 07:06:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB46A61076
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Date:Cc:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RSFyQSqq+EKiWtTRMfzJQqViqXbn+KGPOhBAM63X2NI=; b=n+uX8tDNe8097w5Vhw92TOOAC
	UQM/mNgI/DL3WRqVU4X+nMcPqXr9EBpQwYZBOSH5pCg05QhmyLNClIo4p7krTlWdvXk0HkunZCKTl
	jT69t/JKPFfF4NDAHNqEmX7zlgdf2n3Z5szhsErtEICrMXBHw4bW5owBsZ5hfvWfFLPenXN/bpILt
	8/0JV3hUCSnv/TL6ORN9My4ClLsU0gHtRZN87sZycgxwon4uEil4elR0JofByIS5oYd1fK9CH3VEw
	0pdGyvsQslDa+MY9DTtpwL0mXHJbtPwbS1PQnqtJFkd+qVQKdG4BQ/aejPDex81mKRns1oGXbt1sV
	9MQzcLBtw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbeHU-0031lE-Dp; Wed, 28 Apr 2021 07:06:44 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbeHO-0031kD-Ou
 for linux-nvme@desiato.infradead.org; Wed, 28 Apr 2021 07:06:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=5EnWeViouCWxoehMxDephqDSVUFaig7yM6l3zP3EZdI=; b=HKUCwIe+/7FaLnaIKKYgFrp3xB
 QCXYJ4V4yljqWv7EODj9Flu57sEo89a4AALy0BJDNPBOZq7MJbARrnF1s7z3IdJiX+OBXxxGfKArB
 VObXRnJj+UowlBAHmaFyI9fF2/4yTKCpz+IP6jvcanFGZiJMsi9RhlDon/QoG+3n62b1nk6WLcU+k
 cy31PRLgOruXlz04+eonVmFrezzXI52FgL79NA2S1gFjtgBEYVMWpfGe2nb+LbUZ71Y84C/uWuX2w
 aDT1mSkkl1k4yEkhSaC6AyJBYNztTlp2KQh/9jUZRcNstAz7wS011rPmXvrpkfn3Z30xH9ulu0NjL
 irioVCuQ==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbeHK-00HEo8-BY
 for linux-nvme@lists.infradead.org; Wed, 28 Apr 2021 07:06:36 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1619593592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5EnWeViouCWxoehMxDephqDSVUFaig7yM6l3zP3EZdI=;
 b=Vbui47+aVujGz4x3CCbh7GWCA2TAjB08+lnkZY4xHKs8YK878oKq2TRod0qpQviSPvmPqv
 fPtD1tjOMuHfqxgk3EzRXXTujb61PYdSLCI8udA9bIChcRefxF1/0YPYErFlbZw6/TyE0y
 0qPloRFei8zqcbHyeKNEbPk9n8th3iA=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 1BBCDAEA6;
 Wed, 28 Apr 2021 07:06:32 +0000 (UTC)
Message-ID: <e11706e498a583b764ff9e9b1b7de409f996ad07.camel@suse.com>
Subject: Re: [PATCH v3] nvme: rdma/tcp: fix list corruption with anatt timer
From: Martin Wilck <mwilck@suse.com>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>, Keith
 Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Chao Leng
 <lengchao@huawei.com>, Daniel Wagner <dwagner@suse.de>, 
 linux-nvme@lists.infradead.org, stable@vger.kernel.org
Date: Wed, 28 Apr 2021 09:06:31 +0200
In-Reply-To: <CAFL455=m_4tLZwbh1qRGPgE8ufBfKuq84zKkZmCntX56A17kog@mail.gmail.com>
References: <20210427085246.13728-1-mwilck@suse.com>
 <0ff2dbc0-0182-f54d-b750-084feac53601@suse.de>
 <20210427162521.GA26528@lst.de>
 <f82b7f7c-ef12-27bb-1349-d23ea22e50a9@suse.de>
 <3a0b10f45ac75df3f744dd04ac874021488f42b1.camel@suse.com>
 <CAFL455=m_4tLZwbh1qRGPgE8ufBfKuq84zKkZmCntX56A17kog@mail.gmail.com>
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210428_000634_704415_74FCCCA9 
X-CRM114-Status: GOOD (  19.23  )
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
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, 2021-04-28 at 08:39 +0200, Maurizio Lombardi wrote:
> =FAt 27. 4. 2021 v 22:02 odes=EDlatel Martin Wilck <mwilck@suse.com>
> napsal:
> > The code doesn't use add_timer(), only mod_timer() and
> > del_timer_sync(). And we didn't observe a crash upon add_timer().
> > What
> > we observed was that a timer had been enqueued multiple times, and
> > the
> > kernel crashes in expire_timers()->detach_timer(), when it encounters
> > an already detached entry in the timer list.
> =

> How can a timer end up enqueued multiple times?

I observed in a dump that this can happen. More precisely, I observed
the following:

[ 4389.978732] nvme nvme36: Successfully reconnected (1 attempt)
...
[ 4441.445655] nvme nvme36: Successfully reconnected (1 attempt)
...
[ 4510.891400] nvme nvme36: ANATT timeout, resetting controller.
...
[ 4517.035411] general protection fault: 0000 [#1] SMP PTI (kernel crash)

In the crash dump, I could see a anatt_timer belonging to nvme36 being
pending in the timer list, with a remaining expiry time of 44s,
suggesting it had been created around time 4441.4s. That means that at
the time the ANATT timeout was seen (which corresponds to a timer added
around 4389.9s), the timer must have been pending twice. (*)

> It's safe to call mod_timer() against both an active or an inactive
> timer
> and mod_timer() is thread-safe also.
> =

> IMO the problem is due to the fact that timer_setup() could end up
> being called against
> an active, pending timer.
> timer_setup() doesn't take any lock and modifies the pprev pointer
> and
> the timer's flags

Yes, that's what I think has happened. timer_setup() doesn't clear any
pointers in the list of pending timers pointing to this entry. If the
newly-initialized timer is then added with mod_timer(), it becomes
linked in a second timer list. When the first one expires, the timer
will be detached, but only from one of the lists it's pending in. In a
scenario like the one we faced, this could actually happen multiple
times. If the detached timer remains linked into a timer list, once
that list is traversed, the kernel dereferences a pointer with value
LIST_POISON2, and crashes.

Anybody: correct me if this is nonsense.

Best,
Martin

(*) Note that the crash had been caused by another wrongly linked anatt
timer, not this one.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
