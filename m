Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 588F0C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Feb 2022 05:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s9c74c4WOzDF8cy9H40LMlj4LmtKHbFx/y/3Q3hVexY=; b=TExvFGUYuwo8ILID15wcj7XTb2
	G+VuPPiovEFVTXkBbdlYEykGTHwUJFIGzgktlR+5ivrvBmB39xeqi486DquOzf9zKNNW7Jn5hqYwx
	7afKmmuUZA6u+9o6Ui+ASinosHBdw+YTBUPOGWEuwzA02L82hpQFtw6VBec1RWcFp3c0thlEgT9kj
	hE+Tf2BIArgEupQLyHQhisy+2mq/hsYe+RwikGlsZmTR3Finfpyw4rAQS48PQt+SFhER0Ehe/Nb+q
	2CiTQGl5CP1Uta/Sa6ou1U4OjIacovI9lwyZboPS/1VSfXW5DEv+vdvCI6J4bsA9Ub6weNUfZoj0N
	PQODeRUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKvO8-00Cu3G-Lc; Fri, 18 Feb 2022 05:01:00 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKvNw-00Ctwy-0N
 for linux-nvme@lists.infradead.org; Fri, 18 Feb 2022 05:00:49 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20220218050044epoutp045e00f224dba8f7b78517428cbb5976e3~UyLUvvuTO3169731697epoutp04i
 for <linux-nvme@lists.infradead.org>; Fri, 18 Feb 2022 05:00:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20220218050044epoutp045e00f224dba8f7b78517428cbb5976e3~UyLUvvuTO3169731697epoutp04i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1645160444;
 bh=s9c74c4WOzDF8cy9H40LMlj4LmtKHbFx/y/3Q3hVexY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=tLM0Oazl+SL6uIuL/Km98wEcUBYSrklnsxvQb5iUIqpo9/Ok2ICigp1fvhezwn4Zi
 4GgCXKDjS/smZ5e/cpma8nP0iqYV/ovq/P7lSoflR7+chlc7dpett6eF4BRZbtctQq
 yz7gFP4SsI0chWlQyfmvGtdfb3RYBR5VKWU+85o0=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTP id
 20220218050043epcas5p2a4f639ec6d236b09980838ceba0554ad~UyLUK8HqW2406724067epcas5p2p;
 Fri, 18 Feb 2022 05:00:43 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.182]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4K0KJd5zjQz4x9QV; Fri, 18 Feb
 2022 05:00:33 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
 epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 B3.C6.46822.BA62F026; Fri, 18 Feb 2022 13:55:07 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
 20220217132330epcas5p47a248871b8d1d9f7aaa4b0caf1b100c5~UlZBEV68H2815628156epcas5p44;
 Thu, 17 Feb 2022 13:23:30 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20220217132330epsmtrp2ed7507a8a072bce17dd595d876a39a30~UlZBCC2qF0924009240epsmtrp20;
 Thu, 17 Feb 2022 13:23:30 +0000 (GMT)
X-AuditID: b6c32a4a-de5ff7000000b6e6-ff-620f26abd6d4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 1F.2E.29871.25C4E026; Thu, 17 Feb 2022 22:23:30 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20220217132326epsmtip234b5e87e0e8be80016deb77ba0ffa376~UlY9ZQ84v2210422104epsmtip2N;
 Thu, 17 Feb 2022 13:23:26 +0000 (GMT)
Date: Thu, 17 Feb 2022 18:48:31 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: javier@javigon.com, chaitanyak@nvidia.com, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, dm-devel@redhat.com,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 axboe@kernel.dk, msnitzer@redhat.com, bvanassche@acm.org,
 martin.petersen@oracle.com, roland@purestorage.com, hare@suse.de,
 kbusch@kernel.org, hch@lst.de, Frederick.Knight@netapp.com,
 zach.brown@ni.com, osandov@fb.com, lsf-pc@lists.linux-foundation.org,
 djwong@kernel.org, josef@toxicpanda.com, clm@fb.com, dsterba@suse.com,
 tytso@mit.edu, jack@suse.com, joshi.k@samsung.com, arnav.dawn@samsung.com
