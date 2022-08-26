Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8906AECAAA3
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Aug 2022 19:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x+UMVnujX+X39oLXzhe/HhYNdkWkFHYnX0Mj23junlg=; b=vsV8uRYZ1S+vc/Azy5e9R3wF+k
	LbKD3YZh0mzo7OkupDjMGNnhhYWuhWFv/anGb5DBLpUPAvzfC9TNomO6ckco/N6nz3c00zd67xHL+
	de9KXVzxWRLTcM7RkhKQKmqAX+Up2YzXUBoBHVqmmxegGo7wMaWdGklSKI0Wtd/5A0bxvdO6MYpPr
	JRsC9thJ02PvF6KT2AnBdmu8VLa/ZYTBHwjRJTDc2TdmdbMtKjZoJROlhOMOxs/HONCF2E/Chcr2l
	/Ul/P9lb9abAUcdHmEqvoEykI0CFx5ZW9MACsbn3oM34GcxbAXxir2Z4gDVCXp4nYo7G6v/9oI6A9
	gP2ucXwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRfGO-00Ascf-TI; Fri, 26 Aug 2022 19:45:08 +0000
Received: from zeniv.linux.org.uk ([2a03:a000:7:0:5054:ff:fe1c:15ff])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRf76-00Akca-Nl
	for linux-nvme@lists.infradead.org; Fri, 26 Aug 2022 19:35:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=x+UMVnujX+X39oLXzhe/HhYNdkWkFHYnX0Mj23junlg=; b=WR6NHCgYDvvQiuvmHDFS2QjkrD
	zxpBieFdz8zXKZaTBOZ2eo3bvI8UEm6kuTHCwfdD82/ES84mG3sFgChiT3EpJztCVAh8wESBXuC7k
	sbpAKpUlPN9wYol+RqgklQi0pBZO1Mq3IThb0O4IUcQkJteSr4m+63qwc+FYQRdRztleSnIeqcCIK
	Vz82hYFQ0hRBH7Wsk4MVbxytjoAXW5MNUxLi4GkzKOQAVqKWL5rqmmHBnId0c8nkVR1cCVoUA/n5r
	Tf/PWye0IFxrahKkq+FEMOyqyGuTHR/Fq+fEew2pZdwy6OaxM0R57lZ1zia4Y1fnczYhD6mPm3NCC
	Je95WuDg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
	id 1oRf6r-008dnk-VB;
	Fri, 26 Aug 2022 19:35:18 +0000
Date: Fri, 26 Aug 2022 20:35:17 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Keith Busch <kbusch@kernel.org>
Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	James Smart <james.smart@broadcom.com>,
	Ira Weiny <ira.weiny@intel.com>,
	"Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH v3 1/1] nvmet-tcp: Don't kmap() pages which can't come
 from HIGHMEM
Message-ID: <YwkgdYNkjNWkz+Gv@ZenIV>
References: <20220822142438.5954-1-fmdefrancesco@gmail.com>
 <20220822142438.5954-2-fmdefrancesco@gmail.com>
 <YwVjpTW6vWvdVQTK@ZenIV>
 <2887364.VdNmn5OnKV@opensuse>
 <YwkSXZtO+i+36pXI@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwkSXZtO+i+36pXI@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220826_123532_821488_833676BA 
X-CRM114-Status: GOOD (  10.13  )
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

On Fri, Aug 26, 2022 at 12:35:09PM -0600, Keith Busch wrote:

> > Can you please provide further information or links to documentation?
> 
> This kvec/bvec talk is a digression from your original goal: reduce unnecessary
> kmap() usage. If anyone wants to take on the bvec optimization in this code
> path, then by all means lets do it in a separate patch.

Oh?  And why is a switch to iov_iter_bvec() *not* a reduction of kmap() usage?
ITER_BVEC methods use kmap_local() for data transfers, TYVM...

