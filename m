Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB1FAC48BC3
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Feb 2024 19:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xgotc1+VSor6bAo+JwXaTs/pMZhfIcGSVcptkJgYAY8=; b=vZsLnDaOWCO7oAEVkSbT4XQduB
	FxRUCQ93mNzm3zgdzY+bE8/a/C4CTFtRNKi1XxifdO3UCReLEl6btdh0+XXvSagLQnOdqDpwJQj/W
	P8YkNdaGpk7ZkwHZxQu36VOgEbK/FmMTR8Eh5vZ6F/cmPsMd0Rm5f0P8iBC0il8LVre3XxnCZ/QkG
	OY7eYzQv9e6GFY5AsSAJ7g3oNdazGhZnug0MjhH4+1riPHRV9ro5OKZWTlq4X/zu1L7AeGn7VNIfT
	8O6mn8Q3XV1IBqWjwYcuGHuRpAkLAFg07CzBks8oOUssT3QKpLzdnMB6fTWXWo3jZzWCbm/pqCJcs
	vsTODydg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rc9JK-0000000BtZb-1hzk;
	Mon, 19 Feb 2024 19:28:18 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rc9JH-0000000BtYe-310L
	for linux-nvme@lists.infradead.org;
	Mon, 19 Feb 2024 19:28:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B1C0560ECA;
	Mon, 19 Feb 2024 19:28:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B195C433F1;
	Mon, 19 Feb 2024 19:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708370894;
	bh=28e3XCodLQ2kZ4Xosvb9pK1FTKEHovYXa6YEWzOkzuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EEoR69Bjvz+8j2TNlS/qWjdYuSeSjnz1GljWI6JBJd9AGH9j+HjkiJi/mlUwUwvd+
	 iegb2ZvBuh6G2OEJ04LTG3XQARgP17d7Pnm7Q3yQPBzwgY+JFBIxg7grbJW3VIqET5
	 VAn8sFRkgws05PsO5Nat07mF6rxxaX/OoKlyVaRnfOOKVfA82v0p3/mZKZ/iInp4hQ
	 dr51CXK8jSPO2FBtXj+wXZAoIK/X5qQ9+jf7VaPfTBvXMMSPh0YgXLfJ4fCoZp6nra
	 uAJNNp1uYOfs8UK+D+nOVj+Ct9AhtuF/TxorRjWlgmIq9NFQUhCPjyf7hgvfg9jn+A
	 w5od3BVpXv9gQ==
Date: Mon, 19 Feb 2024 12:28:12 -0700
From: Keith Busch <kbusch@kernel.org>
To: Wen Xiong <wenxiong@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, Wenxiong <wenxiong@us.ibm.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: nvme native multipath question with two physical paths
Message-ID: <ZdOrzKNn-ryJ8v-i@kbusch-mbp>
References: <f5c8d980ffd12601d258c510b879f4d9@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f5c8d980ffd12601d258c510b879f4d9@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240219_112815_847251_19D5D512 
X-CRM114-Status: GOOD (  12.69  )
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

On Mon, Feb 19, 2024 at 01:03:48PM -0600, Wen Xiong wrote:
> Hi All,
> 
> In our nvme native multipath support drawer, each nvme has two physical
> paths/two controllers.
> We created a shared namespace on it.
> 
> # nvme list-ns /dev/nvme2
> [   0]:0x1
> # nvme list-ns /dev/nvme6
> [   0]:0x1
> 
> # ls -l /dev/nvme2*
> crw-------. 1 root root 240, 2 Feb 18 18:05 /dev/nvme2
> brw-rw----. 1 root disk 259, 4 Feb 18 18:14 /dev/nvme2n1
> # ls -l /dev/nvme6*
> crw-------. 1 root root 240, 6 Feb 18 18:05 /dev/nvme6
> 
> nvme-subsys2 - NQN=nqn.1994-11.com.samsung:nvme:PM1735a:2.5-inch:
> \
> +- nvme2 pcie 052f:80:00.0 live
> +- nvme6 pcie 058f:80:00.0 live
> 
> #nvme list
> /dev/nvme2n1          /dev/ng2n1
> 
> 
> Run stress io test over nvme2n1, we hot unplug nvme2(052f:80:00), /dev/nvme2
> controller is gone.
> /dev/nvme2n1 still existed and io still running over nvme2n1 without error.
> Looks io test still
> running over another path(nvme6)bbut we didn´t see /dev/nvme6n1 in /dev dir.

Nor should you see a /dev/nvme6n1 in this scenario. The mulitpath device
doesn't change names. It assumes the identifier from the subsystem. In
your example, it uses subsystem '2' and will continue to use it no
matter which controller instances are attach to it. This feature is why
applications that have opened the /dev/nvme2n1 handle  don't need to do
anything if the kernel experiences a path failover condition.

You should see the different paths in the hidden block hierarchy, which
you can find in the sysfs directory. There should be an entry in your
example at /sys/block/nvme2c6n1/. I am pretty sure  programs like
'iostat' can show how IO is distributed among all the paths of an nvme
mulitpath device.

