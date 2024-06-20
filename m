Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F43C27C4F
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Jun 2024 06:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ot3BoF5a0xO/bkJ20zUjZACWRUkev7P6gLtdYk1Pjdw=; b=haGSA79Gms/CQWCJ0fvYZpYGEn
	MpR+PugH7INN69P79wItOuoauxM6q1ZXySVMWnl1hXE7OjuhwH9Fkv/qsd/z/Jr68+fxBMD7CVQq6
	lXEFCT4n/N1z2Eu9+do58E6qJyeMb4eWmGJKD6qllvCR2jCEMk/j2Gb4sj3kSxX/O3aCGr1Pnig03
	MIo87imutEgC6QOh3L3/kyToa8JqK0VDjoJr0HkdVyc306Gjf23v27wMDTYO++3NmjBLpvYgaBcrO
	yVnc8sC/aLcyo6uM4SP1ZwBfLiDby7aVXb7m46nuGbY5L3LCREqPUjL3eQatV6k5jMOzWzC7jd0Zr
	wnRGd9nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKXri-00000007zAy-49A8;
	Fri, 21 Jun 2024 06:35:18 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKOWN-00000006dEj-1NSa
	for linux-nvme@lists.infradead.org;
	Thu, 20 Jun 2024 20:36:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0350E621D6;
	Thu, 20 Jun 2024 20:36:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4AB2C2BD10;
	Thu, 20 Jun 2024 20:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718915797;
	bh=vEA8X/MKc0gI6uWmJH+jA33Ug9fWGn6Gnff22ONubZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GwXh+FaKDmL85CDPsH8udBqfeZC1mmF+n15sIcBNDwsFbFBRZMyb+xpna0zMD2PLM
	 pqf/pNSj8Xn9DuVLbM7jilwFcIE7roNMHVfaWpDYYRGRC4SG8fpLBeRYVrM+hyP0Bi
	 y36HAxmaieWyUEy7hWc5dTmInhBIN8woKOjinukAIvnzW+3QeIiNEpPs7813h50kTT
	 wyzF9XYqpjMdjwns7vRDcPVOhVos9O5OcqNcwQdEk9vs5KXzSxgZieOpkG1j2x6M+v
	 qRfkGvv4gsSMGTF47/LK1UoUzDl3zNk0K2bgfrIAMyVSEfKdZjCEH6/TKbjw7ONHqD
	 JsWaPADEUONyA==
Date: Thu, 20 Jun 2024 14:36:33 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
	martin.petersen@oracle.com, viro@zeniv.linux.org.uk,
	brauner@kernel.org, dchinner@redhat.com, jack@suse.cz,
	djwong@kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-scsi@vger.kernel.org, ojaswin@linux.ibm.com,
	linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
	io-uring@vger.kernel.org, nilay@linux.ibm.com,
	ritesh.list@gmail.com, willy@infradead.org, agk@redhat.com,
	snitzer@kernel.org, mpatocka@redhat.com, dm-devel@lists.linux.dev,
	hare@suse.de, Alan Adamson <alan.adamson@oracle.com>
Subject: Re: [Patch v9 10/10] nvme: Atomic write support
Message-ID: <ZnSS0Y0AFqQg-7lm@kbusch-mbp.dhcp.thefacebook.com>
References: <20240620125359.2684798-1-john.g.garry@oracle.com>
 <20240620125359.2684798-11-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620125359.2684798-11-john.g.garry@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240620_133639_495285_B5BE5FD2 
X-CRM114-Status: UNSURE (   8.10  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Thu, 20 Jun 2024 23:35:15 -0700
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

On Thu, Jun 20, 2024 at 12:53:59PM +0000, John Garry wrote:
> From: Alan Adamson <alan.adamson@oracle.com>
> 
> Add support to set block layer request_queue atomic write limits. The
> limits will be derived from either the namespace or controller atomic
> parameters.
> 
> NVMe atomic-related parameters are grouped into "normal" and "power-fail"
> (or PF) class of parameter. For atomic write support, only PF parameters
> are of interest. The "normal" parameters are concerned with racing reads
> and writes (which also applies to PF). See NVM Command Set Specification
> Revision 1.0d section 2.1.4 for reference.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

