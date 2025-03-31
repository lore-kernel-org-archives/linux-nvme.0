Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ADBCC36014
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Mar 2025 21:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=shH/F9YW+B/43fgFPPQPTRekEQR79NOIfNztm4osL6s=; b=LEXXvfajQoivX4Hw1tDBGKyHZ6
	xMSQp6iyt+awDdLMgFqhhUUm59zzZJtDXdiIHEcmNSBjPVjSRj8Sz4rwmF4YjbpMODw5Bu0tQptlc
	2MbH0FwgVQ5M8PGrHR/6S10ejSgQhZoPVz5vOzbm+WhKJU5CSFH2ySJH9jm8yQYOEjdBNot3YhtrQ
	2HrVoVztSLinjZkJkrLhgdbKL2gtBYklpcTtCpG5e0zK3DDEzes0PdDky+0ZXvRpvWrWTZYs5xYjV
	AARx/coGH0laIDT83Tr5cvsomWdjEQeaLfHEAI258eYVhaSaNDkn0bZVzAExKvcbcIcNJpUP93/uq
	JyIR8JcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzMPl-00000001OCB-0jdM;
	Mon, 31 Mar 2025 21:11:25 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzMPj-00000001OBs-1H6e
	for linux-nvme@lists.infradead.org;
	Mon, 31 Mar 2025 21:11:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 4CD0BA43A6C;
	Mon, 31 Mar 2025 21:05:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55251C4CEE3;
	Mon, 31 Mar 2025 21:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743455481;
	bh=HZTTkqA1vmUGsxHtCLgWFQWtxFh9NTfPhz66H482+Yw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X4SiP0pbj8FNKNjwMrAbFybdZlY8P3bdtl+U+nh2HydKbZj8EMkAD6ZcLWXhWbNfw
	 EyGOoqH6NNdYaAge5m1dkR5uRTSac16c+5e2arbRgfrCDN+OczcxruhglXWaSrOuEZ
	 23jjQPW+kra8HzRUG/aduJux9Yj9lUoFUVn2qguSyEp0buQsAyQhZLTW04Ebt1gWT+
	 dse5aWJedgy8Eojp76spwO+C1ZsRHiUVEMTosQ1NUjfFsCNmU3WARXjZ3w9/mZH0ZF
	 U0nE4NxR1/CxN+YA9XLGih/HgBPaC4Wf8OwR9gmZPXafZp8ULDGxpMOQGxXow8xFRI
	 9cdpx8GiaNo6A==
Date: Mon, 31 Mar 2025 15:11:19 -0600
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, wagi@kernel.org, hch@lst.de,
	dwagner@suse.de, Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH] nvme-cli: attach ns to local controller if none specified
Message-ID: <Z-sE9yNcdFC13jdf@kbusch-mbp.dhcp.thefacebook.com>
References: <20250331190843.2431830-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331190843.2431830-1-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250331_141123_407430_601A843A 
X-CRM114-Status: UNSURE (   9.55  )
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

On Mon, Mar 31, 2025 at 12:08:43PM -0700, Keith Busch wrote:
> +	} else {
> +		struct nvme_id_ctrl ctrl = { 0 };
> +
> +		if (nvme_cli_identify_ctrl(dev, &ctrl)) {
> +			perror("identify-ctrl");
> +			return -errno;
> +		}
> +		cntlist->identifier[0] = ctrl.cntlid;

This is not a zero-based-value, so this will need a

		cntlist->num = cpu_to_le16(1);

in this section.

