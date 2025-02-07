Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96840C02194
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Feb 2025 02:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=negwGvhk8J88UWnuNmaVTE7IbofbqrpwT5PQuf4vr3w=; b=PGmHj5OnRf9QaeE+4V2IDJ0gMf
	XIyRMzgqMe3HEJDTZX7eKZjrv0PIe99JkNiOFNt8LmmGrKaW2OpT8RALAcgIiipbDI6jpSZa6Onb3
	eBl7kq7u7rnqic86R6rpxfisUBg+Dgry4B5+uNadMC/wfWiYu5f3jDBcM7KYtu8lfjOy2W+e66Qas
	WaVBQTg4P4I2PX+U6MX48vCYpMHOypUFZn9xCvyFBw/Yns80H29SIHuDTJbmemWlH+5uG/qUDAhSo
	HsmVE5I+iIjK5WlV/4z0YsXrJraT/t2yesnk+JWHftwEuoELybxYOBqSEuK+e6QaeaJ+nhOfKVlh5
	adgTCHUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tgDw1-000000083Ax-1yIH;
	Fri, 07 Feb 2025 02:17:37 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tgDlP-000000081hR-3VU6
	for linux-nvme@lists.infradead.org;
	Fri, 07 Feb 2025 02:06:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738893997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=negwGvhk8J88UWnuNmaVTE7IbofbqrpwT5PQuf4vr3w=;
	b=aavz9zM0ORRqY2Tm6pDyCLytZ848zSPPfSaJOIO951OzzHNFrWyUYQY5CcmQTvKVPoT4Ru
	ZbdiP/El51q/R8esDLMQIu63Qk3PbWLC+AYQ4uai051NOh2exgIiPBnnZ06erD1JzXNnad
	LdHwY7GTRogfoR3fov4IDNniWJcjNkY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-Jkp7JE85NRmyHey07Jqnsw-1; Thu,
 06 Feb 2025 21:06:34 -0500
X-MC-Unique: Jkp7JE85NRmyHey07Jqnsw-1
X-Mimecast-MFC-AGG-ID: Jkp7JE85NRmyHey07Jqnsw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8C91E19560B7;
	Fri,  7 Feb 2025 02:06:27 +0000 (UTC)
Received: from fedora (unknown [10.72.116.126])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 190281955BD4;
	Fri,  7 Feb 2025 02:06:20 +0000 (UTC)
Date: Fri, 7 Feb 2025 10:06:14 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Vishnu ks <ksvishnu56@gmail.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Song Liu via Lsf-pc <lsf-pc@lists.linux-foundation.org>,
	hch@infradead.org, yanjun.zhu@linux.dev,
	linux-block@vger.kernel.org, bpf@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Improving Block Layer Tracepoints
 for Next-Generation Backup Systems
Message-ID: <Z6Vqlo3s3sK6d0ng@fedora>
References: <CAJHDoJac2Qa6QjhDFi7YZf0D05=Svc13ZQyX=92KsM7pkkVbJA@mail.gmail.com>
 <CAPhsuW7+ORExwn5fkRykEmEp-wm0YE788Tkd39rK5cZ-Q3dfUw@mail.gmail.com>
 <CAJHDoJYESDzDf9KJgfSfGGit6JPyxtf3miNbnM7BzNfjOi7CQw@mail.gmail.com>
 <CAPhsuW6W=08Vf=W6GZ9DCzwu4wq_AgNOayo50vxvqFMr9CcDcg@mail.gmail.com>
 <677c56994576b_f58f29445@dwillia2-xfh.jf.intel.com.notmuch>
 <CAJHDoJZ5rFhgu-R_N6e82bqkY43S-sXKVs2khnnnZrqJH1vcHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJHDoJZ5rFhgu-R_N6e82bqkY43S-sXKVs2khnnnZrqJH1vcHw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250206_180639_938758_7C6F67F6 
X-CRM114-Status: GOOD (  19.95  )
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

On Mon, Jan 13, 2025 at 11:01:30PM +0530, Vishnu ks wrote:
> Thanks everyone for the detailed technical feedback and clarifications
> - they've been extremely valuable in understanding the fundamental
> challenges and existing solutions.
> 
> I appreciate the points about md-cluster and DRBD's network RAID
> capabilities. While these are robust solutions for network-based
> replication, I'm particularly interested in the point-in-time recovery
> capability for scenarios like ransomware recovery, where being able to
> roll back to a specific point before encryption occurred would be
> valuable.
> 
> Regarding blk_filter - I've been exploring it since it was mentioned,
> and it indeed seems to be the right approach for what we're trying to
> achieve. However, I've found that many of our current requirements can
> actually be implemented using eBPF without additional kernel modules.
> I plan to create a detailed demonstration video to share my findings
> with this thread. Additionally, I'll be cleaning up and open-sourcing
> our replicator utility implementation for community feedback.
> 
> I would very much like to attend the LSF/MM/BPF summit to discuss
> these ideas in person and learn more about blk_filter and proper block
> layer fundamentals. Would it be possible for someone to help me with
> an invitation?

If one pair of bpf struct_ops are added for attaching to submit_bio()
and ->bi_end_io() in bio_endio(), lots of cases can be covered:

- blk filter

- bio interposer

- blk-snap

- easier IO trace

...

Then both bio and request based devices can be covered.

It shouldn't be hard to figure out generic bio/bvec kfuncs for helping block IO
bpf prog to do more valuable things & fun.

Thanks, 
Ming


