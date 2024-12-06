Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB104E77173
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Dec 2024 14:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x+pbS9Dwvv4Adx/JS1J63HbDvKycbIrXy3PXJPrKZLM=; b=VOFf9akaNYthYtzvbhnNKumymS
	8Ofda7H/IizLFKu4VHsP6C8n67g2KWhkFpUgapkjgIEi0G+m2YwpMfTZu3SFlnWlGXsdAkvi64EHH
	+7Pxua2ZBcHAm6Hj20RygG12q0hEKFNuzwRyWMnBtBA3205xVDlq+QaOAfNSipuPC9C0feUwS+zY0
	ToVUtzaYkYPlCJqMkgp49N9njLcjCmzh71FAddY3zoLvmso+iD1ntLhr+3u/vJaWJ6I0iGy1V0s2u
	Bm9DxhRzXGadaD0695ngqErk1+WzFYTJXi1sMy9knmZtQcoSqBWblcXUAPtXNObZRs8TmWgMZ8e+S
	W0Q6k/4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJZYO-00000001tIF-3ywI;
	Fri, 06 Dec 2024 14:43:36 +0000
Received: from ms.lwn.net ([45.79.88.28])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJZXr-00000001tF5-3kxS
	for linux-nvme@lists.infradead.org;
	Fri, 06 Dec 2024 14:43:04 +0000
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 57A7C403E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1733496179; bh=x+pbS9Dwvv4Adx/JS1J63HbDvKycbIrXy3PXJPrKZLM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=tOuv9t583lBSCO2GZA3wVDzxKCSFNSuWUfAN9OzxBnlRU2UgP16oIoOna+gDLDu5h
	 KE9fDqNdfzK0qztkAc4jRjfWMU8GTE3bNB4ysomUPUVfXJv+5GMyEyTUPTlK1csHSh
	 4BkbaavdG/Pd0ScSM5dyfJpMjLmqSTwGoJ8komsHL48fuo/xsx0PrBkS2GH6EvxGJz
	 R8sIhKUR/RAt88A33AlgukV4HkpGbWZJODpVCLnxglW/pk3rjl4cFU+uE+qFjrVgxv
	 3Hr7GeXKyQWjeW7keXJ0bB0GdWVxKqNtM6i83K+T/RAi+swHmELTMhuPLXlMot5dom
	 krc30ODWWbY4A==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 57A7C403E4;
	Fri,  6 Dec 2024 14:42:59 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Chaitanya
 Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH separete v2] docs, nvme: introduce nvme-multipath document
In-Reply-To: <20241206072507.37818-1-kanie@linux.alibaba.com>
References: <20241206072507.37818-1-kanie@linux.alibaba.com>
Date: Fri, 06 Dec 2024 07:42:58 -0700
Message-ID: <87frn0vpn1.fsf@trenco.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241206_064303_933076_B904E471 
X-CRM114-Status: GOOD (  14.41  )
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

Guixin Liu <kanie@linux.alibaba.com> writes:

> This adds a document about nvme-multipath and policies supported
> by the Linux NVMe host driver, and also each policy's best scenario.
>
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
> Hi,
>   We found that we should take care of the throughput of each path in
> service-time policy, so separate the doc patch. And continue working
> on service-time policy patch.
>
> Changes from v1 to v2:
> - Remove service-tome policy.
>
>  Documentation/nvme/nvme-multipath.rst | 72 +++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/nvme/nvme-multipath.rst

Thanks for working to improve our documentation.

When you add a new file, you need to add it to the relevant index.rst
file as well; if you had run a docs build, you would have seen a warning
about this.

I would also suggest that this material perhaps belongs in the admin
guide rather than in its own directory?

Thanks,

jon

