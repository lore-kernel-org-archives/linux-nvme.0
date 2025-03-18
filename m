Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D54C8C282EC
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Mar 2025 08:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bXD5ixfMQVnQm/9ZG+Sq7VooSDOkIDNBkp5z/JkUoAQ=; b=L/S2nfL9O53xkxDJwapzB8pGRc
	W5MqYuJSYRYK3D0xgYMOppSyTvRECXZ8zF5PA808FVGdIR0eTo5yqzpRb7wjHwrtA/9cfiaEWOkza
	xwfPZiSuk6oyusVIiIxXVIRwxQWDZFb9D/SBKGcQUE8iKbf3sN27uc/N0nckSkAxYpVyfvwHRkNki
	fF9QwqO7DauebRpBhzqkogmtoTV8D1Q5Rw4B8AdyRn6ITPSk4eaNXqOYUrwScCAMVPrJZK1CCooJ0
	SOT/dtfVglTf9VUlENUX3zAYTSYnMHoG2IGiMszFqZzx4IQOrKzp4AoZPhaU9LX9/151ciJvf31bV
	abECcavg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuS0L-000000056KD-1jM4;
	Tue, 18 Mar 2025 08:08:53 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tuRz8-000000055vK-0y3G;
	Tue, 18 Mar 2025 08:07:38 +0000
Date: Tue, 18 Mar 2025 01:07:38 -0700
From: "hch@infradead.org" <hch@infradead.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: "hch@infradead.org" <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	Theodore Ts'o <tytso@mit.edu>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>
Subject: Re: [LSF/MM/BPF TOPIC] File system checksum offload
Message-ID: <Z9kpyh_8RH5irL96@infradead.org>
References: <20250130091545.66573-1-joshi.k@samsung.com>
 <20250130142857.GB401886@mit.edu>
 <97f402bc-4029-48d4-bd03-80af5b799d04@samsung.com>
 <b8790a76-fd4e-49b6-bc08-44e5c3bf348a@wdc.com>
 <Z6B2oq_aAaeL9rBE@infradead.org>
 <bb516f19-a6b3-4c6b-89f9-928d46b66e2a@wdc.com>
 <eaec853d-eda6-4ee9-abb6-e2fa32f54f5c@suse.com>
 <cfe11af2-44c5-43a7-9114-72471a615de7@samsung.com>
 <Z6GivxxFWFZhN7jD@infradead.org>
 <edde46e9-403b-4ddf-bd73-abe95446590c@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <edde46e9-403b-4ddf-bd73-abe95446590c@samsung.com>
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

On Tue, Mar 18, 2025 at 12:36:44PM +0530, Kanchan Joshi wrote:
> Right, I'm not saying that protection is getting better. Just that any 
> offload is about trusting someone else with the job. We have other 
> instances like atomic-writes, copy, write-zeroes, write-same etc.

So wahst is the use case for it?  What is the "thread" model you are
trying to protect against (where thread here is borrowed from the
security world and implies data corruption caught by checksums).

> 
> > IFF using PRACT is an acceptable level of protection just running
> > NODATASUM and disabling PI generation/verification in the block
> > layer using the current sysfs attributes (or an in-kernel interface
> > for that) to force the driver to set PRACT will do exactly the same
> > thing.
> 
> I had considered but that can't work because:
> 
> - the sysfs attributes operate at block-device level for all read or all 
> write operations. That's not flexible for policies such "do something 
> for some writes/reads but not for others" which can translate to "do 
> checksum offload for FS data, but keep things as is for FS meta" or 
> other combinations.

Well, we can easily do the using a per-I/O flag assuming we have a
use caѕe for it.  But for that we need to find the use case first.

So as with so many things (including some of my own), we really need
to go back to describe the problem we're trying to fix, before
diving deep down into the implementation.

