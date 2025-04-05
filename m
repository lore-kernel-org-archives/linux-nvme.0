Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93832C36010
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Apr 2025 23:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rhF+luFj10JkaXFEe3RbBPkyuPIc3pQcwZ3uxid6OD0=; b=KcXBI3lzG29AE1G5KwnFFHYb4U
	ohF99jP+al8FArX2Mwnpugvx7zLbV8i77cU5toPppcbBQ3IRUefilRYG7VP2A8suqXPQ1tWjolcse
	QAK+0F5R8qYTcHUGQZJ2xEfwnCUL1Ocxn9OP1WKJllX1zpTRG4Snuifc+lQt1Ql++rnerbqKlnotP
	tRcOYnjmTGXNlzsvidANdeXgInKw0Qa41jCynmcXgCT6M1LtCwDLu4318MLRXgKNQkqvCPe9NgaUL
	lzT2cwAyOAvnqlOLkQ9YYyuupBTqKhSw9Bii7WEYAeoTlv1Qim0NZ7CBzhHrsxxgw0oVlb+/TAxf8
	FlgnPJkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1CrF-0000000Ebq8-0nPV;
	Sat, 05 Apr 2025 23:23:25 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1CrD-0000000Ebpk-19ey
	for linux-nvme@lists.infradead.org;
	Sat, 05 Apr 2025 23:23:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 308A65C0345;
	Sat,  5 Apr 2025 23:21:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B699C4CEE4;
	Sat,  5 Apr 2025 23:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743895399;
	bh=4+av1oJKW/2FuUkuJ/M1AP/wk5lDJ+hacOp/+ahIPVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oslTZ7RKx3rlzxvf4Hg3IGsJKl5mJqPcNJSSF0DVMbqN1iNIBz9s39eS5R/v82u3A
	 QBbVVLfNluz1cYJS4rm6ovHheFJmiebJ6Y/xfB6ZMT/9q4xYqan7gsTAllyno415I6
	 jmu6L0P46b7EHEBvLlTTlq8yU9zJ5n+IUSpWdmWcntDbEkXoTCVYheCzW7PxCx6Pey
	 KajIkHZT8tyfo0oWVIKJzG8Y6yIZH7GPcjUrAxeMrLLc22W8wibnSzQz0knoE1M1d6
	 GZrm6lbGZGtzgx7CxFnoBHRZnkp6IRyMn3GfGpjTkZrPWR8+swcA+tnhO8GVY1b0WV
	 wmZCZjYg4Qwgg==
Date: Sat, 5 Apr 2025 17:23:17 -0600
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@meta.com, hare@kernel.org, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, mlombard@bsdbackstore.eu,
	zhang.guanghui@cestc.cn, loberman@redhat.com
Subject: Re: [PATCH V4 2/2] nvme-tcp: do not complete the request if send
 operation fails
Message-ID: <Z_G7ZUnnFpKIU0Yu@kbusch-mbp>
References: <20250404082801.1614252-1-mlombard@redhat.com>
 <20250404082801.1614252-3-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404082801.1614252-3-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250405_162323_352624_24612590 
X-CRM114-Status: UNSURE (   9.49  )
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

On Fri, Apr 04, 2025 at 10:28:01AM +0200, Maurizio Lombardi wrote:
> In some cases, the send operation may fail even though
> the command is successfully received by the target.
> The target then sends a command completion capsule back to the host,
> leading to double completion and a kernel panic.
> 
> To prevent this, do not fail the request; instead, let the
> error recovery mechanism clean everything up.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