Subject: Re: [PATCH v2 05/10] block: add emulation for copy
Message-ID: <20220217131831.GC3781@test-zns>
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.02.2202160830150.22021@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te1BUVRzHO3fv3l1U8ApYB9RkliEF5LG24EFBndHBW+wUjs3YFIkXuC4M
 y7LtoxAnWVqItzyyWFctVAZGHtEAAcE+FCVCwBRChKhAHhYlIDC8hRZ2afzvc36/8/3+fr/z
 4LJsf+A4cqMkCkYmocU8YgNec8d1t0fpG5vDvA0T9kjXM8VGpb9nE+jriXkWGr89yEZ52RoO
 6hyyQfqxy2z0YC4RQ4OVKxjSXc/D0M3SJgw9Lb4BUFrrAwwtDfBR08ozAuU1PgJI3+uOdPoW
 HH1bNMxBGd11BDL8o2eh4uZlDOWmdmHovnaJQHf+6MJR6RJCyZnzHDRqPHV4O9X5axCVqx7j
 UOqCPpzqbFdSlSVpBFVVmEB9+bgYUA09KoL6vK2JRWkmpwmqu60Wo7LUYwT1fLgXp2oGsjjU
 uKGLoC5Ul4Bg+w+i/SMZOoKROTGS8NiIKIkogBd0IvRIqI+vN9+D74f28ZwkdAwTwDsqDPYI
 jBKbzofn9AktVppCwbRczvM66C+LVSoYp8hYuSKAx0gjxFKB1FNOx8iVEpGnhFHs53t77/Ux
 bTwdHTnZOYNLUzbGpeZoMBUY46YDKy4kBTB5uh6kgw1cW7IBwLryYctiEsD+KS1uXswAOFyQ
 TKxLahtvss0JPYCG0SX2asKWHAGwSs9JB1wuTrrAqsvCVSRId9i6slbNnnSFHVf+XZOyyF4c
 aroHOKsJO/IAzF8sW7OxJvfAv0e6LLwFtlwawld9rMgP4d2mtRa2ks7wVk0ztuoDySdWcKzw
 C465t6PQmPSThe3gaHO1hR3h1JieMAsyAJxr+9Oi1gCozlFbJjsEH+peYKvMIiOhKn/Got4B
 v7r3nSVuA7MWhzBz3BrWfbPOzrCsosDi4wAfzSZamIIXrhotx9iFwZTMXiwH7NS+NJ32pXpm
 3gMLGiYJrWlqFrkNFi9zzegKK+q9CgC7BDgwUnmMiJH7SPdKmE//v/Hw2JhKsPZ/3N6uAwP9
 E56NAOOCRgC5LJ699cRt6zBb6wj6bDwjiw2VKcWMvBH4mC4rl+W4NTzW9AElilC+wM9b4Ovr
 K/B705fPe826VfQ9bUuKaAUTzTBSRrauw7hWjirsrelfFg6PnKmPmdms6s132fVcP5hzOr2C
 7U9yiuJT2p3fHz7xnnCkEJ9VlO9rJ/hPPR11dLKI1MK/is6/Gqk/0p+Mx0+dXUDjZ7YxCalX
 dB1BwqvsA0kuLddCPNyzDt37+LO+jpYMo1G9ZYaonhaYXkw9zN6FiRMfx/t3G+zVA5jmZMQi
 FihefPJOyMO45eb9CcDoJuTJusvmdt+YsyGuTW3/bdChnBS+EtKk3BH/etKs8C4M/3lUhEul
 PX4awzHtzkA743zfybiwlk0rm3rSggQ17Mxa1cGLFxfOnbp/yWvjcXseffyZg7fe2eB6/t2c
 W+eufzQcJxcG/agsepHEw+WRNN+NJZPT/wH/td5UyAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKIsWRmVeSWpSXmKPExsWy7bCSvG6QD1+SwcItahZ7bn5mtVh9t5/N
 YtqHn8wW7w8+ZrWY1D+D3eLyEz6Lve9ms1pc+NHIZPF4038miz2LJjFZrFx9lMni+fLFjBad
 py8wWfx5aGhx9P9bNotJh64xWuy9pW2xZ+9JFov5y56yW3Rf38Fmse/1XmaL5cf/MVlM7LjK
 ZHFu1h82i8P3rrJYrP5jYdHa85Pd4tX+OAcZj8tXvD0mNr9j92hecIfF4/LZUo9NqzrZPDYv
 qfeYfGM5o8fumw1sHk1njjJ7zPj0hc3j+pntTB69ze/YPD4+vcXise1hL7vH+31X2Tz6tqxi
 DBCJ4rJJSc3JLEst0rdL4MrY8PcvS8Fxjoq7L54xNzAeZ+ti5OSQEDCR2H5oJWsXIxeHkMBu
 Romzm5ewQCQkJZb9PcIMYQtLrPz3nB2i6AmjRNf6WYxdjBwcLAKqEptn+4CYbALaEqf/c4CU
 iwhoSlya8wZsJrPAHRaJXX+egc0RFrCWmP57DSuIzSugI/Hy2VWoxVeZJF6+nwOVEJQ4OfMJ
 2BHMAloSN/69ZAJZwCwgLbH8HweIySkQLXHkKNj9ogLKEge2HWeawCg4C0nzLCTNsxCaFzAy
 r2KUTC0ozk3PLTYsMMxLLdcrTswtLs1L10vOz93ECE4ZWpo7GLev+qB3iJGJg/EQowQHs5II
 74eDvElCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeS90nYwXEkhPLEnNTk0tSC2CyTJxcEo1MB3b
 GuS2MUzomsmpCT4MrGtOX7p499M0h8UiKWsTD8g9V5k+V2CRmOtuGUefnVN9p01xWdfkq7ws
 8LNXyIQL9kmuXcd4VKcYuqy3NZO8eH7N6dqQ3fzO6Ud5mU6nFexxK5vw+K3Kw+SPZ9VmOyjv
 mtX4rvbGs1mrVxy08eaPevDDouxcyzt+1Q3vX7zctltFrSfynOKTR1kPZiSdtMiN0vKzsTdU
 tgzSmSfLunydl+DxGgvL0J/vPgQXZrKtf/JddR1nX/F1B+EVt/8d8Zo9cQKnYUNC5oSyJR1z
 zKXPlv/mik46Y7S/NNqhNFclMsWI6f+eD/8u7Qrpcz687JJ62IJdKrwXpLbd0DV+Wizz67MS
 S3FGoqEWc1FxIgCHHo8LiAMAAA==
