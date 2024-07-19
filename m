Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 533A5C3DA59
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jul 2024 08:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uyRnPkOlL+K67i9INrMaahcKB0i6SvDn1QwInydhxG8=; b=BRQ+25ENvME+0zz3CyLmVeJEno
	DHGbs9mQlWGv6cd9FP2hYJpsIMApLohw0VKmTnfQ6lFqZFOO6U37os7xBdzHxlk62GcaOE51SiopC
	fhspj232DtNYAXpLckFgDpuDkEIH6CH9XEURExc8U4Mu+yyxBLwqZWDjdMejgL9EtyrY4KL59uIb1
	KDyr2/3nn7Hk4oMTh4WGCCku1CsVyB0gzPQNUNo7PnoIOTCGmKxDJ+e1iU8gxrdTtBk25QpmHyGms
	8SW16TxaWBZr5YXGS0XlSKed048FCI7+0JQ9V8nLmBonTkS9LP3xRf797F2HwGwyFpLVcBJ1X+z7N
	kKdghobw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUjKf-000000029ej-3cJQ;
	Fri, 19 Jul 2024 08:51:17 +0000
Received: from m16.mail.163.com ([220.197.31.2])
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUjKT-000000029bF-0Sna
	for linux-nvme@lists.infradead.org;
	Fri, 19 Jul 2024 08:51:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=uyRnP
	kOlL+K67i9INrMaahcKB0i6SvDn1QwInydhxG8=; b=pOHE3kAdS53c17AU3E1sc
	Vfo0CEuo2SMGba865U+x92XcX8ADovsUhXyDjr+ZoHgi3A05WsVZoF+gNM5Y/M0W
	WiUi+SqVWv4Gk53vpg3HzJRiq3dmVfyKYB6QE2z6HjsZhC+4Br0vsWV5g/EGWovD
	PvDiqCNNBddit8v9ivhFRM=
Received: from localhost.localdomain (unknown [223.166.237.249])
	by gzga-smtp-mta-g2-1 (Coremail) with SMTP id _____wD33xrnKJpm4hB2Dg--.41463S2;
	Fri, 19 Jul 2024 16:50:48 +0800 (CST)
From: Ping Gan <jacky_gam_2001@163.com>
To: hare@suse.de,
	hch@lst.de
Cc: ping.gan@dell.com,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] nvmet: support unbound_wq for RDMA and TCP 
Date: Fri, 19 Jul 2024 16:49:52 +0800
Message-Id: <20240719084953.8050-1-jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <716c2c20-9471-4a37-9a75-c1bed7b30116@suse.de>
References: <716c2c20-9471-4a37-9a75-c1bed7b30116@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD33xrnKJpm4hB2Dg--.41463S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw43KFyUXFyDGw1fuw1Dtrb_yoW8AF1rpF
	WfAayxKrs7trWrA3sIkw47Jr4Yyw17tr93WF1kXr17Awn0vFyfZw10ya4YkFZ3GFn2qr4j
	yF98X3sru3Z0ya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRuOJrUUUUU=
X-Originating-IP: [223.166.237.249]
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/1tbiSAkhKWXAmWHsaQAAsR
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240719_015105_570837_D4CF1D5B 
X-CRM114-Status: GOOD (  13.99  )
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

> On 7/19/24 10:07, Ping Gan wrote:
>>> On 7/19/24 07:31, Christoph Hellwig wrote:
>>>> On Wed, Jul 17, 2024 at 05:14:49PM +0800, Ping Gan wrote:
>>>>> When running nvmf on SMP platform, current nvme target's RDMA and
>>>>> TCP use bounded workqueue to handle IO, but when there is other
>>>>> high
>>>>> workload on the system(eg: kubernetes), the competition between
>>>>> the
>>>>> bounded kworker and other workload is very radical. To decrease
>>>>> the
>>>>> resource race of OS among them, this patchset will enable
>>>>> unbounded
>>>>> workqueue for nvmet-rdma and nvmet-tcp; besides that, it can also
>>>>> get some performance improvement. And this patchset bases on
>>>>> previous
>>>>> discussion from below session.
>>>>
>>>> So why aren't we using unbound workqueues by default?  Who makea
>>>> the
>>>> policy decision and how does anyone know which one to chose?
>>>>
>>> I'd be happy to switch to unbound workqueues per default.
>>> It actually might be a left over from the various workqueue changes;
>>> at one point 'unbound' meant that effectively only one CPU was used
>>> for the workqueue, and you had to remove the 'unbound' parameter to
>>> have the workqueue run on all CPUs. That has since changed, so I
>>> guess
>>> switching to unbound per default is the better option here.
>> 
>> I don't fully understand what you said 'by default'. Did you mean we
>> should just remove 'unbounded' parameter and create workqueue by
>> WQ_UNBOUND flag or besides that, we should also add other parameter
>> to switch 'unbounded' workqueue  to 'bounded' workqueue?
>> 
> The former. Just remove the 'unbounded' parameter and always us
> 'WQ_UNBOUND' flag when creating workqueues.

Okay, will do in next version

Thanks,
Ping



