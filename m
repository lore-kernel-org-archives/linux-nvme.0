Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E40DC88E56
	for <linux-nvme@archiver.kernel.org>; Sat, 12 Sep 2026 04:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pkbEmlLYOqHu2rT/pG1b8F4ZrumOvKHVAf/LIvXXM5Y=; b=iANkTkVgQP7fuk4SKHXV9ASsP0
	K32ZdodoYkTkKZODr5YZg+qYotWBK+9k+Mmv+B7ON5t6ncyMMlLgKQkFvUeZFAXZez7au59hx1qYd
	+1QsMG+wbdCpaQHMdNPxtCCTCdyWJ3j5CPTeJUDe/skpHrhGdZHna6qmU0fR6SSVvT5p+ZpBw0MmN
	VQN8SzXMkXqjrUEuv0mfoJoo4eORBIyITX9VKYJnGNtpjQYR0YMi2Nurm2zG8w7OOMmSYHSh1yD7P
	W4pv4QVSBRNB7qO0kUI2WrtEnIr8CFgAslfp72xTFC7CGHIfvUmhhAhWMtOWcbpN0kQ24/QLpCgI9
	wcMrWZGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x5FbP-00000000X6p-0ilr;
	Sat, 12 Sep 2026 04:44:35 +0000
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4lnq-0000000FNWf-0r8m
	for linux-nvme@lists.infradead.org;
	Thu, 10 Sep 2026 20:55:27 +0000
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-7f3f52143cdso214010a34.2
        for <linux-nvme@lists.infradead.org>; Thu, 10 Sep 2026 13:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1789073725; x=1789678525; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pkbEmlLYOqHu2rT/pG1b8F4ZrumOvKHVAf/LIvXXM5Y=;
        b=Ke7oi3Ro57I5Tqfa0mkyWt0HG+tIBj/vzyhuQvjRe5Fg6e7RunW+XIPjcpnf2UiGlH
         1XoXPz/T7Wy9EspiDKqYpbXgZXe87mpeWxZOPF3ofOvwV2dj2RNwE7f4+/8snu7jBtE1
         ky5qHAY2EsyT5053m1pfc+slMWwSLUVjsL+5OXTYaN/tq7nwro48/H/BH0boMjIGWLmY
         b05Mt8++m5iD/wxYv9EtoPtAmhAZ62i1uStP1d7vxWSnqAlKLmcCqnWn8Vg3O9KEKPId
         mHeW3+TaOcLmdRZdsm8k6w4vsBK68Kf61qBmsFyCYjPqsBpfNNdUl4WfdhBoJHshk1DM
         NNBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789073725; x=1789678525;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pkbEmlLYOqHu2rT/pG1b8F4ZrumOvKHVAf/LIvXXM5Y=;
        b=LQo1de/U59Qcirs3273Vvz39ei1Kxwz6H6FCrPExKkVbjnfiWy97giZRtJVNI7e9+a
         GLMnS0RrWoj88pgoyR00V7ULUPQzIMzJgF4OrnVCBqjmnJ9yRJWfOnavQJhjvRfu19ix
         OmD9YPBOBA3phzWWCJCytQLsZhqhXOxu/DJUQxgVD8xWSzwIpZvrFUXwlvDE6sMqSwn5
         aIPOhD5gACtIC3eAP4meOn8NKZHZ65GfxmFWaiV0SMoQW//gEfJBBB0ZSKKUjo13UMKx
         8O4AtKOqoJCw2995bFOz7eJhM/4RodrA5ZBvX3ow76dtErunpNbcNNlqFvUYwPOSzqOS
         CxAQ==
X-Forwarded-Encrypted: i=1; AKwUvBy1e4cWnUk7t07+gbv6ag8kx4p0uFfsimbrtppRTOyq+Z3SaGpaEJKJ6bxUFo7CnpokkQEGCtLdiEJ3@lists.infradead.org
X-Gm-Message-State: AFuF++klRZzaEuTo2Bc1sY1DSpZaRJkCyeBL+8ReeQ8JkXfbfAXmaXDs
	l7R9vplyScSgAjQ+xyh9f4Hc3nO9nLc3HUl3bPnNjQV0h7BKIPkDmnWtQtXSPOaEuEk=
