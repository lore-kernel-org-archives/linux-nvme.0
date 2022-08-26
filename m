Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE2FECAAD6
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Aug 2022 19:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h9WVnwndfj9Ncs3v4MSrTwteRvvjIhvNeVW+NH7bd4g=; b=u6AzXI/Gtgq+awc+F/1pPWiNCL
	YI/9PZ3uhcq9/TjFR4ofo9twchY2nrsR/AcDSJPwGWR4FtUk7idKuY+EDiXQaM3AjSPLpHYWGyf2c
	By0TwsC/Fzk8LO2E8F0DlyRmJwY/Y38U3TtI3ztNuRUb/unW7aPv5X2uZwB19DhjWuzZKv6ThLBSJ
	gaLm4bQ1ceI8mtQhiht6wYvbt1uxs2YBZmHACIKhiOcIUWs0AcnHfVv9tNpNM+c/MI2NzuVc6wHhl
	6XFncxtl+ImsJadq6LibAc068Wkr9/RosQXjGJ60JR8z3GDzIaqZfgAII4QrF4iu1I7HwFA2t/wzh
	V/Gs0UKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRfEr-00Ar5u-CU; Fri, 26 Aug 2022 19:43:33 +0000
Received: from zeniv.linux.org.uk ([2a03:a000:7:0:5054:ff:fe1c:15ff])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRf4t-00AiPt-O5
	for linux-nvme@lists.infradead.org; Fri, 26 Aug 2022 19:33:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=h9WVnwndfj9Ncs3v4MSrTwteRvvjIhvNeVW+NH7bd4g=; b=ZSyTODQKMGcnl9NyDkktbrnaIA
	3emfSaArlZ+4sXqOWl9GZYo7J/oYgXrLKG/pckQM1r59OYXoizsEiQSz9eVt/7G/KauhNtMlTcjK9
	jzuvolo2fzh8Cz56Ei3ZDwi1MdY0WyHzhXwRlzAH+jaTfTjM7211tVOSuAxqlDUgKqpxCS0zStNG9
	9+3hCZk9Uv06MzEjdshcL+WUkVb+9RnAJRFM4Z/CkKT0nXhg2rqRCItrFw6w+CBeK5BQs0OMiX5fZ
	RzF1dD1yxqrowDcs9Oe7QL6zsrID/Gsy0luO5Vu3MIUkrYvVa4vay+W5DLj0Aqbnz27RAXZMm/Ewt
	YDko7gbQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
	id 1oRf4O-008dka-LS;
	Fri, 26 Aug 2022 19:32:44 +0000
Date: Fri, 26 Aug 2022 20:32:44 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	James Smart <james.smart@broadcom.com>,
	Ira Weiny <ira.weiny@intel.com>,
	"Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v3 1/1] nvmet-tcp: Don't kmap() pages which can't come
 from HIGHMEM
Message-ID: <Ywkf3NJQ7/8SSV+e@ZenIV>
References: <20220822142438.5954-1-fmdefrancesco@gmail.com>
 <20220822142438.5954-2-fmdefrancesco@gmail.com>
 <YwVjpTW6vWvdVQTK@ZenIV>
 <2887364.VdNmn5OnKV@opensuse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2887364.VdNmn5OnKV@opensuse>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220826_123315_820509_769527E7 
X-CRM114-Status: GOOD (  16.52  )
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

On Fri, Aug 26, 2022 at 08:16:59PM +0200, Fabio M. De Francesco wrote:

> As you may have already read, I'm so new to kernel development that I still
> know very little about many subsystems and drivers. I am not currently
> able to tell the difference between BVEC and KVEC. I could probably try to 
> switch from one to the other (after learning from other code), however I won't 
> be able to explain in the commit message why users should better use BVEC in 
> this case.

struct kvec: pairs of form <kernel address, length>
struct bio_vec: triples of form <page, offset, length>

Either is a way to refer to a chunk of memory; the former obviously has it
already mapped (you don't get kernel addresses otherwise), the latter doesn't
need to.

iov_iter instances might be backed by different things, including
arrays of kvec (iov_iter_kvec() constructs such) and arrays of
bio_vec (iov_iter_bvec() is the constructor for those).

iov_iter primitives (copy_to_iter/copy_from_iter/copy_page_to_iter/etc.)
work with either variant - they look at the flavour and act accordingly.

ITER_BVEC ones tend to do that kmap_local_page() + copy + kunmap_local().
ITER_KVEC obviously use memcpy() for copying and that's it.

If you need e.g. to send some subranges of some pages you could kmap them,
form kvec array, make msg.msg_iter a KVEC-backed iterator over those and
feed it to sendmsg().  Or you could take a bio_vec array instead, make
msg.msg_iter a BVEC-backed iterator over that and feed to sendmsg().

The difference is, in the latter case kmap_local() will be done on demand
*inside* ->sendmsg() instance, when it gets around to copying some data
from the source and calls something like csum_and_copy_from_iter() or
whichever primitive it chooses to use.

Why bother with mapping the damn thing in the caller and having it pinned
all along whatever ->sendmsg() you end up calling?  Just give it
page/offset/length instead of address/length and let lib/iov_iter.c
do the right thing...

