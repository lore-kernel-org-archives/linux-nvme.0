Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDE9C6FD1F
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 08:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fNG74tphX7HatVi3xa6OcNMOHilHbXfmzIeCkxt/Xhk=; b=dTtH4P3B3ZtNJzaA3SkUYfc50a
	zL+fT+n8DXln1T72wgLfvCdf7Ch09SOOvmHw1U+t9kFHIEBXWY3WGYBvPujFzSuzCV7SKNQd2NWkm
	Cwl7rcpCbJ6J14zltoVPxpJL9tHiYwTT/+ku8rSMNfQfhBHkrKLyMYxmeCyUgFzWQ1ZoicQAwcTTk
	K0+INyJ08n1TOdpuyrqfnsc8YmR6SSENT+lJgi9rZQc/mSnN3W4mdOrYMYeAy9zxcqxXQ+NClu79h
	2srJ7buGFFvmVYgRs9rcFYx6XkNu6Dypo2oxEUANT2ubdL0VBjWdySsddec0gST2gKh8zL9c9bM0v
	Nby5Th4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1petpE-00FAw0-0G;
	Wed, 22 Mar 2023 08:28:04 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1petpA-00FAvD-2y
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 08:28:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4565F67373; Wed, 22 Mar 2023 09:27:58 +0100 (CET)
Date: Wed, 22 Mar 2023 09:27:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>, Yanjun Zhang <zhangyanjun@cestc.cn>
Subject: Re: [PATCH v3] nvme-tcp: fix a possible UAF when failing to
 allocate an io queue
Message-ID: <20230322082758.GA23221@lst.de>
References: <20230320133334.57325-1-sagi@grimberg.me> <20230322082034.GB22321@lst.de> <5f3b28e6-3bfc-d46b-7265-725d2c661c70@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f3b28e6-3bfc-d46b-7265-725d2c661c70@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_012801_108647_53ACB11D 
X-CRM114-Status: GOOD (  13.43  )
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

On Wed, Mar 22, 2023 at 10:24:15AM +0200, Sagi Grimberg wrote:
>
>> Thanks,
>>
>> applied to nvme-6.3.
>
> Actually, I would like to waut for Yanjun to explicitly
> give out his Tested-by.

I can drop it for now, but that basically guarantees that we're going
to miss -rc4.

