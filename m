Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BDE1FC590A
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 08:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:
	Subject:Cc:To:From:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9DRy7yqLQHtCip9HCmObThmwj1ASxznQZpTYJ3+LMWI=; b=RW8jheH6hJrJYmQFqMnoEa9QcN
	CQh2d3AgF4wLFxs4FW/DZyaaX6j6w2kDMX07nwLNyJJ/qGYxXF6uMV79ymHpSA3n0jYbkuT8s7BC7
	LXQzHSfmVVlfCLm5lnXlw5SBZO9Ku2v0AsEmz3HAMdrWeoy/5bIbV1IoeW2Ty/AClGpd5QXytW0B8
	2t8bAZXfFwCEEKUUejJnNcU6MPn0Gx7GMxnjdRH9wW2ClDYOIqscY5LpNYBCngEqIpSRZJqwSi10r
	gvkBwcD4obA1o1eJEg4GmS3QmOCQ3V7v0G8/YORGbHbznwPf+TjLKFOOxvkZ0/joyZDTU6Mn088mP
	R7JNPFpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvWP3-00000005cI0-0h5r;
	Thu, 26 Feb 2026 08:07:21 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvWOw-00000005cH3-0skE
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 08:07:19 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id d63d3aa3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Feb 2026 09:07:10 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Feb 2026 09:07:10 +0100
Message-Id: <DGOQMFJJ6K5P.3KLF45WQT2SAS@arkamax.eu>
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Keith Busch" <kbusch@kernel.org>, "Maurizio Lombardi"
 <mlombard@redhat.com>
Cc: <hch@lst.de>, <hare@suse.de>, <chaitanyak@nvidia.com>,
 <bvanassche@acm.org>, <linux-scsi@vger.kernel.org>,
 <linux-nvme@lists.infradead.org>, <James.Bottomley@hansenpartnership.com>,
 <mlombard@arkamax.eu>, <jmeneghi@redhat.com>, <emilne@redhat.com>,
 <bgurney@redhat.com>
Subject: Re: [PATCH V3 0/3] Ensure ordered namespace registration during
 async scan
X-Mailer: aerc 0.21.0
References: <20260225161203.76168-1-mlombard@redhat.com>
 <aZ9sjbZ3CEW_1rW1@kbusch-mbp>
In-Reply-To: <aZ9sjbZ3CEW_1rW1@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_000714_590388_7585DBBC 
X-CRM114-Status: GOOD (  21.83  )
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

On Wed Feb 25, 2026 at 10:41 PM CET, Keith Busch wrote:
> On Wed, Feb 25, 2026 at 05:12:00PM +0100, Maurizio Lombardi wrote:
>> The NVMe fully asynchronous namespace scanning introduced in
>> commit 4e893ca81170 ("nvme-core: scan namespaces asynchronously")
>> significantly improved discovery times. However, it also introduced
>> non-deterministic ordering for namespace registration.
>>
>> While kernel device names (/dev/nvmeXnY) are not guaranteed to be stable
>> across reboots, this unpredictable ordering has caused considerable user
>> confusion and has been perceived as a regression, leading to multiple bu=
g
>> reports.
>
> The nvme-pci driver also probes the controllers asynchronously, which
> can also create non-determinisitic names. Is that part not a problem?

Potentially, it is. The difference is that so far no one ever complained
about it, while with namespace async scanning we immediately received regre=
ssion
reports, to the point we had to revert the changes and restore the
sequential namespaces scan in RHEL.

>
> Just on the suffix part of the namespace's block handle, I have a
> potential alternate suggestion here. The instance names pulled from the
> ida guarantee we'll always have unique names for the lifetime of the
> backing kobject. I introduced that a while ago, but I'm testing this out
> now and it seems kobject_del is sufficient to reuse that name. The
> driver already did that to all the objects when deleting the namespace,
> so there doesn't appear to be a reason to wait for the final
> kobject_put.
>
> What I'm saying is I may have been mistaken about the naming collision
> issues and we can just use the head's ns_id to get a consistent and
> meaningful name based off the backing namespaces. There's some unlikely
> races with multipath at the moment if we did use ns_id, but I think
> they're all fixable.


Ok, so you'd like to use the namespace's NSID as the suffix.
I also considered this approach, the reason I didn't implemented
it is that I wished to have the async namespace scan performance improvemen=
ts
while preserving the same enumeration we had for years with the sequential =
scan:

Before the introduction of the async scan, /dev/nvme0n1 always pointed
to the first entry of the NSID list, /dev/nvme0n2 to the second
entry and so on.

With your proposal, if a user has sparse NSIDs (1, 10, 333)
then he will get /dev/nvme0n1, /dev/nvme0n10, /dev/nvme0n333.
On one hand, yes, they are "more stable" and more meaningful too,
on the other hand this breaks the assumption of contiguous naming.
This might not be a problem for the mainline kernel, but I suspect we
will have people complaining again that the /dev/nvmeXnY enumeration change=
d

Maurizio



