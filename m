Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 646EDC369A6
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Apr 2025 11:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qZ4M4LaL52Jnf+0QHRiqkdCMlReyXleAKszRYq6htwg=; b=G6zi6L3vKotWPv8Pn1jyf2LhUJ
	8Qmb5NZyCkQ52EDO2zHagTQrlMYMrysMcXg7pp6jqYCXKT8ml74DcqshPKev0hpGmOd5gujdYnH+D
	i1RhynOHIvXXp3VOn4sw+ZARVgFdVZt6NDEb02eCCbBuq/nEMhgFKuWRS4y9xJqieKkinVbd7XpkR
	AvgLOBxlf72gnOiO/XYXqVbRZ+DNXSR0UUj/WNIrRXIYF2xY9yzFcaEF8C5po0qanPohEs1l6v012
	iDCk3AnmTSKZ9BMzMftcqGrxt9kj7/+bZwaLVLE+prv6k0i/8SJQEft6dUKy4Iq9zYPSiibSdCuju
	S31m8meA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2ptX-0000000ACKv-3COD;
	Thu, 10 Apr 2025 11:16:31 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2o4S-00000009ue3-2FoP;
	Thu, 10 Apr 2025 09:19:40 +0000
Date: Thu, 10 Apr 2025 02:19:40 -0700
From: Christoph Hellwig <hch@infradead.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"alan.adamson@oracle.com" <alan.adamson@oracle.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: Issue with AWUPF when using multiple controllers in a subsystem
Message-ID: <Z_eNLCn_e1vFOu9m@infradead.org>
References: <4a2e4561-9311-40c9-aa65-87e7a2e5b041@oracle.com>
 <90792c66-d0ca-401d-b171-57faea2c2cab@nvidia.com>
 <Z_Y3V6i7dG5Hr635@infradead.org>
 <34d750b4-88b0-4e4d-8545-3550175529aa@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34d750b4-88b0-4e4d-8545-3550175529aa@oracle.com>
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

On Thu, Apr 10, 2025 at 10:09:53AM +0100, John Garry wrote:
> This, combined with no dedicated NVMe command to issue a write atomically
> (which could error for out-of-limits size/crossing boundary), is pretty
> concerning.

Agreed.  Given that Oracle is actually a major user of NVMe, can you
bring that to the working group's attention?  That works much better
than a random Linux maintainer.

> As an aside, I found the scope of the boundary definition to be quite vague
> as well.

It used to be really horrible, but got a major rework for multiple
atomicy in NVMe 2.2 (or was it 2.1?).  Which version did you check?