X-Gm-Gg: AYBFou0EoPoSGDKzp7svisWvq1nTvV+JsvCLND16xpoSW9N9j90ZujDpDR44ln+o0ns
	9smZS84WOB2IXmW9mfaXqri6FxmAv+OsAIxO+V3pnHORL/NHqZHjBnCQDV+k+9lLfKOGG6EzzJJ
	Qf7W55PuW9+mAzwIf7DLHOQ3AikLnyLJIeK/yBodeCeRRm1sQJBUj7K0XglU/GbXJFxq2NKP9L+
	MWJ8HdYUGNDwRMIbO5Xm7SX321v3XuLNnmUtsPgPFwafqOirOpjtWyhmXjOBOcWVLe2fBqf79qq
	UgnX/NooYNmpm2/rWHVUPhMKyCcdE50HQAnPn6XCkAI3NMuv6jsxRRTbAtlceXFyswYsiXzsYLw
	jn92BdeUQZtdW1RCkQ5y6EmDl33KVgzR3wFHd+UGXqLDiSA6MfLNgF5JlKQnAWUKlzmaNAoBM7L
	KpXUJ99GCqY3cjG2LCnI5ZqP2d93miVWl4QPhFg7YKS00R43YO2WYIhM5ZmqyzCIMLdr0Wg1XJ2
	6JeQz1a4tqwy8254gCDThRuBk3RsrYmINt3UHrSOJOAhqlyNtk=
X-Received: by 2002:a05:6830:2702:b0:800:d883:997f with SMTP id 46e09a7af769-803fec02e59mr471619a34.2.1789073724704;
        Thu, 10 Sep 2026 13:55:24 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-803f60fe54asm635779a34.15.2026.09.10.13.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 13:55:23 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, Pavel Begunkov <asml.silence@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, 
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>, 
 William Power <william.power@intel.com>, 
 Phil Cayton <phil.cayton@intel.com>, Damien Le Moal <dlemoal@kernel.org>, 
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
 Mikulas Patocka <mpatocka@redhat.com>, 
 Benjamin Marzinski <bmarzins@redhat.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, David Sterba <dsterba@suse.com>, 
 Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev, 
 nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org, 
 ceph-devel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
In-Reply-To: <cover.1785596451.git.asml.silence@gmail.com>
References: <cover.1785596451.git.asml.silence@gmail.com>
Subject: Re: [PATCH v5 00/16] Add dmabuf read/write via io_uring
Message-Id: <178907372259.484803.15807864431748251506.b4-ty@b4>
Date: Thu, 10 Sep 2026 14:55:22 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260910_135526_255800_1019F49F 
X-CRM114-Status: GOOD (  13.94  )
X-Mailman-Approved-At: Fri, 11 Sep 2026 21:44:33 -0700
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


On Sat, 01 Aug 2026 16:46:12 +0100, Pavel Begunkov wrote:
> The patch set allows to register a dmabuf to an io_uring instance for
> a specified file and use it with io_uring read / write requests. The
> infrastructure is not tied to io_uring and there could be more users
> in the future. A similar idea was attempted some years ago by Keith [1]
> (from where I borrowed a good number of changes). Later it was brough
> back up to life by Tushar and Vishal.
> 
> [...]

Applied, thanks!

[01/16] dma-buf: introduce initial file I/O infrastructure
        (no commit info)
[02/16] iov_iter: add iterator type for dmabuf maps
        (no commit info)
[03/16] block: rename bi_bvec_done
        (no commit info)
[04/16] block: always adjust bi_offset on bio_advance_iter
        (no commit info)
[05/16] block: move bvec init into __bio_clone
        (no commit info)
[06/16] block: introduce bio_iov_iter_set()
        (no commit info)
[07/16] block: introduce dma map backed bio type
        (no commit info)
[08/16] block: add dma-buf support for raw bdev
        (no commit info)
[09/16] nvme-pci: implement dma-buf backed requests
        (no commit info)
[10/16] nvme-pci: rename nvme_pci_sgl_set_data to nvme_pci_dma_iter_set_sgl
        (no commit info)
[11/16] nvme-pci: add SGL support for the dmabuf path
        (no commit info)
[12/16] io_uring/rsrc: introduce buf registration structure
        (no commit info)
[13/16] io_uring/rsrc: extend buffer update
        (no commit info)
[14/16] io_uring/rsrc: add uncloneable regbuf flag
        (no commit info)
[15/16] io_uring/rsrc: add regbuf import flags
        (no commit info)
[16/16] io_uring/rsrc: add dmabuf backed registered buffers
        (no commit info)

Best regards,
-- 
Jens Axboe




