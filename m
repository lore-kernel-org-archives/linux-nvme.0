Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C21C433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Apr 2022 07:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AjxlthgVN4CgdsWoWV8oNSzIIPy2gbZfd9KRDSiBPS0=; b=vvS8Z7ohFeepG19TrlLNCArsa3
	JIF3af6C25GeMEuBkTt33/frb+O7Jy0ugLII1O5rFK/UczuZMgcDmWICrQat8DszU+aHibD8qgGDQ
	nHAq2g1p+BmiPbL+QZ3RBW13fcjvFC5xEDsmjTmFddWSV4OQim1UalBJZYmIGvm9IJZMEwQTAJImB
	FjOYHCTtDZFY9SIdFX3KYP3WNSR++6y25VsBxo8WxFX2APpn/9jhXZpq0VcUrfVk0VbOBMr3r/I74
	s7oLdAxHF5GEbg7nwjXm6qj1QpJrNe9UaWmljZCrKQsSDYAilkAPLyD4fv2CfY2cbUlvNCZ1qfdeR
	BqoSXApw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbGpw-00DXNV-8U; Mon, 04 Apr 2022 07:09:16 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbGpt-00DXM7-2e
 for linux-nvme@lists.infradead.org; Mon, 04 Apr 2022 07:09:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3961268AFE; Mon,  4 Apr 2022 09:09:10 +0200 (CEST)
Date: Mon, 4 Apr 2022 09:09:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, asml.silence@gmail.com,
 ming.lei@redhat.com, mcgrof@kernel.org, pankydev8@gmail.com,
 javier@javigon.com, joshiiitr@gmail.com, anuj20.g@samsung.com
Subject: Re: [RFC 2/5] fs: add file_operations->async_cmd()
Message-ID: <20220404070910.GB444@lst.de>
References: <20220401110310.611869-1-joshi.k@samsung.com>
 <CGME20220401110833epcas5p18e828a307a646cef5b7aa429be4396e0@epcas5p1.samsung.com>
 <20220401110310.611869-3-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401110310.611869-3-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220404_000913_301883_B6D79FBE 
X-CRM114-Status: GOOD (  11.11  )
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

On Fri, Apr 01, 2022 at 04:33:07PM +0530, Kanchan Joshi wrote:
> From: Jens Axboe <axboe@kernel.dk>
> 
> This is a file private handler, similar to ioctls but hopefully a lot
> more sane and useful.

Without the next patch this is rather pointless (and confusing), so
I'd suggest to move it into that.

>  	int (*fadvise)(struct file *, loff_t, loff_t, int);
> +	int (*async_cmd)(struct io_uring_cmd *ioucmd);

Given that it takes a io_uring_cmd argument I also thnink that the
name is a bit misleading.  Caling this uring_cmd or io_uring_cmd
would be more descriptive.

