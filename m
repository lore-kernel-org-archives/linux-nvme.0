Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA29FE7717F
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2024 15:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GtNGDAZdRaeJIMNdj5Q7Ttu1mMk0bri00fF45iualtg=; b=jpXbs+9cnsj8pEIO5DjI8NO8Fg
	vJKXYEjlDEDdFlXIcIQzq8QNLC5SiF9jw4YJCInaqX8VSfgtmOWkawChSDB8loJ077NJkPOOr9Oin
	gByZ27ZuTxe9HxdlZBE2lt4lNHjMMYrWTHwgz9n558ff4+4/Z8IJt/duRZhqu0qvcwSqHxhfp2Vda
	IEma3AcCDVmOg2qSfzfNh0dpCdn3ZKclbsPiYKlwFCBmvsm5ZiKgruQ7N2pxTXGqnDcyxwJYufm4e
	rNhZYwlVWBHcew9tC0FTECRp+k1NWE7DOzR7Yg4XL5cYzDEHWt8rKqOeivGEpNYWdmBktuCX8qaCl
	wL6U0V0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tL25A-0000000BvpA-2dlB;
	Tue, 10 Dec 2024 15:23:28 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tL258-0000000Bvon-0Tx1
	for linux-nvme@lists.infradead.org;
	Tue, 10 Dec 2024 15:23:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1C0CA5C5707;
	Tue, 10 Dec 2024 15:22:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47969C4CED6;
	Tue, 10 Dec 2024 15:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733844205;
	bh=kFDZ4fWXe1UmPyq/gUpaBBV7FEi+rMVfAazaCxJB3PE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VEAnlEGo5GmYtpBwE/exjIHzNAkVwXL4KcgeYoGd2JG2HF/u6aSWiz+YULBIhmKjD
	 U4fQlv2swb/HIbucsgBYdyid6KAD9kUH9eUKNWdv3FFRbfy5YK45s/u1E7xwBKurcl
	 YRXWOU3wNoTS6FkD6rexkAGNZxW0J4qrq2ct1ZZe3N23N6vmjUtqkHqiuye+P3GeyO
	 825jDV+O8icw4WPw+CNBl2nDa75JbXljzBv3FCQAedcSi1JFcgCkIpyWlfYYtvXsJU
	 s4dYbSSkcbUT6cOGa8do60E5xxiWYReYQ+MA0NJV+wY62rWs/OmloocTZz62stjFhj
	 EeW5MEUSL1u0Q==
Date: Tue, 10 Dec 2024 08:23:22 -0700
From: Keith Busch <kbusch@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev, Keith Busch <kbusch@meta.com>,
	axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, lkp@intel.com,
	oe-kbuild-all@lists.linux.dev, sagi@grimberg.me,
	asml.silence@gmail.com, anuj20.g@samsung.com, joshi.k@samsung.com
Subject: Re: [PATCHv12 11/12] nvme: register fdp parameters with the block
 layer
Message-ID: <Z1hc6l0bCq2VL-LM@kbusch-mbp.dhcp.thefacebook.com>
References: <20241206221801.790690-12-kbusch@meta.com>
 <8d69680a-a958-4e9d-a1ba-097489fe98d1@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d69680a-a958-4e9d-a1ba-097489fe98d1@stanley.mountain>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241210_072326_196231_BC03CF60 
X-CRM114-Status: UNSURE (   8.47  )
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

On Tue, Dec 10, 2024 at 11:45:43AM +0300, Dan Carpenter wrote:
> 04ca0849938146 Keith Busch   2024-12-06  2226  	ret = nvme_submit_sync_cmd(ns->queue, &c, ruhs, size);
> 04ca0849938146 Keith Busch   2024-12-06  2227  	if (ret)
> 04ca0849938146 Keith Busch   2024-12-06  2228  		goto free;
> 04ca0849938146 Keith Busch   2024-12-06  2229  
> 04ca0849938146 Keith Busch   2024-12-06  2230  	head->nr_plids = le16_to_cpu(ruhs->nruhsd);
> 04ca0849938146 Keith Busch   2024-12-06  2231  	if (!head->nr_plids)
> 04ca0849938146 Keith Busch   2024-12-06 @2232  		goto free;
> 
> ret = -EINVAL?

It's very much on purpose to return "0" here. Returning a negative error
has the driver fail the namespace disk creation. Seeing a stream
configuration the driver doesn't support just means you don't get to use
the block layer's write stream features. You should still be able to use
your namespace the same as before the driver started checking these
configs, otherwise it's a regression since such namespaces are usable
today.

