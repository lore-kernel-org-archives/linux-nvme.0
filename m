Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0800D7833E
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2024 18:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aNZAnLF4zysjo2z6MMQ4XkZ2jjJR2YoPQEq85Z6ZsmI=; b=CL7Ji3gdcBl1JKtP1IgTrOjAP2
	pq4P1EgCtedbqaoBR1xdH3hUjpehkNwqNbTkIqOCoitSQQC4hN+qLAqB9gGn+ADcMjR3kiMOPWrRN
	W6sPNQl2KVNQsNAnwrxm1Zk250E8naAlKpzNcA6GSyNszh0F0mZ3D0jNygGRl6RsGOG3yRyrYh/Hp
	PIz5oQb1CH0eJVhDozPZn+SF07nfpTbRf0nE2T0ImkOqWUehTqalKz9JuVzALqh4v1XXDUymgscoy
	VCc7Rz/ah7C90id2xJGnmmu4Bl/sPU1ZshDZC7Qg8TMzhC7sRFfzU2lTEIBSjB7232F5Mwv7X7bVX
	ri+ieHXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIAlx-000000077EE-0Zr8;
	Mon, 02 Dec 2024 18:03:49 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIAlt-000000077Dg-3VjM
	for linux-nvme@bombadil.infradead.org;
	Mon, 02 Dec 2024 18:03:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aNZAnLF4zysjo2z6MMQ4XkZ2jjJR2YoPQEq85Z6ZsmI=; b=fv8pokNHoLynGKaxu148o5WvCe
	SDrVOjbLqQhKKqsf4e4HrXHvAIreDAFsyrsPPW6frndMp9jFXUNUBSs7zv/Qj3Pe+avJXhHJyaK9m
	XA2PFlb+PI/vp2Ag8mU8ic/SXOHBlIKBnsSWMJOd8hsiMDeAPNAZNjUukiucX0HF72fvcujbPYTD0
	7KxDcJd+iCknLOaBLSmPQL1ZArfNYnE/IqRXTt8yIfC7x/arRzzfnNJLMxRVtFd6e4zNz30I0mLHR
	SxfrrHmA78HlbAzkOYMhoWaRWCkyI0z2bir2J+dhpA8fXfp5wxjU7qMxKUjsSRb2Dfrcj/PLuL45r
	K6nKjkcA==;
Received: from nyc.source.kernel.org ([147.75.193.91])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIAlq-00000002EDP-3qv7
	for linux-nvme@lists.infradead.org;
	Mon, 02 Dec 2024 18:03:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id D34BAA41081;
	Mon,  2 Dec 2024 18:01:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28ABDC4CED2;
	Mon,  2 Dec 2024 18:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733162617;
	bh=JtNSdM5QDFvtDSUFFPnRuSj8WUL4/yhIRmpd5x6qOjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=quZRxVQ6SqYtDWGy8JcyAYeIvx640p27rYdVOryJ0eVMVpm/poiKLk/Ln7JBx9He8
	 yXDLZX3RP0vTEpgv80Fk97Nt3s+/ztPTTvXfMokBFn8II7121QGKmz8ynHpkTJFtZx
	 urDNK7tlv5iuBe3vV/U4ZT2BR2Axh+k3/YYz5ARz00MmFCkl8raMBhqud/0YAVuhXw
	 ni41iQlDaIsTAS0Nb4EBp+22IxpG8sW8W+sAoVEJjNCunib2vfwX/U3274YGp/+Gac
	 yl56mklvboN17U0p+q2n1+V+Tk8JFO1zcHL7eRbjNQcXduvuuk0gdIIK+gzniBYYF+
	 Ex4MZ01zgmQgA==
Date: Mon, 2 Dec 2024 11:03:35 -0700
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, hch@lst.de,
	sagi@grimberg.me, axboe@fb.com, chaitanyak@nvidia.com,
	yi.zhang@redhat.com, shinichiro.kawasaki@wdc.com,
	mlombard@redhat.com, gjoyce@linux.ibm.com
Subject: Re: [PATCHv2] nvmet: use kzalloc instead of ZERO_PAGE in
 nvme_execute_identify_ns_nvm()
Message-ID: <Z032dx3uDu-m1j9i@kbusch-mbp>
References: <20241124125628.2532658-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241124125628.2532658-1-nilay@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_180343_182131_5366ECD5 
X-CRM114-Status: GOOD (  12.11  )
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

On Sun, Nov 24, 2024 at 06:25:53PM +0530, Nilay Shroff wrote:
> The nvme_execute_identify_ns_nvm function uses ZERO_PAGE for copying
> SG list with all zeros. As ZERO_PAGE would not necessarily return the
> virtual-address of the zero page, we need to first convert the page
> address to kernel virtual-address and then use it as source address
> for copying the data to SG list with all zeros. Using return address
> of ZERO_PAGE(0) as source address for copying data to SG list would
> fill the target buffer with random/garbage value and causes the
> undesired side effect.
> 
> As other identify implemenations uses kzalloc for allocating a zero
> filled buffer, we decided use kzalloc for allocating a zero filled
> buffer in nvme_execute_identify_ns_nvm function and then use this
> buffer for copying all zeros to SG list buffers. So esentially, we
> now avoid using ZERO_PAGE.

Thanks, applied to nvme-6.13.

