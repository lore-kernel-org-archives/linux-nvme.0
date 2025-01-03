Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A88A9E77188
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2025 16:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=qCyahOV2kTIZy40KZRDCk8UlhlNMc75kM0yqojqk1/o=; b=ED0N1l7zF4HvSj
	PK7c9zbgSu0PLl7no8xpD9QRlBZf5oMSD0BiKo9o6Vzh+4nISAz+ZbhszubahCnV0EwN117HEYVA+
	kwiuGZY2JWqUssd+LPRAvulW/lYQ63BVsOGi6z4tJngpAWSsHHSgdAuJDYucIPGFtzqg/dImd5AnC
	TS6Md/ScdFKL6NSVYjvcxCikG1W2yioVv+Cd7WimWyt0auCipdI3t+GjJLpCfKM9LrGTq31LKPSZZ
	XdPEKiW9SHCnoQLTiFkavn2P2xfrWeChtL7zos1+ZXuazWy1cj9iEwMouv0IldvXQ+ZIxPhnZv/lm
	N5rg8V9P2oPlpK88xh9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUpa3-00000001snt-2DwQ;
	Mon, 06 Jan 2025 16:03:51 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tTliu-0000000DbNj-2PkG
	for linux-nvme@lists.infradead.org;
	Fri, 03 Jan 2025 17:44:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 95ABDA41034;
	Fri,  3 Jan 2025 17:42:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02697C4CED6;
	Fri,  3 Jan 2025 17:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735926275;
	bh=pRVkikpR9atkH7Z9yyBq4g6p9KSycIkZ3xWUYDx7kKA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=meOuPxmX/Ck1O9Y0poyu1vIfbHYu57927aYMHr4c+lFo4un3h0FURP6ahYknhqadI
	 Ou3VE5lCVqinSr+c8Ca+iIDQm550srFu7W26FsUMWJpjdA4+n8mRM7dLEHg8xSPaqP
	 8uEmFVTOnt42FDy6XzozpeQulJLK6F/LapjtG2jjw8z40p+fYAO1Uk1d0RJiOIMAsw
	 HeBZrvMlEAV40/iwAhBNNadnacwoWmNvPaRMbqDe+q0Bwsqm2/Cf4pkwB2e5Vu/oPS
	 Rz/a4yLi/ZewxdQd392AAm4dRgoMDQuSPqZW2Fis9fDjNtXPetd2B+BiXacAoGTxrz
	 HeQV+3vysqs6g==
Date: Fri, 3 Jan 2025 11:44:32 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-crypto@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Haren Myneni <haren@linux.ibm.com>,
	Rick Lindsley <ricklind@linux.ibm.com>,
	Nick Child <nnac123@linux.ibm.com>,
	Thomas Falcon <tlfalcon@linux.ibm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	James Smart <james.smart@broadcom.com>,
	Dick Kennedy <dick.kennedy@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Matt Wu <wuqiang.matt@bytedance.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kurz <groug@kaod.org>, Peter Xu <peterx@redhat.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: Re: [PATCH 06/14] cpumask: re-introduce cpumask_next{,_and}_wrap()
Message-ID: <20250103174432.GA4182129@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241228184949.31582-7-yury.norov@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250103_094436_742783_480C7234 
X-CRM114-Status: GOOD (  11.33  )
X-Mailman-Approved-At: Mon, 06 Jan 2025 08:02:41 -0800
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

On Sat, Dec 28, 2024 at 10:49:38AM -0800, Yury Norov wrote:
> cpumask_next_wrap_old() has two additional parameters, comparing to it's
> analogue in linux/find.h find_next_bit_wrap(). The reason for that is
> historical.

s/it's/its/

Personally I think cscope/tags/git grep make "find_next_bit_wrap()"
enough even without mentioning "linux/find.h".

> + * cpumask_next_and_wrap - get the next cpu in *src1p & *src2p, starting from
> + *			   @n and wrapping around, if needed
> + * @n: the cpu prior to the place to search (i.e. return will be > @n)

Is the return really > @n if it wraps?

