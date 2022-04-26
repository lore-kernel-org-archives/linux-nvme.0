Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F64C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Apr 2022 14:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3c6A+trUSQjUgo5tCyMKw7QZNtfISA5VnZsFVftfyAQ=; b=f09FY8fM1tNFODGvv7129AtYNR
	1qb63iRftm/NOtLVbyUpP0PiUdcqRVclFarjDH7G8BkKXy3t2Bj0QPv9tEbWM8E96jSy9+ZuZ4QDf
	wAGwkCB54H47eSKGX1KybB9vnchfKxQVOYjLBtzexympPtO1BQ/MeX7RR5Nv8bmyt9D1L8FcxVY0i
	kFfSjCgqhx1xSEVtm/gKFgc5exDrYbCNG5oYynoGG90/Z0ndXFWwr79FQYIVQjLN5wDr2rLr8HKZf
	wd0SkqLu3t5MBqw5cL8LsmDnL1jy+2d3pon5KWmQvCKDy53HCdJ4YxhjGduI5BAgnV1SLMocpz38w
	rsVuFeuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njMao-00F34l-QN; Tue, 26 Apr 2022 14:55:06 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njMam-00F34J-EQ
 for linux-nvme@lists.infradead.org; Tue, 26 Apr 2022 14:55:05 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 21689B81E57;
 Tue, 26 Apr 2022 14:55:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D7BC385AA;
 Tue, 26 Apr 2022 14:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650984901;
 bh=me9iCcOuTJq+2PqZc4Jh4npbdVCsacbBRf9z6+gdqqk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Fq9hilMCAJ9Rwa8FPT5daWcr97ssuASl+lSc8iGSkdyweVTInpfT9bvtS2m6xq7PW
 TC8nluVb3QnvFByfp4Ei8BJqnJSBrKDSETcw6YDJ/CKnRVkYlh0RZJ9kGxojrzN4Rz
 fkrMJd5qGeG/yU3l7kmqOHAMSnlGCKcwsXGm1Mj4eRXiiQp5yfQOXWphT95sbPJ86e
 KZNRiIZsBq+RgD5cpH6RL3HE85LRrRKAkdsrw5yUuNJ20N9e2EREBy4VjA4LyTNdJA
 /vpiDNG8S4KLXVAb29UdlnQ3wUurVw+vPZ+0z+xj7P5OBB+HEGSMgcoLrZlf4oPey3
 KMCPwev+alVJg==
Date: Tue, 26 Apr 2022 07:55:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, netdev@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 ak@tempesta-tech.com, borisp@nvidia.com, simo@redhat.com
Subject: Re: [PATCH RFC 4/5] net/tls: Add support for PF_TLSH (a TLS
 handshake listener)
Message-ID: <20220426075500.34776cd5@kernel.org>
In-Reply-To: <66077b73-c1a4-d2ae-c8e4-3e19e9053171@suse.de>
References: <165030051838.5073.8699008789153780301.stgit@oracle-102.nfsv4.dev>
 <165030059051.5073.16723746870370826608.stgit@oracle-102.nfsv4.dev>
 <20220425101459.15484d17@kernel.org>
 <66077b73-c1a4-d2ae-c8e4-3e19e9053171@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220426_075504_676834_536E95F5 
X-CRM114-Status: GOOD (  16.76  )
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

On Tue, 26 Apr 2022 11:43:37 +0200 Hannes Reinecke wrote:
> > Create the socket in user space, do all the handshakes you need there
> > and then pass it to the kernel.  This is how NBD + TLS works.  Scales
> > better and requires much less kernel code.
> >   
> But we can't, as the existing mechanisms (at least for NVMe) creates the 
> socket in-kernel.
> Having to create the socket in userspace would require a completely new 
> interface for nvme and will not be backwards compatible.
> Not to mention having to rework the nvme driver to accept sockets from 
> userspace instead of creating them internally.
> 
> With this approach we can keep existing infrastructure, and can get a 
> common implementation for either transport.

You add 1.5kLoC and require running a user space agent, surely you're
adding new interfaces and are not backward-compatible already.

I don't understand your argument, maybe you could rephrase / dumb it
down for me?

