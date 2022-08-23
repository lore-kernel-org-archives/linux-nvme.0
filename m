Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57CB9C32793
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Aug 2022 23:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZpgOnfoB3G+8B3GPX7SSqWvigoev/1tx1b5/Xxi/HEg=; b=j+jLgyVk8YuuRMXB+OLveAmL0b
	byXDF72nmtdGBc0cRZpJLVLQJH7k0fwOuhWBBMXhINt8MGUln+mD13D5U18LQRONyDT3d8KTRMink
	YhyvxmP8mpwZLVow9MZuFxM7gu1bi3xMcYCuuBdjJyZ5sy2lKAUgy+bVfj3gl0eG6PAIwNwaAN2DL
	p3bhVlJs6lSSltgJPg/NlcIPvmzJT5OkDEoTbj21mDAD7ffQMQUJg+p9Fvi3mMuc7NIjU1nKShaKD
	aB3PQjS9JwDMTMWs39aJevPU0j01uFP0/Yv9IYnXMcrYe3ckB3Em10FNM1WUeUs6xye4WRjz4QjXO
	6w+75eLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQdOd-009CXu-BT; Tue, 23 Aug 2022 23:33:23 +0000
Received: from zeniv.linux.org.uk ([2a03:a000:7:0:5054:ff:fe1c:15ff])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQdOZ-009CUx-I7
	for linux-nvme@lists.infradead.org; Tue, 23 Aug 2022 23:33:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZpgOnfoB3G+8B3GPX7SSqWvigoev/1tx1b5/Xxi/HEg=; b=bftmL1ilNDBTxY0TLs2/XjHJOi
	62QLnNu13X7qG7JoV6DxrNDx6qdbL+OPIOMaiesR3MQfzjO7bGK93fiFd5RcbEQnZISN8999jAwEJ
	yVMKEW+r5ylYM3u46HAyjk+IidRRhyNqUOM0Npg5/3TPI5YY3EW2hC0liR14M6EN3VmFYmRoz7OCL
	7D6PX6AGLWMOzVAtZHQ1GNU83Xp1ng21/BBCbSikZyppheIR4zbwVQW4ItqcKrVG2AxrKT/5heBf6
	HR/XR8odIyoS2/q9tnw7U2i0EOQ/9VXE65Qtde1vRpRCK0ZbKW5zMN8GCor5AmWy+Yksnbnr3rm/P
	+FcIZl9w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
	id 1oQdO9-007aKM-Hn;
	Tue, 23 Aug 2022 23:32:53 +0000
Date: Wed, 24 Aug 2022 00:32:53 +0100
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
Message-ID: <YwVjpTW6vWvdVQTK@ZenIV>
References: <20220822142438.5954-1-fmdefrancesco@gmail.com>
 <20220822142438.5954-2-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822142438.5954-2-fmdefrancesco@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220823_163319_614979_BF851011 
X-CRM114-Status: UNSURE (   9.20  )
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

On Mon, Aug 22, 2022 at 04:24:38PM +0200, Fabio M. De Francesco wrote:

> Therefore, replace the kmap() of sg_page(sg) with a page_address() and
> delete the "nr_mapped" field from "nvmet_tcp_cmd" and instead pass a
> local variable to iov_iter_kvec() from the call site in
> nvmet_tcp_map_pdu_iovec().

I'd suggest looking into switching to ITER_BVEC...