X-CMS-MailID: 20220217132330epcas5p47a248871b8d1d9f7aaa4b0caf1b100c5
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----w44XasAgibz0dH83sqZUwD2VszzvD0Z8603isFAMQ6N2NX8f=_8dd51_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220207141930epcas5p2bcbff65f78ad1dede64648d73ddb3770
References: <CAOSviJ0HmT9iwdHdNtuZ8vHETCosRMpR33NcYGVWOV0ki3EYgw@mail.gmail.com>
 <20220207141348.4235-1-nj.shetty@samsung.com>
 <CGME20220207141930epcas5p2bcbff65f78ad1dede64648d73ddb3770@epcas5p2.samsung.com>
 <20220207141348.4235-6-nj.shetty@samsung.com>
 <alpine.LRH.2.02.2202160830150.22021@file01.intranet.prod.int.rdu2.redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220217_210048_433998_DF0A28A8 
X-CRM114-Status: GOOD (  20.27  )
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

------w44XasAgibz0dH83sqZUwD2VszzvD0Z8603isFAMQ6N2NX8f=_8dd51_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Wed, Feb 16, 2022 at 08:32:45AM -0500, Mikulas Patocka wrote:
> 
> 
> On Mon, 7 Feb 2022, Nitesh Shetty wrote:
> 
> > +				goto retry;
> > +			return PTR_ERR(bio);
> > +		}
> > +
> > +		bio->bi_iter.bi_sector = sector >> SECTOR_SHIFT;
> > +		bio->bi_opf = op;
> > +		bio_set_dev(bio, bdev);
> > @@ -346,6 +463,8 @@ int blkdev_issue_copy(struct block_device *src_bdev, int nr,
> >  
> >  	if (blk_check_copy_offload(src_q, dest_q))
> >  		ret = blk_copy_offload(src_bdev, nr, rlist, dest_bdev, gfp_mask);
> > +	else
> > +		ret = blk_copy_emulate(src_bdev, nr, rlist, dest_bdev, gfp_mask);
> >  
> >  	return ret;
> >  }
> 
> The emulation is not reliable because a device mapper device may be 
> reconfigured and it may lose the copy capability between the calls to 
> blk_check_copy_offload and blk_copy_offload.
> 
> You should call blk_copy_emulate if blk_copy_offload returns an error.
> 
> Mikulas
> 
>

I agree, it was in our todo list to fallback to emulation for partial
copy offload failures. In next version we will add this.

--
Nitesh Shetty


------w44XasAgibz0dH83sqZUwD2VszzvD0Z8603isFAMQ6N2NX8f=_8dd51_
Content-Type: text/plain; charset="utf-8"


------w44XasAgibz0dH83sqZUwD2VszzvD0Z8603isFAMQ6N2NX8f=_8dd51_--

